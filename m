Return-Path: <linux-kernel+bounces-309498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 135BE966B61
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3AB1F21AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3201BA260;
	Fri, 30 Aug 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WlJFPFNf"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF01474C3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054195; cv=none; b=ZddiadM4D2DUeYAMV93uLywQeUu8EQQj1J9dK1RKr7X5ucpAFSHMaIcjm2ZZ5DwI0ynID3Glzluwdn2nwaoOKAVmx5W6zFmenwlBm08jNfLV95upSmlsGZrBayuAvsxwg8J2jASUSvzaxO3DaCUn2CgnddTDD0VO6QlFs9HmAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054195; c=relaxed/simple;
	bh=6vpszAzZ8zhxPZm0vbs72sc/ik01KeziA9Wp0qLkkR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWZwsgyi/FaZJi1G+DgzjwPW5wH7PBuiW9Pmk8qeNDjWHX4Z3ZFBgOeSJTM/j5RF3vT+Qkjkzv7iLS3bYxzSHr9pcFEmPJEniOs6/8poSdvJnR+ML0+1LbU8LpKkKeeaanU2+toRinRH88EtV5X9IQ6JhF8XF7jI+oJQ+pLN2UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WlJFPFNf; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4fcf4ae95dbso748706e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725054191; x=1725658991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gK1TmJ2KEIYeKgjrqy3yOpMjy3RK0PZ6y/agh65IDBQ=;
        b=WlJFPFNfstWQgSn8NTWzpD/Vt74TVAeMqZ+cXan9rmxO/PlWSkWctRhGxFNAZhX6SL
         pgxHEXxiS/lYXMA577FS2NJcBjZJYRBYAw+sWp2Fryr0yRpRQmTY/czMfx8sj89qZy5q
         jxQrjCsnYWrxLIttcuHPN1vRLXyVobPFulxbQCazCvYG9D7S8x7gHz0E4auAAfKQwwMC
         ylWPW+o+JL7l2Fn+H9aSV4LLGkPzp/jIhuIntZz7wTV4YDMHMGQaf2q6wYQpGjcgLV/1
         csiPRurPkcfR2bYXK2aQLLE50cQHsyqYVDzdCKmhFoMFZEZooQ2xuY49DFuMYuoUScak
         T5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725054191; x=1725658991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK1TmJ2KEIYeKgjrqy3yOpMjy3RK0PZ6y/agh65IDBQ=;
        b=mgAvRbVY6OGvljIJOpYnXipPyQs2WB4ekC6yQwNpfmTofDy7Qohr6kmkU6XFasjNKW
         85QIUUQy5OC+7x3+ue7z7KKCDfqodJq3e8dKKEfE2ZYBZ2dD44R9gfWEZGPzOg4fjdYr
         4Gb49okLQRjTBZ9xRDh6kxXx5msz2rCVJEobjk07mAzDIg1UAFB5AbN8K1Sg1Ajo+Q+O
         82YNSP5k1BbdNOLFQ9qdzi7wXxc+KkcoP++HfM9+094cLU5gogiETJZV5w6zXGvAUS9Z
         N2FrYbrxeewlmd/qinV50wkOljp7LPAIDWsStgcMJY2tK0pvo/M0G5BM+8xolHs0t4wR
         +ahg==
X-Forwarded-Encrypted: i=1; AJvYcCXioPXvVeBorw1TYjYorNLILR+TfeeYHajfv6wLbDXB1COaxDMNNSWSiWySDcu4ORvXa6pY128DUfLXr7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf559l/x83UVIV6+zHKs8pyEEoSzA7Spt4+IfRduOQgr0W0d6e
	pJOkFVlWgpR7AIxwCQm0z7njRvFwiSVqDGMoSH9h0aF92+pVkF7G+T9NLFVExuE=
X-Google-Smtp-Source: AGHT+IEzXHtKKFUaMSJ2VDer9feg3251XT2e/e+34Xgsy/KadnOVVzaUG7VMQWc8Ic9njNqbiVu3vw==
X-Received: by 2002:a05:6122:2009:b0:4f5:f65:26be with SMTP id 71dfb90a1353d-5009ad65a4fmr906180e0c.0.1725054191319;
        Fri, 30 Aug 2024 14:43:11 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340dafffdsm18165806d6.140.2024.08.30.14.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:43:10 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:42:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usamaarif642@gmail.com>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, leitao@debian.org
Subject: Re: [PATCH] efi: reserve memory for tpm_log only if TPM final events
 table is valid
Message-ID: <ZtI82gt30kUhwkFY@PC2K9PVX.TheFacebook.com>
References: <20240830212852.2794145-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830212852.2794145-1-usamaarif642@gmail.com>

On Fri, Aug 30, 2024 at 10:28:52PM +0100, Usama Arif wrote:
> If efi.tpm_log is corrupted, log_tbl->size can be garbage (and
> negative). This can result in a large memblock reservation, resulting
> in the kernel booting without sufficient memory. Move the memblock
> reservation after log_tbl->version check, and check the value of
> both tbl_size and memblock_reserve.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  drivers/firmware/efi/tpm.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index e8d69bd548f3..cfc6a065f441 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -59,9 +59,6 @@ int __init efi_tpm_eventlog_init(void)
>  		return -ENOMEM;
>  	}
>  
> -	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> -	memblock_reserve(efi.tpm_log, tbl_size);
> -
>  	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>  		pr_info("TPM Final Events table not present\n");
>  		goto out;

The final event table is not present in TCG 1_2 format, but the
tpm log still needs to be mapped.  So this change is incorrect for
v1_2.

> @@ -70,6 +67,19 @@ int __init efi_tpm_eventlog_init(void)
>  		goto out;
>  	}
>  
> +	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> +	if (tbl_size < 0) {
> +		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (memblock_reserve(efi.tpm_log, tbl_size)) {
> +		pr_err("TPM Event Log memblock reserve fails 0x%lx - %x\n",
> +		       efi.tpm_log, tbl_size);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
>  
>  	if (!final_tbl) {
> -- 
> 2.43.5
> 

