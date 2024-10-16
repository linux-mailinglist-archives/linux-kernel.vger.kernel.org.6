Return-Path: <linux-kernel+bounces-368309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90349A0E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8741F238C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225ED20F5A5;
	Wed, 16 Oct 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gIn81/ID"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705120CCEA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092359; cv=none; b=tyA7IjXKD+OjlCKuUM8OZ9EreotMCWqKrlpuvWDk+6Zvi1iICg4zo2k3qX0hCvg5rJDkziDeKyMZEifckGF/L+bQvTDIu6wNCAxcPi5+EDhKDAUvSxQky8HmB5bajaYiBpETTbexsVBRlAnTl50gOQxMfJt4kiQqutHeupvEa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092359; c=relaxed/simple;
	bh=f8mr5Tp9tWl2Av2SKDrDykQE4z1Aj1mP3io1i9cbYf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bFWnLD57/HoxQrzJn5oIPUs1QtWF3pyO21xWRvt/ZStMWcwUMTBbldxDoCkq7lzmddPyjAPwV15le2HBGQdKSFy2MOC48ocpgMq6rFZqnbI1kvYgCPHkedJIMuiSCq3Xq1RUYVltU26y3sk/CNDc9FzX+4nCC0dZLj91Nz65rAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gIn81/ID; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729092277;
	bh=zB82FGDIZRSlwTU6LrA47k2enlekK9Q2dWwFB2jmb4I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gIn81/IDe+E0GdLwEAs2Togd+6ylTL6seK2eRGEG5aDfCVutku8hO8BGWS2PsY42t
	 IscwjRcKoY8qsp4nuSqsCap8jUuHl1Wq6T+xMBT6J8XUB1ucPPckO3a7A+31tvh692
	 9BVXTtAI1aozj2moI6GItSEg1gJPhCUaPYWVdbeQ=
X-QQ-mid: bizesmtpsz6t1729092272tgrnos5
X-QQ-Originating-IP: 4MrB3UtA303O6nJ05J1HTcZjMebOzESjmRzYyvDcUKM=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 16 Oct 2024 23:24:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5984523009251058252
From: Gou Hao <gouhao@uniontech.com>
To: xiang@kernel.org,
	chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	gouhaojake@163.com
Subject: [PATCH 1/2] erofs: using macro instead of definition of log functions
Date: Wed, 16 Oct 2024 23:24:29 +0800
Message-Id: <20241016152430.3456-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: N8vItbyl617cu81O/yaOxLEZRsIEu0zG4MbQaY5huTwY/2T/fWvFeG6a
	XDw9Gdm7GRMezg2yyhHnTZ9nW6gShWmDDxxjCPLH9ojHuVwPw5rXGG0/aKNc2Q37I5wJ2WN
	bYAy4ENiNAnJmwn3bEmH+7ijcUYjxKSXLhgHAxdced5pqtfnPXHM+W5wWvUUewI271YC0Ok
	hCZFK5JmGG/nUweI2rY5uzOyJOnwAcEil8cBS7NHJNq5UIFw72kgxAIhQsmAEUrGYY/OYfG
	hqQQSfpzRyqiwzG5fn03oGCGkOjcPdNVeaWjRJrMXRRD1fvnyrOxNfTRNimT3g38Txv+AWZ
	ZjmIv7ALz9sT8uROBWDF+e0Flme6BvjOY7g+46Cq4J8UlI1uNgT5jrrSBum/HN8dYDIceIe
	wbSYDx0EqScfvLmu0W84AlDuVeDy5zZvl3LoafeZv2B0c7OMcW20tQX/ryM8Ks8qMKq5nRA
	hqBDMBzMhTQioSAHp3eo7lu/mLOaz0mDKgsAEpmK/l52l07tYO0amUp2HshANSNpVzt7N8t
	y67XFFbo3wgjuvg2z9CZrhbSnGgBVyFDZ/0jgmeih/dFZrtBffsTrNUKKXETi6gvWqTUZws
	FpPjF5LQ8n0A7Z03+ibuV0MNRXX0y66vnTUufantXKaymfDMBOtcGa2UguRnnaRIzjiMwwK
	BE3hk19/NVX1kXKV+SSllcEsuFHZqfVww7rrgAt/8zpcrYBbL3mwYmA2K3c3BJ7l1M2Fql7
	Dro/5k3qpA/yWMUjTXNgIk4mjVMbHOyl1gNDfRW0CWUe5m8+ysoMG5iwiiAuy56N5OFHF/P
	LYPNkR7sQH0nBL2M/ErzBkZCUvdBQzbZuz3aOgtOo53kvqUGm96Tz1veSyAV3xJ9VgVBnTJ
	YmvgPOH2CP2ByasRGsEoxLMXmcUe/bbuojT2JMtH1Kjf1EDkcQGY3m6h5vuGqmAlwu4LfrZ
	XRDPJUbs5pS6iuPNkfYTzLsMvLSjjNEzrCSiIhek3PcA8s1PQzbtua9zrIzkRSaSLOzMkTF
	PBpZwvDKimK8LmwCEBD6OIc2IOSmM8sVQ9bFn62g==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

No functional change intended.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/super.c | 51 ++++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..b04f888c8123 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,39 +18,26 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	if (sb)
-		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
-	else
-		pr_err("%s: %pV", func, &vaf);
-	va_end(args);
-}
-
-void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
+#define _erofs_log_def(name) \
+	void _erofs_##name(struct super_block *sb, const char *func, const char *fmt, ...) \
+	{ \
+		struct va_format vaf; \
+		va_list args; \
+		\
+		va_start(args, (fmt)); \
+		\
+		vaf.fmt = (fmt); \
+		vaf.va = &args; \
+		\
+		if ((sb)) \
+			pr_##name("(device %s): %s: %pV", (sb)->s_id, (func), &vaf); \
+		else \
+			pr_##name("%s: %pV", (func), &vaf); \
+		va_end(args); \
+	}
 
-	if (sb)
-		pr_info("(device %s): %pV", sb->s_id, &vaf);
-	else
-		pr_info("%pV", &vaf);
-	va_end(args);
-}
+_erofs_log_def(err);
+_erofs_log_def(info);
 
 static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 {
-- 
2.20.1


