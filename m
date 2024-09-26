Return-Path: <linux-kernel+bounces-340336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A429871C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7721F284D2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE61AD9EA;
	Thu, 26 Sep 2024 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Pu5QtqB"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035F1AD3E9
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347314; cv=none; b=OjqinjPXOPfmM3oEeQEqJ4Tg58becbxd6vpTs6UbgjIVF2lZe1HxNOnXFbfqev0pynQN8eo37GPs7eN3b+gIXyhkIOgCVEP7WilJsmBbg/JowWBt8aCwYy+E6+QHXDjSf9IR8W2Ws2BP4mpHy2GBduHp3kvh0VyJCD9pG2k3y64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347314; c=relaxed/simple;
	bh=QdwTkH/9dvGNkik0JDrBUUN2zpdrQNY74f1T2YhQLxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uzIDe495tTsjKlFpR3W5aD7FXqdqqD7RFx7TbWYHe4FP6/hXI/RTxjzIjXbZatlOWBw0cVe8i0kzK95szBbaaB65ZKs9og/W5gOZfywObqLZ7wAKaXSOrz8+drufLGejTvNle+PQVNi3vQg+npvJBFXbEsPmtD1HqoL9LtiCyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Pu5QtqB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6de0b23f4c5so11273187b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727347312; x=1727952112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwoP1rcUlc5IEWvZoDzQ3o2b6cQ+HDztqml72ZvJe/8=;
        b=0Pu5QtqBtXoj8wknAKcOd6yRsOIT4hYfQOb05bP0P/jfEyo0ZP0PM3IgmSNMenh8Va
         T/4sd+R5NqdX19pTWWtlezx5Cr1u1FlP8rzhJ4tzjOAjuM0I5v6fuPFk6Wo/kwa05sAF
         0i4MQAP9n6YXkpHik1ybh3GvI5cEtsIhtTHFibg5XlOHcuVDYfNf1iO7F+3x7EnfPepK
         2jpT6UlXEtYZVvgt+M02nziFkRwDE7kGkQR1nqRgHEF5s17VGW7+BgCp7Pz9I5fjRSwz
         Sq5KNir37SFHxJqDBZyxJxtaTmatg3uI8Ppd3540SCeCiqLBFWgt1EDF+eFmL7DPeD/Y
         /glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347312; x=1727952112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwoP1rcUlc5IEWvZoDzQ3o2b6cQ+HDztqml72ZvJe/8=;
        b=HTMWldSx3Ka0qmMD3HJjjROSUHZ/UsxboalqHtVaCom7Ro8JEwQTibVo3c3FFVClcu
         Zm0VH4mazxuU3gqt4jFdlrOjzkJm9qQQ8iupHboMP4DOPqow5Gh4lRjcH+y0qhbgHA5K
         ZslCg63UZFiJHEHSIDMlGYZq+TPc573VOqZFZIQ6T4I8W1/VJAv4eKQd7Mg7OOnBz8ZF
         qdI4Eg4xBe0Zu78Dh48SHS+dgL4AVG10v5Wlo4vcoJfFcygMjnvnVvilR4UuzckF4s8C
         SNCPoIdlr50CzKyITIfWwLMJx8O/U8U/qBvm1uDMPekt0Gwcr74KlfIVK283AMbP3uQa
         h0xw==
X-Gm-Message-State: AOJu0YzqAjT4/WM24ziek0pJTmg8mWmfJrOJOLrE7w/r80sEzh2qhv4k
	URwHAMD9ggjoox7yKYhnz8XcNFakchEpmpQO1fLbYv0E1wKKg5Q7btbyszhJFq8UOshcqF49C+t
	9OYeuFCcqTYMkSBfEl6FMU4KzOtAkYYY06ivnbE4SZq1CaN62rrxovovMg98Z7Z2O4uMu37rS1A
	yOxXbagufRp5gT+mrQJFTA1i6hRYlOaA==
X-Google-Smtp-Source: AGHT+IGFcogBWg0YNHvYrp22ksYkslUYaSpidn/WqA3QXt5WaLA/ISxC26Dr6MxOSXjYzk1lqyi8vs0/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:7203:b0:6dc:836a:e272 with SMTP id
 00721157ae682-6e22ec9e35fmr540887b3.0.1727347311481; Thu, 26 Sep 2024
 03:41:51 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:41:15 +0200
In-Reply-To: <20240926104113.80146-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926104113.80146-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=ardb@kernel.org;
 h=from:subject; bh=nGFC7zN3evy7O6d/rvxHyA6d64EhlpFJ+bJvxzbH5PE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2rlfekYxbphgk37j1fI2+6+6JyzKRrSvf5uPkYr2770
 /vy3/atHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiV4oY/uneq+0IOFzKn64x
 6dHOnxXrpRKSfhs4zFp0WuTkvae5c6cxMhxm0Y98ri366awCh9g15YlN/ov+djz78lvU7gN3WcX 8FTwA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926104113.80146-8-ardb+git@google.com>
Subject: [PATCH 1/5] x86/pvh: Call C code via the kernel virtual mapping
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
 arch/x86/platform/pvh/head.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 64fca49cd88f..98ddd552885a 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -172,7 +172,13 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	movq %rbp, %rbx
 	subq $_pa(pvh_start_xen), %rbx
 	movq %rbx, phys_base(%rip)
-	call xen_prepare_pvh
+
+	/* Call xen_prepare_pvh() via the kernel virtual mapping */
+	leaq xen_prepare_pvh(%rip), %rax
+	addq $__START_KERNEL_map, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call *%rax
+
 	/*
 	 * Clear phys_base.  __startup_64 will *add* to its value,
 	 * so reset to 0.
-- 
2.46.0.792.g87dc391469-goog


