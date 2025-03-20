Return-Path: <linux-kernel+bounces-569202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE94A69FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC53461B30
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30DF1EA7DE;
	Thu, 20 Mar 2025 06:40:24 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67321E412A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452824; cv=none; b=rJBWewXjSroXJugFt14nHuQ0iUKrpDr07R1/LNGFoU/U7Be3+2dC7Kwhxv/rl32z77Bc6PF8Ovzqx0cb5XyhWlB6/LAMjRaW/1kc0ubbFLwXxr0PoJKBcuzAeib0TTdRddLNGIC46rrwJVZGlrqdC60YBBnKYqp5oCY8vnbQzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452824; c=relaxed/simple;
	bh=cMwdsmwGiCyScaGzBB3hUxyKAKbVEkB62bzE7ZxgtX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZT+583PRleG2/aXncEKYqje39h71HZrZJK8APYnK0Ogl6sKrS8LAMwtFdOblqpb/VPPonTyzA12atFlcZ3fBxu8W3Xs3REt2JH9Uv6ZbmjgiC7Uez7V4/TjayJytMNoqJCpY4iZzdVwVU/pLhsmr25jtbWwUNoaqoWMfayPUNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAD33TBIuNtn1PPhFg--.14774S2;
	Thu, 20 Mar 2025 14:40:08 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: linux@dominikbrodowski.net,
	tony@atomide.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] pcmcia: omap: Add missing check for platform_get_resource
Date: Thu, 20 Mar 2025 14:39:56 +0800
Message-Id: <20250320063956.211577-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD33TBIuNtn1PPhFg--.14774S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF45Jw43CF4UCFWDKFy7Awb_yoW3JFc_Gw
	4vgr1xGr45Zryqkw43A3Z3uFy2yF1q9a1DWr1rtaySv3y7u3Wj9ryv9r93Wws29ryUKF9r
	Jryjyr4fuw13CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfU8nYwUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add missing check for platform_get_resource() and return error if it fails
to catch the error.

Fixes: d87d44f7ab35 ("ARM: omap1: move CF chipselect setup to board file")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/pcmcia/omap_cf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index f0ccf479f36e..e0a3820acaef 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -215,6 +215,8 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 
 	cf = kzalloc(sizeof *cf, GFP_KERNEL);
 	if (!cf)
-- 
2.25.1


