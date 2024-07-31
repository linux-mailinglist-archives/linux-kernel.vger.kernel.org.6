Return-Path: <linux-kernel+bounces-269846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9826943772
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775E51F21F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649AC16631C;
	Wed, 31 Jul 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FyFmOzeF"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606529CE1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459329; cv=none; b=Tdm9k5BYsH7RPneNEfbP7kJR+c2ePj2GdVN8lmTGyH9TU/CJNF8JSAGVvJdN5ReO5HN5lXcYgWCXkQMzKXbkwdq0kOwjIaGk7F+ltstPZXtFFPQEQ9JArUQGB/55BKj+hhtTCVW0jSfoytt+k+tZgp2iloXJ6ZLjQHKGYxr4HH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459329; c=relaxed/simple;
	bh=5SQsgXUH0ue4DThxuKUv/BhcYduQfJteQ/P3p4ycbGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaT1WC46cae9P+ZALu6UNHQqu2iXIJwpg2wlU4/0zrjbNXYnWFHmVeOGp531OnOGtzZT/Ev454LEzck23pdQdeoRimfNkJeKzqa7Fw915amR7TAtMm54y11yc94w6I5SdfgMNi9lCoURPqlsXBMstajdtyFCMyF/b6gtx7MvcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=FyFmOzeF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3684c05f7afso769820f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722459326; x=1723064126; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czXRHy0hc+wPP5wtP/ukRAF9X8vY1DORbIlGLuoSDRQ=;
        b=FyFmOzeF3zIiF/x+s00sDQ8ChzTWspNv12ZmL0M1pY9A+XIbM+nEdYdGekZuAOdxdN
         eVYSuDq0nSOuSN0o77JtzntOe/n8sM+IaJ2ZdiZZNlIIO3WJfdzQs4L1F0O0o3vWCnN4
         /Ie3w0QWn5r6mvjia72QOby+F1COwdeGlhPyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459326; x=1723064126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czXRHy0hc+wPP5wtP/ukRAF9X8vY1DORbIlGLuoSDRQ=;
        b=qp8k4NQ9ViN4PncKm7CuhDJi+3gPk9lp52psWgGipryI8rcMsE42Ys+jZCGPJGkOi6
         N2H+5ta+yzwbnFT/hPzjH7+EVigYtqTvSnmCBOu7z6LwyMXldDfCe7qwQohYRrdrUL5g
         RukbfKoqtEG31G54FcDZRkNQ6xKIzBXzY2SrkjlWi4nApQtQPPL7jLqU3VVl8vBNLEdI
         cvDZLat2Ha43eZpNHDtSSk/HD9Hgvcr6SbQOAXqIvBwMIC2nt0ScK88hwFvEUHbrYY0j
         hkkaE/FQU5IqcCIHBTmETN7ylG6h+zhXI3b1AjyaPkqOIH/xbM764vHWlyb5BUz8ArWQ
         HvnA==
X-Forwarded-Encrypted: i=1; AJvYcCWGFYyR8Ui5OYRA6fc1ZHglt7DFIhdQybkMNkEP1C8MRBcsnuqF9J56YtnegTR0160hAzxTGYmPA+LSLqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLCCqnTbAIvAveKNhLh5diFGnoc17BGQvIKbNoxk4K+dfHzM3
	Vf81PYuEceR5fb7nePMgAEZ8ebAJLCLS0dxcu2MkQxDPRdds6aEYVGaol5tf660=
X-Google-Smtp-Source: AGHT+IFn6J60Ck+bfFIRb4T0kdCPpvHeHtGytipJFG8R9nAZz1MYoHJtc6h7xwQvbxy+k2zbiO/M8A==
X-Received: by 2002:a05:6000:1542:b0:366:ea51:be79 with SMTP id ffacd0b85a97d-36baaf4edd0mr199684f8f.6.1722459326061;
        Wed, 31 Jul 2024 13:55:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36858179sm17957622f8f.88.2024.07.31.13.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:55:25 -0700 (PDT)
Date: Wed, 31 Jul 2024 22:55:23 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Matt Hartley <matt.hartley@gmail.com>,
	Kieran Levin <ktl@framework.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Dustin Howett <dustin@howett.net>
Subject: Re: [PATCH v3 0/2] drm: minimum backlight overrides and
 implementation for amdgpu
Message-ID: <Zqqku_zS7CpPGbzW@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Matt Hartley <matt.hartley@gmail.com>,
	Kieran Levin <ktl@framework.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Dustin Howett <dustin@howett.net>
References: <20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net>
 <87v80lwjcz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v80lwjcz.fsf@intel.com>
X-Operating-System: Linux phenom 6.9.10-amd64 

On Wed, Jul 31, 2024 at 08:40:12PM +0300, Jani Nikula wrote:
> On Wed, 31 Jul 2024, Thomas Weiﬂschuh <linux@weissschuh.net> wrote:
> > The value of "min_input_signal" returned from ATIF on a Framework AMD 13
> > is "12". This leads to a fairly bright minimum display backlight.
> >
> > Add a generic override helper for the user to override the settings
> > provided by the firmware through the kernel cmdline.
> > Also add amdgpu as a user of that helper.
> >
> > One solution would be a fixed firmware version, which was announced but
> > has no timeline.
> 
> The flip side is that if we add this now, it pretty much has a timeline:
> We'll have to carry and support it forever.
> 
> It's not a great prospect for something so specific. Not to mention that
> the limits are generally there for electrical minimums that should not
> be overridden. And before you know it, we'll have bug reports about
> flickering screens...

Yeah I think for this specific case where a fixed firmware is already
kinda promised, a quirk is the right fix. Otherwise we open up a can of
worms here ... so personally I like v2 a lot more.
-Sima

> 
> BR,
> Jani.
> 
> 
> >
> > This helper does conflict with the mode override via the cmdline.
> > Only one can be specified.
> > IMO the mode override can be extended to also handle "min-brightness"
> > when that becomes necessary.
> >
> > ---
> > Changes in v3:
> > - Switch to cmdline override parameter
> > - Link to v2: https://lore.kernel.org/r/20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net
> >
> > Changes in v2:
> > - Introduce proper drm backlight quirk infrastructure
> > - Quirk by EDID and DMI instead of only DMI
> > - Limit quirk to only single Framework 13 matte panel
> > - Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net
> >
> > ---
> > Thomas Weiﬂschuh (2):
> >       drm/connector: add drm_connector_get_cmdline_min_brightness_override()
> >       drm/amd/display: implement minimum brightness override
> >
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++++
> >  drivers/gpu/drm/drm_connector.c                   | 34 +++++++++++++++++++++++
> >  include/drm/drm_connector.h                       |  2 ++
> >  3 files changed, 42 insertions(+)
> > ---
> > base-commit: 36821612eb3091a21f7f4a907b497064725080c3
> > change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
> >
> > Best regards,
> 
> -- 
> Jani Nikula, Intel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

