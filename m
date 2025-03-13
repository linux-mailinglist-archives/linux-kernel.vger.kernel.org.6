Return-Path: <linux-kernel+bounces-559011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F5A5EE50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480403BA8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D7C262D08;
	Thu, 13 Mar 2025 08:46:35 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B120EB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855594; cv=none; b=WRoarYngQ6nuJFzBFnt0fO6E5nSNWZEBeaVZQAmW06dRClZcOZYABQ+iECxNn/tZMZ4P0hnmwt8xA2o+YnH9euJq94pOKQIVqLpq2upOU4oA8T/TesWFvVFDFBhDM7odQYYUtJjkcELpQ+dTIEGzwmOJq+GM5B9x/8Slgh6FKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855594; c=relaxed/simple;
	bh=lX5fbAxYohnvu2u3/SWuHgfzE9prnMx7mT62tFxAocU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=uXZlH3c0etBUA1jRA5EUyGr3333NYp6b7SnvF4ZGrCiplocD05o0Lsgd8KeTbHY8vijaS6uTb8ZEMYkP8gVFc6qa1zmx25hSLaYxtCv4SdbVljcfkC8UT6nWDC0b3v11wYkyGk/g7RWavwIM6+HuBd0d55bj4hIipMMnJ7N8FPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZD1Lp33VHz50FXL;
	Thu, 13 Mar 2025 16:46:26 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52D8kC1d078180;
	Thu, 13 Mar 2025 16:46:12 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 13 Mar 2025 16:46:15 +0800 (CST)
Date: Thu, 13 Mar 2025 16:46:15 +0800 (CST)
X-Zmail-TransId: 2afa67d29b57ffffffff93b-5023d
X-Mailer: Zmail v1.0
Message-ID: <20250313164615305U0u1TXBAUsEnpGZQjtOS-@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <brauner@kernel.org>
Cc: <jeff.johnson@oss.qualcomm.com>, <jack@suse.cz>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBubHM6IEZpeCB1dGY4X3RvX3V0ZjMyIHBhcmFtZXRlciB0eXBlIGluIGRlY2xhcmF0aW9uIGFuZMKgZGVmaW5pdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52D8kC1d078180
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D29B62.004/4ZD1Lp33VHz50FXL

From: YeXingchen <ye.xingchen@zte.com.cn>

The declaration of utf8_to_utf32 in the header file uses
int len as the parameter type, while the definition uses int inlen.

This patch aligns the parameter name in the definition with the
declaration,changing inlen to len to ensure consistency.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
 fs/nls/nls_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..59989205f1b5 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -52,7 +52,7 @@ static const struct utf8_table utf8_table[] =
 #define SURROGATE_LOW	0x00000400
 #define SURROGATE_BITS	0x000003ff

-int utf8_to_utf32(const u8 *s, int inlen, unicode_t *pu)
+int utf8_to_utf32(const u8 *s, int len, unicode_t *pu)
 {
 	unsigned long l;
 	int c0, c, nc;
@@ -71,7 +71,7 @@ int utf8_to_utf32(const u8 *s, int inlen, unicode_t *pu)
 			*pu = (unicode_t) l;
 			return nc;
 		}
-		if (inlen <= nc)
+		if (len <= nc)
 			return -1;
 		s++;
 		c = (*s ^ 0x80) & 0xFF;
-- 
2.25.1

