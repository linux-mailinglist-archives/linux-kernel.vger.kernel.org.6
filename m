Return-Path: <linux-kernel+bounces-260073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209F993A29A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AB7285074
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B1815442F;
	Tue, 23 Jul 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUBMasV2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A014A4E7;
	Tue, 23 Jul 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744531; cv=none; b=qJ6XRJb3HiY8ztMsFN4J3bwHMRNlYEKQI7bwNYzqEt1oRUlcJzobF3JZixc1pPP/+14QDN7QDYusxBVB8GGAbs6GAmnrG1qdV3b0xIE8Yw6FnEE1Th0RFcBz1hbnc52LLWMuapq4vPaOHRylUwcwGoQXuk3t6ujYgvA/gKCy+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744531; c=relaxed/simple;
	bh=TIjiGfjzkpS2+OrsvnfRb0ZLD4KZZ+C4Xk4CqNc0b+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4s6WtYRV4KWJFJpnxn1nAcN/hx2MGU/xxcV2TN7U2dDYIN2SmCbHy+9bkDzk3pvIqcYaOVYBrTGiEwozsmKqhZrtwVA86uQnnGadyqv/tlc8h0odepJQzx1mLa6qwTkPAJABnATqMztxy13EIQQieYVURBiul/RxyYndhHuPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUBMasV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7ADC4AF0C;
	Tue, 23 Jul 2024 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721744531;
	bh=TIjiGfjzkpS2+OrsvnfRb0ZLD4KZZ+C4Xk4CqNc0b+A=;
	h=From:To:Cc:Subject:Date:From;
	b=nUBMasV2jzP+8/5uuYJuvFFMcd6vYWtjY4JSV6jqJIU7eKmkj7YIexEZYM23I+F5p
	 iNpiD5U5iy2VfukW7OuK7+3SEzcDJTSPypcbGlj65J7w8e3qpnBBcexqKGUKDs1fNW
	 m1ncSMatPpfQ3zR8Sm+XjJeYm8auz8UuNJnXMXxuD6Dz+k+2sIftRZFaGe9xtQj3/U
	 bbUx3e6lLkAUH27HUKW2/oSL/BfEoUYmN9N5haoeWJegwuP5Ux+eRKaVbGJwd9q9yk
	 0BVYEBpw+f25gMig5UhSqumOPnzjQ5TuX+XamoS1dOhhBA1bjRYZui5nwrWbhhHEmK
	 eNnJZQIdWbx9A==
From: Danilo Krummrich <dakr@kernel.org>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	christoffer.dall@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] KVM: arm64: free kvm->arch.nested_mmus with kvfree()
Date: Tue, 23 Jul 2024 16:20:52 +0200
Message-ID: <20240723142204.758796-1-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm->arch.nested_mmus is allocated with kvrealloc(), hence free it with
kvfree() instead of kfree().

Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 arch/arm64/kvm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index de789e0f1ae9..bab27f9d8cc6 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -786,7 +786,7 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 		if (!WARN_ON(atomic_read(&mmu->refcnt)))
 			kvm_free_stage2_pgd(mmu);
 	}
-	kfree(kvm->arch.nested_mmus);
+	kvfree(kvm->arch.nested_mmus);
 	kvm->arch.nested_mmus = NULL;
 	kvm->arch.nested_mmus_size = 0;
 	kvm_uninit_stage2_mmu(kvm);

base-commit: 66ebbdfdeb093e097399b1883390079cd4c3022b
-- 
2.45.2


