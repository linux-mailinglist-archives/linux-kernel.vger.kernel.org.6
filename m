Return-Path: <linux-kernel+bounces-252546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132BE9314FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CCD282BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F91318C33D;
	Mon, 15 Jul 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJHFa6yu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2363318C19F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048109; cv=none; b=tdbDq7U8w69Vzu+qc2i4MHaMIaI1DLE/1MMrLoHz7ORAk4ySbQzQiKEJqAde++GAmSlj+xQkcpkt1VpN13h398k4ajhtcUHbv5vRtEzXfTiMhFVXZ78f5rKs+e0b2IK+yKhZZAHnC9+PqjrG9c3cSgGVwyjxU3hr9nFWRQ5zoZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048109; c=relaxed/simple;
	bh=zxjn8Ies8hbdduPV97Mi32mWBnX9BtuG8RYZ9bOlCDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJwboprFpPk8+h/bqJfQYDcyur/BJqSmDj22FlwvKd/uFwRC+MnicjQlUfDkLUD6XdBJqAovon6tsOrl2y1bjQxMyarwR6J/AVCeinHIHTkmUwDqWhaOos3e64j1oWKERb0RQLulodEb/X4HBnkNeCfnCgMJPfu4TKhUnKuan9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GJHFa6yu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so32996385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721048105; x=1721652905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xD+Qv3tXsMOBLCom0uRSOSXVlQMZrezJqRHpcu3ciB4=;
        b=GJHFa6yu+AlmUDNLdXlfGbOyl81GlU674mWXP7kJfh1jyfeSu97YKr8QW5tMnVyshC
         tYKRQ8fgFUpnY4Wwt9rL2dDg9Q/eueAfto9vR3FlVCSrpxJGR2lipMqcMDg2BPwJT2v0
         t1vqVCKXoImJpC+AjQosj+dNn2YclnpWuDbkfb+ttDvbf+YquuhtR1Al7kUj13FyvZIs
         dSYrJuSuJNLwpcLS1w+S9wUmZ+4Vg/GoVgGEDpb3GMn/INXX5s+0Txw+ikqlVtBDgsNW
         e+wVsSQe2GyLWa4Ta9AIwrjOFxs/XC+RTKodj7cksgv8R0uqdJe8xF8zAAw9hrQ1OsjV
         197w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048105; x=1721652905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xD+Qv3tXsMOBLCom0uRSOSXVlQMZrezJqRHpcu3ciB4=;
        b=lTQWNVgB2ZcUFWtEmbGhe11JLR58B9/GroEgHrJwhrZ0DWOgBFulTYGTqZDcpRna1s
         LE+Wv02ulhMg+M176L5QcuNHLiTTW+DW/2BmttF3GiqTmkDmtDkD13jaEbHddejjfWl7
         qrAGgcSqaUEWB44NPCFuyGhI2J8Glavo7ngbCJmN5CBUw3beJxyQAHGlLq/OswcGjSpb
         3j16kb4FRdEz2UzFfTVgb1FJHbQ3zRFDBdgv/V9a6HQd5MYUzZHFe1zgoflyI+js2oCn
         033QGFxaODPus0et3xOI+YuF6q9Lj8mdKlM2eY539XxjPFyg86U4IqKnlsR1uPHTOk4U
         Mp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbatuqoOBOks2CDcyXfIYOjgPpAa7NlBGjwAd5vMADGChvVh9S6oJyyKP4XVtOtkEEcp5Qj5AQ4/Q9hGlWZCWf6ou402/GVSYXAk4+
X-Gm-Message-State: AOJu0YxGMPPmXggecQ9A1W5EnA9/ZV6ziNXE82conxrDAUjSslcYi7ou
	M4qU3vb35WKB4kWxeXkjJW5LyI9C5JuvLT60D7SYOtR9cZeVfIshj5hwKjOiHPU=
X-Google-Smtp-Source: AGHT+IFVvTPewQl9xsuC6PQHCLCw7VPZ3EYcEq7OprdCTajdkMctnkeRvosj+jwyjRqqLqq4veQmFg==
X-Received: by 2002:a5d:6981:0:b0:367:9903:a91 with SMTP id ffacd0b85a97d-367cea45c68mr15872686f8f.11.1721048105426;
        Mon, 15 Jul 2024 05:55:05 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:82fb:4328:f644:289a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25abf0sm121761985e9.14.2024.07.15.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:05 -0700 (PDT)
Date: Mon, 15 Jul 2024 14:54:59 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/4] Revert "drm/panel-edp: Add SDC ATNA45AF01"
Message-ID: <ZpUcI3KkIa58zC55@linaro.org>
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
 <20240715-x1e80100-crd-backlight-v2-2-31b7f2f658a3@linaro.org>
 <7daa3c0d-cecf-4f50-be32-ae116b920db0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7daa3c0d-cecf-4f50-be32-ae116b920db0@linaro.org>

On Mon, Jul 15, 2024 at 02:42:12PM +0200, Neil Armstrong wrote:
> On 15/07/2024 14:15, Stephan Gerhold wrote:
> > This reverts commit 8ebb1fc2e69ab8b89a425e402c7bd85e053b7b01.
> > 
> > The panel should be handled through the samsung-atna33xc20 driver for
> > correct power up timings. Otherwise the backlight does not work correctly.
> > 
> > We have existing users of this panel through the generic "edp-panel"
> > compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works only
> > partially in that configuration: It works after boot but once the screen
> > gets disabled it does not turn on again until after reboot. It behaves the
> > same way with the default "conservative" timings, so we might as well drop
> > the configuration from the panel-edp driver. That way, users with old DTBs
> > will get a warning and can move to the new driver.
> > 
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> >   drivers/gpu/drm/panel/panel-edp.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index 3a574a9b46e7..d2d682385e89 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1960,8 +1960,6 @@ static const struct edp_panel_entry edp_panels[] = {
> >   	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
> >   	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
> > -	EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA45AF01"),
> > -
> >   	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
> >   	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
> >   	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
> > 
> 
> How will we handle current/old crd DT with new kernels ?
> 

I think this is answered in the commit message:

> > We have existing users of this panel through the generic "edp-panel"
> > compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works only
> > partially in that configuration: It works after boot but once the screen
> > gets disabled it does not turn on again until after reboot. It behaves the
> > same way with the default "conservative" timings, so we might as well drop
> > the configuration from the panel-edp driver. That way, users with old DTBs
> > will get a warning and can move to the new driver.

Basically with the entry removed, the panel-edp driver will fallback to
default "conservative" timings when using old DTBs. There will be a
warning in dmesg, but otherwise the panel will somewhat work just as
before. I think this is a good way to remind users to upgrade.

> Same question for patch 3, thie serie introduces a bindings that won't be valid
> if we backport patch 3. I don't think patch should be backported, and this patch
> should be dropped.

There would be a dtbs_check warning, yeah. Functionally, it would work
just fine. Is that reason enough to keep display partially broken for
6.11? We could also apply the minor binding change for 6.11 if needed.

I'm also fine if this just goes into 6.12 though.

Thanks,
Stephan

