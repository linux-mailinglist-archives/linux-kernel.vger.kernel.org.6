Return-Path: <linux-kernel+bounces-432521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F5F9E4C71
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD70283163
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B9187FE0;
	Thu,  5 Dec 2024 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QDNkxxo0"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2721779DC;
	Thu,  5 Dec 2024 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366824; cv=none; b=qTYJ5BJtupx2XoL0wkZmS0HewNzVyL75VdFR4OI/LC8mOaMQLSGxQ6xhaHQcvBs/5a0lKJGZgETTiA0lNU+kgryKrylcEJW5hjLuKlwEteqfRKK85LMKMaYwH1y1o00g4pvYwDplVZ1gsH6WDUDIYk/1ETv5dienr099ywyavik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366824; c=relaxed/simple;
	bh=wApEBGjC0yd2xU/0kNlrtiJUYL5vQt8KwhOtTnkT54Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGL2cve242jeyljbqrVAffHjtBcEEW61xCqIdDeoQcitgITH7EwfFtLllAFUoKYcN8zx0IPzRz01LoYx80rvjACMHbIfWpdMJK+OjDlQIvEi/VDl4YkEgAMoDdenSOoDyVIQkRp9T4FxLxIPlWGnUjMFbNm2p/LFpYdxV/d984k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QDNkxxo0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B52kCTU12259215, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733366772; bh=wApEBGjC0yd2xU/0kNlrtiJUYL5vQt8KwhOtTnkT54Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QDNkxxo0CUNwGTWipTFLrcHPdioO5Njo2fougSNgNEz53J/P8XIYVA29weF55Arwt
	 1j0HRjwnHvELbtIVUQrdVXspehugvMN2eDvOWU+fijGfF/gZDMFPraqmJ1w7WCqHe6
	 8VhDwGg133qlULZSTyPiCxGxvjooVJHuxzS0C9Nv2nAeES3ruXjqB1o43bIys6DA8e
	 z+Qk81eWhwWWAiZMw2v7HaOuJSA1gSIgak8IMkTEmVv5AI/YjUsueZE4r2UJlFLyii
	 hfQLmKFFNKKcnPAixaSmAbpysB6IvCgefeSfmWXZKNoZwJRvlW5boySuTGrPPgow81
	 JXg+jUtpZiMMw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B52kCTU12259215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 10:46:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 10:46:12 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 5 Dec 2024 10:46:11 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Thu, 5 Dec 2024 10:46:11 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>
CC: Hridesh MG <hridesh699@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        Joshua Grisham <josh@joshuagrisham.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: RE: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
Thread-Topic: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
Thread-Index: AQHbNrQTIJ19XS0byUOl9H9plIHbsrK6+nSAgABvgoCAASTGgIADYgSAgA/PZwCAAOHGAIAGb05Q
Date: Thu, 5 Dec 2024 02:46:11 +0000
Message-ID: <932d49003ee7444186353082495abb10@realtek.com>
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
	<20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com>
	<87iksmq8ho.wl-tiwai@suse.de>
	<CALiyAo=5aLbYEyRWWw7QscTk6cXy5qckHToiPL6h4fKM9=skLg@mail.gmail.com>
	<87ed387ioq.wl-tiwai@suse.de>
	<CALiyAo=awTsGQnGH5UPB7dF5QsZ2AFkKv5LcJkJRXV9sv51iqQ@mail.gmail.com>
	<CALiyAokt1zY4a6F0DTpyYAmu38D1Fk0k0QvsFtXYHzQ7suS38A@mail.gmail.com>
 <87cyib4xmx.wl-tiwai@suse.de>
In-Reply-To: <87cyib4xmx.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

You can assign model "ALC2XX_FIXUP_HEADSET_MIC" for the quirk.

+       SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC2XX_FIXUP=
_HEADSET_MIC),

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Sunday, December 1, 2024 4:27 PM
> To: Kailang <kailang@realtek.com>
> Cc: Hridesh MG <hridesh699@gmail.com>; Takashi Iwai <tiwai@suse.de>;
> Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Jonathan
> Corbet <corbet@lwn.net>; Stefan Binding <sbinding@opensource.cirrus.com>;
> Simon Trimmer <simont@opensource.cirrus.com>; Joshua Grisham
> <josh@joshuagrisham.com>; Richard Fitzgerald <rf@opensource.cirrus.com>;
> linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-doc@vger.kernel.org; Shuah Khan <skhan@linuxfoundation.org>
> Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro=
 5
>=20
>=20
> External mail.
>=20
>=20
>=20
> On Sat, 30 Nov 2024 19:58:26 +0100,
> Hridesh MG wrote:
> >
> > > know. I'll make an attempt to understand the cases and process
> > > coefficients before sending v2.
> > I did a deep dive into the code and frankly I'm a bit stumped right
> > now since it appears that the code for the headset type detection was
> > written by Kailang Yang from Realtek and i could not understand it
> > since I'm not sure where to look for documentation on realtek codec
> > processing coefficients.
> >
> > To rephrase what I had meant earlier, type detection for the ALC287 is
> > currently not supported. I made an educated guess and added the codec
> > to an existing block of code, which detected it as CTIA. However, I
> > have no way of verifying if this guess is correct. Do you have any
> > advice on what my next steps should be?
>=20
> Kailang, could you check that?
>=20
>=20
> thanks,
>=20
> Takashi

