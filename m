Return-Path: <linux-kernel+bounces-174264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B298C0C51
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F69C1F21DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF02149C7E;
	Thu,  9 May 2024 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="h/Btutn7"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF657149C73
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242428; cv=none; b=n6Ff8qwQMm+E0gPMUPKvLxWOCkOkAjVI2E9OhX+Vb2DabRQoxrU7vx/mwU7Lrq+9TFuP3M/+woY3v2wCOB1vGIPxpUmA4Eqh850jIEMAxPCYbaf7VU1A4xJEdO0iWsWI6TNN2cdPoy/UNK++SbfaGTRE93e8s0vNWeJx8anMDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242428; c=relaxed/simple;
	bh=lHKi0i+Sh9dU0tv5mcRO6DSSVX4y5N1Jy0QuwxVUbw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sepUGA8pN6SK98vy0TQoXrUomZ7V0nHu45PzaA1egHZ5PpISC6nKTAsza6TTmuKshVmLYGlWineDBeNDK2crumPgehkLkQ+bUnl2Lvk/xPvUz2paiXqiGa+P7fShnFxafE1c4+WyEAmb6lVamREsmn7Ip2WYreWQ+9irzaEKRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=h/Btutn7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715242418;
	bh=lHKi0i+Sh9dU0tv5mcRO6DSSVX4y5N1Jy0QuwxVUbw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/Btutn7RgorRwF1FYvdhvD4IemNLoebxsAr3nteozWA+iTGmbeXj125qfCfW0mVW
	 80qmmrYxTZfZmr+SPH5PpX38ROPzwd6ATsNfwykn8VKXlkvtKTRRH0hOY+Me7ZOD0f
	 0cVa39mwR/LukIGUagygLWqOrBI5wkRrl7/zvNTE=
Date: Thu, 9 May 2024 10:13:37 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Dustin Howett <dustin@howett.net>
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing
 through EC_FEATURE_PWM_KEYB
Message-ID: <9b594929-a827-4682-b4aa-98a2c85a536b@t-8ch.de>
References: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>
 <cd9c5b6a-0155-434a-b868-a9ea52e878c9@amd.com>
 <ae29f036-5e39-47ee-98d3-c023a263a3ef@t-8ch.de>
 <ZjxQHV9FPovvm_CY@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjxQHV9FPovvm_CY@google.com>

On 2024-05-09 12:25:01+0000, Tzung-Bi Shih wrote:
> On Mon, May 06, 2024 at 07:38:09PM +0200, Thomas Weißschuh wrote:
> > On 2024-05-05 08:42:21+0000, Mario Limonciello wrote:
> > > On 5/5/2024 04:41, Thomas Weißschuh wrote:
> > > > The ChromeOS EC used in Framework laptops supports the standard cros
> > > > keyboard backlight protocol.
> > > > However the firmware on these laptops don't implement the ACPI ID
> > > > GOOG0002 that is recognized by cros_kbd_led_backlight and they also
> > > > don't use device tree.
> 
> If implementing ACPI ID GOOG0002 is not an option, how about adding a new ACPI
> ID?  For the new ACPI ID, it can use EC PWM for setting the brightness.

Adding a new ACPI ID would be easier than a full-blown ACPI interface.
This would still need changes to the drivers probing setup, however.

What are the advantages of the ACPI ID aproach over EC_FEATURE_PWM_KEYB?
The EC feature also automatically works on device-tree platforms and
without any work from system vendors.

Adding ACPI ID only for signalling without using ACPI for
communication on the other hand seems weird.
Also with MFD the device hierarchy is much better.

> > > Something I'd wonder is if the GOOG0002 ACPI ID can go away entirely with
> > > this type of change.  Presumably the Chromebooks with ChromeOS EC /also/
> > > advertise EC_FEATURE_PWM_KEYB.
> > 
> > Sounds good to me in general. It would make the code cleaner.
> > 
> > But I have no idea how CrOS kernels are set up in general.
> > If they are not using CONFIG_MFD_CROS_EC_DEV for some reason that
> > wouldn't work.
> > 
> > If the CrOS folks agree with that aproach I'll be happy to implement it.
> 
> I would say NO as some existing devices (with legacy firmware and kernel) may
> rely on it.

Ack, makes sense.

You mention legacy kernels, but these would not be affected.

