Return-Path: <linux-kernel+bounces-572890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E698A6CFF1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9241895642
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7713B298;
	Sun, 23 Mar 2025 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OdOwagfz"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1182C60;
	Sun, 23 Mar 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742745950; cv=none; b=rBTxjKTaYQ8VDAVyRJvD+ik6P9+jGGoTfXBEwNTDpf4WRye0hJe9ROVc8QADcPjn0l86sNpuX9u/0VGmaGKYcpj1yJcNqWaTIOp+1CqzJml27ALZRppk1bTE57N41h7e/XCylMr0WR55eKYGoDNziFbxjdugmEh7jOxTd6FugeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742745950; c=relaxed/simple;
	bh=LEWW/CDG9F2+tab9J+tzGiETcdL581VCSTZVlF2recU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHjPzmXb9VjEm2P9vY3NtZvyCr6DBsAok0MlyecMKFR/G76Z6BX3CzIvSaXkM4OdJNiUix3FxY3ZXrSLMdrxZXoz0a1pPSGdkxQhB7LBTQKdIYsyjiDWNOb6Vk5jOVJEtH2HPz5lKMfZKclQAvXsQLND6e9XDHh1VBnO5eoNjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OdOwagfz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742745935;
	bh=LEWW/CDG9F2+tab9J+tzGiETcdL581VCSTZVlF2recU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdOwagfz9ePHgETWn54Rmf+WqhAUpSonw/Q3qxv6XbHS7LEliFvUpJO13HUz1wv/7
	 AuMLseEUPmvX8GDl6gTPhgHxCTMRsO9ABeGi5Lds0IbpjhCJEyjwnGdQL1V3k61zOR
	 /mYtTcEalEDwnyQUOr3+OyF43H8gWMXV76Cmoh8w=
Date: Sun, 23 Mar 2025 17:05:35 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sung-Chi Li <lschyi@chromium.org>, Jean Delvare <jdelvare@suse.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
Message-ID: <45d0681d-3446-409c-8d9b-0309dbb93ff8@t-8ch.de>
References: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
 <e4da28be-66ca-45d3-9ccf-34819460b463@t-8ch.de>
 <f50221fd-1d76-465b-ba53-62c08c6f8536@roeck-us.net>
 <780ce6e8-11fc-42be-b4a7-9cffbf811d78@t-8ch.de>
 <42c49b0b-cef0-49ca-a5b2-5bb05eae8dec@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42c49b0b-cef0-49ca-a5b2-5bb05eae8dec@roeck-us.net>

On 2025-03-22 09:10:40-0700, Guenter Roeck wrote:
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
> > 
> > That also means that the patch under discussion needs to implement the
> > pwmY_enable attribute.
> > 
> 
> Does it ? Does setting the target fan speed automatically change the fan
> control method ? Normally that is orthogonal: One does not necessarily
> want to enable a specific fan control method after setting a single related
> attribute, but do that only after all attributes have been set.

With the currently proposed patch setting fanY_target automatically
switches to manual control. And then there is no way to go back to
automatic control.

> For example, there could be another attribute specifying how fast the fan
> speed should be adjusted, or there could be minimum and/or maximum permitted
> pwm values. I am not saying that this is the case here, but setting a target
> fan speed should not automatically change the fan control method.

Makes sense.
This goes back to my original question: If pwmY_enable is *not*
implemented, how would it be possible to switch between the different
mechanisms?

