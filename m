Return-Path: <linux-kernel+bounces-426210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB2F9DF050
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BF7162F53
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADEA19307D;
	Sat, 30 Nov 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lgok3lwe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6716EB56
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732969622; cv=none; b=NvcTPQFCLkYG5ABIHIjuN0YAu7SYd6wz5JaBUP+hmP7b+Rkj4ERtWtZSwKt8BtW1tTFo1JYD4fBDkrALGvF+1qDESLoZpcA1q5d6P2abwEivFptAMh6tEJcrLNpiCGslMkTgZtkKIZHq8DrnFT5k/7wDj+69WAOKWk9bwIXlnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732969622; c=relaxed/simple;
	bh=+md5XKQtp1HGP8cWJAlUcT/mtjiD68rmg7hfdZAywFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KWEtdkj50Gis2XoSKKVw2Dt2lCRbZj8xPVrvO6swePIt11e9/bLlOONNee40q/JVPRKX1PiO49j7ZAeO/nBhwvnsmHqH7IBFhtTLzyAEd0d+r+f8kcQJ2O1b1tO/dgFStomONl8JjR/Xr8ROrGQhqJWunjGJxsDGC54DOzM6cjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lgok3lwe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E072340E0269;
	Sat, 30 Nov 2024 12:26:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8j_yPeIUIkxB; Sat, 30 Nov 2024 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732969612; bh=9b7rsjWYOUmku+dAyh3+ep0fV3qRv+nk40t8NGxwypc=;
	h=Date:From:To:Cc:Subject:From;
	b=Lgok3lweqO3mbM8bDzAGdIHD1MTXHt6xEV3+nVLEFbXVYBFPzV6ANaV14pyFudpj2
	 gj4+Ils6v5UwR0BeR3xKT3ERW/f5RLDQ5KS7qjUCVErGDv0rvfpqJ31WnvJ0EwI1yZ
	 Y7Ptne0anLCtj/ngT4AcEa4HHnUzn00HcHncI8n+tr/RCvgNcoi42+gMk/Gms7bwtP
	 A+us7UeQe4P7zcTUwkfRgzCcICwOFILoTamUV2rca9lAACM6lv7ZDRnxfmR2gH2+xu
	 iMApvOZ4LIsrTCAMFiwAljXTOxmyfWx/Kzk2HoXfOOIQkuEmYBD5sm7SIqzBr+VJnP
	 oTLGcq1/BlIkByTpf5KGyun7I8otM7B8jPXpqMwT9GQ4ZJMcMhRAAAXXFAiDkxRslI
	 YCX3qoieQ7QH8JclAG4WrnyTGeJqjJvdOhqgNf7XddxB2xU3B7LMo+M7p5nVTSMrb+
	 Mk5oyKWFsOTZX1uDGqnukSJMn4Pp2o9fyrW6nN2iqro984nRA/NX17QwgURvhn5HlY
	 IpBC7t+CqR/uTWHSw57x2NOgr82gx9Ab3cTAJpf879mNK+lFKUnIyJqZn+m6NgcCZc
	 QQxk2bh48t6sg2M0NOlM0WSprU+lAG6L/ieQwUcYGixHiY45R1Qxa9IBHNAcBHoWP9
	 aIGLRFlsmTMXL3RvzcgIpOjs=
Received: from zn.tnic (p200300ea9736a15f329C23FffEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a15f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A36240E0200;
	Sat, 30 Nov 2024 12:26:49 +0000 (UTC)
Date: Sat, 30 Nov 2024 13:26:44 +0100
From: "Borislav Petkov (AMD)" <bp@alien8.de>
To: x86-ml <x86@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/boot/compressed: Remove unused header includes from
 kaslr.c
Message-ID: <20241130122644.GAZ0sEhD3Bm_9ZAIuc@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Nothing is using the linux/ namespace headers anymore. Remove them.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---

I'm really surprised how nothing really needs those includes anymore - at
least my couple of 100 randbuilds all pass.

 arch/x86/boot/compressed/kaslr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index f4d82379bf44..f03d59ea6e40 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -25,10 +25,6 @@
 #include "efi.h"
 
 #include <generated/compile.h>
-#include <linux/module.h>
-#include <linux/uts.h>
-#include <linux/utsname.h>
-#include <linux/ctype.h>
 #include <generated/utsversion.h>
 #include <generated/utsrelease.h>
 
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

