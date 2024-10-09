Return-Path: <linux-kernel+bounces-356315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FCC995F73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A52B1F24441
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173C158DB1;
	Wed,  9 Oct 2024 06:09:51 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231241E519
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454191; cv=none; b=NK8ioYaH8GNUG4BjZ1gkf+Ltv6dhaWovoF2+g5AQulh3N3xF3hHmDR6qmJW+xNNtxIrqBaJo5n2VkxvYMSau71o0ZO1pYoJKPgB/a/wD+dFYvu5QWWDnr0Rz5xgKOglu72gdkVb7mh4Sghhw/rgbj2mzKILT7bWIUA/tggTC0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454191; c=relaxed/simple;
	bh=2C/DYVTbW7dN24xicSg+1V6MJky+mekZnqgt+79cJtw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=g1rvml+/aw3kkHrSWvjRCFR8OptO8zp7y09S82AngW7tx96G/1qbFwN2bN4+sn4VO7XakXubm5mn/jfsmtDpAFjBZahWvZvDavgKNGDu6qBHESGM/LlhR+JzMvdGLkmHTVRnZ/tp76pAZN+m07CzqlZiF2lL5QSw5LcCnmsYgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 44441294730;
	Wed,  9 Oct 2024 08:03:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SDQz2X6cGIl0; Wed,  9 Oct 2024 08:03:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 835172A87E7;
	Wed,  9 Oct 2024 08:03:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ay6qInBW_KBx; Wed,  9 Oct 2024 08:03:52 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 51353294730;
	Wed,  9 Oct 2024 08:03:52 +0200 (CEST)
Date: Wed, 9 Oct 2024 08:03:52 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: Benedikt Spranger <b.spranger@linutronix.de>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <883601802.30668.1728453832223.JavaMail.zimbra@nod.at>
In-Reply-To: <0840be30-63bc-449d-a9a4-c4e6b54c8885@huawei.com>
References: <20241008133342.1937674-1-b.spranger@linutronix.de> <0840be30-63bc-449d-a9a4-c4e6b54c8885@huawei.com>
Subject: Re: [PATCH 1/1] ubifs: Try to recover from missing znode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF131 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Try to recover from missing znode
Thread-Index: I2FbrW4jE5dKP7zIOPm0UuQ/GQmFIA==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "Benedikt Spranger" <b.spranger@linutronix.de>, "linux-kernel" <linux=
-kernel@vger.kernel.org>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "richard" <richard@nod.a=
t>
> Gesendet: Mittwoch, 9. Oktober 2024 04:23:02
> Betreff: Re: [PATCH 1/1] ubifs: Try to recover from missing znode

> =E5=9C=A8 2024/10/8 21:33, Benedikt Spranger =E5=86=99=E9=81=93:
>> After powercut on a system using ubifs mounting failed:
>>=20
>> 2024-09-30T12:38:26.880487+02:00 sonja kernel: UBIFS error (ubi0:0 pid 2=
178):
>> ubifs_read_node [ubifs]: bad node type (255 but expected 9)
>> 2024-09-30T12:38:26.880506+02:00 sonja kernel: UBIFS error (ubi0:0 pid 2=
178):
>> ubifs_read_node [ubifs]: bad node at LEB 103:46920, LEB mapping status 0
>> 2024-09-30T12:38:26.880509+02:00 sonja kernel: Not a node, first 24 byte=
s:
>> 2024-09-30T12:38:26.880510+02:00 sonja kernel: 00000000: ff ff ff ff ff =
ff ff ff
>> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ........................
>>=20
>> While traversing over zbranches during the journal replay one zbranch
>> points to a znode, which was not written to the flash and therefore the
>> flash is empty.
>=20
> UBIFS guarantees two things for znodes:
> 1) all index nodes(in commit seq N) are written on flash before master
> nodes(for commit seq N) are written.
> 2) all index nodes(in commit seq N) won't be erased from flash before
> master nodes(for commit seq N+1) are written.
> So, I don't understand that why znodes not exist during journal replaying=
?

In addition to that, is just one znode missing or are larger parts of the f=
lash
empty?

Thanks,
//richard

