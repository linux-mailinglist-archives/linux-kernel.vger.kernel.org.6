Return-Path: <linux-kernel+bounces-189060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327848CEA72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFF0282C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308E42ABE;
	Fri, 24 May 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVaFpX52"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480F25757
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580018; cv=none; b=hViV86aNpuHxy+QFQ5Qs35GTb4++1c9XRw4m3TYekgpQtnhxCQuaUg6piRV//vku421S5DrgLFDFnFe05Ldm+tG+B1+5JVKys10OW58Bo7bJSRZ2psUyyRxENZfrSre7Ms96YlBo7TzeSo4j9CSHEn41eKaaDHrsVH6/NXf33dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580018; c=relaxed/simple;
	bh=hqoGfP2ngsyi75wjK/7UVPy1G49ajBOguF0CykV81S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ4O4NRRB3hdNpq0Lx5LHvFQSd8h3Of+qGWdjrDpWS2B+uvS1eQEudCpnxjJLeu5tQ37h/8ls5XT2TTIazdvzYD21Jcz3KuhYrQqpM27UekgWDRI2+XNyrzGZHq8VqPXYf4TafbjZjJ8eCTgO0NYTz4DsnWA1crY/i/tVWYPj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NVaFpX52; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e72b8931caso68962501fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716580014; x=1717184814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Quo9VUto6uPX81U21h21/Sote2mqJ5XSyeYi0dVaj0I=;
        b=NVaFpX52RbA0jt5wHoA3J7cbasoJ60Lq2ovvvvAwcQj8RqVi2R5ou50YzMhmPRBBeq
         kNqOqUSOG+fNFOlDUfpesKgb+y261us8576doKV74avyMUGE79ukXgNzA1oVbi/mIN79
         HI2NxMC4qxMLcXDO2CKb8BXf7+9wpA+zLWPV50tKRzWJOYjkUsTrRc335BtEcVXx9eP1
         S5TWUe/EIWxJTprbJbwjaFqsKcgJljpmA0g+nnKOZAuGWtekZYUpWLQJZrbF3MMXEVIk
         cMd692zYp0LdExPMXQJopJCkmKK/qUF2EkOgEhlFFWxE+dzt4s6eEIJ0u+8AnHDlZn6u
         zGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716580014; x=1717184814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Quo9VUto6uPX81U21h21/Sote2mqJ5XSyeYi0dVaj0I=;
        b=tAFnQop9Mhh02t3hC+OaBoPTYnkEM8uYKQp6vY06nzVfGiOwkqGXQ4MvfxplhEuFjf
         V+gdDKK218LOmqgJIhDdm68lW/d5cTivTBfpm7RNa14y/RTgzeYlQeL3ZrdNblZls5Bf
         12Q5DkNXLbp3vwh9X7uynRFiNM7VS135t3/W2MVLBFF8lkVHNh7ezuTRqVr9BfyZOr6O
         iELJpdd8xYHpuEjgrvCS5JQXqaz1V7qG1y51Uung9DUf/RDgTvjJeRAnLAxzUU+emvbh
         61s+8mhCAXPzDoLBBe9SPI/BkE4sRP0WwVGsK22qURXHJb7YnVJOsNZe2DiPo8RMBy3a
         dhMg==
X-Gm-Message-State: AOJu0YxsjQYnXJyc0TJlL9Gpr3V4+OgZRknsEYqSD8S1Y63eMS6Unxg/
	eUeVbRUYQOoI2M4jlGC2SGLMtu4JE+GbQGgWjO9pOSu6bIDmsrqRwPQbSpstBpKV8+/90magA1o
	b
X-Google-Smtp-Source: AGHT+IGGkwkIgDNujDfrkTUvU6TyZSMLZ2HS+RhhNILj1udlfwdmNchCCne3FxzMdqc27keq9rutHg==
X-Received: by 2002:a2e:3209:0:b0:2d8:34ec:54e6 with SMTP id 38308e7fff4ca-2e95b24dee7mr21133711fa.33.1716580014516;
        Fri, 24 May 2024 12:46:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95be00a0dsm3111601fa.105.2024.05.24.12.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 12:46:54 -0700 (PDT)
Date: Fri, 24 May 2024 22:46:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: linux-kernel@vger.kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	sam@ravnborg.org, mripard@kernel.org, dri-devel@lists.freedesktop.org, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, a-bhatia1@ti.com
Subject: Re: [PATCH v3 1/2] drm/bridge: sii902x: Fix mode_valid hook
Message-ID: <x7i5miguht47wxliioos7npelzzicnwt7g5pfjqjvdztksgzga@c7djvf3lg3kf>
References: <20240524093509.127189-1-j-choudhary@ti.com>
 <20240524093509.127189-2-j-choudhary@ti.com>
 <y6ersd72tp2d6k4i2hja7bg37lahnvye2qion67urxeakw6rju@dher7oomt2ks>
 <4cd64cf5-d2b0-4aa9-b958-6b6fc54f0bf2@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cd64cf5-d2b0-4aa9-b958-6b6fc54f0bf2@ti.com>

On Fri, May 24, 2024 at 05:54:02PM +0530, Jayesh Choudhary wrote:
> Hello Dmitry,
> 
> On 24/05/24 15:11, Dmitry Baryshkov wrote:
> > On Fri, May 24, 2024 at 03:05:08PM +0530, Jayesh Choudhary wrote:
> > > Currently, mode_valid hook returns all mode as valid and it is
> > > defined only in drm_connector_helper_funcs. With the introduction of
> > > 'DRM_BRIDGE_ATTACH_NO_CONNECTOR', connector is not initialized in
> > > bridge_attach call for cases when the encoder has this flag enabled.
> > > So add the mode_valid hook in drm_bridge_funcs as well with proper
> > > clock checks for maximum and minimum pixel clock supported by the
> > > bridge.
> > > 
> > > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> 
> [...]
> 
> > > +
> > >   static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
> > >   					       struct drm_display_mode *mode)
> > >   {
> > > -	/* TODO: check mode */
> > > +	struct sii902x *sii902x = connector_to_sii902x(connector);
> > > +	const struct drm_display_mode *mod = mode;
> > > -	return MODE_OK;
> > > +	return sii902x_validate(sii902x, mod);
> > 
> > There is no need to. The drm_bridge_chain_mode_valid() should take care
> > of calling bridge's mode_valid callback and rejecting the mode if it is
> > not accepted.
> 
> I need some clarity here.
> 
> IIRC, if the bridge does initialize the connector in case
> where the encoder does not attach the bridge with the
> DRM_BRIDGE_ATTACH_NO_CONNECTOR (DBANC) flag (referring to tidss
> encoder before we implemented the DBANC feature), then
> drm_connector_helper_func are called and drm_bridge_funcs
> are NOT called (atleast from what I have seen in detect
> hook for cdns-mhdp-8546 driver which is there in both
> structures).

There are different kinds of bridge_funcs. detect is a part of the
connector-related interface, so it is not called by the drm core. On the
other hand functions like mode_valid, enable/disable, etc. are called
for all bridges.

> I do not have any platform to test non-DBANC encoders.
> And I did not want to break any platform that were still using
> bridge_attach without DBANC flag.
> That is why I kept mode_valid hook in both structures.
> 
> Are you implying that if connector_helper_funcs are not there
> then there will be some sort of fallback to bridge_funcs instead
> of passthrough for mode_valid check? Because that goes against my
> previous observations.

Not quite. See how drm_atomic_heler uses bridge_funcs.

-- 
With best wishes
Dmitry

