Return-Path: <linux-kernel+bounces-357192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE767996D4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221BC1C22335
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B6D199FB0;
	Wed,  9 Oct 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3iWbKCp3"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99681EA73
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482923; cv=none; b=bHfGnM9pt3UhyFRKYfop0CKXtDWSde+NoIBqgj6gk9L/F3M7VEtlGo4N6SaAf8Tb6G55y7aW3ey/RdiNXG4zGQ0BfrqBIu65sBYyjDhXJHEGgVQdSyjMrERGiAj6JbEcVL8uWUco1ICLdmtQpAPYw+jihITsaoymst7ofyGaidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482923; c=relaxed/simple;
	bh=KljJxQ/OWT71XfVWKRRyLm/W+KW1HyZb0g/1eexmMM4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BAMWItr73YlpTI4+T1gKilR2gkWgpqJVLiZp/W10ufOnze7kXwPJN7OPgDuTTSzyAqAO21tDZF0RoXSOOMeRHML/j6LCqjTdut02A4ujMO4AEWQOIkKkcHotcdQEZBBkEx16KJLSmvhlMDcVAHj/ZcU5NwjK4bRjUA8G2HAyGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3iWbKCp3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7e9fb5352dfso5258889a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728482921; x=1729087721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/TgKPDJtlyGGleExLO5W0VtSazwFjGgCKY+93bmZ9I=;
        b=3iWbKCp3cxMKZ+CecI+q2+yfl4TdOv7l/sXRV5JDlTpXKWMQFqZx+9TLb/3qSfU4Ow
         m50oNFGTalWGjorycanidTd/I1zNGiuM1VGHBePRM/45fpdlt1s2ujvjnvXPB+u0y1Bb
         55CswlsuJhCCkraqWLFtcLGnQp4ObqPBYpf9O7WkrDBarMHYbVdeYw/Gyvlci0wuMdH5
         6ocqCEyJhJGqdBqsFMolGhgWhV7gDhkoFG09KkN0mg8f4cNbAY5nvk/Dzz/NW6pWbz1K
         rt85Y4trHNiaQn9gJ2q1GGfgVEKJrTC56wEF1yP15qRkZ/vyhtcWY+2D/Ns2BFSZA9RD
         JStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482921; x=1729087721;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/TgKPDJtlyGGleExLO5W0VtSazwFjGgCKY+93bmZ9I=;
        b=poQCf+2rjVDT93S4pTs/lD38BJ13PiOjwSI3UyzszENQf19JbOhcStl/+AkBwy7be0
         Mzuo63KsikWPTqLxE75ZNKU7xgvaTwta00ni6IJsvoqE7Vc3FMcUvxT9gkGeHL3hxUpz
         DXx0yScg1qL08V9Ngn6c3Sy7Gn/4fWtyDUn6yAAfdpWWolNfYCW0BsjvsH19IxTpRs/J
         Xw61WbcK8Km62HaebQZOOjTYPsU2pzmE0BDTinLPGHmlQXmBMkqTAkSxLCk09eceHoPw
         Wfi6bW0OK5/S7AAWwQ4BfSaXrRMTIo+yf4YvLlrhuiAm2Oh2JCC6a5YmrpfiUnpYAJme
         cggg==
X-Forwarded-Encrypted: i=1; AJvYcCVEMIoNMlL+8HG/d9uAKF3z7MIj3baSgNDvlmVAl0iWMzbhqWazEfPMA9/DBo1FtX53M1V1hW1lkiKlqRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+/2yI1clCVZxBZS+Q4Laa/tW5pRkVaolGRyUEy9zMsWWndUM
	En5vo2jcz/yYqL4PkC16UJbIuF+BzzyoXXWaU8X/b+MX6nEx6tQRm3PPKfP3BuDZv9W6yMnSq8s
	lCw==
X-Google-Smtp-Source: AGHT+IHntPVw5fd0BlDT/g077iqrcOvcnBRJX+HnjviW7h72wCo00ygJwdJoZdAmZWM/SPfDqFzQU1v0bH8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:db52:0:b0:7db:1b12:5e08 with SMTP id
 41be03b00d2f7-7ea32095d1fmr4582a12.4.1728482921005; Wed, 09 Oct 2024 07:08:41
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 07:08:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009140838.1036226-1-seanjc@google.com>
Subject: [PATCH] KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kirk Swidowski <swidowski@google.com>, Andy Nguyen <theflow@google.com>, 3pvd <3pvd@google.com>
Content-Type: text/plain; charset="UTF-8"

Ignore nCR3[4:0] when loading PDPTEs from memory for nested SVM, as bits
4:0 of CR3 are ignored when PAE paging is used, and thus VMRUN doesn't
enforce 32-byte alignment of nCR3.

In the absolute worst case scenario, failure to ignore bits 4:0 can result
in an out-of-bounds read, e.g. if the target page is at the end of a
memslot, and the VMM isn't using guard pages.

Per the APM:

  The CR3 register points to the base address of the page-directory-pointer
  table. The page-directory-pointer table is aligned on a 32-byte boundary,
  with the low 5 address bits 4:0 assumed to be 0.

And the SDM's much more explicit:

  4:0    Ignored

Note, KVM gets this right when loading PDPTRs, it's only the nSVM flow
that is broken.

Fixes: e4e517b4be01 ("KVM: MMU: Do not unconditionally read PDPTE from guest memory")
Reported-by: Kirk Swidowski <swidowski@google.com>
Cc: Andy Nguyen <theflow@google.com>
Cc: 3pvd <3pvd@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d5314cb7dff4..cf84103ce38b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -63,8 +63,12 @@ static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
 	u64 pdpte;
 	int ret;
 
+	/*
+	 * Note, nCR3 is "assumed" to be 32-byte aligned, i.e. the CPU ignores
+	 * nCR3[4:0] when loading PDPTEs from memory.
+	 */
 	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(cr3), &pdpte,
-				       offset_in_page(cr3) + index * 8, 8);
+				       (cr3 & GENMASK(11, 5)) + index * 8, 8);
 	if (ret)
 		return 0;
 	return pdpte;

base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.47.0.rc0.187.ge670bccf7e-goog


