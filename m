Return-Path: <linux-kernel+bounces-363028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278E499BD1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB32815E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 00:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884094A24;
	Mon, 14 Oct 2024 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/sQZtPj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8017F7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728866198; cv=none; b=d6jSSE+iN7occ0d3+0diBTNk5dYCyN8V/MXgTjPNN0NYSgUtNb6jhhe759oX3c4/6ZRFvtcFUeVDx0KwH55yFn6qXXwMLGecSaxpt7j4OKvPJTtLLIw2i5QXlk+GWdbGrsDwGrQ8MR8TDkUhb2z8xrV1gsg14sRXU0UCQ/9zmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728866198; c=relaxed/simple;
	bh=y297x332NU+ijg3VI5LQ7GgmCwtETBakQjxlDenyBDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqWof7YKV/UX9/d/T+hSDfus2UqhUkD1zn6EHrhT8RmfTjgefSWETfnRrON8p/jXf9oyP1U0bNSMnHt3LQiVLDYJ5BwDcawaQ5KxpWfhjsfi17g0/mlZgEdAt+6eTtDY9SA7wZ+MWzMreHLCrQZZA+8Pm6HEPcPggE/r73kHhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/sQZtPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD184C4CEC5;
	Mon, 14 Oct 2024 00:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728866197;
	bh=y297x332NU+ijg3VI5LQ7GgmCwtETBakQjxlDenyBDA=;
	h=From:To:Cc:Subject:Date:From;
	b=j/sQZtPju4+JS+kmO5Uv79kbaUvtMKAkcAVWdP6ifXeVZO5bA0gGYPKlqI11b8TJ7
	 l5TBW5Nl8XTIMv3wapDB1c3CtMVp+Yk9vnQv31WwtOpn3BjCJoHaUDqy77j8btv/7H
	 jJXm2si9xKJXopWBoJ+e+4Kj6zM/S5Hxr6DzSGBs/05tZkHHcpLjU2uk8OZo40K+AW
	 fhnglGvQnxasQC1AlWDeT4Owz1tTLZF0S4NiSJn05SZOcLrysMls0fEkKQIkgNVIjZ
	 s3dncYdrMq7N9Heoqm223IpM3JVSHXO3DkFrib8NLdX7ZKNlvjnIhLIHe77RKP50rb
	 qN12g2PBp11zA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bus: simple-pm-bus: Add CONFIG_ARM_AMBA for amba compatible of_device_id
Date: Mon, 14 Oct 2024 08:21:29 +0800
Message-ID: <20241014002129.3173-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm trying to run linux on some platforms with small size memory, so
every byte matters. The of_device_id is 196 Bytes on 32bit platforms,
add CONFIG_ARM_AMBA macro around the amba bus' of_device_id so that it
is removed if amba bus isn't used.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/bus/simple-pm-bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 50870c827889..a760500b918a 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -121,7 +121,9 @@ static const struct of_device_id simple_pm_bus_of_match[] = {
 	{ .compatible = "simple-bus",	.data = ONLY_BUS },
 	{ .compatible = "simple-mfd",	.data = ONLY_BUS },
 	{ .compatible = "isa",		.data = ONLY_BUS },
+#ifdef CONFIG_ARM_AMBA
 	{ .compatible = "arm,amba-bus",	.data = ONLY_BUS },
+#endif /* CONFIG_ARM_AMBA */
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);
-- 
2.45.2


