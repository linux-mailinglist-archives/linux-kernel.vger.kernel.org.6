Return-Path: <linux-kernel+bounces-229075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B8916A79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D0F1F270A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1902A16D30D;
	Tue, 25 Jun 2024 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PfdLaB0u"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9216B391
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325890; cv=none; b=IxiI141SfEX8x5o9ltk3/SsYl0qabXbH+D6dY3Ix+PSWoVnG5EMi2mF91dcxTLVtGWbNtDL5r5q8sdzu9aVRRMr3C31RPOCNxyrEn8cbAlVsqbl7mhoCsARpDr5Mj8m1kgScLfgsxqy2qpSOPYAtWRQFMZOCwbifEtcK0XQ5eu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325890; c=relaxed/simple;
	bh=V7dWE4hfFdpsOxM4KwvBYWS/4Kx5MrWKZMV5B2ruyHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxA/N9rq2OIXtEObhbjQDbE6fqzNk6q1PYI3RGdOM/votczsP0v0iQOM+ugMZ+eU0CDTCh47cbBV9odTOX3AW1945VCH2ggBP2/pAS/5mlNw/B3v7F3L/LqWesmcNyhgSuXatSroTL+7UxF7SKIo+NrvgsBLewfPOajLGSXZUv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PfdLaB0u; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so65053121fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719325886; x=1719930686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=terD6+QvpMZ2X6sUQUwDmG2WaJEp4OJC722UlqzDSBk=;
        b=PfdLaB0uqWhg9cL9yW99Uao3ELdctbWCSyieF41He+HMpjjVXXFOxH/vRVfDGzmaHk
         pKnsHazKshDODxZtx+hJVpAI4Kl5XyyjiqqHD3rUQqTeJyYrCU+boucIgE55np2dYmxM
         C+YN4gM7lXdDIVk+fDYvfPTkSPE4xPwS8SmhrpIPjpNOilQyPoGRzxcj3HC40IA5SRwE
         aFrGQXsvcbM5tkhH+DaLOCySJiQ8siYehk/Ne0EWoaOmKk3VrH46PrhaPFj8ps2BnGq4
         4WTybqnGK6QaBFiWRmiR9RTfBUJ15kH3Qg9g9Kn6GWH3aZVS/1uPMCfzA0J6Kw3V6ILR
         ShNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325886; x=1719930686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=terD6+QvpMZ2X6sUQUwDmG2WaJEp4OJC722UlqzDSBk=;
        b=Zu2EoHtY4eq/Fd8e5rtLhMyBZu/UMAIkrRoxQrWYyOh3oaGCInez0g4t3Fa0iH4UIF
         vhFysmNdyyEyY0VMQL6N26dO0iwaZxstmZ9pIAG4eB+mQYKTnf8HspVMJ6iCT7SOmust
         qbJLUWk1CTCI/K6+xwUSbkvh8Za3ORday9EHVJcPNJYTUkfrk3rW6WMtrBFNE7J1uGr+
         KqN7RpNm+vZ3r3QKWh+JRQUxQabnqmefvOEVPmi2dQZ2w19Vt5VV0TM488e3kFVnTuhS
         IyTvpPRUmWvkxwD4ri8i/2aes89FRWuu/iw/wlX44jn1csgf+W3Z4oI2kBmd/TAtMIsI
         GX2w==
X-Forwarded-Encrypted: i=1; AJvYcCVvvtKriStt1DULzrYDMl1WZJ3V4XqHJ+JQFBnlzUXctAdOCx2+HP3a2xJxrMR5E0w7m/bInsm90atkx4YMXTBhMhLfPbJIp7oenBcX
X-Gm-Message-State: AOJu0YxVm+z0CAfz/G2tkwceAgvIrCbj8AtzxkDjXXM9quGJJQNOC82d
	evGavPKAVRqGuDBGQ/vAHsqKy6FMtptK07n6c47B0bMlQcWoeZdtPMnFXiF6XKc=
X-Google-Smtp-Source: AGHT+IEGzmjKZJbYhPPc3fbe7PHSu8pPNkw01sUFTND10FididG1OaZlj/O83Pz/ya65Uve+U0qYSQ==
X-Received: by 2002:a19:6452:0:b0:52c:7fc7:f40d with SMTP id 2adb3069b0e04-52cdf7f108bmr4688866e87.21.1719325886353;
        Tue, 25 Jun 2024 07:31:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63be24dsm1250303e87.95.2024.06.25.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:31:25 -0700 (PDT)
Date: Tue, 25 Jun 2024 17:31:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, "igt-dev@lists.freedesktop.org" <igt-dev@lists.freedesktop.org>, 
	Petri Latvala <adrinael@adrinael.net>, Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/connector: automatically set immutable flag
 for max_bpc property
Message-ID: <qwcinsvam4xydeytbmpnbhssywyuiblri4pknuocec7ze6622f@yakhawuucf7v>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org>
 <99ff549c-f5c4-dc9c-42f3-396dc3d29d6b@quicinc.com>
 <CAA8EJppcH-z275m6xDQaigsxmVhnfJkLVsq68GHLFoAq_p_2GA@mail.gmail.com>
 <30fa4e53-5a03-4030-2be5-f383a1c60077@quicinc.com>
 <CAA8EJpo_dBDqLUVH-SkufhFchu64rhC+vkhVBFdt++E4pdCrQg@mail.gmail.com>
 <20240625-yellow-shrimp-of-genius-17c662@houat>
 <CAA8EJpr_kn=x080KLGfwsLi3PnnNhTjJhvL=hiRNLBD=WqSuZQ@mail.gmail.com>
 <20240625-enlightened-optimistic-fossa-fdd128@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-enlightened-optimistic-fossa-fdd128@houat>

On Tue, Jun 25, 2024 at 03:58:25PM GMT, Maxime Ripard wrote:
> On Tue, Jun 25, 2024 at 10:23:14AM GMT, Dmitry Baryshkov wrote:
> > On Tue, 25 Jun 2024 at 10:19, Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Jun 25, 2024 at 09:21:27AM GMT, Dmitry Baryshkov wrote:
> > > > On Tue, 25 Jun 2024 at 01:56, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 6/24/2024 3:46 PM, Dmitry Baryshkov wrote:
> > > > > > On Tue, 25 Jun 2024 at 01:39, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > > > > >>
> > > > > >> + IGT dev
> > > > > >>
> > > > > >> On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
> > > > > >>> With the introduction of the HDMI Connector framework the driver might
> > > > > >>> end up creating the max_bpc property with min = max = 8. IGT insists
> > > > > >>> that such properties carry the 'immutable' flag. Automatically set the
> > > > > >>> flag if the driver asks for the max_bpc property with min == max.
> > > > > >>>
> > > > > >>
> > > > > >> This change does not look right to me.
> > > > > >>
> > > > > >> I wonder why we need this check because DRM_MODE_PROP_IMMUTABLE means
> > > > > >> that as per the doc, userspace cannot change the property.
> > > > > >>
> > > > > >>            * DRM_MODE_PROP_IMMUTABLE
> > > > > >>            *     Set for properties whose values cannot be changed by
> > > > > >>            *     userspace. The kernel is allowed to update the value of
> > > > > >> these
> > > > > >>            *     properties. This is generally used to expose probe state to
> > > > > >>            *     userspace, e.g. the EDID, or the connector path property
> > > > > >> on DP
> > > > > >>            *     MST sinks. Kernel can update the value of an immutable
> > > > > >> property
> > > > > >>            *     by calling drm_object_property_set_value().
> > > > > >>            */
> > > > > >>
> > > > > >> Here we are allowing userspace to change max_bpc
> > > > > >>
> > > > > >>
> > > > > >> drm_atomic_connector_set_property()
> > > > > >> {
> > > > > >>          **********
> > > > > >>
> > > > > >>           } else if (property == connector->max_bpc_property) {
> > > > > >>                   state->max_requested_bpc = val;
> > > > > >>
> > > > > >>          **********
> > > > > >> }
> > > > > >>
> > > > > >> I believe you are referring to this IGT check right?
> > > > > >>
> > > > > >> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_properties.c#L428
> > > > > >
> > > > > > Yes
> > > > > >
> > > > > >>
> > > > > >> I think we should fix IGT in this case unless there is some reason we
> > > > > >> are missing. Because just because it has the same min and max does not
> > > > > >> mean its immutable by the doc of the IMMUTABLE flag.
> > > > > >
> > > > > > Well, having the same min and max means that it is impossible to
> > > > > > change the property. So the property is immutable, but doesn't have
> > > > > > the flag.
> > > > > >
> > > > >
> > > > > True, then does DRM_MODE_PROP_IMMUTABLE need a doc update too indicating
> > > > > that even if the min and max is same, property will be interpreted as
> > > > > immutable.
> > > >
> > > > Granted that I'm only doing it for max_bpc property I don't think so.
> > >
> > > Yeah, I have to agree with Abhinav here, it does look fishy to me too,
> > > even more so that it's only ever "documented" through an igt routine
> > > that has never documented why we want that.
> > >
> > > I'm fine with the change if it's indeed what we expect, and it might
> > > very well be, but I'd like to clear that up and document it first.
> > 
> > Should I also move the setting of the IMMUTABLE flag to a more generic code?
> 
> Possibly, but I guess that will depend on the outcome of that discussion

Agreed, I'll post it later today. Could you please ack or comment the first patch?

-- 
With best wishes
Dmitry

