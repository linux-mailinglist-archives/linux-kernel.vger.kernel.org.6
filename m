Return-Path: <linux-kernel+bounces-229675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455E19172AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B542826C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB1817DE1C;
	Tue, 25 Jun 2024 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBKqwgtR"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072617D8BE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348742; cv=none; b=jQGScwgyzDfzqkQ4RccnOlC/5hkWKPNoQsBRev9olxAPzr1k2M2rAjKhKWA3Sgxqzx2WlZBP92v6GSwnOFkRkpuUlWk15bh9uWLi7VuwjMCQJZk4GXSYn+HajzVUucCPrWxMmCQ7V+A7RvtG8e++uMleWclD3Zv14EYdaCzdpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348742; c=relaxed/simple;
	bh=hiJgA6/DnnANN9qeLVXHvmiZDMqRcf+ipIv+ikZ+/GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbFW54Ut7s5V/Kvm8+IdqhzVcztyuIY7a2T+MfvbnkRACbu0d7B+jVYz8LWa5w6hT2HO7HojjdPAXvUSVDJ/ETDzUbkA7Ek6h4mSPEDRkJXoI1rm30YE0Fwi9hIxIf6IRkz18Qwn4hL0RGALCkyipVQOfLMmVCKP5ELcHdGzcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBKqwgtR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c74085d57so1010837a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719348739; x=1719953539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHRkc9t07SlstseLeIgt/BF9i+oxbwcefEU9UF9cIXw=;
        b=MBKqwgtRlh4xGDMC+KaRYcaY/jJ63qL3Yg+uRb2LsuFHCA86iTN/8b4NJAh5tx+rvt
         kBCNzwMTER5D/PH59slGsifCoIVaUzec/Qz9HXEy/CKm+ZIUNzQwsf97qOainu//LAg8
         t4pccAR7kQwVIgd/SdFOwLvlw8fNqeNiWMbDYdcjLkqtNs8U3DA+demZaSsivA5BvGw0
         g6IVTokAzXotcv4BlzP7ON7LzaphIHbSq7X0KuE59XDKbPZGlcckcWUQEtKmbboqqcN3
         UMlUe4bF1+Qtr2Ant0r1sWQs7XEewIcJWVFj9GqqFqFQGPUgcWH9LJg3ld/KTW0iGRLO
         Psiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719348739; x=1719953539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHRkc9t07SlstseLeIgt/BF9i+oxbwcefEU9UF9cIXw=;
        b=tre4BbGa6iYPH1hCjp1UJ5DhgFKTxCJ+REed2wswmI/vsEEVc3q6anSoYOFLTco5Al
         N3v0WHKBAEJRVXofOWkL3OaAXu0i01shC+WgEXyLBYj0AJKyaU2xBI3BWLtZeVAJA8Kk
         tPOtRdpTOGGcW2wruoSX84M19dgyP3trcQ8aIseVMkAozb8fZPFk4kxiCtsUKEsQzz/I
         0643ISQGFdWni6VCDSnnzjw0wHGeYMivjN+IhnCQEpn2OU8yVrYR6amFzwls0esViy0J
         2rWnGL9Ej6ssF7unjSdf6TpxT+10mf4Ji53PRUP4jVyJ3MNSBksOY+w07qOhxyjxOULV
         i/9A==
X-Forwarded-Encrypted: i=1; AJvYcCWwihY2zXQaZ+J1rl0VtPkEZaQfE2vQlZJMmV8QvYRVZ1owPTU3KH2y2h7qEOd/eQu05GVCbkEIymergsKeg2lp0G2y+2cNVDlRCCy8
X-Gm-Message-State: AOJu0YxCiRR/XauvswEAacJ4LenSuGMcBCB5hFtWgC3J9lxB8IjMtAS/
	89LvELO7DuJ+3uxbz+n2y8x/dRPNdXmegmIbMk3x6dO3gCA/z8hQ
X-Google-Smtp-Source: AGHT+IGJnMiPU6FZQ9JOoLfal1V/WdfxPP5gjVBj6ljb7cVv+CJoVMW8AM6Z0i7Q6QmMjOqdkU49BA==
X-Received: by 2002:a05:6402:40d5:b0:57d:432a:582f with SMTP id 4fb4d7f45d1cf-57d432a5e3amr8476020a12.1.1719348739093;
        Tue, 25 Jun 2024 13:52:19 -0700 (PDT)
Received: from [192.168.0.104] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3056301bsm6349566a12.89.2024.06.25.13.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 13:52:18 -0700 (PDT)
Message-ID: <9dc47763-1c44-4283-8692-5e7dce14a0e2@gmail.com>
Date: Tue, 25 Jun 2024 22:52:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: rtl8192e: Fix conflicting types error with
 net_device.
To: Teddy Engel <engel.teddy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 oe-kbuild-all@lists.linux.dev, devel@driverdev.osuosl.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
References: <20240625163334.11117-1-engel.teddy@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240625163334.11117-1-engel.teddy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 18:33, Teddy Engel wrote:
> Add a pre-declaration of struct net_device so the compiler is able to
> use rtl_pci.h / rtl_cam.h.
> 
> Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406250858.L8rJMHQm-lkp@intel.com/
> Fixes: 7dff0b27d9c8 ("staging: rtl8192e: Remove unnecessary pre-declaration of struct net_device")
> ---
> v3: Replace ad-hoc commit id / subject by expected Fixes tag.
> v2: Add commit id / commit subject  under description.
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_cam.h | 2 ++
>   drivers/staging/rtl8192e/rtl8192e/rtl_pci.h | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
> index 3a5635494385..9deffdf96072 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
> @@ -12,6 +12,8 @@
>   
>   #include <linux/types.h>
>   
> +struct net_device;
> +
>   void rtl92e_cam_reset(struct net_device *dev);
>   void rtl92e_enable_hw_security_config(struct net_device *dev);
>   void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
> index c645775b2150..3e39c4835ac8 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
> @@ -13,6 +13,8 @@
>   #include <linux/types.h>
>   #include <linux/pci.h>
>   
> +struct net_device;
> +
>   bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev);
>   
>   #endif

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

