Return-Path: <linux-kernel+bounces-267954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C5941DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB161F27A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1881A76C2;
	Tue, 30 Jul 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYFCHii2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304521A76AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360045; cv=none; b=ktpKwCNLYYjeOWVfe/0lVl419Nbms+8GZA5MNNzN009n9PlZ8LNDEdf1pIlHznMwtZwmUUX5TC6TjaNRKiBSqUHWFb/9xcPygBsKdf+VrwbJLhu+Fur4nJCiFJSVgeLA8P0s7BGr32rLHBF5AEo730OVJmGzWpHGUp63AWkwt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360045; c=relaxed/simple;
	bh=vllOU64qgOZSEQ9z1np2KefJc9ch4rCTf2JyxG1ZzB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx/Jd4vyJpT3wXWs1U0McWwGda5sB2E4zDrBxA8aFTd4H/dS2HqYoi/V6QHZHjf/8BABgAwyyhawb1G3ZxlwlBzB7YCQ8X+YDVSm1/uerKV3EVf7Kdymx6CQVRaLKaqUTXHDvHkefCs0XkFDD6RkAiO4yHDTCp2+Fwfe1tzOb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYFCHii2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722360043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VnWrZUr3XTGc9rWoojma5OUUSoy6Blh+X8bHgZMhN+8=;
	b=UYFCHii2Px7bqeCMmbQGHvaTKWJS16O6gcS7o1KXAuueRjxTeFbJ5MPxowoD4ESxA3hhQ6
	dHximz+VhZ3OYh04nhhbqQWZVy9uP9UZ+gGs++GOIxTym9Ak1rWkL6v+H/8iGy6qvOlnsB
	GgxOd9FXdL1Uzm6/kA1XOWq8ajvAo1E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-y8D50j4bP7GYZYkAMuoeeg-1; Tue, 30 Jul 2024 13:20:41 -0400
X-MC-Unique: y8D50j4bP7GYZYkAMuoeeg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5de421bc6so63015726d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360041; x=1722964841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnWrZUr3XTGc9rWoojma5OUUSoy6Blh+X8bHgZMhN+8=;
        b=Fp1jtGEo94S2c2r38pkh+Q/kfbgIj599kCmiC3vmP5KMT27PeIOKoPpqvzmuC1mjcO
         ZldzjTbyo5PZCKN34D0YmIsE5DtF1cMu0sZjXRp9dqvVgXBeJeGa7/8ZXCx/9wDWS+oA
         WS+BxkOg4FNq0+QtTq1baomhF6A2Wi2w5d3l3kTw7zSZXj1zyEl+en3ZNKOKCdVexwKP
         8liEzndJ4u0X3zvQg2z5u1PlZVMbrtAArziViHMk0W70OAeqI2EsZuy9ZSk9YS/p6E5D
         h/7DBkvG+DgjgxTKGWcFbtWQ732EeO+6GkdHqnTfWgjsw2l2fimJLXZzFDxGvv8Mqt9k
         bTdw==
X-Forwarded-Encrypted: i=1; AJvYcCVuNVt+kY0Q2x3rjJ0qJyrjvk5wE4F6Zd6ZQoQXflQ8K7zy5IfcB9/6XCul4SHfimGFh7yvnoYfsafu30BoapLNa7DF4sXy/f0PoCwS
X-Gm-Message-State: AOJu0YyLFaKSXwOcO/MyQCMvx4gA1zbqrMfOpK076fp2BrUQboOf9xrU
	/BNDkxirLo6LZL8Dr7lmZKtn6z4i7o5fnN3ovU6Sg5s+QYZxgstuZIbPLUkgMMKwpSgItvrezyw
	KJ4pm1fA5MXwfy/wbUGpCNEdpyUoQ6WVD3fb71nO/N1Gdv5AnrDHJDIQ1a8m4cQ==
X-Received: by 2002:ad4:5bcc:0:b0:6b5:17a2:887c with SMTP id 6a1803df08f44-6bb5597d0eemr164177796d6.10.1722360041313;
        Tue, 30 Jul 2024 10:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqeyGsJFBHbEzj2FboEWy6B8OLfQrlTw3ZAzMmST64ENrLhEMusvdb5Ms/LCX/k50gGq0BAw==
X-Received: by 2002:ad4:5bcc:0:b0:6b5:17a2:887c with SMTP id 6a1803df08f44-6bb5597d0eemr164177336d6.10.1722360040806;
        Tue, 30 Jul 2024 10:20:40 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3faef212sm65362896d6.122.2024.07.30.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 10:20:40 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:20:38 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Amirreza Zarrabi <quic_azarrabi@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH 1/2] firmware: qcom: tzmem: fix virtual-to-physical
 address conversion
Message-ID: <p4wbqdmytbzjmxsdovnboetjxbyvuhkwunieuwoh6rui72v7pb@huxwyphj63yv>
References: <20240730-tzmem-efivars-fix-v1-0-bb78884810b5@linaro.org>
 <20240730-tzmem-efivars-fix-v1-1-bb78884810b5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-tzmem-efivars-fix-v1-1-bb78884810b5@linaro.org>

On Tue, Jul 30, 2024 at 05:38:48PM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We currently only correctly convert the virtual address passed by the
> caller to qcom_tzmem_to_phys() if it corresponds to the base address of
> the chunk. If the user wants to convert some pointer at an offset
> relative to that base address, we'll return 0. Let's change the
> implementation of qcom_tzmem_to_phys(): iterate over the chunks and try
> to call gen_pool_virt_to_phys() just-in-time instead of trying to call
> it only once when creating the chunk.
> 
> Fixes: 84f5a7b67b61 ("firmware: qcom: add a dedicated TrustZone buffer allocator")
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/20240729095542.21097-1-johan+linaro@kernel.org/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_tzmem.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> index 17948cfc82e7..1294233a4785 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -40,7 +40,6 @@ struct qcom_tzmem_pool {
>  };
>  
>  struct qcom_tzmem_chunk {
> -	phys_addr_t paddr;
>  	size_t size;
>  	struct qcom_tzmem_pool *owner;
>  };
> @@ -385,7 +384,6 @@ void *qcom_tzmem_alloc(struct qcom_tzmem_pool *pool, size_t size, gfp_t gfp)
>  		return NULL;
>  	}
>  
> -	chunk->paddr = gen_pool_virt_to_phys(pool->genpool, vaddr);
>  	chunk->size = size;
>  	chunk->owner = pool;
>  
> @@ -442,14 +440,25 @@ EXPORT_SYMBOL_GPL(qcom_tzmem_free);
>  phys_addr_t qcom_tzmem_to_phys(void *vaddr)

We should update the kerneldoc here, it currently says:

    /**
     * qcom_tzmem_to_phys() - Map the virtual address of a TZ buffer to physical.
     * @vaddr: Virtual address of the buffer allocated from a TZ memory pool.
     *
     * Can be used in any context. The address must have been returned by a call
     * to qcom_tzmem_alloc().
     *
     * Returns: Physical address of the buffer.
     */
    phys_addr_t qcom_tzmem_to_phys(void *vaddr)

"The address must have been returned by a call to qcom_tzmem_alloc()" is
no longer a strict requirement, it can be within the buffer now.

Otherwise, I believe this should fix the problem you and Johan
highlighted and looks ok to me, thanks for the fix.

Acked-by: Andrew Halaney <ahalaney@redhat.com>


