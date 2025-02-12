Return-Path: <linux-kernel+bounces-510757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB4A32186
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FC13A4AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0044205AA7;
	Wed, 12 Feb 2025 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7D1CTMN"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44778204F9D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350361; cv=none; b=QFs6R1qwuMWC8zli11fHBWZahKBm0sFQing6174fqPyGEzN0P2tfh2zfTjsgf6XOAhp+eiFQIj4rCEESOu/9uUAP+9CI7+qkcvdVKm6vye8H6utVbBzsqFPU5KCTpfSaxpUPbHOir7mgdYeUWrX4/mpqrqypJB1dbevNBr0RgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350361; c=relaxed/simple;
	bh=vwP/WPKngQ65suwlID2kE/0rJDXtF+wo3rC3Wroz4HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwyuKov0/skc1ig9srLhO8bDjQltg/fUUbczkP0K8IhRT0hHaZaGsSTqWsvqkCjZeljS+csABHSnBhO01G5NVEckFQ1J1DJMCuuV0KqqQ5rcRQ6LPx8Bkjk7pUFRpEOk/P1fxT4P6w1CZZjo/yBkgyLRlBg03mlUJJHeaHWKBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7D1CTMN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4395817a7f2so4168485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739350357; x=1739955157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Fr4WWGFaH9Ao2CehCps/KNMRPCf+PR+0CP2ZhgjC54=;
        b=d7D1CTMNlxKsA+LHROv0lor3a3/7zrE1Zb6Wm2hf3hp7LgpsMQUoBE67rLtG7bIwwr
         RzJu9Gto2n/wuK8/n0mj3h9XWf7KdHgVB2NG2XRApr/2dT0cKWpErETKo1KNl7DLyS/6
         bLXfVKMp8m7CwcDxXDcXGOw0cmqtnp8rL6Mv0jsRJnjCyWShPxt8d23hyU+p/MxsH4OB
         0Fh8P2zQn1QlNlp/4Hf/dKN2RV3x2pJyRXsAJo/ESac9my7TrMlu+lFqMKgPKaDA2Yh0
         sCbVLgU56ufyNq07yNBuuzm1FP+AoZqid3RU0jkc7C90lkjmsD1VCSdgcf8bNvRIgM4G
         BtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739350357; x=1739955157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fr4WWGFaH9Ao2CehCps/KNMRPCf+PR+0CP2ZhgjC54=;
        b=N7Gq1+vfapyNAySypeEsDlW19qO7UicdM95A+ut4dwP98sxTCx4lM5Ja6YDc2vdR9M
         Kr5svLO8lLbxHbHuujLH/4y7xttqlb1eYRQ1vh9+1wr1RLZHd6TcgTiknd6oCAf5Yfv/
         P8jCIMpncLiKb2zz14OFgxBKls2o5AitxY9J5SwbQPu/Ln3jdEbqaExbCB9jRuqrARUE
         n7pjzXYQeUBzCAyKqVtal1dsg7ME2L8nNjRrFtPrVvirZtpZWT2hgDa9wliNmgWWwo7u
         w+3p8EC13rK+qkLY+6ZIJBoS6/DH9PN36kxD8GzfyYEPWE4fWDZP+gI5OdwUXQ7qhGxO
         vBzA==
X-Forwarded-Encrypted: i=1; AJvYcCWsUgdvLuvFKvBjy1fyJ13BVf7zrFB1RNN8FCE/FOnzeWrJoqjYU8biVc+/62WRZh4Bz2XAG9Czf0zC/2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQhefXdJt7crDhAsxREOZQh90ovMzEpHXcn0xCq5pc3yI+Z+7
	U40vHfJrLUyjYFi2SL952GlFoaXg8Xeer2OpxALIkIsNzcgVfyfy
X-Gm-Gg: ASbGncvvMtoewD/NRgiPxfQauk1Vj5YDrycqzKOM9k5iSMZS++5ct6nqHgRKjcMX/tP
	jZhsr+Gu+h3SVv0BrjwfHyje5IqnIDoAobyu6IyEHnOfDr+LAGouO2B2QXyYvwOR0B0q2hPORcF
	jRCKuCuIT+A86MrekXn+6tCVUPIcx+DnZkd900OQyFPRLpLRtzs+eRHwdRhzOg/wfMK3j0ohv2Z
	mrXmtDkuB28tr/DUOq8tdCizaXHLv4e6qC1NPhxyeP+nxbmsWipeFu9+IPqqZW4Z24AKEdHYJT7
	AxML63HucEf3jg==
X-Google-Smtp-Source: AGHT+IEykSFyZijWB0AYHLFlfKFLHxSfMlUJsiileUyyDk2HhDRhvh/rLJzlnEP3Glj5NtvWiOYE/w==
X-Received: by 2002:a05:600c:1d1b:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-439581bfdc2mr17243385e9.26.1739350357417;
        Wed, 12 Feb 2025 00:52:37 -0800 (PST)
Received: from fedora ([94.73.37.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dca0b4237sm14066442f8f.85.2025.02.12.00.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 00:52:37 -0800 (PST)
Date: Wed, 12 Feb 2025 09:52:35 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
	melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] drm/vkms: Fix use after free and double free on
 init error
Message-ID: <Z6xhU328loIH_5lQ@fedora>
References: <20250211110912.15409-1-jose.exposito89@gmail.com>
 <20250211110912.15409-2-jose.exposito89@gmail.com>
 <428f88f2-1f30-4018-8113-1c4716288789@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <428f88f2-1f30-4018-8113-1c4716288789@suse.de>

Hi Thomas,

On Tue, Feb 11, 2025 at 03:33:55PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.02.25 um 12:08 schrieb José Expósito:
> > If the driver initialization fails, the vkms_exit() function might
> > access an uninitialized or freed default_config pointer and it might
> > double free it.
> > 
> > Fix both possible errors by initializing default_config only when the
> > driver initialization succeeded.
> 
> Could you send this patch separately, so that it can go into drm-misc-fixes
> quickly?

Sure, I just sent it as a separate patch.

Thanks,
Jose
 
> Best regards
> Thomas
> 
> > 
> > Reported-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Link: https://lore.kernel.org/all/Z5uDHcCmAwiTsGte@louis-chauvet-laptop/
> > Fixes: 2df7af93fdad ("drm/vkms: Add vkms_config type")
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_drv.c | 15 +++++++++------
> >   1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > index 7c142bfc3bd9..b6de91134a22 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -235,17 +235,19 @@ static int __init vkms_init(void)
> >   	if (!config)
> >   		return -ENOMEM;
> > -	default_config = config;
> > -
> >   	config->cursor = enable_cursor;
> >   	config->writeback = enable_writeback;
> >   	config->overlay = enable_overlay;
> >   	ret = vkms_create(config);
> > -	if (ret)
> > +	if (ret) {
> >   		kfree(config);
> > +		return ret;
> > +	}
> > -	return ret;
> > +	default_config = config;
> > +
> > +	return 0;
> >   }
> >   static void vkms_destroy(struct vkms_config *config)
> > @@ -269,9 +271,10 @@ static void vkms_destroy(struct vkms_config *config)
> >   static void __exit vkms_exit(void)
> >   {
> > -	if (default_config->dev)
> > -		vkms_destroy(default_config);
> > +	if (!default_config)
> > +		return;
> > +	vkms_destroy(default_config);
> >   	kfree(default_config);
> >   }
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

