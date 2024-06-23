Return-Path: <linux-kernel+bounces-226445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAB0913E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4001B20ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4218508C;
	Sun, 23 Jun 2024 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+8/Hpeu"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237465A10B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719177075; cv=none; b=Ymb2gfp9pM2+jYIkpBRR6pt33c3msDHGOFs6Vi2M96L/0H25fdkULW1HGqI4w6Ermy/xqDf1NN9htKTFmkrr1XTnplxnJacnUYYQIdwJ8ToXtCOb3tNJZfKsP95JSzgmhRdXP5NfWj271rIL0O/Zr/Vo4o1G6PKwviIMoeLJhLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719177075; c=relaxed/simple;
	bh=OcLrQP06EcGuhvHpTufgk8lLRZY/a9BiV8zgE6Bh05w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzPOcd3nTFHV3RS5JNMEpeRYjm7bGX1B+cAsv6nk59zrn5RVlzJiT5DbiYKY68Zfm/ER+AgkUigEMINoUrgo3ki87Ygexgc5nyOH26X8Sxb1ODI7pEMRFFgMN3cUNT/YLR30zXRmtRF07VZb5zy5GHhd3J844ld5ENYrRTr326Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+8/Hpeu; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so45959601fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719177072; x=1719781872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByUUhCwfU2MDkfN+tsDGtjdI+tw+lqDmSUekMY87cx0=;
        b=K+8/HpeuwLG6heybFPuA3ooYcoWRJkfC2ttjtwO4IUPdgslfw65gHjA2QxgQS+vQnC
         a+o9pQ4yrBSAAFPPtkW7hTC1UOXTRdnaOIju+mBp/suqOJk0MDFTj2frNKwE+80h/cM4
         JyXRgz3940n4NbuYb0qpkR9uubfCpTtu08/Orh2v/eARRO0hwIAgixkC8IhqIy3NMt4C
         /V9If1PVByZK161/ih4WUM3IF4Nb7csPF8jJh3Xw3XAqBLnk/C2P4394tUhBuT4aJRUQ
         ANmVcwm7aX2UrLZqTwRz5IsxLOvToMM0NlrNqPpLC+BXg1qslqsvPjhLom/vBuG3CwzP
         D0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719177072; x=1719781872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByUUhCwfU2MDkfN+tsDGtjdI+tw+lqDmSUekMY87cx0=;
        b=OTSBi4sDREbprdeQ3KYOm5D6szp/jUYzEEPJQDhHqB08zjysLUi4HvttRNlp/tZLLc
         P9ZwHnudhRU0DsahGkKhZU1Z19GMtVliRQ1g/y2wSb52JTCM5Dbj/4KI9OAbnn82/ZDu
         yoN7iNpL+c+0itGj9YrrkgrZWDTY6L7U5WUKRkCJQC0TSAHZN0y9oI7dF/jveS9Pw+0A
         5yB9mDJrn9mCyDc67rUmfeNKMgQc5WcVbEVJyWRJ3+DiQkaU88dw0L9Tf10RtzrALjAq
         iOIg0ZvXZZHNncrfEovxCL6xVJprln48OV3jWfRoeaoGRH2/JOLNPfzGDzDU4Tf3OnWv
         4UEw==
X-Forwarded-Encrypted: i=1; AJvYcCXfn2DOFmS9MhAK//60OVl4SBcwBK74CdXQIb8qOvOtePAiD4BwIBXrt9XqNpt4FY5zqLCjt6hSyN2/2Nbu5Tvbwj2a7782hR8rkpW1
X-Gm-Message-State: AOJu0YydWNjl9IllzYlqpchhf/yO4r8PLeOStdj7vFA0F0YV4LdSYrBG
	pK47qOtFdu+RIP3EZD/j+eMTNfSZ0ZO7pvdT70NjLYe0B5cIqCPR2FfERJZERFg=
X-Google-Smtp-Source: AGHT+IEaaLlfXAyaLl1Y4kuJEtYqkzCxQXOHpE49n+OtSlW6/0hqnpQnYKiS/rm6UCOFGOmz2RVcYQ==
X-Received: by 2002:a2e:854f:0:b0:2ec:49b5:50d5 with SMTP id 38308e7fff4ca-2ec5b357a00mr20958641fa.41.1719177072228;
        Sun, 23 Jun 2024 14:11:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4db2ad8bsm8094331fa.85.2024.06.23.14.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 14:11:11 -0700 (PDT)
Date: Mon, 24 Jun 2024 00:11:10 +0300
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
Message-ID: <b7cgvgh3uphpa3byf3bdl5i4fr64zzuagxg5txuwx7woy56dkt@uhclfjtzejfc>
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <20240521105817.3301-11-keith.zhao@starfivetech.com>
 <cej2d72e6bacbjabyjecoqhjlhz4sxx4bgn2w43rgl3cfyyuwt@jq5kq4egj2wo>
 <NTZPR01MB1050AA3ABA20F736B1756E04EECB2@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NTZPR01MB1050AA3ABA20F736B1756E04EECB2@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>

On Sun, Jun 23, 2024 at 07:17:09AM GMT, Keith Zhao wrote:
> Hi Dmitry:
> 
> > On Tue, May 21, 2024 at 06:58:17PM +0800, keith wrote:

> > > +								  "starfive,syscon",
> > > +								  2, args);
> > > +
> > > +	if (IS_ERR(simple->dss_regmap)) {
> > > +		return dev_err_probe(dev, PTR_ERR(simple->dss_regmap),
> > > +				     "getting the regmap failed\n");
> > > +	}
> > > +
> > > +	simple->offset = args[0];
> > > +	simple->mask = args[1];
> > 
> > Is the value that you've read platform dependent or use case dependent?
> > What is the actual value being written? Why are you using syscon for it?
> 
> The syscon is used to select crtcs binded with encoder,
> If this encoder binds to crtc0 , set the syscon reg bit0 = 1
> If this encoder binds to crtc1 , set the syscon reg bit1 = 1 (0x2)
> Maybe I can do this by the possible_crtc instead of using args from dts

If this is a constant between your platforms, it should not be a part of
DT.

> 
> 
> > 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void vs_encoder_atomic_enable(struct drm_encoder *encoder,
> > > +struct drm_atomic_state *state) {
> > > +	struct vs_simple_encoder *simple = to_simple_encoder(encoder);
> > > +
> > > +	regmap_update_bits(simple->dss_regmap, simple->offset, simple->mask,
> > > +simple->mask);
> > 
> > 
> > A purist in me would ask to have separate mask and value to write.
> Understand , will avoid this action 
> > 
> > > +}
> > 
> > Is it necessary to clear those bits when stopping the stream?
> No need to do this , if clear those bits , the encoder will point to a unknown crtc

what are the consequences? Is it desirable or not?

-- 
With best wishes
Dmitry

