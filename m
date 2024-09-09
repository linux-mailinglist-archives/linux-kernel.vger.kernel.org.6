Return-Path: <linux-kernel+bounces-321103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A07971486
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992B71C22F50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFC1B3748;
	Mon,  9 Sep 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RZv4hkae"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C591B3726
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875795; cv=none; b=RaT5VmLW1WRRthaZUPj3brYzl5TXEQ3qnPayzgEBgy7noyY5HU6qCFhtZZg3dYXygn72UVTsLY/0z8BvcLK1UE4Lx36Mw3iL+vQNsMlN/3OtvCsfPPu5DNwpJtP1r6w7bde7Ru3fbAAytrPzsZXPC1zTs0FWgol7iv+CMSBHE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875795; c=relaxed/simple;
	bh=ktMvSf/rAMcHD9FjPEJ+kEEbLxU8bi4snVIgxbjpmxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0X8b/loown5wE2bmAD3lh5Wa4AnmReAyYwDvWehei9X/PEsYdYBlfgk1kOfS52qAYMtJXnFKBepeHc28lMWs0r4K+XHi+ZNPvLh72Q4tEEdPJUkqhf7BmZ5LEC0ZrP2zZPrgDY3Ua3o8zNh52Ao5ZUfIUwSqRYrP+M5D+EhkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RZv4hkae; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6BFEC000B;
	Mon,  9 Sep 2024 09:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725875785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAeuadKeSyVHr07LY0GUdrdw29DCbIusjiSIYmZBONw=;
	b=RZv4hkaeubG4UehdbroKzmwajUTVf2HXwEqUnN34DFCVW7tzIao3HjC9Kv80oHBKWIz4/5
	IGD+mC5UwXLQElpEc8PyoAn3uGxvNV9/lKjcYSEEG/hSfIATAH7J8idYIgVFRgGMxvACUB
	MrQsKB8KnCsppntk2dKcb7OfYvirQ9bz4/XM9bzE8zYthOaSPijVENuYCPzPTfOC4W9hH0
	AtlMn9bguNNsG6ko8ltkfxExcnqcpzLCVvmYgJr2cYhK0CyA2GYr3s5NyUVCozZtTFIMQ/
	+2b7ZdGR4pCELPNSdE2Hs1L8yDBp9IG+qizquHZoZr244D743moipP2+56MlPw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v7 2/2] mtd: spinand: macronix: Flag parts needing explicit plane select
Date: Mon,  9 Sep 2024 11:56:23 +0200
Message-ID: <20240909095624.20668-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909092643.2434479-3-linchengming884@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'475aadeba5df687524bd9bc5c77cba44c1736e08'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-09-09 at 09:26:43 UTC, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> Macronix serial NAND flash with a two-plane structure requires
> insertion of the Plane Select bit into the column address during
> the write_to_cache operation.
> 
> Additionally, for MX35{U,F}2G14AC and MX35LF2GE4AB, insertion of
> the Plane Select bit into the column address is required during
> the read_from_cache operation.
> 
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

