Return-Path: <linux-kernel+bounces-169293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6A8BC666
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C50C1F21FDE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D85343ACD;
	Mon,  6 May 2024 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0aJtJUV"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF33E462
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 04:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714968665; cv=none; b=mfof/giI71FKo4VctV0/+2mjYjsT5l+ujg6RzG9SZbwXuA2nSk2iaUcBl31SbwXCrCqyYwdX2UAiAA2t92pK1TYsBEv7CanlknC57EvlK8djoa0ZuTdiWF5BtYX9wwpwxWm1ZuqJL7mu0mjF0gFePI9wsZVlojNTk3hiciPFGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714968665; c=relaxed/simple;
	bh=mdlDKnLF4q2AD4WMVa17WbpDpgJPxnEo3fzjs+83oJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWRAuT05XDeVM9fkJF59DXOoPmScADdvGfVSm/YW4TVwX3KnWDr/ZM+MmLyfFbUW+bpZbqONKJiefVYNy+ITSh5sEMzQGpXvldSQZY6xGGnfrr7Gkqytlnavyda8bSfNPuyaXyIWRC+1u4G1vInb7X6d7jsnRem6vJSQEjEsWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0aJtJUV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f60817e34so1607039e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 21:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714968662; x=1715573462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOzlmKhadoILI75vbecom8goSQt+hbRUXma6brS+FpM=;
        b=P0aJtJUVcBC9gtG1pF4ghTmThx//APh5vqzncghh7LPc8JkxogF0F9TiW1BTM5mCdf
         egGzjqc2C0D64sOCipcb0gDiJcD0GWB/WwuHnNny/f2Lv6Arstf9FrWuDO3el9uCm2nL
         ziO10z8JxvjW7OfXHjIM6yPavMnxCd15NVlG3Jx/2fmr+2ER+NGPgEmMZZtIRWAKCvlL
         w0uIKf48hpCYH1/BqO/yMax4fr/ggbRtN93e9hwaDe5GaoaW1J5A41kk0i81hyQZdoUf
         +eGQAmDd06UE/pF+fQX6UGzHOJ9jWtlAEeA7yhet2GK8vu6KP8pnEsHUnzAdskWrMhoX
         OkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714968662; x=1715573462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOzlmKhadoILI75vbecom8goSQt+hbRUXma6brS+FpM=;
        b=hKtLsugVgjv/9TFe3mQHC4cXKqOqKtXOOwD4y2ox+1qz5e9cOzDbxUElVJMGOFiMjk
         Q3P3mRCBFrKL48s2C6oFhSzTZR9PEyUnqkOraRtaIhTV/sgAQ/Zk639gzKKOAkavuIsY
         lfCVnO7IeOJpAe0z8+Ut8rKR7k/1KXB1i1HOZUoTaRF+O3u6gsef+RIJaTuvdxnLzKCz
         lYUKidbr3X8e5d5zfVcQOdkBng/Tj3SM7HAaQzDyriltt6E+VBRZM7OpFvPnfOWt4COg
         a+OC2gj/qnWSbIJKwMH7H0N7NzH2LgWKkHYwT1q+CVIBgGFYjroEZn3riD51sB5X3WI8
         /fEA==
X-Gm-Message-State: AOJu0YzrmLWEL8JDY4iCVTmgvBTpxqPfCKoEQb4LrVyqVWUJApjPx88V
	KL2P+/cWtEn+x/Uf1xfpK14kRvm8WQX3CmTS0xYykZRijLxzyRP7BF4rIg==
X-Google-Smtp-Source: AGHT+IEwPcI2ITyo71Xd4NOa/7T5Vkma/7FpgrgLLmRAEhzgYSHDVpE3hYa/Df8FnVDGOSsQcDrgJA==
X-Received: by 2002:a05:6512:32c4:b0:51d:70d9:f6ce with SMTP id f4-20020a05651232c400b0051d70d9f6cemr8275496lfg.53.1714968661717;
        Sun, 05 May 2024 21:11:01 -0700 (PDT)
Received: from localhost.localdomain (host86-177-210-156.range86-177.btcentralplus.com. [86.177.210.156])
        by smtp.gmail.com with ESMTPSA id p12-20020adfe60c000000b0034ccd06a6a3sm9621047wrm.18.2024.05.05.21.11.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 May 2024 21:11:01 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	Markus.Elfring@web.de
Cc: linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v3] time/timgr: Fix wrong reference when level 0 group allocation failed
Date: Mon,  6 May 2024 05:10:59 +0100
Message-ID: <20240506041059.86877-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240505085709.82688-1-ppbuk5246@gmail.com>
References: <20240505085709.82688-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tmigr_setup_groups() failed level 0 group allocation,
wrong reference happens on local stack array while intializing timer hierarchy.

To prevent this, Check loop condition first before initializing timer hierarchy.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
v3:
    - Fix typo.

v2:
	- Modify commit message.

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

