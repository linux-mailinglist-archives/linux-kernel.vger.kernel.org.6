Return-Path: <linux-kernel+bounces-199187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B08D8386
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181221C23F20
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65F612CD89;
	Mon,  3 Jun 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="MxJSGwRr"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC812C7FB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420174; cv=none; b=FfysWuR0X8gXnU/tw+jcDWJbrPjiE6obeg5rNYZlnaZZtXlT0J5bFcj5NDQHBwl963qVPkqrUpF5NaPb9MvtjoxSVyUQRHXHY8/WBZ5hYVGrs9GHD8DyzHGvOWuNsqSC++f3Zwiq4d8mksuqO1iYQMfHc2NCkpxEaKqcKqdaxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420174; c=relaxed/simple;
	bh=gbet9ula8hiXQ5Q+WCGU8KzDeDurJoyPHFLzhk0cMyY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kWT+cPQl6552XJ2+Ir2sumsrkh4Y/BlJD7GybY8/ipvCFtOinpgJ1JMuI/oCmbiMOjBUy1YXSdQRnPDbZtE1lZcLKeowExtWLxdA+ewqgfWYXn2t3PD1KIrqd6KzUE+iOsm+wc5SHpiigDVbXIT4CBidFUaiE02P0gO3s5omj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=MxJSGwRr; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=saSbscj/lc1Vh8GhjtWmIhA6ffszYypeEA6Stg616AQ=; b=Mx
	JSGwRrsT3NgBJIPap+/fef/f5y07gyzhFnPorvucFoDsLB8JTUxbN7DTTDd1jJNdfOxIbHhfIl8p6
	BPFvUZG1lT9A4zWgQpNYWs9BLnnvQS4eXmagdxb6t4KfiqgLbr09mD9zoQ5wVdn8wXAJ2E7b8kqNL
	0Gmdo1QsVl4FtTTIg0qPCMDQuE11SX3DCXnDIAVcumj0n8OcPvR11Cxx+FjW1JppgtVVjDQpOMSn+
	63ynxg8fcvsaVCV7PugzJ5dXZGTOVQt0nrDoTAcsvA5hj2dAvbQ1YvmMOqKHJpSQvWfpqHG1dJkvv
	LXEawy3omWF0FCYounOSHHpFDv0WX+Lw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sE7RF-000Jpp-W5; Mon, 03 Jun 2024 15:09:22 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sE7RC-000O6H-0c;
	Mon, 03 Jun 2024 15:09:21 +0200
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v2 0/2] mtd: spi-nor: macronix: workaround for device id
 re-use
Date: Mon, 03 Jun 2024 15:09:14 +0200
Message-Id: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHrAXWYC/42NQQ6CMBBFr0Jm7Rg6UEFW3sOwqHSASYSSVgmG9
 O5WTuDy/f/z/g6BvXCAJtvB8ypB3JyAThl0o5kHRrGJgXIqc00lTqbzbpYNp430s6BcW+xley8
 B65r4Ssy2shUkweI5NYf83iYeJbyc/xxfq/qlf2lXhQqZlSbWF9M/itvAJk3PnZugjTF+AV0U+
 PXFAAAA
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717420161; l=1472;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=gbet9ula8hiXQ5Q+WCGU8KzDeDurJoyPHFLzhk0cMyY=;
 b=y5ijGA8XqkpyiBGBumNuknoDSMA7jQBonPKQG1Q6NrxAUfdOM7n6kRYO48IQO1A0a2f4gyVDB
 7Tm6TlO2DMqDpGtihS6mUUl88/ZwKoWZVDvAki7HLnhJlCQfoiNhsVx
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27295/Mon Jun  3 10:28:26 2024)

I only have access to boards with MX25L3233F flashes, so haven't been
able to test the backwards compatibility. If anybody has boards with
MX25L3205D and/or MX25L3206E, please help test this patch. Keep an eye
for read performance regression.

It is worth nothing that both MX25L3205D and MX25L3206E are
end-of-life, and is unavailable from Macronix, so any new boards
featuring a Macronix flash with this ID will likely be using
MX25L3233F.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v2:
- Added new flag (SPI_NOR_TRY_SFDP) to spi-nor core to allow trying
  SFDP and fallback to legacy parameters without having to specify
  DUAL/QUAD parameters.
- Rewrite macronix to use SPI_NOR_TRY_SFDP flag.
- Use with the ancient EoL MX25L3205D chip will not get speed
  increase, but stay at 1-bit mode as it is now.
- Link to v1: https://lore.kernel.org/r/20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com

---
Esben Haabendal (2):
      mtd: spi-nor: core: add flag for doing optional SFDP
      mtd: spi-nor: macronix: enable quad/dual speed for mx25l3205d chips

 drivers/mtd/spi-nor/core.c     | 3 ++-
 drivers/mtd/spi-nor/core.h     | 1 +
 drivers/mtd/spi-nor/macronix.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240524-macronix-mx25l3205d-fixups-882e92eed7d7

Best regards,
-- 
Esben Haabendal <esben@geanix.com>


