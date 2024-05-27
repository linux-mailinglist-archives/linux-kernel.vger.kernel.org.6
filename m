Return-Path: <linux-kernel+bounces-190554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03A8CFFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4A41C2146C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DAD15E5A8;
	Mon, 27 May 2024 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MyqNIIN/"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C63C463
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812199; cv=none; b=H3JkHqtFk2sluQX3kK2srRhOSxf678ZlcCtdoVT2KcaYKaoi2ihbAKGVp0ujqqJtof94IKvW+ADe8bXUnnk6bFb6O49wYVTzwW48XmwekFUwWwEOn8cM1adKcSIVTnSZGySXs/bxGVthLVk9waYUdep6PxQrtV/SvUvP5UwhoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812199; c=relaxed/simple;
	bh=n7tF2zLuaYtWS6W7RnvRDCZk8r4T9DId9Ls2cgNRYoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMor5LHb68O80vlCEkPr6/zT9P1IJgH2mim2S2TpvrFkrUEifZtEcN5+H3x4jjuz3Tya9q7yIdFRpXEnx13zXWq/tg6/Gb0H5AlmBGT/NAqwO/MeCPh3jfVlkme0IojRjwDKlvCrPh18TgjyZ5w+kmML0PW8Ec4OX+Bwatm1QUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MyqNIIN/; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1367FF808;
	Mon, 27 May 2024 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJ5YURNdvw7Mm1Ei1FkK4NMTuUkuMXP1FS+gaKbKcuw=;
	b=MyqNIIN/nP1ifiOMu6NmlcYAUV273gjY3dXdTWR2IfEqyCLR6AIn08vLfu8cKFpmUFtGpg
	XP5Y3qpBcoyMSla6QiUPgIrG2oKiZq3V1Tx18NrTrb3taC7WBiHEQsILZyLMWmanA9QKCW
	0Y01AwNL3Zy4a47lgevcWOh+3717WudVci7WhMMNY5H3ygQFTHCCVdEYArP8is8oVCRHW2
	KTX14ll2qzEjtOtzRl3MvQVz+kku0tvMg4RJzViYjj0qOzveJdGNYTsBCPuo3hkVIJltOx
	zx8K1My4yipHx8OCgQttkp9laQRbjAN29+fwp0AJlqEsRxn0sb9Ka2+jUw4W0g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: physmap: Use *-y instead of *-objs in Makefile
Date: Mon, 27 May 2024 14:16:35 +0200
Message-Id: <20240527121635.104011-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508151222.1443491-1-andriy.shevchenko@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'cf4ccd1c029e60bae787a9c8f75623b37ec2a558'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-05-08 at 15:11:53 UTC, Andy Shevchenko wrote:
> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

