Return-Path: <linux-kernel+bounces-206037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5890038B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE01F2772B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207A196C9D;
	Fri,  7 Jun 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6uvZMA3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD4195FF2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763229; cv=none; b=rXTKCbNfIevkxNuMf1MZUqezNCBgp0ueQ/ocqIK+qHLjhUDKv+S03oVdyhvtZBRsd84msxB+Xhw/P9PM3Gwi+NcVI27JGS+lrzag84IvLGcfglR0YKSvLzUCRoyz+rn2p6sRQg+/wK/DJMXWyFd8QzIITKEIkXP4EruYvM3Ap64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763229; c=relaxed/simple;
	bh=ijm0GPn/zaSIhGjFfkIwc3vF+unFOLisQCItbhyQnT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s17la/004vWdAx4qsB2N3QQlBanh15Q/p7tUUyn4fRZCel6aslJ8jO5GwQqjw3JvLJ120rGMdEO7Zrq17+2UIxbEf4ZovJYM7y4zOkIwRTYFxNelTV49UkBqws1z23Kbe3TdHMrOCPWF0vq0r8My3HBZovcrAL2n4+2pRjSTIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6uvZMA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8eSDPJOHg5XX+C6EnMgGjbvp60roI+VIhJqlmfxAK0=;
	b=a6uvZMA35XEzA353ewNPEItbdyzFyyK8SLmabu33RQWuXJQaYDT9KONsUiRJCvmWGsTVgj
	hOawZwGsksS1fw1GZz9zXRgmrRr81KRljUEg06cNbTHjPnybXInI2iIgFIc/JN2XsqWaRt
	ZG1f+AjTdfUbXyzYg0FKGnWw23OxN2A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-_srFBKt2MY6fPtJK5GGq8g-1; Fri, 07 Jun 2024 08:27:04 -0400
X-MC-Unique: _srFBKt2MY6fPtJK5GGq8g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c1a23d1382so2006651a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763220; x=1718368020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8eSDPJOHg5XX+C6EnMgGjbvp60roI+VIhJqlmfxAK0=;
        b=Ax4R2fgSg38HQp/6sDyVZSjsYO7+VxlNXBtz2YYiQ4yHMFgeskKbotnVm6OiUJ1cBv
         xy/j9WP8G/CabJUvGf3BTUyryPQ8B8wthk+7+8EGoe0zNsAwvRAAG3enZ5NsL1H5a89S
         L24ZGp4cNzy/Sro09QNxq+3iiqsCvNeHspnbvC75zGKSUXcGFu7fDn6WVGhvLxTqX153
         iLD2D0gLpvhW6On11fQZ94d2+WAPRNOtt10Zyzwi7Ao+3c4QNTenp1bO8nkrTubYOqTg
         PZ5Z2oOpgkV/72026MKiKFeZjMV/5Bmsbi8e86WCMBiqQrFTfTAsrvs6jwuHKaRQx4R3
         4iXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy3rZ8mpvoY/wJUIuQTiAX49Y7nILLRNHCfyxDFlKxxdmm77BtGxxT6lRymBtzFYdF+3GSjffAMgKWubx6P/hI+Bteh3NStLJgY/Cp
X-Gm-Message-State: AOJu0YxE3V/mh7zsfrMqnv2/iKejZfvpLOMHP1fEV0g1eo6lZtuAQ/aB
	Rkt/J2S25ihz/zdRpdR/UOPwdQ+5OZ9f5hUB3Cgt88F1F6mgDLXOvc3Sne63n0/n/DNaq4eRchw
	4yR5H/Mv75+s5YeX9xFPlEJFa3bZVng8RkpM9Ut5mURUp3RdQNaW9qUL4119+oDBwm7jUXShAz6
	It8g==
X-Received: by 2002:a17:90a:c68a:b0:2c2:d294:4b37 with SMTP id 98e67ed59e1d1-2c2d2944e21mr159152a91.16.1717763219595;
        Fri, 07 Jun 2024 05:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw9d3+j4Qxyr3iy7YrPWSmR+eC0E/vLf1RLdGhWBQep6818IZh3UHaedUhxP520TTrHOJycQ==
X-Received: by 2002:a17:90a:c68a:b0:2c2:d294:4b37 with SMTP id 98e67ed59e1d1-2c2d2944e21mr159112a91.16.1717763218929;
        Fri, 07 Jun 2024 05:26:58 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806cfa57sm5342060a91.49.2024.06.07.05.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:58 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Fri,  7 Jun 2024 20:26:16 +0800
Message-ID: <20240607122622.167228-7-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1st kernel will build up the kernel command parameter dmcryptkeys as
similar to elfcorehdr to pass the memory address of the stored info of
dm crypt key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/crash.c           | 20 ++++++++++++++++++--
 arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f06501445cd9..ca7f7d44a433 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -266,6 +266,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int ret;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -274,22 +275,37 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	ret = crash_exclude_mem_range(cmem, start, end);
+
+	if (ret)
+		return ret;
+
+	/* Exclude dm crypt keys region */
+	if (image->dm_crypt_keys_addr) {
+		start = image->dm_crypt_keys_addr;
+		end = start + image->dm_crypt_keys_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return ret;
 }
 
 /* Prepare memory map for crash dump kernel */
 int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 {
+	unsigned int max_nr_ranges = 3;
 	int i, ret = 0;
 	unsigned long flags;
 	struct e820_entry ei;
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 
-	cmem = vzalloc(struct_size(cmem, ranges, 1));
+	cmem = vzalloc(struct_size(cmem, ranges, max_nr_ranges));
 	if (!cmem)
 		return -ENOMEM;
 
+	cmem->max_nr_ranges = max_nr_ranges;
+
 	memset(&cmd, 0, sizeof(struct crash_memmap_data));
 	cmd.params = params;
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 68530fad05f7..9c94428927bd 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->dm_crypt_keys_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -441,6 +445,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret)
+			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");
 	}
 #endif
 
-- 
2.45.1


