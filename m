Return-Path: <linux-kernel+bounces-170874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC98BDD2B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAE128183F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE613CA89;
	Tue,  7 May 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLY8b90e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12CF13CA9A;
	Tue,  7 May 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070551; cv=none; b=IrXl597jjdt8/J0oKmT/HZNVcxCDOwKkPMcDnXApAXiHIRONeadL9nH4ywDpj1klJ/aIfDWgVpdsyd50qPjo1eMaNVPVSLP+AOPmYcf6xDQqU+jZ7AUdvh09RdALGCPw0kN8eSUqaUV44Ie8bP4duobIlN+P1swpUvEfpM8DiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070551; c=relaxed/simple;
	bh=0zdeGPhU3mRbeeDOlmnBus9pw50/Ln9j0NVn9XT83/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6/cBRqM1u/XlZwQVhMKqQnao3yUZCi7n2x+v3tUac4nsW9YUeeV7UKrA5Eaq5M09ImY49QgwBflBFpSDCvQ/fVxJjpQ5+binOYO2rG9720WWqdUnHf4HQKL7tJ3SmE9Ao8NmYPprWMC++FOzUzZoBwBJwZ8Gdm5GNyOXgwV0wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLY8b90e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4081EC2BBFC;
	Tue,  7 May 2024 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715070551;
	bh=0zdeGPhU3mRbeeDOlmnBus9pw50/Ln9j0NVn9XT83/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLY8b90ezp9Eh9A9WQ7NBVrog04p5SnAcxA3nZB+VzJ7zi32nA5GLOZHrMiftSf+S
	 3YFKA+fmjb/UWBHEkfBM/cYr1HcVaZzgv7EhzcAQEbphlWxG9sOYFGY4iVKuJ+UZ7B
	 6TheLefgs8nojtQP6mnn7Ib3w3RPrc2ExovheJX8wG7yE2v08azTO/tDJrrqXK+ZpG
	 gQXjPiDB1uYrUOu7HLKdCAf+7BZIbG3YCvdl/uGC5BnNcXajOlOvHoD/ytg7W7iFCS
	 jVCf+rjqa+CJSJ2q6J1zSgSE9nCvx0UeoYcjofbcTULBaIcgcWc+QIkXh5zJRGa098
	 4UTSsfsf05xFQ==
Date: Tue, 7 May 2024 09:29:06 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing
 through EC_FEATURE_PWM_KEYB
Message-ID: <20240507082906.GU1227636@google.com>
References: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>

On Sun, 05 May 2024, Thomas Weißschuh wrote:

> The ChromeOS EC used in Framework laptops supports the standard cros
> keyboard backlight protocol.
> However the firmware on these laptops don't implement the ACPI ID
> GOOG0002 that is recognized by cros_kbd_led_backlight and they also
> don't use device tree.
> 
> Extend the cros_ec MFD device to also load cros_kbd_led_backlight
> when the EC reports EC_FEATURE_PWM_KEYB.
> 
> Tested on a Framework 13 AMD, Bios 3.05.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> This is based on
> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
> 
> The helper keyboard_led_is_mfd_device is a bit iffy, but I couldn't find
> a nicer way.
> 
> * driver_data from platform_device_id is overwritten by the mfd platform data
> * Setting the driver_data in drivers/mfd/cros_ec_dev.c would expose the
>   internals of cros_kbd_led_backlight
> ---
>  drivers/mfd/cros_ec_dev.c                        |  9 ++++++

Split this out please.

>  drivers/platform/chrome/cros_kbd_led_backlight.c | 41 +++++++++++++++++++++++-
>  2 files changed, 49 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]

