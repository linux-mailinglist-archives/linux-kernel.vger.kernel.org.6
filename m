Return-Path: <linux-kernel+bounces-535219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7629CA4703C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D19D16A7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB5C2FA;
	Thu, 27 Feb 2025 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3UdIWWth"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AC7E0E4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616407; cv=none; b=fxEBovbmb6ZJCI0AL/l6DHL+SYdKnMHJBXnIQtcb6Mf6SF5Tr99Wyf3+Sy5SFIHncWwlnMbp94OLZwJ0huycbPDiVN291ZS5kFP/52wMtcQSTS5+j4zVmrEsRyGMR9Tvzb8KUNLZ/TXQwXnkixg3GXpMXgzZxDl6kGFx69PyiVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616407; c=relaxed/simple;
	bh=ytI77feCh85Kuzlfp0vkiYSCReLiPQumaOtjnCZz+Lw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J6TOVJ64i67L8IWfRUGFXCDYmmFla0d+lo32JAfauooLYLtzM/qisZaRpZdr3nL2Kh4fC096oLW1sEZFHmAk5iBTtRJ0DIisoUPgzVqm/2DnFmTOmfC/hbtMp43SI9Irv8t65eqLrLuAkGbZuYOIPY5EHJ5Fgf2iPR6ejbpASRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3UdIWWth; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e4becb4582so349273a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616403; x=1741221203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGmJYM3ZdXjed+VdIIVOBszfWrx1X1fG4+VBkIzQ0l4=;
        b=3UdIWWthex1/gAAU/yZJxS8LcwzWJ9Fm1SwcrXsa5om/XohAtVo/vA43dYiK2T3OqY
         43wG235bhgxKMxpzlKAY1cLxhkPUVITy393+U75rkgqp+UxdZaqNQweBcN2+uk9yFv8/
         Xrc6p899VUbSGSsOZQULb0nj1N8RxTN2NrKUmwaC6oRq8OhH7EoO4Th+YybHZOq6Wyid
         Hk02h+i+KZI/kllkvNKWVkhnl2H4ZSL6MVW+EtgUPyHdRYt7CC2p4g4nHx2j0+/clOjX
         8J+otjvEs2rptGaxqA9f7LSaRaRff97DbTsUbKm5fKSF8dQtbPHRRRotUI3ty5r0idT6
         iIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616403; x=1741221203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGmJYM3ZdXjed+VdIIVOBszfWrx1X1fG4+VBkIzQ0l4=;
        b=rxdnPQJJRm+WXz/m1p8VDlNqBH1PeYblHTGypqvuZSixlmMz7M62xuxr1T2Z2Vcoj0
         3HtQbso11+5dl9LuJ1ON/my1TCwtsduyc7TE2Clvbbd4mNKBZ104PVaCuuSUng0XxJbM
         ZxT1SpO25Kh67rJwYB2JGHgZuQpRfRADTSfU19ZkD6JBKRBSlbMqu32xE8BiJI+eeSyS
         16k4oilNim/6nl4KmNTX2wy6XLrSjsaPg/hdcn1sgf6gUm2vZaAXuPEkmBAboNBRQcvE
         ToFqPioeQW8JEPlz5+EAmkEs3yTlDk6d7/hsiLYIa+wjEowsWZkMdx/qbRHpuPDI2q2T
         Asbg==
X-Forwarded-Encrypted: i=1; AJvYcCV7LaWE2f0ZpfE8Nu6W4gXNHYgkwSaWZrHmXWEaHM2XmWDmiBJBzUk1omVdMbk87zjZf0xWi3Qd00vUidk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQzJUjvttVwPqUGy14wX/oAHignjD/pR+QP1w8SVKmGw8xuoJR
	qnlWowkhr1qkKSLgzGaGY23jex664rfLM0FuNWFsIiZJGeFPwcIvtkPK8Dx6NB0IaIju3+hkHUe
	D0BJsCw==
X-Google-Smtp-Source: AGHT+IG/8xxJ0edTLXImN+8foUCiY3IiLHVItOY++3PsS94AT277t67Spxy60uaWfxFei8RcZX4NGH7I/+gI
X-Received: from edbeo13.prod.google.com ([2002:a05:6402:530d:b0:5e4:befa:4847])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:280d:b0:5dc:7725:a0c7
 with SMTP id 4fb4d7f45d1cf-5e44448139dmr11904494a12.3.1740616403358; Wed, 26
 Feb 2025 16:33:23 -0800 (PST)
Date: Thu, 27 Feb 2025 00:33:09 +0000
In-Reply-To: <20250227003310.367350-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003310.367350-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003310.367350-6-qperret@google.com>
Subject: [PATCH 5/6] KVM: arm64: Defer EL2 stage-1 mapping on share
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Quentin Perret <qperret@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We currently blindly map into EL2 stage-1 *any* page passed to the
__pkvm_host_share_hyp() HVC. This is less than ideal from a security
perspective as it makes exploitation of potential hypervisor gadgets
easier than it should be. But interestingly, pKVM should never need to
access pages that it hasn't previously pinned, so there is no need to
map the page before that.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 3ab8c81500c2..ae39d74be1f2 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -686,7 +686,6 @@ static int __guest_check_page_state_range(struct pkvm_hyp_vcpu *vcpu, u64 addr,
 int __pkvm_host_share_hyp(u64 pfn)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
-	void *virt = __hyp_va(phys);
 	u64 size = PAGE_SIZE;
 	int ret;
 
@@ -703,7 +702,6 @@ int __pkvm_host_share_hyp(u64 pfn)
 	}
 
 	__hyp_set_page_state_range(phys, size, PKVM_PAGE_SHARED_BORROWED);
-	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, PAGE_HYP));
 	WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED));
 
 unlock:
@@ -735,7 +733,6 @@ int __pkvm_host_unshare_hyp(u64 pfn)
 	}
 
 	__hyp_set_page_state_range(phys, size, PKVM_NOPAGE);
-	WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, virt, size) != size);
 	WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_OWNED));
 
 unlock:
@@ -811,6 +808,7 @@ int hyp_pin_shared_mem(void *from, void *to)
 	u64 end = PAGE_ALIGN((u64)to);
 	u64 phys = __hyp_pa(start);
 	u64 size = end - start;
+	struct hyp_page *p;
 	int ret;
 
 	host_lock_component();
@@ -824,8 +822,14 @@ int hyp_pin_shared_mem(void *from, void *to)
 	if (ret)
 		goto unlock;
 
-	for (cur = start; cur < end; cur += PAGE_SIZE)
-		hyp_page_ref_inc(hyp_virt_to_page(cur));
+	for (cur = start; cur < end; cur += PAGE_SIZE) {
+		p = hyp_virt_to_page(cur);
+		hyp_page_ref_inc(p);
+		if (p->refcount == 1)
+			WARN_ON(pkvm_create_mappings_locked((void *)cur,
+							    (void *)cur + PAGE_SIZE,
+							    PAGE_HYP));
+	}
 
 unlock:
 	hyp_unlock_component();
@@ -838,12 +842,17 @@ void hyp_unpin_shared_mem(void *from, void *to)
 {
 	u64 cur, start = ALIGN_DOWN((u64)from, PAGE_SIZE);
 	u64 end = PAGE_ALIGN((u64)to);
+	struct hyp_page *p;
 
 	host_lock_component();
 	hyp_lock_component();
 
-	for (cur = start; cur < end; cur += PAGE_SIZE)
-		hyp_page_ref_dec(hyp_virt_to_page(cur));
+	for (cur = start; cur < end; cur += PAGE_SIZE) {
+		p = hyp_virt_to_page(cur);
+		if (p->refcount == 1)
+			WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, cur, PAGE_SIZE) != PAGE_SIZE);
+		hyp_page_ref_dec(p);
+	}
 
 	hyp_unlock_component();
 	host_unlock_component();
-- 
2.48.1.658.g4767266eb4-goog


