Return-Path: <linux-kernel+bounces-576088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5AA70ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D3B188A240
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF61FF1BE;
	Tue, 25 Mar 2025 19:52:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769B1FDA66
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932351; cv=none; b=eV3pOcO/c1xoxUP1igaSRtkj1tSWMwhDKUa4iMz5AxcHxcMruwF4Hq68Xw26GEIjNE6BtqW/MNEnm95D+zvSc1F0edt5rlexVzIGud8dXsiQW5AC7ha8GjrTji4Q5Mhmx8VLFj9qe5gtRM8+lIRxfTUsAfCZ1t2FBP7Tu4FhAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932351; c=relaxed/simple;
	bh=q5fv07ZkrQ3fpHoQ7VYoxQYYEMQDOme2X/qEKavyPW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOy3p95kqd3B/Zh3XB3cB/1YYETx6PqHRHkW7t028z2hjQfsP8SguxKkRfQWQt5wbHr8ZMeAG+LBIOURrkTWPUESiP4Yspo2/C5qgCixkWRGYaQZwLVNRsYr5yvdlSCeHokRv12V6KjDD6ipSXKI8eXdr6r80G62UeOfgDXNoVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1txAJx-0004Z5-S8; Tue, 25 Mar 2025 20:52:21 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1txAJx-001d93-0W;
	Tue, 25 Mar 2025 20:52:21 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1txAJx-00FxNU-1Q;
	Tue, 25 Mar 2025 20:52:21 +0100
Date: Tue, 25 Mar 2025 20:52:21 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: jens.wiklander@linaro.org, sumit.garg@kernel.org,
	akpm@linux-foundation.org, vbabka@suse.cz, willy@infradead.org
Cc: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] tee: shm: fix slab page refcounting
Message-ID: <20250325195221.ipqmtc36vof4vycb@pengutronix.de>
References: <20250325195021.3589797-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325195021.3589797-1-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-03-25, Marco Felsch wrote:
> Skip manipulating the refcount in case of slab pages according commit
> b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
> 
> Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/tee/tee_shm.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..3d6a3077b6f2 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -19,16 +19,24 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  {
>  	size_t n;
>  
> -	for (n = 0; n < page_count; n++)
> -		put_page(pages[n]);
> +	for (n = 0; n < page_count; n++) {
> +		struct page *page = pages[n];
> +
> +		if (!PageSlab(page))
> +			put_page(pages[n]);
				  ^
I forgot to change this to page, therefore please ignore this patch.

Regards,
  Marco


> +	}
>  }
>  
>  static void shm_get_kernel_pages(struct page **pages, size_t page_count)
>  {
>  	size_t n;
>  
> -	for (n = 0; n < page_count; n++)
> -		get_page(pages[n]);
> +	for (n = 0; n < page_count; n++) {
> +		struct page *page = pages[n];
> +
> +		if (!PageSlab(page))
> +			get_page(pages[n]);
> +	}
>  }
>  
>  static void release_registered_pages(struct tee_shm *shm)
> -- 
> 2.39.5
> 
> 
> 

