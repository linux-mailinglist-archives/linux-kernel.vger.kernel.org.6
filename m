Return-Path: <linux-kernel+bounces-261723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761693BB55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310A2285240
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DDC1865A;
	Thu, 25 Jul 2024 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qH35jpn/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673C3C3C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721879482; cv=none; b=O6cIKknQYfYXOailTm9NEgAQ5yRYfG2tV/M2TcuyraoiUdQJiENncPOBDcIGT8/UVDuyxmWAvj/LLGlweyZn4QQxRVjzIltyR8szpoAIDB88FiNvDfHLdO9nDUkSYhqn3KAE5qxxe9fEi1tKb0Cj4BnGnUynmkmuU7BNsqo27Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721879482; c=relaxed/simple;
	bh=fCfETQcIwR0zoxCaDh7zmy6xKdyMs2KCqzVmscPbTO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMZd60FRC6ACa9E+JakA8G8aWyTMI816jPpGbuvqupRNRTOW+XFbjd7jjVdR6pHS7bncdHUNSOztWHMme0G6CWxhxL0SQs/FOGHBlOWuLl0NVSg/sANOjjsJ9Jg7Wx8Hynf9UHLR8xIymCfLm24FVWH57TSeUA3x9cXCKztF8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qH35jpn/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f04c29588so588568e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721879479; x=1722484279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNYhTjsxqh1MBcJckEFXN+yzwFzXcYglKIB13bT1HUk=;
        b=qH35jpn/veqEnRHK+l7yp0J0WwfYq++vnIrp8uPeGTtR4QvYGMd8AHeFOauKlswri3
         QD8djG6JQv9zz7VWMGBoWkPjBS1y5kX+hda56GK6u8d5pKkiMgfBaptGCw1RcSWF6MEZ
         64AFmKzlKgWiAJAUsjCmm1yiDCv9ixjfvhyVAWJ0W57/pnXtr2uDDstvofchMG7Z2wUH
         EymM+V0BHaRxheNg/++Oeip/xSi5THj4fYPTzaS6u/4H5in148M5Lsx6WQbcvbaj+iMx
         Oo/4vDWeQ1+csX257vkzAZyIvHfPvvYyVB3A19079mgUoBvUewWAk2cfqB3mTn0l8IDs
         Mrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721879479; x=1722484279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNYhTjsxqh1MBcJckEFXN+yzwFzXcYglKIB13bT1HUk=;
        b=FiPAmXnkFxWKcz27hhDjNWASiHUbafTIIJqDXb61aiJcagL4N+6rKT65IcmCx1gdBe
         2z2nEVvugDh8Zo4Iz86uV8ueFsUEAEuQEB34RfeglmIr99CgrPSKSfBFSHdW1leoxDn9
         A8XnKjTs0LN0zDXucHpL3vDKeE9wWbR+q5hnwGF/5X2tkrNmxwcoboth480P29EysECh
         rneFZORW252QXMEk8wKZt324rJ/hF9g8GeMrR9JmBof8YYagX4d8CDQkNEw+2gE9sIgn
         LLxA6o4uF60oJWF7qZUJUg3cYbIb4oPpMIsOO3DLM7ciOU0+kMI49jVxg56bw6LFkMxi
         aFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3sL3zdl46C+Pxm0A4vOq4G6IW6V5LaOBLtzYQ5VxPyOIiZY7jXVK56UCuMmbKc06g7j/WOrCcVUH+jk+t8mtuSBR8OlaFVdE/njvY
X-Gm-Message-State: AOJu0YxOywo0cKbAPHegT1VmQH6HL8CEkx/xxqKwP3FxLdcHFuFeCoOd
	ycXG2g4zQaxQBSvXPDUYNinOUCTHnijVsFjV2BGNGPylcRJ+iROCOOak+8eW1a0=
X-Google-Smtp-Source: AGHT+IFVQ+aVJJmE25JP8a0HX3bdKT13fCdNQmhW/3KOv9baRW9TsF3kvo+Z+I11aF2nOvo3uSUiiw==
X-Received: by 2002:a05:6512:1c3:b0:52e:f463:977d with SMTP id 2adb3069b0e04-52fd602a7famr308517e87.20.1721879478572;
        Wed, 24 Jul 2024 20:51:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c1a148sm68691e87.226.2024.07.24.20.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 20:51:17 -0700 (PDT)
Date: Thu, 25 Jul 2024 06:51:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] usb: typec: ucsi: Fix SET_PDR typo in UCSI header
 file
Message-ID: <qjtutodlbqhsj3ofdhhw2ggjgh3sqglvxmxt72oz3j3xsswmau@g4b5ub56ctfl>
References: <20240724201116.2094059-1-jthies@google.com>
 <20240724201116.2094059-5-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724201116.2094059-5-jthies@google.com>

On Wed, Jul 24, 2024 at 08:11:16PM GMT, Jameson Thies wrote:
> Fix SET_PDR typo in UCSI header file.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
> Changes in V2:
> - None.

Fixes: 470ce43a1a81 ("usb: typec: ucsi: Remove struct ucsi_control")

Note, fixes patches should come before the rest of the changes.

> 
>  drivers/usb/typec/ucsi/ucsi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 6a958eac5703..a0e91335da80 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -153,7 +153,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
>  #define UCSI_SET_UOR_ROLE(_r_)		(((_r_) == TYPEC_HOST ? 1 : 2) << 23)
>  #define UCSI_SET_UOR_ACCEPT_ROLE_SWAPS		BIT(25)
>  
> -/* SET_PDF command bits */
> +/* SET_PDR command bits */
>  #define UCSI_SET_PDR_ROLE(_r_)		(((_r_) == TYPEC_SOURCE ? 1 : 2) << 23)
>  #define UCSI_SET_PDR_ACCEPT_ROLE_SWAPS		BIT(25)
>  
> -- 
> 2.45.2.1089.g2a221341d9-goog
> 

-- 
With best wishes
Dmitry

