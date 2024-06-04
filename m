Return-Path: <linux-kernel+bounces-201230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C308FBB49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCDE1F25AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856E714A0AD;
	Tue,  4 Jun 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="icO6sQ9n"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6B149006
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524581; cv=none; b=Zqv9m93nbK5ceZhtTtv3h3FWbbQrBE88HKt0CNILfhO7GJ7t1ANva1ikOZdBHOLXbJ13OQWHAciNeejplDE0XGFsNoxuy/A+0j0DUi8GBX/OEeXRCUiE1mrJl27CmwR6HIwNHHxFE0TwrLM2ezN7tOlUF5eLki/B8TpnkOqVEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524581; c=relaxed/simple;
	bh=zlFWfsNQMx3Sd1wcaWh6ZJ1CoD/mFgMKL5nAugZkz7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r/836DSsw+egA4Gxjkm18EWuNcn06XKL5L4YN/EyYR35D1pXyH5d+VZsXUWy3RsGezyv864Dolu930wzA4XQ2gsHjvHRHvOXSGoRvOWhx8MPhB2MZB4VaKvKtMCysh91ww/cl20MTEss9Bd3HDXEaRQ1N+tjwMcvGHZkPBib6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=icO6sQ9n; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e73359b900so14832421fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717524578; x=1718129378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BF8/GItxoat+r6e4T4fHLj85BE2y/O2eJbYc1bfqVo=;
        b=icO6sQ9nYKhBglMTDc1Q6bEW9B1kSlQ7SIoK2XI3RDoOyqMEWUaoO73UtpTFEkxI4n
         d016IgL0BRSGE/A4k9yQb+UCNQXepe+uey+Z6fMvQi7tbdlEChx4Mgsqs+KF+neFDDEH
         kBNZdfHRtykgxbiscS8XtS2ZBTUO2zZozv6Y9ONthxbGHPtZck2qXQcs5lcaPEDy9amk
         p7G//WxSD4sAwPr+PvpwPE/L1+E2sEAo+5hrQ/qjQpDf0xJp78eMGeoRNpAQTPLcisFk
         SlvGLErc+YE4o/UYmkB1txiXJWnWWShzkjmls/nPirjqJvcIlazkWPstrozI4SvrZrK1
         kx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717524578; x=1718129378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BF8/GItxoat+r6e4T4fHLj85BE2y/O2eJbYc1bfqVo=;
        b=IUzC2QtS1Wwfygo9RUOuW5+t2BRRXqL2Fx+top5d3bsZ+TjvxCPe3E5yECDaKsx+sa
         soJbp+QniEeyO7tI262pn6+SnekjiOne9g2LaaSmD6/8MP56UbEtzCceVH0roP4kggyV
         8fQMxDWQWOYdc/6DAxCb5BBmSBKRvDJynktCJQz+NTIVFyX/RECWQI1JTdhVehxdja84
         LbUWMPVU17o9Zcy0Vp03beyaf+tVoBV+TfqGa6CUU434pNH0xeVhXL87cKsgH1goZtBr
         gokPLTAjvc4Oss0fjPiGGjLtRYZeKox9UmayMSgHFDPLfrQ5eNfX6AgFUKSnADuYpiYo
         C9fQ==
X-Gm-Message-State: AOJu0YxukBENUPfKBFXpDSIpLS3ZZ2JKnjYkKMllftG/ST//6uw9/y3A
	GSrzViY3TnygjC4R5D9esgPfTjQLoTlxRnMF91iGGomx7AwlNSmXUIofzNCGNpk=
X-Google-Smtp-Source: AGHT+IF3N6NfG0OENYZjXQOQM6bYvkm+cqHhQ/GSCbJSHvHKe8aILbrtlbcys8kaiBIZmXUTWEMsPw==
X-Received: by 2002:a2e:800e:0:b0:2ea:8291:c669 with SMTP id 38308e7fff4ca-2eac7aad160mr184191fa.44.1717524577695;
        Tue, 04 Jun 2024 11:09:37 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-160.dynamic.mnet-online.de. [82.135.80.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4214fdf4953sm27451925e9.25.2024.06.04.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 11:09:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] locking/ww_mutex/test: Use swap() macro
Date: Tue,  4 Jun 2024 20:07:07 +0200
Message-Id: <20240604180705.257033-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

	WARNING opportunity for swap()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/locking/test-ww_mutex.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 78719e1ef1b1..252bef786aef 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -402,7 +402,7 @@ static inline u32 prandom_u32_below(u32 ceil)
 static int *get_random_order(int count)
 {
 	int *order;
-	int n, r, tmp;
+	int n, r;
 
 	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
 	if (!order)
@@ -413,11 +413,8 @@ static int *get_random_order(int count)
 
 	for (n = count - 1; n > 1; n--) {
 		r = prandom_u32_below(n + 1);
-		if (r != n) {
-			tmp = order[n];
-			order[n] = order[r];
-			order[r] = tmp;
-		}
+		if (r != n)
+			swap(order[n], order[r]);
 	}
 
 	return order;
-- 
2.39.2


