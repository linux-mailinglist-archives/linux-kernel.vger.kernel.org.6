Return-Path: <linux-kernel+bounces-434295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B09E647F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADFA16A41A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ECB14EC46;
	Fri,  6 Dec 2024 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdpytCAM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CE1E522
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453849; cv=none; b=NM3hycgFAZ6bD2rvqmDUPaTFkyz8Gud87dZPTzuYuWbDY8OH7u285JQwtNwpxg+x2PzLgHAb4IbptkGhH/89uINrlgqDmyMa2akXPclIIfOb8De6GMF326Ce2mnF5C4Q1MXqHqgKMWsk0nyx7FKlgQA5iEpa1jtDALlFnQnZ5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453849; c=relaxed/simple;
	bh=9HvO6MAsaIXImHWsj9SUkjkf6vOQBCv+prcETtLm2y0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cYOtAPuHiBT02cPWKYyU9D3ZAEkJ12elqbPuzg3Z3IgZFCg8oK38K0jc4dR8xTmxre1dvqlFBaa8HHVDVMMva4kgtpG6CHlndBN2fAOBkbi+q1Y8ttd4nugODg+GQqTw+3E+70UBKt/3n5klyOMuMbonGjjeXxElU2auiGYQVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdpytCAM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215bebfba73so15249825ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 18:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733453846; x=1734058646; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuXPmsAiOF3KO5nczLS1cdNL/HEbPrxijgBKivhC7TQ=;
        b=NdpytCAM99uWwLqIatFyk4UZkqwV0HG9jj1nt+PoCx1/W5CjjKas/hmYCZ6Dfqz3RC
         WIUFbJ8w2aPbPSRsNfIQPuuZQuJgEfAV12qyDjOQbsTi04S+OR28wkqKUH94PoXlI+rY
         74pWoJJudIDOt5ldh4FTVvRv9tlMo/bs/pIKB2hkeulYenF7jMhyK6bfTlEvyJX6aizT
         M5D/WP6vi5UV8fFhZQv17p/vUWc4OiJFZp4gvGcFdt5VIRMzODtjtAPOh+7mFLBy89GZ
         tRvKUW8KBrxZijjp6j7EwIjWHNpexjeZn0QBbLy6VYsASILbgOESHqUUR8FvOX9FsTLq
         zVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733453846; x=1734058646;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuXPmsAiOF3KO5nczLS1cdNL/HEbPrxijgBKivhC7TQ=;
        b=rubLytFjJRnFnRrJk/TsK7hlhwe4mSCgO01NcMoFE2HsMxvxKFjgoOgYtdcQlot9Tk
         2NE5uNEVYm6z/ioQoIHEtqIvlsUBoZi6DIH3P3gDLr5IAZjHgKDPr7oS/WakDs8mJ4sF
         u3i456MlmPkonQfasQ7WgxypHhO5gY7uEroSQ2M3q/wE3UewJ71Z2ZW21JbyOyEnEfHH
         P6RwTM/YaQW30arEZVaGA9XXyXFKorQeAkVUyovtIJfT1262cqUo4oHzSBFaHPYMRIVI
         w7e6WFoG7pabnEqQSKy/aLGBwyEZhb7OGpMVp81uxfYk3/LznqE9E9LGBM4KWfjixEXb
         HcLg==
X-Forwarded-Encrypted: i=1; AJvYcCX63trg18itSx/nVc38MsFFAGVO2ve29yLx68bfy7tO/J6a5L7XyPGJdmPDyLDiMwVYjtT7i6Q7bdcTSHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWEwgbZ9wSfvfMlO41zL+6EQrv0I8KxLecEFPB19iMtPJO6qN
	AQWYDbrFWSEo0XXD2skVNvVYnaxNyZkGB4zqxuQ+lSWZeBLRxau2
X-Gm-Gg: ASbGnct5OyK4Ow4znQI8xIXeTfKj90Bl9zqg5fZRCdsimDgR5QE5i7axi6kpxl8oYW+
	EO1SRj6tLGif8Ne1peBiIuce0nA/zwLAh0kaURtLxRHoPZlupGUb9o7n0EQWtVAvom7E+yTYbDD
	H9XJe7JfV+sUMwTw/aUC96M1QvXKbBJ0q7jUJPJg58livmX4sZvNBao7isEJvHeIhclKSX2NUsj
	doFZpY7bPLxk26ORbQsm/qNnpKxJZmBwqrw+g01hR23HKIfxKQtw9p1DtI=
X-Google-Smtp-Source: AGHT+IHejNabSimnXrS0lGaFIhPRq1cGDp6OFV5HMLaXgF0kRwII3SCTj6G4UiGebDcRVGiFJ/yURw==
X-Received: by 2002:a17:903:234a:b0:215:6093:e384 with SMTP id d9443c01a7336-21614dd7fbcmr15675455ad.49.1733453845922;
        Thu, 05 Dec 2024 18:57:25 -0800 (PST)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3fd6bsm19436955ad.4.2024.12.05.18.57.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2024 18:57:25 -0800 (PST)
From: mengensun88@gmail.com
X-Google-Original-From: mengensun@tencent.com
To: akpm@linux-foundation.org
Cc: linux@weissschuh.net,
	joel.granados@kernel.org,
	avagin@google.com,
	linux-kernel@vger.kernel.org,
	yuehongwu@tencent.com,
	MengEn Sun <mengensun@tencent.com>
Subject: [PATCH 1/2] ucounts: Move kfree() out of critical zone protected by ucounts_lock
Date: Fri,  6 Dec 2024 10:57:22 +0800
Message-Id: <1733453842-5773-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: MengEn Sun <mengensun@tencent.com>

Although kfree is a non-sleep function, it is possible to enter a
long chain of calls probabilistically, so it looks better to move
kfree from alloc_ucounts() out of the critical zone of ucounts_lock.

Reviewed-by: YueHong Wu <yuehongwu@tencent.com>
Signed-off-by: MengEn Sun <mengensun@tencent.com>
---
 kernel/ucount.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index f950b5e5..86c5f1c 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -164,8 +164,8 @@ struct ucounts *get_ucounts(struct ucounts *ucounts)
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
 	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
-	struct ucounts *ucounts, *new;
 	bool wrapped;
+	struct ucounts *ucounts, *new = NULL;
 
 	spin_lock_irq(&ucounts_lock);
 	ucounts = find_ucounts(ns, uid, hashent);
@@ -182,17 +182,17 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 
 		spin_lock_irq(&ucounts_lock);
 		ucounts = find_ucounts(ns, uid, hashent);
-		if (ucounts) {
-			kfree(new);
-		} else {
+		if (!ucounts) {
 			hlist_add_head(&new->node, hashent);
 			get_user_ns(new->ns);
 			spin_unlock_irq(&ucounts_lock);
 			return new;
 		}
 	}
+
 	wrapped = !get_ucounts_or_wrap(ucounts);
 	spin_unlock_irq(&ucounts_lock);
+	kfree(new);
 	if (wrapped) {
 		put_ucounts(ucounts);
 		return NULL;
-- 
1.8.3.1


