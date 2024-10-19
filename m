Return-Path: <linux-kernel+bounces-372900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE27D9A4EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CA91C2434B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C18648CDD;
	Sat, 19 Oct 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAcmgmQV"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA458222
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350718; cv=none; b=IbvxPoXhP/8uDI9f+BxjUwFoLxlCmrdUynjm3bpKOHtjQf5Hbkt80qvFvCHuC+GHCYni0t5EEmzU73DPX3fVjvYVG6rjX5THkEAgkygV2XgxBZksPENngIpG8Ak7U+DgwY/18tlh4F2Kv8BJVPwOneCFCtEtcLy0pMq7sdO2Aow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350718; c=relaxed/simple;
	bh=5W1Ycz1TWR5v0miD79I8aWCONwKzQgRpNE2SdDTapUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYfabd/JdjputJTB31VFPEG1xd/arO3P0jZ3WEqlN+g1LKZmhXoIfcyCOT1q/1gVCFBLoJamCgt9IUCxevfN5XINRLSU1QBOCwYQMHPvrx0FyqcJptL3ywLz2tePtTTet0I8zC38RBHiPOm8NVgZ9rICst6c8VCZiM97tYq5TYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAcmgmQV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e4b7409fso3069406e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729350714; x=1729955514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nb/Hai4/ZFPWWuvb61BWUzY8KGM98YH4lS2Tuv7vwwU=;
        b=AAcmgmQV5UbMyosEODAkZ9g+m5AFlSdCw5z7l6sNxQJZwv4J7wRnws92AtuwetREdf
         fYdGv1ujdcP0xpMOw/XHmWG8mlkutGknccxrcEDfIPAcuULlc5skxLk2TUuhwTiC19ej
         Uqq/GP6hk9AJzqQQy2agl/7OqFjMsHp1/r7OBB7pYVM4bH2Nvb/NFowO6YlYVBS7uF3q
         fdNPxH2Sgp/VSdRdayBglV1ptbAHmEh8M8m32QRd8PlzQmcKBBXL9cn8qgr/aoLyHQA+
         06TXO2BLA9gvOkMPvxXnVv6+hGwPOuVQsisSPP29TmLgFZUg0W2RDJqJaBkKsv5sPCOw
         keSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729350714; x=1729955514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb/Hai4/ZFPWWuvb61BWUzY8KGM98YH4lS2Tuv7vwwU=;
        b=nAs9GBtC3DGIxAZ5In+eHkfJBRiRshDkEgZkIV1cJJQKKHS4L7mv4YnwWW/Xhck7SM
         CWdY486/2CEwnfECfFmtUuiRCxNGadoUjOJddeoT1pIvCVK5XlzeA9MzTa/ViDdsITGG
         04nGBMKzvM3CI95ping01TjHZqRRb4qSQsNyXDiSAkngAOQuqwxOaY81XBqXGYlLyTps
         8y7oEGrTndLpYsAlAGjhN/5eDyELowt0HQQ7KMEGKj0ns8hfWt3v1QvacicLdOCRtycl
         8DRvArSPpBUmc2oYbzJfC5D/sse8nAIozthNDb2/P311mB47B6f03F46xtoUb0GnCH1z
         GQEw==
X-Forwarded-Encrypted: i=1; AJvYcCXdShEtCvLADiaofO4XdjGGv2YBnDIRs8UvqO3OG+MYzSp8BKSGsDmBz5dHvngH1t5QRWVT/wlOM3EfBec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWupQMslhtbY83w/nf/DBtKAjQUbr99XUaOMdLOhq17R5fFRk
	JTPRtVoFYHhT3vfcmhu09+S6UMC58fgAGD2LNTW1pW6pQhjswTI/rlkGTNCN5Mg=
X-Google-Smtp-Source: AGHT+IEpTyjPk7DvbEShcUaeYyGDz9czzrSWTbsRLCmDec44UsUXygtFMkhSHXOFLJ9ciGGl8Iw11w==
X-Received: by 2002:a05:6512:23a5:b0:539:f922:bd3a with SMTP id 2adb3069b0e04-53a0c7525aamr3223014e87.25.1729350713890;
        Sat, 19 Oct 2024 08:11:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15211a8fsm551733e87.261.2024.10.19.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:11:53 -0700 (PDT)
Date: Sat, 19 Oct 2024 18:11:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	dri-devel@lists.freedesktop.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: also call
 drm_helper_hpd_irq_event
Message-ID: <yc43bbhfcc6nnrgxke2khkgcxxpt7mne2vmrggpkkc7gdwet4e@prpfb2wpgs66>
References: <20240923074803.10306-1-lists@steffen.cc>
 <20240924184335.GJ30551@pendragon.ideasonboard.com>
 <e4626c1d3b28613d1d219c735bcd8525be0f0d9e.camel@dirkwinkel.cc>
 <20240925163609.GD27666@pendragon.ideasonboard.com>
 <6cea659387e14f0436105053416a42c4729923b3.camel@dirkwinkel.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cea659387e14f0436105053416a42c4729923b3.camel@dirkwinkel.cc>

On Wed, Oct 09, 2024 at 04:28:26PM +0200, Steffen Dirkwinkel wrote:
> Hi Laurent,
> 
> 
> On Wed, 2024-09-25 at 19:36 +0300, Laurent Pinchart wrote:
> > Hi Steffen,
> > 
> > On Wed, Sep 25, 2024 at 09:54:18AM +0200, Steffen Dirkwinkel wrote:
> > > On Tue, 2024-09-24 at 21:43 +0300, Laurent Pinchart wrote:
> > > > On Mon, Sep 23, 2024 at 09:48:03AM +0200, lists@steffen.cc wrote:
> > > > > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > > > > 
> > > > > With hpd going through the bridge as of commit eb2d64bfcc17
> > > > > ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
> > > > > we don't get hotplug events in userspace on zynqmp hardware.
> > > > > Also sending hotplug events with drm_helper_hpd_irq_event
> > > > > works.
> > > > 
> > > > Why does the driver need to call both drm_helper_hpd_irq_event()
> > > > and
> > > > drm_bridge_hpd_notify() ? The latter should end up calling
> > > > drm_kms_helper_connector_hotplug_event(), which is the same
> > > > function
> > > > that drm_helper_hpd_irq_event() calls.
> > > 
> > > I don't know why we need drm_helper_hpd_irq_event.
> > > I'll try to trace what happens on hotplug.
> > 
> > Thank you. Let's try to find the best solution based on your
> > findings.
> 
> There's just nothing registering for hpd with
> "drm_bridge_connector_enable_hpd" or "drm_bridge_hpd_enable". I'm not
> sure what the correct way to implement this is. In
> "drivers/gpu/drm/bridge/ti-tfp410.c" the driver registers for the
> callback and calls "drm_helper_hpd_irq_event" in the callback. I guess
> we could also do that, but then we might as well call
> drm_helper_hpd_irq_event directly? Some other drivers just call both
> like I did here. (drivers/gpu/drm/mediatek/mtk_hdmi.c for example)
> For "drivers/gpu/drm/msm/hdmi/hdmi_bridge.c" I also can't find the hpd
> enable call and it just calls drm_bridge_hpd_notify.

The drm_bridge_connector handles enabling it for you when the driver
calls drm_kms_helper_poll_init() / drm_kms_helper_poll_enable(). It
seems zynqmp_kms calls drm_kms_helper_poll_init() too early, before
creating DP chain, so the HPD doesn't get enabled.

> 
> > 
> > > > > Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD
> > > > > through
> > > > > the bridge")
> > > > > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > > > > ---
> > > > >  drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > > b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > > index 1846c4971fd8..cb823540a412 100644
> > > > > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > > @@ -17,6 +17,7 @@
> > > > >  #include <drm/drm_fourcc.h>
> > > > >  #include <drm/drm_modes.h>
> > > > >  #include <drm/drm_of.h>
> > > > > +#include <drm/drm_probe_helper.h>
> > > > >  
> > > > >  #include <linux/clk.h>
> > > > >  #include <linux/delay.h>
> > > > > @@ -1614,6 +1615,9 @@ static void
> > > > > zynqmp_dp_hpd_work_func(struct
> > > > > work_struct *work)
> > > > >  					    hpd_work.work);
> > > > >  	enum drm_connector_status status;
> > > > >  
> > > > > +	if (dp->bridge.dev)
> > > > > +		drm_helper_hpd_irq_event(dp->bridge.dev);
> > > > > +
> > > > >  	status = zynqmp_dp_bridge_detect(&dp->bridge);
> > > > >  	drm_bridge_hpd_notify(&dp->bridge, status);
> > > > >  }
> > 
> 

-- 
With best wishes
Dmitry

