Return-Path: <linux-kernel+bounces-295365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E82959A20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AE6280F33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438F31B533F;
	Wed, 21 Aug 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="qTbTlp5J"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3471B5311
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237996; cv=none; b=BW374gL3yndzK1t64HXt9xIsGjN4qLxdhY6SITTuTWz1QwxzW4RgOIex4DrMWVn0hu5W5qj+9ijZKftjzzuNa3BpwpUv4M7XvwKTMtPs/EdKnj0m5KcUDdavvnuCkHxf3ssOaVSfQ72+uKTEzvSFpMTrG8v5Kdku50iwujyD/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237996; c=relaxed/simple;
	bh=eClaG8jD82jJND52UR5S1toTYxEheg+rPjpNi0zp30k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/FCQyrGou5bl/+pmaSrwjcAsIAj6XG23rWlPapu0Dfk8PctblWX0QmBRpha0a1URE2kHEhbLWxzLlUvjgXA3NWhEuB7b+L3uCESlA19fY+NANehHWiMmWxOo+2ZX5pvwrWThGc9KDAw1t1ZUXL+KghExWuvHL7t7U20iOIzpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=qTbTlp5J; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D30F31483DF2;
	Wed, 21 Aug 2024 12:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237991; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=82Txq8wjdCnYwZ4j95zlkdbSO+k6QphWbvjQj7xx3Mw=;
	b=qTbTlp5JakJrsN0woUsh5s94nZgneFmNAoyviJMtzyfQ0lInYveVm/gdfwHGfPgESSmPYW
	Mk6ZhapHCM68T+FfA9eNyNmySbp1/6JUp4A9ugeAq5W/PTdWnQFoc1BvylP3E+nh8EwmOC
	ZzW/hf5duBG8wm2soyTi+ab8E24paU3MREzfXecY+H7wXklmCkdFlaPgz38FI4qLNsOzub
	Dmln7iBA3+5/qu7W4X6EM6ge9O4E6p403K6PpmyNX4kpk1FdHQH2r7wWkqC/+FaLUcqg7+
	mIjeKBJcujk2+BGLeuZdrBGxlvV5c9joAOCYkiJbXcf+Qk98aPqTe5FbGGxR8A==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP OTPC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 02/12] nvmem: microchip-otpc: Fix swapped 'sleep' and 'timeout' parameters
Date: Wed, 21 Aug 2024 12:59:33 +0200
Message-Id: <20240821105943.230281-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Makes no sense to have a timeout shorter than the sleep time, it would
run into timeout right after the first sleep already.
While at it, use a more specific macro instead of the generic one, which
does exactly the same, but needs less parameters.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/nvmem/microchip-otpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index 03e60b99f2c9..bd3383eabdf6 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -87,8 +87,8 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
 	writel_relaxed(tmp, otpc->base + MCHP_OTPC_CR);
 
 	/* Wait for packet to be transferred into temporary buffers. */
-	return read_poll_timeout(readl_relaxed, tmp, !(tmp & MCHP_OTPC_SR_READ),
-				 10000, 2000, false, otpc->base + MCHP_OTPC_SR);
+	return readl_relaxed_poll_timeout(otpc->base + MCHP_OTPC_SR, tmp,
+					  !(tmp & MCHP_OTPC_SR_READ), 2000, 10000);
 }
 
 /*
-- 
2.39.2


