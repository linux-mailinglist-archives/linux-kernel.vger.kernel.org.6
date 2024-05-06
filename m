Return-Path: <linux-kernel+bounces-170237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B048C8BD3E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2921C21964
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD5157498;
	Mon,  6 May 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="U/lKhD5X"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFAC142909
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017101; cv=none; b=sx8MbyF4FYwooHntsfNGUkYt1UWtjOIlYai+o/bMRKXFaTSPCMN4jMHLn680UoSEjuddCavMWPbK3yxTuewmV+WuiODDMvXjHiMbwO64CjaoZQaDHwTE2mY4g3fRoZVjY7acaSQ1lwtOVTWJHzvZu+KtUsKk8fMoS1G4JDGB7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017101; c=relaxed/simple;
	bh=4XFC9LixjSuuTuMODWQ2jae7SIkFY3aM9gnz3hQ/Sfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdTpDHV+dzg3MQWkiGQJqvL57wh78XKR6DoDR8MpMASLx0MDBtqZ/ArAnVRFYiRNiNaZjyrdmo06mkSKq6Wd1aan552SuPm9rf/62Oi/ZrJk2nLNzp231l7UWt5MZubyq7PorwoPVVlxL3DKUesILmOsb+Lprlo8LnEuWxMuYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=U/lKhD5X; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715017089;
	bh=4XFC9LixjSuuTuMODWQ2jae7SIkFY3aM9gnz3hQ/Sfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/lKhD5XrgXw8BC4RZYX+Zbzpkz+aHyxToifuGZ+c4dFH60sdVZkO4x4ksCCEE/ni
	 s2OCOD3gW/B5gjKkO7RSWBTtvW3EKtgrbYhBidaHLZ6NHeZ1TEkv5GYVOy8ltPxJpJ
	 jIcuOpPYmsahVEHWALirlCZFqftaDaDAEgqu4QVg=
Date: Mon, 6 May 2024 19:38:09 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing
 through EC_FEATURE_PWM_KEYB
Message-ID: <ae29f036-5e39-47ee-98d3-c023a263a3ef@t-8ch.de>
References: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>
 <cd9c5b6a-0155-434a-b868-a9ea52e878c9@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd9c5b6a-0155-434a-b868-a9ea52e878c9@amd.com>

On 2024-05-05 08:42:21+0000, Mario Limonciello wrote:
> On 5/5/2024 04:41, Thomas Weißschuh wrote:
> > The ChromeOS EC used in Framework laptops supports the standard cros
> > keyboard backlight protocol.
> > However the firmware on these laptops don't implement the ACPI ID
> > GOOG0002 that is recognized by cros_kbd_led_backlight and they also
> > don't use device tree.
> 
> Something I'd wonder is if the GOOG0002 ACPI ID can go away entirely with
> this type of change.  Presumably the Chromebooks with ChromeOS EC /also/
> advertise EC_FEATURE_PWM_KEYB.

Sounds good to me in general. It would make the code cleaner.

But I have no idea how CrOS kernels are set up in general.
If they are not using CONFIG_MFD_CROS_EC_DEV for some reason that
wouldn't work.

If the CrOS folks agree with that aproach I'll be happy to implement it.

> <snip>

Thomas

