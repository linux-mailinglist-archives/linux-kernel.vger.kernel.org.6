Return-Path: <linux-kernel+bounces-255332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE803933F47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D077284A03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA101181B91;
	Wed, 17 Jul 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B8WafE4e"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977617FABC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229007; cv=none; b=cz6ZdtCMGyOqTq1q7H6e8L1jHtbpYU6XA7VjSLJwhoYahz7cmAU25JIxK4N6nH96aszxabrbTBu9ddC9WSj3EgwNwYDcn92pMGu6rF6NoNLciAtl8MttPhXlMydpM8JSL94vCSyPTi9ZAflWSPp3gCXqeBdq3rYW6uY/SKr/TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229007; c=relaxed/simple;
	bh=tuAEIzyj+ha0nP/x70IsIoGb8TTJsf4NyxTFGO4faUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLAo4Djr1ovzcd4vGNJyoH0/vopNksX9hasx58pj2uwd25HWi75qH+Z0FuxdVHURyLIRu2esG9zviq+1fyn5sP7C0W7LVsteQnNE/5WlDtsPuCOCxKyFB8IEYUJ6h4rROUa9XSH1czc5kuzXz9cX6Mx48PQOBpFbFQNbw+IYHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=B8WafE4e; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee98a224b8so10715561fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721229004; x=1721833804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn4TP8PBVroM1jvpw0ODPErzX1wcuSE2iey02MAd1Zg=;
        b=B8WafE4eu2dmjyxCeFdkn/Yc4mumHa9xu9cOipxzuMZvJaJYXEPLP658Wp1vVh/ixk
         KC37iBdGmlXGwDmR86rv8oQIqfGLdMf8+0uAEVRqR5UP3I7CvO1un52nE73AYvPwGtki
         cQRa3Na9WtgQTVQKjN0bEwtZO3bUJOaCOOar4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721229004; x=1721833804;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn4TP8PBVroM1jvpw0ODPErzX1wcuSE2iey02MAd1Zg=;
        b=euoHDLoaHArQODfWY6gzmenU4RXspr9BBUxUbPNhLNTNJXpE/ol1g7ykwFh/Hxx5ow
         5GhXopMThra5evQ5gd2NeGUlQHMssJmnUIcL6gBQkE+ip5qDfynIzsXDUogNwucdJM2T
         cLTTH1RM8mRPrJGJZzVHrmdVYHPPq/yGS4HLVmYSXbJ+vAnEeL0+UwuftnpE5F3ov/tP
         EZfkyGGQbrHzJEyGUG0znKV9GvuzjEpoCRM8/SKPxPFTX3DpwC2YiQZj5Tk63BxiHvXV
         luEIDBd1tDhK0lWNdEGth7t7y6u4zFiZFPRPgWqFSjiYlziZHhuxYAdRsWA6WC1fqVps
         R7vg==
X-Forwarded-Encrypted: i=1; AJvYcCWYPyLx8CHuZdIbDNwgOeHj+/knrjb1YEO0xONTfr5e/MQ6nOqPAKjRAcEWDaTbSapb8mOCcJ9CA5C56gi24oH3rTREKv1xOH/bTL2Y
X-Gm-Message-State: AOJu0YxRnOAcSNZKH/8ZJ9p8fl5hMaJswspoLQxZfoGJlpc6fTbc39xu
	lV/otlkyATn6xq1VfuEyrhyrD+KDhurMa71A3kHZKQdrnPPv5XwwNyCaarqLJP0=
X-Google-Smtp-Source: AGHT+IFERPpApl0DTzfYtP7vReuydD6LyFVwPjkdroK6PS8C1ELiGKXsed2rqK8YbNxdsN3KnCok/A==
X-Received: by 2002:a05:651c:1a0c:b0:2ec:18c7:169d with SMTP id 38308e7fff4ca-2eefd0b8418mr8758821fa.1.1721229002527;
        Wed, 17 Jul 2024 08:10:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7814203sm1212865e9.45.2024.07.17.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:10:01 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:09:59 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panic: Remove build time dependency with
 FRAMEBUFFER_CONSOLE
Message-ID: <Zpfex7mO2JcdVHWe@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-4-jfalempe@redhat.com>
 <87wmlk49ed.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmlk49ed.fsf@minerva.mail-host-address-is-not-set>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 17, 2024 at 12:09:46PM +0200, Javier Martinez Canillas wrote:
> Jocelyn Falempe <jfalempe@redhat.com> writes:
> 
> > Now that fbcon has the skip_panic option, there is no more conflicts
> > between drm_panic and fbcon.
> > Remove the build time dependency, so they can be both enabled.
> >
> > Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> > ---
> >  drivers/gpu/drm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 6dd0016fc9cd..a22cab218004 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -107,7 +107,7 @@ config DRM_KMS_HELPER
> >  
> >  config DRM_PANIC
> >  	bool "Display a user-friendly message when a kernel panic occurs"
> > -	depends on DRM && !(FRAMEBUFFER_CONSOLE && VT_CONSOLE)
> > +	depends on DRM
> 
> This is great. Thanks for finding an alternative approach! I don't see any
> issues this time, because there is no locking involved. But let's see what
> others think about it.

Looks like it should work, I did check the history of fbcon_is_active and
we've used that to force/disable panic output for fbcon in the past. So I
think it's the right tool.

> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Sima
> 
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

