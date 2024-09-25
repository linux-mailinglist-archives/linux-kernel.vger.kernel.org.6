Return-Path: <linux-kernel+bounces-339387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C527498645D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82996288176
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668C208CA;
	Wed, 25 Sep 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Hfvng506"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F342F5B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280049; cv=none; b=SX6KmbtMKP17AbtFRb4CS1PGpfxx1Z372H+fvafEfZnal5FpKAPch9QqXe2JqADyOkneazuCaie/rFPmZ0+rnImXWLt4BlA4XS63bvBbxoTHa8jNU8k9IFU/lUW0kIlkIQmyd1RZAgOA/JgkgNdV0lkU/zzFuoHbuvYDJt7KvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280049; c=relaxed/simple;
	bh=S7be5KN6UGGOf23Jltm5kL5ASOA+5n5j6TpUb0Rh4r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/aK7VFSssCuaempgGIvZF30Q9x4PrrUQXH0nJ9BlNW3w/2FqoPkrP6EKmuSF8KueCfLfq9lEENZeKOmm73vzAN+o0s/LAF7fxm0ety6cwZvJX1P+VP72foSxrhuNZwcR3bv5JHNA5Hs3vWJ3GzpIji6muaI8Zc70hgiBRtIS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Hfvng506; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 09F0087E30;
	Wed, 25 Sep 2024 18:00:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727280045;
	bh=WqvSyAtJdJLkJyg1eGohRVV8HBMvuaIpHViAOX2Hufw=;
	h=From:To:Cc:Subject:Date:From;
	b=Hfvng506APnt/IorzQSrKlFLcsd64/VsJJM3/jfX0X4g80/84RglqnGwzbIbymsCJ
	 u2EVkWyKPGSqxobu64fK8kJkDU8DCKij9yYJevrCmmKZw3HnRqEhjygXMynQrLiIdt
	 uOlwcDW8R7aFdLa5pMzyIJaKI48eL7YlqXdmNBu/rkxhClvh7+f2hfJHCiYnRocN1+
	 GuusVY/PuqJsXJew40jhTa9oZMqqW6xXMhG0EzWfHvczTWSRbxfUPCiBxIb+R+DzRL
	 CUjfQ12Yfn3gdK4WC/uATT8p1EDxNld9vDltruyK/b44xNXLvHEfGzhQuYRdasWa3p
	 0DzHyyCZhOHRQ==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@dh-electronics.com,
	Marek Vasut <marex@denx.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Saravana Kannan <saravanak@google.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx8m: Probe the SoC driver late
Date: Wed, 25 Sep 2024 18:00:11 +0200
Message-ID: <20240925160026.84091-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

With driver_async_probe=* on kernel command line, the following trace is
produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
driver is not yet probed. This was not detected during regular testing
without driver_async_probe.

Attempt to fix it by probing the SoC driver late, but I don't think that
is the correct approach here.

"
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at drivers/soc/imx/soc-imx8m.c:115 imx8mm_soc_revision+0xdc/0x180
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-next-20240924-00002-g2062bb554dea #603
Hardware name: DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3) (DT)
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : imx8mm_soc_revision+0xdc/0x180
lr : imx8mm_soc_revision+0xd0/0x180
sp : ffff8000821fbcc0
x29: ffff8000821fbce0 x28: 0000000000000000 x27: ffff800081810120
x26: ffff8000818a9970 x25: 0000000000000006 x24: 0000000000824311
x23: ffff8000817f42c8 x22: ffff0000df8be210 x21: fffffffffffffdfb
x20: ffff800082780000 x19: 0000000000000001 x18: ffffffffffffffff
x17: ffff800081fff418 x16: ffff8000823e1000 x15: ffff0000c03b65e8
x14: ffff0000c00051b0 x13: ffff800082790000 x12: 0000000000000801
x11: ffff80008278ffff x10: ffff80008209d3a6 x9 : ffff80008062e95c
x8 : ffff8000821fb9a0 x7 : 0000000000000000 x6 : 00000000000080e3
x5 : ffff0000df8c03d8 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : fffffffffffffdfb x0 : fffffffffffffdfb
Call trace:
 imx8mm_soc_revision+0xdc/0x180
 imx8_soc_init+0xb0/0x1e0
 do_one_initcall+0x94/0x1a8
 kernel_init_freeable+0x240/0x2a8
 kernel_init+0x28/0x140
 ret_from_fork+0x10/0x20
---[ end trace 0000000000000000 ]---
SoC: i.MX8MP revision 1.1
"

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/soc/imx/soc-imx8m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index fe111bae38c8e..04d6ab1073b25 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -251,6 +251,6 @@ static int __init imx8_soc_init(void)
 	kfree(soc_dev_attr);
 	return ret;
 }
-device_initcall(imx8_soc_init);
+late_initcall(imx8_soc_init);
 MODULE_DESCRIPTION("NXP i.MX8M SoC driver");
 MODULE_LICENSE("GPL");
-- 
2.45.2


