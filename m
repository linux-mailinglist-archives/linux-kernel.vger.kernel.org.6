Return-Path: <linux-kernel+bounces-287586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B5A952997
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4586D1C21D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC090179965;
	Thu, 15 Aug 2024 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4k7Kb3J"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B541AAC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723705430; cv=none; b=QdcCz4w1jl/h+inBs+UnoCQXUSmYhbCvd21TC7MWGmhdH9EwlScJGE2KUmkZpGOEtXtzJLd/ieIox4kDJCRXCdneumfsNemNB2hf1Xaaln/dmsFs+NHgyKagD346hrIPFRPvIHLlY/pv8di30ek/xZC6e0rwI9bVvAsCmLAh0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723705430; c=relaxed/simple;
	bh=u9bm+Qbz7C1qqs7i+bygRTf07niYCN8se11qivTSqdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPNDEJLlvMB6GDerF0JKpnrXSkxo1Qe8pNrjOyOe7airwbKLyiYRDsCXs+Tq35OVlyhpgm5C/FRdfXpeRM36PuPqpuee/QxqeG+1NCscgobeJJsb7MESkTz4Vyahvy/yaREPm291zBk5mpl8pjFO0y1p/+u7C1aHYRqQ8ljzC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c4k7Kb3J; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso480361a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723705428; x=1724310228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYFHnzZlE2z4I8OeUtVxhxbrKXDVuacQCP+ip3UxGoE=;
        b=c4k7Kb3JOP65unCurne9x0A8gYXfhIxRgGWxiQfNlLCk2nIwlijdedb5wRW4hSFBHh
         nG4Dbd3fmKHJQo0bFQxHIHDFdn63QZCFoAzKmGA8VoigRNVBQPL3gzDfk8dolP+2vOqy
         1NHWh49LNXZwibLHpc57U9S7DA7T3ZrejQ9rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723705428; x=1724310228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYFHnzZlE2z4I8OeUtVxhxbrKXDVuacQCP+ip3UxGoE=;
        b=c/16z/8l1Ux0BRRAz2hPMWEvdRvXatpkgepK98+XY0w5ZB5BCZUQ+SdXrlmLZUa62N
         OaoRZwlllfTGTY0J3k6rz6oH1rvj1vbWajbP99Z8/F14RTWjDZjSWpQmPkYadEosypYL
         aA19j3GwH1MeC7dmSlNo+fatefwZH1SkNtJJhmfEwtTsN5Ub5j+S621o/Zm6r1QTCNeq
         d1Y7vKYeKnW3k4OtKP/I7i39VjavUGA9aYzoLPRrw3Y/4mO9ddftuwsB8FQozy1GSd2l
         KkMJSaT4HZWuc0uobNtERZljIf7Moyt3F7F/LBDLOTpTGGM3yEWUUB5eVvpEwGcQdoIM
         hwyg==
X-Gm-Message-State: AOJu0YzwcFtjRHfxFD0woOP2qgad2LC/4lt1zJV4wsSiAW9QtNTJViA5
	qTDwiNCz2VU5aEMG+lJswXsc3kf8u2xbMK452ekJHoWrsj0zO8X4HuPP36+luVmfM5wylq71Bal
	7qw==
X-Google-Smtp-Source: AGHT+IEVK6nCe3/OnasDn5TjKoMRKafDu7iebvGM8IM8gyfpU91F8Vh8UfTXNTlpvaqIFMKoARrNtQ==
X-Received: by 2002:a05:6a21:9212:b0:1c0:f1cb:c4b2 with SMTP id adf61e73a8af0-1c8eae4b51amr6837510637.4.1723705427741;
        Thu, 15 Aug 2024 00:03:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f7dc:2307:3c4b:963e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b636bcabsm577829a12.90.2024.08.15.00.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:03:47 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue() error
Date: Thu, 15 Aug 2024 16:02:58 +0900
Message-ID: <20240815070339.346160-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wq->lockdep_map is set only after __alloc_workqueue()
successfully returns. However, on its error path
__alloc_workqueue() may call destroy_workqueue() which
expects wq->lockdep_map to be already set, which results
in a null-ptr-deref in touch_wq_lockdep_map().

Add a simple NULL-check to touch_wq_lockdep_map().

Oops: general protection fault, probably for non-canonical address
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
RIP: 0010:__lock_acquire+0x81/0x7800
[..]
Call Trace:
 <TASK>
 ? __die_body+0x66/0xb0
 ? die_addr+0xb2/0xe0
 ? exc_general_protection+0x300/0x470
 ? asm_exc_general_protection+0x22/0x30
 ? __lock_acquire+0x81/0x7800
 ? mark_lock+0x94/0x330
 ? __lock_acquire+0x12fd/0x7800
 ? __lock_acquire+0x3439/0x7800
 lock_acquire+0x14c/0x3e0
 ? __flush_workqueue+0x167/0x13a0
 ? __init_swait_queue_head+0xaf/0x150
 ? __flush_workqueue+0x167/0x13a0
 __flush_workqueue+0x17d/0x13a0
 ? __flush_workqueue+0x167/0x13a0
 ? lock_release+0x50f/0x830
 ? drain_workqueue+0x94/0x300
 drain_workqueue+0xe3/0x300
 destroy_workqueue+0xac/0xc40
 ? workqueue_sysfs_register+0x159/0x2f0
 __alloc_workqueue+0x1506/0x1760
 alloc_workqueue+0x61/0x150
...

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/workqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bfeeefeee332..59bd2c1e55af 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3870,6 +3870,9 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 static void touch_wq_lockdep_map(struct workqueue_struct *wq)
 {
 #ifdef CONFIG_LOCKDEP
+	if (unlikely(!wq->lockdep_map))
+		return;
+
 	if (wq->flags & WQ_BH)
 		local_bh_disable();
 
-- 
2.46.0.76.ge559c4bf1a-goog


