Return-Path: <linux-kernel+bounces-347445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C9898D2D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C3DB2177B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5221CF7AF;
	Wed,  2 Oct 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="uiaA0679"
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7161CF7AE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871012; cv=none; b=BCwLLv4wdnT3VsYnC1rvyq4iqojvYJDqwOxcu0dz2hxfHPvGucc6sI7BkInExpQDNL/jMG3VooWqKFpfFEHphYibuHHOjn0317LBUo1vHhRa195u1yedS+z3MQt+szS7F+qWF1m0j5vTyUfMjyk1jge22JbT8v3EMwlwheLJ8AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871012; c=relaxed/simple;
	bh=fs8+Yu860MQFCC64c/PvlAMI8bGUZEFOyA2IRk/Z4Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4DrIc2S79OotvteYAKgJFIDQKKG79xE+edFRhyeDhn/RNuo2lNyHNEwtr3jT2RORh6a3TVsC/wXInnbPL7M0h7BAYo2eR4I+oMYB7iG77Fqlx2tEu4/aZBHpWP/LjraZJ7gkR3UWi41C8TlH9Z0fJUu6YhyFJJFhMilIrB9a8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=uiaA0679; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=fs8+Yu860MQFCC64c/PvlAMI8bGUZEFOyA2IRk/Z4Oc=;
	b=uiaA0679f4RlsGFHqF0yZs1VFGlgypUVuA25KtJjB2slFJGIrHwbsApQf45I31BR7BlNWxolmfSci
	 TF1h9o1zeMlsQEN0EsdgkHCZ3xpRemKhAQmI+U2Rk1NU2keXa+YyHypzvTtX0384GMWmvW8LkAu4Os
	 8KGdHNz0GSJKiYB3Hx53B/nCSFqgRNDJhH2a5Hyc5jxJKTH2rF9W9iy0tTLqnzs0M3e8YSDeUXIxRD
	 NscqzaUBhB0tX7gLj3PDcL+/76oZiEg73UAlycHFLseTZ1F0dRdh1tWs2nHqCzRzq9ESId9VlEIqIf
	 Oa7Woa8fSCQ50wzw0PlUpgRRxTA2DkA==
X-MSG-ID: 1916b1ba-80b7-11ef-93c0-0050568164d1
Date: Wed, 2 Oct 2024 14:08:55 +0200
From: Robin van der Gracht <robin@protonic.nl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/1] auxdisplay: ht16k33: Make use of
 i2c_get_match_data()
Message-ID: <20241002140855.3cbf1076@erd007>
In-Reply-To: <20240930133453.3403318-1-andriy.shevchenko@linux.intel.com>
References: <20240930133453.3403318-1-andriy.shevchenko@linux.intel.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, 30 Sep 2024 16:26:42 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Get matching data in one step by switching to use i2c_get_match_data().
> As a positive side effect the I=C2=B2C ID table is in sync of OF one.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20
> I believe this is correct update. And here is why.
>=20
> 1) The documentation of the I2C user space device instantiation does not
> mention a compatible string. it relies on the term 'name', which I believe
> has direct link to the field .name in the struct i2c_device_id.

Ack.

> 2) The above mentioned documentation says explicitly when user space
> instantiation should be used. And for this driver it seems the only last
> piece might be the case, i.e. prototyping / DIY configuration. For this
> we don't need to rely on vendor ID anyway as in new supported hardware
> the DT/ACPI emumeration is assumed.

Not sure what you mean here. It's statically declared in the device tree fo=
r the
imx6dl-victgo board [1].

> 3) Moreover, the currently used i2c_of_match_device() seems never be
> considered to be used outside of i2c subsystem. Note, that it's being
> used for device matching and probe, meaning firmware tables and board
> info.

4) It seems your change will also allows matching the device when it's
enumerated through ACPI.

> Also note, that the other (yes, it's ONLY 2 drivers call this API)
> user of that API is going to be updated as well. Taking 3) into account
> I think soon we remove that API from bein exported to the modules.

i2c_of_match_device_sysfs() also matches the user input with the driver
compatible string(s). Which is no longer true when i2c_get_match_data() is =
used.

Not sure if it make sense to match against the compatible string at this po=
int
though. Because I'm not sure if the device can be instantiated through
user space by using the compatible string in the first place. If so, there =
would
only be 2 drives that can get their match data...=20

The documentation doesn't mention the compatible string for user space
instantiating just to use "the name of the I2C device".

So maybe it's a good thing to remove that API or at least part of it.

Regardless, the change looks good to me.

Reviewed-by: Robin van der Gracht <robin@protonic.nl>

Regards,
Robin

1: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts?h=3Dv6.12-rc1#n278



