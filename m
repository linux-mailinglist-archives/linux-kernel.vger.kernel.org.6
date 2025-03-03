Return-Path: <linux-kernel+bounces-541163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5CA4B96A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA900168CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F61D1E9B31;
	Mon,  3 Mar 2025 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUoqany6"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A671B0406
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990827; cv=none; b=HQMZu9kINFheii44cOfw0UXCbpfN+0kLBe+Oc4SU2CycIgVPmtnNVg5OSw0K/yLaFMw1oshGkD811Wov9BdOr9eKTy2NgjFJHYDX1jLClYfyvsvIMMU0TWuE4J9m6anw0Iwxa2HJoA7UubyaBN3ttcumS47jOb3IuRznvQdQ1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990827; c=relaxed/simple;
	bh=Md6tUHUw7r7GXqbljVBM42ecN+wwu6huDO9jOD3T3lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDzPd0mkDsoXhSNpu1jwlXLofw+5dZJcL2dRUd8X1q5/fvlp1vJV3jPXkw+wXhsQEyJ76gcCMLDr0aR9vrmH+/i4Q0n44vGpw3Sn2ZZ//Bbra31Ypayfgx2B7oHG6RvDHPwma3gJiL0z2D6IQ0HMQcEh/l8L3MtF0IwHKuHdZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUoqany6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso3511031f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740990822; x=1741595622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bT1LQfCLCGwFX0qetA3ELWVouvB3S1JZXxghCyOJvvU=;
        b=FUoqany6vltJ5UwQRYrik4sUazPdy+5cOr5bUfKRoNMBf5ykpO/dWYW93BpOvi7mPF
         YOYdFBXGLWLqzapFB4hcEFGNHQYiHreHFJVAp1Fp5DZTZHEVwKlTIHV1N9HUMcZKH9Ry
         WpKs1yxy4lGSHpAT7s9vZe7qZkwdH/NiWdNFX1n2kUG2NxTrIZ758WaNOt05z2O8pUuI
         /Ty62W6hEBVQ00Tg2ry5/Omihj1vpxQWDNzeqFNRuOwYewp2pXq2m5TfejaWnntFM4VE
         hVgGjdtja2/1+I3ctttCT2nB7Cimx3yTgc9zOvLWSgF+ZbSzJF6GNxOJzlRJdgSBYeI+
         N5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990822; x=1741595622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bT1LQfCLCGwFX0qetA3ELWVouvB3S1JZXxghCyOJvvU=;
        b=Hn/bhz1BhGyr8rThLlz8FNHzEpGvNxOtDxhzWpOOoVqcncLKGEg/t1x7S8jvMryZ1s
         zIB6+MWxlRkTVaC3hWMTDw8aVeUzairyqd9pqyAbYcr1TMVlgWTacVRnUU7YRrWRr1Av
         BXNvaIN5FT4Imhxy35DZ7L1bf2U1D1A9evDDh7nELdYYNm2Hrkl00nqpLQpD2JzmvZ6D
         HVSWthU9qvOZDpLNbq8WomOg6sTAORQCLZI+Yo1pAGpa1m/mognba7HHsyL4soqAj/Qv
         Lww4BjvjrmhBZid9r7eHWXGjS15V3SwJmXtUgggFloRTqUTTOKxJM+rF5pwrJmgWHyBh
         Lw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFuuYCkB+mSikOwy6rOJelkDB2lhLU8oPP10pl+ZYo7wbHikYJM9vducSHLlBB8NYdnkwq7jykkYWmdb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgVjy9DJtJYwkWEZZVFefNc51J/jba+0+s9LBzTSTRW0SRmH/
	RhonIBgF8EJgBxFG2IAN13cTCEs5Yp3s86GCgaA5cRI0MjA0XtbU
X-Gm-Gg: ASbGncuuFvxw4qBTwlgVfze14mQySJMXJ6JMdqwd0C3WaXYTe8EVUREBf5VUM9oBCVQ
	BqHD3rKvWLtVd9DGQVrYHva/WrwE5ZtRgD2f6W8QhyW/beZp/jZIb+7Dfzz47qllKNhQq+ir9bF
	oTMGt9sk2q0F5vT3zxE0c2H2QlobeEbDgFmdWZxfQVXIo6Va/OBahWvMuY89v0MgvvjW6IdJJfA
	o2KTkySHFJRSlmvyk9tyQtgX8KEWKgd43jAf45y6CXYAHFVIu5LEextftenOQXOuDQDjEyHS3HC
	3HEwSjsa8jaXu/0ZScx6RRMoAL+S2C8uqJGtW5LTc5AM
X-Google-Smtp-Source: AGHT+IGoyhMpApGxBbybGU+2w7DqVmAprIREr2pjwLAwSYV8ty0wbFF8bOrHY9ajuwHbykFmytcwag==
X-Received: by 2002:a05:6000:1fa9:b0:391:e1f:4c29 with SMTP id ffacd0b85a97d-3910e1f4d09mr1213416f8f.13.1740990822293;
        Mon, 03 Mar 2025 00:33:42 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm13541473f8f.44.2025.03.03.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:33:41 -0800 (PST)
Date: Mon, 3 Mar 2025 09:33:40 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] drm/vkms: Add and remove VKMS instances via
 configfs
Message-ID: <Z8VpZJLoVq312ONH@fedora>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
 <20250225175936.7223-3-jose.exposito89@gmail.com>
 <16d2f49f-02f6-44dd-91f2-05b2e5d598da@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16d2f49f-02f6-44dd-91f2-05b2e5d598da@bootlin.com>

Hi Louis,

On Fri, Feb 28, 2025 at 04:19:13PM +0100, Louis Chauvet wrote:
> Le 25/02/2025 à 18:59, José Expósito a écrit :
> > Allow to create, enable, disable and destroy VKMS instances using
> > configfs.
> > 
> > For the moment, it is not possible to add pipeline items, so trying to
> > enable the device will fail printing an informative error to the log.
> > 
> > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > [...]
> > diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> > new file mode 100644
> > index 000000000000..92512d52ddae
> > --- /dev/null
> > +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> > @@ -0,0 +1,169 @@
> > [...]
> > +static ssize_t device_enabled_store(struct config_item *item, const char *page,
> > +				    size_t count)
> > +{
> > +	struct vkms_configfs_device *dev;
> > +	bool enabled;
> > +	int ret = 0;
> > +
> > +	dev = device_item_to_vkms_configfs_device(item);
> > +
> > +	if (kstrtobool(page, &enabled))
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&dev->lock);
> > +
> > +	if (!dev->enabled && enabled) {
> > +		if (!vkms_config_is_valid(dev->config))
> > +			return -EINVAL;
> > +
> > +		ret = vkms_create(dev->config);
> > +		if (ret)
> > +			return ret;
> > +	} else if (dev->enabled && !enabled) {
> > +		vkms_destroy(dev->config);
> > +	}
> > +
> > +	dev->enabled = enabled;
> 
> Sorry, I was maybe not clear enough, and you may hate me: I don't like
> `guard(mutex)` :‑(. I proposed scoped_guard because it makes very clear when
> the mutex is taken/released.
> 
> For me guard(mutex) is almost the same as mutex_lock/unlock. Yes, your mutex
> is always released, but:
> - without reading the code carefully, you don't know you have a mutex (even
> worse than a mutex_lock because you don't have a bunch of mutex_unlock to
> remind you)
> - you keep it until the end of the function, which may lock your mutex for
> too long
> 
> The scoped_guard solves the two issues:
> - you are in a dedicated block + indentation, so it is very easy to see that
> you currently have a mutex
> - you know exactly when the mutex is released: leaving the block
> 
> I am very sorry to make you work twice on this

It is fine, don't worry :) I'll send v3 using scoped_guard() and addressing
other review comments.

Thanks for your reviews,
Jose

