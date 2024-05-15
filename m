Return-Path: <linux-kernel+bounces-179598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF5E8C61EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D039B20BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B13E47F53;
	Wed, 15 May 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1I2LBXI"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241E4AEE6
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759000; cv=none; b=ZslBaTi9bVf9TQ+SUcdeZPzU+IuaOr+bDXSGLbushmmGV6sghdkW2j8ZfOBDGxD+2VhgvzPYyk7uAw/XvVVf7g09KN9wExZdGuRgH1PrEENm0ORvkyJ2dL6QylpbS9r7mJln3hh2juhvsLv3EiBQtO0yGNkD5xcpE6knh6L6uM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759000; c=relaxed/simple;
	bh=E0IGluC5+XgNT11xJ+RtB5dreOvQpxGunKXJku9jkWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEFGQoXhF4R/K/cE8dtTxMUST7QKqNqDWg9m38BhM9/FJUPntkZpdE3Lrv0ZAy0jmpaH7YRtFQtD7/AjffyGauMtt0e3S6g088nVVYPWnLOQh6eTHRnxfFha3RIKGzEf7QA0GSad8e9QraKFulIsJdC2b/M0JMihgy4qRJ2db8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j1I2LBXI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so78556051fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715758997; x=1716363797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YjDBypUekJr0+IQ4Z+KTG8+Tk3A3MRsLN1U8VmTHyxE=;
        b=j1I2LBXIi07weseEa+p8Tap3GE9BH1ngr+X2gQ7np6VUSeX908xM6VptdoWcdsxOVN
         PSZNv4iQv3QqRbtSq/BP2zfBys+BI8nQ0aCnqNS7NouIYFLCW1FaJx7H1t4uezEkCoEH
         NVzwrS9unlmNkv/xGqwt4OtkafTOP3i3HfqFzqDOr8+SXFCto5VqvW83jJXAQLf4JcBt
         4cseiSkLazYn9z/zBZPIs3YabyfAhxeFiwPHZqUZ5yinrEVveqYvHOc500+FdVyEd8E+
         Ok8O2wWAUjagVmiv//uL8P/YrvQUh3b6mQ3H4Hc6wwF1nI5i/OH2gwJnc3kx2Zwynw/H
         KAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715758997; x=1716363797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjDBypUekJr0+IQ4Z+KTG8+Tk3A3MRsLN1U8VmTHyxE=;
        b=w1zb/69c/7ByZidWnr9YJ7s++AY+DMiW3sxgTES5OoVRPoCNTGTFw2Wo7barNLRNdc
         eFHoMvRtoP4aelCC25D24iOkAP4ci4oSf/tf3KJgS0tELcUsNMFSTEzw6qRWQ1K2ku0m
         BGysHEHmSnkuyJYcjCBT6T9XhJ+CtO5hBLPZy2UWv7cx6iaqqejwrpFJBj1so1jN2ts0
         h3ZCULto1VQQuVwJbZLeCqnTwYjj4QlRthz5QnzwncMAOFGnGxI0svCgjo6bhZng7tOZ
         H4/Hotgw2Nm9rka56lFFptbfSXlaC5veyoc3W8gJq5QjWcGKX4L5wdcLkfrr08hdrOJ6
         Z+EA==
X-Forwarded-Encrypted: i=1; AJvYcCWg+sVbqcx5YZFBgiTAYZMZO8EFqakPyAlBHLdi2bYcZ6smXDI+zmt/f/iONQWqWUAXzs0JYqduxY1smWWII+iLdgVYmKFroTFrJRUD
X-Gm-Message-State: AOJu0YxP0rNZyPSDQQBtWRLz4h0HBG9AsoYnd8T/0xN61AfyM3v6p3Su
	/fgFXlsLEOP2K2Fa8yehHZYR+7AIdW6U1SI8CkUa4m2khSpUIMxGNUjX3M46Fw==
X-Google-Smtp-Source: AGHT+IGNYhZGnS7whMi8D6i33kdHngdHjgTrOicH2QUT098ZecRQ2W92yX+Fz+KdJPd9cb5m4ij6hA==
X-Received: by 2002:a2e:8806:0:b0:2e1:afe7:4cd2 with SMTP id 38308e7fff4ca-2e51fe5273cmr87212431fa.11.1715758996952;
        Wed, 15 May 2024 00:43:16 -0700 (PDT)
Received: from thinkpad ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce73f5sm223704565e9.21.2024.05.15.00.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:43:16 -0700 (PDT)
Date: Wed, 15 May 2024 09:43:15 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re:Re: [PATCH] bus: mhi: host: Add Foxconn SDX72 related support
Message-ID: <20240515074315.GB2445@thinkpad>
References: <20240510032657.789629-1-slark_xiao@163.com>
 <20240514143741.GA2306@thinkpad>
 <541de8e4.1600.18f79de44f3.Coremail.slark_xiao@163.com>
 <fc42977.1ac5.18f79eb945a.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc42977.1ac5.18f79eb945a.Coremail.slark_xiao@163.com>

On Wed, May 15, 2024 at 09:43:53AM +0800, Slark Xiao wrote:
> 
> Send again with text mode.
> At 2024-05-15 09:29:20, "Slark Xiao" <slark_xiao@163.com> wrote:
> >At 2024-05-14 22:37:41, "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org> wrote:
> >>On Fri, May 10, 2024 at 11:26:57AM +0800, Slark Xiao wrote:
> >>> Align with Qcom SDX72, add ready timeout item for Foxconn SDX72.
> >>> And also, add firehose support since SDX72.
> >>> 
> >>> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >>> ---
> >>>  drivers/bus/mhi/host/pci_generic.c | 31 ++++++++++++++++++++++++++++++
> >>>  1 file changed, 31 insertions(+)
> >>> 
> >>> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> >>> index 08844ee79654..0fd94c193fc6 100644
> >>> --- a/drivers/bus/mhi/host/pci_generic.c
> >>> +++ b/drivers/bus/mhi/host/pci_generic.c
> >>> @@ -399,6 +399,8 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
> >>>  	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
> >>>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> >>>  	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> >>> +	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
> >>> +	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
> >>
> >>This means SDX55 is also supporting FIREHOSE channels, which is not true I
> >>believe.
> >Actually, I just verified it with my sdx55 and the answer is Yes. These channels
> >are common settings for Qcom device which support PCIe mode. BTW, the
> >default settings of Qcom and Quectel support firehose for their sdx55 products.
> >>
> >>>  	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
> >>>  	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
> >>>  };
> >>> @@ -419,6 +421,16 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
> >>>  	.event_cfg = mhi_foxconn_sdx55_events,
> >>>  };
> >>>  
> >>> +static const struct mhi_controller_config modem_foxconn_sdx72_config = {
> >>> +	.max_channels = 128,
> >>> +	.timeout_ms = 20000,
> >>> +	.ready_timeout_ms = 50000,
> >>> +	.num_channels = ARRAY_SIZE(mhi_foxconn_sdx55_channels),
> >>> +	.ch_cfg = mhi_foxconn_sdx55_channels,
> >>> +	.num_events = ARRAY_SIZE(mhi_foxconn_sdx55_events),
> >>> +	.event_cfg = mhi_foxconn_sdx55_events,
> >>> +};
> >>> +
> >>>  static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
> >>>  	.name = "foxconn-sdx24",
> >>>  	.config = &modem_foxconn_sdx55_config,
> >>> @@ -448,6 +460,16 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx65_info = {
> >>>  	.sideband_wake = false,
> >>>  };
> >>>  
> >>> +static const struct mhi_pci_dev_info mhi_foxconn_sdx72_info = {
> >>> +	.name = "foxconn-sdx72",
> >>> +	.edl = "qcom/sdx72m/xbl_s_devprg_ns.melf",
> >>
> >>What is '.melf'? Is the firmware available somewhere? Did you plan to upstream
> >>it to linux-firmware?
> >>
> >This file similar with "edl.mbn". In SDX72 product, the default "edl" file name is
> >"xbl_s_devprg_ns.melf". Currently we don't plan to upstream it to linux-firmware
> >since 2 reasons: 1: we share the same fold name sdx72m with qcom or other vendors
> >2: this file may be changed since sdx72 product still under developing in our side. we
> >may change the base line according to QCOM release.
> >>- Mani
> >>
> And I want to say, the os or driver can't recover device with this "edl" file only. This file
> only used when device needs to be changed to firehose mode. After that, we need
> a tool and a complete firmware package to do the firehose download. Unfortunately,
> there is no open source tool to support this download. Even Qcom PCAT tool only
> supports their own VID/PID with their own driver. So the function of mhi driver is:
> Put device into firehose mode and enumerate the wwan0firehose0 port. The rest
> shall be done by enduser themselves. 

Can't you use QDL tool? https://github.com/linux-msm/qdl

- Mani

-- 
மணிவண்ணன் சதாசிவம்

