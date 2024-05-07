Return-Path: <linux-kernel+bounces-171256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C48BE1EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB531C229F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EEE158A14;
	Tue,  7 May 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JLida0Wg"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C74F896
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084537; cv=none; b=i7DYLImSAEpT5AlHTbvhAE7BbNIltrhudVsh1eizqvnfIimBmjx0Jgs0j3oQg6eBi8VUroir2FDs+uKlwC4gyf2f5Dcj5pU3qo1HIq1XpsBdv+Djp8E3nEsrQHUVxICNCdwcW+CjbL+3d/EmmZDER9SUD7dMB3PK/sZSZXeIDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084537; c=relaxed/simple;
	bh=B6kR1xJ17f2MEcCkehimUgPLU+4LRK2+MrfwNpVDTX0=;
	h=Message-ID:From:To:Subject:Date:MIME-Version; b=sy4OjyQTBljSfO5Gjt3Ro0aJNvySww5ZKtcLd+6R1HNpISF+OW7iSVG+/056RGpJ7Pkc/Tvq/HJG5qc69ePh+2w54Cih/8phXr6172tOPyRDKUKDH6fQg0qjN2zfKFxLh2TvrpdcpwZXbHWdW5o9ZXLjJ3DnK3lJHN+9S8ha9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JLida0Wg; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715084526; bh=k7iH2IWINf1iF9AVyAxjOgBfh0oZVxsfFHZWtxe/7Eg=;
	h=From:To:Subject:Date;
	b=JLida0WgGbqfaZWyDo8HUp9QaoUPBQsrooxUMZtsB+s9gDH9cGGmUr7TLue8hpJpo
	 3ZgJ7TND0ywVRaPfYe8JJwMAnul8bml/k9OlPhEDg2BDLSVjKNE0LfBY/9NkOEuQLh
	 fJJWZXb4J5vwfYPekxiqWbQtXCg8KhV/ibiYrRXc=
Received: from pipishuo-OMEN-by-HP-Laptop-16-b0xxx.. ([123.115.148.131])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 3669CAAC; Tue, 07 May 2024 20:13:38 +0800
X-QQ-mid: xmsmtpt1715084018t4hbvjsd9
Message-ID: <tencent_1423E8EA63C9C00B49636738FF1050480C06@qq.com>
X-QQ-XMAILINFO: Mkw1Oys1xyjC2i83KPm7vqPCnLjHHv/GZzgcJSKqikIOxCvf/FI8McfE4NaUAU
	 viL8DQ/NNdBZzmwcJa5oCGEauzG/aAh/qYtV3ZxQT04QK4FrlBPUt5hCzWBgh4fxKHMROVuL3A9M
	 /fTZVSaH8eil1ty7yErlpwqwDRffVXC/LbNsD6zsrPYZ3SHTh0U5+9Y6Yb3BgyfGHxF3/2nppUxV
	 ZeMMWHkKhaYxU52vazuEtcZ/TgnIfSebEMaNIgsbtc7S3WmJztc1ulDFp5Sl7++NwodtnqErS/fQ
	 sodcZQ0pf5/iuDLzyAtsAZeijVqdKYSxmLTlUdk1l43EnXHFWTa9ojTFut5zEBB6vb8Ssd/F8RdN
	 xeD8kgQP3+SAiK6M+vIpS2qqtzhDunZlfTIBkgOzN8Khkm08JPswo/a/Rrqsk4fZs3+SkPQ+pbZC
	 8rbGzRgHBN7dWkxs+YGOGuAqdDDSzjrJCTcY72NuplYOSk5CCv+M5e+pEMK+EN0guIaKCyTd/FkO
	 s3cAcIhs1f9ddXWRfU4V8GQY5zNTn5M1LX4lWMZyQoO9jO+AlMja11AokFnvL+WhxWpm5BBvORXl
	 ZlunnuZYc6eXvLwWWyrwZZWUT6BdRYmjw2MPnD6FaELx+6c+Okv1Lj2EBDr5ECxWSxJ5C1+sy+FD
	 Qpr/uRLCtAbX+hr/VEpeGrbodEbNt0qruFk4JbfZ0AUPHXL2DjW6g7DwhY93rzQVqjPAYMBczLpg
	 zBjCWd1kRVBnfzH8dsLeMt7gUQd1kdb3pSMUE5BOoZpv1SnnaZfnfUqHOM4eoaSqTdn1RduevHl1
	 zTAfJHfC46CVm0AWssCKPsrYoeshuQciN0o+6vfZMMSzFuh8f5AMvpzLUoXiiz9/OwgpltA5aujk
	 SS2q2NIqqpJIZ3dr9K9qL37k5VpLbyc1BTFxDstE2kcwU4OkMlOZLUZFTSHEyxcnomGPhXymHwXZ
	 6R8xkCDOJiKftYiW7qbOjMJq1yYGpTCdcCOpmpQa1vUb+jZA7KqbAiiupEKev1uEHIrETRCrZS5/
	 YRB5rZPhzk2Bw7y20YJ6yF5DpNYElhUphlfjohhbJbJCFJ9o3PasV7OAottbM+WbIrpzCAQ/H5xF
	 4coCauYQRZZ6YCZVK5VWSFOInTWkgNCvwzfaeSNgAN3j+NJK8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Chen shuo <1289151713@qq.com>
To: 1289151713@qq.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging:rtl8192e:fixes unnecessary braces
Date: Tue,  7 May 2024 20:13:37 +0800
X-OQ-MSGID: <20240507121337.10511-1-1289151713@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the warnings reported by checkpatch.pl
for braces {} are not necessary for single statement blocks

Signed-off-by: Chen shuo <1289151713@qq.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e3ed709a7674..1862a9899966 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1640,9 +1640,8 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	if (stats->Length < 24)
 		stats->bHwError |= 1;
 
-	if (stats->bHwError) {
+	if (stats->bHwError)
 		return false;
-	}
 
 	stats->RxDrvInfoSize = pdesc->RxDrvInfoSize;
 	stats->RxBufShift = (pdesc->Shift) & 0x03;
-- 
2.34.1


