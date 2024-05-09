Return-Path: <linux-kernel+bounces-174123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F1B8C0A77
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0CB1F225C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417C1482F3;
	Thu,  9 May 2024 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkK1WhgX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D313B2A4;
	Thu,  9 May 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715228705; cv=none; b=B23VMRlZOTbwabkP3FZq/xwy/4LUBm+kF4tV1Si/acbkeZJgzeSkJWhX7yi82zQ1WUUOHgOmTW5Ererycybb1tcA3AKua3XNJXEkfy94JWWI9eIUbpgRz0ayTfjaKA8Cb2us3DRllICJe6CnH5KwIi44/q9Ynb9O+8dnfvB7wJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715228705; c=relaxed/simple;
	bh=6HMpt//iy5ul/2zvPh0UXT6YXRvV0LGvSjzXl6xMbJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1L4Xzieg5FnY7q13dmJqnvLRDxXV9L5LcmodkR+Y4Gr3NOcqslYWErV/ewKWBdFynhh/ihGW5paD29PiCKGPCK0NU51JcP4i6mkZUjmbJVde7Dp63nn6CRso1rQ/tnm2az5j35SWaZL8wH8V70+bbVkh2XQI+NJeoRvb5+qOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkK1WhgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5983C116B1;
	Thu,  9 May 2024 04:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715228705;
	bh=6HMpt//iy5ul/2zvPh0UXT6YXRvV0LGvSjzXl6xMbJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkK1WhgXxEb58hvEtKOpPilq6s7ovX1CgptaWZkaoVON9UAOv+HG3ayV5TSUxLODp
	 UTlP3JhwsnoC40fipbLtTPEvUdiJgPn83VJJIEsjtZzj0NYaS7lk/8Nj/dUWW0cFtz
	 8rlCCcyd7XSmKtEtd1gsT1+6lVduhuqOnuB3+mGqYfGTATi1UMaCurYP3xms6fgFNi
	 hJCz+LJfNZgrTPjezaP3RKzs55KapM0oDls4UWdkjwV8v46k8EcR7eTvYaRq8Kpud+
	 lcrHYLjmR/Wd1ikuGDSJ1If8w3hdJnHCKWaI0WO3eDL6mLGAOc86BTlzFOn25wPyv7
	 qFCqaS5cE/RTA==
Date: Thu, 9 May 2024 12:25:01 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dustin Howett <dustin@howett.net>
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing
 through EC_FEATURE_PWM_KEYB
Message-ID: <ZjxQHV9FPovvm_CY@google.com>
References: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>
 <cd9c5b6a-0155-434a-b868-a9ea52e878c9@amd.com>
 <ae29f036-5e39-47ee-98d3-c023a263a3ef@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae29f036-5e39-47ee-98d3-c023a263a3ef@t-8ch.de>

On Mon, May 06, 2024 at 07:38:09PM +0200, Thomas Weißschuh wrote:
> On 2024-05-05 08:42:21+0000, Mario Limonciello wrote:
> > On 5/5/2024 04:41, Thomas Weißschuh wrote:
> > > The ChromeOS EC used in Framework laptops supports the standard cros
> > > keyboard backlight protocol.
> > > However the firmware on these laptops don't implement the ACPI ID
> > > GOOG0002 that is recognized by cros_kbd_led_backlight and they also
> > > don't use device tree.

If implementing ACPI ID GOOG0002 is not an option, how about adding a new ACPI
ID?  For the new ACPI ID, it can use EC PWM for setting the brightness.

> > Something I'd wonder is if the GOOG0002 ACPI ID can go away entirely with
> > this type of change.  Presumably the Chromebooks with ChromeOS EC /also/
> > advertise EC_FEATURE_PWM_KEYB.
> 
> Sounds good to me in general. It would make the code cleaner.
> 
> But I have no idea how CrOS kernels are set up in general.
> If they are not using CONFIG_MFD_CROS_EC_DEV for some reason that
> wouldn't work.
> 
> If the CrOS folks agree with that aproach I'll be happy to implement it.

I would say NO as some existing devices (with legacy firmware and kernel) may
rely on it.

