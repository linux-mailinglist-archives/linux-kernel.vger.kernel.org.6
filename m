Return-Path: <linux-kernel+bounces-245887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0534992BADE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23A21F25F41
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFE15B980;
	Tue,  9 Jul 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1mcMZ8k"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4FD15FA93
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531269; cv=none; b=qnKasc0DpEw0ztiN45Iu3O1vwgNZC7DsPyjJqoXvXNA/XUFFXVMdWo716lQzV/fpmGWbapG9qrVAzc7yVG8QQzXf0WXdPTMPElGA4bXrcHRr45uD9INupSxPsWUITGn4QUVvdTpL28e85H4fR9WouBE0EJclS4oijw8AyQjv1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531269; c=relaxed/simple;
	bh=t3Nh4K0EgSspKbGVqz0X1bAV7PZaIwIZ1XOCKhOkTBI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JaA2EiViqm47yUZng/1nllMl0kap9ckprtC9vaigpM9vDB3uwth4jd3XIsSyngFsC+EYtJJ8nfF0yBLjg4J0DlEhY/XI2vs9NwE9d6QDLhG5uRv3iPlBPHce8wa/E1jMu+ohTzfVhK4xzc1x+MsVVdwjUu2F1wFPY7HC/JPC1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m1mcMZ8k; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70af548db1eso3879898b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720531267; x=1721136067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91y1ViYzzS22frzUrEAAYagk7sEQX2NaM9leAuKuoiU=;
        b=m1mcMZ8kl9L2eJ7+cmAkTvrTQHGReya4X2ZwEhfpOPmkImkqhlPqXpHb+Yf/MrwWs0
         dpxgebFhn7FdajE4I+PZowh/5zVL/l7vkx0TZeAOvisFFOk/LVfpdPlyYZB5SKac3HCv
         oNXDvNHvUKX7WOhd7Y9nT1uqi0kQ/RnDQ4Y6t3KWAAzl2RAHDpcZhdcV+gP5gqkafcyG
         4u8nl/ExJnf5ZbjpvHyBehXR90qeGaQbSvADM7snxahnC1YYJbwhzOW8vN4noxun/IT1
         to3KgoZpr2qDrmGbyo2WxQD1nk6+lzZFsW77Jencwum3CgcGbACjgERQKweAtei/zQxZ
         FKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720531267; x=1721136067;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91y1ViYzzS22frzUrEAAYagk7sEQX2NaM9leAuKuoiU=;
        b=noAwDX2+zn0nIlTWcF040eoY/Ij/DLtA3Vttxk+nJQraZ9fbn0lqUp+VfCITkKmgVc
         8u3fNmJZQ9YeOYxeSgJ40TN1BSO+/4l3d6HA6SAWxlEM2y4pUepdRL9oO+xwS6k+7lS0
         I+0jc7NS9byoZHC5AxxHGC7p3BFYDHd9BenRTmpvnDhSaCaal3DUpksrLepUixS+bfGM
         R2pnYGwZl4dsg5YFYfN16O2FeX8oxfHUZQemlxuXgs5LNo36Ae5N8lkeAIHl8vmonepA
         BHDHMT0Aee3fhO0wf5i6TeApMtde8hurvXjKb9HAkX2eYsXPkckr1FtXnfyistJQtcUw
         8Cog==
X-Forwarded-Encrypted: i=1; AJvYcCWGiQCc4ePcDijEpNtDVaBQrxgH0oDQRzqfknNhVDuK+VcxdyWVu+YMCWXl4dEfxi72mxGcv92iAAgyMuQ6F52wQst/5IsQQrVGN6kW
X-Gm-Message-State: AOJu0YxEAqrVnfK3v9oTcSv9ta9Sx3oyGP5PQRWyLdg8FSpQFESJG+me
	FC1LQWezjcygnF/5VwMnzOQ3t0gFbO0V7cYb3Ub5Cq0oa3QZgIVjyM4xcWL1Wl+CqAFmBIpevHf
	kb4MPAf8/9w==
X-Google-Smtp-Source: AGHT+IHnhhEo/FT7unUXOiYtEv21JGTtRWBB+eYjZZipziKWNkzvFRhxgaWH5sWuaB2RfGlZ23uG42E7bXzm8w==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a05:6a00:2d2a:b0:705:d750:83dd with SMTP
 id d2e1a72fcca58-70b44b5ee14mr89189b3a.0.1720531267259; Tue, 09 Jul 2024
 06:21:07 -0700 (PDT)
Date: Tue,  9 Jul 2024 06:20:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709132058.227930-1-jmattson@google.com>
Subject: [PATCH 5.10 RESEND] x86/retpoline: Move a NOENDBR annotation to the
 SRSO dummy return thunk
From: Jim Mattson <jmattson@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The linux-5.10-y backport of commit b377c66ae350 ("x86/retpoline: Add
NOENDBR annotation to the SRSO dummy return thunk") misplaced the new
NOENDBR annotation, repeating the annotation on __x86_return_thunk,
rather than adding the annotation to the !CONFIG_CPU_SRSO version of
srso_alias_untrain_ret, as intended.

Move the annotation to the right place.

Fixes: 0bdc64e9e716 ("x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk")
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
---
 arch/x86/lib/retpoline.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index ab9b047790dd..d1902213a0d6 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -105,6 +105,7 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
 /* dummy definition for alternatives */
 SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
@@ -258,7 +259,6 @@ SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ANNOTATE_UNRET_SAFE
-	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
-- 
2.45.2.803.g4e1b14247a-goog


