Return-Path: <linux-kernel+bounces-236209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51AB91DEC1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71885283C78
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBAB143736;
	Mon,  1 Jul 2024 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gtFWtrtU"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5339850
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835748; cv=none; b=I+sMv1msw4c2udvJE0fyqa9dEu8PFdWluOtL2ZdFIh8x0QdJ0REFC0gCtt5W//cZywEWXSQd6EOgnLnsQ6Z8dHt8qEhHus6035r0HE9IHwKMWjI8cMcPVDMmtvrnOwoQrSmHdEnqJ2InhN5Mmg6YHx3tr74FdC7z3DuSQtdrl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835748; c=relaxed/simple;
	bh=JJgEQlXJtlS+oqIHnZRbiwWTMMkHgUFtCoEUSHhOfXE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pn19vvi0gg+NJn4ca7dWjNjFWUtg9eZgusdXxUIkN2J4I21D+k6jlPCabxsw5zH59F9Yo/1EqeKYTwXv5EVlOkzMbIXnQme3DBsuxkP64Z51P3FC6PZjC9wTqGlIjvXdsnulE0NXRGijJZ63oO+2/7Ck7+nk7Apz9yLU33ItEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gtFWtrtU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86A046000C;
	Mon,  1 Jul 2024 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719835745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NNHFXuboV35aybAAtJgPt+uHy7GJqBm0IfKboXBxs+s=;
	b=gtFWtrtUHiEHXWBUvLvImnMb5SkMPmovx9sNgbE6qtEy+vKdIN/mHwN6GW8VfhDLWURTrY
	yiKOgkscs7FmbNd6B6M5Z59l8RgRPuLcuEUbT0OPVdc+TGjIHnwFhn8HIbmtleLj5xp7ic
	AkA9dSeyaxqatWh7BItC191jY7onPOhqGKsrcLWYnCWPTe5KHqkjjzn5CG9fS36rOX2VBi
	6vmln2BJmV31n9R1/m30wfgiuC0jPIi6+2v8OvK5080kjVv0tvXdTYFAeWtjka+5CWkVvJ
	Hp1+kpS/4EGAtv5wJSEsN0HIpqViNYuPkkys/HbSduTQNFU1lHp9qebFyjcaPg==
Date: Mon, 1 Jul 2024 14:08:51 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael
 Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for 6.10-rc7
Message-ID: <20240701140851.307df5e3@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Linus,

Here is a fixes PR for the next -rc.

Thanks,=20
Miqu=C3=A8l

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.10-rc7

for you to fetch changes up to b27d8946b5edd9827ee3c2f9ea1dd30022fb1ebe:

  mtd: rawnand: rockchip: ensure NVDDR timings are rejected (2024-05-27 13:=
42:25 +0200)

----------------------------------------------------------------
Raw NAND:

Rockchip NAND controller driver was not checking the timings properly
and the introduction of NV-DDR support broke it.

The core was also misbehaving in some very specific cases: in case of
(unlikely) bitflips in the parameter page, the fallback might have
failed as well but for software reasons.

Finally, the chosen ECC configuration was no longer properly propagated
to upper layers, mostly failing an info message at probe time.

----------------------------------------------------------------
Miquel Raynal (3):
      mtd: rawnand: Ensure ECC configuration is propagated to upper layers
      mtd: rawnand: Fix the nand_read_data_op() early check
      mtd: rawnand: Bypass a couple of sanity checks during NAND identifica=
tion

Val Packett (1):
      mtd: rawnand: rockchip: ensure NVDDR timings are rejected

 drivers/mtd/nand/raw/nand_base.c                | 68 +++++++++++++++++++++=
++----------------
 drivers/mtd/nand/raw/rockchip-nand-controller.c |  6 ++--
 2 files changed, 44 insertions(+), 30 deletions(-)

