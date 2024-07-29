Return-Path: <linux-kernel+bounces-265900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBA893F77C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDAD1C21D97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF14C155393;
	Mon, 29 Jul 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eO+NPWXp"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C414A4F5;
	Mon, 29 Jul 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262883; cv=none; b=V4U3dEkWx9jBH+sNfK54SHQHIOGZ/jC3JtslYThuRCXmPLlcGIhzdKI0pA1oNTCXPKw3Ym8KnQ2seQRucLMQOL5JRtnjEJ24xUvES/YqlZEMmI4p3GSW1FnJkzbSXFVOSVwTBmccpmqWsuyIP7qEqXMnUqoec/9GgbKHX5Je0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262883; c=relaxed/simple;
	bh=garDM2VCcIh7nFxERMMTQlNcCfhkxCqcAVpMIfokR+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqMQofuHgxueGUYJNlPuto8b421bzZa+NrVpLBEmDsdUpy+1fwmW/VcCuXnvBkGu+TJfHdwz60pldog9mdvDfa4PkRF0S8boLmnewP3aoIl1J6xsE/betJHnZdVeKoBTwhxeRAuSQ3M9ZC/XVSz3icw7tPpZD5aqtdwwXu0LipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eO+NPWXp; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 354FF24000A;
	Mon, 29 Jul 2024 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtWIrdliZOmk8NGcbWjUR4YnnqWzac5bc0tUFTTDrBg=;
	b=eO+NPWXplKyyW0/mvVkJWrztkvt5H6enfUtcbkKdP4TUnlZ57AQndR+5lYgIv4Hw7cMtWH
	/ZMjPq92LlqpLjSHljz4Ez19jp9EvJX4+OyJwr9sFzNX+8ehtebr6Xly6RoFu0TwbEelbm
	gw0nrsKIfzF1AuSd/rdzIaABtnT+p64JpUnd7ygHnz/YHqXsQsNGaN75WZUy8vnW4S2lEM
	sJLyexpWIo7NKOCrSFJB1pv3UF28x3ZLh8JMUeNxhUKjYTOItjDfIG8KrXkeUaJZUNrOZv
	SOEt0HNGiMXrp7jihlgW2ExVOUgK20N16ktKpz2LQUHx4hjntz7UOCJqNu874g==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v1 06/36] soc: fsl: cpm1: tsa: Add missing spinlock comment
Date: Mon, 29 Jul 2024 16:20:35 +0200
Message-ID: <20240729142107.104574-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

checkpatch.pl raises the following issue
  CHECK: spinlock_t definition without comment

Add the missing comment.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 7b1032fb1572..a9d35b44489d 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -128,7 +128,7 @@ struct tsa {
 	void __iomem *si_regs;
 	void __iomem *si_ram;
 	resource_size_t si_ram_sz;
-	spinlock_t	lock;
+	spinlock_t	lock; /* Lock for read/modify/write sequence */
 	int tdms; /* TSA_TDMx ORed */
 	struct tsa_tdm tdm[2]; /* TDMa and TDMb */
 	struct tsa_serial {
-- 
2.45.0


