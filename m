Return-Path: <linux-kernel+bounces-421406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C72C9D8AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1318128944E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B01BBBE0;
	Mon, 25 Nov 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzgJ1Lw2"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1C1B87F0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554281; cv=none; b=hi6T5A7ENJAmABUVdTFMOyAgtq0e2aYCv3gTA5AP3+UazyNsVtE80B05DNpk1MwaRNA6OH6v4LbGiCaLxLVxvR7GTx3zEtdfKMZzWNt8deKzYdWZ90DuavQ58aNxru+sm1buiRJ0nR3NBN0vWMVyc87rAjdrV9zyvf6kQi8i8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554281; c=relaxed/simple;
	bh=j2tM4QD1SkAtREWke8zQejYp6BaqA5p8HjugUKNYyjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j5u9cb0eZ6lnP1EaUQDlnNNyDgXuizMDdUbPqMR9lIb6VAgkzSQaS0wptkHGnle6LXG6P2z+YS6pGCodM46bUY/yzQMwruu6RNd3veP4ZgK9tC0k7/J8rlyyHDPqnPEDbHXtYNoylWbl1QfcYrEb1lKehq/DjBi47l4Lde5dvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzgJ1Lw2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4349f6b337dso10598675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732554278; x=1733159078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3c90HGYf1jO28WhyRh+s+PaLSbRY1NkwjCczIX8X8Y=;
        b=JzgJ1Lw26MpQwoVtaD+tdHIHWui+TDYupLYB9piyp0oqpEcGub3hviyR44AihSzF6Q
         fT4mt9i/vYS82PwtrwaePTAXiKTpzmKdSYcBy/qfJNXdCxTq1aOJmHrPNlayl7W+ufdu
         LXEP34/0Hpd59gDDkTsBfkzrfEu9NriRjkyflXitr2Tm26gJbpy3k/r6rXlVlPRZz4He
         XkQ4ZFgTZvwB0y1Nd9J4CDBfg9QA8+JyldNcoqIONv/kbkYb9IU1fxO2vUhGo/zBd0sE
         fLebHTRPxtBxXw3dYYo0azHfOTkVrzOI7TY6OI7W9TYD77QOSeyvY82UoBxVVdxsKRza
         IpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554278; x=1733159078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3c90HGYf1jO28WhyRh+s+PaLSbRY1NkwjCczIX8X8Y=;
        b=Fxqc4z/nYOsBMmTfd8v5C4mICNzkm8cAejkqoD83Bi1t1V5I8kvGZfQ4aRcf7njrv+
         OeGk+cYOkLPtD6X2h11aRHLaqJlPUOdQQiMv6z+oz/ynfsfCE+cwKHcRWRwWB+KKq6/H
         iqJERLIGYzjRc03j67vh+vNMVvTCGAeOqQzZ8r+NQpbXo4pQ+A1Gk8UG5Jj7mk/mIUvk
         xiq+oCpOMxtRH51NND3fWRCcTC/Nm6TTN5Dx/JgGBvwQK44z+dZ+f0sT2TqD6+xPKznk
         KEJ3acTHlW9n5HBrOM34sYUfxgSpe+rHjkR5mDPsbBXPp2pNArtSElWTQiGsB4LVoey1
         YqQw==
X-Gm-Message-State: AOJu0YwQNCxaVK0egbxuEKBEjreIefBnRCWAI9Pa/a/seQBLr/v1s37H
	hDu8HfCNGMM9Vftnjz/Pao6px+vUYTr6ru9SugeiS+B3r/MVDnW5dX19WscMg2oSSfiV28r8yv5
	FIT2NHd8kVqxaPgBVOZcipCN3X1Y7eXeYIV/TiAw4NJjAVB+uIXB57BdRJe0PW7M5lTZSvRpF1b
	e6uwee+NYlYKOB2OTVEyGTUlfZXvqAow==
X-Google-Smtp-Source: AGHT+IGqAU9eSoeW3uYNkvD7b9yiALLO6GGEjSyjsNZJSVnLsO3KBCkqBuahwUwwZfumVTGo1Ge00/nC
X-Received: from wmov21.prod.google.com ([2002:a05:600c:4715:b0:42c:bfc2:aa72])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2803:b0:382:4a4d:9a10
 with SMTP id ffacd0b85a97d-38260b8134dmr7134508f8f.29.1732554278549; Mon, 25
 Nov 2024 09:04:38 -0800 (PST)
Date: Mon, 25 Nov 2024 18:04:16 +0100
In-Reply-To: <20241125170411.1898410-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125170411.1898410-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=ardb@kernel.org;
 h=from:subject; bh=fDaV6XJBfFZfNWU7YK2EDKa7oVLcbnDeTar+kji37cg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1lnfC5q80cB30Y7c5kHPDLS/Zumv/N5sSqp38mtvo0J
 za4LirpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPxX8TwP/T5XJuZcT1llyct
 VtZs9Z/fXmtWuOiWgP1e32mmPExL/zL8j7oiX9yyZMHE37ePXrigUDLH+nfSS0tJ/m6P1spHfEL arAA=
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125170411.1898410-13-ardb+git@google.com>
Subject: [PATCH v3 5/6] x86/boot: Move .head.text into its own output section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In order to be able to double check that vmlinux is emitted without
absolute symbol references in .head.text, it needs to be distinguishable
from the rest of .text in the ELF metadata.

So move .head.text into its own ELF section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index c98bc91bafef..9c194df2c8e4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -135,8 +135,6 @@ SECTIONS
 #endif
 		ALIGN_ENTRY_TEXT_END
 
-		/* bootstrapping code */
-		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
@@ -151,6 +149,11 @@ SECTIONS
 
 	} :text = 0xcccccccc
 
+	/* bootstrapping code */
+	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
+		HEAD_TEXT
+	} :text = 0xcccccccc
+
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.47.0.371.ga323438b13-goog


