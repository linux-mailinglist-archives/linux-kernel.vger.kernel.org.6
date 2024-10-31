Return-Path: <linux-kernel+bounces-390394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D659B7955
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FB51C23080
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C9199FDC;
	Thu, 31 Oct 2024 11:06:33 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA219A2BD;
	Thu, 31 Oct 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372793; cv=none; b=aGyuXuLLrS2Izsu1s/diLoDRzby1nIz3I4iF1VLibAYbv5vKMx1wfwQCSQ6T/d/9OyjMgKfl6PyWkfcy5bsxU8ZAdw5y32tJLxwzOxQ2q4i3GjPkareNj/lnUYRZzLNlQ5wY0SipUWB+tNdpgpWv81GMz1xpd4jWYIpsnRDzy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372793; c=relaxed/simple;
	bh=lV+EUJqfDWzyyQHAbyXR9EzAuRsGDjjqPtmGBcuuSbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJUP2V9w4yaDTqi03Cspt75RfDoT6H30zib6YFz+FwJA1vHsTlIP8+NtZ0FcPJmqYr3CC1QfYyHGKdvRtLZnR7MRsibwiZRxPVnbxMSyHUWEvfHSC1+U/oPe8USeGZIBycy2/Bxdvc7SWNM6NlOhPBxEaKsda/7trWsGUbe0I5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso1368725a12.3;
        Thu, 31 Oct 2024 04:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730372789; x=1730977589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+HKORyDDK+Axk/t+2gyImNFveSQGpvk9mihkiuMdmg=;
        b=GvmTF3botc6npH0fascdcEcwwfjmbF13J4li9qaufePLilnB1tqA/pJ8h04L2TicvA
         3ZNV9KwH0/ewNsrcFPynKpUZpYoC0mV8Ho2CZCJJlA3qDgJuPAPwDloMhvkCjVkoZby1
         VCb+G1gFaZRfJSjusd/HtnvL6cibaRXg+Wd1jBlZrUwYPrjQ2qBhpQH6UnwRlzcL0Jia
         SDEJ6S5RD18MAARXNdNyX0DPDPBC9zAkQ0zHMETLaDEC+6cIZ29DWLLNOScekVZyrQKQ
         yvfiXjMS7m7epj09d/Pt7ebw6fle543iU9zn3rNbpWact/nwnMHM1DGSIPyZEuRUhiaY
         lLmA==
X-Forwarded-Encrypted: i=1; AJvYcCU5f2MuxMHMIkune1PQY/kKz4bfHhxPim1L2LixRM1K13P+z8cDw3zOyQlw9bC2P22P6+/YkuRHLKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhM1UeH9hUbcGVFPCP7QfR6NZXBCBPUg1m1IZ+wwgOREgzdOOU
	NKiTNnC6lCj+WjTeNqfQn2SxZrVphC9AYYydfCcAoxMXHKUxsQ2xqarVEohr
X-Google-Smtp-Source: AGHT+IGWyWOZyNInhyM0WAt+Txz0HXH7fHoSSTd83QP6JLZTAaW+4dHTcUpMah8HS1e7GvvH59kU1A==
X-Received: by 2002:a17:907:2d1e:b0:a9a:4eac:a2a5 with SMTP id a640c23a62f3a-a9e50ba7551mr283173566b.63.1730372788915;
        Thu, 31 Oct 2024 04:06:28 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564e96a9sm54840666b.97.2024.10.31.04.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 04:06:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 31 Oct 2024 04:06:17 -0700
Subject: [PATCH v2 2/2] x86/bugs: spectre user default must depend on
 MITIGATION_SPECTRE_V2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-x86_bugs_last_v2-v2-2-b7ff1dab840e@debian.org>
References: <20241031-x86_bugs_last_v2-v2-0-b7ff1dab840e@debian.org>
In-Reply-To: <20241031-x86_bugs_last_v2-v2-0-b7ff1dab840e@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3259; i=leitao@debian.org;
 h=from:subject:message-id; bh=lV+EUJqfDWzyyQHAbyXR9EzAuRsGDjjqPtmGBcuuSbs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnI2Svgf4IgbrZMCTyQqKs5L+aCyzdr0oQlaAw1
 5svrL2h+DSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyNkrwAKCRA1o5Of/Hh3
 bdjmEACZiyPRGCQTN5EybwwTJKtu3r5OUhzaMKcawpb4C/v7hpeM9x+x1Ln+uKGhXPcAkeX+c8G
 fOQ1k+f0TRLWig3BXlxgJT9/5Qw8OLrl27UwKJhZKzqNL4dicnyJcNWMEWuLxhk4eYyjJrB5q8K
 gWZUencHkUbn1vVPb+S6uOKeJ2MaoK/SbcDAXImzFISJp2/UvY+mBDuIU+Iu24/OBSIr1Yko8z1
 6D9UccDSSv/BMAUSqnCDrzuj16cWU+9PBpMueHN9MDvnSQx1WYd+Hii4N/UFrbqfmUFF0w9pRZR
 4uRD3AKxPkOzyzoEJuMgO7wE0Ozd01M3lWB0yc7jfGJvfTD/oA0/FwwUta6nO4AdnGEwmPHSgzK
 y80M+qzBa97ImZg0Nm+XoULTVV/sDWmgqQt9ACR4xbo+xNdNmMs8y262wA/RmpXHkcGE1hB+nUj
 hsyb4wewrK7zRnIgMreRJUdz7+OTXcYPQQi0Sdih6B9mhCRwox2++UFEe8mBDgDmzxgH70SL4bQ
 7mtOMGZXfbUt7pQMO96EfPz+MUzYg1l4o6ppjeo10eT2eJ12QwfxQjdN9pQGEYSnsyHqySww3pl
 P1rG5vAK0l746VNt/sUDXb6t7kSLPhs1phayQv9ZripP1BDhjuC/Bsha5JnteQGA064IR1o6NCI
 zjkn2UcEAohLZiA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

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

When CONFIG_MITIGATION_SPECTRE_V2 is not set, users have the flexibility
to opt-in for specific mitigations independently. In this scenario,
setting spectre_v2= will not enable spectre_v2_user=, and command line
options spectre_v2_user and spectre_v2 are independent when
CONFIG_MITIGATION_SPECTRE_V2=n.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/kernel/cpu/bugs.c                      | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe2237f1d577df5656339d6224b769be..f8bc02cd10ec3012c478e12e90bad85d9f70d9ed 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6241,6 +6241,8 @@
 
 			Selecting 'on' will also enable the mitigation
 			against user space to user space task attacks.
+			Selecting specific mitigation does not force enable
+			user mitigations.
 
 			Selecting 'off' will disable both the kernel and
 			the user space protections.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ceaa5f0c742025a62aa564aaa9cdfa1fe86e681c..236c691c3fd2ac7d41c494d5c7fbc844d11ae82f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1294,9 +1294,13 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
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
@@ -1309,7 +1313,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+		return mode;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1319,8 +1323,8 @@ spectre_v2_parse_user_cmdline(void)
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


