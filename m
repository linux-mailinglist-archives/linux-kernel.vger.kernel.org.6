Return-Path: <linux-kernel+bounces-339927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A40986C40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D321F2291E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AB17C223;
	Thu, 26 Sep 2024 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqNtBdgG"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8751AAC4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330764; cv=none; b=kYX0kaseSHVawBjSlcBvWyeSzJ7SDrosT+7trnQDXYPwrgwS2DTab/gWyialwVE9Th+9gjXsPQq1LV48/NFgtjQDNua9wbsCApGXsr94Pae+cgdF4Y7wA3jfwvxJaG6ABhiAhBw26PzF87YJXie2y+iGQytgk1/d/iRTvBE6XeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330764; c=relaxed/simple;
	bh=41awYERf085PoUMMp7gVyX8A5AhXUUwMK8WoICUMYdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KURohFOITvm1HbrdZWpz6rISsTqZWth53Q/outK3FAhtLm40r5jTjS7U/TECuAukcdXqRW6HAXK0omWWEAKfxfepwJiYVSqT5D7063u/4oZBFbua7Ok1yyAQmgIUBwgm1oeVasPFqIzxwZFKn/kWjlASWv7maEjmlRPAtjTrzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CqNtBdgG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-536748c7e9aso737723e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727330761; x=1727935561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dv3MfhlzekToYiiGQvI+mFiz5vJ2MaGQXv1NU3UKSRY=;
        b=CqNtBdgGOyikGCfBUDnomQOaKlseTvALDemfmsOYfq84S64Vx6NmH9ItNDluwwDmrp
         JVlbbp6egiHkGScxgxgpDMET0TDxARLICVfvuOa+VP8+byN6wBg9gCIZJymAFe2v0mqj
         Y3Y9fzx0+7Opd5kxxfgOF8W5eehAEZSC8xJ6Fjbbpqupa8uwXGxXhFtfLsRqxPKaURqV
         +vEks3FCYj1fqAMuG/Uj1J53Ngb+cCgs/1o5aqtfd7y5yJ92YvGl57AeykmUd59C884Z
         cs+dHxEC6qMbHQhxDdY9XPj9cZr88u8aKLuTGB+Qu6se8LA45AmrN4303oIcPP4GTUbS
         BrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727330761; x=1727935561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dv3MfhlzekToYiiGQvI+mFiz5vJ2MaGQXv1NU3UKSRY=;
        b=BmJ6Z7wismtZD4jvTgvJ26KGFkFxMOUQWIW9m5GSV0KyuuNGuczw77nTwxyT5e3A2y
         +niYBW09DwHXfVg0QBxRl4zNBk4C98uVM0sSo2pnm7LE/zFfAf9eaToy67RSi63N50tp
         v6EqlrL7WpAWRl4arPfqSntNJEX8xy1ffbaauq6KkV0TxMXvhb9vRGUIu12vdurMeHju
         EOWy2oGDRQjNiBnNWfoNisqYodryHeziXj0ALjr7y4D6iEy74iYQ0udNzV25quefVtGv
         4vXeI+jcoAkoBT6CW3USXUvj4APExaVYPAK31kCpc7l6rSHHjLu3ALlWK4MWh/YU5H/v
         2BxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+e6iJByI+AYvToJalt6lgnvNBhcgYUk4NXny648g+cu+q7ZNOfCjgIt44Fqs7FjKC8sKUaCswX1ZrTFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2FnvZKjvp5i38+mrt26cWoL7VLJPWBMg5X/RL+KhQ557KSlFg
	dsf7uiCpF0OeMrIPeO1LygV/9UOJP4/SWrwRKXQSjLyj6QkLRYIYC3otIE0Fg4U=
X-Google-Smtp-Source: AGHT+IECc/KpvpaVQ+jOo1BF+Y3mHrWstzLO1HtustfrT7Cxj/8Uuoh9wKeKKpiS7XYHYKzTVV+puw==
X-Received: by 2002:a05:6512:1094:b0:536:53c2:817d with SMTP id 2adb3069b0e04-5387c1be662mr3339826e87.45.1727330760584;
        Wed, 25 Sep 2024 23:06:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a86407acsm714862e87.130.2024.09.25.23.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:05:59 -0700 (PDT)
Date: Thu, 26 Sep 2024 09:05:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm: fsl-dcu: enable PIXCLK on LS1021A
Message-ID: <tosilxaxfg6hejtqs2fslf6ez5pdg5yxj776pohmodja3bn5jp@4jbdprx52fqx>
References: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com>
 <20240926055552.1632448-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926055552.1632448-2-alexander.stein@ew.tq-group.com>

On Thu, Sep 26, 2024 at 07:55:51AM GMT, Alexander Stein wrote:
> From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> 
> The PIXCLK needs to be enabled in SCFG before accessing certain DCU
> registers, or the access will hang. For simplicity, the PIXCLK is enabled
> unconditionally, resulting in increased power consumption.

By this description it looks like a fix. What is the first broken
commit? It needs to be mentioned in the Fixes: tag. Or is it hat
existing devices have been enabling SCFG in some other way?

> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Add note about power consumption in commit message
> * Add note about power consumption in comment
> * Fix alignment
> 

-- 
With best wishes
Dmitry

