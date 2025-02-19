Return-Path: <linux-kernel+bounces-521623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECFEA3C001
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EBC1886163
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02271DF986;
	Wed, 19 Feb 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZFUF70SD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857E20B22
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971990; cv=none; b=UM3EBsI5Wganri47mK+9Qtv3uDuomtH8tOE/U82FrVLAT6AgZsjAGLeMzGsdr0H2+krbTx1TaWSRxJk0mZT4HXhKybzhfHsJe3mW8uzinRzZYE5evZq4l6pahzXK9sheKVYjmjrEAHwf74WEh0PvgF/UfgzcJjqi9vHOD7RsyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971990; c=relaxed/simple;
	bh=cjD26/2UAwFHsgSeZprQTMz/5m3GY77SlSgA4q9tIqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUyiX0RV3hcBHzfecWCz20vXZ1vd1efwd2WVmlYEirzYxOfy3OkcHwuV3QjZDj1blEYQ37KBetsuFipxbKwGNwLMN4S98cMUr2HJggZVP+eIWw3fd6ox8CxUCpBGVQfu/cw/j6dqSvtm5GLNg9APPG8fPK9lef+bKu9cgIFhuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ZFUF70SD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so2882665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739971987; x=1740576787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeYnr6jPu3lSIUMnd641DJ0EkSXG3SudMAp417EhFus=;
        b=ZFUF70SDBKdB1mZKTYT3kAmtiT1kiO7UWJhEXoMZ5KxCqrF7ZuZOMjOVYYtDq+wZlf
         zbimSHfo6HO6VfC+0PVKYmmrO/AnXcple9aJBiw8v2mBloqhVtSDwfJD4yhPdo7ARHcl
         Bh2GFpm/TXev1P5l0SICUY1+zNgR3D1nkFgio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971987; x=1740576787;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeYnr6jPu3lSIUMnd641DJ0EkSXG3SudMAp417EhFus=;
        b=tJnzTF9wgE6Y79E7HaP0K+BHYJmSddl1MdMdjVELjV90gVOssmhUwIsps0lLsh8/5V
         8noK7Pgx5hWmi8vOUM0yDtUOoSkFrOdOVsxmOqAjOrdXbj5Y7Aej5q/bNBXovagaJcA1
         rHWr/wmJGzU+W7pPI3d5Os9sMEIaZGEAmhI3sHDyTCX971ta+EfBVD1Oh8QFRayxu+Xx
         iOkNZWXjn0nsimYEQAbeuMes07s+p7Ft5wJYs20EPeyleVYlR6Sh4LWfBrK+iUsdq1nq
         D4zQ59GPkYXKUDh2j0HM9MBJkxxdyIhZOJ2E8+IIdhyTJNC56JuDl9Zo3dyh4+cokxQ4
         VUNg==
X-Forwarded-Encrypted: i=1; AJvYcCVGkq5eVZvpQRwwk6rOfArj7ORJk4+7Yub6oHKYVGaVOzK6NRDrxNbbSqoyxnZRWerMWKSE4yi2E9Xt8lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySS+YQuNE9M00P4dgukjmazqlFlsRwe73HD5RBDJk+waBmJgGe
	qZBvp3ukhCR/iuDTLhFLJBP96tQ11VHQ9sSI/6K4Oa6AtYgR196ecGLYZ7C7tpQ=
X-Gm-Gg: ASbGncvCK2F8vsGiAPGSQOlHGw8X2PGmQA68WEGIQyY3n5Uyv3q4Iw31iYf1THOVwrj
	KJ6PcQ6q1OmPjsHuttZv/NPQH6xSg7I0s2xAOU/Xhy/qAgfwaWJ1UMcfIk4UBWcX/740tXHe8/3
	TEWJlG/uzyXWzIszCu2CsrtTb5lmIr+AbOJv8b69A0TJv8uULK0Jozvvfz3gSNh0RPgboIPmBRV
	rUS7+z0bNWzKd9T6LM0i2H4ajWwRmEo58Hl+Tj1iDwcGAF5WlSygDWkIIADcRxP1FkMCZQxaj6d
	R4K9R9Q59OPkLJhkRnc4/Z7BX4c=
X-Google-Smtp-Source: AGHT+IEfr4282QBqEmzNfVUxfuk6xB0RBCkHqhW01JOw3jzUDHaoP/nFjPNWk6Jdq6rqr+AuCCpqyA==
X-Received: by 2002:a05:600c:19ce:b0:439:5fbd:19d2 with SMTP id 5b1f17b1804b1-43999b44505mr33869735e9.10.1739971987073;
        Wed, 19 Feb 2025 05:33:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f208sm211702665e9.6.2025.02.19.05.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:33:06 -0800 (PST)
Date: Wed, 19 Feb 2025 14:33:04 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] vgaarbiter: documentation grammar correction
Message-ID: <Z7XdkAKqlK2KJuq2@phenom.ffwll.local>
Mail-Followup-To: Bagas Sanjaya <bagasdotme@gmail.com>,
	Pranav Tyagi <pranav.tyagi03@gmail.com>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>
References: <20250207165325.3998-1-pranav.tyagi03@gmail.com>
 <Z6bKR9K16-oYMLFl@archie.me>
 <CAH4c4jKe7Q-E1LhA0KxOxEjK-gn=JY7e=2GN13X=yutaO8k3Pw@mail.gmail.com>
 <CAH4c4j+kOYMfzO5QOBg+hGe2zt4kN4f7v+mrri-2GMLzYtCPrw@mail.gmail.com>
 <Z7WOym9fl8GNPJiO@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7WOym9fl8GNPJiO@archie.me>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Wed, Feb 19, 2025 at 02:56:58PM +0700, Bagas Sanjaya wrote:
> On Thu, Feb 13, 2025 at 11:05:39PM +0530, Pranav Tyagi wrote:
> > Hi,
> > 
> > Just a gentle follow-up on this patch. It has been reviewed but hasn't
> > been applied yet.
> 
> You may need to resend the patch, but with scripts/get_maintainer.pl
> output Cc'ed so that DRM maintainers can be notified on the patch.

I don't have the patch since it wasn't cc'ed to dri-devel. Can you please
resend with r-b tag included?

Thanks, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

