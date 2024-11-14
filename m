Return-Path: <linux-kernel+bounces-409590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EDD9C8F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C85DB43208
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FED15C144;
	Thu, 14 Nov 2024 15:50:39 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071EE2AEF1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599439; cv=none; b=CH1sTNrwH6hLYOqDX2L4FlN3UW/v9O64TiXTXxQ86i6jz2CFGdFkFiEtqnLD7+NIgGQuAIPw8J0VypUS/KOXPdxY5utV8S3ETvisrXUUxrTzF16bmpHg1Ve74wpgx9oNRRFZus+x0051ZwTAwIlIY4jyXF58i9CtjdmTsWVyUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599439; c=relaxed/simple;
	bh=vcxSPoO/LmnLNkcxwNba1mblqBCjbM4FVGKWelTaG7E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jXp5usq5fBCJymYn9Z5kGw1ACmpc2wvD0Kk3agR9pazUQ7R68v0UUAMjKc2omkZ2PhvBfRscJcHetjdK6rBYPBEGKEeCZoKxzCZvhvebuH3J3kKrIgbouoH1qbhsyxfri1xTzs/SDUpZzvwKGt356iBf4g/WoMSL0NpuMvp0YU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 67C9F2BFA23;
	Thu, 14 Nov 2024 16:50:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ltrO9K3SGxkH; Thu, 14 Nov 2024 16:50:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BBCC42BFA25;
	Thu, 14 Nov 2024 16:50:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gjdoMpmc9UA2; Thu, 14 Nov 2024 16:50:27 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8BCC62BFA23;
	Thu, 14 Nov 2024 16:50:27 +0100 (CET)
Date: Thu, 14 Nov 2024 16:50:27 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, joern <joern@lazybastard.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Fabian Vogt <fvogt@suse.com>
Message-ID: <1898930663.21166792.1731599427304.JavaMail.zimbra@nod.at>
In-Reply-To: <20241114154442.25920-1-tiwai@suse.de>
References: <20241114154442.25920-1-tiwai@suse.de>
Subject: Re: [PATCH] mtd: phram: Add the kernel lock down check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF132 (Linux)/8.8.12_GA_3809)
Thread-Topic: phram: Add the kernel lock down check
Thread-Index: fEx14KVYL22/FSDt0R0dYYGq9HpsYA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Takashi Iwai" <tiwai@suse.de>
> An: "linux-mtd" <linux-mtd@lists.infradead.org>
> CC: "joern" <joern@lazybastard.org>, "Miquel Raynal" <miquel.raynal@bootl=
in.com>, "richard" <richard@nod.at>, "Vignesh
> Raghavendra" <vigneshr@ti.com>, "linux-kernel" <linux-kernel@vger.kernel.=
org>, "Fabian Vogt" <fvogt@suse.com>
> Gesendet: Donnerstag, 14. November 2024 16:44:41
> Betreff: [PATCH] mtd: phram: Add the kernel lock down check

> The phram MTD driver may map any memory pages no matter whether it's
> reserved or whatever used for systems, which basically allows user
> bypassing the lock down.
>=20
> Add the check and abort the probe if the kernel is locked down for
> LOCKDOWN_DEV_MEM.
>=20
> Reported-by: Fabian Vogt <fvogt@suse.com>
> Suggested-by: Fabian Vogt <fvogt@suse.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Good catch!

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

