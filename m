Return-Path: <linux-kernel+bounces-371928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E79A423C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714131C22360
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11F2201254;
	Fri, 18 Oct 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ex7sTEWR"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D171FF7C2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264980; cv=none; b=CAknoB4XSmER0YP5NMLmEz12lzzEzjbbjAQiJtQ9pz83XiSrVzEDlTqhhoREs2sdyvJNBlKvUQ4Me/3ylDIm3GA4GDcYS+Ii9YY0CEiOPKINtns6CsnZ5Pbhm7g/JI7UlpyG7wugA0l5TsruEAQRHSYCxIt+mRAo+3nHi/j0ZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264980; c=relaxed/simple;
	bh=ppghXajr7mhEOYXY5xWy2NDJw6Rv7mCbsa8gnAaqBBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZShM5ueNFT0H/CsgX8TopIlf0AUMBAj2QUE9Wn+9CZnxK+HfI4xTwj7Zabo9DFO1NTr43fRuqOubNb8R8Oiwxc55R95MUPaIAaT3Duu1EetUDk6w7oENZAqrDpHbiBezTH5i9Gjb/32McettDojecWZX/iRPrnqcda/nJCGLiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ex7sTEWR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e4b7409fso2275733e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729264974; x=1729869774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvYOf2b92tGv/0UJsbZFFQLBbdVKWDuRIravkxYfymw=;
        b=ex7sTEWR7kMY4kp4SMCdopAiWpmUWFf4b/J7yH7vEPlSNc97MPoIMzyIfonhHjax5e
         kVAFXz0vuODKPwWNivFDsW0EGfAcqhOrSTpg/uMkg/Z6v1p216yD3dal6QJ9M2i8ozjz
         MM3+iW4NfIcIYENqAU6umA+lrSVPImWsMIYHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729264974; x=1729869774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvYOf2b92tGv/0UJsbZFFQLBbdVKWDuRIravkxYfymw=;
        b=UQjEx6aCEjoUEpGP5TR2/gqbekU3oVFIHbQoqDjXtXPcsV7oMywEgzrQFxCsHDHDnT
         v4oDk9+yGIdSy6VpL0o0zShCMrSMEHll7oOBPYebj3lMlvtph/fugzV9u8cKMYvSN/Pd
         7fCjBKoIpRcWey+ZuHaAMkAHt4OT6qY3YoLGJu8imqEy+lGrtu4YbWdVTiWXue1uHs1j
         e0pkZNF5VCCbLDdJ4BkN4Kdlzxl44ao7YSHWMBki2VE8jA/D8kmJIyAFCzQjuEOJfv78
         3U0MdPTrCsu0aqR39tutrd9y2a/KJiGnc5+4ADjBI6nvoxmCugM3NnXh0E2bqtfXvqi9
         KUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6PxMpnt4LcazRZcmn9j98iS4MAIMc+1GlNsvBXg4sD8sXW8mDdZEXTqY7DPq9/7Lo7GVOii5p/BZ6U1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDCht8MRcAGdpvjFjworHlTN06HA400ilXON1Br1Wv9Cn1Rxc
	fAw0k20QNkTfL4DEE+jIHr+mSTWcrE/Oj3zyX8Zi/Mda1ymXqrkIb3VIQINYxHXownuYdmXmfJX
	XO59f
X-Google-Smtp-Source: AGHT+IGYk7EKDSVEhQU9YdpEFxIgJw4+kPc1V5xqWWCOajZXdobO5DVLVXZz+wtrX2vC/1MF+imj8Q==
X-Received: by 2002:a05:6512:33cb:b0:52f:1b08:d2d8 with SMTP id 2adb3069b0e04-53a15844da5mr904442e87.7.1729264974446;
        Fri, 18 Oct 2024 08:22:54 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a152044a2sm244541e87.227.2024.10.18.08.22.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 08:22:54 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e8586b53so2772048e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:22:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUadNWQHg/diFwV8+PkZGPeo/xwv/KKZGvvJOm/nmD/JGGIbc4gAj3FNtTEf9IuVyjms5/8nTQQ1IVIgwo=@vger.kernel.org
X-Received: by 2002:a05:6512:39cd:b0:539:ea33:c01b with SMTP id
 2adb3069b0e04-53a158456e9mr874666e87.9.1729264972196; Fri, 18 Oct 2024
 08:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018141337.316807-1-danielgeorgem@chromium.org>
In-Reply-To: <20241018141337.316807-1-danielgeorgem@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Oct 2024 08:22:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XNTgzccjkQOnuTcYtaUK+ZRU1DbqYdnNOOD+TrVGn9xA@mail.gmail.com>
Message-ID: <CAD=FV=XNTgzccjkQOnuTcYtaUK+ZRU1DbqYdnNOOD+TrVGn9xA@mail.gmail.com>
Subject: Re: [PATCH] r8152: fix deadlock in usb reset during resume
To: George-Daniel Matei <danielgeorgem@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>, Hayes Wang <hayeswang@realtek.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Grant Grundler <grundler@chromium.org>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 18, 2024 at 7:13=E2=80=AFAM George-Daniel Matei
<danielgeorgem@chromium.org> wrote:
>
> rtl8152_system_resume() issues a synchronous usb reset if the device is
> inaccessible. __rtl8152_set_mac_address() is called via
> rtl8152_post_reset() and it tries to take the same mutex that was already
> taken in rtl8152_resume().

Thanks for the fix! I'm 99% certain I tested the original code, but I
guess somehow I ran a different code path. I just put my old hacky
test patch [1] back on and re-tested this to see what happened. OK, I
see. In my case dev_set_mac_address() gets called at resume time but
then the address hasn't changed so "ops->ndo_set_mac_address()" (which
points to rtl8152_set_mac_address()) never gets called and I don't end
up in the deadlock. I wonder why the MAC address changed for you. In
any case, the deadlock is real and I agree that this should be fixed.

BTW: it would be handy to include the call stack of the deadlock in
your commit message.

[1] https://crrev.com/c/5543125

> Move the call to reset usb in rtl8152_resume()
> outside mutex protection.
>
> Signed-off-by: George-Daniel Matei <danielgeorgem@chromium.org>

Before your Signed-off-by you should have:

Fixes: 4933b066fefb ("r8152: If inaccessible at resume time, issue a reset"=
)


> ---
>  drivers/net/usb/r8152.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index a5612c799f5e..69d66ce7a5c5 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8564,19 +8564,6 @@ static int rtl8152_system_resume(struct r8152 *tp)
>                 usb_submit_urb(tp->intr_urb, GFP_NOIO);
>         }
>
> -       /* If the device is RTL8152_INACCESSIBLE here then we should do a
> -        * reset. This is important because the usb_lock_device_for_reset=
()
> -        * that happens as a result of usb_queue_reset_device() will sile=
ntly
> -        * fail if the device was suspended or if too much time passed.
> -        *
> -        * NOTE: The device is locked here so we can directly do the rese=
t.
> -        * We don't need usb_lock_device_for_reset() because that's just =
a
> -        * wrapper over device_lock() and device_resume() (which calls us=
)
> -        * does that for us.
> -        */
> -       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> -               usb_reset_device(tp->udev);
> -
>         return 0;
>  }
>
> @@ -8681,6 +8668,19 @@ static int rtl8152_suspend(struct usb_interface *i=
ntf, pm_message_t message)
>
>         mutex_unlock(&tp->control);
>
> +       /* If the device is RTL8152_INACCESSIBLE here then we should do a
> +        * reset. This is important because the usb_lock_device_for_reset=
()
> +        * that happens as a result of usb_queue_reset_device() will sile=
ntly
> +        * fail if the device was suspended or if too much time passed.
> +        *
> +        * NOTE: The device is locked here so we can directly do the rese=
t.
> +        * We don't need usb_lock_device_for_reset() because that's just =
a
> +        * wrapper over device_lock() and device_resume() (which calls us=
)
> +        * does that for us.
> +        */
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +               usb_reset_device(tp->udev);

You seem to have moved this to the wrong function. It should be in
rtl8152_resume() but you've moved it to rtl8152_suspend(). As you have
it here you'll avoid the deadlock but I fear you may end up missing a
reset. Maybe you didn't notice this because commit 8c1d92a740c0
("r8152: Wake up the system if the we need a reset") woke us up
quickly enough and the previous reset hadn't expired yet?

In any case, please move it to the rtl8152_resume() function, re-test,
and post a new version.

-Doug

