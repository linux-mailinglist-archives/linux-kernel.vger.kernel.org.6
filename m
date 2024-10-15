Return-Path: <linux-kernel+bounces-365576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E293F99E48A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6194EB23A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA281EABD7;
	Tue, 15 Oct 2024 10:51:27 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B11E377E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989487; cv=none; b=m0zGnbA7MqUqoPmTS3qcjGWfxCkWTh0xXuwiJ76N7oO3vDq0N/Xrh3sKV+Q3mIoOJsRYU2whjkAYMOC9NKL95mKKFNVbmTX8279IA8fnqA4jLjcJCuzz/hT91Vb+sGBbTGacWhs+QegJ76YaNoqMlDCzJAqSOxCsTEDKfB9ekao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989487; c=relaxed/simple;
	bh=9GZgHLphi5Wk4HmWN/Gm+S5zsftBa7bRNsvRGrRRmL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjmAD/MPRgS6YttFQ7wgUALwWjs1wO9D7G03Ixz1Bs+zRag2tVoySBOhr4cSxWxFpyRGweiVqbLYqjMp1lnndT2S8yjXD2ZdOOnfxO+9niiDIXHTAXw5j9avBqxpzz3zO6PWz9fz1dSsJTFIvgp+I9opJ0YY4wpTIJPa2Ym2N94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4311bb9d4beso34961855e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989484; x=1729594284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kvs4LqINVgBhaSBAT3DZgAdv6NUP3/EwAoWMF6a1O7M=;
        b=XlY6MKRfKWf6h5xfjlwBGc84iF2xEjcTum164McGVdD6wpn/sq1fmhBMKLPpYJSN+o
         GpqbHOiXqPrAn50tUyNjclM7MgceBDAgTz6SWDhOlIIwaWGdO8pMlfNT5k6xkin+OD44
         9wEimJIxHJ93rxgezIEq9K38f3JnpKza5a3o52bYwkGognKowH2tNSYsArdjRWrKeXHL
         KEWCuCarmLCzYwKQCzrlGU21yU7Tx/vaQj227CTs4w8Ol1UFAwmdVOm9lrpzGMKj3c+9
         B41hNt+xOB2i9agNVApN1izgVcjPJ+FwVTk8u81m/bwdqVvW7JuJCpyOrnP185bSdvnX
         b5yw==
X-Forwarded-Encrypted: i=1; AJvYcCX8j+nRNNYIae/qyDWYJWmy8o0IxHF9FLek5wsqpVWz4oy468L9+WJkDpoHZ5sdgVs9lI6TsnJrkpLfeWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznlTqKeU6hxaVyfChVd1GiaSnZMRKHj+j+kHf1ojrxYBjUUHiB
	w2usTMGuNQln9KJ2pPxhKmJfakDRVbcZCuPUHpqYCA0qw3ZoOVzC
X-Google-Smtp-Source: AGHT+IEwHPS3iHYo8pijwkLDsdDwhNILMyZpgoa9CuaZDjtL+cklX5ongFxs+cHJsA0PAjOFXMp4NA==
X-Received: by 2002:a05:600c:3496:b0:42c:b22e:fbfa with SMTP id 5b1f17b1804b1-431255e765amr101656005e9.21.1728989483296;
        Tue, 15 Oct 2024 03:51:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf8228sm1247443f8f.81.2024.10.15.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:51:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: bp@alien8.de,
	x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/bugs: spectre user default must depend on MITIGATION_SPECTRE_V2
Date: Tue, 15 Oct 2024 03:51:06 -0700
Message-ID: <20241015105107.496105-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241015105107.496105-1-leitao@debian.org>
References: <20241015105107.496105-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the default value of spectre v2 in user mode to respect the
CONFIG_MITIGATION_SPECTRE_V2 config option.

Currently, user mode spectre v2 is set to auto
(SPECTRE_V2_USER_CMD_AUTO) by default, even if
CONFIG_MITIGATION_SPECTRE_V2 is disabled.

Set the spectre_v2 value to auto (SPECTRE_V2_USER_CMD_AUTO) if the
Spectre v2 config (CONFIG_MITIGATION_SPECTRE_V2) is enabled, otherwise
set the value to none (SPECTRE_V2_USER_CMD_NONE).

Important to say the command line argument "spectre_v2_user" overwrites
the default value in both cases.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6d3b61d7be9c..c21ff072e048 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1277,9 +1277,13 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
+	enum spectre_v2_user_cmd mode;
 	char arg[20];
 	int ret, i;
 
+	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
+		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
+
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return SPECTRE_V2_USER_CMD_NONE;
@@ -1292,7 +1296,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+		return mode;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1302,8 +1306,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
+	return mode;
 }
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
-- 
2.43.5


