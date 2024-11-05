Return-Path: <linux-kernel+bounces-396552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60A9BCECE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD261C22235
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E618A1D9A5D;
	Tue,  5 Nov 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKA2vlAR"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77331D86C4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815977; cv=none; b=ezunlU4DO4puUcj0m6wnNXAf4+VouziCxSZgQJQeFY3pafz3ZE3l33bsgaQrfr7QLQtVJmWvpBMU74GEAogPOCVRI8l02pB4AzhZfnS/Iw4jYz+tVKrX3UzoYOb2PjreXZuT7y9CDnuh46YyN/m4OeJCB2XGZ8ZHwiaOgG+bIwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815977; c=relaxed/simple;
	bh=hUkwBIFaHgKGdSZE77G6VlJhtFjXldaYVov83tYixZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgJfU2Sisi3K9U8jsLpJpml0ocv11bO9rd3p7f6YneWsQ39nD60Jys53nk0qgqQUIBihFIa5iIhiV3c/9hsNSjsUiZolajOWv4hr5LtbNXiVyQOcLAr1kmj5I0+mjmhSshaAzr08SEuuR3/oweAFz42bvssOW6lIUsyiZ4HbbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DKA2vlAR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3596200a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730815975; x=1731420775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d8Xdl2YqDUk9A0/HsJ2W90hRe4mWgrUkpYm3OC0EsMw=;
        b=DKA2vlARsMc9tmPYM0La6HZfNKpvmRr0/gZOBQwHIJ1FWV9UvXcUgJhSbytE+2lB8j
         HC+Km7XMVQsPU4aI975HqsKrH3M9jVu45aL4FpVwJKOfsf/QRZZgeKVjyxTR1ZsoA/PS
         0fg7Sl9tavPOaWB4clvUdFOuerTl079hnGsbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815975; x=1731420775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8Xdl2YqDUk9A0/HsJ2W90hRe4mWgrUkpYm3OC0EsMw=;
        b=oLkp1yk/r2jCwc7mFIASBBskTLqMJ5Ub/L73NSONTpN7Kk2a5V2euV3TGLs3hCtc9Y
         ubV5CK6psSB+LecO2aIC9Ienk69GDHtUOLv/UOf/GVfEsTn7KRW280rRZUsfhC7AYBqX
         9q1LImQAe1KiakxOWbuCG9sdBtpX1eGIVEwMGtEzF+sd1VxRr0Qi2BJnJFAR0AMDQFpY
         Qw4GePZv2o2+Dp8a+KYfB9kp/g4sEpkdo4BjZ9bw0t+vY67P+/bm73V8rvQy1jd2SSHc
         u0v8KVLKfpZ1aboEDvQsagC7ezAtJVWz2SCTS0g4QHpLoAK1j489qrwYSvm6P1p6LgF/
         Efpw==
X-Forwarded-Encrypted: i=1; AJvYcCWj4+NfvZrUFUKc1Q9Y8AdclQXMpbFK2oTHBYbw0YKtrZFLJ+I04I+R7TkOKjEDH5hG8PDa+43DTwZJ+qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJKD4wXltot5o1s3qXxdywSo+Xor7gDdM5P7FUl0N+eIgZqv/
	gzL5GlmKQMP2sSmUT7gmEuujw+0lgwHjncQFdkeD5o70Sg5o46OdDNpN0lg4EAl/3E2vzkko6mM
	=
X-Google-Smtp-Source: AGHT+IHyuqu+8VffrCMmSdS3/jb9xBpFJuwhWVxT3hhtkenbRK/sStxUywd+M7T+bq5CCB0Bsp9izA==
X-Received: by 2002:a17:90b:1c85:b0:2e2:9e64:c481 with SMTP id 98e67ed59e1d1-2e94c2e2caamr23067678a91.22.1730815974969;
        Tue, 05 Nov 2024 06:12:54 -0800 (PST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa11af5sm12040094a91.9.2024.11.05.06.12.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:12:53 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so4166987a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:12:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVu69QOQvtH/CK+H2mFmmu79JdbF5FaQL7p+bcD5vxaRqr5ymM3Wu2kM2fczlfoII6s+u8GFGw6GZciz2M=@vger.kernel.org
X-Received: by 2002:a17:90b:2803:b0:2e0:7560:9338 with SMTP id
 98e67ed59e1d1-2e94c517581mr23012661a91.25.1730815972500; Tue, 05 Nov 2024
 06:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-uvc-crashrmmod-v4-0-410e548f097a@chromium.org>
In-Reply-To: <20241105-uvc-crashrmmod-v4-0-410e548f097a@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 5 Nov 2024 15:12:39 +0100
X-Gmail-Original-Message-ID: <CANiDSCvC1T40ozrjsEfTQnnvE83YeSbELaO04027FR=FkpwD7A@mail.gmail.com>
Message-ID: <CANiDSCvC1T40ozrjsEfTQnnvE83YeSbELaO04027FR=FkpwD7A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] uvc: Fix OOPs after rmmod if gpio unit is used
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi

Please ignore this version. I screwed it up when I prepared the set.

Sorry about that

On Tue, 5 Nov 2024 at 15:06, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Changes in v4: Thanks Laurent.
> - Remove refcounted cleaup to support devres.
> - Link to v3: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v3-1-c0959c8906d3@chromium.org
>
> Changes in v3: Thanks Sakari.
> - Rename variable to initialized.
> - Other CodeStyle.
> - Link to v2: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v2-1-547ce6a6962e@chromium.org
>
> Changes in v2: Thanks to Laurent.
> - The main structure is not allocated with devres so there is a small
>   period of time where we can get an irq with the structure free. Do not
>   use devres for the IRQ.
> - Link to v1: https://lore.kernel.org/r/20241031-uvc-crashrmmod-v1-1-059fe593b1e6@chromium.org
>
> ---
> Ricardo Ribalda (2):
>       media: uvcvideo: Remove refcounted cleanup
>       media: uvcvideo: Fix crash during unbind if gpio unit is in use
>
>  drivers/media/usb/uvc/uvc_driver.c | 30 ++++++++----------------------
>  drivers/media/usb/uvc/uvcvideo.h   |  1 -
>  2 files changed, 8 insertions(+), 23 deletions(-)
> ---
> base-commit: c7ccf3683ac9746b263b0502255f5ce47f64fe0a
> change-id: 20241031-uvc-crashrmmod-666de3fc9141
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>


-- 
Ricardo Ribalda

