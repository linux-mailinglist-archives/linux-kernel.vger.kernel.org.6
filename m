Return-Path: <linux-kernel+bounces-286238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE7C951869
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60BF283ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1F61AD9C8;
	Wed, 14 Aug 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/iEdSU3"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCEE1AD9C3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630218; cv=none; b=rXAk5kFWT+yNExVLPgy7Le/nIYaxBOEjEeZIDlZnfUsVcd0H8/gtINAF2yeLq5gdfHv5LnloQLWfwTZQmiMhtgqRj8A8RcABDpuo7Ifs9J/tVsvpirUvO8ywsr5LIzyeLPjJyKcErEQ0Nz3rh151nDMp/VbI1LRulcuMTnWhahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630218; c=relaxed/simple;
	bh=HtmsSU5ENdUZpr+MPxoYuH51F28PtAovj20fVUAbRwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5UO4/UlwHe6AJgZv4JCavM1P1QXWInQC1EOiG32jyYNHlIE5ga/rzZUMWkkghM3bbnXRIoAVkDcEBU0QfBfxhh5uUt9ILJPlUQViVwmlT3oDu1TFMUzVArobZpP46qJd9wgGt7btTCRSEVYN5mfl5r2+HEB8FhrVV2Hd8+fC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j/iEdSU3; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f025b94e07so76185231fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723630215; x=1724235015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQxN/7VWNI1muBwzClG5Zirbw85McBRj904vS8Fpu0c=;
        b=j/iEdSU3Gv1uH9TUVPNvmrm/2QZpGumGlEgCXh1a8G+aqAIkvOXGrnRes9Lrj9FySQ
         xVoyqhzc2aBlr6hgPU7xeJsD0dEhX0355GPFPcKSMIk6rXUh8/jNNQ5yTbGj91V8XY1R
         cmGhzrXSkAi0yqSv6ol5zigy7mjAeL/f6iCoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723630215; x=1724235015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQxN/7VWNI1muBwzClG5Zirbw85McBRj904vS8Fpu0c=;
        b=HXSWOWQX9yYj9udoJeYDUe50EE+KwFEYve5RMdoKRRBn0Cqe/WNfqu291ZyT8Srp/e
         A4lznsbQtxm8u5a1DXEQR0z2nc3WUnooH2om/K30tb0rx4DCO+6HtcEZYBw4aNzyPaNF
         iQ45olDP3A133iXilwJ9LydzKIqq59orPTzy2qrpHMVrH03hoknf9tAR63iTtnS057T4
         IyCz9fuJCyx32RtJfBpqb9W4JG9iNGUXHBxncHh+v1b1XOZgtnFGWufmZNKLbBX6+a3J
         uwmrr3HMZOERIUJnQnGLIIWDYWcVKZ4uxuwJbYfe/7n/qIsB4nuL+hHrapHq3xEX1y2H
         +vWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/2YZ9Zgfb9XP36BdGDVj+lmqzk8I1vDi4KxAdv3NyxmYDKC+8DUdIVSMFAq1ydF7mRpmCs2i73jBrg+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDH2hW91u9teLp2ztGhSs63MvhrB+y8tkq7+dvByTEkx4vPZ3S
	e+R+dsmon7UjNZggikv3BzVi0XV9Rx+jF7ujRVMoQ5SbP53e4WEXpR2rkyc2Fhf3TA3lwQBGgDr
	C7jih75jG614gMJ7VzhZHOFoocfGksgbDVEYE
X-Google-Smtp-Source: AGHT+IEe32jN8gUqbf1l9ngrSD5IPLARvV8fpV4Tje3WEqH7kkd+ZQY+1xW4UvomRXZlgVtw/pLaiYHStH4ShpBNc/E=
X-Received: by 2002:a2e:4a1a:0:b0:2f0:33e:d286 with SMTP id
 38308e7fff4ca-2f3aa1a5198mr14064661fa.20.1723630214840; Wed, 14 Aug 2024
 03:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808095931.2649657-1-wenst@chromium.org> <20240808095931.2649657-6-wenst@chromium.org>
 <ZrtHhcNMiyHmKbal@smile.fi.intel.com>
In-Reply-To: <ZrtHhcNMiyHmKbal@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 14 Aug 2024 18:10:03 +0800
Message-ID: <CAGXv+5EgqdziyheOt7wzkbe036fqPcw_UpSHiMsB3W_nTB3NWQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] platform/chrome: Introduce device tree hardware prober
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 08, 2024 at 05:59:28PM +0800, Chen-Yu Tsai wrote:
> > Some devices are designed and manufactured with some components having
> > multiple drop-in replacement options. These components are often
> > connected to the mainboard via ribbon cables, having the same signals
> > and pin assignments across all options. These may include the display
> > panel and touchscreen on laptops and tablets, and the trackpad on
> > laptops. Sometimes which component option is used in a particular devic=
e
> > can be detected by some firmware provided identifier, other times that
> > information is not available, and the kernel has to try to probe each
> > device.
> >
> > This change attempts to make the "probe each device" case cleaner. The
> > current approach is to have all options added and enabled in the device
> > tree. The kernel would then bind each device and run each driver's prob=
e
> > function. This works, but has been broken before due to the introductio=
n
> > of asynchronous probing, causing multiple instances requesting "shared"
> > resources, such as pinmuxes, GPIO pins, interrupt lines, at the same
> > time, with only one instance succeeding. Work arounds for these include
> > moving the pinmux to the parent I2C controller, using GPIO hogs or
> > pinmux settings to keep the GPIO pins in some fixed configuration, and
> > requesting the interrupt line very late. Such configurations can be see=
n
> > on the MT8183 Krane Chromebook tablets, and the Qualcomm sc8280xp-based
> > Lenovo Thinkpad 13S.
> >
> > Instead of this delicate dance between drivers and device tree quirks,
> > this change introduces a simple I2C component prober. For any given
> > class of devices on the same I2C bus, it will go through all of them,
> > doing a simple I2C read transfer and see which one of them responds.
> > It will then enable the device that responds.
> >
> > This requires some minor modifications in the existing device tree.
> > The status for all the device nodes for the component options must be
> > set to "failed-needs-probe". This makes it clear that some mechanism is
> > needed to enable one of them, and also prevents the prober and device
> > drivers running at the same time.
>
> ...
>
> > + * Copyright (c) 2023 Google LLC
>
> At bare minimum we are in 2024 now.

Ack.

> ...
>
> > +#include <linux/array_size.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
>
> > +#include <linux/of.h>
>
> Why?

Might have been left over from previous work and squashed into the wrong
commit. Will remove.

> > +#include <linux/platform_device.h>
>
> ...
>
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(hw_prober_platforms); i++) {
> > +             if (!of_machine_is_compatible(hw_prober_platforms[i].comp=
atible))
> > +                     continue;
>
> > +             int ret;
>
> I didn't know we allow this kind of definition mix besides for-loop and
> __free()... Can you point me out where this style change was discussed?

Will move to the top of the for loop block.

> > +             ret =3D hw_prober_platforms[i].prober(&pdev->dev, hw_prob=
er_platforms[i].data);
> > +             /* Ignore unrecoverable errors and keep going through oth=
er probers */
> > +             if (ret =3D=3D -EPROBE_DEFER)
> > +                     return ret;
> > +     }
>
> ...
>
> > +static void chromeos_of_hw_prober_driver_exit(void)
> > +{
> > +     if (!chromeos_of_hw_prober_pdev)
> > +             return;
>
> First of all, this is dup for the next call, second, when may this condit=
ional
> be true?

When the module is loaded on a machine that doesn't match any entry,
neither the driver nor the device are registered. Hence the check.

Or maybe the proper way to handle it is to return -ENODEV or something?
I'll work towards that.

Thanks
ChenYu

> > +     platform_device_unregister(chromeos_of_hw_prober_pdev);
> > +     platform_driver_unregister(&chromeos_of_hw_prober_driver);
> > +}
> > +module_exit(chromeos_of_hw_prober_driver_exit);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

