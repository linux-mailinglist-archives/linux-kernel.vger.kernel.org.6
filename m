Return-Path: <linux-kernel+bounces-401310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D79C18A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74654285423
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B44C1E0B9C;
	Fri,  8 Nov 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QztMvHcL"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357D1CFEC0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056485; cv=none; b=dd0qbm4dOxRfqoVbVHAE1jcGoxihfuVgx2k2nxFiAF3PQ8Enl4liwvskYikOHssD1iCn2JzRyhG1MUFzQSfV21f6tvLrcXvXUf+ZqPCCoHJzPwIwWWp0BxmGQ4wX8CgUrWy3jVkMwWnWx6jAleZ1A1vMWXqA/hQAK6MEUx6a/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056485; c=relaxed/simple;
	bh=xm3UhMCd7zn0wf/NB/NpG8HDn8ZRdu/b34t338J+8xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGh00jdjNFzFBcZmXIVuhEdHWvLAUJXlFpu55C6VaZKEpeI6knu2nX9TnqkgymxU8ICMwmHkmonptClo288E85GVnwp3adHqC/9Cr1qlFiX0u114kqlmZpKxqQlUcf1FeUexZzl4bY1mC6AtjukNPZwgo31Kzvm+alBXyeKaSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QztMvHcL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB0E01BF206;
	Fri,  8 Nov 2024 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731056478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xm3UhMCd7zn0wf/NB/NpG8HDn8ZRdu/b34t338J+8xk=;
	b=QztMvHcL/LJyrVDUjANfvRSEswWgGPCBkv8uGEXEF5EpfVhacT90xYLK/fwUPj2/au1Tc3
	1kh4DFm1qrJD/IV8wBboJjVIHQleo2/noYXHVSj16eJsENavfZmk1SsWmfowSgsSLPfavk
	phoOMfYt1+uV5mwHNLWE7Uhf/KujTA3RdCjpBF9mXa7ugfbiBd0ygDjVIOMZTYf5yTZ12/
	/oYn9/UfoHVdXU+OSnEKkoxw3iYpgtwPRZmg+NDNQZEip+rkelvRp8lva1M2fJRofpKpS8
	3U6vTMUP93+AAK89JLssHwaAi7z29pUaKMK4z+2+4qbL5LsfSdJhj+LIGLD6Kg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,  "Gupta, Anshuman"
 <anshuman.gupta@intel.com>,  "Deak, Imre" <imre.deak@intel.com>,  "Richard
 Weinberger" <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  "De
 Marchi, Lucas" <lucas.demarchi@intel.com>,  Thomas =?utf-8?Q?Hellstr?=
 =?utf-8?Q?=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,  Jani Nikula
 <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  Tvrtko Ursulin <tursulin@ursulin.net>,
  "Weil, Oren jer" <oren.jer.weil@intel.com>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
  "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] mtd: intel-dg: wake card on operations
In-Reply-To: <Zy1EAIPEaY8Wlh-h@intel.com> (Rodrigo Vivi's message of "Thu, 7
	Nov 2024 17:49:36 -0500")
References: <20241022104119.3149051-1-alexander.usyskin@intel.com>
	<20241022104119.3149051-7-alexander.usyskin@intel.com>
	<Zx-mPQSHXv5Teq_j@intel.com>
	<CY5PR11MB621157335FFB1089F49CEF8B954A2@CY5PR11MB6211.namprd11.prod.outlook.com>
	<CY5PR11MB6366EF9CA6552ADF6E01A557ED4B2@CY5PR11MB6366.namprd11.prod.outlook.com>
	<Zyk5kueKlusKlwqM@intel.com>
	<CY5PR11MB636622B23A3646D58A70A920ED522@CY5PR11MB6366.namprd11.prod.outlook.com>
	<Zy1EAIPEaY8Wlh-h@intel.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 08 Nov 2024 10:01:15 +0100
Message-ID: <87cyj6aylg.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com


>> > That's the part that I'm not sure if I agree. if I remember from some
>> > experiments in the past,
>> > when you call to wake up the child, the parent will wakeup first anywa=
y.
>> >=20
>> The child (mtd device) does not exist at this point of time.
>> To create MTD device, the partition table should be provided
>> and it read directly from flash that should be powered to do read.
>
> I don't understand... you have the mtd->dev at this point... this is
> the one you should be touching, not the mtd->dev.parent... even at the
> probe, but moreover on everywhere else as well.
>
>>=20
>> > > Considering above, is this move is justified?
>> > > Also, MTD drivers tend to enable parent rpm, not its own one.
>> >=20
>> > What other drivers are you looking for reference?
>>=20
>> drivers/mtd/nand/raw/tegra_nand.c
>> drivers/mtd/nand/raw/renesas-nand-controller.c
>> drivers/mtd/maps/physmap-core.c
>
> I see they getting pdev->dev... not the parent...

That's three drivers where there is probably room for improvement.

These differences are subtle and likely un-catch during review. Feel
free to correct the drivers if you think they are wrong and more
importantly, do the correct thing in your own.

Thanks,
Miqu=C3=A8l

