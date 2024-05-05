Return-Path: <linux-kernel+bounces-168929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1D8BBFDE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A7F1F215DF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C326FC5;
	Sun,  5 May 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt3/q5eE"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9E6FB6
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714899435; cv=none; b=YZgLiLmSy4MPal/MyZXn0RSscLdnJWBw2PV/7HM2ETfXtCYySuIIDgjsS++GX6GlxDHkOuXus70L8ytcWlDS06Sk/8qJgd10saBxa2HmuylYlE5ChgoznLSbY3AfIhy/SJXOR22frQiaLOrOiKjH3paq9EYo+rUPm0V7yu1XMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714899435; c=relaxed/simple;
	bh=Ehg8SnP9d1v1mC1FVfoCaxTGw79pUSG6BVMh37zV3DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLbHhANB681Qkr/JR50uy9c0gnOFCaLVesSomBYoqDFkoFSUN8HaVLiWOzuC1N9cRKEHxeRj97t0AtqLSWtxeaTVL1l+0j8hBTNIn9TZBAScUFDQTgexiRBFuUCqslXw+ZUAHsWcJ6ZEC8Aq5nilkPcNUuWAHWZ5xt1SjTiUNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt3/q5eE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso4890415e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714899432; x=1715504232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOJc1LQ/uwTTREZFAQaONK1K4DlXlSIPSYXu4lxduKY=;
        b=Nt3/q5eEJYR72m3l/74QRWO/IwWb1FAbwdaagztPgR2szD5kryU4QFuX6x/bWQt9Sq
         oB+n5wWEbTXL9BRr3nn3ob4YwvzveOpPMsevkNp3ukzsS4k8CNAbTaQT9je3D2hMm7pz
         9TjwtshCuB2OWiB8866cFzMwLt/fyTMAaJ8IU3SXXBuVW3VYdfYO0wvKdJDdjKbNWAda
         JF+3x4wsoGg4gmYJhFx2zJFcYBrAto/8KCLrFvU2YY+TdjerA+zVl4JAbfo3JJO99Qt+
         FOMtBeNcEI/uBNKHTtun68DORHgSp0dRKmI4erchfkuB24iw0CTGNsU1sPW9js7nemgM
         Yh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714899432; x=1715504232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOJc1LQ/uwTTREZFAQaONK1K4DlXlSIPSYXu4lxduKY=;
        b=HeOfTTGORRko8Fmi6g8tHTCxIcISK/WL7u3elpprn/8JoRsWtR1IF8LlPDRLwG6q5X
         BTO7TnxK9LrHrszBCI+EeL+gnFouQXUXD41uMvMML1azrVSbbln3cKW2BHQBxfYdkU67
         2BmplGycqC3QMCWLjr9QCoIVsvx9DWh+4gvqReSEpCCVFDR2ew+e+FTHt5lTPvS98Zxd
         aRJ6sFutxADvOfAUvhyF/1SPB9/u/cv7EQ5HTJXYcfEr6nR2HZdD00Q3FcrWDYPXaiFG
         dMEXox32Y50LLsuAbJaMMAkSxjlNWO+uq+4TG3AOfGUKI+QtFg8x4T22mNCZsz569LWn
         5ydw==
X-Gm-Message-State: AOJu0YyoShqn2jSs9wrlmLSVmrM/PC/TBMgAiAkNy74v7/8wzZamdEr/
	e2SJGubUrIFL7yfDy10iqDgD+nqEQwyCQ8Pbw3eik+GSgP0piOxk
X-Google-Smtp-Source: AGHT+IFkFWzFBXPU8EFJp63RbN72TIii8CCC1G+7/lqJUT/HF82q0mlDjFPTmSjVd5DxGyfdSZG65A==
X-Received: by 2002:a05:600c:3106:b0:418:5ef3:4a04 with SMTP id g6-20020a05600c310600b004185ef34a04mr6338193wmo.18.1714899432163;
        Sun, 05 May 2024 01:57:12 -0700 (PDT)
Received: from localhost.localdomain (host86-177-210-156.range86-177.btcentralplus.com. [86.177.210.156])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05600c525000b00418d68df226sm15594986wmb.0.2024.05.05.01.57.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 May 2024 01:57:11 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: anna-maria@linutronix.de,
	rederic@kernel.org,
	tglx@linutronix.de,
	Markus.Elfring@web.de
Cc: linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH RESEND] time/timgr: Fix wrong reference when level 0 group allocation failed
Date: Sun,  5 May 2024 09:57:09 +0100
Message-ID: <20240505085709.82688-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240501195116.62669-1-ppbuk5246@gmail.com>
References: <20240501195116.62669-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tmigr_setup_groups() failed level 0 group allocation,
wrong reference happens on local stack array while intializing timer hierarchy.

To prevent this, Check loop condition first before intializing timer hierarchy.


Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 kernel/time/timer_migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index ccba875d2234..84413114db5c 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1596,7 +1596,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)

 	} while (i < tmigr_hierarchy_levels);

-	do {
+	while (i > 0) {
 		group = stack[--i];

 		if (err < 0) {
@@ -1645,7 +1645,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 				tmigr_connect_child_parent(child, group);
 			}
 		}
-	} while (i > 0);
+	}

 	kfree(stack);

--
2.41.0

