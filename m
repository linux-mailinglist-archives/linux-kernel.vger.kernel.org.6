Return-Path: <linux-kernel+bounces-380276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F278F9AEB6C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CC71C2247F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC81F80CB;
	Thu, 24 Oct 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNf6vcTU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030AF1F5825
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785990; cv=none; b=hUo8OA5ziLusuJoHLkhcab3PYzgkJsBHr5MHxqzrhr8C1cktp9pbKo2USZ7BdaQhKpOQqr/wnSBrDCAYNMWQ2SN15fdfVBRIB3OJi3XfYi4e3QG+5SLvIU3nCYnhHnATrSJhcg/G1aunUCpa2qdQKL43ohS3wf/NSaCtc4k8+JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785990; c=relaxed/simple;
	bh=WAvb8deVOd/vKnE5XvJDA/BfDiTCU+46fRIbfkvknyY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iCPQpTLJwSz76cix4B9pxkzN/6HxU9wNOql3u8AlPvXIVF5O588ewJjUXMdP1qsJ8AjnTViwtHFD0+aDI5lCSucYv7ct3tDGijN78kU59xwkPbdCE7y2oHRojD4BBX9XCDtVRUv/Ll+xccfDz3oVxt5ofVE4uYnSkkEIOGe9ZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNf6vcTU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e297a366304so1902045276.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729785988; x=1730390788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Vlh+OWPEJjqhnR1Dpqe4iO+ZlrNapO4KnJxZYyLlWk=;
        b=gNf6vcTUYfGeVfQ2d+HLOWaf6axfUuS8U6fECfce2z1zPzZQ63MxW51hUdGE4U3v8E
         d9Pbu+F0AqV8bt0ux2TLeMWVMV/JNQfquF9nNGiyAwKfVCTcZaZlgNZ2AFWMgfPD4Phn
         KN+mTnF9pEwjxz3Sn/U0dvf1/+0zqrECvDE2c/gb+JJlAQXHPu2jxbbgrfsXt2MqFYnn
         /Bu5V1u+P7m8tGx+7BfWhyoNCoBiM8vSPhhRX6lXveOb3arCRTfyxpyT9ojJljwtbPX2
         wu2+Ur6hgo1ZFkWm89sN/ABeHW8bD4nlDFb9vQ360kozStxedtR6r/5zjRy1TimEZnfh
         Aa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729785988; x=1730390788;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Vlh+OWPEJjqhnR1Dpqe4iO+ZlrNapO4KnJxZYyLlWk=;
        b=MAL+SDtejzWUL16Z9nJ35tRZDmSJyKGNe45h/6Zdkpe+zr3zUVbxLGK/iilVf6OdoO
         +PgPo61Ncj9GlMY1atcynJKIDyU0BNLGl1aWgTg76tFvAxID3Q12XFCqUvxhMhw3Yh1i
         D/RAeQWf34kNl1/DtFip2gqwgW/8zbRJxxF4B0R+qDRi/rWn6a11jnuED+6wHkNLBkP1
         KCh+p0+Vc2XvQc4zr3d4yB5ZgUFXNvwXM5wMMKn0VkvIhtbJ26NShdYhCaf6JVjC/pCI
         XKH84z1CifNs1TXtlbwuYfbWCy9/8+0ELxD+XH/4qJL/4ArsqQOyFH/JYMwwZPLWoJ3A
         bSzg==
X-Gm-Message-State: AOJu0YzF2FSpYY9A2racTh+twPUW6Eq3W+nHi4b8x/y9FNcjFej0lvXb
	wD+CBDDOnEFc3o25PbPln4ekfFwAmjAMXMOAY8n+iBS5IQTR1oBBOW1gCb76CIxTgosU1fF9nKH
	EIOhKl8FYrYDqABh7iz9RvKw44NgXfdtwrnkZQyzRd6RpbOn9uoh+S/JMXA/oSbnEMiadlylbGE
	jZrsse1jE3+BAOevBoPsN6apHuzBOAGs0DxnQ/MPLlLtMu7Tj9I3E=
X-Google-Smtp-Source: AGHT+IGaTNB2cxvpZfiLTZ3lOLyBwhFAf/NyceFQfu/ZPNy7VLbkaYQkYEfTc8o/kTdRiS7SjTcDccubMooCLA==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:b113:0:b0:e2b:ce2f:787a with SMTP id
 3f1490d57ef6-e2f2302ed44mr7753276.3.1729785987546; Thu, 24 Oct 2024 09:06:27
 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:06:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024160614.1894599-1-smostafa@google.com>
Subject: [PATCH v2] Documentation: Update the behaviour of "kvm-arm.mode"
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: corbet@lwn.net, Mostafa Saleh <smostafa@google.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit 5053c3f0519c ("KVM: arm64: Use hVHE in pKVM by default on CPUs with
VHE support") modified the behaviour of "kvm-arm.mode=protected" without
the updating the kernel parameters doc.

Update it to match the current implementation.

Also, update required architecture version for nested virtualization as
suggested by Marc.

Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>

Signed-off-by: Mostafa Saleh <smostafa@google.com>

---
v2: Update nested value also
---
 Documentation/admin-guide/kernel-parameters.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..d5b771e5cb5b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2740,12 +2740,16 @@
 			nvhe: Standard nVHE-based mode, without support for
 			      protected guests.
 
-			protected: nVHE-based mode with support for guests whose
+			protected: hVHE-based mode with support for guests whose
 				   state is kept private from the host.
+				   In case hVHE is not supported in hardware, it will
+				   boot with protected nVHE.
+				   nVHE protected mode can still be forced on VHE systems
+				   using "kvm_arm.mode=protected arm64_sw.hvhe=0 id_aa64mmfr1.vh=0"
 
 			nested: VHE-based mode with support for nested
-				virtualization. Requires at least ARMv8.3
-				hardware.
+				virtualization. Requires at least ARMv8.4
+				hardware (with FEAT_NV2).
 
 			Defaults to VHE/nVHE based on hardware support. Setting
 			mode to "protected" will disable kexec and hibernation
-- 
2.47.0.105.g07ac214952-goog


