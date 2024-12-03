Return-Path: <linux-kernel+bounces-429245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1849E197B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFA52820F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE261E260F;
	Tue,  3 Dec 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4pPTgUf"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A51E25F4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222262; cv=none; b=Vx17uBYumrQGc2WYLW1C3oo89/O3QgJTBllIcHVMReL1lcl3svsl9eWXWpx999+mtb9bFcl6RzFAXc1WRoegyn3Gqm/8NKi7ij1ZhCUDdEO7ntIUPUrrve1xH+6sMsWhdzzUl2Ecm+gbeY1RGmucD30iWQFU2/RTPYnruTcXI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222262; c=relaxed/simple;
	bh=Az1fJxxv/3DdXwUg7UmHqkk/Q/SdadU+SOIWO9/jJ8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IOz1aFlHeXsjo9Z6VfamTKkgaSa4VkORx3ZKcWpAq5FX5s+eGK4pR8+Ml/YslYIK/fHHmk8frw2eO3c4nGLqh1zFTMK4u0eqhw/Z63q2UKbmZzCh9C2LpFS49htuBgHZdQ6SkQuD8wSsrQINg4+82HvxM9rkDollCVxb7q/V1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4pPTgUf; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0cfaab94bso2236967a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222259; x=1733827059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqJAm+kSytYxVvAYW4fxQLPPZZDbz/LJCZvGfh8JEeM=;
        b=k4pPTgUfzm0OeciJu8SYK+DoEQP/o62UQk0iT0Zj8+3ZG1t3DWpiR63eyyusDMkf8I
         ZZRfAPHegLPVfovN8shcqJYncjXhgnGuXU8xBgx2F84AJh079bypyEWSzKvbBT3DD24M
         vRjLFONYFKtS4dDnt2k6h9DIT1Ifw5L47hh/cTC8xKq5gNf1dvGlBZJSEm3UIQJF/hoy
         rQv29LlCQZXQNbagMOJPE8qwECC6s5EfwNlnRuX9qtSeZzo0LhvoM5wc33+mDgHN73Y2
         oXH0XGLvESEfirjelAGGILFbYPuFU3yEyYkrquTbI2s7RMAH9naxaEk9l/azdfvFQzNJ
         nwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222259; x=1733827059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqJAm+kSytYxVvAYW4fxQLPPZZDbz/LJCZvGfh8JEeM=;
        b=WSLr/k5hAf1c0WoFGMMZiahXzVt3ieO9RvOQ8SxEcW5I0wpGeEvJ54MWWq66QerO29
         A7Bdh+37QMJ1ycoVZDUeEjNHgJSsfRzjlK7xoNWUdUDbEgOoG8uAzyjlUZi0YA4ZFYeS
         6f3WWYo/Mt6frYSW3/OEQaS6qQ2tIDyi0yPCTKxWF4GyUp5YmthC/wDM275qDd6R6DWA
         /r6iMP9f0M552+D3olF19r3AkBJiDO3EjMYA6tktVbF1+U1fYv0GX+We98HC/LWkOxHw
         AGNDvcNSdLKkYCXkjtN/ryYC1G2Vh07Z5gEOYcPATc59SSpvYLzWUExYirsHOFTPSy0o
         4MLA==
X-Forwarded-Encrypted: i=1; AJvYcCXFwI8prekLRRkr/7ZTyrInAMBA4Y8YJmz05zhVqt4dz0UFBAF+fwGTwFOxiyuqOoKM6SGdVfFYi8YDC1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqM12vDDLJ695bu5T38tzn/5V4qAuNhDWlzL169KCogT8FDlxl
	DIIn64SvVQLPqwx8hEqSug0dYf4H2zjR2H56QN6mtGgVXWBLeyyWdnZiWou1yGKTMLJeCPnmJKn
	U89iVmg==
X-Google-Smtp-Source: AGHT+IEEJ7rK/bdiM0bZrA50MGLa30le76F10afOeSti4NHKLxb/Hx80hARIZU6bFlY0t7qoOHZgeSespPMG
X-Received: from edb10.prod.google.com ([2002:a05:6402:238a:b0:5d0:d98a:2511])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5186:b0:5d0:214b:9343
 with SMTP id 4fb4d7f45d1cf-5d10cb4f1fcmr1754647a12.4.1733222259494; Tue, 03
 Dec 2024 02:37:39 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:18 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-2-qperret@google.com>
Subject: [PATCH v2 01/18] KVM: arm64: Change the layout of enum pkvm_page_state
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The 'concrete' (a.k.a non-meta) page states are currently encoded using
software bits in PTEs. For performance reasons, the abstract
pkvm_page_state enum uses the same bits to encode these states as that
makes conversions from and to PTEs easy.

In order to prepare the ground for moving the 'concrete' state storage
to the hyp vmemmap, re-arrange the enum to use bits 0 and 1 for this
purpose.

No functional changes intended.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 0972faccc2af..ca3177481b78 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -24,25 +24,28 @@
  */
 enum pkvm_page_state {
 	PKVM_PAGE_OWNED			= 0ULL,
-	PKVM_PAGE_SHARED_OWNED		= KVM_PGTABLE_PROT_SW0,
-	PKVM_PAGE_SHARED_BORROWED	= KVM_PGTABLE_PROT_SW1,
-	__PKVM_PAGE_RESERVED		= KVM_PGTABLE_PROT_SW0 |
-					  KVM_PGTABLE_PROT_SW1,
+	PKVM_PAGE_SHARED_OWNED		= BIT(0),
+	PKVM_PAGE_SHARED_BORROWED	= BIT(1),
+	__PKVM_PAGE_RESERVED		= BIT(0) | BIT(1),
 
 	/* Meta-states which aren't encoded directly in the PTE's SW bits */
-	PKVM_NOPAGE,
+	PKVM_NOPAGE			= BIT(2),
 };
+#define PKVM_PAGE_META_STATES_MASK	(~(BIT(0) | BIT(1)))
 
 #define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
 static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
 						 enum pkvm_page_state state)
 {
-	return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
+	BUG_ON(state & PKVM_PAGE_META_STATES_MASK);
+	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
+	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
+	return prot;
 }
 
 static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
 {
-	return prot & PKVM_PAGE_STATE_PROT_MASK;
+	return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
 }
 
 struct host_mmu {
-- 
2.47.0.338.g60cca15819-goog


