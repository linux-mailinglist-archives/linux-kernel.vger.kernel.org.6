Return-Path: <linux-kernel+bounces-267781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340BB941562
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51EA1F245EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6CE1A2C34;
	Tue, 30 Jul 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UPUnUBwz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EAB1A2C17
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352889; cv=none; b=Q/kFrlmzMJeWuJJmoEIxiCl1pqQmHnGfhh/eQq5DCNtPuJFa56Sqce8feCrlYKUMkh5aqX5MDBFzLQFJmhwKP3KE0K++ZrzNkFoopCRKeTqWP7M0zCSjTFpnGxPL5STVoF3gnES98cKch1v9pvF9Ffk73phiTM075Qpf9vnj0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352889; c=relaxed/simple;
	bh=0qpnTgOzReVulZgfg9hj0scl4g1+GaSa56gFYhhPCYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YidqeNpmzbL6kE1RoOEc/yToXv8eRtEWpFwhfXI7W4tLBmBXy6lMzlY3i61z3657cCgexGNXvT8iZQTr5wrF+qYB5XvlI3y4+jPOGuM+II4xzelXZZGW/af4ZJp3zI2qfRxHJAeLfk/Jnk8yILmLJ1zF2IdLysKtMeT4YGW0WJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UPUnUBwz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 055B740E01CD;
	Tue, 30 Jul 2024 15:21:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xpnqvJtBHNib; Tue, 30 Jul 2024 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722352877; bh=5JOjjO8RaohXhYODiyBW0i2sbPCLIRgv9IHMA2dz5AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPUnUBwzUvpjACJ/50ROdLLWPI+7htLt2zmQfBGD+UuctqisXbAzdCMNV6DY0tuni
	 fa+97XNn5+3x/ABAgOquj8BizA4/MswvyurL4lXubcPNx/elEC1Z73ytvIzXt9sTfu
	 fr9m1A84Zkofv7vPjwfcJUsnSV0xD1WA77AtW1Pte1sWHYy9ZoGsXBF49/ZtTmYc0s
	 /PwUGNiBMxL1tAakbJSpPPLSMOmO69VGpLFN42xdzb+dMmg7nxvFKpO2UKiRJLOdos
	 dXpggc7AuBp5JkTNBT45teB+O8oKUgIIzpsaVQfWMDITgumb33UcuIZ8wLUrNiwVHR
	 Zr/Zu4V9L8aNN5PFeAWnWofInLNM1HHGCQ4l/r+wiWnjIkdaKb/KuilMv9Fu7+M8xa
	 fDiqohndrwOVibrfK239Fxky4J6tzUf6HhVPxQrLdWyUrMgJOZZoYzcisJj2/cF2vG
	 Oamb7UHPNWd3HB82rYsvHHF/Id271rqV5ubr6ns+caYxQe3cYAaCwHwa+iN/RE0z11
	 cg56oJaqjS6QdofyoyRpHPF9v4Y6qaJmN9Zwf/AOgyCeJRKHHAkJhqnZ+bhbQdPPkq
	 mztcyDep7O2TacJMQ6KhJq/CqRecHi5Oz8yrzwqm7Qv0ZQk34sWV7Tw7ZFrRzocGBK
	 TMY9twHvXs6R3A87LRCq9KZY=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79F0F40E01A8;
	Tue, 30 Jul 2024 15:21:14 +0000 (UTC)
Date: Tue, 30 Jul 2024 17:21:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/setup: Parse the builtin command line before merging
Message-ID: <20240730152108.GAZqkE5Dfi9AuKllRw@fat_crate.local>
References: <CAHbf0-G4bmpuXorwH-e_chWm1fXX7AJ8ck5AL4p+AFevhvdBfg@mail.gmail.com>
 <20240722152330.GCZp55ck8E_FT4kPnC@fat_crate.local>
 <CAHbf0-FTrRPfDTkkSjq9yvyFrWvoYjH_uJAW5KDae8vO-hch+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbf0-FTrRPfDTkkSjq9yvyFrWvoYjH_uJAW5KDae8vO-hch+w@mail.gmail.com>

On Mon, Jul 22, 2024 at 05:56:08PM +0100, Mike Lothian wrote:
> That patch does indeed make the warning go away :D
> 
> Is there anything else you need from me?

Nah, all good.

Thanks for reporting and testing.

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 30 Jul 2024 16:15:12 +0200
Subject: [PATCH] x86/setup: Parse the builtin command line before merging

Commit in Fixes was added as a catch-all for cases where the cmdline is
parsed before being merged with the builtin one.

And promptly one issue appeared, see Link below. And the microcode
loader really needs to parse it that early. And the merging happens
late. Reshuffling the early boot nightmare^W code to handle that
properly would be a painful exercise for another day so do the chicken
thing and parse the builtin cmdline too before it has been merged.

Fixes: 0c40b1c7a897 ("x86/setup: Warn when option parsing is done too early")
Reported-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240722152330.GCZp55ck8E_FT4kPnC@fat_crate.local
---
 arch/x86/include/asm/cmdline.h |  4 ++++
 arch/x86/kernel/setup.c        |  2 +-
 arch/x86/lib/cmdline.c         | 29 ++++++++++++++++++++++-------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/cmdline.h b/arch/x86/include/asm/cmdline.h
index 6faaf27e8899..6cbd9ae58b21 100644
--- a/arch/x86/include/asm/cmdline.h
+++ b/arch/x86/include/asm/cmdline.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_X86_CMDLINE_H
 #define _ASM_X86_CMDLINE_H
 
+#include <asm/setup.h>
+
+extern char builtin_cmdline[COMMAND_LINE_SIZE];
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
index 384da1fdd5c6..c51726c251a0 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -207,18 +207,33 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 
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
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
+		if (!builtin_cmdline_added)
+			return __cmdline_find_option_bool(builtin_cmdline, COMMAND_LINE_SIZE, option);
+	}
+
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
+
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
+		if (!builtin_cmdline_added)
+			return __cmdline_find_option(builtin_cmdline, COMMAND_LINE_SIZE, option, buffer, bufsize);
+	}
 
-	return __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option,
-				     buffer, bufsize);
+	return ret;
 }
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

