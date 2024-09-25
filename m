Return-Path: <linux-kernel+bounces-339459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11130986563
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C441D28AB40
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526B684A31;
	Wed, 25 Sep 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdrF2Xy+"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE8481CE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284328; cv=none; b=MO0NWjB1jdW7Lx29ujcbZVc1gjpXXUTtWTw9ilAQVdMQOBg78kof84Zo4SLogneL7IxyaOxQnPLCrz+pHwS+oxzt0KI0AXWAaNUoZYaLWNripkP26VVQgQHaDdMpI5ibH0Ds+fdZAwkMJY6WM6BX6NVg4jFFDQEgG8OIgXGXfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284328; c=relaxed/simple;
	bh=bIoWbL8+cQIvftkQhhhS5aGeLo30gcPHnKNxeaE3haM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WULN2vY7aM3lhbEVhRb8Eg1MiULpICJu6e11MFgiFrM13P/GD0Cn5qZp01mtXEp6tED/jeniWxTmjrFpL9gVwLlgDjWr3mRRuY+NZa3dNS3VnZ+dFIwsQz1tAKJ6+l94Sa6UsLYsYDnS0gKXwrcg5MHUR5tb3y449h0dzdQXsiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdrF2Xy+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-536a2759f0eso144575e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727284325; x=1727889125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4Z/qrw/8ifzhH4AWTm4LO9RxwBj17vLbr7zbvp6uIk=;
        b=OdrF2Xy+54e01alroweUoc7T0cOqAwiXrLotIIkAUOvhjUaCLA4h3U98i3ad3MlRFb
         pmQqnX1MxR6uHsdB2J25qPynbrfnz1421N2jSZTIuO8gkf7BYhmbs5pekvfn/sUiJgDc
         zxMqGRktYOlmGA2rPEplhJucT3V1QmSI7OohqAp7nTAGl+UpA4yYZhW8arpYunULdGNq
         03UyXj/BEiVOaxRaRR3Bre2T/jkvvvtEQjuLe4pr5zns7GIrgqd7wdG9onOnoKFTLWDC
         DG3gesATDCnEYaLCkMqQ2B4mSsIqiMPQDpUn0VqvEPd3jV190mJE1eKNWHKio72GPX8/
         IdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727284325; x=1727889125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4Z/qrw/8ifzhH4AWTm4LO9RxwBj17vLbr7zbvp6uIk=;
        b=xCaaDjD0M1VUXTY7+UBgEIvAnfZVq6f69tluaXaiGrFHdsJlsbBD3viXskHqglkDhZ
         TEGz/8cMayL3yTozifxby+fGsZt2I18VB2CGIdyRYxFUmjS4ElT2vt2YlRZurZbvTON8
         M+szaQUPjL9YLCMW2QojF9/14e54NYhu8u6+GQafiQ9y1wKyGPlwuxsUe/OgToLTnNlI
         9aAslbBT+RBEIPpqH3gyAuo6kA5b+bGMIm2+YnzI9PYVW/cWcGKipCBQfgyT21oEMtAU
         kzHp4UIRVySLYiv9owtUiQwxPnuwkETgvgu34q+/mI847YfUr13rAC/11XfiZ88TwLGO
         mK6g==
X-Forwarded-Encrypted: i=1; AJvYcCUcZwK70WIfiX5s8N9iBraKrKeoUm91th6S1KRG1ZwiEBMj4dyuHuAd+zEgwEQVHAiGjsptdKeM+SFNdWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Xu99A7wVOE2uQIXwgc+nfHmcY6OK/kilgUPFcTTn+eGGWsoW
	aDtE2qutv82f2SyIrPu4kN6tQb/nlsYztluG+5sjStx8baY0ofQt8p/XNzAqVLvA340twQcAav3
	cr1W4IQ==
X-Google-Smtp-Source: AGHT+IH88Z9ewx3HV2rusn4TYxo6thy54qxZ0Rzi5KZL1FRdRnJgljKSZzpDn1p7xLduuWwez5myRw==
X-Received: by 2002:a05:6512:3d26:b0:52f:d15f:d46b with SMTP id 2adb3069b0e04-53870498352mr2214537e87.14.1727284324994;
        Wed, 25 Sep 2024 10:12:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a86402adsm572113e87.169.2024.09.25.10.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:12:03 -0700 (PDT)
Date: Wed, 25 Sep 2024 20:12:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, Benson Leung <bleung@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/8] Thunderbolt and DP altmode support for cros-ec-typec
Message-ID: <6flxq7m7fdcpajdg5sthar6xlnpn2b3nzzwgp55jlqrjw5ubge@kdym7c2kv5fm>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925162513.435177-1-abhishekpandit@chromium.org>

On Wed, Sep 25, 2024 at 09:25:01AM GMT, Abhishek Pandit-Subedi wrote:
> 
> Hi Heikki, Tzung-Bi et al,
> 
> This patch series adds support for alternate mode entry for the
> cros-ec-typec driver for Displayport and Thunderbolt.
> 
> Thunderbolt support is added by adapting an RFC Heikki had posted
> previously:
> 
> https://lore.kernel.org/linux-usb/20191230152857.43917-1-heikki.krogerus@linux.intel.com/
> 
> A few comments on the series:
> 
> * The cros-ec interface will not accept any VDOs/VDMs so we simply
>   ignore any configurations we are passed (i.e. DPConfigure). This means
>   the sysfs control of DP lanes won't work.
> * ChromeOS has two modes of operation for alt-modes: entirely EC driven
>   or AP-driven from userspace (via the typec daemon). Thus, we never
>   expect the kernel alt-mode drivers to auto-enter modes.
> 
> This was tested on kernel 6.6 with a ChromeOS Brya device and compile
> tested against linux-usb (with allmodconfig).

Please test on top of the linux-usb or linux-next. 6.6 is nine months
old kernel.

Also for v2 please consider CC'ing both lists for all patches. Otherwise
it's hard to follow the changes.

> 
> Thanks,
> Abhishek
> 
> 
> 

-- 
With best wishes
Dmitry

