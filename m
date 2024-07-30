Return-Path: <linux-kernel+bounces-267963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6CB941E73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A72822FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFFE1A76C5;
	Tue, 30 Jul 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1Po+Yvf"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AE1A76BE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360542; cv=none; b=ZOTCz4aspqs664uyfXqf5bREC1C/5//+tQwzGwDaH+uDN2YF/DRbbPxAyHHlwx03/jaH309qaurE71wMatQVFEB0yAtsS28FosIhvu/JNAfAFLTZ5AwOAWb20IPqFY2manC5igORy0260d1xETQXr6T5I7Iz7HLnQpAWv8yQfI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360542; c=relaxed/simple;
	bh=JP1s8QjYEdh+uFt+cmIt4OJAgmgev3dxGNW2dQ2XwRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7Lf4+InpaaRqsKUiF6ZM9EpzrT+lraF0grvJ9yyQGqqUmOEPMUVeUq0DHD2h1Uv7bm/49Nnwl8PVu51tvax83Wdes9D/2Go0w0uLECZfrMgEyXwYWlbyjzzlr+4vI0+IYVbpUP+JxjHU5rCdUeap+xWG4tsescs1kG2/px3OZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1Po+Yvf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6518f8bc182so857657b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722360540; x=1722965340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP1s8QjYEdh+uFt+cmIt4OJAgmgev3dxGNW2dQ2XwRU=;
        b=b1Po+YvfPuzhtiuM3ahXtPb4nIh8j7dLANVBQDvmnz5XwYGYbmLayKVZXMm8g64nKb
         ks8CSc1flN1ZVCVvcAkqxZNbqMPZFWOMRambL44fzfn9au5etrhnmT2IkcP1cbgngPxT
         VY6fdh3EWRk819vlaJ2BQQdOPofTBKs+u6Yvz7Kh53iYKVOHuTU4+zk5KLdrcZnObztF
         rF1r2d8vt8Ki0Ahgtsv6lmqLCVoOy68OO54h+2eXWCe/yQC3lYlKRMkd2/Rx+qxmKyXB
         6PJ9ZGhgg10plGQ3i36S/ypdmZwOJjdQ9f5fw7/mtM2vOsHh08Q8X80+qlXJPeJzT/40
         2SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360540; x=1722965340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP1s8QjYEdh+uFt+cmIt4OJAgmgev3dxGNW2dQ2XwRU=;
        b=bCNFAdVrqFXFoi+AeGoW76AQtDmlQSY8f4OQjR5kEl6fhRAVHjyb4K+KbQhh+Jc9pZ
         6YyaurCxft35yym7JKMfOUBKOry+zSVqGQoOUrbLBNlI8KlcU4kY0FmUEYF+VczGQjbS
         zXu3Ol1efdPyACh7LX42NBFukK33ifI72i+4oQtwgMkLzwdP4eSwFG3a2juCoos94FMj
         zCOrRasd3llzAW543DD2Q5A80jHDPJpOnK/OA0LSxvNAEIJo9wRHxBsND+1Ykiw4K1ld
         mi2HZGXb+ArQ8igaOg7ST4tanqbVFuBYPF5NDHcK5q7eML9WKQyY2f3R+4evNuwNvz7F
         i+mA==
X-Forwarded-Encrypted: i=1; AJvYcCUPvdACaxttOS/hhBlZNZ0J25MawtV2vf57xq8Oiw+20FWbKqggKCAnhAt3/BAnKEgW/GhNOHLTcelUPxMRtnG6plhx2mT7xur2je/r
X-Gm-Message-State: AOJu0YzyMjMhcN1GMPRkaBOLtBGw9HfrjRLtMBT/AJALxfRCoVZzpxsU
	9UaYfs+H6OMsmHSICkYkEPUQwlqAoBJkPsVIDo4Taf3zHmmIGgpXoqgaHzo+R36GvuVjLTtYx7m
	Kvg6FdwndsTqMU+UvaNAKzZt+0LE=
X-Google-Smtp-Source: AGHT+IHjhwrPp9CibFnetfBtnFVu8ekaB8v8h7DpbGWNITgABcH0CpPLw7LAylTC580BwBw9woSzMfuBDmpv3rONZMQ=
X-Received: by 2002:a05:6902:1202:b0:e05:eccb:95f5 with SMTP id
 3f1490d57ef6-e0b9e1fa50bmr2913232276.18.1722360539852; Tue, 30 Jul 2024
 10:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726185825.142733-1-computersforpeace@gmail.com>
 <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org> <454deacb-88cc-4ab0-80b4-006d863a56d2@linaro.org>
In-Reply-To: <454deacb-88cc-4ab0-80b4-006d863a56d2@linaro.org>
From: Brian Norris <computersforpeace@gmail.com>
Date: Tue, 30 Jul 2024 10:28:48 -0700
Message-ID: <CAN8TOE8-9=P7p8Tkc+5kG5Sqan+RAWAc7k2VH-p5W9hR-bb_Xg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>, linux-mtd@lists.infradead.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor, Michael,

On Tue, Jul 30, 2024 at 4:33=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
> On 7/30/24 7:51 AM, Michael Walle wrote:
> > On Fri Jul 26, 2024 at 8:58 PM CEST, Brian Norris wrote:
> >> These flash chips are used on Google / TP-Link / ASUS OnHub devices, a=
nd
> >> OnHub devices are write-protected by default (same as any other
> >> ChromeOS/Chromebook system). I've referred to datasheets, and tested o=
n
> >> OnHub devices.
> >
> > Out of curiosity, there is also a hardware write protect switch
> > somehow, right? At least that's my understanding how verify boot
> > works.

There's a whole doc on this:
https://www.chromium.org/chromium-os/developer-library/reference/security/w=
rite-protection/

Short answer: yes.

If you want to see how this fits together in practice on a
non-ChromiumOS system, you can see my companion OpenWrt work here:
https://github.com/openwrt/openwrt/pull/16014

Basically, I just try to make it easier for tools (in this case, the
CrOS vboot tools) to find the write-protect GPIO, and cross-reference
that with the software (MTD "locked" ioctls) protection status. We
need to understand and manipulate both if we want to (temporarily)
remove write protection, while otherwise retaining verified boot
integrity.

> >> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> >
> > This looks good:
> > Reviewed-by: Michael Walle <mwalle@kernel.org>
> >
> > But could you have a look whether this flash supports SFDP.
> > According to the datasheet it looks like it does. In that case,
> > could you please dump it according to:
> > https://docs.kernel.org/driver-api/mtd/spi-nor.html

Sorry, I didn't notice this doc. It's not technically a "new" flash,
so it doesn't necessarily apply, but for the mail-archive record:

# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450000100ff00000109300000ffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffe520f1ffffffff0329eb276b
083b27bbffffffffffff27bbffff29eb0c2010d800000000

> This would help getting rid of the no_sfdp_flags and size from the flash
> definition. Another reason is that the SFDP dump can help us
> differentiate between flavors of the same flash, if it'll ever be the
> case, and help us keep backward compatibility.

I wonder, since manufacturers seem to reuse IDs sometimes, is it
possible (or, likely) for SFDP and non-SFDP versions of the same flash
to exist? I'm not really sure whether I can truly drop the non-SFDP
definitions.

> Also, if you care, would be good to extend the SPI NOR documentation on
> how one shall test the Block Protection.

That sounds tougher. I don't know that there's really a standard
toolset for handling protection -- I guess the 'flash_{un,}lock'
utilities in mtd-utils qualify, but they aren't even packaged by
relevant distros (e.g., OpenWrt; but I guess they're in Debian). I
typically use flashrom, since that's what ChromiumOS uses, and it's
available in OpenWrt -- would that be an OK basis for docs?

It's also highly conditional on what sort of range(s) the flash
supports. So it's almost like we might want a programmatic
write-protection test suite as part of mtd-utils/tests/, rather than a
bespoke narrative document. Which ... is getting a little larger than
I signed up for.

Brian

