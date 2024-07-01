Return-Path: <linux-kernel+bounces-236198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015CA91DEA7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1E51F23F2A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D1155335;
	Mon,  1 Jul 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AxdWh2iP"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F34152500
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835233; cv=none; b=lVRMShBrKVmAQiEUKJzgC/UsPyVULENSbaItLouiAAebH136hvgr/wM4cgvlLwJOjdUb1zOrgtT+pLu9/dNRPBl4M19XTBu8qI30UIl5qQ0tyetFQCKzasBrnm3sZgk7Rf0LcKaFYlLRm7Qhyeo2LkY0DL2w/gWA9k7VnFOPGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835233; c=relaxed/simple;
	bh=5tWNzcLQ6GEUa/V0DYFPIm2I6atDIjegPMLNE71Ue3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZ4myNzYCsLT4huAL6cgg/6kf1Uq+qksa2vqJatsmADjDbDnq3mSad0ZrGS1TF+LrcQKVAYqgm2sPz+8ocq8G6HMc+JNdyCUm23X1DtqQgCIodS3iuCxIoh4TfpGfucsvoC7S8IWO6e48xFphFxEMWugMqxJ5uPOmqppfOHUlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AxdWh2iP; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C068CC0007;
	Mon,  1 Jul 2024 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719835230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mMFdDlVb8tiUU5WEmsBNo9BoejZis2bqk/srViz/iU=;
	b=AxdWh2iPt5xV83865WrQsdKKsm33cg8tiIZCQRdI0G/urVsuKUyuxPGfkCZyLi9VfYMhN9
	Mv/LpkDuIXI4FvUIdFlKpY7abT98KSQvkNeaBhStjHcMnyvX2XCflRrY92p/9t85UrMlth
	YdQWL0Bx43mL4w+D/hXQPb008V4VQHNJQi/rHktDbJgSQ+fYG2YIzLAkWNiMbh+fuKwuwo
	zZzy7GYtbty+Zw//kx1ME8KW3imMOnaHAoqu3+qwtDnL41tNvpq8sDWAfneotFVcNxWwUF
	/cFTAQgSVFyU3deqh5S5RxxkmaSAPJAK1JzwYH1KSC17v7or6cpdIHv90UGk9g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/2] mtd: nand: mxc_nand: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  1 Jul 2024 14:00:29 +0200
Message-Id: <20240701120029.525541-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240604212919.5038-5-wsa+renesas@sang-engineering.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'73c6e7963ee8b835c5f267222ec011510be2b630'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-06-04 at 21:29:20 UTC, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

