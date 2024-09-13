Return-Path: <linux-kernel+bounces-327656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D09778E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872301C24DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCC1B983D;
	Fri, 13 Sep 2024 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF8MT5gc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306E186E46;
	Fri, 13 Sep 2024 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209610; cv=none; b=A6uj370Jsaj6w4KhAsndwFJARYm5oQO44VKSz7AU7pP/8sEQutS1N7bX1ehQcM8+z6caZOue+ivg8nqzq2qE6dKGGqBL1MrDU7gmuRi0n2vkJ72ozBEvwxdCWrXt2TWEWbSCSycJJT0HsRIpnDGGBj/yhfk6C4dlUzfRT7RZ7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209610; c=relaxed/simple;
	bh=T+QA0JQw/tcCgEq6Zy6uk3t1T8mRvpS6RiUFW0kEWT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=quiS4pW2byxnq4FLCKlfB+fBdS0LvaMAyVb7zWivhroZ3W5qEouvcD/AHvqt87o/GnEh87O4+3TPvjoTkGIuB4nfDIeu9BNyAndxtbWvljzymlRdCdKDq3Mj5RMpIXAcfA0kZK+eVhvBb+BSYQUWYHbwEZfBn2B2v+ZrVrknG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF8MT5gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C11AC4CEC0;
	Fri, 13 Sep 2024 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726209609;
	bh=T+QA0JQw/tcCgEq6Zy6uk3t1T8mRvpS6RiUFW0kEWT4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YF8MT5gcxKLKBvDLMde1acPu13DbF602qOUxqhGRYen1xySCmHwy/3cSWMuo3J6B+
	 D1SBDUWFzSb8fA+xfD4kTpwcaEMZQj/8bOk8oYV5Rh3po5SB0lu7oMiB7YyPkVOIpU
	 RYyTpMqHrQSQgVFiFkk3CUhy5djkWyPr0X9byR0Y/ekZlHdP4AAOAC0LiicUwrfMMX
	 jYFBBlqEHgNU7OEsWYtp4uiEaUl+JdKwtKh6iU0TkWnhDvVYYnvKDf/gGnHQY9pUSn
	 kAmwEW+NkrrypTokMfafFcMp/4LSWsnXxhS0uKiTvL26/f4ajje4ij/vQV6AFhWeE0
	 38Z7N1aUjWT+w==
Message-ID: <488b3bdf870ea76c4b943dbe5fd15ac8113019dc.camel@kernel.org>
Subject: Re: [PATCH] hwmon: Fix WARN_ON() always called from
 devm_hwmon_device_unregister()
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Matthew Sanders <m@ttsande.rs>, 
	jdelvare@suse.com, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 23:40:08 -0700
In-Reply-To: <ca09333e-902e-4b2c-8c8c-eb7f0d2d4922@roeck-us.net>
References: <20240912091401.4101-1-m@ttsande.rs>
	 <ca09333e-902e-4b2c-8c8c-eb7f0d2d4922@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 07:13 -0700, Guenter Roeck wrote:
> On 9/12/24 02:14, Matthew Sanders wrote:
> > devm_hwmon_device_unregister() only takes parent of a devres-
> > managed
> > hwmon device as an argument. This always fails, as devres can't
> > find
> > the hwmon device it needs to unregister with the parent device
> > alone.
> > Without this patch, the WARN_ON() in devm_hwmon_device_unregister()
> > will
> > always be displayed unconditionally:
> >=20
> > [=C2=A0=C2=A0=C2=A0 7.969746] WARNING: CPU: 1 PID: 224 at
> > drivers/hwmon/hwmon.c:1205 devm_hwmon_device_unregister+0x28/0x30
> >=20
> > This patch adds an extra argument to
> > devm_hwmon_device_unregister(), a
> > pointer to a hwmon device which was previously registered to the
> > parent using devres.
> >=20
> > There aren't any drivers which currently make use of this function,
> > so
> > any existing users of devm_hwmon_* shouldn't require any changes as
> > a
> > result of this patch.
>=20
> If there are no users, there is no need to keep the function. We
> should drop
> it instead.

There aren't any direct in-tree users of the function.  But some out-
of-tree drivers can find it useful to use, hence Matt hitting this
issue.

If there's a desire to just remove it, that's fine.  But it would
remove a handy hook for out-of-tree stuff.

-PJ

>=20
> Also, your patch is not signed and therefore can not be applied.
>=20
> Guenter
>=20
> > ---
> > =C2=A0 drivers/hwmon/hwmon.c | 6 ++++--
> > =C2=A0 include/linux/hwmon.h | 2 +-
> > =C2=A0 2 files changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > index a362080d41fa..84945a276320 100644
> > --- a/drivers/hwmon/hwmon.c
> > +++ b/drivers/hwmon/hwmon.c
> > @@ -1199,10 +1199,12 @@ static int devm_hwmon_match(struct device
> > *dev, void *res, void *data)
> > =C2=A0=C2=A0 * devm_hwmon_device_unregister - removes a previously regi=
stered
> > hwmon device
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * @dev: the parent device of the device to unregister
> > + * @hwdev: the hwmon device to unregister
> > =C2=A0=C2=A0 */
> > -void devm_hwmon_device_unregister(struct device *dev)
> > +void devm_hwmon_device_unregister(struct device *dev, struct
> > device *hwdev)
> > =C2=A0 {
> > -	WARN_ON(devres_release(dev, devm_hwmon_release,
> > devm_hwmon_match, dev));
> > +	WARN_ON(devres_release(dev, devm_hwmon_release,
> > devm_hwmon_match,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwdev));
> > =C2=A0 }
> > =C2=A0 EXPORT_SYMBOL_GPL(devm_hwmon_device_unregister);
> > =C2=A0=20
> > diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> > index e94314760aab..2434c6fc17a7 100644
> > --- a/include/linux/hwmon.h
> > +++ b/include/linux/hwmon.h
> > @@ -481,7 +481,7 @@ devm_hwmon_device_register_with_info(struct
> > device *dev,
> > =C2=A0=C2=A0				const struct attribute_group
> > **extra_groups);
> > =C2=A0=20
> > =C2=A0 void hwmon_device_unregister(struct device *dev);
> > -void devm_hwmon_device_unregister(struct device *dev);
> > +void devm_hwmon_device_unregister(struct device *dev, struct
> > device *hwdev);
> > =C2=A0=20
> > =C2=A0 int hwmon_notify_event(struct device *dev, enum
> > hwmon_sensor_types type,
> > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 attr, int channe=
l);
>=20


