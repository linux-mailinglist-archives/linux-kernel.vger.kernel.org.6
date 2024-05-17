Return-Path: <linux-kernel+bounces-182626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605F48C8D79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F571C221BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF200140363;
	Fri, 17 May 2024 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ERloO8o"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E191A2C1E
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715979244; cv=none; b=pJsACbVvT5/R7z2immAVWRIFhapK+mL6c91YOX1awWu7mKPLh9J1fN0lNssdtTw2sQDOe4OPsUlQeiC89yqkIf4AYorlU28rxIh8evDVV/pJBV5QnwIoJq8jn01lVV802Ec7zyIURsxnpOpgSKd5s1MqrKbYr38AkIumLO0+XHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715979244; c=relaxed/simple;
	bh=vn13dLP5pRrsDv4NOdbcqGoQN2bmYpHdTGHpP55EB4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgEIBhm7ihwFzGGgHu66DWD1smbBIzdrKm2IoW4Pl80vnJqVg+jSfb9BYIeeQ7AUfjMdC+POT3iIcG59seE6NzS7Wm8u3o6PJ2SptNgF51O7/EXgRo2bUlr61hWR1VBvejC5+B4DJHVi65dz415g7rLT+czQMXHsjsfc1AWnG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ERloO8o; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso4905a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715979241; x=1716584041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn13dLP5pRrsDv4NOdbcqGoQN2bmYpHdTGHpP55EB4g=;
        b=2ERloO8odOMloUw8cFRMxlB643roWDB8ViPC+u+m6wveygHhji9yYKsynG1Z0tmHG2
         vRD8jii3rPmUfYQztBKv5+oCWywvYAs8xizFq1Emu3142DqU0p3hQZ7+gY48ejgxZ9Q5
         jEeBUyy9oEtteJq26yFJPXjGdfVRJF19+FhvhyARUB4ro65VGLq0P0E6N5rTbkzcKcal
         XQv6/zsFMVEbIfdyMOYLHPznBDIi+vTI+mJbZLzJWcMbtbBveo6JPiwGYV4B/0qeyJlA
         KbgaNlp5cadRa1ejK/OAnxTHwSsiucOnr7lfWgxQJv5oQTKwYL7Q9p9qcuYJE7Qg1Xvu
         uDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715979241; x=1716584041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn13dLP5pRrsDv4NOdbcqGoQN2bmYpHdTGHpP55EB4g=;
        b=mTVA7X5TBIZrD85N2Xe06MjFf/5KVziiq/wWd/sMpXWaYECu3PlclIpsVVIFjWXP9R
         6A1dIFVE54IxQJaavJ3R4pf8n4QM33cOqemTmIhVKvtf/QJeo8lU0ETH1wlWh5hmV1xG
         P0qNxWmJR9O4EnBWSG/DlFPpcVrvfsC7x9sjW1FwTEvTDgsWTaXCtQPwLGcRnjkhrc4a
         wwjIaQF77IoyPH3B/iWqeY7aV6IcHsW8tylw9rwVvrYUMf7WWvNom5x6jfE6kAcs9YJk
         ggohdS31b43HMGlG7H9E41wvXaX1ly/TTPynqb6f/HfgDeuI+8KaRe9hfTs66rJyZp59
         cfYA==
X-Forwarded-Encrypted: i=1; AJvYcCX/owGKqF6awzyRWMrZiuZ/U2ommtNv8cRyh70vv+0w8DN5qbluJTriOJeLH/k8QpmmMLsBySmPXajAhWH7/4nvp7Z5pJRaVXyq8vn7
X-Gm-Message-State: AOJu0YzniOjqzBaBC1M2clYiJQPSetykJQyGWko5C0NVTPHfsjNcHZZA
	lp+6E7q5XTPpz5BqDNjHwNtscxVpRLrSzibkH+T88j9lfaxhMO+vbseLpetExfJ9/+AH4RwBZdh
	BSXdxjxLsnWGTTlbwRur7QNVDIaYNFSuTjz2J
X-Google-Smtp-Source: AGHT+IFRAIfV54+Aa1LbyF88d23hN+YT1t2sexWDi9c3fyTst75D5FRNvAf6sgXSn3IVxUNlK5yurWk/GWDFHEMqw/c=
X-Received: by 2002:a05:6402:2158:b0:573:438c:778d with SMTP id
 4fb4d7f45d1cf-5752c3f15c3mr3670a12.1.1715979239492; Fri, 17 May 2024 13:53:59
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517171532.748684-1-devarsht@ti.com> <20240517173607.800549-1-devarsht@ti.com>
 <Zke6o3HYnUrgtD0K@smile.fi.intel.com>
In-Reply-To: <Zke6o3HYnUrgtD0K@smile.fi.intel.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Fri, 17 May 2024 13:53:47 -0700
Message-ID: <CAGS_qxpCM=Aw1J_EVQPZv_nDy0zCp6JqxfQk5mGkV+5iCe1OZA@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] lib: add basic KUnit test for lib/math
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benjamin.gaignard@collabora.com, sebastian.fricke@collabora.com, 
	akpm@linux-foundation.org, gregkh@linuxfoundation.org, adobriyan@gmail.com, 
	jani.nikula@intel.com, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	laurent.pinchart@ideasonboard.com, praneeth@ti.com, nm@ti.com, 
	vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com, b-brnich@ti.com, 
	detheridge@ti.com, p-mantena@ti.com, vijayp@ti.com, andrzej.p@collabora.com, 
	nicolas@ndufresne.ca, davidgow@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 1:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> > [devarsht: Rebase to 6.9 and change license to GPL]
>
> I'm not sure that you may change license. It needs the author's confirmat=
ion.

Checking, this is referring to the MODULE_LICENSE, which used to be
MODULE_LICENSE("GPL v2");

and is now
MODULE_LICENSE("GPL");

If checkpatch is suggesting that now, then changing it sounds good to me.

>
> > ---
> > Changes since v6:
> > * Rebase to linux-next, change license to GPL as suggested by checkpatc=
h.
>
> Note, checkpatch.pl is not false positives free. Be careful
> with what it suggests.
>
> > +#include <kunit/test.h>
> > +#include <linux/gcd.h>
>
> > +#include <linux/kernel.h>
>
> Do you know why this header is included?

I think I had put it in the original before a lot of the work you did
to split things out of kernel.h.
I haven't had time to look apply this patch series locally yet, but
I'd be pretty sure we can remove it without anything breaking.

Thanks,
Daniel

