Return-Path: <linux-kernel+bounces-285798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD5A9512EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03388287285
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E4F339A0;
	Wed, 14 Aug 2024 03:09:45 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEE74CE13
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604985; cv=none; b=XF7vkvrcqEd/qRsFqV1FagnouApUjNO/PS6Ro/Conl44LXHTec233TN4XkoNcmC/AqKLqrjzHNtPb8MoF6letBpVbvHAZuIDTPBTFd1MxaN1gbDu7IFCIuiKhj9r8Ov7lSoZEuZEXPCwgmHjso1jnCKg/OqCRXvjlhB5cT3wEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604985; c=relaxed/simple;
	bh=1cYJwkc28bftvFZaf6qre2rBCBdCEBWMq2cuYhDKGos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/dINKtOlwJTZ0KvsoZPiibHCYlSJObfqrhw7+4tBVX0ikVuKkkpxXso9qfAn/3u4lYHjnlAdj7rTTbSUZevO4c53fx1oENAWrMWtyBxcyFH9RN93sBvpOrd8oSK2UH+XlSP3HV2oVTMCYSTIw9U/TUjhyUolWBX6aSegFfhTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566bc1ff10ff-3a101;
	Wed, 14 Aug 2024 11:09:37 +0800 (CST)
X-RM-TRANSID:2ee566bc1ff10ff-3a101
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee666bc1fe1ac0-22bd1;
	Wed, 14 Aug 2024 11:09:37 +0800 (CST)
X-RM-TRANSID:2ee666bc1fe1ac0-22bd1
From: bajing <bajing@cmss.chinamobile.com>
To: w.d.hubbs@gmail.com
Cc: chris@the-brannons.com,
	kirk@reisers.ca,
	samuel.thibault@ens-lyon.org,
	nicolas@fjasle.eu,
	masahiroy@kernel.org,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org,
	bajing <bajing@cmss.chinamobile.com>
Subject: [PATCH] speakup: genmap: initialization the variable
Date: Wed, 14 Aug 2024 11:02:43 +0800
Message-Id: <20240814030243.2138-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable lc is not initialized before use, so the initialization operation on it is added.

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
---
 drivers/accessibility/speakup/genmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
index 0882bab10fb8..a1ea0ce45c20 100644
--- a/drivers/accessibility/speakup/genmap.c
+++ b/drivers/accessibility/speakup/genmap.c
@@ -48,7 +48,7 @@ static int get_shift_value(int state)
 int
 main(int argc, char *argv[])
 {
-	int value, shift_state, i, spk_val = 0, lock_val = 0;
+	int value, shift_state, i, lc, spk_val = 0, lock_val = 0;
 	int max_key_used = 0, num_keys_used = 0;
 	struct st_key *this;
 	struct st_key_init *p_init;
-- 
2.33.0




