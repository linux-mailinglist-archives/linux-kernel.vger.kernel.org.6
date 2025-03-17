Return-Path: <linux-kernel+bounces-563216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC85A63998
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFAC16AEB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A4722F01;
	Mon, 17 Mar 2025 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="umsUWZmO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B18BFF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742173371; cv=none; b=O9kGkY5cZbQX7na32YLW6mGWyh8UZ0UqK0q1UJYCX6lTc25YaDtosxeZZXBNpqdIHIn9AQuHkRw5NFvFnPPyQp7qzGQIM2yX5kjNx2BGMC48veHeksOsRHTIMaC50Q+sVM5Lt3p4V89T7jzjpvkjumb6LXEnESP3vb9OPzpWl9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742173371; c=relaxed/simple;
	bh=G9cV0TFTJ+t2auqmesfJTNbYJNnk22Exj+XyW/E2oGc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=opoAIs6sTxG98CLKAhy4OaGs13+reeKtdPj0THjhNi2TaNiOiZL06HNuGkb7c/qKYcmz+RJetYePaVSaqy0eIhCOJLlnB6F7XNlK0H7BXQeI8hag8TW8/UhNodjaEAIk918znaso1/1+1Uh9pJ3Rq0RpD8MLjpR4tv83RwecYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=umsUWZmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7F3C4CEDD;
	Mon, 17 Mar 2025 01:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742173370;
	bh=G9cV0TFTJ+t2auqmesfJTNbYJNnk22Exj+XyW/E2oGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=umsUWZmOqvANgNUoTnjagOzV0EHGA3V3Jc0kOhqq3BacTVLKB4T5iuF2crzGzGHoX
	 /HNogFnHSSVCddBypl0jo8EYaUyMSeY2+EhLBscXZ4/+QEP501cZWNOWJzFoIkBs8g
	 M3Oafg/8XM13jbaIqwfJEOKbbXi1O5LWT6xlsfBE=
Date: Sun, 16 Mar 2025 18:02:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Pasha Tatashin <tatashin@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] mm/compaction: allow more aggressive proactive
 compaction
Message-Id: <20250316180250.70767a305cea9798dcc7c9b8@linux-foundation.org>
In-Reply-To: <20250127215020.4023545-1-mclapinski@google.com>
References: <20250127215020.4023545-1-mclapinski@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 22:50:18 +0100 Michal Clapinski <mclapinski@google.com> wrote:

> Our goal is to keep memory usage of a VM low on the host. For that
> reason, we use free page reporting which by default reports free pages
> of order 9 and larger to the host to be freed. The feature works well
> only if the memory in the guest is not fragmented below pages of order
> 9. Proactive compaction can be reused to achieve defragmentation after
> some parameter tweaking.
> 
> When the fragmentation score (lower is better) gets larger than the
> high watermark, proactive compaction kicks in. Compaction stops when
> the score goes below the low watermark (or no progress is made and
> backoff kicks in). Let's define the difference between high and low
> watermarks as leeway. Before these changes, the minimum possible value
> for low watermark was 5 and the leeway was hardcoded to 10 (so minimum
> possible value for high watermark was 15).
> 

I'm not seeing enthusiasm for these changes and a couple of comments
from myself remain unaddressed.  I'll drop the series - let's revisit
in the next -rc cycle, if you feel so motivated.



