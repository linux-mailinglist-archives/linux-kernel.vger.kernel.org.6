Return-Path: <linux-kernel+bounces-551410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A13A56C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B7D3A7F65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D92721CA1C;
	Fri,  7 Mar 2025 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="omhhvBeK"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93A21ABC5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361500; cv=none; b=m7/gn8/r/rXArjPFVuN7X2Y35ZewjdTzYsr+LTWu82n6kbU9U/WJ5XJdXLbVcIzD6Wo4/0OPsmVIBg+xisgZGmQ7uvrOH3KF3JigV9m1bG5M4xvKHc2F31l9PM7tTltUyercpRYXH9/Ai6mAabU5RcjTdn1xG3cy9QP9hrh0rMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361500; c=relaxed/simple;
	bh=rAKhmiFutwtrHDdVUzP3i4ARxVv/+H6cHq664FvjxIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SVyt6fMvPzTvwQNt6qzzqKkAcguraYIOeQIj8PBZWGribMIGATnzmw4fsj82tXUJ472JqXOhZAnRq7yS+jpwPB7fU7sWswt1MoEp/mHyYaWq+VDMgSBC2gTt3+746iaL9tNyP4WJeWULj+FNq6VzZwV9Bb8iqUNaBgmDhbzHm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=omhhvBeK; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 51FA3580031
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:08:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F285442CC;
	Fri,  7 Mar 2025 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741360111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VGmtI+SKLrf/sudcADm+6/sRFbbFUHl7sOsN7wcaehM=;
	b=omhhvBeK+J5BBV6p5GqmAgiucIVoWh3s1rCE9eAdzS0LDSUxc9N24Z04oVBXXGhNwtB3Rw
	W1mClHMYI3bXg96wSidvA3FG6U/PEauc/LXaOdhmnygCvMdCsJ2Oco5UQGBFjmv9Mm9pTA
	Qoxu6TSfHA4j171s1mqG326S/pdiU4R0mq11xi2hkXGgixLzFHZBrAvvtMZNO8OxoylcKA
	B6UQW+lqRHTZjWKbiPjHV+xf9OFQqqwyGoqVJUR62IIyxEqwQ4LdE6d+dKBSH3/72UuIy2
	T4KLc65cDEB4+3uJKYvgoHQRZkluRifWPmQhvzkqQVhhVTGlPk5pez5PmimxJQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 00/21] mtd: spinand: Add octal support
Date: Fri, 07 Mar 2025 16:08:19 +0100
Message-Id: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOMLy2cC/x3MTQqAIBBA4avIrBtQKYOuEi38mWogNDQqiO6et
 PwW7z1QKDMVGMQDmU4unGKFagT41caFkEM1aKk7qVWLF0eXYkCDFdkrTP6wG5q5D844klq2UOM
 908z3Px6n9/0An1UM0mgAAAA=
X-Change-ID: 20250214-winbond-6-14-rc1-octal-6f7db6be0204
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugfefveegtdfhvdehudfgkefgheetveefvdelheeuiedukefgfeejheefheevueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeelvddrudekgedruddtkedrudejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrudejiedphhgvlhhopegludelvddrudeikedruddruddtiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepshhtlhhinhdvseifihhnsghonhgurdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

spi-mem and SPI NOR already have octal support, but there are octal SPI
NAND chips as well, which will be supported after this series. For now
we focus on SDR modes or mixed modes, where the opcode indicates the
content of the operation.

Support for three Winbond chips is added: W35NxxJW (xx: 01, 02, 04).

The series is mostly split into two parts:

- Renaming the op macros to clearly indicate the number of lines and
  whether each subpart of the operation is SDR or DTR, in order to
  clarify them.

  This has been discussed and agreed upon with Tudor in a
  previous discussion:
  https://lore.kernel.org/linux-mtd/4ca13ef9-062f-4952-9588-c14f22867bf3@linaro.org/

- Progressive support for the various octal operations which can be
  supported.

---
Miquel Raynal (21):
      mtd: spinand: Use more specific naming for the reset op
      mtd: spinand: Use more specific naming for the write enable/disable op
      mtd: spinand: Use more specific naming for the read ID op
      mtd: spinand: Use more specific naming for the get/set feature ops
      mtd: spinand: Use more specific naming for the erase op
      mtd: spinand: Use more specific naming for the page read op
      mtd: spinand: Use more specific naming for the (single) read from cache ops
      mtd: spinand: Use more specific naming for the (dual output) read from cache ops
      mtd: spinand: Use more specific naming for the (dual IO) read from cache ops
      mtd: spinand: Use more specific naming for the (quad output) read from cache ops
      mtd: spinand: Use more specific naming for the (quad IO) read from cache ops
      mtd: spinand: Use more specific naming for the program execution op
      mtd: spinand: Use more specific naming for the (single) program load op
      mtd: spinand: Use more specific naming for the (quad) program load op
      mtd: spinand: winbond: Rename DTR variants
      mtd: spinand: winbond: Add support for W35N01JW in single mode
      mtd: spinand: Define octal read from cache operations
      mtd: spinand: winbond: Add octal read support
      mtd: spinand: Define octal load to cache operations
      mtd: spinand: winbond: Add octal program support
      mtd: spinand: winbond: Add support for W35N02JW and W35N02JW chips

 drivers/mtd/nand/spi/alliancememory.c |  20 +++---
 drivers/mtd/nand/spi/ato.c            |  14 ++--
 drivers/mtd/nand/spi/core.c           |  18 ++---
 drivers/mtd/nand/spi/esmt.c           |  16 ++---
 drivers/mtd/nand/spi/foresee.c        |  16 ++---
 drivers/mtd/nand/spi/gigadevice.c     |  60 ++++++++--------
 drivers/mtd/nand/spi/macronix.c       |  16 ++---
 drivers/mtd/nand/spi/micron.c         |  34 ++++-----
 drivers/mtd/nand/spi/paragon.c        |  20 +++---
 drivers/mtd/nand/spi/skyhigh.c        |  20 +++---
 drivers/mtd/nand/spi/toshiba.c        |  22 +++---
 drivers/mtd/nand/spi/winbond.c        | 128 +++++++++++++++++++++++++++-------
 drivers/mtd/nand/spi/xtx.c            |  20 +++---
 include/linux/mtd/spinand.h           | 121 ++++++++++++++++++++------------
 14 files changed, 318 insertions(+), 207 deletions(-)
---
base-commit: 342664f6de706e46a26bc906b6e4f4537ecc8a95
change-id: 20250214-winbond-6-14-rc1-octal-6f7db6be0204

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


