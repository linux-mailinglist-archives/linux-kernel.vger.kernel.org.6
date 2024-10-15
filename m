Return-Path: <linux-kernel+bounces-365098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C9F99DD77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234781F23EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F31175D54;
	Tue, 15 Oct 2024 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lewbo6iy"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1FA175D48
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969750; cv=none; b=onTjwZo+QDrD5xcy6s6as2f6TWit4+d0ff371uLlH/+5FcqdmwdRzXA7VywqjMAb0CcDsT7gvBciNIXd9FmgXFkXD73u4hycw+PoFpYswqcVzKdMIKH0/01G7KACIccsFwoNbragjyUrsH7hpClJe0tuvB+E+P991g+1a42hEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969750; c=relaxed/simple;
	bh=QroOQcxlNuix6nORrJFaZjYUpe/qnnT7RocqztaVH6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSKs7U/MzKK6WH09fkuEzq5ExSM+Is8MRhencDHnJo7hnfo9GGC9ixKzGts+ibc1bmZyXKN+kgtslw2LQ4xAJL+cUqfXefa7lXRiXzst40ipel3mow7IBSCR43+mdUi/MN2c7H+sfkXwDPIE1CzHjQtJMcUBtZnHRshQS8zTvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lewbo6iy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e8586b53so1999355e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728969745; x=1729574545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2amfIbZSfwwrInuc60WPLo9Bq9qEZCLpcMAyCEJ6kmU=;
        b=Lewbo6iyk4u7kTWaOVRnQzCOQ7wTbOt0UUNEGRHEgwFn2JIcj20DaQNjgK685JjrUc
         1NF3gAOSlzR5FzQEH3t0RMRDwQzfV+lk+Rn7Qu7HTvCEX+ObgwyYLk0vPRh96E7XPq73
         p1wcd0OI6qd28wQX3RD/Sc6lGtNKlqXqE5lDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728969745; x=1729574545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2amfIbZSfwwrInuc60WPLo9Bq9qEZCLpcMAyCEJ6kmU=;
        b=ed7SjN/cgmvTNkRuXd6QJ2R6oUsfx7Sl7lRrQpHW/1qHYKyIoLs5o0/fgU9N1KJhYJ
         cSb8ckjTE2XKirOYJvkjNT9pdcypwqY4IY73ZU+/Qd0xOIqBC9PP/Iqnkzq/ac0DTL2V
         /YzV03OY6Gg8DHBOLGsnXHlC1Prwpcitdhtqg+CNQchzKP/lHZ2mJTWF4im4jhL+hmWS
         JQCVQmiJPS8vhcAhAxNxSAClkKtvsmE9yr6kYuQrw1gEFJtYxkGrYEvJlRGchLIf7kHa
         8eyneUWNlE7RoT6VZ4QiCKCyo4YlQYgJKk1EBs+wAPFIsYq6DmjfBVbmdyjw3KJOJ3a6
         T0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXA2PjvGqfYd6YpnNgR7NMWFgrASU/0kJi0guGPw71NXX6STj14CTwkMAggW2IddKV/MH02j8qhVh/MXDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fPDEi1Yq96oB9BajyKTRRYToW83Gj+9UN+ErR5CrhKT12DQJ
	SDIDy/scjg8JEmTXSVIBheyMCvGQq42dxDBD1kUsFdbPd86JySplHWjzB8LrMP8xqnnSo8MkbSG
	AEKSqtDoeNvxzeyXWcGQ2YKBDectikk8UEeNW
X-Google-Smtp-Source: AGHT+IGnCYIKC4fxrTKf7KXrK4wtSw6kzD/gty96rpQnFBMMz91hHJcgXAFaBjG2JNXIFl/CWbfvb9I+Di9bhTdNMZc=
X-Received: by 2002:ac2:4f0a:0:b0:539:e263:331c with SMTP id
 2adb3069b0e04-539e26334a7mr4023423e87.17.1728969744956; Mon, 14 Oct 2024
 22:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-5-wenst@chromium.org>
 <ZwfvuA2WhD_0P3gL@smile.fi.intel.com> <CAGXv+5Hm62hFsF27B-cEWTJ_AKrhcfCPaqR7BxmpwnjABzwHTQ@mail.gmail.com>
 <Zwz9djqb0Q6Ujmo_@smile.fi.intel.com>
In-Reply-To: <Zwz9djqb0Q6Ujmo_@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Oct 2024 13:22:13 +0800
Message-ID: <CAGXv+5EGq=OAymON-wj0OzQjK1VxRzdvgJgbHxaYPKP_pmTN2A@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] i2c: Introduce OF component probe function
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 7:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 14, 2024 at 11:53:47AM +0800, Chen-Yu Tsai wrote:
> > On Thu, Oct 10, 2024 at 11:16=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Oct 08, 2024 at 03:34:23PM +0800, Chen-Yu Tsai wrote:
>
> ...
>
> > > Fresh reading of the commit message make me think why the firmware or
> > > bootloader on such a device can't form a dynamic OF (overlay?) to ful=
fill
> > > the need?
> >
> > The firmware / bootloader on existing devices are practically not upgra=
dable.
> > On the other hand, the kernel is very easy to upgrade or swap out.
> >
> > For said shipped devices, there is also nothing to key the detection
> > off of besides actually powering things up and doing I2C transfers,
> > which takes time that the firmware has little to spare. We (ChromeOS)
> > require that the bootloader jump into the kernel within 1 second of
> > power on. That includes DRAM calibration, whatever essential hardware
> > initialization, and loading and uncompressing the kernel. Anything
> > non-essential that can be done in the kernel is going to get deferred
> > to the kernel.
> >
> > Also, due to project timelines oftentimes the devices are shipped with =
a
> > downstream kernel with downstream device trees. We don't want to tie th=
e
> > firmware too tightly to the device tree in case the downstream stuff ge=
ts
> > reworked when upstreamed.
>
> Okay, I was always under impression that DT has at least one nice feature=
 in
> comparison with ACPI that it can be replaced / updated in much quicker /
> independent manner. What you are telling seems like the same issue that

That depends on which camp one is in. Some folks advocate for shipping the
DT with the firmware. In that case you are limited by how easy the firmware
is to upgrade. Or they would leave an option for the firmware to load a
newer DT from disk.

The other camp is shipping the DT with the kernel image, which ChromeOS and
some Linux distros do.  Then the DT is as easy to upgrade as the kernel.
Opponents would argue that the DT is a hardware description and should
be separate from the kernel. However as with all hardware bringup
development, one can't really describe something that hasn't been
developed and gone through review.

However here I am specifically talking about the firmware _code_ being tied
to the DT. To implement the probing feature in firmware, one needs to eithe=
r
add a lot more code about what devices the system might have, or implement
the equivalent of this series in firmware, or something in between. This
is a lot of code that depends on the structure of the DT it was developed
against, which most likely was downstream at that point.

Say someone screwed up some DT structure downstream at the time of release,
such as the node name or address prefix, and that was fixed upstream. The
new upstream DT no longer has the structure the firmware is expecting, and
the firmware might not be able to handle it anymore, resulting in some
peripheral no longer getting probed or enabled. And you don't have a way
to upgrade the firmware to fix this.

> ACPI-based platforms have. However, there they usually put all possible d=
evices
> into DSDT and firmware enables them via run-time (ACPI) variables. Are yo=
u
> trying to implement something similar here?

Yes, that sounds similar. However for us the DT is tied to the kernel, not
the firmware, i.e. not provided by the firmware. There's also no UEFI in
our case.

> ...
>
> > > Another question is that we have the autoprobing mechanism for I2C fo=
r ages,
> > > why that one can't be (re-)used / extended to cover these cases?
> >
> > I haven't looked into it very much, but a quick read of
> > Documentation/i2c/instantiating-devices.rst suggests that it's solving
> > a different problem?
> >
> > In our case, we know that it is just one of a handful of possible
> > devices that we already described in the device tree. We don't need
> > to probe the full address range nor the full range of drivers. We
> > already have a hacky workaround in place, but that mangles the
> > device tree in a way that doesn't really match the hardware.
> >
> > The components that we are handling don't seem to have any hardware
> > ID register, nor do their drivers implement the .detect() callback.
> > There's also power sequencing (regulator and GPIO lines) and interrupt
> > lines from the device tree that need to be handled, something that is
> > missing in the autoprobe path.
> >
> > Based on the above I don't think the existing autoprobe is a good fit.
> > Trying to shoehorn it in is likely going to be a mess.
> >
> > Doug's original cover letter describes the problem in more detail,
> > including why we think this should be done in the kernel, not the
> > firmware:
> > https://lore.kernel.org/all/20230921102420.RFC.1.I9dddd99ccdca175e3ceb1=
b9fa1827df0928c5101@changeid/
>
> Perhaps it needs to be summarised to cover at least this question along w=
ith
> the above?

For the first question, it boils down to we think that the firmware should
be simple and do as little as possible. It also should not be tied to a
specific DT, so editing or fixing up the DT in firmware is something we
avoid. The firmware can do overlays if they are provided, however in this
particular case, the identifiers used by the bootloader don't cover the
variations of the I2C-based second source components.

For why autoprobing isn't a good fit, I believe my answer above covers it.

ChenYu

