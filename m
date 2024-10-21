Return-Path: <linux-kernel+bounces-374045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E11F9A6109
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24B61F23C55
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649441E6325;
	Mon, 21 Oct 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pjbCMal6"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90001E47A1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504961; cv=none; b=bLtKtRvLg+cMGS0omk3GGGUNVSNpk4MLOQeSjl5l9LvvcTe6T67xclxanwg8E1Y+HrGBaHZGjCWi5wssn5ZXhC67fyOBLiq5Vwqalbyb0YsF7J9NdA+hf3V8t7Wq2eOw4ovD66zPqgP5KBEEMQhfvWrxU6mU7Xof6UtesE6PqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504961; c=relaxed/simple;
	bh=v0O+l1rFjh1equUPt12VbWAsZO1OqHCsCI/nYA/Yy5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7Q/X7ipeThgEpbpcrLjwFJMAdgG/df2mEar74Ch2+ORzxZvfvNjTUIMml/k67/FObVYGdM2+wxDhptjg7pwtk9hZGJ75qX/OpBofNDl2fzXBEnkL7vjFwoBxxt4yP0n+QkowfQKeIYzcJjKrT4GDLWRUmutVZYCbZMJiLQOMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pjbCMal6; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CBD01C0002;
	Mon, 21 Oct 2024 10:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KmJDdtwu7yFlMx6CxV7xwkga/0e7ocqt3YdcjbK1Rg=;
	b=pjbCMal61lX5svKMpZO0z6ApOb2Dw/2/bVvRRRpuArn1BJGFNb4GvBmVFvIlL6tx/zyH3j
	lCGj7EB33NNkVRnZ9WU6jM7BPKmphjSncIFAyNkKmIkojgjB/vHk43tVRX/8+9gc5NFmH9
	sMYr1TP7vP1i2Lu6Nr4EEHafifQ8TR806pVg/guHDipGI/n5Fy62deuerNO0rPVOOnlkxk
	ghOgwO6GfNqsxmOV5MnCbLau/Nd7kny9IslI55ISfFnRzrfX7ELOEbLCVt2kWgxjhyPjfl
	wt+Neug7+XuvJqV7VVV41Vj7bmQyYQjQ3A4BQ2inCGFRIg6TUzFwWmszptxOTw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mtd: nand: raw: gpmi: improve power management handling
Date: Mon, 21 Oct 2024 12:02:36 +0200
Message-ID: <20241021100236.173365-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007191319.220775-2-han.xu@nxp.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f04ced6d545e20b3579c575b0afdbd7054db2543'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-10-07 at 19:13:19 UTC, Han Xu wrote:
> Refactor the power management handling in the gpmi nand driver. Remove
> redundant pm_runtime calls in the driver probe function. Handle the pad
> control and use the leverage runtime suspend and resume calls to take
> care of clocks in system suspend and resume functions.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

