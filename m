Return-Path: <linux-kernel+bounces-547083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D108A502E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F347188B956
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D324EAAF;
	Wed,  5 Mar 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSAfo7+7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4220248863
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186186; cv=none; b=k/6yTNdr+K8RIvPZRtzhRlH7JMyfLLVdXYEpzvJtPwMmzYffAOl57PQwzfhmCFWkNvnmfd8O4gTY2nQYT7nRWhufKO848+2u/gnuoJnZmid9mZ6kI71pxgN9aboGjhp088DMC6BuZ6JwtBub8GWUfWktsK5rVuTb5rMjGS32JKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186186; c=relaxed/simple;
	bh=x29h9M6n8nq7NdPnqRKffAT+4udR1rBlR+7/BBJPG6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCgAnPdgbHSBw9NA3BrEZjKVld4/oepNYMz5PlY0WU++kN4huWDubY5JaD943WIQTTHVAIlJHbNaaNAbJ4BDrC2OqGVW02iYVzkuiUY7RTseaGzbKeas8X35e6gUrZftFKe8mvzp8YKiM3Be2lzyP7zjKO0CmZ6yQ+91W8vdRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSAfo7+7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741186183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YM84sfhKyVCM1WHnPi0ugQYCezGBxRCWusGn++RPss0=;
	b=QSAfo7+7LuRPUhfqQNWhMzhC63e5ic6X16RP/kLgOABKXcLnpapr4qkOETKZSkwgiEmxaO
	HqWxRrMjrZSOfzEAoJghQhFaA9VjcBj2GMWsKIyuig+YGv24lognoBTf+Ue908uWBOcisD
	w3RhOyE1o1mCLrcJ6VqzFhjm1KKaUb4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-Gf8JmoSDPnGuSs9gs2cxZw-1; Wed, 05 Mar 2025 09:49:42 -0500
X-MC-Unique: Gf8JmoSDPnGuSs9gs2cxZw-1
X-Mimecast-MFC-AGG-ID: Gf8JmoSDPnGuSs9gs2cxZw_1741186181
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39101511442so495389f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186180; x=1741790980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YM84sfhKyVCM1WHnPi0ugQYCezGBxRCWusGn++RPss0=;
        b=vyblB+AZnkFumkkY4DRlZ/Ab8ptM4GqPwmOl/CaGg9Qx9eFSgCI/MB1J7e4LUzKng6
         w0c34TRUPWYU9CISZbXj0ErQ8Gorm89QlEYuF0p9yTbDMFV92UTWZWifBkTRJQPlIiB6
         UqrBNHa/7H7bO48Kmzrmk14rDgwNPk8LBfP/DtOo1Sbr4tOdviW52K/hjeAZQBuftI5x
         SxAstRUx7redjtFkzkOUQfIdydzrWSbDoF0MnOSKaRyZ7qa7lPHNcyxWiP9CTVm6wNhv
         bKg4PKqvgaz0d5EIZQwETNcNFk/rw8EcqRZZ6tIK0Hin1OdpNe89Y7GHYZALDVx14K7g
         b6+A==
X-Gm-Message-State: AOJu0Yweex2h61zuP6clvwiHyoIjvT55Si9nEMb5MweFATAPe66JhUch
	Imq5qAqLnOEE1I5RX0b0l2+PM+JK0ItnPvOhHQ9IRDBn7BrnRVGu/JSEh9hz82gwhZXMpQYwXYb
	U08wQl4Sss91ylh0f4/irMS+IDKZgOFW71RpLI+AzvBj4CR0EDpKBJIjzHVbBta6pC6/r5ZowFg
	1tkWVM7hQ8tcXbP0fzqMW4vwHnMpN+rQ+iYEmWXzRcCm0vdbGMkfA=
X-Gm-Gg: ASbGncu3l9cKGYg2BqxmUohWPaqKgpiHd4M1ysE9gBu+OKDq/guZjab2A9wytXuZOno
	9IcatVRrw0mPCu5joZqYqXo5CSEZLhvqbA56KrqPlPQWisDA5KF8iBZ8kf9j/QLYfKU6oZwZ+MG
	1+gaBv+IommyeNswzrfZE/de8E1Sb45dpKHxtifA+1pHqFQakLmrnD7cDdE7gtMJrDXM9NrQqJ0
	BILdIh7wXB4NHnV/5H2Uot7hUAktjepQvFlgD63GMNHutafbVUN4fTFxo5NBByJXee56eCCGs/J
	ZcQd/fUYNmyCcfhcR7kRI0FdBg9LtUJM5jv9ceohRskpP8A=
X-Received: by 2002:adf:e183:0:b0:391:22e2:ccd2 with SMTP id ffacd0b85a97d-39122e2d080mr1812877f8f.3.1741186180434;
        Wed, 05 Mar 2025 06:49:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpZB4BYpB9A76P4a45l7m/RU6UnuwhTcw/rRDIfT7W5uDFJhJmK1bfyR7MVaBtIvxiEQk6Ng==
X-Received: by 2002:adf:e183:0:b0:391:22e2:ccd2 with SMTP id ffacd0b85a97d-39122e2d080mr1812850f8f.3.1741186180022;
        Wed, 05 Mar 2025 06:49:40 -0800 (PST)
Received: from [192.168.224.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479609asm20954791f8f.2.2025.03.05.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:49:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.12] KVM: e500: always restore irqs
Date: Wed,  5 Mar 2025 15:49:38 +0100
Message-ID: <20250305144938.212918-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 87ecfdbc699cc95fac73291b52650283ddcf929d ]

If find_linux_pte fails, IRQs will not be restored.  This is unlikely
to happen in practice since it would have been reported as hanging
hosts, but it should of course be fixed anyway.

Cc: stable@vger.kernel.org
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/powerpc/kvm/e500_mmu_host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index c664fdec75b1..3708fa48bee9 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -481,7 +481,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		if (pte_present(pte)) {
 			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
 				MAS2_WIMGE_MASK;
-			local_irq_restore(flags);
 		} else {
 			local_irq_restore(flags);
 			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
@@ -490,8 +489,9 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 			goto out;
 		}
 	}
+	local_irq_restore(flags);
+
 	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
-
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
 
-- 
2.48.1


