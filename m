Return-Path: <linux-kernel+bounces-359804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C29990F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1E41C27250
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5520821F;
	Thu, 10 Oct 2024 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dg9gcvn1"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DD208200
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584812; cv=none; b=Eua3LGfl1jCTw7tN+bZkhb8oH6gADm+8TpLrV136ZGThbnKdGlSKqMIGwY5mXmLCGl/IEfzG0TLzwwRd9YD3Z/s3j8wz8JKPqCpQp5N48sSDezqrGVMUEBgHAajgdp4NZfXMPKpwd49uY7oUm3VlUdI6ntYHL1yvLGVto028WvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584812; c=relaxed/simple;
	bh=lNDyXtKPmFS6sOILzqWSFd9L+nyXpdsd6JebnDHI5l8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lNVa+UG+95SR8Yx146PwdYufAjPRfhWvR/1/FeX6ZAoCxQ221uZea//b9LdRuCFy9FlKcMRsQTPaOmTEsidyyhVJg1wASpN0OXUUHI4t67t5iaYn/zz2D2pV+1dUZVemauGsiGCOs16XFixP28rI0e7fV+SZswSkhFdrLPYRI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dg9gcvn1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e123d3d22so1429259b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584810; x=1729189610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=K6YUqJX41UvLftiTjNafBx3/10X+6KBTIzQjXduU2xw=;
        b=dg9gcvn1EbsSMEFFWFfwFAC3/SO7ovIMxsDf+/JNqUPrNu+sX4BsLpvzKD94FQExHx
         ct/k5mewMmav7ktqHjn4oB9I4zkkRwXyn5w0tIoApPyDKIiQH7p6tHkpXFCPJTtIseQ3
         VoNYFKhdpcHf9CbYy26zVGFEvyT2J19mE20vTiQrjL6CB9Vq2Zh4KkGD82MaCrPd6y9W
         UUtvrC92Pn2SaMErlsyPwQ0Db0yjSoKXkYH0TPgJINJmnOxNVVxCzUM3KVkk776W72n9
         gwT6JZjKyO2gcBCYOp3KcN9F1c/eMnDgfxq3VKPhPILvMxpVO8cOkwe7VhMm+/YDQ2ay
         oHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584810; x=1729189610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6YUqJX41UvLftiTjNafBx3/10X+6KBTIzQjXduU2xw=;
        b=cErWaDBgHm17cQmraKeN9ggnahq19Z0D1Ltfuj37RnCe7M4Iohgf+ds24QNoLaaR/K
         kNVQFxKENsTno/Uqk7gKypQEqtvqlPkBgnHIbcd3zenH9LrGJl7OLN6tD7ZEroYX28ye
         N3b4TVWnGPYEkPEj1Br193HAp8S3VNccY3d87DGv466mt8Anbqp99R0k+WOSHNeKo+zZ
         aya4E+3+kL5m/JB6ndb0y1oE/W+TQT0rS7Da3DoTBqJbqu6vmq3C2y4ksf2YAm7d8yJS
         sjinkddcKOUFfjDJ7AlzrnsV/fvBh9RmO/V/GV1WiP8DMcCE05DwgFkjDC9nqB5kDf+N
         dGLw==
X-Forwarded-Encrypted: i=1; AJvYcCW6FTZ2tdPrPjfgwSavOx0kJIOYNs4gc+SrvDVlOiGebQGX80ccN1ouU/7HtE1O/fQ1qJ3vQ5wdmRjEnWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQ73w7zDgSRPbLSVpCtEjvrJAoKNHCBu4Dax5FaXN1zbCPkrD
	2Y5TTCgU47NTC13DMYL0+NIGxYNANkWAu1t+XJenWBfuGm+OlpWCEg38FATBLK7y0MByPuIUlCe
	TYA==
X-Google-Smtp-Source: AGHT+IEO1ECBC98fGvB+GRqYHAQaBdxJcqvY9DmP3QI4gZm0KdOyij1fLmFl0bPXgfvra8JJdQe8JNFxBHM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9199:b0:71e:1e8:e337 with SMTP id
 d2e1a72fcca58-71e1dbe467fmr8496b3a.4.1728584809106; Thu, 10 Oct 2024 11:26:49
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:57 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-56-seanjc@google.com>
Subject: [PATCH v13 55/85] KVM: arm64: Mark "struct page" pfns accessed/dirty
 before dropping mmu_lock
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"

Mark pages/folios accessed+dirty prior to dropping mmu_lock, as marking a
page/folio dirty after it has been written back can make some filesystems
unhappy (backing KVM guests will such filesystem files is uncommon, and
the race is minuscule, hence the lack of complaints).

While scary sounding, practically speaking the worst case scenario is that
KVM would trigger this WARN in filemap_unaccount_folio():

        /*
         * At this point folio must be either written or cleaned by
         * truncate.  Dirty folio here signals a bug and loss of
         * unwritten data - on ordinary filesystems.
         *
         * But it's harmless on in-memory filesystems like tmpfs; and can
         * occur when a driver which did get_user_pages() sets page dirty
         * before putting it, while the inode is being finally evicted.
         *
         * Below fixes dirty accounting after removing the folio entirely
         * but leaves the dirty flag set: it has no effect for truncated
         * folio and anyway will be cleared before returning folio to
         * buddy allocator.
         */
        if (WARN_ON_ONCE(folio_test_dirty(folio) &&
                         mapping_can_writeback(mapping)))
                folio_account_cleaned(folio, inode_to_wb(mapping->host));

KVM won't actually write memory because the stage-2 mappings are protected
by the mmu_notifier, i.e. there is no risk of loss of data, even if the
VM were backed by memory that needs writeback.

See the link below for additional details.

This will also allow converting arm64 to kvm_release_faultin_page(), which
requires that mmu_lock be held (for the aforementioned reason).

Link: https://lore.kernel.org/all/cover.1683044162.git.lstoakes@gmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index dd221587fcca..ecc6c2b56c43 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1692,15 +1692,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	}
 
 out_unlock:
+	if (writable && !ret)
+		kvm_release_pfn_dirty(pfn);
+	else
+		kvm_release_pfn_clean(pfn);
+
 	read_unlock(&kvm->mmu_lock);
 
 	/* Mark the page dirty only if the fault is handled successfully */
-	if (writable && !ret) {
-		kvm_set_pfn_dirty(pfn);
+	if (writable && !ret)
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
-	}
 
-	kvm_release_pfn_clean(pfn);
 	return ret != -EAGAIN ? ret : 0;
 }
 
-- 
2.47.0.rc1.288.g06298d1525-goog


