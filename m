Return-Path: <linux-kernel+bounces-528116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598AA413B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7600D170137
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079C199E89;
	Mon, 24 Feb 2025 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxAxZCx2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0A4430
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365571; cv=none; b=cLTpEwoxKwDpowaxEBzd3uwQm2y6QJz/7nPkwAo99FuAitWG/9YKtYQ9t2vm/XC01M4GObNKzPFg17Wb3PQ17/cePpym6/dNfL1sP50/ILqOraOjnT+0CWhpZeCr4j0m84LND9cH7c5h6QKI2Y1AcOluSlv/hFIKnF8lLwkwJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365571; c=relaxed/simple;
	bh=X+jZl9yjWxMVT4yYJA/b1HzJa0muchAg22wzqZtgmIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7v/lSKWpk37gWC0XLYSpcloXtyXU0KsgdPJOgHlG5rRzi/bUiul/3jkolctuLPEfd73RhuunHKUjgWPzvH9tsRv8B0ujOSE2voe4eyRLEmbPrnVSd6mzYW4Xgb0hfTKzTPkfo6GfnjuhciErsBNExks0H+2bjQyQQYhK7KdhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SxAxZCx2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5461cb12e39so3728325e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740365567; x=1740970367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N79cu7iC2Cqqnin+PLo4xCdrijtvr/2XsDeBhnAhIuo=;
        b=SxAxZCx25MjB9yd+nhpYqRFOySLyHXv+K5E3w/36MFzoqsPpaLsm+3ePFQHPeYfDmI
         Aifvg96ci/Y9L1mpKeIO3AWaHUzE91BxKL4lA1AnoE3gtQ2Yv+RMXPvNgeAh341Vh3YY
         L6GN0tEkIWUcybBuBhTrFuUPWaxtWNV8Ur4o/Cu/WRLTleqA+J5KM5Bt68AtrXgPw18c
         N9et6eE0LHpGlmfsDhTYVyHsOftEdxtBLE8IEDxpZ94AcCM3fsJKC0h8cinToGAFMedn
         rQsnWZYpd7tx0fpYRwgmLDZhQipGOI0a+ddtjN64vF8kBR3YZ4sZO6f2Oxj3h6zAMgHp
         FxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740365567; x=1740970367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N79cu7iC2Cqqnin+PLo4xCdrijtvr/2XsDeBhnAhIuo=;
        b=FNUUwZNG9evY/Rs4VIrIstkod3USbgUQBwHtbl4u+R0Vl5jX0XcuF/E2U3r5Ida4AK
         8npAZeaxiR/YuVWUBUOE36EYEyqLikH8LPsOTaIhoDyIuxrc5NJdhWd+09+3WPf34sqv
         TF65w+VOf46zxsB66sg9C24I/dc4iUHI+08SE5UtsBgw22nszIKfB1kFDDLbsUYcHN/W
         brAKD4yQS28J6kEmfA7jqEVW1/tXb4kkEX6QgsAcJNhDSG2XiLwVK0QEctGDPj6+u4kA
         9GQfT+f3I06y7Xj65f0xKiuZG5lHmEtH3MSVgEgP1agJCOyYIjZEh/y5RNVQKDt+nxRj
         ZZAA==
X-Forwarded-Encrypted: i=1; AJvYcCXrwvDrIi5HQLM3fHNoBGu4EUbaj2lAy/GK9EIGRFIzJep+IiIHYBMoGA7KILf7uPJx3y7TQPBUV+eRmf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybV/s1uB+KWm0RWet57wj85uQfWzw9aBfON7DH1O8ntccXdbpn
	EKHiISuitR45XX+A4gLYI8JW9ZlHys+MqczbEL/fuilaBTg0ebEodqjkiru2guA=
X-Gm-Gg: ASbGncsYU333diRAfxLB/vTxn6Y8ohXW1Uqj0dYzxED3j4uhXV9yNH7E+TbRuVYOWDX
	U8HRL3CMEnSqnMWfXdvJOw7x+c0IFJk4CX8938o1pMfxi4Q4FDQFcM8HoaTBMZAGiNHrMONGnaw
	RGeVuyr58DTbbqHjYjxsgB+sT9BVeKT4W84I6HOKuftvVJe/1Ut+4/q5cMY0D6Io+Y7soMmKwgt
	7JjHszOFYDzrIL4NVye8q3EH3bVKDz/M97FJdO5ODV3RVZkAcaL6VoOtXh/tHwscxZzqFHHeW2m
	6Bsb/4LHSeaqPRFNvFq0i5RLopRBzL454L9IqxXcVj+F6xErA9yMVQgPdPA4w7W7mdca+tc72zd
	FrcoQxA==
X-Google-Smtp-Source: AGHT+IEa5Mf84ph5T/ZdHvdKMLIs5jH8HXd1tjLXSn92MqsxBCI728iU6GLsECzIInK2/X8Pt2Ep/A==
X-Received: by 2002:a05:6512:110d:b0:545:62c:4b13 with SMTP id 2adb3069b0e04-54838f4c9efmr4290701e87.40.1740365567236;
        Sun, 23 Feb 2025 18:52:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54839cd339dsm838172e87.203.2025.02.23.18.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:52:45 -0800 (PST)
Date: Mon, 24 Feb 2025 04:52:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
Message-ID: <6jx5ldpidy2ycrqognfiv5ttqr5ia4dtbryta3kc2mkndrvvgo@qzuakucz765k>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-8-shiyongbang@huawei.com>
 <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
 <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com>

On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
> > > +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> > > +{
> > > +	struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> > > +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> > > +	struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> > > +	int ret;
> > > +
> > > +	if (dp->hpd_status) {
> > > +		hibmc_dp_hpd_cfg(&priv->dp);
> > > +		ret = hibmc_dp_prepare(dp, mode);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		hibmc_dp_display_en(dp, true);
> > > +	} else {
> > > +		hibmc_dp_display_en(dp, false);
> > > +		hibmc_dp_reset_link(&priv->dp);
> > > +	}
> > If I understand this correctly, you are using a separate drm_client to
> > enable and disable the link & display. Why is it necessary? Existing
> > drm_clients and userspace compositors use drm framework, they should be
> > able to turn the display on and off as required.
> > 
> Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
> We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
> the different video modes into DP registers.

Why? The link training and mode programming should happen during
pre_enable / enable stage (legacy or atomic).

> 
> 

-- 
With best wishes
Dmitry

