Return-Path: <linux-kernel+bounces-374049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753789A6121
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DF9284C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870A51E7C39;
	Mon, 21 Oct 2024 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GycgOCIf"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1381E7C17
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504972; cv=none; b=uiYVDKKzFQgPuP8cjLgCUIqDsek2HjTXIkj232Yc7jONr3/mxa2dB+L9x0EdxBAyX1wTzqsvAhgiXHZALT06hMid7mcraDnhuQlw67sW9EOTXdTXUF/169subQeGa45LvBOAl9K5czh3DdY2n2x8pbaq5X7YStjkHCWVpW0ZYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504972; c=relaxed/simple;
	bh=To/ZcUc1dFuXwLDRsWjO+cyROiFSiziGui75p2f43k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9sNnnYu3623NalSye9dClHkkClKsiRMPt3uhbATicQMPEDQaIokQVKwIzVChE5f0nL+Kdj0rSp3qMfXB6LUKS7/fwU0OdhNUSOrVJytPvskhAw9HzjqD4UeFHyaCHEHm/94lYIINaNlVEvIcVz6S/GfpgDjCwbVW6s0ZHEQgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GycgOCIf; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D187E2000A;
	Mon, 21 Oct 2024 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QciFo5dHP82ddOCHWNzJYcO3C8zVXIkPV5OK4TqBMaU=;
	b=GycgOCIfxCXrcQXTiVuFoR0fYyM4MyIRHEAwnywG9UMcbbzK+adWXKp+REYp6goMRx2luM
	uNWaWYePYAb8LqyAd19A0Kl6vcsENb8tyAFtrcdf14h9jxZWN+TiZJBG6/r3Dxr/6aBgz0
	vmPpbsUR8qZDuIkqqCjuX+OydYlFOtErGI1ijybsVi3AcCbTMFOXMQzXr+bVwsTogsKh/h
	Vco6JYUwG2LqQrLs5Ipmp9Y4V46bb9OciB37NB+YPmx2PFys0u8e1c/EO5MH1TIpSRBmHH
	sLqmkvu+S+3cx6fY5Se4boclvkPDrtJBo5AwIZCQLbh4QbHVtHHu+gCiYxGzKg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/3] mtd: rawnand: davinci: break the line correctly
Date: Mon, 21 Oct 2024 12:02:48 +0200
Message-ID: <20241021100248.173452-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007122350.75285-2-brgl@bgdev.pl>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ded621161b02a7dbee39e82863334301ffd731e5'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-10-07 at 12:23:49 UTC, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The line in nand_davinci_get_pdata() prototype is broken in a weird and
> unreadable way. Make it consistent with the rest of the code.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

