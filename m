Return-Path: <linux-kernel+bounces-429350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC209E1AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D970289775
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EEA1E47C8;
	Tue,  3 Dec 2024 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxWRnJKo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A41E3DE6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225150; cv=none; b=NGPcrwkMFmUCj4v6Unf5IEZqWs/Aqh1cX96TKKb7ytqLZMvYegFAp+gVgkYpfADNqpbBfOZpN5GBH/b0mLludSgGWRO6obYcRn17SfFRGZg2qqk5G7baCWvar+nbu9Xya5Ga1vJMGkH8+RekD1VT6YZzl+y+P7EADU8YV2tpadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225150; c=relaxed/simple;
	bh=V7KwPGMF2A4L+k/hHX6Isufb0CaGHYqFaBE25j7xymA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eaf3bwGPFrXEO+5GrB08pXMSJ2JIbB5IWx+TBm8H67p/ZTiAqsSciASXXhkY+ld5F6I0RlE3l/ShCkSof233BiCSCUJZuXioUGFHy1tr9cHOPejyUsAMYuO2NKXwLugfJxmfEBLKPSXn6MLUqPK+F+7U3jZX3GQCfEkHA9WxIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxWRnJKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916C8C4CECF;
	Tue,  3 Dec 2024 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733225149;
	bh=V7KwPGMF2A4L+k/hHX6Isufb0CaGHYqFaBE25j7xymA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxWRnJKok2oVK9+07pQzfb+QFG4fI+UKTBNVqlZ/6lNZFUQWUIiG+yczVLSAoSiD5
	 4WBoOpF0VJu/7V3g8fsXnlPBzL2wsaZL73x1EbXCgO3Nrksrt0k96F8WRcHkO01oAg
	 ocr5zEg6CbZ2GJkZn32D1LAlGfqiU+cmsOF6G5FIII1jFRFhHNihZKHWGROsJxIdts
	 lS5CLxXcW/FCrJ29AMgvhJNoksILWyjRYoVRLYtS8ep/hL2n+iPqdYkmquJqU4AfNh
	 1T/jg71MIGO+hc4ywUzwpJbScs78moyWgFlP5CxKxWJsT2a62tJofAlFFmdeCwgMO2
	 gWHhvu5jto2pw==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ning Sun <ning.sun@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	tboot-devel@lists.sourceforge.net
Subject: [PATCH 3/4] x86/boot: split parsing of boot_params into a helper function
Date: Tue,  3 Dec 2024 13:25:24 +0200
Message-ID: <20241203112525.591496-4-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203112525.591496-1-rppt@kernel.org>
References: <20241203112525.591496-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Makes setup_arch a bit easier to comprehend.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/setup.c | 72 +++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d299fe5bda25..d4bb9a2e8f15 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -426,6 +426,42 @@ static void __init parse_setup_data(void)
 	}
 }
 
+static void __init parse_boot_params(void)
+{
+	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
+	screen_info = boot_params.screen_info;
+	edid_info = boot_params.edid_info;
+#ifdef CONFIG_X86_32
+	apm_info.bios = boot_params.apm_bios_info;
+	ist_info = boot_params.ist_info;
+#endif
+	saved_video_mode = boot_params.hdr.vid_mode;
+	bootloader_type = boot_params.hdr.type_of_loader;
+	if ((bootloader_type >> 4) == 0xe) {
+		bootloader_type &= 0xf;
+		bootloader_type |= (boot_params.hdr.ext_loader_type+0x10) << 4;
+	}
+	bootloader_version  = bootloader_type & 0xf;
+	bootloader_version |= boot_params.hdr.ext_loader_ver << 4;
+
+#ifdef CONFIG_BLK_DEV_RAM
+	rd_image_start = boot_params.hdr.ram_size & RAMDISK_IMAGE_START_MASK;
+#endif
+#ifdef CONFIG_EFI
+	if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
+		     EFI32_LOADER_SIGNATURE, 4)) {
+		set_bit(EFI_BOOT, &efi.flags);
+	} else if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
+		     EFI64_LOADER_SIGNATURE, 4)) {
+		set_bit(EFI_BOOT, &efi.flags);
+		set_bit(EFI_64BIT, &efi.flags);
+	}
+#endif
+
+	if (!boot_params.hdr.root_flags)
+		root_mountflags &= ~MS_RDONLY;
+}
+
 static void __init memblock_x86_reserve_range_setup_data(void)
 {
 	struct setup_indirect *indirect;
@@ -803,35 +839,11 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_olpc_ofw_pgd();
 
-	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
-	screen_info = boot_params.screen_info;
-	edid_info = boot_params.edid_info;
-#ifdef CONFIG_X86_32
-	apm_info.bios = boot_params.apm_bios_info;
-	ist_info = boot_params.ist_info;
-#endif
-	saved_video_mode = boot_params.hdr.vid_mode;
-	bootloader_type = boot_params.hdr.type_of_loader;
-	if ((bootloader_type >> 4) == 0xe) {
-		bootloader_type &= 0xf;
-		bootloader_type |= (boot_params.hdr.ext_loader_type+0x10) << 4;
-	}
-	bootloader_version  = bootloader_type & 0xf;
-	bootloader_version |= boot_params.hdr.ext_loader_ver << 4;
-
-#ifdef CONFIG_BLK_DEV_RAM
-	rd_image_start = boot_params.hdr.ram_size & RAMDISK_IMAGE_START_MASK;
-#endif
-#ifdef CONFIG_EFI
-	if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
-		     EFI32_LOADER_SIGNATURE, 4)) {
-		set_bit(EFI_BOOT, &efi.flags);
-	} else if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
-		     EFI64_LOADER_SIGNATURE, 4)) {
-		set_bit(EFI_BOOT, &efi.flags);
-		set_bit(EFI_64BIT, &efi.flags);
-	}
-#endif
+	/*
+	 * Translate the fields of struct boot_param into global variables
+	 * represting these parameters.
+	 */
+	parse_boot_params();
 
 	x86_init.oem.arch_setup();
 
@@ -855,8 +867,6 @@ void __init setup_arch(char **cmdline_p)
 
 	copy_edd();
 
-	if (!boot_params.hdr.root_flags)
-		root_mountflags &= ~MS_RDONLY;
 	setup_initial_init_mm(_text, _etext, _edata, (void *)_brk_end);
 
 	/*
-- 
2.45.2


