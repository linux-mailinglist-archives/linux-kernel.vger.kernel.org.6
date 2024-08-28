Return-Path: <linux-kernel+bounces-304160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6E5961B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4FC1F24807
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26413208A0;
	Wed, 28 Aug 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W6nMf6yv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A231DFEF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724806800; cv=none; b=cHaFdLoG991NR5SvCBxLNRT/IGs/+9gjMHfWgVmm8j3qX50je++wKuWexW4Ln1f1f1V8Zb/ydk1xwPbob44vC1e2QE7x1VJ42+veGJmlfQv7Q8DMHUlFREsHmxIHrhFMRP0xfDd9/yevm8R6NzEbcjBnxo750qSFjCesdp+Wj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724806800; c=relaxed/simple;
	bh=i65raoFdcOG1ThmM7NP2MtO1wtjOxTudquKF99DFxE0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NWbZLzQ5vQ45fv+8B9GmOUoRRl9EB1KSTnGW3g6Ss4rmEydiTe43SsAwe1yiaLh8DiXEaVuVAzqxGhjS7tz8Aziberoux5I0SXn8cfEKun9PRjSgyHWxHdADhgqr6pu29HnKARvxDpWkoB3odiChGZoYbOUCC8z7XJDJV6UwNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W6nMf6yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B4AC4AF0F;
	Wed, 28 Aug 2024 01:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724806800;
	bh=i65raoFdcOG1ThmM7NP2MtO1wtjOxTudquKF99DFxE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W6nMf6yvaF/Ss4uvCF9sl474TR1KOW+120H0q1OblTfh4stJgLzJ4GV+S4v9H4WND
	 LhO8iAfg2b1PLboCFBHR8t1Q6ry8tZDg++BznCB6+1F301OIXyJ7lf5qdDN0b/gf1a
	 jfC4rJWI7FtM63bwAK/2o8ggtt2JuV2bkPFvkP8o=
Date: Tue, 27 Aug 2024 17:59:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huan Yang <link@vivo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: page_alloc: simpify page del and expand
Message-Id: <20240827175959.8f0e9a228407a7be16b328c1@linux-foundation.org>
In-Reply-To: <20240826064048.187790-1-link@vivo.com>
References: <20240826064048.187790-1-link@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 14:40:48 +0800 Huan Yang <link@vivo.com> wrote:

> When page del from buddy and need expand, it will account free_pages
> in zone's migratetype.
> 
> The current way is to subtract the page number of the current order
> when deleting, and then add it back when expanding.
> 
> This is unnecessary, as when migrating the same type, we can directly
> record the difference between the high-order pages and the expand
> added, and then subtract it directly.
> 
> This patch merge that, only when del and expand done, then account
> free_pages.

It isn't obvious to me that this is a significant improvement.  Am I
missing something?


