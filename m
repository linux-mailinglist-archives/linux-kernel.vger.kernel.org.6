Return-Path: <linux-kernel+bounces-329568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B9979302
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 20:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2368F282F06
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B31D174B;
	Sat, 14 Sep 2024 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT307L6j"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAD1CF5D2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726339788; cv=none; b=B052zP3DwQB3w+hiB6EWqoyhsEadLdVtc+UgmL9knBP2Tcy/J7sk1ZiseedAzdX6suPWxXEeRXHnLDkcvWTXlaRGJbh1zZKOjOi7sJbaMKxFYmG3Pp/BtYL0jvJvrOJqvlKApxjEPIgEl2SgjcE29jSsPKTh47SkcUcu78lVAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726339788; c=relaxed/simple;
	bh=e70E5Y91Jsny0whAyhew+r/g5VGp2qLMl59bQCj571w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqw1vM8ha1r09pt1pxWYUqjT6jDa+hEjU3ZAbwzQP/ExzkcbSUUeXtBOQOTOu3F6un4E4Q5DZgkrOt33n8xbBpklG0H0DTBvx78SfUj0NcoLzi+aCmOQ+o3S8yfIM9zayqKnDMRWO8h59YSPB42hkYzYTdzJwFI+9PpruTMnyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT307L6j; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so1762811a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726339786; x=1726944586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRV/D2yysUbqRudO1eZM7UervZe3Msap6RU661L548E=;
        b=MT307L6jItSszAF6n1bG1H6S7BnSEMVQbG6fYBMin6n2B1SXmaLQ49aGx7p5NqZi2V
         FRFIzuLHEMBuCdbo5nVJLQ/jjyqvEqq4h+Os0lD4By76HADCvccVnqgZmo3AbcXSKSl9
         o88OdyxEm3i4azs3ZkOWiRVS+CsgCwVHKvaHB3NNZtbr8z4Ze2zNMObo/JoaOoqf0dUJ
         jZpn4EJ3HM9Sf57N5psUJtiV9XWCpBhjAGaxgrTzZPuL0VcWxNUUPoiMSDIQIXP2fiVa
         jgl+mWtBFtx9VP4/DnEmcykSiFlbp2juvIHQRHCxcmVQEcJCKzHud2ESmET479TfKoxv
         EcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726339786; x=1726944586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRV/D2yysUbqRudO1eZM7UervZe3Msap6RU661L548E=;
        b=VlsatJ+2ev1jDWdWDwfvQmVBnZ9BrxAlp5yuc7tvhU/xeHPXlt4WDYnDAhkUykyPi1
         EvjGa6FxL0IEYGGWbQsSNaywqm7wQo/ujgGyebCwe6CCkfxiAA06bwe0Tw8XO9XvGN3l
         U75L2GFDz10d2MFi0DKSLwtlIs7yo/ngJ3ztL2lesRJOEl0mVdg475G2DCUHp9cSmRHU
         jGCJYbTyC9//Ae1v6IrU1oBPe/NlJ5UtP8W+kCugd5GMfRDWn8oIPHTrEo8D3hmZPT3m
         8KAKJzqtA48XLFXrmB6UIAOTShdrKnNHg9zAJ19KUuVzyozlEipG4WfmqSpi8XD9qdFW
         vvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHIYImItCnAYjK5wKXV0jJqnnC6Tf0GX544rtjpLwXLGnA3Q2IjbDWDllnaIxgDY6hPcdaMQ8nPQvE65o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuG3zIKS1dOesMe/tx0uAIK2dPvweMUoMuork9c9wtqdmLHb73
	BF+kcyuraHzRm8vNuhTrevAuw3t9xOSelfIYL3Tf9hD7a7yFj907
X-Google-Smtp-Source: AGHT+IGG089sKirYuMOIPyg9jQWpJLf2jAJ1DKymjs53A5OLIf65r9pHbmzVbYI/wDkgKwg6PEo74A==
X-Received: by 2002:a17:90b:1c06:b0:2c9:1012:b323 with SMTP id 98e67ed59e1d1-2dbb9f3c96amr8589484a91.27.1726339786061;
        Sat, 14 Sep 2024 11:49:46 -0700 (PDT)
Received: from embed-PC.. ([106.222.229.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d5c9dcsm3998170a91.43.2024.09.14.11.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 11:49:45 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] staging: octeon: Use new initialization api for tasklet
Date: Sun, 15 Sep 2024 00:19:35 +0530
Message-Id: <20240914184935.848999-1-abhishektamboli9@gmail.com>
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


