Return-Path: <linux-kernel+bounces-199653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B56AB8D8A63
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7881228592B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42F13776F;
	Mon,  3 Jun 2024 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="HBMnh5vl"
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABE259C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.3.6.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443589; cv=none; b=lZrm9QQZpBoXo+DbTG9zaRTUbQiag1hW2X3kXSYZNAe9ujZndVoSVVOAsva6+vWYmkPX7WFeYjqK/GqR7OteHAmgVKNtWiqGWKwNFqPHsu/P7cRdgfHVm3mothWU5zLF2K5WLQ8t+xOye5YrgQ0TRlyYIPUjKGBOXmOwrr90tMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443589; c=relaxed/simple;
	bh=2FaW7jU8Cx/GwNp4bNE8A3s5T06Tt97CBdNwcgcim9g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=t7m83OE9izfPlWMY8x4vgTwXsHMMeFEYci3AC8fTcW4sVSnfJbyIggIcHfRQugRAE8idP4HvjMG2Y+18EKNtlbFkFgjGvskgG0qVY7Ircbwhpi05pWHGcn3IHbLVXyIAtKR1vpuRArd6JaaTRCCaSAEweXg+DM4pM9GxPm65Chk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=HBMnh5vl; arc=none smtp.client-ip=81.3.6.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id 97FAD106013E;
	Mon,  3 Jun 2024 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1717443199;
	s=s1; d=bens.haus;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=2FaW7jU8Cx/GwNp4bNE8A3s5T06Tt97CBdNwcgcim9g=;
	b=HBMnh5vleQlaTPovT+nccD1i9T6GqApnbvH/85UGMyoP4F2Sdm7o21gvPxdQVABI
	LvYo/WP243sTk4GPHlXaX2yZW0IHtJZFrDkXXTc25AanJcz12qkOg+G7uPhekqgAO3T
	iaXEA+2pSlJiqsrYTllR06Ue284+L7F8bxe/R5Z8OkOeR4xfN/K5avlZtjfWTZW70U0
	kQtkt1tcaO12AcHWWU8J/JEu5m9xZgKqQA3fTD7UQ+bP+aettwgdMI53z9+5NJJ4r3W
	ihQYQi2+5Fi0Px8VOq9NXQLS/NX35r3fDxprk4M8NN4QsAUSzHr9/mL7hskm++/swOU
	nLlTdoBEiw==
Date: Mon, 3 Jun 2024 21:33:19 +0200 (CEST)
From: Ben Schneider <ben@bens.haus>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Schneider <bschnei@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <NzURcjd--3-9@bens.haus>
In-Reply-To: <f2284d6b-2e75-4896-9e10-caf2f72854a0@lunn.ch>
References: <20240603012804.122215-1-ben@bens.haus> <20240603012804.122215-2-ben@bens.haus> <f2284d6b-2e75-4896-9e10-caf2f72854a0@lunn.ch>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jun 3, 2024, 05:46 by andrew@lunn.ch:

> The problem is, most systems don't have the new bootloader. And so if
> you enable 1.2GHz, they are going to be unstable.
>
Based on my testing, the A3720 was unstable using a bootloader built
with Marvell's source without regard to clock speed or frequency scaling.

That is, it didn't matter if 1.2Ghz was enabled or not, and it didn't matte=
r
if cpufreq-dt was loaded or not, my devices were reliably crashing when
trying to use Marvell's source instead of Globalscale's for building the
bootloader. When I dug in to find the difference, this DDRPHY setting
was one of two that I found. I also found that setting it to the value in
Globalscale's repos restored stability to the devices.

I then tested 1.2Ghz bootloader speeds as well as frequency scaling and
found that they worked fine. I've been keeping track here:
https://github.com/bschnei/ebu-bootloader

> Rather than making this unconditional, i think it needs to be
> conditional on knowing the bootloader has been upgraded. Could you add
> code which looks in the DDRPHY and see if 0xC0001004 has the correct
> value. Only then enable the additional clock speed.
>
I think there are two potential issues with doing something like that. Firs=
t,
that DDRPHY=C2=A0value has been flipped back and forth. The change I
submitted to Marvell just undoes this change from January 2021:
https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/commit/c3a8d3c7=
ff4bd460770b0cf601e57a6f70cb1871
Perhaps it would be OK if the older code is also stable, but I haven't
tested it.

Second, the value seems to be deliberately different for other memory
configurations (DDR3) which makes the conditional logic more complex
if it's meant to work for all A37XX variants, and I don't have other varian=
ts
to test.

Given the history of this setting getting flipped back and forth, and
having read through a few old threads on this subject, it's my theory
that some of the instability issues that were attributed to kernel frequenc=
y
scaling and/or 1.2Ghz as a speed were more likely attributable to bad
bootloaders all along. I've reached out to Armbian and Arch communities
to let them know in the hope of finding other users of these devices
that might be willing to test, but have not received any responses.

It's also worth noting that my devices came from the factory with the
bootloader clocked at 800Mhz. I'm pretty sure the OS cannot set a
speed above=C2=A0the bootloader=C2=A0clock speed. As a result, at least for=
 the
ESPRESSObin Ultra, the only devices I would expect to break are those
where users have put in the work to build (or taken the risk of flashing)
a bootloader clocked at 1.2Ghz. When the kernel encounters one of
those devices it currently disables frequency scaling entirely (cpufreq-dt
will not load) leaving them to run at full speed constantly. If there are
users who can't/won't update their bootloader and for which frequency
scaling is unstable, it seems like it would make more sense and facilitate
further testing to use kernel config or userspace tools as the place to
disable scaling.

Thanks!

Ben

