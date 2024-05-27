Return-Path: <linux-kernel+bounces-190563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631058CFFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155F71F20D47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8715E5B6;
	Mon, 27 May 2024 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jIRoTlyi"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3102215ECF2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812331; cv=none; b=fIFELe3jcrKhqY3CNgCuihTZZ1NX/bzNfPMT3LtpcNq7u/KDt3V3pTX/mIAXM3BzHCzfcqzB9vS/5q8kfdCBhbcIqp0ta/kvudLNG15YnIw6p0OqAFCI31icsbNbU3cH89mEkPfX+m9tALou9pKlxvJv4L9m9jltf4rpq4RyJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812331; c=relaxed/simple;
	bh=XPK8JUkDJMDNrRNK5OlDLRX+GPu7Xb98GLwLx3Ezoxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FiqNmDbrSfXvmC7JIYy2t1j4kbCXC1jPq1o3tjNjwUeDWHNOR0YIOqmNcOqNl7VZcJAHFQObGwYi4ZIS8i7fH22uOPgl/YaWZXBLyQ1Gwm9CoZgu39d8Ot/BAuTcYTCQZ3RaqqvWWrtB0GHC18kf9HNLj3lNoB6ojItB1XfLzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jIRoTlyi; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6786660005;
	Mon, 27 May 2024 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljXnv7jIfAdkaMgii6nM8Jjri0Nf4oqo8tMGW+JTGks=;
	b=jIRoTlyiSA07+Vzq380JmPd+BHDvOla9auFJBFUstlmkOrMZOTsWI6MK6qotkJO2Zi4DCW
	YXwophTwacmZVPgdYgIbO1/pY1nma7C1d0PArSNDr347jKFJII16HlyvtnOmJJIzhqtIVq
	rsqbdJ/KRQY4XvcWq4xzzycN6uq7GsEin+gmPj9YDEEtHnm0HkH30Abya7dRcOweaPd8vk
	b+VSvJDvw84t8GXyQ3SxjTQn5M8HPqZop1hm5IiaY7zXAreg2m787UlfSpvXAPmjFc5+qz
	qa37sHX28v7Kz3qUqIBVY0K7yAWLw17NoZ4pdydkpDkyL4uUCnQjY+zuF9WnGg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mtd: nand: mxc_nand: support software ECC
Date: Mon, 27 May 2024 14:18:48 +0200
Message-Id: <20240527121848.178542-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To:  <20240522-mtd-nand-mxc-nand-exec-op-v4-3-75b611e0ac44@pengutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2ba9d29c44cc046b46c275d654fa946a0781a540'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-05-22 at 05:39:53 UTC, Sascha Hauer wrote:
> With these changes the driver can be used with software BCH ECC which
> is useful for NAND chips that require a stronger ECC than the i.MX
> hardware supports.
> 
> The controller normally interleaves user data with OOB data when
> accessing the NAND chip. With Software BCH ECC we write the data
> to the NAND in a way that the raw data on the NAND chip matches the
> way the NAND layer sees it. This way commands like NAND_CMD_RNDOUT
> work as expected.
> 
> This was tested on i.MX27 but should work on the other SoCs supported
> by this driver as well.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

