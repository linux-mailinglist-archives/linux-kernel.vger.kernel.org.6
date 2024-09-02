Return-Path: <linux-kernel+bounces-311730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F05968CDD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA264282D7F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4786B1C62A0;
	Mon,  2 Sep 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfCOTZ6Y"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621D1AB6E5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298680; cv=none; b=cR2DdLwVqXkHK4NnFgOyIerR4aMcWLBftEhcGF2R8IKs4w5b4Y/eARnrChvw8Dudl08f/a7lU7SgNeCTQYy1VgBQ3ckkcJWMJPiY8Y072yUb/1f+EshZEitbrmzovSVu+TItuLW0HqIiy1QhFlY1fzYaD4C9yzuVeX9OdcwgtO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298680; c=relaxed/simple;
	bh=2LyLJFBJOmpkyHgmBU0Wd4Kf38GorrwZA3ZkiceVJ80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVCLDfeM5KxJ6OS3r7/aJJsFXj9W54jDcZZ0URrAw/WzMMW5ycxpnUeYd7smM+dBNP0b6N6LFqicX7ZnLCiD9r8q97rV5rJi10FJmwLzbKl89Zw+SA7T6szZ1MctKShjpBrh0i3K8QdUYVYlDqWC9O2upRPcg0hPLW/w+v2aMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfCOTZ6Y; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a866cea40c4so511738566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725298677; x=1725903477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlYC5+UWRQW9485wkiPs3igaS2O+2Vwz4uQskFYOh6o=;
        b=CfCOTZ6YWEL17QFrI2flz9UQh0BXcWE6Ayt4tp3IgXQ9yRCYC8ryrGBtS4oG2rxO4l
         1pYvJp7Q8iix+ufgmcQAyYra5fiOgV/UwbePNFMeCF/pY+uoeDOpyHNgsxlAN6Hf1dSP
         JLa+Sv+TLfbMMX4FX2oZu491uanxBsz3T4yhkDggyVV18Nzk5RoFNTCBf/j8foR2nknJ
         XxafvMOY59r6kFvYjylhtlAXbGDgve1LaXC29QFTkT0NOBGyi1ynJltwBICDryhZNNZG
         xsW+ascvfDVadqtjrRxTuuOl9mHkSHkL3mHiXoZc45LzBIzWsZxJ1TQGUd4jxbtx49X6
         WdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725298677; x=1725903477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlYC5+UWRQW9485wkiPs3igaS2O+2Vwz4uQskFYOh6o=;
        b=xNpg3pmbmNiglTaBPdpCYkBx+sl77rmsiKl4caHSpBMwlvlSe6ylbBW/dsbjbS4WDX
         NwLNk47aANQ68Dz/hnIDwzL9vurfh2sf0KdDCgTWA6kegX66GuS8hoBI6ei/ksHv0gok
         u096oTIrAkVCb6VLaVGCNweOr156L60jbXsrZEoP9Gs1xSZp/IbvXoumLKlwTXCxYu6N
         6J5b01KJAqn5GB6KyO1IV6Xv9vAflNQGNxXcl8RacgAtNNKUX5YpQpvD815ueAsR2u41
         bjV0gcRG0ykoEUncpF2VAon3N+w7R0eiBVSFRZhtqX9AV5VuDLC0JAKFcL0LvGHYwKjZ
         eCfw==
X-Gm-Message-State: AOJu0YylenfUYVPeibd0jAGfiEU7bUBnsRdWImAD4vvVjzWBLAgThTR+
	tGE/AzlkiYu4KMwhPNPa5H2VjQtEpCF/2bE2iU4nh786Yx6yZGps
X-Google-Smtp-Source: AGHT+IE72WMG+NfpRJWbufPMuI0nhMrpl2JfY4rFg8iprwK9c4YxYynUgwNJPBlebwy8FnMGyuHzDA==
X-Received: by 2002:a17:907:3fa6:b0:a86:b00a:7a27 with SMTP id a640c23a62f3a-a8a1d5708a2mr73755466b.60.1725298677132;
        Mon, 02 Sep 2024 10:37:57 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb0f0sm582173366b.20.2024.09.02.10.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 10:37:56 -0700 (PDT)
Message-ID: <cd97d2eb-25d9-423b-9037-c4cc3816a760@gmail.com>
Date: Mon, 2 Sep 2024 19:37:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Constify struct pci_device_id
To: Riyan Dhiman <riyandhiman14@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20240831160831.121720-1-riyandhiman14@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240831160831.121720-1-riyandhiman14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/24 18:08, Riyan Dhiman wrote:
> static variable struct pci_device_id rtl8192_pci_id_tbl is not modified
> in file rtl_core.c.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> Before
> ======
>     text	   data	    bss	    dec	    hex	filename
>    17838	    893	      1	  18732	   492c	drivers/staging/rtl8192e/rtl8192e/rtl_core.o
> 
> After
> =====
>    text	   data	    bss	    dec	    hex	filename
>    18006	    725	      1	  18732	   492c	drivers/staging/rtl8192e/rtl8192e/rtl_core.o
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
> Compile tested only
> --
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index ad21263e725f..22a203d01b8a 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -25,7 +25,7 @@
>   int hwwep = 1;
>   static char *ifname = "wlan%d";
>   
> -static struct pci_device_id rtl8192_pci_id_tbl[] = {
> +static const struct pci_device_id rtl8192_pci_id_tbl[] = {
>   	{PCI_DEVICE(0x10ec, 0x8192)},
>   	{PCI_DEVICE(0x07aa, 0x0044)},
>   	{PCI_DEVICE(0x07aa, 0x0047)},


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

