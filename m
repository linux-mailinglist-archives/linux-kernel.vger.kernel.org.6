Return-Path: <linux-kernel+bounces-311134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB59F968544
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087161C22CE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341317DFFC;
	Mon,  2 Sep 2024 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpWWlHVK"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BEC13B5B6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274143; cv=none; b=dQ5lKqFCWFUsqC0jNUZuSYWn9eEaZSnd6IeWTEUaPcyLjoUS1jpxrNQmSnE5SCxgGAqd1OkwKPtq5OgEns1AvtRx1Y7Tr30OErqRJJ/dFr6ZbI1fPYoCeuFOq81nmDD+/6h83mdknbPOk3HsHyJV5ruQRhffPGEvKrR9ScCY9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274143; c=relaxed/simple;
	bh=llgRoGRfUPyr3z+hUejB0Hzdxn0OmeuTOZIYLzimPeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2r5GHL++x+iSAtOJBcZNZnrkcaJrH5FnrP5zt6qw95DtMelUDTUNuQvEZg/5+ioNDRPjya3L3qTUNPgLUKsijlpWlIVGdtgJa8/gpFR0EvTxof0whZ68Joo7x4kbKBQT/HDDYUqQ3mRuXxzp43Hn80GKiLbFlgnJiXom50/JvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpWWlHVK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374bd0da617so1275634f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725274139; x=1725878939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YE8GOg9eP4fkXCl3LYIG8YV0ZpzhTauCmnYmtO/s/Yo=;
        b=BpWWlHVKlQC6jL3dHUcplWWEMUlkLp6/p7vpDLlI326pkh2v8FRNGWo7K7QEqEMZ8Q
         HLJjV62s+XTRTaNxhO5fsGpE2Fr/8kVKM3KNk9FENbBI8Dx+vo36/76FzUGLI8Kq5+KG
         r7xXAOHeBoKDO8BYBHr88ClWE1oSXabbUn6E+g+CWrwE4lK7AGt553RAW45RDlvVR9hX
         fnqV/VrfPbAbGYvU8WkLws9ghdYY3qGJ9PXLrxi6HQzR8hhPOoQX/Z8+bwjZJVITuniq
         STG/U+Nnv9SDzocUfuFdlMSD/YCYy1J8vd2vvBsMXSjJJlyStbaq/APWkxWdn+6yvzL7
         f8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274139; x=1725878939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YE8GOg9eP4fkXCl3LYIG8YV0ZpzhTauCmnYmtO/s/Yo=;
        b=NTHFdYfJWpEDWaVoPJyNn58wlO1VZn3S5LB4ihv0ZizOF0iQpSPEZGmJuEbAxN3Nio
         c1QX1qb1KtRocUVJpHWLm3RZmnI9+0dCSbx0rGZb8xo+X0iBxnU+eHUdN947aWdjzME0
         +r7zIjEiK7PcR+AwTxR3Y352ZSlouZ66FRViT4Iz5tt+vY8LDZYkgeYwdRuVXufy6AS3
         KKUMTxRYFRYtYvlyujKLZdhpaQe4bfV53sNPOBlGts1oeWyBEOZBMh8awccG7G4zcXJf
         BmidzKsG1vqODAxMZrx3KEckn0FJuCnoCbLMmvOh9/5KG3BOuLmuXxYvk5ZHlwE32+9T
         FkrQ==
X-Gm-Message-State: AOJu0YwHAeYN/lDno2NECegioFSQPCx+eQz68irh0y95yzDHlYMvBTSL
	MetS70jh3n9+jJn84tvy97rK7shah0aU5Msyh37abE0G7Q29JihRcKh+oMv4
X-Google-Smtp-Source: AGHT+IG3UKwqb7s1jRdHp22n61Molwkn96iR+sRXDPE9myqfNqIjlngMJn2R94nFu983Ut8SamK6yg==
X-Received: by 2002:adf:e262:0:b0:371:8a70:b107 with SMTP id ffacd0b85a97d-374bcfe5eb0mr4595246f8f.49.1725274138118;
        Mon, 02 Sep 2024 03:48:58 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4ef35sm11041076f8f.13.2024.09.02.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:48:57 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rich Felker <dalias@libc.org>
Subject: [PATCH v2] clocksource/drivers/jcore: Use request_percpu_irq()
Date: Mon,  2 Sep 2024 12:48:04 +0200
Message-ID: <20240902104810.21080-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use request_percpu_irq() instead of request_irq() to solve
the following sparse warning:

jcore-pit.c:173:40: warning: incorrect type in argument 5 (different address spaces)
jcore-pit.c:173:40:    expected void *dev
jcore-pit.c:173:40:    got struct jcore_pit [noderef] __percpu *static [assigned] [toplevel] jcore_pit_percpu

Compile tested only.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rich Felker <dalias@libc.org>
---
v2: Also remove this_cpu_ptr() from jcore_timer_interrupt().
---
 drivers/clocksource/jcore-pit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index a4a991101fa3..a3fe98cd3838 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -120,7 +120,7 @@ static int jcore_pit_local_init(unsigned cpu)
 
 static irqreturn_t jcore_timer_interrupt(int irq, void *dev_id)
 {
-	struct jcore_pit *pit = this_cpu_ptr(dev_id);
+	struct jcore_pit *pit = dev_id;
 
 	if (clockevent_state_oneshot(&pit->ced))
 		jcore_pit_disable(pit);
@@ -168,9 +168,8 @@ static int __init jcore_pit_init(struct device_node *node)
 		return -ENOMEM;
 	}
 
-	err = request_irq(pit_irq, jcore_timer_interrupt,
-			  IRQF_TIMER | IRQF_PERCPU,
-			  "jcore_pit", jcore_pit_percpu);
+	err = request_percpu_irq(pit_irq, jcore_timer_interrupt,
+				 "jcore_pit", jcore_pit_percpu);
 	if (err) {
 		pr_err("pit irq request failed: %d\n", err);
 		free_percpu(jcore_pit_percpu);
-- 
2.46.0


