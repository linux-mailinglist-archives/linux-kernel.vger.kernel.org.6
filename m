Return-Path: <linux-kernel+bounces-259131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7519E9391B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952211C2121E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7857F16DEDC;
	Mon, 22 Jul 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MiOqlKHt"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEA1F954
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661835; cv=none; b=gsedzC+r45q5fxSCMczrOZHTW4zODKgMiI7ZvJpmkx+KhLUk6+vaDf3TZ404YVBdXX68Yg/4MyEb8W/QB21nMUlPkCI2d6inkabgnFSUWkVsVajIU1rnAgVSsEFsTR+Qvgyflnm+fZgcdt3S9AoUdakNexG2GFSEJ5JOsLrvAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661835; c=relaxed/simple;
	bh=RMACHLpVpYM4R76oqhYTWyo08oDWGnAAePE/xNL9xj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUOaUJsF4kaOVLRaNsoJEKBeIolR1LwCkub9G8FRbul4ckxA0iISpo1wde8RMqj57nIViiZTmQPr3QTh0HclfRkS1uDdzs4HDnBdWb6B/pCa7bY7gzimENihVPtGYb3VsWSTjKI6GuTHyjcqpRAEYZVC3HfPSNB+koYqcquhzfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MiOqlKHt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6275140E0192;
	Mon, 22 Jul 2024 15:23:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iR0Mp5_YjBjt; Mon, 22 Jul 2024 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721661820; bh=/W1Mjjqu9zf3p9Lj4B5+TqoD2FIVDe//5FXoGD2BvWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiOqlKHtRun8B+l4rY8Weql2SRSsrPNLhWNpwe4e3462V/VGk2Mofhng4F3V+0BdH
	 Iw3VPYB+nnYKOCKYO695Pvv1OWweHcC0cZpfvrRKN6fT8/dAvlkvwHzAaPhFJFJuUE
	 9m7qRvt/0Gu4WV7V6CaAhPNU+wnDNWs2KHVp/Ozn8WzI7GfnDq4+v0AnJ+yaYFH0x4
	 7LxG05EUPgyrZXN/ylvwddmRodvVVDMIQlOVjuizfmsC+F73L168guNFzzOhgwOM6f
	 cpDXrVhEG3B4M1cy3m9IJSd3CJl7LvBWkpb2AQSNhFK5MWbMUkkK7hzHEFn8BlSWSI
	 ozKeHGx15YhLDS5t+NK4xjyTDAlbTzfYT3OcJyk5U3iglXp7Si8X8QI2EB9td9IDjS
	 3WSB2bTBD3Jj45xJsFkcfnXKvlzgjfbXq1gOiDBp/BR6YIWyH2g5RfJcJJp6a7dv3/
	 8imJt1bfIZAZncgpFXFMEs+EmYmn73zCJbhW0KhnSoR9PCYWFvNllOoJe5Rhd6VItf
	 9GVXQXO5ypQe9rCtmXutEC3JBxde/Yv9Ax0mnq4DCjk8a6iBlhubTOUDS+njzi0s0Z
	 QlGPzPSGRwdXWFqRgB3ZMSNY2lpgT7CEiays7d/wdnKXnRDGMGtz3PzaNIfZ+O5CkS
	 C8wy4GNtk0hA9K2wq7O+IBlU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DC9E40E0184;
	Mon, 22 Jul 2024 15:23:37 +0000 (UTC)
Date: Mon, 22 Jul 2024 17:23:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Boot Warning
Message-ID: <20240722152330.GCZp55ck8E_FT4kPnC@fat_crate.local>
References: <CAHbf0-G4bmpuXorwH-e_chWm1fXX7AJ8ck5AL4p+AFevhvdBfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbf0-G4bmpuXorwH-e_chWm1fXX7AJ8ck5AL4p+AFevhvdBfg@mail.gmail.com>

On Mon, Jul 22, 2024 at 01:45:35PM +0100, Mike Lothian wrote:
> Hi
> 
> I'm seeing the following boot warning:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at arch/x86/lib/cmdline.c:211
> cmdline_find_option_bool+0x741/0x760
> Modules linked in:
> CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.10.0-tip+ #4105
> RIP: 0010:cmdline_find_option_bool+0x741/0x760
> Code: 85 07 f9 ff ff eb 20 41 80 f8 21 72 1c 45 31 c9 41 80 f8 21 41
> 0f 93 c1 45 01 c9 81 f9 00 08 00 00 0f 85 e5 f8 ff ff 31 c0 c3 <0f> 0b
> 48 85 ff 0f 85 ce f8 ff ff b8 ff ff ff ff c3 cc cc cc cc cc
> RSP: 0000:ffffffff83803f18 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
> RAX: 000000000a50000c RBX: 0000000068747541 RCX: ffffffff833f2bec
> RDX: 0000000000000000 RSI: ffffffff832def4e RDI: ffffffff83b98820
> RBP: 0000000000a50f00 R08: 00cf9a000000ffff R09: 0000000000000030
> R10: 000000006c617470 R11: 0000000000100000 R12: 0000000000000000
> R13: 0000000000000000 R14: 00000000b53e4000 R15: 00000000b53e4000
> FS:  0000000000000000(0000) GS:ffffffff83acd000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8880b61c6810 CR3: 0000000004b57000 CR4: 00000000000000b0
> Call Trace:
> <TASK>
> ? __warn+0xcb/0x1c0
> ? cmdline_find_option_bool+0x741/0x760
> ? report_bug+0x173/0x220
> ? early_fixup_exception+0x4a/0xa0
> ? early_idt_handler_common+0x2f/0x40
> ? cmdline_find_option_bool+0x741/0x760
> ? check_loader_disabled_bsp+0x46/0xa0
> ? load_ucode_bsp+0x6b/0x80
> ? x86_64_start_kernel+0x4b/0x70
> ? common_startup_64+0x12c/0x137
> </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> I use an efi stub kernel
> https://github.com/FireBurn/KernelStuff/blob/master/dot_config_tip
> 
> I wasn't quite sure where to report this in the bugzilla, I'll happily
> raise one if you let me know which section it should be in

Yeah, you can usually CC x86@ and lkml and that is fine too - bugzilla is not
absolutely required. Did that now.

Anyway, yeah, this is nasty. Our handling of the merging of the builtin and
boot cmdline options would need some serious reshuffling to fix this: the
ucode loader needs to parse cmdline but the final cmdline is built a lot
later.

The only easy thing I could think of right now is, well, to check both cmdline
strings before the merging happens. 

Something like the completely untested below:

---
 arch/x86/include/asm/cmdline.h |  4 ++++
 arch/x86/kernel/setup.c        |  2 +-
 arch/x86/lib/cmdline.c         | 27 ++++++++++++++++++++-------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/cmdline.h b/arch/x86/include/asm/cmdline.h
index 6faaf27e8899..abcb270e2a07 100644
--- a/arch/x86/include/asm/cmdline.h
+++ b/arch/x86/include/asm/cmdline.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_X86_CMDLINE_H
 #define _ASM_X86_CMDLINE_H
 
+#include <asm/setup.h>
+
+extern char __initdata builtin_cmdline[COMMAND_LINE_SIZE];
+
 int cmdline_find_option_bool(const char *cmdline_ptr, const char *option);
 int cmdline_find_option(const char *cmdline_ptr, const char *option,
 			char *buffer, int bufsize);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 5d34cad9b7b1..6129dc2ba784 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -164,7 +164,7 @@ unsigned long saved_video_mode;
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
 #ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+char builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
 bool builtin_cmdline_added __ro_after_init;
 #endif
 
diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index 384da1fdd5c6..75e7e2cc4569 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -207,18 +207,31 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 
 int cmdline_find_option_bool(const char *cmdline, const char *option)
 {
-	if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
-		WARN_ON_ONCE(!builtin_cmdline_added);
+	int ret;
 
-	return __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
+	ret = __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
+	if (ret > 0)
+		return ret;
+
+#ifdef CONFIG_CMDLINE_BOOL
+	if (!builtin_cmdline_added)
+		ret = __cmdline_find_option_bool(builtin_cmdline, COMMAND_LINE_SIZE, option);
+#endif
+	return ret;
 }
 
 int cmdline_find_option(const char *cmdline, const char *option, char *buffer,
 			int bufsize)
 {
-	if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
-		WARN_ON_ONCE(!builtin_cmdline_added);
+	int ret;
+
+	ret = __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option, buffer, bufsize);
+	if (ret > 0)
+		return ret;
 
-	return __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option,
-				     buffer, bufsize);
+#ifdef CONFIG_CMDLINE_BOOL
+	if (!builtin_cmdline_added)
+		ret = __cmdline_find_option(builtin_cmdline, COMMAND_LINE_SIZE, option, buffer, bufsize);
+#endif
+	return ret;
 }
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

