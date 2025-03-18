Return-Path: <linux-kernel+bounces-566483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F8A678A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB81773CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B4A20E33E;
	Tue, 18 Mar 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fM5q+AK1"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7C20F061
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313763; cv=none; b=FkXNHKNB40EnsJN1Y4WGdDCDXqQ2kaZpQfTm4iuL9EG8gEfKZ2RBTHjzFRXjxWgLk0I1TZG0H3Dw+4W+6Bcm+yeCFLfPYLLT7/QjdnsSQQfAXJ1OImEe/zUaFQ3eCEoFpV/g97hvFgFONc05fNvqkNCpN4A7fi8pl1rR5VjQVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313763; c=relaxed/simple;
	bh=baOMbasIHySzN1tAztBhKFZtQWvc7C7Z2zw5B3J1lYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/ZJvRMq28S4M6c11FTqC2ncNZr9ED6GPTbBTvl0IFsNcTOmoW5x1VES69o5VPGjZH2i2pe9vSaUOCezwE3kieLy8NeTLAhDT5ZjMVxs115CpL5glwlFZDOuObSizlgsNbb1OjNHysxAF9Sx22ndITILEoYdZnWEAyl2z73FUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fM5q+AK1; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B84CF4431C;
	Tue, 18 Mar 2025 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742313755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baOMbasIHySzN1tAztBhKFZtQWvc7C7Z2zw5B3J1lYM=;
	b=fM5q+AK1CwYjUwitI0Cpn3nkCc3ChML/bUVxQAO4WCOPMQBJbDA2kT6ZDrE3s9xL9XkiXa
	tidgSSlZ7Nupi/KYPMSJKw0HhIrPemspSi4GI5uaaPpZTDS4B3llqyLOMUbQcNXYW5zFz7
	1Zw8Tsa83IG1i1MN8kFMc86gDOEiejrvSKL9rJIASf2dGidPgfBJnUsh4sCRr1N4/zuBC/
	6BKmhNR7WCWdoPbbKnPSwIVzuA+C854HLUpohwXgGw0opkc9L0pV95P71bIHb4h+SlXDMJ
	OpYza+rkGP9mKQah9G3CMEk9LBt9a0q/gx+h5nNvkUXnL9V+z7ZwB0CYpMVKgA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Lucas De Marchi <lucas.demarchi@intel.com>,  Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,  Rodrigo
 Vivi
 <rodrigo.vivi@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,  Jani Nikula
 <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  Tvrtko Ursulin <tursulin@ursulin.net>,
  Karthik Poosa <karthik.poosa@intel.com>,  Reuven Abliyev
 <reuven.abliyev@intel.com>,  Oren Weil <oren.jer.weil@intel.com>,
  linux-mtd@lists.infradead.org,  dri-devel@lists.freedesktop.org,
  intel-gfx@lists.freedesktop.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/11] mtd: add driver for Intel discrete graphics
In-Reply-To: <20250302140921.504304-1-alexander.usyskin@intel.com> (Alexander
	Usyskin's message of "Sun, 2 Mar 2025 16:09:10 +0200")
References: <20250302140921.504304-1-alexander.usyskin@intel.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 17:02:33 +0100
Message-ID: <87frja72ee.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegrlhgvgigrnhguvghrrdhushihshhkihhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehluhgtrghsrdguvghmrghrtghhihesihhnthgvlhdrtghomhdprhgtphhtthhopehthhhomhgrshdrhhgvlhhlshhtrhhomheslhhinhhugidrihhnthgvlhdrt
 ghomhdprhgtphhtthhopehrohgurhhighhordhvihhvihesihhnthgvlhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Alexander,

On 02/03/2025 at 16:09:10 +02, Alexander Usyskin <alexander.usyskin@intel.c=
om> wrote:

> Add driver for access to Intel discrete graphics card
> internal NVM device.
> Expose device on auxiliary bus by i915 and Xe drivers and
> provide mtd driver to register this device with MTD framework.
>
> This is a rewrite of "drm/i915/spi: spi access for discrete graphics"
> and "spi: add driver for Intel discrete graphics"
> series with connection to the Xe driver and splitting
> the spi driver part to separate module in mtd subsystem.
>
> This series intended to be pushed through drm-xe-next.

I need to test patch 1, sorry for the delay, I will do that and if I'm
happy with the result I'll apply this patch to mtd/next at -rc1 (better
having this kind of change early in the cycle).

The other patches can go through drm I guess, regardless of the presence
of patch 1. I'll send my acks after testing.

Thanks,
Miqu=C3=A8l

