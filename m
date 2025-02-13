Return-Path: <linux-kernel+bounces-513721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F6A34DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6E3A466F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC40F241691;
	Thu, 13 Feb 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2RE8o383"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387B1422DD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471813; cv=none; b=SB6ZXjmF7YyJawcxbLCoo+X5Hbnn9uYOIaXVR6vlvbyslaGQ7RqAAyQY5KUOk/lHNFZ4bt4tyVJVehvSsudoyqj//++zbOV8YCqUjPph1k0SlcxPS08b4WWIlNh7U4TQiDG2HrMMFIlZyeiXTpsdQMNa01UlfQpEiMFmNWbd2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471813; c=relaxed/simple;
	bh=6MXgt8K1fqxe7oAyzFvQ5u+fTJ1UmsA6LGu4qS+I3xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbZs8cN+e+DBM92xCVsCsQG+ziKMLF6N7j6CK7Za4SDDA5a7T44ximxUvAEH0Vnu1n5PHpwmrZ5b+PTnJhawE2sl9FmbEQ/+Q3ZSBEti+287Wcg0bKR7x6pxUULPo8x48wQfXgkJtZwheRQuCLwAo2QiyOWcc2P+ecBLaFeV5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2RE8o383; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30227c56b11so12559441fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739471810; x=1740076610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MXgt8K1fqxe7oAyzFvQ5u+fTJ1UmsA6LGu4qS+I3xQ=;
        b=2RE8o383D4d5qr72Hat6ZKDB9v0NIvT04HN0J46o8boFIAr0RZtzmpITtxG1+yCBEg
         JozeQwUkpSp80mcz/7YGfRvrs6rqQge70wz5oBxqKhqQBo3zPz/G49u1ncaiYEJXLZM7
         5eYVZmSiWOe8q/bPGC4sQ6TQ9fd1LbI7zhEV0zgkjqHefoIeXG1F1duau2kuTP4DMi6p
         c0zxpliv7nyHg7vyWB9RJz6Us0AjbNP+6oCbE9CCSPDE1xm/93RwC+0tPYu7PKPdcxBz
         3TyrTOg4ydRTEnc4AbNoccNHWGDSK1acmHI3wLeaqRwtVlgg/weN3w0OcyeXfVlTLwCF
         JRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739471810; x=1740076610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MXgt8K1fqxe7oAyzFvQ5u+fTJ1UmsA6LGu4qS+I3xQ=;
        b=HTzb7lzTVsKdcP7ntAwSmZvYC7YZ9bWHLSSJyhevY8ilmNG25RIJaqRRxCWUTjpxcq
         kQ1BhyGPpNli5LFyqLQj7IWdbtQPfT6fU9fOsoJ/t3G+rysdW5Ho3snFZTMhkan1ZGNG
         VDBohejMbCcSVr8F633F3TgAOaMtRgD6b07X/Su+8XZY9OOz1G/1BTEs465oPbowzNPL
         OSFg+1KJ5HokA1X/ketIQU3hVdg+KkLhVLwuxRHkHHqXgNob8VKkD8vwx812bCOQLNHP
         639llZO/9P8MBAogqqvI+6R82QbMbTrhq1IGmfzcvY+BD0d0N1Vopst/JA7GR8wkLd/t
         G3yw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6L3BED9S9U064gDCds4LRRr/ievKi2nv0lN2IHDOhm7kwTI9CLWRnPLMpAspxbi6vLhz4/15kOh45l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4cOs5K4+Fhw+OawQgXDsMFWiYnMXoMlYk1jLQAGMj8XPDbDQ
	hR6p9YFSrpza1GLrnwcQin8gxl0I02Yzc5ChJeWCipGfpNQUCuZeYxPyIC+l+JQrr2oijAb2ON/
	szFDjxSLvBOVtftAkSCcAKK9oUgYxBeG9co06mw==
X-Gm-Gg: ASbGncvOaC1KYYQn58R79i1sAKvVXFfWcfDBVhUygWF4C7PAsAkwuOwoyU1GW7AjK9I
	kUXlAU0HmWqnTv0vATCW3jcsXdoWg7jjbQ+o5w5O8CQl2Xkw+W+RUVC/8Uq57n998yiKTqTqzWN
	XtucMl9CAKgAvRP15s0BhDOGtRtfPq
X-Google-Smtp-Source: AGHT+IGS6rZ5QoysfkI0qHoJmFvWRDPx9d8qV86s8a9//PI16K2BiXEPn/UKdP9YO5UDgyQ2advyGUV8KL3E064dBuY=
X-Received: by 2002:a05:6512:1195:b0:545:9e1:e824 with SMTP id
 2adb3069b0e04-545184bc12fmr3451856e87.48.1739471809751; Thu, 13 Feb 2025
 10:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213182527.3092371-1-andriy.shevchenko@linux.intel.com> <20250213182527.3092371-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250213182527.3092371-2-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Feb 2025 19:36:38 +0100
X-Gm-Features: AWEUYZkqCv_yLp89wB5ocJkqXxJ0d_HsrRMQvT3Q1hOD30OWbUeTKkdx_i3cu5E
Message-ID: <CAMRc=Mf0MMKB40gC1hJLwY1i1Bjj+aKKDfFN9sYUzG_Z5Hu1iQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: Move for_each_if() to util_macros.h for wider use
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Alexandru Ardelean <aardelean@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Other subsystem(s) may want to reuse the for_each_if() macro.
> Move it to util_macros.h to make it globally available.
>
> Suggested-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Who would pick it up? Should I take it via the GPIO tree and provide
an immutable branch for the DRM tree?

Bart

