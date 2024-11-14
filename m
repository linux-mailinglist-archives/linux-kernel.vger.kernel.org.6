Return-Path: <linux-kernel+bounces-408678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7E9C820E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A069DB2583B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362D165F01;
	Thu, 14 Nov 2024 04:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NPvYCuzj"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42D1632E7;
	Thu, 14 Nov 2024 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731559272; cv=none; b=q9gHfOxkvJ5+/H/mkR7sO4ZasFBSbUW0lwSvadHM92iEvBH4j+4Lyqo2obYMGwvuEJu8EIHCNzqitM+kT9TxDthC/e3mx9bNcc3uF78ox2odlyKYbD8VX7I+wnqxjdvCb49zbM+hsc8lnfyRWya56V+f1vp6j4NVLgxWwGj3nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731559272; c=relaxed/simple;
	bh=Tmib4jjLJqIBLcCrkSlX7oaas0R9RgMKIBI6zShGvI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVhERToYTXoC7rAgHQOiStL4HQudGTcGFx/vYfKy+qWdRX8wX5ODrg9/3jOS5KWXMKxGp0j1j1sv9UiXb9QoFi2uQLZm1m2Dy8sx7/nFwkuNSmQe/z3jhJj4qL7EBu7Meq21pf+CbaWquXd1+RUjRLzTtSy56iE5Guw7dAMF9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NPvYCuzj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731559256;
	bh=Tmib4jjLJqIBLcCrkSlX7oaas0R9RgMKIBI6zShGvI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPvYCuzj2p4SEyVkL00gdajRVwzh0v0JUjakfyta9Ai+Y4/pZVu8H1M5QV9Rrcnaa
	 cxpJebdCz+4wum6ChuS2VUUZo+nEktXRyGJMna2ErFxcW2BnJgMW6wITY2wpD7WBy+
	 DnqKPT5P5ioVexvN61DyNzzu0EaZ4p+VvZOqAsNY=
Date: Thu, 14 Nov 2024 05:40:55 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (core) Avoid ifdef in C source file
Message-ID: <b6ed8499-bf84-486c-be5f-0ef13311eb18@t-8ch.de>
References: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>
 <041a52c7-ac0b-4a78-8b39-4fc4ac4d2fd2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <041a52c7-ac0b-4a78-8b39-4fc4ac4d2fd2@roeck-us.net>

Hi Guenter,

On 2024-11-12 22:52:36-0800, Guenter Roeck wrote:
> On 11/12/24 20:39, Thomas Weißschuh wrote:
> > Using an #ifdef in a C source files to have different definitions
> > of the same symbol makes the code harder to read and understand.
> > Furthermore it makes it harder to test compilation of the different
> > branches.
> > 
> > Replace the ifdeffery with IS_ENABLED() which is just a normal
> > conditional.
> > The resulting binary is still the same as before as the compiler
> > optimizes away all the unused code and definitions.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > This confused me a bit while looking at the implementation of
> > HWMON_C_REGISTER_TZ.
> > ---
> >   drivers/hwmon/hwmon.c | 21 ++++++---------------
> >   1 file changed, 6 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > index 9c35c4d0369d7aad7ea61ccd25f4f63fc98b9e02..86fb674c85d3f54d475be014c3fd3dd74c815c57 100644
> > --- a/drivers/hwmon/hwmon.c
> > +++ b/drivers/hwmon/hwmon.c
> > @@ -147,11 +147,6 @@ static DEFINE_IDA(hwmon_ida);
> >   /* Thermal zone handling */
> > -/*
> > - * The complex conditional is necessary to avoid a cyclic dependency
> > - * between hwmon and thermal_sys modules.
> > - */
> > -#ifdef CONFIG_THERMAL_OF
> >   static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> >   {
> >   	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
> > @@ -257,6 +252,9 @@ static int hwmon_thermal_register_sensors(struct device *dev)
> >   	void *drvdata = dev_get_drvdata(dev);
> >   	int i;
> > +	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> > +		return 0;
> > +
> >   	for (i = 1; info[i]; i++) {
> >   		int j;
> > @@ -285,6 +283,9 @@ static void hwmon_thermal_notify(struct device *dev, int index)
> >   	struct hwmon_device *hwdev = to_hwmon_device(dev);
> >   	struct hwmon_thermal_data *tzdata;
> > +	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> > +		return;
> > +
> >   	list_for_each_entry(tzdata, &hwdev->tzdata, node) {
> >   		if (tzdata->index == index) {
> >   			thermal_zone_device_update(tzdata->tzd,
> 
> There is no dummy function for thermal_zone_device_update().
> I really don't want to trust the compiler/linker to remove that code
> unless someone points me to a document explaining that it is guaranteed
> to not cause any problems.

I'm fairly sure that a declaration should be enough, and believe
to remember seeing such advise somewhere.
However there is not even a function declaration with !CONFIG_THERMAL.
So I can add an actual stub for it for v2.

What do you think?

Thomas

> > @@ -293,16 +294,6 @@ static void hwmon_thermal_notify(struct device *dev, int index)
> >   	}
> >   }
> > -#else
> > -static int hwmon_thermal_register_sensors(struct device *dev)
> > -{
> > -	return 0;
> > -}
> > -
> > -static void hwmon_thermal_notify(struct device *dev, int index) { }
> > -
> > -#endif /* IS_REACHABLE(CONFIG_THERMAL) && ... */
> > -
> >   static int hwmon_attr_base(enum hwmon_sensor_types type)
> >   {
> >   	if (type == hwmon_in || type == hwmon_intrusion)
> > 
> > ---
> > base-commit: 3022e9d00ebec31ed435ae0844e3f235dba998a9
> > change-id: 20241113-hwmon-thermal-2d2da581c276
> > 
> > Best regards,
> 

