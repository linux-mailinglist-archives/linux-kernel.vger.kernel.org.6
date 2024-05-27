Return-Path: <linux-kernel+bounces-190569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C394E8CFFE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661FB1F23035
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CA715F418;
	Mon, 27 May 2024 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="chXcKfC1"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880A15DBDD;
	Mon, 27 May 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812350; cv=none; b=Kg5ZekjI9QAT35i+2dAnJuhzfw65h0+UD0UGv1BqAcbbZ04/Y5YSgeaShoq9huLmZGrWh7J60yJO4s9MmBJDUFwxd9kF1Pq6vJB/DEP5q5HVX5Ig7Owq5wB7Uuy/m2SeR5A0GvtVXZUkrZT7CLGeNAhO6CZlSbeHv8t96dlITkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812350; c=relaxed/simple;
	bh=5G2XQeKlbaBhjT2RsAL0QgWuhM7y5OA4zXW32p+VlFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoA75zrBh0oyc1iTMyo7bDjsc51qzw1jvK+VidnJh+jryL5vJ1rRE7ZTqYLC/bis8fez4PjS/5pb1hA4xK5in0fQK2IZxPOtjoD4UOWWTPoR0VaxqHO+4mZLGOnwYjlKzbvOecAx78SG8VljMebooPUX2FC/Isblnc/BSQVB1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=chXcKfC1; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18FB8C0008;
	Mon, 27 May 2024 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHNpEdPAzLabYPq0SKzj1VaD6s28qVaQXn92xL+zHtk=;
	b=chXcKfC1F14nrThICBClXHAqo6TG3TKiMQu4Vp82sTG/R/e4KEhWbct2POcDlWTucShJdO
	XovJzQzhSTsGTSEKM+O6EI+9fPO0+VuYKcB3DA43S493y2Ld1bg9j6Z6utpafbIci0XAcf
	tfa2c9qewL2WHxqnCL+m+wmwKncTLjVBqIQxy9+6qvr/EQEuxbKOjdmJTF+3EbzON7wM+I
	YZ52a2NBYviI2lFZo8w7ACY4RbslMXqG6nSu0ND7p9lv8b+b5zTTg1b8Hf4ow4DHhzMPgd
	6/LFhFf9kR0C3HHBnLvZNZoef1tQOho4HWMoHIumRh1VoinHtbX+DYhJ5gSEpQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	oxffffaa@gmail.com,
	kernel@sberdevices.ru
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
Date: Mon, 27 May 2024 14:19:05 +0200
Message-Id: <20240527121905.178683-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240507230903.3399594-2-avkrasnov@salutedevices.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4e976b1521ca5e19fc2c0ba2bae0b97877ad0ef4'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-05-07 at 23:09:01 UTC, Arseniy Krasnov wrote:
> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on. Such pages are located on the chip in the
> following way (for example):
> 
> [ p0 ][ p1 ][ p2 ][ p3 ][ p4 ][ p5 ][ p6 ][ p7 ] ... [ pN ]
>   ^           ^           ^           ^
> 
> pX is page number "X". "^" means "special" page used by boot ROM - e.g.
> every 2nd page in the range of [0, 7]. Step (2 in example is set by
> 'amlogic,boot-page-step' field. Last page in range (7 in example) is
> set by 'amlogic,boot-pages' field.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

