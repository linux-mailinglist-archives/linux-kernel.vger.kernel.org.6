Return-Path: <linux-kernel+bounces-515233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C2BA3621A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01105171A45
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C32676F5;
	Fri, 14 Feb 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip4h4PR+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A442676D6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547862; cv=none; b=Fjuvs8S40gtVD4E7SimfAEbLQo7F/q68HuZ0e+A8R1F1dR/sHpohcKTvXV7Jpemoti7/5eXXTH8qJfLjmtZ6Yr6bMPcdi1Yr3reRzBjCUyAGL2x1tUyx4n1aW+zp6406aB57gcbjeKpSt7pcJu+upyaO9eDcUoVLu3+Ga8b9UJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547862; c=relaxed/simple;
	bh=ICPSdwDUGRWx0WbCUm7OSHgLTbyXZAg7jqUc+PtH/J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLPiYjTFQB8+qgqarFkI0k+KbUkNY/6N5pN0MrYhjpCOfAh8SAAtus5lOHaOHibHMbaHW6BsblrJokNsLRnMviCDN5aZScpk4dVGTL9AilEGG7HngvE9pFKr6CZZjWjL20jnalfe3IDfOb1x0eDzANhQtRdzm3wkD070Zxy/4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip4h4PR+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43948021a45so23135605e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739547859; x=1740152659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+d3zRv5P3gfitT19aXZo9yCUhUwKlCUptW0UeMXsxs=;
        b=Ip4h4PR+YRV22zOU1E0eSc2fDmEknUeYpoOjKWLLsORb/mGuaI0CVnK00hGfmefytX
         K0rsRtE5podiHyTjAs1u71IghlHI+FZRmtoRzObRA/l28Ot1cfSqUf+zk5MERIaIxYuf
         5vSHDfW1WbeIicwGwPpOGXQF7rXpAhresG6DhRtR9DhH6q1JaIzNhxLtJnWkCZgNak0H
         LiRhbujMtkGtyFTyShq/CeUm0LHJePhmAY0eO2NmYrYn1U1SKK9ToDkJ32X1zu7gnYvL
         8y6/liZ+W5zpm2n8i0oto0qiW1zGjXaH/lu23ycm3KC/zSN5S1pNmPC1SU4IWpDEcu6v
         Dekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547859; x=1740152659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+d3zRv5P3gfitT19aXZo9yCUhUwKlCUptW0UeMXsxs=;
        b=smT/K4BHmkwNkgTbcQsdg6o/OBLFO5PdE3Z+9ZnmJzgS+bBPa5qwDhg8Drbqg/NLQI
         WwNuvaePIytt95fyqdkm0b3dZpIB7uc9SX1ZddH6NoYARO9BLO7f23AiBdsFp+uhcGR6
         yShjMVrPSP0CPlaRQyHUWhbfKtYIx5Tn5dJ9l2rKOP/dwLxlH0kM4Jpwbi5XVTuuBWJ1
         clsfZ9vV9xTlIYyTXcpF3z8o4oNqtd3EAW/2ZpdQWD/BnQObdNJRbyGQfTCytSTo3WjK
         8zSNLKmFpw8SFfpEq1LfAyndAXPRqn8A0Sp/0PN4jk8aTQ+uZTnIVSECb4D2qj4ou0L5
         iILw==
X-Forwarded-Encrypted: i=1; AJvYcCX62+fEScrjsdv+1qLEOdZO4ZDTaWq0WtKjw4dCDo+/7nTt3CcyR7WiiR31rB6AokWLxbzq5LEpzq1gVdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUvaVMWgz63D5FTO2K7pHZXlIJ/r2WV2XYJcvMgX43b/2WWZr
	WFABVdgVP5FRrPDYI7izmvpHkmQZTwaze1VnBPz74JTauKOvGsdD
X-Gm-Gg: ASbGncvcudd5ouLS42kUDfE0dffNFQOiJnKqXumYo2V6YUj70V6DcAqjlHdk+G1Tfge
	OJ+m6JEHLw6xhfPCWe1kcA9CSSLNMazTeXWi+VtCZUObm+9eLYuiNQRYLTzkIIJ3dYEZ7FJzKEd
	t5pnXS7Z4ckww8odQFTBueMT0vTTBW1Z/Nik3+4+jqljTIbuuZ9g6wRMe1P34TdbbTS9K1pFwbY
	l5qSj9gr+fHhdaMDM/kRtK9NAfkc8fZufAI8fj54GdDgRDof8LE+ZvTWtSufSLUD4/l9s4SWgrJ
	M9lcAYFQT33QGG4=
X-Google-Smtp-Source: AGHT+IEPDbRl8m66IACo1TTA+yK/jZSJ/d+D7h5IGK7nYLNMQUiXFMMLindZv6/sZrNAAZ37oy1A1w==
X-Received: by 2002:a05:600c:3b1d:b0:439:6d7c:48fd with SMTP id 5b1f17b1804b1-4396d7c5247mr10913135e9.4.1739547858283;
        Fri, 14 Feb 2025 07:44:18 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dab74sm4993013f8f.32.2025.02.14.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:44:17 -0800 (PST)
Date: Fri, 14 Feb 2025 16:44:16 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, hamohammed.sa@gmail.com,
	simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, sylphrenadin@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Fix use after free and double free on init
 error
Message-ID: <Z69k0MLER7CYN5fx@fedora>
References: <20250212084912.3196-1-jose.exposito89@gmail.com>
 <bfc71d72-2f23-4c8c-b278-7e9aad3bf72d@suse.de>
 <3af06a6e-adb9-4e72-ab4d-23dbf37258b4@bootlin.com>
 <Z64LmAJlf-B6wQkL@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z64LmAJlf-B6wQkL@louis-chauvet-laptop>

On Thu, Feb 13, 2025 at 04:11:20PM +0100, Louis Chauvet wrote:
> On 12/02/25 - 15:06, Louis Chauvet wrote:
> > 
> > 
> > Le 12/02/2025 à 09:53, Thomas Zimmermann a écrit :
> > > 
> > > 
> > > Am 12.02.25 um 09:49 schrieb José Expósito:
> > > > If the driver initialization fails, the vkms_exit() function might
> > > > access an uninitialized or freed default_config pointer and it might
> > > > double free it.
> > > > 
> > > > Fix both possible errors by initializing default_config only when the
> > > > driver initialization succeeded.
> > > > 
> > > > Reported-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > Link: https://lore.kernel.org/all/Z5uDHcCmAwiTsGte@louis-chauvet-laptop/
> > > > Fixes: 2df7af93fdad ("drm/vkms: Add vkms_config type")
> > > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > > 
> > > Reviewed-by: Thomas Zimmermann <tzimmremann@suse.de>
> > 
> > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > 
> > lore.kernel.org is broken currently, to avoid doing mistakes, I will wait
> > for it to be working again so I can apply your patch using dim+b4.
> > 
> > (I removed danvet.vetter@ffwl.ch from CC, the mail server rejected the mail)
> > 
> > Thanks!
> > Louis Chauvet
> 
> Hello,
> 
> I tried to apply the commit, but I have a strange issue:
> 
> 	$ dim push
> 	Enumerating objects: 13, done.
> 	Counting objects: 100% (13/13), done.
> 	Delta compression using up to 20 threads
> 	Compressing objects: 100% (7/7), done.
> 	Writing objects: 100% (7/7), 1.67 KiB | 113.00 KiB/s, done.
> 	Total 7 (delta 6), reused 0 (delta 0), pack-reused 0 (from 0)
> 	remote:
> 	remote: ========================================================================
> 	remote:
> 	remote:    Equinix is shutting down its operations with us on April 30, 2025.
> 	remote:    They have graciously supported us for almost 5 years, but all good
> 	remote:    things come to an end. Given the time frame, it's going to be hard
> 	remote:       to make a smooth transition of the cluster to somewhere else
> 	remote: ([TBD](https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/2011)).
> 	remote:     Please expect in the next months some hiccups in the service and
> 	remote:    probably at least a full week of downtime to transfer gitlab to a
> 	remote:                different place. All help is appreciated.
> 	remote:
> 	remote: ========================================================================
> 	remote:
> 	To gitlab.freedesktop.org:drm/misc/kernel.git
> 	   ff3881cc6a58..ed15511a773d  drm-misc-next -> drm-misc-next
> 	Pushing drm-misc-fixes to for-linux-next-fixes... Everything up-to-date
> 	Done.
> 	Out of merge window. Pushing drm-misc-next to for-linux-next... 
> 	remote:
> 	remote: ========================================================================
> 	remote:
> 	remote: ERROR: Internal API unreachable
> 	
> 	remote:
> 	remote: ========================================================================
> 	remote:
> 	fatal: Could not read from remote repository.
> 	
> 	Please make sure you have the correct access rights
> 	and the repository exists.
> 
> Is this expected?

I guess you managed to fix the issue. I git pull-ed this morning and
the patch was applied.

Jose
 
> Thanks,
> Louis Chauvet
> 
> > > Thanks for posting this patch separately.
> > > 
> > > Best regards
> > > Thomas
> > > 
> > > > ---
> > > >    drivers/gpu/drm/vkms/vkms_drv.c | 15 +++++++++------
> > > >    1 file changed, 9 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > > index 7c142bfc3bd9..b6de91134a22 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > > @@ -235,17 +235,19 @@ static int __init vkms_init(void)
> > > >    	if (!config)
> > > >    		return -ENOMEM;
> > > > -	default_config = config;
> > > > -
> > > >    	config->cursor = enable_cursor;
> > > >    	config->writeback = enable_writeback;
> > > >    	config->overlay = enable_overlay;
> > > >    	ret = vkms_create(config);
> > > > -	if (ret)
> > > > +	if (ret) {
> > > >    		kfree(config);
> > > > +		return ret;
> > > > +	}
> > > > -	return ret;
> > > > +	default_config = config;
> > > > +
> > > > +	return 0;
> > > >    }
> > > >    static void vkms_destroy(struct vkms_config *config)
> > > > @@ -269,9 +271,10 @@ static void vkms_destroy(struct vkms_config *config)
> > > >    static void __exit vkms_exit(void)
> > > >    {
> > > > -	if (default_config->dev)
> > > > -		vkms_destroy(default_config);
> > > > +	if (!default_config)
> > > > +		return;
> > > > +	vkms_destroy(default_config);
> > > >    	kfree(default_config);
> > > >    }
> > > 
> > 
> > -- 
> > Louis Chauvet, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > 

