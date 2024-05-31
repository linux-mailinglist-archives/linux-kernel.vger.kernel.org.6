Return-Path: <linux-kernel+bounces-197261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F48D6852
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637DB1C264A8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE117C7D4;
	Fri, 31 May 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9wjN6eW"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681F17C21B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177422; cv=none; b=dQes7RUS2B0VETpGO23Me+vGk4M2I4ASxu/uTL3TCoDsCBBqQwyl6NEM5Q/ZKztksIh7QOkARc4so0KWEgARvStulstisy5fhO4xoXHQKW/sjfbPwcQuTFfaXuvhow8NoKtNjlx3LzlVKs5vgDFrtoEbQUVp0PWCPiT3YcVC4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177422; c=relaxed/simple;
	bh=yazqncsssq1fUNb2/bAmcA/AMNGpD5O3/oksh1jttp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IapVDng95hc3L+xMspzdau/uXP9PGdIoQ3LvJgvf9zbp8pw8nbOzIwV7Q8tvR0yEPYo5At9GV5fcshZFsbhJ0PqQrjnsDvS/orJxRQCr0VeWYR0mmFA+HB3AKtn7tmYGlboKTeXJ9iJLnzCOr3lknFGKKKyvuhxGAL7221YW7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9wjN6eW; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso31728241fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717177419; x=1717782219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++A9eRTepXKaQlX/n7y1YLYk+bRzmeV2OxSEniWyl9Y=;
        b=m9wjN6eWKD0St2AG1ECC6DaelND/LIf+Vv+lL/ghbxctZAdx6IN0/W1ccCBUwRamOI
         9PjC4T0DTkDb2EVtlv9fha6/AGjWPMj64mTyIr4aRi6NHkGWzTMd2pPkJF++iEkRbGJU
         shTalWZmpreLstj9ulBS3NmxmGAxx+NMc21j/g0RAScjQwTtxpLUa+PhPyhcKi9a0BDL
         nb6la93wP8qp1xRtnLndgjcZifBjv5bGk0NRoRJRrPjiNRy/ug9S1gMQmmWJEF/Ke7nh
         sAanEJF2kkO/TZTgrTbcvHmZnsJFKyfyrAn+4zl5G0jDwWNfHIrCxRlU/T8XUdBbKSbi
         x+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717177419; x=1717782219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++A9eRTepXKaQlX/n7y1YLYk+bRzmeV2OxSEniWyl9Y=;
        b=SW+zOAeaXnmFhDLI0Ko4q8d0xUBTb1JyvZGAfvUH2JOCg7/fqafTOQDdDJNHs5L/as
         N8bhzBvu+wlc3KYj9sL4yezDPsb78ngy46zAPENd2S9jdMGjo2SAcbH0HIg//diciReB
         4qN6Gt9O9u4IJNSIg/zx1hwzkWMPTUUnL7TDnqF9icGKuDz+4/2PHzPPx2Jv3ElCd1lK
         HOBzhnASf5ijS/yUfSvTGvnyr5nZLYVSpMPXK63IvWhxM8q6QUTE+7fh4Uhv2GEO8DXD
         PiZtSnfZIIvyXTmBtuScUzr+aJRiRi2xbNcEYan1/442Wi96wXRQPFv73LFgq5p8b0RQ
         /ldw==
X-Forwarded-Encrypted: i=1; AJvYcCWMC0ukvHdFzEZH4ylYxt9VOcLAlOSmxUOjc8YXPVevoNBqSw+Hsuzui3lQ+vxPCldkdVBoVeTL+m3ZeWqa0YMk1+lOXslGXob5wImF
X-Gm-Message-State: AOJu0Yy+00yFsPds8tjMbd09zukvKhJtyviv6F7omb/V4un90wc2oyOj
	CDQSXo/El3npyy6Qmrk+BXTxHNPzSZtXWKiwjjo1T4th2GqPq1K4xpkmTa3KW44=
X-Google-Smtp-Source: AGHT+IFyvYzgg/xDu6GcGjRimu3ZdjRNTdvZZXX3T2C8F9djKPfbZ79k2XyO7ksg7mNcH2hCy7HTxQ==
X-Received: by 2002:ac2:4354:0:b0:52b:404:914f with SMTP id 2adb3069b0e04-52b8958aed8mr1697776e87.34.1717177418909;
        Fri, 31 May 2024 10:43:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b8e43a5e2sm54511e87.298.2024.05.31.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 10:43:38 -0700 (PDT)
Date: Fri, 31 May 2024 20:43:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/3] drm/panel-edp: remove several legacy compatibles
 used by the driver
Message-ID: <6kmhrxip4xb44bspptwdaoqsod5gm7ccr27fn3jr4ouh4jszi4@fuxht25n5wki>
References: <20240531-edp-panel-drop-v3-0-4c98b2b95e3a@linaro.org>
 <7428a2f7-befc-6db8-76f4-3ca8dc12d31c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7428a2f7-befc-6db8-76f4-3ca8dc12d31c@quicinc.com>

On Fri, May 31, 2024 at 10:18:07AM -0600, Jeffrey Hugo wrote:
> On 5/30/2024 5:12 PM, Dmitry Baryshkov wrote:
> > There are two ways to describe an eDP panel in device tree. The
> > recommended way is to add a device on the AUX bus, ideally using the
> > edp-panel compatible. The legacy way is to define a top-level platform
> > device for the panel.
> > 
> > Document that adding support for eDP panels in a legacy way is strongly
> > discouraged (if not forbidden at all).
> > 
> > While we are at it, also drop legacy compatible strings and bindings for
> > five panels. These compatible strings were never used by a DT file
> > present in Linux kernel and most likely were never used with the
> > upstream Linux kernel.
> > 
> > The following compatibles were never used by the devices supported by
> > the upstream kernel and are a subject to possible removal:
> > 
> > - lg,lp097qx1-spa1
> > - samsung,lsn122dl01-c01
> > - sharp,ld-d5116z01b
> 
> Ok to drop the sharp one I added.  It should be able to be handled by the
> (newish) edp-panel, but I think the TI bridge driver needs some work for the
> specific platform (no I2C connection) to verify.

Thanks. I'm tempted to merge the series as is now and drop
sharp,ld-d5116z01b once you can confirm that it can be handled by
edp-panel on your platform.

-- 
With best wishes
Dmitry

