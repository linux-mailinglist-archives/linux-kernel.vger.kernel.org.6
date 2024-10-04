Return-Path: <linux-kernel+bounces-351556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40347991310
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E442836AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209A1514EE;
	Fri,  4 Oct 2024 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ezBBvrfG"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085D13B7B3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084847; cv=none; b=ELCb+wmr86B1oYcXnzEmhvdeaUa3R4yk2ccraPHadzEHLyiUUWP78nixl6SBKegqNUOBJ9eJGm8A1F5zHFn6+98vV/9K6nqPI5SSc+yCC9vGdJuqhEZZyyBJn2ZrGJETUIQ2kXO4vGFemvGGksNGGvjrUYeRPCsxUwj/qh1TL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084847; c=relaxed/simple;
	bh=9puunMsepb78XI8PyErkXDumZiN6OUvhJ82G9mTQ6ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuQdGpaKzdSA00ci6gulz3m53/Y+T4ZLBCT+JhZOb3iu233FnOOBt8QNiS+VAdFc/CjYzomcWf/X7vaBD88IqyxpdPJqkfiSXbJrYpkk2cIMsg8H8Uy1h6a/RZM/7zUlvVCbL120XxTHwjXWPCTL17gerRjMsWMw1OF2vSypwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ezBBvrfG; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb2aac40faso30061266d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728084844; x=1728689644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEr1bgGbdIhTRvJq6QQK1LSQE3Bvhn7MMNbTSr1CmZY=;
        b=ezBBvrfGU71I7DyJertpXbas/BajV3JFxQ/llwiAwPcFvrZUyY6lYBE2lMR+qmLCZZ
         rC5z9IUcbNoWT7oZnA+wuGg4rCjHf2Kk+NlCBIQpPigIeo/DV0R3+4Q9RfqKZhD+2wQg
         6UfAanV9+UL/G+Zq+b8hUxs/cRI/s5UvvdpBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728084844; x=1728689644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEr1bgGbdIhTRvJq6QQK1LSQE3Bvhn7MMNbTSr1CmZY=;
        b=CjKEA07vax2sh1FC+ZK5ZjlRWrVfrVYsDi1sTF+2Z2gSyVuuuaBP2lXd2tX6ztcO4f
         w2l0NIILeTSTkLu6xwkicaZqb74uVQ4MJkitwJqO5H9w7H+VukbFOaTKNipOV5Z00bfA
         tygjICY9mPXQIzcbAoxUKYbvIJpRGLiwQntH4fpikVQcL1lcsemPmAXxZl7AmkpI8Gxn
         MD1bUzHTkHjBq5gygvFIG1XdQN1fDlXYK0OKlzH39Ry8tNcYIYObukg+tAfsaG7Pho4j
         gjICSgidgKBUYm83g9dOhnV50FE3usWcN5NWuZDI9DciUuC66DaVSl99bRG9AZ5gGBpa
         QnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7G5KELLORMDm49Sdo6jlulHYqDwcIi7419L4UrJKIUAvly4r3hD4eK1Cvlord5YpArE+zGwt1UeSx5R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBnHB28miwQT8QB3CKq8Ga5+0SzYJ6Autth/i5giwUlV5hMU7
	PvC86EoaMCKgCKC6/q9RTCQb97sbcMu7fxFTWWN2H64Oy7p14MpheykEd/K1Bw==
X-Google-Smtp-Source: AGHT+IGaquXlqirj+VXnsOr24B/0vE++hyztwT2o9zz/fzDRgzv3htgmjpxsPMvdfi3sF6F9ZqPKVQ==
X-Received: by 2002:a05:6214:226a:b0:6cb:55e4:54d5 with SMTP id 6a1803df08f44-6cb9011ee5dmr153370606d6.10.1728084844502;
        Fri, 04 Oct 2024 16:34:04 -0700 (PDT)
Received: from [10.69.74.64] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4751032sm3438976d6.84.2024.10.04.16.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 16:34:04 -0700 (PDT)
Message-ID: <539c5456-b807-4bb5-b5cd-28eb1c22132a@broadcom.com>
Date: Fri, 4 Oct 2024 16:34:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] phy: usb: Fix missing elements in BCM4908 USB init
 array
To: Sam Edwards <cfsworks@gmail.com>, Al Cooper <alcooperx@gmail.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20241004034131.1363813-1-CFSworks@gmail.com>
 <20241004034131.1363813-2-CFSworks@gmail.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20241004034131.1363813-2-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/24 8:41 PM, Sam Edwards wrote:
> The Broadcom USB PHY driver contains a lookup table
> (`reg_bits_map_tables`) to resolve register bitmaps unique to certain
> versions of the USB PHY as found in various Broadcom chip families. A
> recent commit (see 'fixes' tag) introduced two new elements to each chip
> family in this table -- except for one: BCM4908. This resulted in the
> xHCI controller not being initialized correctly, causing a panic on
> boot.
> 
> The next patch will update this table to use designated initializers in
> order to prevent this from happening again. For now, just add back the
> missing array elements to resolve the regression.
> 
> Fixes: 4536fe9640b6 ("phy: usb: suppress OC condition for 7439b2")
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Woops! Sorry I broke it.

Reviewed-by: Justin Chen <justin.chen@broadcom.com>

> ---
>   drivers/phy/broadcom/phy-brcm-usb-init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
> index 39536b6d96a9..5ebb3a616115 100644
> --- a/drivers/phy/broadcom/phy-brcm-usb-init.c
> +++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
> @@ -220,6 +220,8 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT][USB_CTRL_SELECTOR_COUNT] = {
>   		0, /* USB_CTRL_SETUP_SCB2_EN_MASK */
>   		0, /* USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK */
>   		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
> +		0, /* USB_CTRL_SETUP_OC3_DISABLE_PORT0_MASK */
> +		0, /* USB_CTRL_SETUP_OC3_DISABLE_PORT1_MASK */
>   		0, /* USB_CTRL_SETUP_OC3_DISABLE_MASK */
>   		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
>   		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */


