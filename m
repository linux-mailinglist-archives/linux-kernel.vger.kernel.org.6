Return-Path: <linux-kernel+bounces-340338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D99871C9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A2F1C23345
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC001AED29;
	Thu, 26 Sep 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZBldBfx"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5A1AE85F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347320; cv=none; b=RBpCSUmI2dkKs/6T/iXnqcixaNu4wBIuTut/TEV0WkkjC1TXDBnZDeYRooMI+LR9Wuj07TtFutL7lFoYXq/FnIxzcrCAaRKmhnPVSUXvTspnP38OizagA9piBPyHJPqdnmlpwx6zjWxWSgFBxSHFz6Au0e3RaE41q7BkpgPVGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347320; c=relaxed/simple;
	bh=ofM5Tz88RWUMVPKc1VbBBI5JtPzQ4eU6jClTGK23pCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IdX15Whx71rVFfIZzT1+Y/HemqIZCIXTlM6h5hjt9O310Oy44Oddp6yDmv2iuSQcQxZ9uEK8J0et7y9simt5bpUiv5VShdc6bB4BjEHUHNnhXmjXH6/JOOaVMtIRgIjkoB8tD7Zrn7oR7LvwUl1OHwZuf50ZVdzdQxnZE5weWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZBldBfx; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a8d1095442cso62224966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727347317; x=1727952117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ownyzv9FvJUARNva8kkWN7DdL7kgRVlMI6W55f3d3tc=;
        b=tZBldBfx510SyguFnKbfQw9/93R0XAX+sS48Bnmi9kccE0Cyd+yqN42RUJhWfUbATY
         yVPROwfbGaekPF5qHbsPthwYcNhpD25X3Suz1uRB/8M2tkBt0dps2mhQn6iae3B6pqtx
         CXtNBU/YZiNxKSuQOZlllunln8OySvwNPBVBLJAgk1GmcHuE7ZIx0/ZzxMDuggsKsYez
         88EFJMnzkhZAgjB+PO58uKm4YizasKAZvlt4SGbhkGvVDmBuFA4/8gmxuhZg9xnO4uqJ
         hpSUmwO919GfxCotKO+nHFhu+3ywqmBnbFQVPexGRNhc7X6R7qpfVz9UvcCbB0wQOI7v
         rSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347317; x=1727952117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ownyzv9FvJUARNva8kkWN7DdL7kgRVlMI6W55f3d3tc=;
        b=PMAOwKpC1KXpjRE9eJCumB3rDNX3cMxWraJJUC68qi6FqedFKMLJGJeptfzBFJ+WTF
         6d3Tib2vL4YHBFVq6E1nsb6+EJLdKifkZmj01PaFPxXvxBWkJ2jxP8sH47280kYs5JKS
         18guIKcapztVh5jbs6lMq1/M50xMj4UjigO5mbHvxQPP65qghEzUsGfWShCDm47bKmu4
         SIy26hfTp8E93+Dii3a+IHls6eZ53sXEV9vZ4Rqj9ycjCXKrV1kZrUz4vZjyR8WXebdo
         LgVN8Vtejtvb+4jsUEzSqzSU7zRz/G1IWpGbWNlA74868gGtaeVxq1LlYTgLkmbmUWO0
         4YTA==
X-Gm-Message-State: AOJu0Yx39hGkI87roT0yYXjqYwHvSTAzcUVQatTaJbe2ZCDrYcq94jlY
	65dATySvUdLDXYWS+oC8uMwhtNVFNswQQIYgifmmqeCHKGupV6V5I/tQhyDA4frkuYkFhZGVwUz
	x3DcHR8HmqDmDABPF21Ukk3oydthHUX5/nODhJ8+7s6e8sDGOo2mKS/zE9YomW9+ZS2TZtA6RHy
	bPDO8lH9mWMj9ZTimZ7yJk39ehajTMhQ==
X-Google-Smtp-Source: AGHT+IGy82jujwPzArGAUf1MuUGtrrrgAoLRL/QZd4vc5rXaUoeqVqj+O60HWt1N3meFf9X0ymoxcaJv
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a17:906:1642:b0:a7d:e176:71d1 with SMTP id
 a640c23a62f3a-a93a05c19a3mr293266b.9.1727347316493; Thu, 26 Sep 2024 03:41:56
 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:41:17 +0200
In-Reply-To: <20240926104113.80146-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926104113.80146-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=ardb@kernel.org;
 h=from:subject; bh=SK89jirZxlyhNPfrfzxj4qoYkybGiruH5hLSJPLATEs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2rlZ/E9V0L29KWOv/h8NISPt5Qf6nif2NoSM088ZqgV
 b0Oy9Z1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIl81WD4Z7rxIf/2XQpOzxxi
 q5977XTzWHJUoKvkSs5y83eJYekuDxkZev2uM8t8FD0tYzvjxseQtEWvZX8cSOZMLDU648yRJyn GDwA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926104113.80146-10-ardb+git@google.com>
Subject: [PATCH 3/5] x86/pvh: Omit needless clearing of phys_base
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Since commit

  d9ec1158056b ("x86/boot/64: Use RIP_REL_REF() to assign 'phys_base'")

phys_base is assigned directly rather than added to, so it is no longer
necessary to clear it after use.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index f09e0fb832e4..592747f2d731 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -179,13 +179,6 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	ANNOTATE_RETPOLINE_SAFE
 	call *%rax
 
-	/*
-	 * Clear phys_base.  __startup_64 will *add* to its value,
-	 * so reset to 0.
-	 */
-	xor  %rbx, %rbx
-	movq %rbx, phys_base(%rip)
-
 	/* startup_64 expects boot_params in %rsi. */
 	lea pvh_bootparams(%rip), %rsi
 	jmp startup_64
-- 
2.46.0.792.g87dc391469-goog


