Return-Path: <linux-kernel+bounces-409605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D39C8F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A932834BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364A41C65;
	Thu, 14 Nov 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kUELYSU2"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901861BC49;
	Thu, 14 Nov 2024 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600438; cv=none; b=JT5eEkUpC9w4Yi96AH9NEeG8VxQb+z6fCjm0uTVoYODf1TqFQMPsVL8Lbb9uj6CUlMcHIyEcdgZTU+GC1tE88OsEeYZqkcy0vIp/kIYSRJ2qge/DBDeATjU/SO/LdT1bPUhr76oufu9haZsAI06dd8J4IMeHhufx3pz2YXkYKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600438; c=relaxed/simple;
	bh=jh2oRSzx6u5z+iH44W8gFAvDdTaQNNoevLV18Ll2k48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVajXqnqw5PQX2SJ+ErLDsPRoZHPP/MYQJA9QymA3PgMNhJCxis5mHYswhn6OAzg0IjSYXUOMRLXT/kabl8V9Lw9QYcqTaeUWLb4Yx9yRvGFQDKtgNlSC9Z6CYOoj827ha+3U2NHr4WUcvdzq+0k3wBKPhONp77D8edhUONQTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kUELYSU2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731600429;
	bh=jh2oRSzx6u5z+iH44W8gFAvDdTaQNNoevLV18Ll2k48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUELYSU2r2QcM7Kshr4NdJouIK1/QTyc4xNhAXyrU3IdWqypHdzvPW9gfA6wFvpMw
	 DVXQxTwx289k+c+ocnO1gJisCa2AaD9sk/jldI1aAm+Vlj/AuW4n0R/1RhNNhcypD9
	 M4Vpe+LaKf1xV00QS5JnzUbcBVqey001zmW/dx0Y=
Date: Thu, 14 Nov 2024 17:07:08 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (core) Avoid ifdef in C source file
Message-ID: <2b1b5e06-062b-442d-be13-da02d3233fba@t-8ch.de>
References: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>
 <041a52c7-ac0b-4a78-8b39-4fc4ac4d2fd2@roeck-us.net>
 <b6ed8499-bf84-486c-be5f-0ef13311eb18@t-8ch.de>
 <3f1914da-4f94-415e-8c46-8731834e51a2@roeck-us.net>
 <c3aaf724-a1d2-438c-851a-dedb0e9a3f34@t-8ch.de>
 <7a01e398-c8fb-43fd-9b47-7fefb7a692cb@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a01e398-c8fb-43fd-9b47-7fefb7a692cb@roeck-us.net>

On 2024-11-14 06:40:03-0800, Guenter Roeck wrote:
> On 11/13/24 23:27, Thomas Weißschuh wrote:
> > On 2024-11-13 22:51:37-0800, Guenter Roeck wrote:
> > > On 11/13/24 20:40, Thomas Weißschuh wrote:
> > > > On 2024-11-12 22:52:36-0800, Guenter Roeck wrote:
> > > > > On 11/12/24 20:39, Thomas Weißschuh wrote:
> > > > > > Using an #ifdef in a C source files to have different definitions
> > > > > > of the same symbol makes the code harder to read and understand.
> > > > > > Furthermore it makes it harder to test compilation of the different
> > > > > > branches.
> > > > > > 
> > > > > > Replace the ifdeffery with IS_ENABLED() which is just a normal
> > > > > > conditional.
> > > > > > The resulting binary is still the same as before as the compiler
> > > > > > optimizes away all the unused code and definitions.
> > > > > > 
> > > > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > > > ---
> > > > > > This confused me a bit while looking at the implementation of
> > > > > > HWMON_C_REGISTER_TZ.
> > > > > > ---
> > > > > >     drivers/hwmon/hwmon.c | 21 ++++++---------------
> > > > > >     1 file changed, 6 insertions(+), 15 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > > > > > index 9c35c4d0369d7aad7ea61ccd25f4f63fc98b9e02..86fb674c85d3f54d475be014c3fd3dd74c815c57 100644
> > > > > > --- a/drivers/hwmon/hwmon.c
> > > > > > +++ b/drivers/hwmon/hwmon.c
> > > > > > @@ -147,11 +147,6 @@ static DEFINE_IDA(hwmon_ida);
> > > > > >     /* Thermal zone handling */
> > > > > > -/*
> > > > > > - * The complex conditional is necessary to avoid a cyclic dependency
> > > > > > - * between hwmon and thermal_sys modules.
> > > > > > - */
> > > > > > -#ifdef CONFIG_THERMAL_OF
> > > > > >     static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> > > > > >     {
> > > > > >     	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
> > > > > > @@ -257,6 +252,9 @@ static int hwmon_thermal_register_sensors(struct device *dev)
> > > > > >     	void *drvdata = dev_get_drvdata(dev);
> > > > > >     	int i;
> > > > > > +	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> > > > > > +		return 0;
> > > > > > +
> > > > > >     	for (i = 1; info[i]; i++) {
> > > > > >     		int j;
> > > > > > @@ -285,6 +283,9 @@ static void hwmon_thermal_notify(struct device *dev, int index)
> > > > > >     	struct hwmon_device *hwdev = to_hwmon_device(dev);
> > > > > >     	struct hwmon_thermal_data *tzdata;
> > > > > > +	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> > > > > > +		return;
> > > > > > +
> > > > > >     	list_for_each_entry(tzdata, &hwdev->tzdata, node) {
> > > > > >     		if (tzdata->index == index) {
> > > > > >     			thermal_zone_device_update(tzdata->tzd,
> > > > > 
> > > > > There is no dummy function for thermal_zone_device_update().
> > > > > I really don't want to trust the compiler/linker to remove that code
> > > > > unless someone points me to a document explaining that it is guaranteed
> > > > > to not cause any problems.
> > > > 
> > > > I'm fairly sure that a declaration should be enough, and believe
> > > > to remember seeing such advise somewhere.
> > > > However there is not even a function declaration with !CONFIG_THERMAL.
> > > > So I can add an actual stub for it for v2.
> > > > 
> > > > What do you think?
> > > > 
> > > You mean an extern declaration without the actual function ?
> > 
> > Stub as in empty inline function:
> > 
> > static inline void thermal_zone_device_update(struct thermal_zone_device *,
> >                                               enum thermal_notify_event)
> > { }
> > 
> 
> Sure, that would work, but it would have to be declared in the thermal subsystem.

Of course.

> > > I'd really want to see that documented. It would seem rather unusual.
> > 
> > > From Documentation/process/coding-style.rst
> > 
> > 	21) Conditional Compilation
> > 	---------------------------
> > 
> > 	Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
> > 	files; doing so makes code harder to read and logic harder to follow.  Instead,
> > 	use such conditionals in a header file defining functions for use in those .c
> > 	files, providing no-op stub versions in the #else case, and then call those
> > 	functions unconditionally from .c files.  The compiler will avoid generating
> > 	any code for the stub calls, producing identical results, but the logic will
> > 	remain easy to follow.
> > 
> > 	[..]
> > 
> > 	Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
> > 	symbol into a C boolean expression, and use it in a normal C conditional:
> > 
> > 	.. code-block:: c
> > 
> > 		if (IS_ENABLED(CONFIG_SOMETHING)) {
> > 			...
> > 		}
> > 
> > 	The compiler will constant-fold the conditional away, and include or exclude
> > 	the block of code just as with an #ifdef, so this will not add any runtime
> > 	overhead.
> > 
> > 	[..]
> > 
> > While this primarily talks about stubs, the fact that
> > "the compiler will constant-fold the conditional away" can be understood
> > that the linker will never see those function calls and therefore the
> > functions don't have to be present during linking.
> 
> Yes, I am aware of that. However, that is not a formal language definition.

Formal as in ANSI/ISO? I don't think these ever say anything about
optimizations. And also the compilers don't really write down the
details AFAIK.

> Yes, in normal builds with a modern compiler it will be optimized away.
> However, I don't think that will happen if the kernel is built with -O0.

The kernel is never built with -O0. It's either -O2 or -Os.
It's a Kconfig choice between CC_OPTIMIZE_FOR_PERFORMANCE or
CC_OPTIMIZE_FOR_SIZE, one is always enabled.
This is not clear from the logic in Makefile.

With -O0 more or less everything breaks.

> > So a declaration would be enough. But an actual stub doesn't hurt either.
> > 
> 
> I disagree. You did not point to a formal language definition saying that dead code
> shall be optimized away and that functions called by such dead code don't have
> to actually exist.
> 
> Do we really have to argue about this ? Please provide examples from elsewhere
> in the kernel which implement what you have suggested (not just the use of
> IS_ENABLED(), but the call to functions without stub which don't exist
> if the code is not enabled), and we can go from there.

None of the hwmon functions have stubs if !CONFIG_HWMON, only declarations.
And there are multiple drivers that use the pattern from above.

One example from drivers/net/wireless/mediatek/mt76/mt7921/init.c

	static int mt7921_thermal_init(struct mt792x_phy *phy)
	{
		struct wiphy *wiphy = phy->mt76->hw->wiphy;
		struct device *hwmon;
		const char *name;

		if (!IS_REACHABLE(CONFIG_HWMON))
			return 0;

		name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7921_%s",
				      wiphy_name(wiphy));
		if (!name)
			return -ENOMEM;

		hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
							       mt7921_hwmon_groups);
		return PTR_ERR_OR_ZERO(hwmon);
	}



*But* the thermal subsystem is actually using stubs.
So the same should be done for thermal_zone_device_update().
As mentioned before, my original claim that declarations of the thermal
functions are already usable when !CONFIG_THERMAL was wrong.
And if the thermal header is to be touched, it should as well be a stub
for consistency.
Given that there are already stubs for all kinds of thermal functions,
this doesn't seem like it would be an issue.


Thomas

