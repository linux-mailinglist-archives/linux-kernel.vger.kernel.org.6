Return-Path: <linux-kernel+bounces-265718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F393F4D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80D11F20F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE61146A77;
	Mon, 29 Jul 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoSyL3WS"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F576145B37;
	Mon, 29 Jul 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254753; cv=none; b=LkRZP8sGq/lMf5qBSRu31sr6Yv9DZSxizogL6JeR1Z9ExYAGfnl+ChoOX78U2k+uK8vPKiM0CaQsB13dxOS7YY/Or1Ch/HAkrpTK4TacY77itkUAIsCmU6hCEWacUsRCktSE0uLqDZh07Yv0EB1Fy43gmBorJDNpEoNVtsWdG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254753; c=relaxed/simple;
	bh=06dQpEC9g4tlMXb9xSPjM51cZCH2yusZzY0G052ylbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8oDogC1/7zbjnC7I5enJnDqeUFhK7C4zY4u6kYBvIe4Tuh3pfpIAKw4zrTsjtFbp2dg3J9LaVxJWxQJSU/RyibW2qRJ/QQ6nEQtY4HIjoA1rmQjIoSEg1nFdLinGVfmopE1vh3Oo/ThQ933+4xX0wGsm7py6H0nPQJXg3wH0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoSyL3WS; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d066a5daso224338985a.3;
        Mon, 29 Jul 2024 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722254751; x=1722859551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b1eFHG/gJZDKFSeIKRiXVWS5jkOH7+BDPKwpNOQ1+VM=;
        b=NoSyL3WSl2ZBghxKgBd1adJTxIyf52XIVJaflAfbdjo0H8RGh932WtFJciNlQV50bo
         ft65QYhq/w7bUVBdORyt5eKk1COJUnq37Sg6rit06kHB2BfvtYT+fH28umkbbie+TX2N
         A43WO+0J9lwq2Vd6Q6gJ4RZmbfgOD+bEfh9TccqHY+nz01Zc+rcN8Y4TYAmIsUGtANif
         KV/XY7nbWou3r4mf2ovFbYj2M/90SJ44UWGx7lD9LbuVSUTWgJuXQead6DXpdg0wXf2E
         /9hB67qOTRo80SrDO9KMDStJitJPaPeJ8tSCQ6AFLo7IYkMOsNIphcxotDzRhPjuDAIF
         0X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254751; x=1722859551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1eFHG/gJZDKFSeIKRiXVWS5jkOH7+BDPKwpNOQ1+VM=;
        b=LVszLjEOrLHwmys6AnR/+RRqrKU6iRhsvXs4V45fxlF5epmv6smGEZ58HaU/zfd7y6
         766XW+dMmGDzYiDAjcnnEH6YR2qP9wBM4P5zqUdjyG1CJHq61aEfa9QGqEMssiyZDaZ8
         i3CopKUrLBGf6Nzub6kUTKGVyUaHVWS07GFA3jrrLjfk0cvVNFAiBM980cylXZQmtyZI
         d+SIIv7FuDD+rzZWszke7YMVsUJvLs0BfLA/UIbi9UCmsO9pTr4+cyzFlQ0P2qQZOoHV
         N0zZRTLx9wJ78KXMQl1etvWBCLBfOx+gqg+Mcr1sSoJiPKQu0JlT6rGyFlB7MVX+fLbN
         46Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUIeMi0sQ+P28OnGMIL/zod68nF1VKbmY1MjUH8LQnQFLCgrCtWo7ypkGA6CgzCFaV3QWvbHNeVi1cC934aOwK++ABQm38oz0g818OPspwMhriw1tZI9QHTRh93ZxXlIr25DxNM1dS1sw==
X-Gm-Message-State: AOJu0YzjnPh1fF6krYCOYgyFnTbthGC79YgSayhrLvstB7nmlMctkdCg
	bqQEFD9mYpVTirpBnsPwwoN3c2VeHpQyB6SnNSlwilJ5LC4S2eN2
X-Google-Smtp-Source: AGHT+IGH8UKr0ucxaLYfeyN8JagVjMpPWUGD8vLGcSiPBNx4stPfkpu7abhAucZAuaXCiJxo2Pi28Q==
X-Received: by 2002:a05:6214:2527:b0:6b4:ff83:c02f with SMTP id 6a1803df08f44-6bb55ada366mr91055596d6.53.1722254750951;
        Mon, 29 Jul 2024 05:05:50 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb07bf7sm50779046d6.137.2024.07.29.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:05:50 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:05:47 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Mehdi Djait <mehdi.djait@bootlin.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <darls2mffvsw2ktkirzimzij6w5w45hxylvfcfwgmd3k3elmar@xeg6mfpa3yax>
References: <20240729014311.1746371-3-lanzano.alex@gmail.com>
 <0b1ee6f7-b24d-49a6-ba90-d917c864ecf4@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b1ee6f7-b24d-49a6-ba90-d917c864ecf4@web.de>

On Mon, Jul 29, 2024 at 01:00:47PM GMT, Markus Elfring wrote:
> …
> > +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> > @@ -0,0 +1,684 @@
> …
> > static int sharp_memory_update_display(struct sharp_memory_device *smd,
> > +				       struct drm_framebuffer *fb,
> > +				       struct drm_rect clip,
> > +				       struct drm_format_conv_state *fmtcnv_state)
> > +{
> …
> > +	mutex_lock(&smd->tx_mutex);
> > +
> > +	/* Populate the transmit buffer with frame data */
> …
> > +	mutex_unlock(&smd->tx_mutex);
> > +
> > +	return ret;
> > +}
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(mutex)(&smd->tx_mutex);”?
> https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/mutex.h#L196
> 

Ah, I didn't realize guarded mutexes were implemented. That's really
good to know.

I'd usually use them when it's possible to return before mutex_unlock is
called to avoid goto cleanup logic. But it's probably best to just use them
by default.

Thanks for the review. Will clean up in v4.

Best regards,
Alex

