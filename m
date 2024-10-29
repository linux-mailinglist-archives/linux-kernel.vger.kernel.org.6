Return-Path: <linux-kernel+bounces-386326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA20A9B41F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08ED1B21FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1B62010E4;
	Tue, 29 Oct 2024 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgMDRuHG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923C201005
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181188; cv=none; b=RSsP4RyC+GUPZACBeR1501TGwZCWI9BYgoZhxST210I0MegZdpZnYUYXK5WVVyjfGHfvMavnYYu3giIC6kxRve5Hkwmay9FxtdRaA8N0WU1JExsqoqYUdh6eeV5u1cPecjIekwjjRYRPmSDol4J0r5Tojmnx7d7gC+czlKg3kqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181188; c=relaxed/simple;
	bh=OGf1IBa2xW8q/phmDcwzFethFRTNER1r47OWYEHFXh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHl2puyOQJtLb3PMpuX2zTtXYLHBvNYZ7+L/qQKZOPpDQkX27I8pOnAZ85Kzk7yKc5sCuAuTxJVzrTrmESseThUyQ7VNowfo0w+4fV9zhu1DQJbE2tLvm2nGUofjoHLYZclSEV+qMk8BoFS+Toq2wwyCnCQCA/1BRwPGOSHXW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgMDRuHG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxN33tdMukhisw/yIqoyNXhrPQQ42HlFh3ca/0Qlc2k=;
	b=AgMDRuHG0p36RTHgA33nLxhId1htH3rj7wPCCX8AoRCH8hjVgBfAWuucQBqBh1n825GiGW
	Md2RTelEypK0mVa/QiuLpGNVQt+Ts+5+h5MZuQrNsYkqM9CGU7ZknRX06wzpml6uQ+uGKv
	UY4sZF85brueeXy3ABbSJywQg0UXShA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-X4smrvfBPPi6LX0K1I3B0g-1; Tue, 29 Oct 2024 01:53:03 -0400
X-MC-Unique: X4smrvfBPPi6LX0K1I3B0g-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7eb07db7812so3740442a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181182; x=1730785982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxN33tdMukhisw/yIqoyNXhrPQQ42HlFh3ca/0Qlc2k=;
        b=OhNkxy7wbIRW2+FVk5D/XrDYeK6vmTPqyDDA1wrAXi0CRBSu+cOwm0GlUaCMaNkXjZ
         43tKO7V84KZofmWRK2IpxFwN9dF7e1t1mRWU/FYVEfrNad91sf2u8utdSouOsLhCQSqx
         ZOh/zbFVu3f+dtTcOMs20Dkwf/wZ19Ra7QrXTAI0Q1jWazGfrH2k9ethsoiihKusaEft
         mAP6KWXQaZDPSC28tkHp/ClLKsadyvoMhasntDa9OE1S5D7EhSRdHvY9vV4jou3iuGfG
         BwsWZtecCIPEiPKkAfUww4837iNy6kTGfiNtHwJPxDze6p3evAelynAQcoA9qclMHEPb
         PI5g==
X-Forwarded-Encrypted: i=1; AJvYcCWufFgUZlInkvxW2EmVFKNBy5i9VihKbbgjzVRTQS0mIER/F/Xbeg2ej+1VvSO94zXrByqEQcxeCtt4xu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8sEV6r1DjgAYyvX/XQRhmDodd1/KFUOeSP7FX+wBbaUo0zpV
	MkGWQjjsyZQjGDr4lMuUhd1OGa/bFzE60sCH8hvKHXf6RCdkBF4IxvIFXz4eyPz9xIq7QB4gUFu
	ZZGfn4sMLeXS+FpaGVbVY/OXKoUfi4Iur0RJGluiSUhtlUJHQZev2oJY7Mv/umA==
X-Received: by 2002:a05:6a20:1594:b0:1d9:1661:56b8 with SMTP id adf61e73a8af0-1d9e1a37b6cmr1403781637.24.1730181182368;
        Mon, 28 Oct 2024 22:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+5lOO2h8SrB779IPVLSPIhRIwwoXPjJUnB9hq/AGjJ6AhPouE5mbdohA59r2JGo+YR4/Uog==
X-Received: by 2002:a05:6a20:1594:b0:1d9:1661:56b8 with SMTP id adf61e73a8af0-1d9e1a37b6cmr1403764637.24.1730181181979;
        Mon, 28 Oct 2024 22:53:01 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a39b15sm6630484a12.79.2024.10.28.22.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:52:59 -0700 (PDT)
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
Subject: [PATCH v6 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Tue, 29 Oct 2024 13:52:19 +0800
Message-ID: <20241029055223.210039-7-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
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
index 340af8155658..99d50c31db02 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -278,6 +278,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int ret;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -286,22 +287,37 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
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
2.47.0


