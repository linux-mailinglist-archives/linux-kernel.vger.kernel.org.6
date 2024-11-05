Return-Path: <linux-kernel+bounces-396535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA89BCE98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64551C218BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E01D86C4;
	Tue,  5 Nov 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="vvEjIjNZ"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA341D5160
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815438; cv=none; b=ph3KHY82ufdc2oX0WaD7Spqo5Ny73aCF59w5Sy6zGMTpzUNpz+LM4dZUXm/aqeVkOeC/DZvyDon7CD37oTOhnJDe8j4ZleMAip2wm6tZWzxIUuNgv0G5eMorvD5ahYpm0RoslUqrZwImJLNa66k2NqckL7EQ5QC6KTNy/G5Q0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815438; c=relaxed/simple;
	bh=bTWTSNiAotUnHnllbcY0LdMXkwpE2P3sBMcLOhKkx5I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CJfUDbrGgrPDi/rejdng5mXfVBqwa2gdy65/0NA1gI59gjCPIlY+tup/G9SPGLKCDs0W6SUvdxIO1PcbEPRizsZp5j132wNcJNs0/Qw2NlbMXU+G9cgOrNh9tPKmnUyn0dLg+0HZxGdKfV+v/JxSyXf8hGPz+FmrYHN++zbsq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=vvEjIjNZ; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 74F009C5794;
	Tue,  5 Nov 2024 08:58:19 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VBzwaD1mWAko; Tue,  5 Nov 2024 08:58:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AF3679C63E4;
	Tue,  5 Nov 2024 08:58:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com AF3679C63E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1730815098; bh=SBKGTrlLTDQIGERPKwoCpnmjiyE6/uKRwA3Oxcr3bRg=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=vvEjIjNZBE+9/GzVkprdX13JfbvyhVjnJCzZZHS3fU3uJQu1pU0KybGYrg2m6z6co
	 uMwJY9KT7NrXacgCmFv1V6myU7JtG4Y/TMiNRX6bB7wobei8Cvy88/0nCGTg3qhiZC
	 sR2j3RsfVHtUwlkM5Qi+GPyvHez+nIllMlBgM3BlLcv1Gnot+M8G2jSmZJZ2+Nr5gw
	 cgbRtOyqTUJ3CT6Xq8waGPGWX5MOCz6UwOrP1KekXYe2YTsY9a4mmeQEQOORUcoqmH
	 qptzEcWOlWAqpYzeMJ9+mFcPYryr/HqZaF/ADF783b2T5GUJ6lkxNsWliGA6RX6Rwe
	 JS/0pT5GRBwfA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xvHjvFmXB96q; Tue,  5 Nov 2024 08:58:18 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 762169C5794;
	Tue,  5 Nov 2024 08:58:18 -0500 (EST)
Date: Tue, 5 Nov 2024 08:58:18 -0500 (EST)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Shawn Guo <shawnguo2@yeah.net>, 
	Russell King <linux@armlinux.org.uk>, 
	Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	imx <imx@lists.linux.dev>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Message-ID: <1044800423.57572.1730815098440.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <Zyj0VsTJ2qDHiss2@eichest-laptop>
References: <20241030122128.115000-1-eichest@gmail.com> <ZyXTFhEm9UCBii2c@dragon> <ZyY41nJY9ghwe-Y4@eichest-laptop> <065268d6-84eb-4247-b834-40a9ff32c1f4@gmx.net> <ZyiAMpjmXuVMi5FX@eichest-laptop> <787b45a1-9f8d-493d-8930-e1c8d396c818@gmx.net> <Zyj0VsTJ2qDHiss2@eichest-laptop>
Subject: Re: [PATCH v1] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
Thread-Index: du0Xtk0rWav2/sd22e8hfQbQ+0Eh0A==

Hi Stefan,

On Monday, 4 November, 2024 17:20:38, Stefan Eichenberger wrote:
> Hi Stefan,
> 
> On Mon, Nov 04, 2024 at 12:39:40PM +0100, Stefan Wahren wrote:
>> Hi Stefan,
>> 
>> Am 04.11.24 um 09:05 schrieb Stefan Eichenberger:
>> > Hi Stefan,
>> > 
>> > On Sat, Nov 02, 2024 at 04:35:19PM +0100, Stefan Wahren wrote:
>> > > Hi Stefan,
>> > > 
>> > > Am 02.11.24 um 15:36 schrieb Stefan Eichenberger:
>> > > > Hi Shawn,
>> > > > 
>> > > > On Sat, Nov 02, 2024 at 03:21:58PM +0800, Shawn Guo wrote:
>> > > > > On Wed, Oct 30, 2024 at 01:21:12PM +0100, Stefan Eichenberger wrote:
>> > > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>> > > > > > 
>> > > > > > Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio. This
>> > > > > > change will fix commit d469b771afe1 ("ARM: dts: imx6: update spdif sound
>> > > > > > card node properties") which moves away from the old "spdif-controller"
>> > > > > > property to the new "audio-codec" property.
>> > > > > > 
>> > > > > > Fixes: d469b771afe1 ("ARM: dts: imx6: update spdif sound card node properties")
>> > > > > It doesn't look a fix to me.
>> > > > I agree somehow, it was just that before the referenced commit our test
>> > > > succeeds with the imx_v6_v7_defconfig and after that we get the
>> > > > following error:
>> > > > [   24.165534] platform sound-spdif: deferred probe pending: fsl-asoc-card:
>> > > > snd_soc_register_card failed
>> > > this error should have been in the commit message including the
>> > > information which platform/board is affected.
>> > Okay, I will add this information to the next version. We see this error
>> > on an Apalis iMX6 which has in my variant an NXP i.MX6Q SoC.
>> > 
>> > > > So maybe it is not a fix in the sense of a bug, but it fixes the error
>> > > > message. However, I'm also fine with removing the Fixes tag.
>> > > But this patch doesn't look like the real approach.
>> > > 
>> > > Could you please clarify the impact of the regression?
>> > So the problem is that before commit d469b771afe1 ("ARM: dts: imx6:
>> > update spdif sound card node properties") the audio driver was
>> > using an implementation of linux,spdif-dit and linux,spdif-dir which was
>> > directly inside the fsl,imx-audio-spdif compatible driver. Now with the
>> > referenced commit the idea is to use the more generic linux,spdif-dir
>> > and linux,spdif-dit compatible drivers. That's why this driver must be
>> > enabled in the kernel configuration.
>> > 
>> > > Is it just this error message and audio works fine or is audio also broken?
>> > It is not just the error message, audio is not working because the
>> > driver deferes and because it is not enabled it will never succeed to
>> > load. I don't know if this is called a regression, because the driver is
>> > there it is just not enabled in the imx6_v7_defconfig. I thought because
>> > a lot of the i.MX6 based board use the generic driver, it makes sense to
>> > enable it in the imx_v6_v7_defconfig.
>> okay, thanks for the clarification. From my understanding
>> imx6_v7_defconfig is just an example config for testing. All possible
>> users of these boards might have their own configs and stumble across
>> the same issue. So I thought it would be better to add the dependency in
>> the Kconfig of the FSL audio driver.
>> 
>> I'm not that audio driver expert and don't know how the dependency
>> handling between the FSL audio driver and the required codecs like
>> SND_SOC_SPDIF. So it's possible that I'm completely wrong here and your
>> approach is the best we can do.
> 
> That might be a good point. I don't know how this is usually handled.
> @Shawn and @Elinor, do you think this could be an approach to make
> SND_SOC_FSL_ASOC_CARD select SND_SOC_SPDIF? It already seems to do this
> for SND_SOC_WM8994 and SND_SOC_FSL_SPDIF.

SND_SOC_FSL_ASOC_CARD will compile the machine driver fsl-asoc-card,
SND_SOC_FSL_SPDIF the CPU DAI driver fsl_spdif for the SPDIF
and SND_SOC_SPDIF the codec drivers spdif-rx and spdif-tx.

In my commit series I made SND_SOC_FSL_ASOC_CARD select SND_SOC_FSL_SPDIF
because the old machine driver previously compiled with SND_SOC_IMX_SPDIF
selected SND_SOC_FSL_SPDIF.
But because fsl-asoc-card is a generic driver, it could be used on a system
that doesn't have an SPDIF device, and therefore should not require
SND_SOC_SPDIF nor SND_SOC_FSL_SPDIF.
So maybe it is not a good idea to automatically select SND_SOC_FSL_SPDIF or SND_SOC_SPDIF.

On the other hand, if every imx6 or imx7 boards have an SPDIF device, then
I suppose SND_SOC_SPDIF can be put in imx_v6_v7_defconfig.

Regards,
Elinor

