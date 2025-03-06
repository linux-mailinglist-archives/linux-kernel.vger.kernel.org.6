Return-Path: <linux-kernel+bounces-548688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB7AA547FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C667A75A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19790201034;
	Thu,  6 Mar 2025 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="axeY+C2P"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF7208989
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257486; cv=none; b=SlgB+CMVhDkLAiJQypbDsvoFjLggREQYDfyDJVzrheWcxAbiu7uI7qg8g3zpGdKeRVySERx98/jnmIQnEc7o8MaMN0aXfYauC2Ss+sFaIhzYKdCDwUzqFSUhmz/5FTlFPwTzMYXpBGZ7PIfbyDmwv7dMn3txnNDB+Y7MXcEwK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257486; c=relaxed/simple;
	bh=h1cH28RnxJqZ0laSafVMaBR35QK3+q622jKde/EWIGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyvriN64qrtixWBfcIZflVCCBFIzesehHDvJANLIXFxW8vCocad51yR+opp3KK5XfC3fSycNJekZW9A7556+RNEah6Yg1m5Mn2DW8yDxh1AIDWmRoaKwrRL/3cuo3t6WiXtVUaVmtvkUmsGYWLzWLSe0pujQNIt/QjFMccnPbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=axeY+C2P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394036c0efso2690735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741257482; x=1741862282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYXCLPdOGTSqqbn+ENL6UC3+xBy0sRKQUeVNbBWV4jM=;
        b=axeY+C2PCh6xMn9FCz+pkTRlNa3gY8Dnrn+8x0/vlYL0KNAz7MnWBsARoSfknJlxz4
         umcOIUOiVN38F66CfbEuNCOf8uSitZ2eFWwZpRavEQ6oqoA+eL+xP12Cm4q46yU9QNgl
         VacHOpqZSm6YrMLCTQAvoxqTIn/e/v9BaYr0I60RifYHDoWVQ/9qbvfyXyetQQLM3RA6
         Z1NYbonCD/AVfyMCqPechs/msG/0z+1gS5R8vz5yCMokod8WevWNYhgGmxBS0BbRk+z1
         NOzdS7cRmJLzL9TbRPDQGrRTwt4p2TBKp4SbudGdmFn1FpUGPEYCgPSpHHGZOlmhS8ze
         dzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257482; x=1741862282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYXCLPdOGTSqqbn+ENL6UC3+xBy0sRKQUeVNbBWV4jM=;
        b=KHAQ0hZql7AK7lkFDG5+uQghQx9+H8dLkRVuOFGubOU/m6Nkgzprd98ZSOO1xZUb//
         cgbllFUNGLQ5u85I4QudQsThnMgmj6DuTCqXT/gCUWCxXSBoCfPlNnWfRR27e2CIgulM
         HUjQEcOW/eFepzefwWy8fjC8prFkpFxrHorFcDgQXt9MXgbyfCRG4s2hjMpaEoOdYhVw
         oZ6vtgvHCnFtGnrzMHJQgYwJte0vWbDaKqJKV2E3uOVzAaAYwM8xSzoo1Kd0n4CiJv67
         B6Ukbxod3hKUD6KmEK2p/WcrjD0x5uU4LBovggeL9N8BT7moYqo40XnObYbVlgqfIgkS
         0/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXXXweRMLfVVhvtDmwyLj6SgaJPt/8/5mZtkXpdxdHeNC5r0IQOqFGq6W5tcPdrB86Hugpesa3GveAncVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5uRE2aiM4nVkBpPwcPytYg1cDiFxize3DV/1BgiPbGCA6sm2s
	7gLQUtaIOjZ9dMIWP5GsKjhJlFtoYtHUARIDKrH8EtkHlHxFT4fUDUu1lJtlwXk=
X-Gm-Gg: ASbGncunXux62TgjpjbnA9DmADdq1eYfg6w0LF71F+VJ9PfFmnkT0MFvnorlZoWR4Bu
	sL1MUCW0QS5ecQMQysaI9PsDW2wxFIP2MlSBYmDYUXPkjlI2WgQcqP2Nb/bVWC9V596q8wEb+Pt
	DwO5OobadgN92y8uS3a0VBzieht9tRKeJbaEq3M9PjOmN1HIa/LavXT0ovufrreWPNY0AveesaL
	IQBwibUGQbTq9lKxiu+Sq3j8vDYbyXVCxWnlu81nmGwlbpOH/dJjSdG7ORtMjvZvgwJv/MXN2ox
	wY+0mlQqWiZFl/uCVy9KOFgAYtTYujOtW6rEOUaGFUH9SoxO
X-Google-Smtp-Source: AGHT+IF4Yk8mL/PWY9vwvySrg1rq2xp0zWk7mLV73I7qJzzkk6N/FGrhmeYnuVM7QebMZOIhoeRMzw==
X-Received: by 2002:a05:600c:3b2a:b0:439:8346:505f with SMTP id 5b1f17b1804b1-43bd29b4d11mr47266935e9.20.1741257482533;
        Thu, 06 Mar 2025 02:38:02 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd93ca9fsm15566305e9.28.2025.03.06.02.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:38:02 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Taint the kernel when write-protecting ro_after_init fails
Date: Thu,  6 Mar 2025 11:36:55 +0100
Message-ID: <20250306103712.29549-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the unlikely case that setting ro_after_init data to read-only fails, it
is too late to cancel loading of the module. The loader then issues only
a warning about the situation. Given that this reduces the kernel's
protection, it was suggested to make the failure more visible by tainting
the kernel.

Allow TAINT_BAD_PAGE to be set per-module and use it in this case. The flag
is set in similar situations and has the following description in
Documentation/admin-guide/tainted-kernels.rst: "bad page referenced or some
unexpected page flags".

Adjust the warning that reports the failure to avoid references to internal
functions and to add information about the kernel being tainted, both to
match the style of other messages in the file. Additionally, merge the
message on a single line because checkpatch.pl recommends that for the
ability to grep for the string.

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
I opted to use TAINT_BAD_PAGE for now because it seemed unnecessary to me
to introduce a new flag only for this specific case. However, if we end up
similarly checking set_memory_*() in the boot context, a separate flag
would be probably better.
---
 kernel/module/main.c | 7 ++++---
 kernel/panic.c       | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..8f424a107b92 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3030,10 +3030,11 @@ static noinline int do_init_module(struct module *mod)
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
 	ret = module_enable_rodata_ro_after_init(mod);
-	if (ret)
-		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
-			"ro_after_init data might still be writable\n",
+	if (ret) {
+		pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
 			mod->name, ret);
+		add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
+	}
 
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5cecb2..794c443bfb5c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -497,7 +497,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
 	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
 	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
-	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
+	TAINT_FLAG(BAD_PAGE,			'B', ' ', true),
 	TAINT_FLAG(USER,			'U', ' ', false),
 	TAINT_FLAG(DIE,				'D', ' ', false),
 	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),

base-commit: 48a5eed9ad584315c30ed35204510536235ce402
-- 
2.43.0


