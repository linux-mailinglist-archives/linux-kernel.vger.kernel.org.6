Return-Path: <linux-kernel+bounces-352566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AD9920D2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB31F214C1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A1518A934;
	Sun,  6 Oct 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XT+i9bx5"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10F16E895
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728243766; cv=none; b=VTNUJSH/qb5nJlMuJ+DyHRncVJ2ry0h4ubIa9s7ApVttrVm+Ni/kXPFz7KQUgEkVjdQel8tHJEJrwjkn0p40uXzVNg3Ei34nfpTJH/Oa3ZKa8P1TZJrzvQUQcRGHvofujlcufpeWZZ9qMTJuFB/IKbHmeCG3SHMlpOtj7N4bhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728243766; c=relaxed/simple;
	bh=Hcsq9u/Oy45NABldaJR8NLozYhmALr0ebJvg0CjHjrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7v458QFEqsi2gy1azsbNppUvvPY+glVZHDQyUvdBtDQVi2r/Mlpdp3Y0TiXbPmLg4J0zWepryUZZa8ux3Dvr7TgFmshvPbAkB6p58XtNHeevFHlDBjVE8lXBV1PHsTk2CTQI+5QHGEOBLCgu30gU/f57VeN/rQ4iRRGpVteXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XT+i9bx5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fabfc06de3so39519871fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728243763; x=1728848563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHibNOQgWPeoVta/xHpsDiUFSZc/zSngWt4tp6ypuXs=;
        b=XT+i9bx5GTTxOKtD/72pebZfL/os2XFWqAgqpHWAgp+Q2BVJJdUdz4ILYpq9mTHsQ9
         JTpJNSXq5Iy06gOzlLnQaP2n3WoVYJvHuqPxjs77rh7FVni+GZx35AwD/7BfYXDKKULs
         K810HqUkI/xaO76MbCZ6thAHjXEWOLSvfSmwtIOVqVFB+GvjQqfRRrJSdCMmfGowqr8r
         YHaweWsrfIiPkGeGha8lJsbAYYmohFTxnE89H/4wzT4xVRXy+L4wihjlCWetbUZ7X8cN
         s6Uj3WQxQryMYjWmrlV0XDexkf17lVjo2NocJDzOQZdgBNIpP4/8s4uHEZunfeO4u/7o
         GmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728243763; x=1728848563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHibNOQgWPeoVta/xHpsDiUFSZc/zSngWt4tp6ypuXs=;
        b=KFWW/zftpYiEmxEam19uZlulqecBDPosb6L1sHI8+6ZVoMHIiKmQHT1w4lDbCsRzHK
         XkIXxtwIicivJayGbTYQY6ZzW8rj07wrOZSZ2LV5MRKDeIqcUwK2ZHzNZ3xKvfDATETF
         mYZ8Ga+hqFA+Ap+CfRWGXSdCP5scVE+ttCKvrmXBHi1qXt9IKps3nhP3Ewqyu4TSGSfP
         5ht9lkkQjTQvJTKVPhXE81STmlRLFpAo+kl7bCbFvMUADbMq4i+FLiqtfJkFNmNpNNG1
         eaxoRaGpZK4OD/WCzH8dI3NoF6zCwqdVZ9bqvkukr9gizeLiO1mqV9M5rMyu9yIgFV69
         kcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaIc3Zp/UHvD4Tssv8aY7MVnmo7COBLhQiQ6fSpP6oZN55Ktlr5SsHkHVvbCNI9gftdX59UGneGy6IhEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDerRX+fKcuZGEGRGdTzRcSeORyDRcY2wb2mqY9uhwMYXUiKy
	5Zuwo9oD9lO1SvzNkiufcUmnhW6QIXbmnpZA9OjtleS7z0Yh1o953AQEC9ehtZ8=
X-Google-Smtp-Source: AGHT+IEZlv8v7BJ84pPP1ztXJlcl0Se7cU3v7FcFIzLns/Dc88WWmH4V82OwZA86E4ml+OBGEToOcA==
X-Received: by 2002:a05:6512:10cf:b0:536:53c2:8179 with SMTP id 2adb3069b0e04-539ab9e1651mr3691623e87.37.1728243762717;
        Sun, 06 Oct 2024 12:42:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec1264sm601094e87.21.2024.10.06.12.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:42:41 -0700 (PDT)
Date: Sun, 6 Oct 2024 22:42:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pd-mapper: Add QCM6490 PD maps
Message-ID: <f5yvqcx4qh2ba44qxwezrtfnusnfo7juo52e27wnrp5toneq6y@3v5sy3yxbjyx>
References: <20241004-qcm6490-pd-mapper-v1-1-d6f4bc3bffa3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-qcm6490-pd-mapper-v1-1-d6f4bc3bffa3@oss.qualcomm.com>

On Fri, Oct 04, 2024 at 08:47:29PM GMT, Bjorn Andersson wrote:
> The QCM6490 is a variant of SC7280, with the usual set of protection
> domains, and hence the need for a PD-mapper. In particular USB Type-C
> port management and battery management is pmic_glink based.
> 
> Add an entry to the kernel, to avoid the need for userspace to provide
> this service.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/qcom_pd_mapper.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

