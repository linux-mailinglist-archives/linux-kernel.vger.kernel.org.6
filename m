Return-Path: <linux-kernel+bounces-343294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D90098993F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BC5281444
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60021CD35;
	Mon, 30 Sep 2024 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuNaeH4T"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E32A1D1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727663600; cv=none; b=PFKIKrHpOEITgqOawDmKLh99pQdy81Ur8dEeYhxl1aUMhbPw8oUO5Kk7OjReYdiCR6RPAa0wPe6KMJ82F/eMplwLncYi7cmuqVzqdX/HsEMuridARFDjxJt8dnJWibik938I18Ary75LIXOQolGXN3T/D7PtTh5HncfhurMTuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727663600; c=relaxed/simple;
	bh=e70E5Y91Jsny0whAyhew+r/g5VGp2qLMl59bQCj571w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fkd/kaAVd2AjFOixE9m68UIj9gkgDs8yc992StrbYGew7UoHE0h/B/kA7G3DJTno+PqCH/5IVVkHJC34R5AO/edoI3W9TQTSVCN+QTmTslpfV2sqShXa8fr0OygMB3/Q3dPZJJ3QSvsFUYvTObBxMZn5pvqlvYtzUbEEPFvb+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuNaeH4T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-208cf673b8dso38402125ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 19:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727663597; x=1728268397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRV/D2yysUbqRudO1eZM7UervZe3Msap6RU661L548E=;
        b=VuNaeH4T60Y1YpPyIdTg5cGBR3m/+TI66WSkhirBioixedSVoH3oD6anASwvPL9k5s
         RXainIr7I6bYd8Ofd+Pq8oKop4CtfncUkP0EaHOOpkNYkZf8jBsvpMxXNgdZudUKWifV
         XeicZ4ePIoouFyVGcfG0j1dwNKr1ddOE2l94qEQWl4683O3t7lZKu5kNfowN4+uf0olC
         aBjX4ksQ5z5o5efE6uAK1i6jCT+wIQ7OgfnZfdip/OKWA0mqW+Modvqv/mDWFxQe5QGu
         20F1Ycjk0EMa0/S6yf910Z/tTNVbfPaykik4lOeNM8Z7fkiPGcZu+yBTMmHn7XlJgsoJ
         Luyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727663597; x=1728268397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRV/D2yysUbqRudO1eZM7UervZe3Msap6RU661L548E=;
        b=MjYdLJpsJsoojOQkQ3aFvf03K+p4ZM3r7VrL2KQ6C2M08XpmgwkfYKMHlolDnzIAXF
         6Q5LnnIcgzwyDwX2UEDD2GJYmv1jJHTq3OWLIOltVknnLqi1JYSgnecZypTLbnaoRn8m
         pBbyg3RsOyCl+E7DeTko8BXmMVpc0Z/CdF/ZG45jJgJYevqjNToHh6zWejpzBapBDANZ
         IBiwjsWwAzKwupGhVj7IXa4T5wxjOzel6kAGulGs5GrIWIJ8zCs+omtqy1y1sJUFrMiR
         eSM7sA6anH7PZNQUV3vm8aEFZAqcZfKQ+9Di+Iqa+wN0IQGShXYnBAeXJeOicO586PEz
         Qr7A==
X-Forwarded-Encrypted: i=1; AJvYcCUW56QFVxCLljRRAcZYjLHgBm5L37PFcWgpkuPzhoCLQZcb8EL/nwNF1E85o6wbgk01R9ZHmjbjAqhv9ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo24vLzj1Vb49ChG6pcncVzd3dBxHRHwBaKjVarZ0JHdRYWm9P
	MuUb2pRA6JzUOU+j9RAvoBV+p+amXoe997QmZhHAxWdsOVCA5i15
X-Google-Smtp-Source: AGHT+IFaTTkpMfIa3pAOQiRSHGes+mnXnVgqsNsCx/5/t+75/M5Nvh0Z+2hujAzCajr+YQeaUPZG3w==
X-Received: by 2002:a17:902:e74b:b0:202:508c:b598 with SMTP id d9443c01a7336-20b37bcfa36mr177554005ad.59.1727663596735;
        Sun, 29 Sep 2024 19:33:16 -0700 (PDT)
Received: from embed-PC.. ([2401:4900:889d:8638:b2f5:89a3:1fb4:f5b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d60e92sm45487275ad.43.2024.09.29.19.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 19:33:16 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dan.carpenter@linaro.org
Subject: [PATCH RESEND] staging: octeon: Use new initialization api for tasklet
Date: Mon, 30 Sep 2024 08:03:10 +0530
Message-Id: <20240930023310.397543-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new api DECLARE_TASKLET instead of DECLARE_TASKLET_OLD
introduced in commit 12cc923f1ccc ("tasklet: Introduce new
initialization API").

This change updates the tasklet initialization
process without introducing any functional changes,
ensuring the code aligns with the new API.

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
Changes in v3:
- Rephrased the commit message with the reason for the change.
Changes in v2:
- Fix build errors caused by initial[v1] patch submission.
- Update the cvm_oct_tx_do_cleanup function to accept a
  struct tasklet_struct * argument, required by the new API.
[v1]: https://lore.kernel.org/all/20240912172231.369566-1-abhishektamboli9@gmail.com/
[v2]: https://lore.kernel.org/all/20240913191734.805815-1-abhishektamboli9@gmail.com/

 drivers/staging/octeon/ethernet-tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index bbf33b88bb7c..261f8dbdc382 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -40,8 +40,8 @@
 #define GET_SKBUFF_QOS(skb) 0
 #endif

-static void cvm_oct_tx_do_cleanup(unsigned long arg);
-static DECLARE_TASKLET_OLD(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
+static void cvm_oct_tx_do_cleanup(struct tasklet_struct *clean);
+static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);

 /* Maximum number of SKBs to try to free per xmit packet. */
 #define MAX_SKB_TO_FREE (MAX_OUT_QUEUE_DEPTH * 2)
@@ -670,7 +670,7 @@ void cvm_oct_tx_shutdown_dev(struct net_device *dev)
 	}
 }

-static void cvm_oct_tx_do_cleanup(unsigned long arg)
+static void cvm_oct_tx_do_cleanup(struct tasklet_struct *clean)
 {
 	int port;

--
2.34.1


