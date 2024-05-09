Return-Path: <linux-kernel+bounces-174348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1DF8C0D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3900A1C21C8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956414A619;
	Thu,  9 May 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBw4nxwF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07591D528;
	Thu,  9 May 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246942; cv=none; b=pAqtuVWIPN4jvezq/5LbtPWuqcxlwEJmd5K4GrNlefPmHex/uVoBO6vrz7aXTOujOX9j613eIWRBrnqI2rU73hiSJV9EvunIryqjpqX4jHIhoFIgfuqp4SJHnkDZIOLy9+5A+ADDDaWrUZDKI4F3d6tAaLN8dwl/pTId6vlSVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246942; c=relaxed/simple;
	bh=wZKrO8+x5D6FuMJ5ZBvR3E+b5O6QBa7DkTruok+Onyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOCcp85zUd8WGGVBmnIh+HGlsOC0ZIb4Mb1jSsQqt/NM2hAh6u1W7r/YvpxHn9cE68RiPja8+aHqLwZbL/dBx8qss9FPZU358B6nMc+ykexqenWEw3EFbgvPqaAh5wOwbi6YNh2nj6o2o4VDtzHJ+uP/nNMiob0ufaQEwXvMrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBw4nxwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECD5C116B1;
	Thu,  9 May 2024 09:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715246941;
	bh=wZKrO8+x5D6FuMJ5ZBvR3E+b5O6QBa7DkTruok+Onyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBw4nxwFm5vXM+XYMQ269h/KD+KGBB94ZKz2nVikiFUIzg32j5yyaDN8aVcahigay
	 im91cM6Yuj13adOrCWAIHPvolZdLGlBIZN47UW5j2KT/kz28njMS2l2FXF2d7DxVbe
	 ky4rS3hNNLKH9DOR8Rs4ALDWDbNLWXq39nYIIkGQ8GeyDYcNHLmRF+VVO68cptDoY2
	 OBJ7RdC9xlrAujTjW8FGMVMThKxIuAXCmQZWxPw0PtkXATDSqhA/U4s/utBpDxOXxU
	 YqpIKsGjQ2dP4EbKSjmk6WifDuK7V4tau8b8aqwEnyr/N45Epa4QTe92iQ0g5y+JSu
	 ZVCrXLFSFMg0g==
Date: Thu, 9 May 2024 17:28:58 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dustin Howett <dustin@howett.net>
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing
 through EC_FEATURE_PWM_KEYB
Message-ID: <ZjyXWrYIjE47--Hl@google.com>
References: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>
 <cd9c5b6a-0155-434a-b868-a9ea52e878c9@amd.com>
 <ae29f036-5e39-47ee-98d3-c023a263a3ef@t-8ch.de>
 <ZjxQHV9FPovvm_CY@google.com>
 <9b594929-a827-4682-b4aa-98a2c85a536b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b594929-a827-4682-b4aa-98a2c85a536b@t-8ch.de>

On Thu, May 09, 2024 at 10:13:37AM +0200, Thomas Weißschuh wrote:
> On 2024-05-09 12:25:01+0000, Tzung-Bi Shih wrote:
> > On Mon, May 06, 2024 at 07:38:09PM +0200, Thomas Weißschuh wrote:
> > > On 2024-05-05 08:42:21+0000, Mario Limonciello wrote:
> > > > On 5/5/2024 04:41, Thomas Weißschuh wrote:
> > > > > The ChromeOS EC used in Framework laptops supports the standard cros
> > > > > keyboard backlight protocol.
> > > > > However the firmware on these laptops don't implement the ACPI ID
> > > > > GOOG0002 that is recognized by cros_kbd_led_backlight and they also
> > > > > don't use device tree.
> > 
> > If implementing ACPI ID GOOG0002 is not an option, how about adding a new ACPI
> > ID?  For the new ACPI ID, it can use EC PWM for setting the brightness.
> 
> Adding a new ACPI ID would be easier than a full-blown ACPI interface.
> This would still need changes to the drivers probing setup, however.
> 
> What are the advantages of the ACPI ID aproach over EC_FEATURE_PWM_KEYB?
> The EC feature also automatically works on device-tree platforms and
> without any work from system vendors.

Perhaps no advantages but just following its original design.  The driver uses
ACPI table for matching devices since it appears.  We shouldn't remove the
ACPI matching anyway as some existing devices may rely on it.

In addition, adding a new ACPI ID sounds more reasonable than using
keyboard_led_is_mfd_device() to me.

> Adding ACPI ID only for signalling without using ACPI for
> communication on the other hand seems weird.

I have a different view: using a new ACPI ID and another driver data fits
current framework better.  I'm not sure if the reason is strong enough for
applying a new ACPI ID though.

We could wait to see if others in the mailing list may have more inputs.

> > > > Something I'd wonder is if the GOOG0002 ACPI ID can go away entirely with
> > > > this type of change.  Presumably the Chromebooks with ChromeOS EC /also/
> > > > advertise EC_FEATURE_PWM_KEYB.
> > > 
> > > Sounds good to me in general. It would make the code cleaner.
> > > 
> > > But I have no idea how CrOS kernels are set up in general.
> > > If they are not using CONFIG_MFD_CROS_EC_DEV for some reason that
> > > wouldn't work.
> > > 
> > > If the CrOS folks agree with that aproach I'll be happy to implement it.
> > 
> > I would say NO as some existing devices (with legacy firmware and kernel) may
> > rely on it.
> 
> Ack, makes sense.
> 
> You mention legacy kernels, but these would not be affected.

We never know if a device would run legacy firmware with new kernel in some
day.

