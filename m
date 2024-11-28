Return-Path: <linux-kernel+bounces-424870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7509DBA80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587EF165262
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B851BD9D6;
	Thu, 28 Nov 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCGxc4Fo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79E1BCA0A;
	Thu, 28 Nov 2024 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807586; cv=none; b=kVT6A6Iib6YoAzVWOhchb0QLCi8SNahRlApf7rTYn57Tw5IqBdRM7i//6x2/jSIALzQpgf5tBB3uHwv3iAFdK4qyEz4sfm67TWrtbkWti7YVYxespHODFk8DzRO8KhcjhsigGRlpF9Vpi3TxDa0L4OHBRXzUk6sGvsLKpEO5T0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807586; c=relaxed/simple;
	bh=0aC5cqmO39QiCbyZUhJS3xSoLJpG70kuls+DEfoEVjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9bjb/nkCOcTMsAw398e0Nnyi5mosoeIXv4/FCNp+o2UYiFzKKQNGKVEBkonm4ehCdpHKpf5R+tV0Zz6GB/DOogMlvUneA+aQ7xl3lP1xhvOvlJKt4fTFKZ7gtbC3rArlNE26II/8a+3zGiPyYC32ppOpggZddOBom2S7CI6+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCGxc4Fo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732807584; x=1764343584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aC5cqmO39QiCbyZUhJS3xSoLJpG70kuls+DEfoEVjU=;
  b=LCGxc4Fo8+cx5prat49rxHQjLzkHw5GuJT6riXDCJwi3h37XUEF1Ud3I
   FRqVz+8lX7Rzwpx2+byAOotjloE76PwbPsWk/+DR6wUGHE++FW0pm+LJB
   2xTggvwjUAh6vWa/cs1NqUEUXBOuN5MCqXhoKRn+QaO8eCb0ok3oFK+q1
   3yfn2va41wPzxJN6khXkpBurKo5/ZW0AxzOF4el+ejwkn7n2P7nVb96dh
   byOATvonlUp/ZTqnT5G//8Zu1WLPvQc5rIUI2eiZYgwKeODjK4ShQvPxa
   cK+JeKaa6akPd47m20oLexZzYYUZSK0XTV2Ib8cgTZN4DBdmvf6dDe1Oj
   A==;
X-CSE-ConnectionGUID: rlukY/tBQx+27DLQuaYAgg==
X-CSE-MsgGUID: XXhpaBErRWqVCOkHY70QYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33175838"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="33175838"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 07:25:55 -0800
X-CSE-ConnectionGUID: BIV0s4IDRgmzgMmiloDSXA==
X-CSE-MsgGUID: FMoyTApIT6ea9w8QQZRRUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="92730958"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 28 Nov 2024 07:25:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 913801BD; Thu, 28 Nov 2024 17:25:50 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v1 1/3] x86/Documentation: Make Literal Blocks to follow reStructuredText specification
Date: Thu, 28 Nov 2024 17:23:38 +0200
Message-ID: <20241128152546.2396782-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
References: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file collects pieces from different epochs and hence has unaligned
style of the Literal Blocks (in terms of reStructuredText specification).
Make the Literal Blocks to follow the reStructuredText specification

While at it, make the C-like code more C and follow the Kernel Coding
style in them (after satisfying rST specification).

Suggested-by: Ingo Molnar <mingo@kernel.org>
Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/arch/x86/boot.rst | 327 ++++++++++++++++----------------
 1 file changed, 162 insertions(+), 165 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index ad2d8ddad27f..17a7da883895 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -95,27 +95,27 @@ Memory Layout
 The traditional memory map for the kernel loader, used for Image or
 zImage kernels, typically looks like::
 
-		|			 |
-	0A0000	+------------------------+
-		|  Reserved for BIOS	 |	Do not use.  Reserved for BIOS EBDA.
-	09A000	+------------------------+
-		|  Command line		 |
-		|  Stack/heap		 |	For use by the kernel real-mode code.
-	098000	+------------------------+
-		|  Kernel setup		 |	The kernel real-mode code.
-	090200	+------------------------+
-		|  Kernel boot sector	 |	The kernel legacy boot sector.
-	090000	+------------------------+
-		|  Protected-mode kernel |	The bulk of the kernel image.
-	010000	+------------------------+
-		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
-	001000	+------------------------+
-		|  Reserved for MBR/BIOS |
-	000800	+------------------------+
-		|  Typically used by MBR |
-	000600	+------------------------+
-		|  BIOS use only	 |
-	000000	+------------------------+
+  		|  			 |
+  0A0000	+------------------------+
+  		|  Reserved for BIOS	 |	Do not use.  Reserved for BIOS EBDA.
+  09A000	+------------------------+
+  		|  Command line		 |
+  		|  Stack/heap		 |	For use by the kernel real-mode code.
+  098000	+------------------------+
+  		|  Kernel setup		 |	The kernel real-mode code.
+  090200	+------------------------+
+  		|  Kernel boot sector	 |	The kernel legacy boot sector.
+  090000	+------------------------+
+  		|  Protected-mode kernel |	The bulk of the kernel image.
+  010000	+------------------------+
+  		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
+  001000	+------------------------+
+  		|  Reserved for MBR/BIOS |
+  000800	+------------------------+
+  		|  Typically used by MBR |
+  000600	+------------------------+
+  		|  BIOS use only	 |
+  000000	+------------------------+
 
 When using bzImage, the protected-mode kernel was relocated to
 0x100000 ("high memory"), and the kernel real-mode block (boot sector,
@@ -142,28 +142,28 @@ above the 0x9A000 point; too many BIOSes will break above that point.
 For a modern bzImage kernel with boot protocol version >= 2.02, a
 memory layout like the following is suggested::
 
-		~                        ~
-		|  Protected-mode kernel |
-	100000  +------------------------+
-		|  I/O memory hole	 |
-	0A0000	+------------------------+
-		|  Reserved for BIOS	 |	Leave as much as possible unused
-		~                        ~
-		|  Command line		 |	(Can also be below the X+10000 mark)
-	X+10000	+------------------------+
-		|  Stack/heap		 |	For use by the kernel real-mode code.
-	X+08000	+------------------------+
-		|  Kernel setup		 |	The kernel real-mode code.
-		|  Kernel boot sector	 |	The kernel legacy boot sector.
-	X       +------------------------+
-		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
-	001000	+------------------------+
-		|  Reserved for MBR/BIOS |
-	000800	+------------------------+
-		|  Typically used by MBR |
-	000600	+------------------------+
-		|  BIOS use only	 |
-	000000	+------------------------+
+  		~  			 ~
+  		|  Protected-mode kernel |
+  100000	+------------------------+
+  		|  I/O memory hole	 |
+  0A0000	+------------------------+
+  		|  Reserved for BIOS	 |	Leave as much as possible unused
+  		~  			 ~
+  		|  Command line		 |	(Can also be below the X+10000 mark)
+  X+10000	+------------------------+
+  		|  Stack/heap		 |	For use by the kernel real-mode code.
+  X+08000	+------------------------+
+  		|  Kernel setup		 |	The kernel real-mode code.
+  		|  Kernel boot sector	 |	The kernel legacy boot sector.
+  X		+------------------------+
+  		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
+  001000	+------------------------+
+  		|  Reserved for MBR/BIOS |
+  000800	+------------------------+
+  		|  Typically used by MBR |
+  000600	+------------------------+
+  		|  BIOS use only	 |
+  000000	+------------------------+
 
   ... where the address X is as low as the design of the boot loader permits.
 
@@ -242,9 +242,9 @@ If the "HdrS" (0x53726448) magic number is not found at offset 0x202,
 the boot protocol version is "old".  Loading an old kernel, the
 following parameters should be assumed::
 
-	Image type = zImage
-	initrd not supported
-	Real-mode kernel must be located at 0x90000.
+  Image type = zImage
+  initrd not supported
+  Real-mode kernel must be located at 0x90000.
 
 Otherwise, the "version" field contains the protocol version,
 e.g. protocol version 2.01 will contain 0x0201 in this field.  When
@@ -365,7 +365,7 @@ Offset/size:	0x206/2
 Protocol:	2.00+
 ============	=======
 
-  Contains the boot protocol version, in (major << 8)+minor format,
+  Contains the boot protocol version, in (major << 8) + minor format,
   e.g. 0x0204 for version 2.04, and 0x0a11 for a hypothetical version
   10.17.
 
@@ -397,17 +397,17 @@ Protocol:	2.00+
   If set to a nonzero value, contains a pointer to a NUL-terminated
   human-readable kernel version number string, less 0x200.  This can
   be used to display the kernel version to the user.  This value
-  should be less than (0x200*setup_sects).
+  should be less than (0x200 * setup_sects).
 
   For example, if this value is set to 0x1c00, the kernel version
   number string can be found at offset 0x1e00 in the kernel file.
   This is a valid value if and only if the "setup_sects" field
   contains the value 15 or higher, as::
 
-	0x1c00  < 15*0x200 (= 0x1e00) but
-	0x1c00 >= 14*0x200 (= 0x1c00)
+   0x1c00  < 15 * 0x200 (= 0x1e00) but
+   0x1c00 >= 14 * 0x200 (= 0x1c00)
 
-	0x1c00 >> 9 = 14, So the minimum value for setup_secs is 15.
+   0x1c00 >> 9 = 14, So the minimum value for setup_secs is 15.
 
 ============	==================
 Field name:	type_of_loader
@@ -427,9 +427,9 @@ Protocol:	2.00+
 
   For example, for T = 0x15, V = 0x234, write::
 
-	type_of_loader  <- 0xE4
-	ext_loader_type <- 0x05
-	ext_loader_ver  <- 0x23
+   type_of_loader  <- 0xE4
+   ext_loader_type <- 0x05
+   ext_loader_ver  <- 0x23
 
   Assigned boot loader ids (hexadecimal):
 
@@ -686,7 +686,7 @@ Protocol:	2.10+
   If a boot loader makes use of this field, it should update the
   kernel_alignment field with the alignment unit desired; typically::
 
-	kernel_alignment = 1 << min_alignment
+   kernel_alignment = 1 << min_alignment;
 
   There may be a considerable performance cost with an excessively
   misaligned kernel.  Therefore, a loader should typically try each
@@ -808,13 +808,13 @@ Protocol:	2.09+
   parameters passing mechanism. The definition of struct setup_data is
   as follow::
 
-	struct setup_data {
-		u64 next;
-		u32 type;
-		u32 len;
-		u8  data[0];
-	};
-
+   struct setup_data {
+   	__u64 next;
+   	__u32 type;
+   	__u32 len;
+   	__u8 data[];
+   }
+   
   Where, the next is a 64-bit physical pointer to the next node of
   linked list, the next field of the last node is 0; the type is used
   to identify the contents of data; the len is the length of data
@@ -834,12 +834,12 @@ Protocol:	2.09+
   Thus setup_indirect struct and SETUP_INDIRECT type were introduced in
   protocol 2.15::
 
-    struct setup_indirect {
-      __u32 type;
-      __u32 reserved;  /* Reserved, must be set to zero. */
-      __u64 len;
-      __u64 addr;
-    };
+   struct setup_indirect {
+   	__u32 type;
+   	__u32 reserved;		/* Reserved, must be set to zero. */
+   	__u64 len;
+   	__u64 addr;
+   };
 
   The type member is a SETUP_INDIRECT | SETUP_* type. However, it cannot be
   SETUP_INDIRECT itself since making the setup_indirect a tree structure
@@ -849,17 +849,17 @@ Protocol:	2.09+
   Let's give an example how to point to SETUP_E820_EXT data using setup_indirect.
   In this case setup_data and setup_indirect will look like this::
 
-    struct setup_data {
-      __u64 next = 0 or <addr_of_next_setup_data_struct>;
-      __u32 type = SETUP_INDIRECT;
-      __u32 len = sizeof(setup_indirect);
-      __u8 data[sizeof(setup_indirect)] = struct setup_indirect {
-        __u32 type = SETUP_INDIRECT | SETUP_E820_EXT;
-        __u32 reserved = 0;
-        __u64 len = <len_of_SETUP_E820_EXT_data>;
-        __u64 addr = <addr_of_SETUP_E820_EXT_data>;
-      }
-    }
+   struct setup_data {
+   	.next = 0,	/* or <addr_of_next_setup_data_struct> */
+   	.type = SETUP_INDIRECT,
+   	.len = sizeof(setup_indirect),
+   	.data[sizeof(setup_indirect)] = (struct setup_indirect) {
+   		.type = SETUP_INDIRECT | SETUP_E820_EXT,
+   		.reserved = 0,
+   		.len = <len_of_SETUP_E820_EXT_data>,
+   		.addr = <addr_of_SETUP_E820_EXT_data>,
+   	},
+   }
 
 .. note::
      SETUP_INDIRECT | SETUP_NONE objects cannot be properly distinguished
@@ -896,19 +896,19 @@ Offset/size:	0x260/4
 
   The kernel runtime start address is determined by the following algorithm::
 
-   	if (relocatable_kernel) {
-   		if (load_address < pref_address)
-   			load_address = pref_address;
-   		runtime_start = align_up(load_address, kernel_alignment);
-   	} else {
-   		runtime_start = pref_address;
-   	}
+   if (relocatable_kernel) {
+    	if (load_address < pref_address)
+    		load_address = pref_address;
+    	runtime_start = align_up(load_address, kernel_alignment);
+   } else {
+    	runtime_start = pref_address;
+   }
 
 Hence the necessary memory window location and size can be estimated by
 a boot loader as::
 
-   	memory_window_start = runtime_start;
-   	memory_window_size = init_size;
+   memory_window_start = runtime_start;
+   memory_window_size = init_size;
 
 ============	===============
 Field name:	handover_offset
@@ -938,12 +938,12 @@ The kernel_info
 ===============
 
 The relationships between the headers are analogous to the various data
-sections:
+sections::
 
   setup_header = .data
   boot_params/setup_data = .bss
 
-What is missing from the above list? That's right:
+What is missing from the above list? That's right::
 
   kernel_info = .rodata
 
@@ -975,22 +975,22 @@ after kernel_info_var_len_data label. Each chunk of variable size data has to
 be prefixed with header/magic and its size, e.g.::
 
   kernel_info:
-          .ascii  "LToP"          /* Header, Linux top (structure). */
-          .long   kernel_info_var_len_data - kernel_info
-          .long   kernel_info_end - kernel_info
-          .long   0x01234567      /* Some fixed size data for the bootloaders. */
+  	.ascii  "LToP"		/* Header, Linux top (structure). */
+  	.long   kernel_info_var_len_data - kernel_info
+  	.long   kernel_info_end - kernel_info
+  	.long   0x01234567	/* Some fixed size data for the bootloaders. */
   kernel_info_var_len_data:
-  example_struct:                 /* Some variable size data for the bootloaders. */
-          .ascii  "0123"          /* Header/Magic. */
-          .long   example_struct_end - example_struct
-          .ascii  "Struct"
-          .long   0x89012345
+  example_struct:		/* Some variable size data for the bootloaders. */
+  	.ascii  "0123"		/* Header/Magic. */
+  	.long   example_struct_end - example_struct
+  	.ascii  "Struct"
+  	.long   0x89012345
   example_struct_end:
-  example_strings:                /* Some variable size data for the bootloaders. */
-          .ascii  "ABCD"          /* Header/Magic. */
-          .long   example_strings_end - example_strings
-          .asciz  "String_0"
-          .asciz  "String_1"
+  example_strings:		/* Some variable size data for the bootloaders. */
+  	.ascii  "ABCD"		/* Header/Magic. */
+  	.long   example_strings_end - example_strings
+  	.asciz  "String_0"
+  	.asciz  "String_1"
   example_strings_end:
   kernel_info_end:
 
@@ -1139,67 +1139,63 @@ mode segment.
 
 Such a boot loader should enter the following fields in the header::
 
-	unsigned long base_ptr;	/* base address for real-mode segment */
+  unsigned long base_ptr;	/* base address for real-mode segment */
 
-	if ( setup_sects == 0 ) {
-		setup_sects = 4;
-	}
+  if (setup_sects == 0)
+  	setup_sects = 4;
 
-	if ( protocol >= 0x0200 ) {
-		type_of_loader = <type code>;
-		if ( loading_initrd ) {
-			ramdisk_image = <initrd_address>;
-			ramdisk_size = <initrd_size>;
-		}
+  if (protocol >= 0x0200) {
+  	type_of_loader = <type code>;
+  	if (loading_initrd) {
+  		ramdisk_image = <initrd_address>;
+  		ramdisk_size = <initrd_size>;
+  	}
 
-		if ( protocol >= 0x0202 && loadflags & 0x01 )
-			heap_end = 0xe000;
-		else
-			heap_end = 0x9800;
+  	if (protocol >= 0x0202 && loadflags & 0x01)
+  		heap_end = 0xe000;
+  	else
+  		heap_end = 0x9800;
 
-		if ( protocol >= 0x0201 ) {
-			heap_end_ptr = heap_end - 0x200;
-			loadflags |= 0x80; /* CAN_USE_HEAP */
-		}
+  	if (protocol >= 0x0201) {
+  		heap_end_ptr = heap_end - 0x200;
+  		loadflags |= 0x80;		/* CAN_USE_HEAP */
+  	}
 
-		if ( protocol >= 0x0202 ) {
-			cmd_line_ptr = base_ptr + heap_end;
-			strcpy(cmd_line_ptr, cmdline);
-		} else {
-			cmd_line_magic	= 0xA33F;
-			cmd_line_offset = heap_end;
-			setup_move_size = heap_end + strlen(cmdline)+1;
-			strcpy(base_ptr+cmd_line_offset, cmdline);
-		}
-	} else {
-		/* Very old kernel */
+  	if (protocol >= 0x0202) {
+  		cmd_line_ptr = base_ptr + heap_end;
+  		strcpy(cmd_line_ptr, cmdline);
+  	} else {
+  		cmd_line_magic	= 0xA33F;
+  		cmd_line_offset = heap_end;
+  		setup_move_size = heap_end + strlen(cmdline) + 1;
+  		strcpy(base_ptr + cmd_line_offset, cmdline);
+  	}
+  } else {
+  	/* Very old kernel */
 
-		heap_end = 0x9800;
+  	heap_end = 0x9800;
 
-		cmd_line_magic	= 0xA33F;
-		cmd_line_offset = heap_end;
+  	cmd_line_magic	= 0xA33F;
+  	cmd_line_offset = heap_end;
 
-		/* A very old kernel MUST have its real-mode code
-		   loaded at 0x90000 */
+  	/* A very old kernel MUST have its real-mode code loaded at 0x90000 */
+  	if (base_ptr != 0x90000) {
+  		/* Copy the real-mode kernel */
+  		memcpy(0x90000, base_ptr, (setup_sects + 1) * 512);
+  		base_ptr = 0x90000;		 /* Relocated */
+  	}
 
-		if ( base_ptr != 0x90000 ) {
-			/* Copy the real-mode kernel */
-			memcpy(0x90000, base_ptr, (setup_sects+1)*512);
-			base_ptr = 0x90000;		 /* Relocated */
-		}
+  	strcpy(0x90000 + cmd_line_offset, cmdline);
 
-		strcpy(0x90000+cmd_line_offset, cmdline);
-
-		/* It is recommended to clear memory up to the 32K mark */
-		memset(0x90000 + (setup_sects+1)*512, 0,
-		       (64-(setup_sects+1))*512);
-	}
+  	/* It is recommended to clear memory up to the 32K mark */
+  	memset(0x90000 + (setup_sects + 1) * 512, 0, (64 - (setup_sects + 1)) * 512);
+  }
 
 
 Loading The Rest of The Kernel
 ==============================
 
-The 32-bit (non-real-mode) kernel starts at offset (setup_sects+1)*512
+The 32-bit (non-real-mode) kernel starts at offset (setup_sects + 1) * 512
 in the kernel file (again, if setup_sects == 0 the real value is 4.)
 It should be loaded at address 0x10000 for Image/zImage kernels and
 0x100000 for bzImage kernels.
@@ -1207,8 +1203,8 @@ It should be loaded at address 0x10000 for Image/zImage kernels and
 The kernel is a bzImage kernel if the protocol >= 2.00 and the 0x01
 bit (LOAD_HIGH) in the loadflags field is set::
 
-	is_bzImage = (protocol >= 0x0200) && (loadflags & 0x01);
-	load_address = is_bzImage ? 0x100000 : 0x10000;
+  is_bzImage = (protocol >= 0x0200) && (loadflags & 0x01);
+  load_address = is_bzImage ? 0x100000 : 0x10000;
 
 Note that Image/zImage kernels can be up to 512K in size, and thus use
 the entire 0x10000-0x90000 range of memory.  This means it is pretty
@@ -1282,19 +1278,20 @@ es = ss.
 
 In our example from above, we would do::
 
-	/* Note: in the case of the "old" kernel protocol, base_ptr must
-	   be == 0x90000 at this point; see the previous sample code */
+  /*
+   * Note: in the case of the "old" kernel protocol, base_ptr must
+   * be == 0x90000 at this point; see the previous sample code.
+   */
+  seg = base_ptr >> 4;
 
-	seg = base_ptr >> 4;
+  cli();			/* Enter with interrupts disabled! */
 
-	cli();	/* Enter with interrupts disabled! */
+  /* Set up the real-mode kernel stack */
+  _SS = seg;
+  _SP = heap_end;
 
-	/* Set up the real-mode kernel stack */
-	_SS = seg;
-	_SP = heap_end;
-
-	_DS = _ES = _FS = _GS = seg;
-	jmp_far(seg+0x20, 0);	/* Run the kernel */
+  _DS = _ES = _FS = _GS = seg;
+  jmp_far(seg + 0x20, 0);	/* Run the kernel */
 
 If your boot sector accesses a floppy drive, it is recommended to
 switch off the floppy motor before running the kernel, since the
@@ -1349,7 +1346,7 @@ from offset 0x01f1 of kernel image on should be loaded into struct
 boot_params and examined. The end of setup header can be calculated as
 follow::
 
-	0x0202 + byte value at offset 0x0201
+  0x0202 + byte value at offset 0x0201
 
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
@@ -1385,7 +1382,7 @@ Then, the setup header at offset 0x01f1 of kernel image on should be
 loaded into struct boot_params and examined. The end of setup header
 can be calculated as follows::
 
-	0x0202 + byte value at offset 0x0201
+  0x0202 + byte value at offset 0x0201
 
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
@@ -1427,7 +1424,7 @@ execution context provided by the EFI firmware.
 
 The function prototype for the handover entry point looks like this::
 
-    efi_stub_entry(void *handle, efi_system_table_t *table, struct boot_params *bp)
+  void efi_stub_entry(void *handle, efi_system_table_t *table, struct boot_params *bp);
 
 'handle' is the EFI image handle passed to the boot loader by the EFI
 firmware, 'table' is the EFI system table - these are the first two
-- 
2.43.0.rc1.1336.g36b5255a03ac


