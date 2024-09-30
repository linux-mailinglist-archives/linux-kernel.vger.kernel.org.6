Return-Path: <linux-kernel+bounces-343456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C07989B20
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F98E1F212C5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237D21547DE;
	Mon, 30 Sep 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLGSAn0P"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473B56742
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680530; cv=none; b=ZOJ0sF9Mv7HjbNGIxItrpNZ0iAJtcY1RE3ZtHoc+99Swe0YXj/h0bVGuH4pPOqp8HYtkev8CvEljkp5P5QuYc2y8S/JDK5spbcxdOLSsRHGWncOwWvjhp/EVxXj6RhKLN8/T+rB+6bN/Z2fhbahNZqoOAUhMx6E4FqahVQDP9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680530; c=relaxed/simple;
	bh=negPutfUwJjL/8RYvy+Q6JXDiljFdvhtl2+JE042uuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZyZArYbSbNW/ueqXy+OTJNt+E4DS5CCK0p7qLriz4dweL061BpMdzZSp7GNU5bMRKyBZVMldbVy1yGjwCgu97T1Ay9rAUi7TT1zdZIqbFQk6VDvU6iBycPnKKPXEXyKSJy8Bh9xI9oPrc+8W3/6iuDMmK+Gk1y+2nAy2X7KP7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VLGSAn0P; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ddbcc96984so59785697b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727680528; x=1728285328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsZTXhwK3mXXOhRjtLwXUoeG4XCPMITRRWukmjYsd98=;
        b=VLGSAn0PYKPedmWb4n0NjHKSSCb1yzfgW8uClhBdj1VZCSb+b5XulnZjLsLPm61AXN
         0LdbehBcVMe1yp8S+hcCI2SsNRziiXfIQMO43NMI+WMGP4pSaoRl2cIsHqDhImDokUAf
         ANzWp2c5Q+xAVzmd4zt2Ifns9AiDM9Yya4Gvhki8trbLSaar8EZSYOfc9ccXLsz/+W9f
         D0SmMuvYXIMnTSMZxEheFZ5uxNEyFVVw+Teh1hlqukz/71MWA/Wv5yT0mBZmbD5L3+nE
         HQvkquUnxaHIjB7einDbryNcb2ODT+dbrD87sFo/RynOM+z6uQbILXmb4EsNUiJ+xTuL
         Hm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680528; x=1728285328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsZTXhwK3mXXOhRjtLwXUoeG4XCPMITRRWukmjYsd98=;
        b=gBTzBBC0NFijpqUY6WPeM9cGIuuoF5IHJmf25EMelVk3mNVg9RN0wEmeZULxvbLg3/
         YrMHNBn/EH6neANW2fIhEOvLxIkwvP0ULPWy+V7PMHSlvJvi6l5HGjAY8F9xNEaNYEYW
         CrquMA4uQzNFghHCYdMQbrkxHWAeYoVBg7evony8ncbzUa1NWDa9AQCbDz3etPQTDKzY
         BSEFgAEQPMB9OezX4ymNnTENcAinVGdkJ1knkg+YP1qn2NEWEWMKmg6h+uyc6Q9pacxz
         /cADjb78lpBCBJf7Xc9TFeqTtp58fbQXoLhgLx90y7Uky0u2sWQnuQt2yNpGyG3JY/51
         EL4g==
X-Gm-Message-State: AOJu0YxX5KTWCW6cT+M1uzXVifbChcmkGH56OkYr8f8xo4KEUqXWtuFk
	5alXNtQe63SJfdoX3n/ziLaRoYE4UMfGsOhYmw3r8P1yR40BVI3v2J8z6/G2Nzbq5E/Soi3VQYm
	kV8yC3qzuGMo6Mcz27KV+Ilp46WGQ/BGb+WZLL2CxHcVu3TZqxNOLptSu+NMtOBz0M3TxT3MSkK
	2WuZMXIebOjRLckok9yU3GprJ0PoznPA==
X-Google-Smtp-Source: AGHT+IEEITnmcH5UeTV2zllc3PmFUNjrBWClElCZQ6t5GapgJ1dmZhJuA8uiVOK2ULv5OhBDd14Xgcyd
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:c83:b0:68d:52a1:bed with SMTP id
 00721157ae682-6e2474d2257mr1919327b3.1.1727680527795; Mon, 30 Sep 2024
 00:15:27 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:15:15 +0200
In-Reply-To: <20240930071513.909462-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240930071513.909462-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=ardb@kernel.org;
 h=from:subject; bh=DOghVKCQRkP+2PZSSBUfsRwzGz2qTq1yeEJiIzZkHRA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe1XAPP+CW6ZqxccPKowL43/Tf6HExp8dsf8IuIdo91Dp
 38VbpvbUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyP5ThD39HQciqZ45X7a+I
 V/w7Vrn2CUPYFo2E0GfiEzqK3SeJaDH8FaicbvpzA/e5xw8uM6jYfnfbb220fSNTS1jDbtfUmGu XuAE=
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930071513.909462-8-ardb+git@google.com>
Subject: [PATCH v2 1/5] x86/pvh: Call C code via the kernel virtual mapping
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Calling C code via a different mapping than it was linked at is
problematic, because the compiler assumes that RIP-relative and absolute
symbol references are interchangeable. GCC in particular may use
RIP-relative per-CPU variable references even when not using -fpic.

So call xen_prepare_pvh() via its kernel virtual mapping on x86_64, so
that those RIP-relative references produce the correct values. This
matches the pre-existing behavior for i386, which also invokes
xen_prepare_pvh() via the kernel virtual mapping before invoking
startup_32 with paging disabled again.

Fixes: 7243b93345f7 ("xen/pvh: Bootstrap PVH guest")
Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 64fca49cd88f..ce4fd8d33da4 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -172,7 +172,14 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	movq %rbp, %rbx
 	subq $_pa(pvh_start_xen), %rbx
 	movq %rbx, phys_base(%rip)
-	call xen_prepare_pvh
+
+	/* Call xen_prepare_pvh() via the kernel virtual mapping */
+	leaq xen_prepare_pvh(%rip), %rax
+	subq phys_base(%rip), %rax
+	addq $__START_KERNEL_map, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call *%rax
+
 	/*
 	 * Clear phys_base.  __startup_64 will *add* to its value,
 	 * so reset to 0.
-- 
2.46.1.824.gd892dcdcdd-goog


