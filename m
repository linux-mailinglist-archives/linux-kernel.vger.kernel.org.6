Return-Path: <linux-kernel+bounces-201572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBAE8FC031
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E2B1F24AAF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150E14EC6D;
	Tue,  4 Jun 2024 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMM1Q+vm"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69F14D2B8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544973; cv=none; b=hlt4G1Flgy0yAQABrxtISnwfG4DXWSQxWziT8TlJMa1XAAlwjwPHkHYvh2wjEbsJQI849/8q3Sio/dDz30IqIvCJUBzNhTxqy+UexRAkzdh0ybjVwB0GRJypFOMvRczxVI5Fpb7uQKXenJiFlH4huwntVtBUlBb9XtnMl/avJ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544973; c=relaxed/simple;
	bh=wwaaPx6QWt15nHSdqWTKXp6nXVK1oyhFcBxCNFquLTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JglWgKhHUO/B985awbeNSHEmBFAeLCiSt0+Sh3p28Dy5vvW4iiD+7OBCN1W8YXx5tMD1TOM8jWIA+mL3ABe9EkFp8p4xeF1/qd/5iz+tj1mXU6vdcsUrr0MeGSA+q+/hmBFa7kCesH0l5hW0NstC5sEkjWy3yeGo5CTkYSJE410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IMM1Q+vm; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaafda3b90so35899811fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717544969; x=1718149769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYlsPq/Nl2a6jpBnYLpUuE7MhnCmlQ2CakctggIcvoA=;
        b=IMM1Q+vmn6OC2+46T2IyUDCh8tOSlLTaRZdx1GStHpngJdpQS/ElC92goOH3d1XxMW
         tXMzTfs4e4R5OTe7r5J/adPPEh1xHdQhHNgktd2F52PUWIn8JUj6z/iktssr8hmD4b8J
         xl1GMWBHhDOhUWw1lYk3CHLqXLoyYmwlWhiQv3kYcNTGNufYqHk9EYAwTCZldDP11hUs
         635JW959ee9uWLoD6Yi+GseAO6UXk+RIuPR09C5hHadyLD1o8O1T6F4tPNVrUs1NR/PZ
         QMtlF0aR/eQm89IiBU+AIfDou0eGEaZEleIkWABvO+emRly4wXNtJiF+LABTI0dybYVu
         roOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544969; x=1718149769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYlsPq/Nl2a6jpBnYLpUuE7MhnCmlQ2CakctggIcvoA=;
        b=Vhvl3vRmXn5ISQ5P4aINHYXrHgL122k7CzGKQMMEoX218VW/20JrAqDjDUkEjNP4xq
         ZZxjUdMAdEmMjoSEESAB1I+vDEb81t8D3rOJs+0vCY+IBQvLVtcjWlLdgstk6Ae3DfGM
         OhKoX+qXxGjnUikFjb2ZkR93IpTEwsaH6gTw+I87XnHjg1TtGDqcVlxkXC7H76yV/9ay
         gzEkYKF0N/AuCqVPnct6TjptUlOtbrHR4tB/6vOuMyB2jF+EB3qpsZNeQAVfmYFI5Wjt
         n0r8zYraQEMslfCfN9w5uItFeFRWhT5yA6ovldzappLECOpSXpSSBky/4BQmjX5DpsqT
         tMEg==
X-Forwarded-Encrypted: i=1; AJvYcCVDVRGnZZEiJeXC4LOLyqxKPF/7LVcIbMLUaisiqjQmwSxgAZj7B90iLdh2A8N3alPqyM7ILy4szB4eVhuG9ahpgwVwIfnaE0LfRCgI
X-Gm-Message-State: AOJu0YzPywFU/EIo0xwvq7iDBrdW2ltynqkF9Xndyr+NnIZk0NqJhy6i
	3bWbgmaSmK3y8n0ZHfFmKfiN2XugWYP545pV6A92IvMGPFWcnrSvJRuoR3k4dtY=
X-Google-Smtp-Source: AGHT+IEqt/1E9UYfq6hr7NwOOCvGfJFrmEaHjn1YhWsPZoauNt3zoMgMqQ+4sf+zBHTn4FHcfvCgIw==
X-Received: by 2002:a2e:bc08:0:b0:2e9:5011:f6b1 with SMTP id 38308e7fff4ca-2eac7a73140mr3969551fa.42.1717544968775;
        Tue, 04 Jun 2024 16:49:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cc65cbsm16085851fa.73.2024.06.04.16.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 16:49:28 -0700 (PDT)
Date: Wed, 5 Jun 2024 02:49:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Yao <markyao0591@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>, 
	Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH 00/14] Add initial support for the Rockchip RK3588 HDMI
 TX Controller
Message-ID: <ymccadqprkxlvhv6ekyqr7utsgejxhqmxlki7nh23htgktlynl@7upjoc5whcy6>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <a5jlj5hncv2p7lxk6pbgynkqfovlg3lzz2muzrbrkd73afiopu@n5tmd4zfyeik>
 <892b2070-2fd0-42b2-a8c2-811dc7382b0c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <892b2070-2fd0-42b2-a8c2-811dc7382b0c@collabora.com>

On Tue, Jun 04, 2024 at 10:44:04PM +0300, Cristian Ciocaltea wrote:
> On 6/1/24 7:32 PM, Dmitry Baryshkov wrote:
> > On Sat, Jun 01, 2024 at 04:12:22PM +0300, Cristian Ciocaltea wrote:
> >> The RK3588 SoC family integrates a Quad-Pixel (QP) variant of the
> >> Synopsys DesignWare HDMI TX controller used in the previous SoCs.
> >>
> >> It is HDMI 2.1 compliant and supports the following features, among
> >> others:
> >>
> >> * Fixed Rate Link (FRL)
> >> * 4K@120Hz and 8K@60Hz video modes
> >> * Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
> >> * Fast Vactive (FVA)
> >> * SCDC I2C DDC access
> >> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
> >> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
> >> * Multi-stream audio
> >> * Enhanced Audio Return Channel (EARC)
> > 
> > It would be really nice if you can take a look at using the HDMI
> > connector framework (landed few days ago) with adaptations for the
> > drm_bridge / drm_bridge_connector ([1]). Your comments for the
> > drm_bridge patches would be defeinitely appreciated.
> > 
> > [1] https://lore.kernel.org/dri-devel/20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org/
> 
> I will definitely check and try to use it, but I'd rather wait a bit
> until this gets stabilized and focus instead on the mandatory changes
> required to upstream this driver. That's mostly because my limited
> availability and expertise on the matter, while trying to unblock other
> work depending on this.

Ack.

-- 
With best wishes
Dmitry

