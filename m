Return-Path: <linux-kernel+bounces-374046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93239A6116
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA95D1C2243E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D611E766D;
	Mon, 21 Oct 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nVvlQPAU"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8051E5716
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504965; cv=none; b=RMV2FnAh/6r+Yp+ZiGT/ifsHrLA0NIxEHTnmdSDy0/OJGw7uCe4Rglkccd3czyMT7e1WoyLeak4rLh2m5CCWOd1xfC8EsKZyr2YPHuGyYL52BJ7hNBfiD1hWGJticKaoLAkmZ+Gyb1zjQ7ZbuPqny9qsP3nOka5aQWlU7b1fXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504965; c=relaxed/simple;
	bh=QnO/pGqKy+SdwSwusnNzSGBFs6gdUebQGQ7JLaPxkjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJdwdc0FrfuX/lW0pC8OVjA9CRtiSWGE97V6fAkjW+kM+u0WoatKC3N+Ztd4qHs8kqnjRhvKNxc3pMjmPUaQtl/k4+q5wDKNIGRPSuqycnAfFFee3mupHVhfxDJm55RbGqTejaDeaoNSucMrAr0dNpla9gSadL+kV5ftFpB67Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nVvlQPAU; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50C56FF813;
	Mon, 21 Oct 2024 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jt4ag5MKyMd3xgYncsPFdm31U3M1z0irrsL8f/DQljI=;
	b=nVvlQPAUCCdLBIJWZ9hiWMraywkcDWO2Y0kLB4GGWQQOQXTL1UpZkZfS8JHZlYodhZsAMc
	JELm0CH5+uoebbZPgy1ktk7KdfNUXJVXghPoApSp4QoK+5MTim2ezKjS5BrYcYn8wLpwOS
	TOR+J0o0U0y5dhW8tgC+t9RcPoE2K9lMm6YoRLhkMyaV1f01gh3hpWsGSte+AnBWuMZ0X8
	kT4ZeiJSHGaApwvItirBExtns+esL2I/wqjNI9oTPmj+XY99eXoZUF0bvuuc7PrAzWDrsA
	yLT0+r8CL9HW2o9giaap/EcQ9zNFnkIW5eUI18ltuGaqbRebgLkBOMSoM2aTlA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mtd: nand: raw: gpmi: switch to SYSTEM_SLEEP_PM_OPS
Date: Mon, 21 Oct 2024 12:02:40 +0200
Message-ID: <20241021100240.173393-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007191319.220775-1-han.xu@nxp.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bc1bd939c4caa57a421c8cf3492140e2820a4860'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-10-07 at 19:13:18 UTC, Han Xu wrote:
> Replace the SET_SYSTEM_SLEEP_PM_OPS with modern SYSTEM_SLEEP_PM_OPS
> alternatives.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

