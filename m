Return-Path: <linux-kernel+bounces-535220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCEBA4703D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CF6188543D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465FF1474B8;
	Thu, 27 Feb 2025 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAeRGQSR"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C113AD26
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616408; cv=none; b=I6Ah/A69Z6Zi2xe0AWzsN/3UPVzhhVp/HvSMGXjHnLDx5/nDgQLlOmdOOGwe7oXd6oBcgJdapMQcaGlTmrGz298M/GDKVo+ltRQXXxkjVWTDOWqikzDq0RYkuwK9M09s4jTScsfGEGV1kf6cZZt15YOTRTfA4Y/DbzRpj6YUJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616408; c=relaxed/simple;
	bh=rp3IDhVnxkQh03oSaa4+o9TnUw4DyqtAF5BOWHgKtFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJzo+17gh4n4hbLD/C3fJAYgHT/kB7h64yI6SkpUG8Auqd6gIV2ojpfRs7nylUoj7dLyaJXQ1YkSYhG9dwKtbMtXYKRrec5u95Sqky8eI/fzoLwlIdzstTyjPhxrF/jgG1ii4H2UOG72EtPEOLayOiz8ubp0v46Dph5cimle9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAeRGQSR; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abbf03205e6so27490066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616405; x=1741221205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=go/rSw9bkr3V2Z7S0UpAa5FZKtjaGuIC5hzD90cfQFg=;
        b=CAeRGQSR8PfzSq/TZLd+Fr65LfN56ZjyI87GONnLbf9lbMvZMVUkiuXTV0aLh/ZBVg
         go2MwNSjNcBlQjnwLXji8QydsxYXGmoB7dyXpxmOMhzU6btLweuyG7uhvYQutPVM0Z+O
         iHiotlLJpgbDtbIOa+r5LNBSuaZotLnwh4TTem00KunxolNX1fgAvvPgg+aIv5YXUTd0
         TS0cNjQih8lRaZ2/zqZDH/l+NfvcWK6fhNX9t5xW71K9rqnomue6ac2MQa/nZ4XBHGPn
         Y25fzAJWuIPIwHmb/2VwPNWGJ7mCYtytdOHw3JVVWErweg7Rfn5MUppDytAAb3wYCWQr
         1DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616405; x=1741221205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=go/rSw9bkr3V2Z7S0UpAa5FZKtjaGuIC5hzD90cfQFg=;
        b=GV02nUtApIxxLf6tqYt57X5izAH+aGOHewG84Y7q0C/eQfP7VurZu+qMHqQdhvNygR
         aVLgUaVQgH5b4v5EwkQsyuBzrFqKOiwpmzW1O7k74N7ZHNFygkMrWgBVFdVhHqyxsZAe
         lAfnDzL6eVubtmN4qtAT7dPJAgD179R1kifu0jd5bCa9FLf7BuECN/HAsyZppZ6v0A5v
         Ag8zkAD8HbWfaNHiliXEjbRS4hS1RnOwaALAejRT3t5YXP2mF1xZl6uaU2Nl8O7p+LG7
         2juTD4/Fmrttp+jDXTxs8A201VlxIIxUY0BYxkEvuWO42JzArFMK/uicrodKeqs/748n
         Wyqw==
X-Forwarded-Encrypted: i=1; AJvYcCVvaifmy1wiWgR7t7vLlNa/qIqqirF+xqaTzb4HttftHh8uYg7JjskqdvcgqKcrvPNmYxBcIPzAt4CqW0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZuYK0Ygbb8uFVUDdNAHMnCaPeBZXpZdPAoy95IglaG4w3EIQ
	tZla+AumosypAVCjqiYIcSLXmoi2qYFWQhbN2hYNmPgqTGsrT/4pEGq/tbMmFOmm6J+RFxs09Qy
	ij6RkOg==
X-Google-Smtp-Source: AGHT+IHoE0D/+VTxFu9mBffqWU8TmUIEm77P7VHQouobm1YsZoARZri0ZIO8rfS0b5y60ajdzwb57L0Mwq80
X-Received: from ejclm3.prod.google.com ([2002:a17:907:18c3:b0:abb:9896:c72f])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5202:b0:5e0:8c55:4fa
 with SMTP id 4fb4d7f45d1cf-5e444853ef4mr25783357a12.6.1740616405565; Wed, 26
 Feb 2025 16:33:25 -0800 (PST)
Date: Thu, 27 Feb 2025 00:33:10 +0000
In-Reply-To: <20250227003310.367350-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003310.367350-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003310.367350-7-qperret@google.com>
Subject: [PATCH 6/6] KVM: arm64: Unconditionally cross check hyp state
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Quentin Perret <qperret@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that the hypervisor's state is stored in the hyp_vmemmap, we no
longer need an expensive page-table walk to read it. This means we can
now afford to cross check the hyp-state during all memory ownership
transitions where the hyp is involved unconditionally, hence avoiding
problems such as [1].

[1] https://lore.kernel.org/kvmarm/20241128154406.602875-1-qperret@google.com/

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index ae39d74be1f2..22a906c7973a 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -695,11 +695,9 @@ int __pkvm_host_share_hyp(u64 pfn)
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
 	if (ret)
 		goto unlock;
-	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
-		ret = __hyp_check_page_state_range(phys, size, PKVM_NOPAGE);
-		if (ret)
-			goto unlock;
-	}
+	ret = __hyp_check_page_state_range(phys, size, PKVM_NOPAGE);
+	if (ret)
+		goto unlock;
 
 	__hyp_set_page_state_range(phys, size, PKVM_PAGE_SHARED_BORROWED);
 	WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED));
@@ -755,11 +753,9 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
 	if (ret)
 		goto unlock;
-	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
-		ret = __hyp_check_page_state_range(phys, size, PKVM_NOPAGE);
-		if (ret)
-			goto unlock;
-	}
+	ret = __hyp_check_page_state_range(phys, size, PKVM_NOPAGE);
+	if (ret)
+		goto unlock;
 
 	__hyp_set_page_state_range(phys, size, PKVM_PAGE_OWNED);
 	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, PAGE_HYP));
@@ -785,11 +781,9 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 	ret = __hyp_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
 	if (ret)
 		goto unlock;
-	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
-		ret = __host_check_page_state_range(phys, size, PKVM_NOPAGE);
-		if (ret)
-			goto unlock;
-	}
+	ret = __host_check_page_state_range(phys, size, PKVM_NOPAGE);
+	if (ret)
+		goto unlock;
 
 	__hyp_set_page_state_range(phys, size, PKVM_NOPAGE);
 	WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, virt, size) != size);
-- 
2.48.1.658.g4767266eb4-goog


