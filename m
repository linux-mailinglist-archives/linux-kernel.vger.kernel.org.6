Return-Path: <linux-kernel+bounces-518634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7888A39265
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB9716189F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF91B0409;
	Tue, 18 Feb 2025 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="J6cOA2Tu"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06A1AC882
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739855245; cv=none; b=l25QXwP/VvpDfBLBb6hrIURUIg++Spit/2fZhwrlaQOYJ6xElb+Z1RXrRrEfIf/xS+tLhn3xspChj4nA0CHpk3XsSpArq26lrTK0/l8wL+heKFLxRJlZZxsgVaxtpT+RI/VWKWUcv46QtrocdoHuZ3XpeEQJG0nGO5TPaEZMjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739855245; c=relaxed/simple;
	bh=LtiaEOZsgDZuuU2n1MkfkwAUkhX7jYfHI2FIWQVUesU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAc0fL3lr7Kc8EOvmTLGQRe9LFCIdmC8Z3fESES1YgvCym3Nr6Y3vqT8cwRUPc6++xgFkOKbRIe9txhVSZEOpux+VZODwXWgYrp3rMLjlmhSVDxQvav4TCJlRitq6KhVCoKuKk5dg9yo6rGMl+QKdOB09lnvP2pfyMGkZ5cOF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=J6cOA2Tu; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739855206;
	bh=1vAKLqNsFIt3VZbfHz9u4YiCFpGxegS27zz7OL5Y9aM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=J6cOA2Tu8vxctfFoA8B/lAkurBouTb6Q4vmgM3J+ga45WuvwUc06A6UOAoc8LU2RS
	 Mg0rBurU3OIFpmxDtJTLP5R1jwaoWMNiS1i8Q8jgpQta0MYIPKCsPkv38gv0xXLI1F
	 svFu9C9Lfk0aj1QeJg51miANkBwnfb4jTzM6huGQ=
X-QQ-mid: bizesmtpip4t1739855161tcklbz7
X-QQ-Originating-IP: NSxoZGYJy3N0XkREdeX3sustINZnXeAPkIi71wc7HD0=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 13:05:59 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16173264948170778916
From: WangYuli <wangyuli@uniontech.com>
To: sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org,
	mayulong1@huawei.com,
	mchehab+huawei@kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	chenlinxuan@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] spmi: Only use Hikey 970 SPMI controller driver when ARM64
Date: Tue, 18 Feb 2025 13:05:52 +0800
Message-ID: <23BAA675A75EF4F5+20250218050552.57711-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ODAIZU/2rwU14P2aWaeUvgb0L04r4OTeUokhlejl03d6KnBSjIL5NdoI
	yyjkHAfIe6HBPZZAgDUl09hVfxH5mr3ejuwhr3rwU/Wh9CPGjgEXJNtW8GIEQk9Iy7lVxw3
	nVtRAibG9dlYfcF8w5abvh8me6yQghYgLdXJlyRtq2K2maY0ZbzoRzZa+kYKJr6xZMHLiUs
	jUAR3S95sqDKw5dwkGN58CLX8EVOvqCFr17lXGl6f7HR1Ysx4Q7vhPpConwuiViFy9KIYfZ
	O4Djn71XnSJcAFWDT5B6gWAfBxP1PrMLesf8THFFqmMRPrWtW2I+qJs9+/ROYCdCTkKrpD7
	dZDiRScARqenIMNzH4W4xan389NXkufFCUzAmDRQqSkzfm/uAdoT/HyKMr/ujKWPIhWuSB4
	jbRRd8IFHZHjGKYJydzSY5eO4yMGvJuQtv06YaAtFq2K5XgMLJZ9ZdKsbNdJpv1qjgiv5O5
	fFhKAGDNBdQR4p0dB/NQ5jxvtexXWKTdjRwPT2nxhq6KHCBlJn7LAVno00FAJuxGOMwxBsM
	j6XRSWvEExYjQFSh/aJj+SICfNY7lNhXlzow0pTzdqtiLePbfRYHfHaLBqu+JqYuZGwSrxB
	8pVTgwIm48U4+O++KQH8HKRxe64NlIFGdJihPD/tCCER9soAjevBU8KLLjTh8nBSvqJNPJs
	fNJ/5SyUX5SM2e9zxzloWdZep3DN/Y77/AOPlobwwtKMtvnVJr71cQOa+6p6Kd7bY0tp05j
	kz73JhWypKZR9/VR6ZYTt+N8bJibue+KyBzEBiL2fxDbtIwjKtcz6UBCGsQNlB6Z0Mfc4uV
	byESKKZCHHbmyW+TFHux3kv7cRqhHZa03yutTrYuOUcxzLIV1d3Pqqf89smybdBLs/LFwhC
	vYH6PcJfOfgEOp5mfvuj9Gsl0yb5Sw3ElSJTNSYunqMhzVc98mChA8ti5kZxApcWlgEq3l9
	EF8hRiH0Z5eO4yDMQpDKpAoTz/Z2nLnwS1XlWQEOnt6wSHD1fpX7GPHktni/+KQi/ELk/rg
	lENKK3VpzAg9ACpJ99Vt6Yl7cKvH1dSMmW755Fnbfc5R6JjoB3QGKiaQqBXmFwtWZYx/MLn
	g==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

SPMI_HISI3670, the Hikey 970 SPMI controller driver, is only
required to use the Kirin 970 SPMI bus.

And the Kirin 970 is an ARM64-based SoC, it cannot be used on
platforms of other architectures.

Link: https://lore.kernel.org/all/b4810f476e41e7de4efdf28b42472ae4ffe7defe.1597647359.git.mchehab+huawei@kernel.org/
Reported-by: Wentao Guan <guanwentao@uniontech.com>
Closes: https://github.com/deepin-community/kernel/pull/604
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/spmi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index 737802046314..4ee496491c74 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -14,6 +14,7 @@ if SPMI
 config SPMI_HISI3670
 	tristate "Hisilicon 3670 SPMI Controller"
 	select IRQ_DOMAIN_HIERARCHY
+	depends on ARM64 || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.45.2


