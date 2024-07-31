Return-Path: <linux-kernel+bounces-269701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51549435F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43699285E32
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D21453364;
	Wed, 31 Jul 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Flh1DjZW"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBBE1396
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452195; cv=none; b=dNR0RHPwQGioUsKiRgfJZoEinc7YlxQDkFgF+QEn+e+xldiX6GQ9eoaYP0diJz81hXluNCxor8wDx1ZgOqTivjqdmO7g/F3O8DN8zzrQTqXJkYE6+LipRxApCUvbXVOzjRkA8ZQQ/NapyMHUmGKKmlhH8XkCJv6cXXMpF1rlC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452195; c=relaxed/simple;
	bh=l06Trw+3iRTBRs3j5IRleAhPtXoufAxxUau3O9VCqp4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FRzHEn9JQdP8gfYiOmkysOQFb9saC6fT5RzMw5hGFvxeQvPCnfcdQocrjKgbAsmx0crD+IgFnOIoJwX+gGOK37WfSFonpfMdbhgHQor6qG9yzHZs0uQpeWQaH11zg3HFB8Tn3qCZiM6fhcKwpjBkGPleTbWRpvyS+vxPR5eyGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Flh1DjZW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7b396521ff6so1608195a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722452193; x=1723056993; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=h4Ojkr5aF2Di4n8s8q8PfYpJTOlPkrKn5tqBpphrbhY=;
        b=Flh1DjZWHElKgCI99PHrgmKaWXCyVSY+0G3wC+y1c7ehy9lC/MqyVS1iEc9LPJCMY1
         vnlGyX4XAsuxvCdrT75mKlBloytsbwHVcgRLeTd8S9MUKImWlTz7SX2gVMBRqeyz2idP
         ZHukXPJcrgmdF/9+0bbTwz28fn9Ro5CaPasQqmNce+u6eCjTXtXdjxlPdysX0UHY5KGC
         /dep4eeqfDrjpoDWaEoy6tjolulVIPZ14HGiK6BsO06ei+SCf7zD5hMiWNhGSl08a4zk
         k4UzY4rbJWSk/vmtPUn+cPgQOyVtais/22iMhn/bZhBH3O0EDT4wds3+DIEuGGGrsrhX
         OiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722452193; x=1723056993;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4Ojkr5aF2Di4n8s8q8PfYpJTOlPkrKn5tqBpphrbhY=;
        b=XCGdpxOn9rC4foH2SPgHCnr89E1zzsPgqT7aDmnaNfZyopvk7FsyVNog+pJY8mHGF1
         u5mR/lSbjlXeFurJXy752WlNUk+YBWhU3ozQqn7+GgboODzgCA9NpeKMz+lHbmu+pi30
         rVX4aOSrBRqBwiAgA83p5uGmonV+HdFBu+ny7nhwPg/jRNfzXb4shiMAWk13CMOp0cje
         Tu+Uz6T6fWh91ea+zxdun2TvV4fYnVANt1AKa1ZFVp+q2O9GFPJDpJxj6vkRsJf3HWg7
         QnRGsy17NviqbJAKLFaMtCgA/JwQ1WRIeAylUx2KgQrGYb5nIKmBmhpUHwjiP38THeNj
         /H0g==
X-Gm-Message-State: AOJu0Yxi9dVnwJ7RKxIZFF/YDJ7LVfN1SfwxL4bGLwF1qzG4NGJEiEbl
	xQZJvE0xJBUF9rBH3NmajN2FBNLuUxfG91aylgC7CXoLwEjDO+17T2FHQw==
X-Google-Smtp-Source: AGHT+IHYFcv2S3A5Mr7aGBusWeekP3v8CrhOytepslRNZMeoXH7FLI5jU8tymgkHmaE+zdz4hyXkvA==
X-Received: by 2002:a05:6a20:430f:b0:1c4:214c:d9ea with SMTP id adf61e73a8af0-1c68cee58ffmr507004637.19.1722452193335;
        Wed, 31 Jul 2024 11:56:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7104e5411c8sm1325432b3a.39.2024.07.31.11.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:56:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 31 Jul 2024 08:56:31 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.12] sched_ext: Build fix on
 !CONFIG_STACKTRACE[_SUPPORT]
Message-ID: <ZqqI349WxdejfXZM@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

scx_dump_task() uses stack_trace_save_tsk() which is only available when
CONFIG_STACKTRACE. Make CONFIG_SCHED_CLASS_EXT select CONFIG_STACKTRACE if
the support is available and skip capturing stack trace if
!CONFIG_STACKTRACE.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407161844.reewQQrR-lkp@intel.com/
---
 kernel/Kconfig.preempt |    1 +
 kernel/sched/ext.c     |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -136,6 +136,7 @@ config SCHED_CORE
 config SCHED_CLASS_EXT
 	bool "Extensible Scheduling Class"
 	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
+	select STACKTRACE if STACKTRACE_SUPPORT
 	help
 	  This option enables a new scheduler class sched_ext (SCX), which
 	  allows scheduling policies to be implemented as BPF programs to
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4334,7 +4334,7 @@ static void scx_dump_task(struct seq_buf
 	static unsigned long bt[SCX_EXIT_BT_LEN];
 	char dsq_id_buf[19] = "(n/a)";
 	unsigned long ops_state = atomic_long_read(&p->scx.ops_state);
-	unsigned int bt_len;
+	unsigned int bt_len = 0;
 
 	if (p->scx.dsq)
 		scnprintf(dsq_id_buf, sizeof(dsq_id_buf), "0x%llx",
@@ -4359,7 +4359,9 @@ static void scx_dump_task(struct seq_buf
 		ops_dump_exit();
 	}
 
+#ifdef CONFIG_STACKTRACE
 	bt_len = stack_trace_save_tsk(p, bt, SCX_EXIT_BT_LEN, 1);
+#endif
 	if (bt_len) {
 		dump_newline(s);
 		dump_stack_trace(s, "    ", bt, bt_len);

