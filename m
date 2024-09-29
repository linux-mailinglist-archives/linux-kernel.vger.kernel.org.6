Return-Path: <linux-kernel+bounces-343057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2C989651
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AD31F22747
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B3817BB13;
	Sun, 29 Sep 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pJ/fOHHI"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB18D79FD
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727628847; cv=none; b=A2axh3aAKEshuXK33xezAoylK9m7H1u0rkJRVQ54e8s0pjzKfMJ189sTgn89UY6Vuwibn2l0yR78WH4M4PHzmAzZKB815Q3BxsGE4jRqOId7KJYoygQclAuWdJQFsQzV4qy3SZgReQoBgJcjh/wMW+h2pgnbnICgasC7ESlMfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727628847; c=relaxed/simple;
	bh=Hmf65xmPAaX0KA81uMG+zeb0V7kT8bj7y3voi9BokZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H4UewKTFudZPKDB7sOMQ2bGlMtygmXr5atvhbWSajfBfgkwRjA6s+wzbCRWReW6Kf/mzrOfsOfv5zxzOn+mjkieKmiBm2/jltika2SHBTyFKZC9cD1tHbwIgUhFA7u8+cUAqs+MUBxMf6MEPCOtmp24mhKajHMjdyqJ+WSAU8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pJ/fOHHI; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=f5s0J
	iV0hBMDez/3/VZZr5beTCYKZp//oFcyFRstHes=; b=pJ/fOHHImITp2lJtpFdXn
	18WvQ9BOt5WXz8jCRxi70IA35uIl9oedXTRCVYZxIcmU6aZZmUKUqh61fI7iRGen
	AWSrPBtSjweInQFfMVfmZ5bOXIpkJUUSWravn/bHMe1DYe90VxGdiV4nomx5pnoy
	d/JFdhWD7kPqXEAPd/2XII=
Received: from localhost.localdomain (unknown [183.192.226.126])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD332URhvlm43+AAA--.18459S2;
	Mon, 30 Sep 2024 00:53:38 +0800 (CST)
From: Benji Dunn <helicobacterpylori@163.com>
To: mchehab@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Benji Dunn <helicobacterpylori@163.com>
Subject: [PATCH] lib/math/int_log: add natural logarithmic function intloge()
Date: Mon, 30 Sep 2024 00:53:08 +0800
Message-Id: <20240929165308.3325-1-helicobacterpylori@163.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD332URhvlm43+AAA--.18459S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4DWr4UAw48uw4fCrykZrb_yoW8WFWxpr
	Zagwn8t39Yqa47AF9Iv34kAwsaqrs3Grn7Jr9F9w17Xr1agw1kJF13J34Utry8KrZFkFWY
	gr4UXryDCw4DAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU0XH_UUUUU=
X-CM-SenderInfo: 5khoxupredu3phus5zxrulqiywtou0bp/xtbBDw5oeGb4M3dWWgABsG

Helpful to do natural logarithm on some NTC thermistors.

Signed-off-by: Benji Dunn <helicobacterpylori@163.com>
---
 include/linux/int_log.h | 19 +++++++++++++++++++
 lib/math/int_log.c      | 24 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/int_log.h b/include/linux/int_log.h
index 0a6f58c38..b452ff298 100644
--- a/include/linux/int_log.h
+++ b/include/linux/int_log.h
@@ -53,4 +53,23 @@ extern unsigned int intlog2(u32 value);
  */
 extern unsigned int intlog10(u32 value);
 
+/**
+ * intloge - computes loge of a value; the result is shifted left by 24 bits
+ *
+ * @value: The value (must be != 0)
+ *
+ * to use rational values you can use the following method:
+ *
+ *   intloge(value) = intloge(value * 10^x) - x * intloge(10)
+ *
+ * Some usecase examples:
+ *
+ *	intloge(10) will give 2.302... * 2^24
+ *
+ *	intloge(2.718) = intloge(2718) - 3 *intloge(10) = 0.999... * 2^24
+ *
+ * return: loge(value) * 2^24
+ */
+extern unsigned int intloge(u32 value);
+
 #endif
diff --git a/lib/math/int_log.c b/lib/math/int_log.c
index 8f9da3a2a..34d1c5065 100644
--- a/lib/math/int_log.c
+++ b/lib/math/int_log.c
@@ -131,3 +131,27 @@ unsigned int intlog10(u32 value)
 	return (log * 646456993) >> 31;
 }
 EXPORT_SYMBOL(intlog10);
+
+unsigned int intloge(u32 value)
+{
+	/**
+	 *	returns: loge(value) * 2^24
+	 *	wrong result if value = 0 (loge(0) is undefined)
+	 */
+	u64 log;
+
+	if (unlikely(value == 0)) {
+		WARN_ON(1);
+		return 0;
+	}
+
+	log = intlog2(value);
+
+	/**
+	 *	we use the following method:
+	 *	loge(x) = log2(x) * loge(2)
+	 */
+
+	return (log * 1488522236) >> 31;
+}
+EXPORT_SYMBOL(intloge);
-- 
2.30.2


