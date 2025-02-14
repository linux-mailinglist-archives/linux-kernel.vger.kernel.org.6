Return-Path: <linux-kernel+bounces-514642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D65A359AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E763ADDC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7822D7B7;
	Fri, 14 Feb 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfM2x2LC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD622D7B9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524032; cv=none; b=fxYJWbzNn0dagTEewPDd35ABqMMEcGv2tESQ3D4WXfLMWV8tWheKk+Iss+RRtckzaKziZIngKYrl9iXteGBDyjaZ8b7pnt6iY4n/RHKMTiYwI/VWqqz1p/I113tU6ZQ0ON7mQ945I7OLIui7+ZcwREmkscGoMWO35ZL3rYwBAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524032; c=relaxed/simple;
	bh=PgMTMw6Oe7ITbA6641p6eI75CKgUid8ZfAzIAJaAUb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jO+/zZhuX6OQdcWpScdnBMlHb3Hxku9pA4eqzLrmPePOg9ITAtQbB/FUhyciqO3r81txAs/VAXfM5ec+CNeB4j+tnj0cifcCWIySM9SdjshAVqf0IQX3OBGAb1PnLeXbuJyljrYpxZRLAHNh4/Tw3NWvgYeXYnmD0vLn6R5zPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfM2x2LC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99202C4CEDF;
	Fri, 14 Feb 2025 09:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739524032;
	bh=PgMTMw6Oe7ITbA6641p6eI75CKgUid8ZfAzIAJaAUb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfM2x2LCoE9YYe/wB6RKPzRQRcdlw80BkC/ZDVfBemLWNbdlPQMyp9otWou9RWXTB
	 6/gYq7DIA1nc5zNtCskkqUn9dhP8ZixR/RpEmkzTPb1LoN2qXGRRZjmxCGjoJly4VF
	 iEjiYCx4WDkQ+glS4Ih+aOZb+4Irdrkj5gp0x32eCznO7bERCG+Q/wqq2PKZyGYnrl
	 v4Q8u/sSK77zWluLWcq/kgxRBf/RphS+H1JufOXx/bkq7/7non8m3KhoHyFfi44Tei
	 ipLkUhgTPZ908tzx1RfsSS13JiCsqj7eHUhRZyhtuOCSr+PDyhl9nvhvDlTaXx5Z7q
	 Xmckj1moRgZnQ==
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
Subject: [RESEND PATCH v2 3/4] x86/boot: split parsing of boot_params into a helper function
Date: Fri, 14 Feb 2025 11:06:50 +0200
Message-ID: <20250214090651.3331663-4-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214090651.3331663-1-rppt@kernel.org>
References: <20250214090651.3331663-1-rppt@kernel.org>
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
index 3d95946ab749..6fb9a851bc19 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -429,6 +429,46 @@ static void __init parse_setup_data(void)
 	}
 }
 
+/*
+ * Translate the fields of 'struct boot_param' into global variables
+ * representing these parameters.
+ */
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
@@ -806,35 +846,7 @@ void __init setup_arch(char **cmdline_p)
 
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
+	parse_boot_params();
 
 	x86_init.oem.arch_setup();
 
@@ -858,8 +870,6 @@ void __init setup_arch(char **cmdline_p)
 
 	copy_edd();
 
-	if (!boot_params.hdr.root_flags)
-		root_mountflags &= ~MS_RDONLY;
 	setup_initial_init_mm(_text, _etext, _edata, (void *)_brk_end);
 
 	/*
-- 
2.47.2


