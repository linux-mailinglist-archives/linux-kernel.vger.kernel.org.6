Return-Path: <linux-kernel+bounces-299876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473ED95DBC3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCDE1C21781
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 05:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A23314A4C5;
	Sat, 24 Aug 2024 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pa/imFBV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54B4C69
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 05:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476010; cv=none; b=pFG4m5vDktAZF4QHbkpkgfcaw00MH9Js0WpxGKzavp7YkqOAtsQoaUQk34b66cY7nQspN7KkJEuqkL1beDOkTRTz4VtNzMgdsK60DTVRG44SCqpjYuK2dFfXXsPO4wCc3sfgw+EcByCEuHKRfTQTukcFDHfPkgWUFOyKIZ2HWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476010; c=relaxed/simple;
	bh=kRWFF7F7UOmGwHsnPPfHcZiz0xTpgYj4in7SPYOK5rE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=R9vQi1jYGuvZVpRXA5vSvVBk26ZfuiEIE6WYFuf8yOroC4zI6UW5WW5tDkKMVbiZYC0DPYXRw2vO5zwsjmk2CjMrP5KCczuT3R0nGChWtjSbenUsF0eHvrKZw6ziISrDPFdFCtq9R7zB9ehJTB22h91gKox5IHaWSW5YaL7DMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pa/imFBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA46C32781;
	Sat, 24 Aug 2024 05:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724476009;
	bh=kRWFF7F7UOmGwHsnPPfHcZiz0xTpgYj4in7SPYOK5rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pa/imFBVI1dRJuLEbCRg5jLgkW+r2i61IHu1dx04D0wwx0S+szwL62nEl0kQoHlnZ
	 tMaMvnMExIKr56XQ4kTFiYoajFBQVU2fjk6j8nAFvUYG4UrQdHqc1MslmmASvKIIXJ
	 HHrR00BcommdOhWGCh3ysBnr7+GBr61Ap3yheiWQ=
Date: Fri, 23 Aug 2024 22:06:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RESEND v8 0/2] mm: store zero pages to be swapped out in a
 bitmap
Message-Id: <20240823220648.081970f3fc9fb49f925f15be@linux-foundation.org>
In-Reply-To: <20240823190545.979059-1-usamaarif642@gmail.com>
References: <20240823190545.979059-1-usamaarif642@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 20:04:38 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> Resending it, as the CC had "Huang, Ying" in one of the initial patches,
> and it was rejected by git send-email because of the "," in name.
> 
> The original series [1] was almost merged, but was dropped
> due to a last minute bug [2]. Resending this with the fix for it,
> by handling zeromap in the same way as swap_map and cluster_info in
> enable_swap_info, holding swapon_mutex and si->lock, hence avoiding
> a race condition between swapon and any point where the lock is held. 
> This is the safest way.
> 
> The series had already been reviewed and acked by all maintainers.
> 
> Hoping that this attempt goes better than the initial one :)

Yup ;)

We're missing the [0/n] words here.  I pasted the text from the v1
series.  Please check that it remains the truth, the whole truth and
nothing but the truth.

