Return-Path: <linux-kernel+bounces-329901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC6979743
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D2A281541
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186F51C7B66;
	Sun, 15 Sep 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFyFX2zC"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492D2CA6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411475; cv=none; b=nk1ws3u0SyvvqrWrMSAUXJ8SfmB5s5aOu20XYeBRVsLZn7WOVgLjD6bkx93sJIJHBkrYs1y2oPB3lBThrKmH9nxArhrpZjuA27qzid23fVSH9yrkWyIpXEky2G7cq5BJm7oW8E3IMNoRXMHrUYtpUBYN+DJZsA5Gp0MCqundy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411475; c=relaxed/simple;
	bh=P03z3/vk9tX66eDUKP1sZ+GOLBzjfiQP8T1pS0h8a10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVeZ/2veRsm/oHdKKP1JJVKVnDP7hKKopljP1U0h9fKpwVHlDT3mL5jjtlErG5/ALf37yQRO77ex000byDC2lBd6s1FxK6f4tvzo9H9l2FJRotEwapETTOUckM4sS6g+ydBZgBPH6tXf3MPqehdUkmUDqqOgZzRzxlVGQPo1Mo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YFyFX2zC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so35273475e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726411472; x=1727016272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Im5mohdnvwzPYK1S2aukh0tGBmiMd0JUcK1Fzdmufzs=;
        b=YFyFX2zCBYRN0N8kZ8zny3FacnzqDygQJvAdRz88Nyn4o9hl6QsT5NHpQIgOFf+bXT
         Z+fvBrYwr73Q3jq0O7ywB7qiKfn0rZM3pjRyHkygna/fxKX3fg2GnxNFIsnLNk0SIrE8
         WdLiHT9mggxQsgGaQmJL+m5pjh8/Dmsr+xfHHEqwr1Xg0/tmP2wxjFASFYKYe+p6/akA
         QFVJqN6ze7W7mfgHQfZlGUv25o8f+nmz/OrI4wlMtC3XSz6VMpYwtQgCNDfYBZjFDhwH
         OFwrWAkhZl0OV1N7fyG+p2vmr2v/g2/MkCsqDmPppOS9wAp5rSsji8D4hmP+ym2RvBlf
         Tz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726411472; x=1727016272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im5mohdnvwzPYK1S2aukh0tGBmiMd0JUcK1Fzdmufzs=;
        b=dlQcTz5qjD+Qeo+cCtnjvsGyE/6MzsCQ0ErsE46VgJQPxGtPvysFwZpsOdSpT+FtNU
         H9WvJSj/vKzUins6fAA6Hw6pHbBgQWHWNjT0CEa0qVh0rQgUR2cm/wErTe4NBDuqxOFG
         /3EM8Rtq3fm8oTbk4EZVR7TVrqf0K77AnAtea0N0NEBeX44zYf2WQvN1rArvacaMTCI6
         QgIUtzRrdCQ4GAm6Gi4JJ6FUG3EHdoKQkr9ccF1DdcE24v6KEIP1dpV3g2j9dSFQpZR1
         xBJb7Hlf/+JjdtyKYavqdBKSEDpiWCAAevdpsC5tb5A0iK18jS5HFDbGlEIlX+tUyxVV
         L0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU6zKrZf8U56TWKXDnXPZXipVSzZfmqMc/iFUyTHUWzT3xZy8Hl2wFZ4g09qPeXxl0TgUSlTwL4E7sqE9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6BTLv1Wo6azmv+RcKDRc4XGHE1eVLaL8SmvIq+SHyGswUQ6b
	fDsDChH8siCdHbq7tgWylHokmYfwLnGRy+RlAx7FMHaOgYj1VorbCSVKvIZ1BVoF1Nhkzv71qzz
	V
X-Google-Smtp-Source: AGHT+IFFIav3HQrjidyoF0GojUNGWBSCwS64zJ0ttCd35kkMnPXYBhdHgMnmP9VgeKOeeSDjeETmGw==
X-Received: by 2002:a05:600c:1d1b:b0:42c:cdcf:2fef with SMTP id 5b1f17b1804b1-42cdb540484mr103275215e9.15.1726411471952;
        Sun, 15 Sep 2024 07:44:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05d6fcsm83832645e9.15.2024.09.15.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 07:44:31 -0700 (PDT)
Date: Sun, 15 Sep 2024 17:44:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] staging: rtl8723bs: Remove unused functions
 including read_cam
Message-ID: <952106c1-e455-46bb-962a-a6f1ecc05f30@stanley.mountain>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>

On Sun, Sep 15, 2024 at 08:38:14AM +0200, Philipp Hortmann wrote:
> Remove unused functions, macros and one enum.
> 
> Tested with rtl8723bs in ODYS Trendbook Next 14
> 
> Philipp Hortmann (17):
>   staging: rtl8723bs: Remove unused function dvobj_get_port0_adapter
>   staging: rtl8723bs: Remove unused function rtw_search_max_mac_id
>   staging: rtl8723bs: Remove unused function read_cam
>   staging: rtl8723bs: Remove unused function rtw_get_oper_choffset
>   staging: rtl8723bs: Remove unused function rtw_get_oper_bw
>   staging: rtl8723bs: Remove unused function _ReadCAM
>   staging: rtl8723bs: Remove unused entries from struct hal_ops
>   staging: rtl8723bs: Remove unused function PHY_SetBWMode8723B
>   staging: rtl8723bs: Remove unused function PHY_GetTxPowerLevel8723B
>   staging: rtl8723bs: Remove unused function Hal_BT_EfusePowerSwitch
>   staging: rtl8723bs: Remove unused function rtl8723b_GetHalODMVar
>   staging: rtl8723bs: Remove unused function GetHalODMVar
>   staging: rtl8723bs: Remove unused function rtl8723bs_inirp_init
>   staging: rtl8723bs: Remove unused function rtl8723bs_inirp_deinit
>   staging: rtl8723bs: Remove constant result macro is_primary_adapter
>   staging: rtl8723bs: Remove constant result macro get_iface_type
>   staging: rtl8723bs: Remove unused enum with first entry IFACE_PORT0

Thanks Philipp!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


