Return-Path: <linux-kernel+bounces-572891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FBAA6CFF3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAA83B2626
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA213B58D;
	Sun, 23 Mar 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dg2euc03"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61B82C60;
	Sun, 23 Mar 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742746098; cv=none; b=GgnfGD0du5Oz7/wvrPz3favSQ+YVZAaXwccw+Fbf6Sq3nGAhOYbzLPq03v8juFLMQW8yJjSDnjsm+mMv58o+bJMWoZQhDvXtFF8p8QOcc5jOgOaTwFm8kpwSU8Hu1zbDFFUVhyEJDbaUBBaPIpzYMoqRIX7XiIblnveop4JbcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742746098; c=relaxed/simple;
	bh=neIr23byQh5Ii3UIrUPwLSuKzaAgGYewIdlU6vNmKB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djj1/JPQbtVxpoLkZojFrz1/tsnop+oIdWfs7hxdUyDHmAWuuMDEug+k7HpolpFOwc3GLByt09J3jIUHh1typOCpzHkmloXjNbZXGe15SLYcIknPPO1qTouCvP0hb3wez/VnB510nQwFxOhSVWlE81jWX6Hb9fKLP6r8kwlCDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dg2euc03; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742746094;
	bh=neIr23byQh5Ii3UIrUPwLSuKzaAgGYewIdlU6vNmKB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dg2euc03IjTMzM0v8hnX5DTZson9qjo2J/osxwShgWv6EIp4URjevS9kXUDNt8yyb
	 HAr/aIaf+oAWzYYHK/4RxpHVUHh/PRLLPDK3pXiCPx5HjcuOuNsnfqFDynNBVJjGll
	 GohFdbKgCtQFJYcuhcZ/RcXPWqEbB3N2/SiZ93vk=
Date: Sun, 23 Mar 2025 17:08:13 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sung-Chi Li <lschyi@chromium.org>, Jean Delvare <jdelvare@suse.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
Message-ID: <155d783a-574c-474f-b87d-a20ddb56d109@t-8ch.de>
References: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
 <e4da28be-66ca-45d3-9ccf-34819460b463@t-8ch.de>
 <f50221fd-1d76-465b-ba53-62c08c6f8536@roeck-us.net>
 <780ce6e8-11fc-42be-b4a7-9cffbf811d78@t-8ch.de>
 <dae402fc-4b3e-4a5e-adb1-59f0697d9d61@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dae402fc-4b3e-4a5e-adb1-59f0697d9d61@roeck-us.net>

On 2025-03-22 08:45:06-0700, Guenter Roeck wrote:
> On 3/22/25 08:23, Thomas Weißschuh wrote:
> > On 2025-03-22 07:12:48-0700, Guenter Roeck wrote:
> > > On 3/22/25 06:55, Thomas Weißschuh wrote:
> > > > On 2025-03-18 15:45:23+0800, Sung-Chi Li wrote:
> > > > > The ChromeOS embedded controller (EC) supports closed loop fan speed
> > > > > control, so add the fan target attribute under hwmon framework, such
> > > > > that kernel can expose reading and specifying the desired fan RPM for
> > > > > fans connected to the EC.
> > > > > 
> > > > > When probing the cros_ec hwmon module, we also check the supported
> > > > > command version of setting target fan RPM. This commit implements the
> > > > > version 0 of getting the target fan RPM, which can only read the target
> > > > > RPM of the first fan. This commit also implements the version 1 of
> > > > > setting the target fan RPM to each fan respectively.
> > > > > 
> > > > > Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> > > > > ---
> > > > > ChromeOS embedded controller (EC) supports closed-loop fan control. We
> > > > > anticipate to have the fan related control from the kernel side, so this
> > > > > series register the HWMON_F_TARGET attribute, and implement the read and
> > > > > write function for setting/reading the target fan RPM from the EC side.
> > > > 
> > > > Should it be possible to switch back to automatic control?
> > > > I can't find anything in the hwmon ABI about it.
> > > > And neither in the CrOS EC source.
> > > > 
> > > > Am I missing something?
> > > > 
> > > 
> > > Not sure I understand the context, but the fan control method is normally
> > > selected with pwmX_enable, which is defined as
> > > 
> > >                  Fan speed control method:
> > > 
> > >                  - 0: no fan speed control (i.e. fan at full speed)
> > >                  - 1: manual fan speed control enabled (using `pwmY`)
> > >                  - 2+: automatic fan speed control enabled
> > 
> > So far I associated pwmY_enable = 1 with the pwmY attribute.
> > Also controlling it through fanY_target does make sense though.
> > It could be clearer from the docs IMHO.
> 
> That is chip specific, and needs to be documented in the chip documentation.

Ack.

> > 
> > That also means that the patch under discussion needs to implement the
> > pwmY_enable attribute.
> > 
> > One more thing I have wondered about before:
> > Is pwmY always refering to the same thing as the matching fanY?
> > 
> 
> That used to be the case when the ABI was defined, and it is for the most part
> still the case. However, nowadays there are chips which permit dynamic assignment
> of pwm channels to fan tachometer channels. Recent Aspeed SoCs are a perfect
> example. On those, the pwm <->fan mapping is completely dynamic. How to handle
> and express that in devicetree (which is where it is really needed) is still
> being worked out, though I think we are slowly getting there.

Thanks for the clarification.

> Of course that means that the correlation isn't typically spelled out explicitly
> since it _used_ to be implicit.

Ack.

Given the docs need updating anyways, I'd like to the see the
correlations spelled out there explicitly.

