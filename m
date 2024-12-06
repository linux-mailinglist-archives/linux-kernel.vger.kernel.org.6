Return-Path: <linux-kernel+bounces-434884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8409E6C49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C8128A874
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C3200BA6;
	Fri,  6 Dec 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfTb0AuX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E131C3F2C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481056; cv=none; b=FtqOVwarm6v3Rrr7vdCRSYhBbSmzhuN3Ia2wC0GeaChRC7hCIJ2l1rlqxbwVcLGrXL8Uyo1Dh3uZps8as1txIidqOxvRFvO5lgeVqxH+g1OZo/1+kkXHgMtlFkLjJvZ+nJByg2UIYgk6jmuoKJhSywm55CjgE4MZv8kLCjEqne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481056; c=relaxed/simple;
	bh=9queEJvu5d9ge2refCPUa6FSP1BvRTqPK/DYIcHJkeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vgx8QeozG6A/kQxV8u2PPu3dCjj5/PS/SkRKlgC1LlYA/lFZIoFKperXSa49wsOkF9IN7kJUn6kDS7+Od5JAJ7koTO7kTMdnOJWbV+CnXQlfXQVM0L3ruY7FizSy7ZAfy6+s1WI81vSIuKbE/TtgGvgq+fRGVNSWQwba3ExNu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfTb0AuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA17C4CEDD;
	Fri,  6 Dec 2024 10:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733481055;
	bh=9queEJvu5d9ge2refCPUa6FSP1BvRTqPK/DYIcHJkeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfTb0AuXA33OVGJI1pyHYa8q1GDfWkk03SmRZBpzCyhQn+hiXDv4gJRh7swwaxoyS
	 VgiATS8yrilhuD1cmPIZzkqMflYyh78s5WuMKFqYHdQy9C/GQsNsYuvaNewHjwcQEo
	 mdJpXz+Znl+LVT/9d/k2gDm4+/W+cc2tQvv1oxMM8aFxbl8YWsPkccKkZkGX2OZe2Z
	 WmPpbRwkFBqkOHg0a2dZd1agyZwTlK5mEUnhgB/jAjUjApB3LRlc+ZhvNM7b2MzqZL
	 0Rq8srGJ0QLziAnQ7aytSfbuHCK3JLEpDmKpTTqRAnLfre+sJ0d5FHkKJAve6fUYmC
	 wOiHClFGr+sCA==
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
Subject: [PATCH v2 3/4] x86/boot: split parsing of boot_params into a helper function
Date: Fri,  6 Dec 2024 12:30:30 +0200
Message-ID: <20241206103031.737458-4-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206103031.737458-1-rppt@kernel.org>
References: <20241206103031.737458-1-rppt@kernel.org>
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
index c34316a12897..d4e44f50f350 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -426,6 +426,46 @@ static void __init parse_setup_data(void)
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
@@ -803,35 +843,7 @@ void __init setup_arch(char **cmdline_p)
 
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
 
@@ -855,8 +867,6 @@ void __init setup_arch(char **cmdline_p)
 
 	copy_edd();
 
-	if (!boot_params.hdr.root_flags)
-		root_mountflags &= ~MS_RDONLY;
 	setup_initial_init_mm(_text, _etext, _edata, (void *)_brk_end);
 
 	/*
-- 
2.45.2


