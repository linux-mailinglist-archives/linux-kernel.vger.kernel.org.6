Return-Path: <linux-kernel+bounces-510299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B3A31AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF9C168628
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB217996;
	Wed, 12 Feb 2025 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+hasUA2"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765835944
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321718; cv=none; b=fPggkQQCLB+PbjgXUFCtHmHPtxfvnt/OG++ny15oeJeAZB892lPD3bFhJ1zH5w9ogw6KSNLa6NgutcBljDG6dFc+WYNV7zZRHQJ47zNaA3glaS6rAHKLsh1p/1237UQNt76NxSxeLl/7ZKxnbBmmJnvlKIYR2wNOs/v5+sPbT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321718; c=relaxed/simple;
	bh=jCIurlHM76zZcC+ag0j1ChJ979i5vOv3fvHyabZoXuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgJB4rEKPLD39zCcw43G4WXVJznkwpVdzq84I4UvParEOo928Jl6N9HTI4FtOt/hWbmpBiTyVkNkICOwmYgPeOrizA/maSkPkTFuDldnRNAqlBESz84AtVl6SntRz6kQHTZWCmhWFph5iOtRXH3jwYkQB+0sEFJgMojpoNu9ofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+hasUA2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-308edbc368cso28575921fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739321715; x=1739926515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUxNo4sdmWLVTWOH02xXE+iuTiw7pWWtDZzrPFzNKj4=;
        b=A+hasUA2gaRDwPuRIfLYEVasUS4mPC9f7V3Netd8+6K0fvTjs7Xe4VxxVMoO3GFqUc
         6GHkPO6sKyTYTD+5gPoXpq7uAU+Hk7sz0Irx5LNI6pKmfE4ONdBGwT4dry4usq0BSNH0
         p8HS5rZCj3qtW+IvVqBWwJnX5JQfYBx9PGI66Z/e8jlt3783q8Vll/+KleQyU2afUztU
         tDvXnLS88TGLBPeF1YbGfKiaTsMcODGkv8VzWLNG97g7M4tMW86gWOn96dB5f0rDUQlo
         lIReBqmzqys3x9rTV0WdGjU14KyxMNkU1clOM+lsu2aL7xLf6H36f55ZT4FZZERjLL2o
         /Xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739321715; x=1739926515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUxNo4sdmWLVTWOH02xXE+iuTiw7pWWtDZzrPFzNKj4=;
        b=aki2wBRIeWq05VLVbrC+QpmtPbcrOdcc4nOOAtncF+oAX+9m+dpRVvrPayMl0foL1w
         DgMjWL+eyzMh6Jtoh4Pv/JJ6Hgz4Wx2yub5VlpFwhuAnxnl/tr/QQ27C8IZrTHIfY8Oi
         Qoe1DXYJnVieXrJbvibF1AvipbqsdbmI4d1V+bzDnuCthUizFZbzZu/ksbeKGoNhnyDR
         xWFdNdDALc3RKUpWCnJOnb2PeqBWP00h4nXYVgt6fjSD/v9Trbnzm3LDFeaYm/DPam/T
         gg8rxIFQOC+gnIYfQiFZTT7th9RLwsBrJxRxEP8HfNaXU96mAUI9mnW1n6x4HeCDjuE6
         MPog==
X-Forwarded-Encrypted: i=1; AJvYcCU1SCWRxcqySxqipEGk4UsAyGyWeveJalg2vkLT2efrtqUjz/SWbV+THa4QhLXNHG0jsVj97cpg9a1MbDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/BGZyJXRD0FVYAzsVPcX0zJzRMmVaKlRT8gx35z86hhgBZRm
	XA+NhcP6C611FDFPMqsna2oiilb+t/O5ZRAlUFCi3Cp2+lawa9x8JpZWrN868sw=
X-Gm-Gg: ASbGncvF4Q6ODmyiWWVAqfcS59FvHt1juBjzNsDe2u/jV7qZ8nOnkhpdPq6tDaqAeML
	vTPO+kr6FQS+9HiKq2VFnVQur8oSNNsgO98Xpt9HHC2sbDI1pGCnfYfa4huaF1wcFSgfGncEy9c
	azyNG/wlRfJmkPrzU1laIxaUrZzlQi5HMwbdjo3f5W0EferQZ0N7IKHxRDXC5ph0lOFMNsal6Ba
	+QD3ViWul7syACBvi9hYme1V6CxByC4e59HiRYy5g+nBodj6ABptJ9FwfXNNSItrYPY1VCc6xh1
	6UlZ2X91+1xau6FUXRncily+WUuWNa1IN7Atxuro0w4Jt0nTlWLYUIfPEW/vJbFvSzKtgx8=
X-Google-Smtp-Source: AGHT+IGs0cV1u4iegcMKrjuoero2v6sW5UX43WNEwXp7nEN1CqXaDi6DN+1s0QUOAJhNgTLw4fuguQ==
X-Received: by 2002:a2e:a985:0:b0:308:e54d:61a6 with SMTP id 38308e7fff4ca-309050be548mr1754521fa.34.1739321714727;
        Tue, 11 Feb 2025 16:55:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-308e95f67f1sm9534311fa.48.2025.02.11.16.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:55:13 -0800 (PST)
Date: Wed, 12 Feb 2025 02:55:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Daniel Thompson <danielt@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Paul Kocialkowski <contact@paulk.fr>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, =?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
Message-ID: <i5q5zuymhn6sy4nou22zxbolztqbq6soef2cwrdq3ey63vfugj@z3rv7zh7xhle>
References: <20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com>
 <20250206-hotplug-drm-bridge-v6-14-9d6f2c9c3058@bootlin.com>
 <20250207-ingenious-daffodil-dugong-51be57@houat>
 <ucttjaf3trkgtpvhnsj7xfsybhnoi4qqow5ucwghlggivbagy7@gngjhbtu73lb>
 <20250210181244.0e3e9189@booty>
 <qnuskv4mln32nqgbgvwi2qcdwfma6tqfbq7e6sqb3za6pmms2j@ir7pt5634dsh>
 <20250211-venomous-dragon-of-competition-d76bf9@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-venomous-dragon-of-competition-d76bf9@houat>

On Tue, Feb 11, 2025 at 09:48:31AM +0100, Maxime Ripard wrote:
> On Tue, Feb 11, 2025 at 01:14:28AM +0200, Dmitry Baryshkov wrote:
> > On Mon, Feb 10, 2025 at 06:12:44PM +0100, Luca Ceresoli wrote:
> > > Hi Maxime, Dmitry
> > > 
> > > On Fri, 7 Feb 2025 21:54:06 +0200
> > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > > 
> > > > > > +/* Internal function (for refcounted bridges) */
> > > > > > +void __drm_bridge_free(struct kref *kref)
> > > > > > +{
> > > > > > +	struct drm_bridge *bridge = container_of(kref, struct drm_bridge, refcount);
> > > > > > +	void *container = ((void *)bridge) - bridge->container_offset;
> > > > > > +
> > > > > > +	DRM_DEBUG("bridge=%p, container=%p FREE\n", bridge, container);  
> > > > > 
> > > > > Pointers are not really useful to track here, since they are obfuscated
> > > > > most of the time. Using the bridge device name would probably be better
> > > > > (or removing the SHOUTING DEBUG entirely :))  
> > > > 
> > > > bridge device name or bridge funcs (I opted for the latter for the
> > > > debugfs file)
> > > 
> > > These DRM_DEBUG()s proved extremely useful exactly because of the
> > > pointer. This is because when using hotplug one normally has the same
> > > device added and removed multiple times, and so the device name or
> > > bridge funcs is always the same, preventing from understanding which
> > > instance is leaking, or being freed, get, put, etc.
> > > 
> > > Do you think this is a sufficient motivation to keep it?
> > 
> > Then it should be something like %px. I found that %p is mangled.
> > What about having both device name _and_ a pointer?
> 
> No, %px must not be used there. %p is mangled but should be consistent
> across calls. But yeah, it's kind of the reason I suggested to use the
> bridge device name instead.

Then we need to extend struct drm_bridge with struct device *dev (which
I would appreciate, it will solve whole hdmi_audio_dev / CEC device /
etc story).

-- 
With best wishes
Dmitry

