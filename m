Return-Path: <linux-kernel+bounces-311461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6D0968987
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B168E1C228BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291A2101BF;
	Mon,  2 Sep 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLERkQk7"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE1183CDC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286214; cv=none; b=BLtsC8s5eMsF7+sa9D5Cu/j3URqAib27bW92s1o5hE1KH3VX8GCOWMlUxaJuvVulFml5dGzjvNCLXCE6FjzZw8mY1jmDLTSmPnSjVWvCQyfuD66Q7WG90OUxI5GMfIXRB+lGeCov3YKDkWSBMb7RCtFr2POFD0aee7xOvkUNJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286214; c=relaxed/simple;
	bh=Rqbvxj3n98trjlHdrE5VMKTk4FUqRBiiWZY/N59Lh94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpKuvlxuUHQrDxg0X4jtcLspKoHU1v6VflahhJSpVQv6CwOq4E+I8aGxh3KEVKSCJKbFdCXwV+9tFv7vstTmIZOsGXEFZ+1tLN0yVnLOY7a5dHXQoVakd0NztxPfeQK99Eb3JxnrsC+FAN0kHkZQWH07VadXsrE8stQ4TB4QLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rLERkQk7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5343e75c642so5559384e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286210; x=1725891010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFrr/vhtyUsBCEL3AzabuAYoE0ekzhv/EiMOJWFtnNw=;
        b=rLERkQk7kAP8nB0ummoWRmIEW+je1xsc2kNxCT+sZoRP2dnhT5yhq1F5Ij8hK/b4Ne
         t5t8R5VdF7E0/hZIr2uB2KUMJF1MG/EuN8Ze1G1mnBgMuhKEJDkC2eVXHQ7e4EEoFwrp
         PrUm7oDc9QBhN4gd0OftBL4b1hiInmURgIrx39+8TtXKiwvHenZYGT9g0mmyU1OP167Y
         N9mx0XSiqb2O2phSqnwXvbf01OLeNMuX5Pqyvm3qHNzV+kKH2lpRLh5b/gxpXWCw+uyq
         rDTJldtFrhBl459Cg7n5FIHR+z0WmYAPX138bXaNu8+ubgrfQiGbwxukwMdTQBwFg6bK
         0rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286210; x=1725891010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFrr/vhtyUsBCEL3AzabuAYoE0ekzhv/EiMOJWFtnNw=;
        b=twL0GyJbS2xVbMmeiYCUqDbMRBZMvyiuwjtmERpRliLHydiTdTg8lXHCHeeCFcUQ5O
         HCbnTEjcS/gnkCqYOuqKcFMUpvxqy2I0fmOmaq4Y//CYUfq655VzpXus4JPWzIMBErwL
         TESwNPu9OvYyGeSUylEX+lgSAfawyDnKzDW8ammuwne5Q2HEYtMvWUtXQrzMw9JGhSGZ
         cOq6ftYbo/fy3eLeD9q0ilUftZ0LR2RzWiVqd3W2VS2NfFneORVV8ixAmRZCTlDC4B1m
         okPfxnKq7tYSVCGyHdgZ+WcZtG0KuuRPC68VxudSMp6pOQUOkPe2cCX2dumjwDD0XnA2
         TZbQ==
X-Gm-Message-State: AOJu0YxAVMLR7efHjW/TT83YCaqYHVZerBLhIxuGFLHFW7k3D5JBUHux
	R/iC2PqVb+Hc+ezmWOWF/m7WLARDfEu4v+vIHC/axSowCA0TUiF+0qrnDfWJ3qE=
X-Google-Smtp-Source: AGHT+IFaO6dxlDDaiWFSdIP/UX9nluCBle4q/MSw8r+vz8yzTRdG1rB1gJ4tgPH4HvY2bPou2oAjug==
X-Received: by 2002:a05:6512:118e:b0:530:dfab:930c with SMTP id 2adb3069b0e04-53546b34ddcmr6403270e87.28.1725286210350;
        Mon, 02 Sep 2024 07:10:10 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f16sm561716066b.150.2024.09.02.07.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:10:09 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] slimbus: messaging: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  2 Sep 2024 15:10:01 +0100
Message-Id: <20240902141004.70048-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902141004.70048-1-srinivas.kandagatla@linaro.org>
References: <20240902141004.70048-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 4ce0cb61e481..242570a5e565 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -111,7 +111,8 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	bool need_tid = false, clk_pause_msg = false;
-	int ret, timeout;
+	int ret;
+	unsigned long time_left;
 
 	/*
 	 * do not vote for runtime-PM if the transactions are part of clock
@@ -151,9 +152,9 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	if (!ret && need_tid && !txn->msg->comp) {
 		unsigned long ms = txn->rl + HZ;
 
-		timeout = wait_for_completion_timeout(txn->comp,
-						      msecs_to_jiffies(ms));
-		if (!timeout) {
+		time_left = wait_for_completion_timeout(txn->comp,
+							msecs_to_jiffies(ms));
+		if (!time_left) {
 			ret = -ETIMEDOUT;
 			slim_free_txn_tid(ctrl, txn);
 		}
-- 
2.25.1


