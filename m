Return-Path: <linux-kernel+bounces-391222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1639B83FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D7B283B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D98C1CCB26;
	Thu, 31 Oct 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="H/6E6Sg+"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846391C7B62
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405044; cv=none; b=sUTXakyH71pdFhSmUpQgDBZD8/QEgGEweZtNooO/aVEdOvuEkkvzgKlUZE88/Iyd3e2k9p3WUMyRVmKAFevxGXkT3coTJyXL6pzfN+uDH993/ZWZJWPvnCaOQ+0jP7WSsv0EKL+nyXmH3Tr5C9wvVjBarlstBSn5amDh79wjml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405044; c=relaxed/simple;
	bh=JSEvZwWjK1/LoQ0uFWLyo74GABdj9hbu1mVQ26RoJ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKTbFld+EU99PuObohgFfbcK5j1qYFkj++syUdAz+IjAN0z/5++WtT241aDNwt2th/y7hzBQZYNMnn404IzOhIVm/is2zTWkqJaD3ZYG6yu0MV15Rc9vUePyo8pxOR8OaSGKiHzetn9FnKjzW8YuQuvJ4uzPrPWoBH3r+wGJ0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=H/6E6Sg+; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 627CA2C0525;
	Fri,  1 Nov 2024 09:03:53 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730405033;
	bh=8ni5QRUCD5VvO4J50KmFVZvZeIdbtTq4nskuSxlH7vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/6E6Sg+8w5UA0ewmPQBlddL49LFu929V47Q89AAiGRRv2mQ/kCe8+Jum9ZoaAbEh
	 d2ZkSlUfLxhelXB7P64x4NtjURJdgYu4pIW2PUeF7bG8CyBfSsepxg+llQM/jV+8Cd
	 dFs7VxoYNduLp20Lylz+wAOalXH7QUsgkTzVncAcAXT2klBSfKxIfH6SObsOFaOZ8D
	 3htpMfPI0JyRR2BK+wyqY4kfcfZ/qIWo0dc3TlAgVVyo9x5eQVr66VegYrOAqd0YpR
	 yNh3DirSiJmVX4I81cqbJMhnvZkpdd9Xjp4r1HYoRQEHGw3G33QmC5qy2AyLU3zfme
	 xVNA00BEnyu9A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6723e2a80002>; Fri, 01 Nov 2024 09:03:52 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id D6D1413EE83;
	Fri,  1 Nov 2024 09:03:52 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id D1A5A2809DD; Fri,  1 Nov 2024 09:03:52 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	sre@kernel.org,
	tsbogend@alpha.franken.de
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 2/7] power: reset: syscon-reboot: Accept reg property
Date: Fri,  1 Nov 2024 09:03:45 +1300
Message-ID: <20241031200350.274945-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031200350.274945-1-chris.packham@alliedtelesis.co.nz>
References: <20241031200350.274945-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=6723e2a8 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=KKAkSRfTAAAA:8 a=GF1LeCK7rlvhbTvQy6cA:9 a=3ZKOabzyN94A:10 a=cvBusfyB2V15izCimMoJ:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

For historical reasons syscon-reboot has used an 'offset' property. As a
child on a MMIO bus having a 'reg' property is more appropriate. Accept
'reg' as an alternative to 'offset'.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    Changes in v8:
    - None. This has been applied to by Sebastian, I've just kept it in t=
he
      series so that others can see the complete picture
    Changes in v7:
    - None. This has been applied to by Sebastian, I've just kept it in t=
he
      series so that others can see the complete picture
    Changes in v6:
    - Add r-by from Krzysztof
    Changes in v5:
    - New, making the driver accept the updated binding

 drivers/power/reset/syscon-reboot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/sy=
scon-reboot.c
index 4d622c19bc48..d623d77e657e 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -61,7 +61,8 @@ static int syscon_reboot_probe(struct platform_device *=
pdev)
 		priority =3D 192;
=20
 	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
-		return -EINVAL;
+		if (of_property_read_u32(pdev->dev.of_node, "reg", &ctx->offset))
+			return -EINVAL;
=20
 	value_err =3D of_property_read_u32(pdev->dev.of_node, "value", &ctx->va=
lue);
 	mask_err =3D of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask=
);
--=20
2.47.0


