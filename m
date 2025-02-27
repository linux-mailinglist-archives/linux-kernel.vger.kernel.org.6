Return-Path: <linux-kernel+bounces-535216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9AA47039
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534847A815F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABC82C6A3;
	Thu, 27 Feb 2025 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsN5ERQX"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B750EED8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616400; cv=none; b=G4XOoPT1/yaSutTfrKRhAZj936MCkbThdySYz+xsBsG1dyIXYr5bQYIbtMwC0gMtgUm9dc5GXsirSlEob2NjnTPlwedj9BVMofD24ZH4+yBFHLYV4wH/O8MMq7IgpHoF9Cz7xgOcrRAQX8ZQs1BsM4cpDrCVyLDhUK4j5PBzjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616400; c=relaxed/simple;
	bh=261ZPCgnrvvDXYcolm1gc3HyK99Q/XfdlKS2Gd7awrQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G6HegHxg6IUIl5TA7MlIbo2/HRZWfXZoGhDU9ryk69gYbvTkUQSnL1drg1ZwvgxwTLEGL7hFjhdtkPZOPgoau3MD95EowrcIBGPPuvnK78+qnO/wAp+zJrLZHxxu+rGMwoD8QwsV7BkcqZubTBEbJ/zcU7XnZ7Yhv6HubgD9BPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XsN5ERQX; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so34139766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616397; x=1741221197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nP/0ASv3gZv6Dq4JFLJ6V0xk++r2sqgnKrNUADZ27XI=;
        b=XsN5ERQXwm9d8W72NIbybPof42gz4GaMRHviYxZSVjJ0gV+f5YBAMbiQnGHobXGstw
         6/tXbwAkJ13lNR4aeQOEQeWsHL7JLYKu2eHZohCJ6MDVHbb3QX/OqyDdwz0MV1zSi2dz
         aZMSqQB1eeh785JZgSWRrRgwVv+wHUdMW2ECcppYvdcu2CxJtoGuTj1F83cGw49poupp
         vvSubl1sxotVHHrabIbiUi2aAt6j2wabNvUQj6o8hPk10AY5TrCZx2D1pC6B+6Hi8NAq
         RIIEGJhfcobvEZ+I7MVi/MZ1NL3wlL2mjNIzFhfNInZ0TINOxkea4PCSExpCM3EkWbM3
         MFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616397; x=1741221197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nP/0ASv3gZv6Dq4JFLJ6V0xk++r2sqgnKrNUADZ27XI=;
        b=cw3+lGFZupK3lXIkoeIIRpT1BIqkWRE1x2hPzw4dq88JDGZw84i2OY4FCfBWk1/R0e
         U1d2TPc6B6bbAtrG+QHc7pefdCkCtXepLi8WETOn8O20GekX0USJ3DflYvfCV6kLA/Mf
         Sp6cFYId4BbhMWGcEdoxfc1EvT6YW2nPISJnVkUjg/Y8M0qLIuLfPIeC7pZhjfoK77SD
         aMu5pkK3tPUnKbcWLNJxV1cip41eeopiBi2L9FdD9w77reeGEkpI2IRR3TJiQYNvHgn6
         otCclln+u8bRP+C9dkETAn8x4UiZG3pV9D/AOctby4Qbo2oWjCdwIXNC4PTVXyGLrdSq
         zx1A==
X-Forwarded-Encrypted: i=1; AJvYcCVnEDPwtnZ/0LvWnWpFQVZn64eYSot5KWAMxkW8303EQeHg/S/t7nFJ3/ym8SMpuboFQ6qdDu32IoTx91o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUo/aZPEKDTfy0VkqvDOHODcv0/DcjLRKeZVm8ajwuGRTu1Qgs
	ki5L/l9Z0XvswugJCj2NobHUhvvaghEF4bKw2Qrnb7Pepe/aqq1ZbdvHH7TCJ4H5SM3/p578vIs
	Y1cPfyA==
X-Google-Smtp-Source: AGHT+IG1YIW+GqBALCieMnU4BqI9X9ToFAuUlbxFKvAcEIATQsa5h/n36+QHjYaFBr4TgnPvu4HEXBtbRBDi
X-Received: from ejcrr23.prod.google.com ([2002:a17:907:8997:b0:abb:9ace:21a3])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7841:b0:aa6:5eae:7ece
 with SMTP id a640c23a62f3a-abed10179f1mr945776366b.43.1740616396839; Wed, 26
 Feb 2025 16:33:16 -0800 (PST)
Date: Thu, 27 Feb 2025 00:33:06 +0000
In-Reply-To: <20250227003310.367350-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003310.367350-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003310.367350-3-qperret@google.com>
Subject: [PATCH 2/6] KVM: arm64: Use 0b11 for encoding PKVM_NOPAGE
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Quentin Perret <qperret@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The page ownership state encoded as 0b11 is currently considered
reserved for future use, and PKVM_NOPAGE uses bit 2. In order to
simplify the relocation of the hyp ownership state into the
vmemmap in later patches, let's use the 'reserved' encoding for
the PKVM_NOPAGE state. The struct hyp_page layout isn't guaranteed
stable at all, so there is no real reason to have 'reserved' encodings.

No functional changes intended.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 34233d586060..642b5e05fe77 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -13,18 +13,15 @@
  *   01: The page is owned by the page-table owner, but is shared
  *       with another entity.
  *   10: The page is shared with, but not owned by the page-table owner.
- *   11: Reserved for future use (lending).
  */
 enum pkvm_page_state {
 	PKVM_PAGE_OWNED			= 0ULL,
 	PKVM_PAGE_SHARED_OWNED		= BIT(0),
 	PKVM_PAGE_SHARED_BORROWED	= BIT(1),
-	__PKVM_PAGE_RESERVED		= BIT(0) | BIT(1),
 
 	/* Meta-states which aren't encoded directly in the PTE's SW bits */
-	PKVM_NOPAGE			= BIT(2),
+	PKVM_NOPAGE			= BIT(0) | BIT(1),
 };
-#define PKVM_PAGE_META_STATES_MASK	(~__PKVM_PAGE_RESERVED)
 
 #define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
 static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
-- 
2.48.1.658.g4767266eb4-goog


