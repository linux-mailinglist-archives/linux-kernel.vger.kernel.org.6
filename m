Return-Path: <linux-kernel+bounces-319657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8526C97002F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22A5285A2B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5C52F88;
	Sat,  7 Sep 2024 05:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF3TpHSY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1F3BBCC
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725687241; cv=none; b=Fnwlq6jeZmK9+VqIvoW/GpPH9wFykyDQ3dxG0xl/jV91uitZ5RvAXqM1TMNSICNYX2NxOsuB4VEdHRi5iT6z4Pl5yPCEMSQumJPanrbfTr/RBq2M0kP/p2vnYFyNozUZxDenUX0XY1kV2Gi/a4vr6jnO6/6WTUuTvPo+qy2c6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725687241; c=relaxed/simple;
	bh=kfcyOE4DpTjdjTKab5fkXSY8DHJBo8VRu2aq+jREYf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sY/MuxQq3lghfAf3DltpYLubn6sDxcEQPczBDstR7n5ZtaCkQq3usMKZ20YA8MGPCiVWhsWu08nffXb9q99Y3IGeF1m0DOaOMbb6JB/HmX9R3IPXxSN8mdISjF3rRNYmilAqKdiKv8j/D0GhkZ/lkzAkCLwlUnTt/z0aXvn16jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF3TpHSY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a868d7f92feso377846866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725687238; x=1726292038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DjXA/8GrhI1BNWvWDz88P6fjRKdiu2Q/jSNXR3agbs=;
        b=YF3TpHSY1o3hS/woOFcDoefKd9a1IKsNHawftEvWH2EwQxqlUIozdiglTwPQebmzy+
         c+Ba/4TLAaqvA40swi+YKga5rVgawMdsI/nzcFPxxeqRoysOtQCE6c6czwyKR3vT4JHp
         oV7Ao/svctBzeigb7TzWqx5UPgGslzPEmpBBp5UrxrPPUg2eSP4cANzJFDrC4cwkZKTG
         +5UdmU6mnzgWJK6tGl/2CA/wJOeK5/sSg7GLiPwFUE2JZv08FxBBWT7wmYjYsoTQ36X/
         VTwz8PPnXNr99iqnt1zbXGveDBWCcPmhs60aXM0em/Oe+/ydy3NxseaonQBZW325lKEq
         oLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725687238; x=1726292038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DjXA/8GrhI1BNWvWDz88P6fjRKdiu2Q/jSNXR3agbs=;
        b=gyS2fo4pQJ1AJ3oAydkbPDSerb1VL+aPpl6gDJKy+Eq0+6buiWibvN61Oniv/Sg3AG
         jsraRZy9AcTtDa3yqmKMaYgX5nIGNdzXeImYG6XKgcQzixrOEJ9kq6KaqaVu+XTdhSEN
         BwZ1Twqk7QyjZB+OxoDorR906I+rN7KJiu4GAXHE9oTQZ9jhIJJ4ZZx890YdptuvVuRR
         CJQSQR+uY7F/FF0y1H6Ljne0iB2urbpBgYLtpMQ5esKtSXOlqL5yqOYV3+b5paGdJ3p2
         ROFwZOjJk/wzhN3U6WnmTl06iGdR7P/UoThscFgbEU0x38xWBY0gw872oqoQFv0JhRiB
         IekQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtI4/URSn7tmNklU9XcVZn81Xh6lS1b9N/HZU6sQkZ45WUnCFNMUdfNUSVU2hz3Yohdg/pcbxFNMfx/Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIB97DUqYWxGJvYprPFVzwgIIRHk7g/jZ5cFBYlA03zHZMK1t
	2mIDalrkOcMst/IO0U4PR0T6UMk76QoVy8Nl+LDg8OwSQsvZxG/d
X-Google-Smtp-Source: AGHT+IGHDYjOxcDr2zqVtQOZwyIIisn33mp9gJRdPX39U5JX3dvGPaknm1wyYBsds6xszZJNNwvuIQ==
X-Received: by 2002:a17:907:eab:b0:a8d:1545:f48a with SMTP id a640c23a62f3a-a8d2494c101mr43805666b.61.1725687238365;
        Fri, 06 Sep 2024 22:33:58 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8554:83ef:b48b:9bd4:f165? (p200300c78f2a855483efb48b9bd4f165.dip0.t-ipconnect.de. [2003:c7:8f2a:8554:83ef:b48b:9bd4:f165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced18csm29710666b.161.2024.09.06.22.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 22:33:58 -0700 (PDT)
Message-ID: <1d480b00-de7c-490e-8042-2d2c865ddbf0@gmail.com>
Date: Sat, 7 Sep 2024 07:33:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: include: Fix spelling mistake in
 rtw_mlme.h
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240906141134.10118-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240906141134.10118-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 16:11, Roshan Khatri wrote:
> This patch fixes spelling mistake to increase code readability
> and searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>   drivers/staging/rtl8723bs/include/rtw_mlme.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
> index e103c4a15d1a..e665479babc2 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
> @@ -131,7 +131,7 @@ struct mlme_priv {
>   	u8 roam_rssi_diff_th; /* rssi difference threshold for active scan candidate selection */
>   	u32 roam_scan_int_ms; /* scan interval for active roam */
>   	u32 roam_scanr_exp_ms; /* scan result expire time in ms  for roam */
> -	u8 roam_tgt_addr[ETH_ALEN]; /* request to roam to speicific target without other consideration */
> +	u8 roam_tgt_addr[ETH_ALEN]; /* request to roam to specific target without other consideration */
>   
>   	u8 *nic_hdl;
>   

Hi Roshan,

please make a patch series out of this 4 emails. This makes handling 
easier for the maintainer and the reviewers.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

