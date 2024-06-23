Return-Path: <linux-kernel+bounces-226425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D526913E3B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47F8B21331
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE10D1849FB;
	Sun, 23 Jun 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sas6q+mx"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91626ACA
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719175974; cv=none; b=svmaWMzmJbvUswR4Vt49/Lj1AZWKCOxST/xZt0pXm77mX1hmadPb/1njeip6mAE0qFHrp+6e8qO4inZxaZoKK3MvQHoencXe7dN2HE/DE12x2w24mNInwLKvVW8w7cTYyaPGM2QYtBZjbFKTndlBJx2JchTP1qFBDJ+YH1HIpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719175974; c=relaxed/simple;
	bh=NPxalwkxWB39X2rpA0eQNy8cn/fkGWhtgk10S0tZbGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHUOdeu+hk6G5HWi/l5v9NyFwtxVY0PJWkyFIgTOPf1L9TI1YGVXkVygiR3QtyQfT18L5S+5O41POS8CJh1h/yFQ7v9bxx/7D/v3Bwbmjt4rxUz8o8OjsE9NHowHp36O1FUmvrxrakRrdxcZI/n1+VwgonOuAiGsduf75Gg5KDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sas6q+mx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso32175661fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719175971; x=1719780771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7uTo3ZPUx3K0rhi8+9SzsYcK1LXS9wxsvZyOU1ivZAE=;
        b=sas6q+mxGDBAcy9H4BWNvRUGMwqYqeBrya2ApTziKXrDsirCM0kFaIE6LeeHixQQwj
         1tedP20BDGMh4zOIxPcYKNN5Wsk0uh4Nd1zBuu0ffXQADS2LhOXE8ad13gRvc57qkLD4
         zLHqgG9nGkWzCpxvLQnnr5F3b78c7Z07nLzm/PmUJ2KTFZUKdqVx7kwDe0qwu0XoThA1
         PFMy31m19ob/hYjPHRfc9nVr+6aCCaU5Av0+918YDl4LkzT1Al0oAKtXA1Lzbh4uvVWf
         /DcyLvWQyVDbNRYFOBe96wMPU6HrlpN7G/gyWgN/Go27Jjf4BJkvSwrhFxJW3JbMfi0c
         rLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719175971; x=1719780771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uTo3ZPUx3K0rhi8+9SzsYcK1LXS9wxsvZyOU1ivZAE=;
        b=lgZiqU4lmovRFswisq2qS2JACKcfSphYig6OgQFaHtu+arpkmfSHe2ET7TBYyYuQ1A
         7VrRubfWRkze7bFIpi/zIV9ourt/o2mxWiYKIdPDx15psnE+TVGjSvPkgUoTHlSADhSR
         0u9RzcSpyjT/VUxN1ttaV0s2dBdWXX6o+1Qg/LLsBv369ajqT0w43IcX0brUwSp4zDV9
         rkfzwLq/EOT0Tu8u1+Vjfzey8eMbJC4SZAhCmHtu7HcluCtcRHbkfMe2pnBRCivm41xt
         rKUY2HHRL/SsvAKcKp1FBOX9wcZzxodfqz+T3Zks0/UTzkKvGC3aDiU+wAhlRYEh4jiL
         ja+w==
X-Forwarded-Encrypted: i=1; AJvYcCV4hLrPM1qBjxHzNZZL8leB4pMTBAxFbMeHuQNh7fmQ5bsR9SRvlLexgxSMEN3HW55jW/Wyervgd1HoapT96ADI7IBhwikzwanNPnxZ
X-Gm-Message-State: AOJu0YzNdLkrB7v/4g52s5BOLD/axUGerKScy5mbNowMhit2BjgFr/7E
	uELBJk6BKGFmn2v3l2xQG3MyH9JK0toWtwDA34ldI8bFotW6PXp8aiiXWVeoAws=
X-Google-Smtp-Source: AGHT+IHOdvwlm/V74XgOSUz/yzIxVY9cnm339PgJIGCdcSGcuh23BD7ELQkWwC/H5ZAyl+yMDB1o/Q==
X-Received: by 2002:a2e:80c4:0:b0:2ec:4d82:9e96 with SMTP id 38308e7fff4ca-2ec56caf832mr12068771fa.23.1719175970544;
        Sun, 23 Jun 2024 13:52:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4de2dbc4sm7824561fa.73.2024.06.23.13.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 13:52:50 -0700 (PDT)
Date: Sun, 23 Jun 2024 23:52:48 +0300
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
Subject: Re: [PATCH v4 05/10] drm/vs: add vs mode config init
Message-ID: <nwyeptrjhpmpnvwrexjebkvsl3dudgao4w4lnm3srs6ahmjwjr@6mdyw6kvtbag>
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <20240521105817.3301-6-keith.zhao@starfivetech.com>
 <ttjuehs6ui4dsnexhhodfd22okujx55mof5svxuk47gizhkv52@kdbdvwsamz6i>
 <NTZPR01MB1050281A0007497AF8606662EECB2@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NTZPR01MB1050281A0007497AF8606662EECB2@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>

On Sun, Jun 23, 2024 at 07:17:01AM GMT, Keith Zhao wrote:
> Hi Dmitry:
> 
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Please drop such headers from your replies. A simple "On 1st of January
John Doe wrote" is more than enough.

-- 
With best wishes
Dmitry

