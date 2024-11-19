Return-Path: <linux-kernel+bounces-414253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7EB9D254A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190E8B21DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1A1CBE92;
	Tue, 19 Nov 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="joihnOwG"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1414E2C0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018219; cv=none; b=SrKoR65cZuKKV07VH0bmPu/UmkwGAwsEQVF6Arbhzutu6Ej1OfmN5RnuVbG13lT+wnpYCvnZCBQJkIvEkwf18dTjhmC7joAu86QMfUpqRCT9C8dnSxH5HmCGoD5IILwKgLSiSGsq7afDrLWuqdzwqQiN3ACc1QoLzM2+yN1K6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018219; c=relaxed/simple;
	bh=EHHXpK2I22/nEn9GrAvnLolnIYuHuWm+nQOWbTaETao=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=QLMqiVGam7N1Y65GTtmdgS53S57tM8luHorbwHFu7W1iwLC/I6sVzy6ZpELf7Gru/ZTrMr28F5nGc6VPROsrNigB5uLtEJ96h8y8GWYNNnehKtcDyREAnxArBViGMOrPWsiMij5cOfaWvPDzgipUa6RwKqZUXt682CSJ87qlCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=joihnOwG; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732018209; bh=KFNPhJewrH3SEkj8gWwUntmsvmz2hvW9KUI7i+AvKjY=;
	h=From:To:Cc:Subject:Date;
	b=joihnOwGcO0e18sxm2iMRpdJsaV/JnymGSNmBJu2TLhg+B4d4yZDGkE4U9lvhYpK3
	 0c8qD+dUAdZnBVL080XpBrExbOBrciX2n62zMd3G1o9S7CMP1OgQNZyG7Re/rBPfda
	 UuhvA4xEzq2K0/tm33+XAvS4EDOPc0vbixGiYd40=
Received: from LAPTOP-58DOKDH3.localdomain ([218.95.110.191])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 743D0F2; Tue, 19 Nov 2024 20:01:52 +0800
X-QQ-mid: xmsmtpt1732017712tfq137wu8
Message-ID: <tencent_E213136E4B8D60D984B3095D9C2E2F0FD107@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2KyZCsnVHbTa/tTB9CsEX19D5cYVnuzw04LatcgolDVPEGBtuKY
	 +DkDpX4Wp11TXHbLun503p4ddEObhG7r9nZGMPudmqg76YYxUDboT4jn/r0zeBeqbK1w5BI8Do7B
	 FrmA8UKN9SUh6SWNLGgUdgWTpF8AzZo2TsH/WjhjZAD4s2L8mbIqe7A2BR8B+rc0qxSFpozA60Cq
	 kgySKjZ4OUkTxSrKTmuM1XEmnnwCEdV5+2NF49PvKMm8J4xI2lgSBVKKGPpdvn3BdXRfY5/5W8aL
	 8ARE8JbImNPxLl9AZgF4lzjOJMfcNSnHf32MlfMZIi7Gps4gi7J0vH0+kDpHQ7ubEm7Blr5Tc4HY
	 ifwQlZGlnAygUZ7iQhIcaptchJkOKweWUu2sQdhBgNIru5E4UnuEiKvuKsq3EWzyflfUkNGH4N/a
	 8zDQMVQLqMbCfwFbgVJDm9S3Im9iSak66ZFE6OBDuPbJTWm/GylYZeo4PBbNFpNaN1XOO730WxhC
	 Se8BsN30muN2+FuCog4Cu2k1k8I8w116AWAxYw1zgg+BFBG/wvPRqlxk/sHUcwUVyzKMogJBCUPS
	 1QyjUc3zr3o2lgkytDNpWwSuToAZg+iJMj5xiO/WIzoEVWNnzFy1U3QcrSU78GhyxCaWfy2BTfcL
	 Lqke4RpMas4lmVqKDwlxF7RLl2z3O42YqaTZ3liKT+kMNhF69IslGEPK+yrg8Zsqf1OXv7L+1Gbn
	 xD5wEpAZyxIobfXs0aV1EC4KWqEngOV/kq5jycMSbKtQbfbsujERuuuLDZ7Fd55s8/rSwlUBgDYA
	 QkjFdrEstnXDpSeDeHENSRBrAG2JTo6agfT0A7bogIIGi12FzgCrj/qxk/Zrb57WKxmnaCBKmS4N
	 TYmOjCOT7yZrMe4h9x2ocRaCIIL+mhS/c6OqSIz1Ihs8hOkCNqydUu5MckIcbiRg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: winterver <295107659@qq.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jiale Yang <295107659@qq.com>
Subject: [PATCH] mm: Remove 'return;' at the end of void cma_activate_area()
Date: Tue, 19 Nov 2024 19:59:40 +0800
X-OQ-MSGID: <20241119115939.16838-2-295107659@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiale Yang <295107659@qq.com>

Remove 'return;' at the end of void cma_activate_area(). It's a void
function, so an ending return statement is unnecessary.

Signed-off-by: Jiale Yang <295107659@qq.com>
---
 mm/cma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 2d9fae939..070399bce 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -135,7 +135,6 @@ static void __init cma_activate_area(struct cma *cma)
 	totalcma_pages -= cma->count;
 	cma->count = 0;
 	pr_err("CMA area %s could not be activated\n", cma->name);
-	return;
 }
 
 static int __init cma_init_reserved_areas(void)
-- 
2.43.0


