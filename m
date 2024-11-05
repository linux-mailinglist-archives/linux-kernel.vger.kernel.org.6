Return-Path: <linux-kernel+bounces-396728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86439BD15B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BC91C226EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AFC17C9B8;
	Tue,  5 Nov 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeGU4imK"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21B178CDE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822304; cv=none; b=Ck+lLslIH4y9py/vC5z34sMh6u/OODMKVx3bwUUk0roPMFhhVVL3tZdZQzh5BYcl4IBgppN0Q6jjTXi8OwPD80f+p1RMOQjzoQzzzbIekNNpH0fRhDiiT3HY4FNz2BRQ9XBegrFY2kFFC4iCwtzKZ+i2vlZOmV5+lTuWK4o4aaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822304; c=relaxed/simple;
	bh=e6CadN4Wjeq8ZoBSwOhz57prsTrnBh9zM8CvE9CiT5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAnTTOefXTuWjVjr0t3klNF/2oB9WTSbxG7A/4mG4IObXkulRRykGwPcB9CYDEYYW7qhJLuNkSCw6rrlxC5wfrTV8GQ977TK4lFh0OAP6xaafVYcXOCgl72Wrz+e5MCJLsACWDke9PXsIZRHHtfTRXeGdg8jeelTqUIGWg8JM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeGU4imK; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ebbed44918so3266487eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822301; x=1731427101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSPWXTKyL1XQ/YdGJ/1gqxsONhCLEGuN7u7SD8r/qZw=;
        b=BeGU4imK2b8zbOntMcIexXrQWstRRJB/1DKlVaLDHKc9Q4cxgbuS+wNb67ynCu7Hzb
         FRop0UOCVlKhK8Y7U/VThX13yfWBn/oCwvlVDXG6+4LdJMDy/U7oLvaBEY2dJDxCTQEW
         Aj3/GG9iiM5Fu5xPzJ5hJocCrFMb1MszPHB08TfiZeLGRJYCK+Vjnn+C0gNQo20YEZRN
         RKtA+HgiYqg0/O5H0O4U3tugWecGubW7wxyzMHOA1hNt7om5Doe9LQuky0Tp2W346reg
         ZMfJXdtxLuNzAJ9CUd8K81CxPVN6TyVLDqfKcq3KPBZqTUxs5nmr2Tzt2P5mr0YzOOMz
         CDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822301; x=1731427101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSPWXTKyL1XQ/YdGJ/1gqxsONhCLEGuN7u7SD8r/qZw=;
        b=UmVkgoGklgchGpqizLC5IfqBxQG+8X0qUlYiiZUbAJliEgTX5VsF71yzItp/rwZNyg
         yVaU/TB5jFudBWWUGeP2nto8fSMjLi0RSpTU6W8t8ZAguhblQBaptz6KpJgicjLkff4n
         2Ykb3ZCyxXltGoY6YGkCm3O/bDLRNEyv6rSgI2hweqs7S0DwoX4cqqHT8VbAjnOH3AZa
         pOepSEp+XoRPaiZKc+PKWxIg3Zx52L8xvOFpPZaAvPR9orsS1I5k9pW374kiG/Vn75aj
         lE3L371uzSsLdMKd3G/fQOeM/9WJxO1n/+X3q64wKC7ZBlKRJH75bj8XtF8X4M8WsNWP
         WzYA==
X-Gm-Message-State: AOJu0YyA4V8c+pyUvhqBs+N2yhPpDTmSvaK+/+WZwGmttelO8wgQeaSw
	TChWtUi+pCo0U4tkH9UdUFnMqwOB2tmaql/vMp5Zngt71Yr6Gg5algQt
X-Google-Smtp-Source: AGHT+IHQ0gFI8DtbzdZNykJIwHj4DuvLDCq9g4+ab8Olkj6CcDH5KwrLO3AncT0VkvDMcc8SNEIuUA==
X-Received: by 2002:a05:6358:98a8:b0:1bc:59a1:5bb8 with SMTP id e5c5f4694b2df-1c5e32a7767mr1305791455d.6.1730822301316;
        Tue, 05 Nov 2024 07:58:21 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:20 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 06/16] x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
Date: Tue,  5 Nov 2024 10:57:51 -0500
Message-ID: <20241105155801.1779119-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
stack protector location.  Treat them as another type of PC-relative
relocation.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 6afe2e5e9102..7d7fc7f0a250 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -32,6 +32,11 @@ static struct relocs		relocs32;
 static struct relocs		relocs32neg;
 static struct relocs		relocs64;
 # define FMT PRIu64
+
+#ifndef R_X86_64_REX_GOTPCRELX
+#define R_X86_64_REX_GOTPCRELX 42
+#endif
+
 #else
 # define FMT PRIu32
 #endif
@@ -226,6 +231,7 @@ static const char *rel_type(unsigned type)
 		REL_TYPE(R_X86_64_PC16),
 		REL_TYPE(R_X86_64_8),
 		REL_TYPE(R_X86_64_PC8),
+		REL_TYPE(R_X86_64_REX_GOTPCRELX),
 #else
 		REL_TYPE(R_386_NONE),
 		REL_TYPE(R_386_32),
@@ -860,6 +866,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
+	case R_X86_64_REX_GOTPCRELX:
 		/*
 		 * PC relative relocations don't need to be adjusted unless
 		 * referencing a percpu symbol.
-- 
2.47.0


