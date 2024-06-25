Return-Path: <linux-kernel+bounces-228705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73A9165A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EC31C21DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676814A60F;
	Tue, 25 Jun 2024 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaI1ZqjW"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518A1095B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313152; cv=none; b=FB44oXWgaLdMzn0SmUxP0h0VLn6SZH2ikbtBSPM/uzSdWoNpmz84bz5zXihinxVq8NUFhd+j3CjhzoFsmZ6LujfA8PP07ByD/NrrMfNknkBdU840NwD7txDwyO6YM1ipFeNQSm+EoccLMQiHADNSswC16mZDejkTcUmpJ3PUxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313152; c=relaxed/simple;
	bh=AvGbWbfCQolqEB3Qeoz2io8fr9DpeiYOoxZvrBezFoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ddx+r3XBu1BMcueVfCANF4ebz/ofYNsAYuF3IRjxTrq+9FwcrqZoSU1kMtngt4c357T9bUD/0fjTt8tUyi0UCKszVe6yZdI+yNG4sMZ5LwTfAobFO+xW5foUzBqq/dcI8UjYHpe5qZw69zd5lSo/R7g0jEUMzn4tAJSgBEZT/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jaI1ZqjW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdf4bc083so4345353e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719313148; x=1719917948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ap+EbCgWJ+AJvWKstiQPgmG/qtQmcsmJ/Rrhaee2O1k=;
        b=jaI1ZqjWNmRu4xI63SxCUGxyHU/QBYjF0Ymnt8L6b5xk7QuEUWi3AqhNhCBZmvkgOA
         qqR8/79C8hQlluIq3usk8Shr/rLKd+a9LaYbOrCyvraNAZ6z9RJn8D9DYdkQzGIjvQ3u
         UINmYFIVszsbEH1aiFBbN1sdb7xdcwfetY1N1dPNP/PHgNaV6u46UJHMkYz6Bbn63Ggn
         abBgxM1n05m/9ycrFYxQJtyZXQcwPw9IVncq7bfSqwHyJIJ/QZo10RwMUXdOiYlCHoh7
         5v7ReYSRGHMLf8Wx2X3Jv3prcCS1qYdhJMHvcvEhK2Z9+GYPjfOTlFkNJmuDz6ppUkCV
         0xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313148; x=1719917948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap+EbCgWJ+AJvWKstiQPgmG/qtQmcsmJ/Rrhaee2O1k=;
        b=L2VN6lbGwxOcYpR9VuTOwDl1TZ7FAIHK42hGo3InGwt/a9N2aRYcnfdES1IMLZoMjS
         evxh3gTVdvVCOv8teKxJzWsoBNIduE6zz10g6G8forqIqgn4iHMi4543fmMc9+lCCCx5
         kailN5rbBmES7QiKiTh1MDVcuNgkOiJc8t0YPrMeabi41kdWuRCGe3dKu9IWm1XzlpCH
         Gd17Lsk2mMzJHvUmta8Ssb2ro9xooANqXkeEbbODcgNavi4q4hQTZaKfnZH8ACwsbEC3
         eyBn4hmkCrizhQRU/QYsV6hC7wUo+pfsqB6LaiYQ/j8ir29uFWQsYp4ZVjg5HSnSIA0U
         SqWg==
X-Forwarded-Encrypted: i=1; AJvYcCUCO8q5BIgrLh/MszrMS/CgQ3SXs35aP1ZBALjQ7yjpslwYXFjlj719yReGWCEXW2qko58BEDQr308jB+R3PYFRhQMFwteHeU8wLIKG
X-Gm-Message-State: AOJu0Yx0+k4wUzogkF9OXjZTAEhMVQ8VB3gy2Jo6gINW+aeonCJs5IDn
	Ljm2T6CoZ9neD5C1dgQcV9R8HalC/elKyuwu0drOdtS15W70B/y7yIKPR1IC6is=
X-Google-Smtp-Source: AGHT+IELfo9Wd11H6BpCcjeN9tYgLU03zzvea5ZVbA5djNJEU8H0AMfA61zaxu1gPBk2a1ekKNglcQ==
X-Received: by 2002:ac2:4c39:0:b0:52c:8c85:cb46 with SMTP id 2adb3069b0e04-52ce064697bmr5438180e87.64.1719313148440;
        Tue, 25 Jun 2024 03:59:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cec5923a3sm211365e87.96.2024.06.25.03.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:59:07 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:59:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Keith Zhao <keith.zhao@starfivetech.com>
Cc: "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "rfoss@kernel.org" <rfoss@kernel.org>, 
	"Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"hjc@rock-chips.com" <hjc@rock-chips.com>, "heiko@sntech.de" <heiko@sntech.de>, 
	"andy.yan@rock-chips.com" <andy.yan@rock-chips.com>, Xingyu Wu <xingyu.wu@starfivetech.com>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, Jack Zhu <jack.zhu@starfivetech.com>, 
	Shengyang Chen <shengyang.chen@starfivetech.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 10/10] drm/vs: add simple dsi encoder
Message-ID: <u7zx25g7zwf56unal4qwgh65hmjydfa7d2vnbgwxnulygtcj3w@uicmayewp4r4>
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <20240521105817.3301-11-keith.zhao@starfivetech.com>
 <cej2d72e6bacbjabyjecoqhjlhz4sxx4bgn2w43rgl3cfyyuwt@jq5kq4egj2wo>
 <NTZPR01MB1050AA3ABA20F736B1756E04EECB2@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
 <b7cgvgh3uphpa3byf3bdl5i4fr64zzuagxg5txuwx7woy56dkt@uhclfjtzejfc>
 <NTZPR01MB1050B4B8FA6F36267A1DBB01EED52@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <NTZPR01MB1050B4B8FA6F36267A1DBB01EED52@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>

On Tue, Jun 25, 2024 at 08:33:48AM GMT, Keith Zhao wrote:
> 
> 
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: 2024年6月24日 5:11
> > To: Keith Zhao <keith.zhao@starfivetech.com>
> > Cc: andrzej.hajda@intel.com; neil.armstrong@linaro.org; rfoss@kernel.org;
> > Laurent.pinchart@ideasonboard.com; jonas@kwiboo.se;
> > jernej.skrabec@gmail.com; maarten.lankhorst@linux.intel.com;
> > mripard@kernel.org; tzimmermann@suse.de; airlied@gmail.com;
> > daniel@ffwll.ch; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > hjc@rock-chips.com; heiko@sntech.de; andy.yan@rock-chips.com; Xingyu Wu
> > <xingyu.wu@starfivetech.com>; p.zabel@pengutronix.de; Jack Zhu
> > <jack.zhu@starfivetech.com>; Shengyang Chen
> > <shengyang.chen@starfivetech.com>; dri-devel@lists.freedesktop.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v4 10/10] drm/vs: add simple dsi encoder
> > 
> > On Sun, Jun 23, 2024 at 07:17:09AM GMT, Keith Zhao wrote:
> > > Hi Dmitry:
> > >
> > > > On Tue, May 21, 2024 at 06:58:17PM +0800, keith wrote:
> > 
> > > > > +								  "starfive,syscon",
> > > > > +								  2, args);
> > > > > +
> > > > > +	if (IS_ERR(simple->dss_regmap)) {
> > > > > +		return dev_err_probe(dev, PTR_ERR(simple->dss_regmap),
> > > > > +				     "getting the regmap failed\n");
> > > > > +	}
> > > > > +
> > > > > +	simple->offset = args[0];
> > > > > +	simple->mask = args[1];
> > > >
> > > > Is the value that you've read platform dependent or use case dependent?
> > > > What is the actual value being written? Why are you using syscon for it?
> > >
> > > The syscon is used to select crtcs binded with encoder, If this
> > > encoder binds to crtc0 , set the syscon reg bit0 = 1 If this encoder
> > > binds to crtc1 , set the syscon reg bit1 = 1 (0x2) Maybe I can do this
> > > by the possible_crtc instead of using args from dts
> > 
> > If this is a constant between your platforms, it should not be a part of DT.
> > 
> > >
> > >
> > > >
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static void vs_encoder_atomic_enable(struct drm_encoder *encoder,
> > > > > +struct drm_atomic_state *state) {
> > > > > +	struct vs_simple_encoder *simple = to_simple_encoder(encoder);
> > > > > +
> > > > > +	regmap_update_bits(simple->dss_regmap, simple->offset,
> > > > > +simple->mask,
> > > > > +simple->mask);
> > > >
> > > >
> > > > A purist in me would ask to have separate mask and value to write.
> > > Understand , will avoid this action
> > > >
> > > > > +}
> > > >
> > > > Is it necessary to clear those bits when stopping the stream?
> > > No need to do this , if clear those bits , the encoder will point to a
> > > unknown crtc
> > 
> > what are the consequences? Is it desirable or not?
> There are two crtcs.
> Each display terminal encoder can combine any crtc, depending on the value of possible crtc.
> When the bit is 0, it means that the encoder matches crtc0.
> When the bit is 1, it means that the encoder matches crtc1.
> The possible crtc of this encoder is 2 , the reg bit is 1.    
> When the video stream is stopped, if the bit is cleared, the result is that the encoder hardware points to crtc0, 
> and the encoder points to crtc1 based on the drm framework(because the possible crtc no change).

I'm not sure if I understood you correctly. If it doesn't disable or
disconnect the encoder, I'd skip that in the .disable path.

-- 
With best wishes
Dmitry

