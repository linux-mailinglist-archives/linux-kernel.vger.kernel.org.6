Return-Path: <linux-kernel+bounces-190555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED66C8CFFC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9348287454
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8495215ECD3;
	Mon, 27 May 2024 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l/Hk6T5p"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109EF15ECCE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812203; cv=none; b=rou17U3q/Z47GdR+k53qDI4C1NIVoEl7R1ugVScL1YsEzSdQqG9kG7yGcAusBHF/wTLaWWMr0f9QbFQC3uOwvh9AVePlZ/A8xZStxGz01RkawLxrmWojPe9xtcG0bE/OtzQ3agG+O+NSd154/2nlBCrE4H8JdcD0BVjCLnaGsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812203; c=relaxed/simple;
	bh=WrYbZaaHssEZuUL36PVuCYCFrB2Zbt4e9NL0L7i0xwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUJunxEInyJA5nQ+lO3CFM/yrdaX+D3CK9tEziiFZold3LgKAMiD57AC6kf+aVforQHJDoAg/AO8Znt7aCa4y4uycX8UqLcX7iQQ/3/wn/ry1LY88/ugKgVq0i6KVqYuUZFS4YA0c2NqD1k1Dq2CcaKbiPcoEu84/H84/2c3lsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l/Hk6T5p; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA7171C0009;
	Mon, 27 May 2024 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+pTexNnoi2rCugZBXqMjjTiJGuY+cdZad02BzfGqoE=;
	b=l/Hk6T5pn2De9E6jOnwCSc6eG58e00A9vohb+VB2G1BGtcVFQ0+HbNCad2x2X1J4Z/cRpW
	g5g5rRt1jg8czZ5FElP0w57pTzVs8zZLeLzCY1t9aDAkkNBnsb4/al6ezlvICJG4injp3H
	Gfu9rpz+PC5yUB2gEJ79pbDxJzb892m4L5Cv4v4aokye/SRKsJxncTdViGf/57yNx8d3nI
	FalV7Txy+Oiyakie2P4SR7ftw3NAXvuLzS8s6gSfvJDGZNWw0EPXBYQshMJmBU/XeG7szT
	7dAvNXBhxSp0/xU8313R+PcIbETDiQI64ULXya+V6FQbZ0VtfXRU3bWexFB/mw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: cfi: Get rid of redundant 'else'
Date: Mon, 27 May 2024 14:16:38 +0200
Message-Id: <20240527121638.104039-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503184230.2927283-1-andriy.shevchenko@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5350f6ec55df381cd99db2a6bde283328fb3f75a'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-05-03 at 18:42:30 UTC, Andy Shevchenko wrote:
> In the snippets like the following
> 
> 	if (...)
> 		return / goto / break / continue ...;
> 	else
> 		...
> 
> the 'else' is redundant. Get rid of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

