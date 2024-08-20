Return-Path: <linux-kernel+bounces-293104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADBF957AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9A01C22E15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126C175A6;
	Tue, 20 Aug 2024 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vdikBRMK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBBDDDA0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116664; cv=none; b=Pyh/i97XsadBN33eWPrLPnEfXPGRSzlIUpo76gO3VHlKn5HMTbCYqziIB0OHWxBw58n4jODkD7m2Ts7xbrA/OxjMFQvfMzTRhzNnraUikWo0b1WhSRR1xFgtcQqP0wMZct7L0V1LOGhF0mHmm+34IRml9KjRWOKp1z4zRJb4RNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116664; c=relaxed/simple;
	bh=sNdiYmQUi6QlIpSV8ifvizkXpL5MR16zy8pSxwiA/kg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kq++TR9HZEa84m9jNucWgZAozTh4Xd6QAx042/9FNmzLivcUq5yXsyA5L3cYg/xJu16lqzpX0OaJ2340Y+EchfZEs5cuzny8C8HObOh33JAKImzRcYChwb4LS7S4qD6tUKSEpfWbc67WyvH0z2mFUW6SDxPcpA3VsdOq5QLqLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vdikBRMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4383C32782;
	Tue, 20 Aug 2024 01:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724116664;
	bh=sNdiYmQUi6QlIpSV8ifvizkXpL5MR16zy8pSxwiA/kg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vdikBRMKyz3b3bjtM4lOjuJb2L4qacyu50Ymd3Lwa6XsIkEi/YSBsXn1yKIVCudC0
	 KTFmBizjbN2oIt4/zJzcCIYCyvBo51wGGBGQzotDxZEiUI6WEIfMinA3ifwQkygvhO
	 FHeHIqQfIyuoIgH5dJgXQ98qHsxKK7wnmKm6SNJg=
Date: Mon, 19 Aug 2024 18:17:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: yuzhao@google.com, david@redhat.com, leitao@debian.org,
 huangzhaoyang@gmail.com, bharata@amd.com, willy@infradead.org,
 vbabka@suse.cz, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RESEND] mm: drop lruvec->lru_lock if contended when
 skipping folio
Message-Id: <20240819181743.926f37da3b155215c088c809@linux-foundation.org>
In-Reply-To: <20240819184648.2175883-1-usamaarif642@gmail.com>
References: <20240819184648.2175883-1-usamaarif642@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 19:46:48 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> lruvec->lru_lock is highly contended and is held when calling
> isolate_lru_folios. If the lru has a large number of CMA folios
> consecutively, while the allocation type requested is not MIGRATE_MOVABLE,
> isolate_lru_folios can hold the lock for a very long time while it
> skips those. vmscan_lru_isolate tracepoint showed that skipped can go
> above 70k in production and lockstat shows that waittime-max is x1000
> higher without this patch.
> This can cause lockups [1] and high memory pressure for extended periods of
> time [2]. Hence release the lock if its contended when skipping a folio to
> give other tasks a chance to acquire it and not stall.
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1695,8 +1695,14 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		if (folio_zonenum(folio) > sc->reclaim_idx ||
>  				skip_cma(folio, sc)) {
>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
> -			move_to = &folios_skipped;
> -			goto move;
> +			list_move(&folio->lru, &folios_skipped);
> +			if (!spin_is_contended(&lruvec->lru_lock))
> +				continue;
> +			if (!list_empty(dst))
> +				break;
> +			spin_unlock_irq(&lruvec->lru_lock);
> +			cond_resched();
> +			spin_lock_irq(&lruvec->lru_lock);
>  		}

Oh geeze ugly thing.  Must we do this?

The games that function plays with src, dst and move_to are a bit hard
to follow.  Some tasteful comments explaining what's going on would
help.

Also that test of !list_empty(dst).  It would be helpful to comment the
dynamics which are happening in this case - why we're testing dst here.



