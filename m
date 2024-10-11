Return-Path: <linux-kernel+bounces-360379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38246999A35
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E941F24526
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1361F12EF;
	Fri, 11 Oct 2024 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnyU0Yxy"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DA1FBC8E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612694; cv=none; b=ozabo+SVDGMdrMWSiIyDzggpbsa8dgiHL6vUUlInav2dorSOMB/0iP8eJeKCD23+cJFZfkM5c0Aa1MqYLJpo2iyC1dgT5hLYj1sK5z2WS7kDi2p1jzhnQ0QYOMtWIq/xA31+Z+MTE/bXN5XH7NOry9bvKjjSSVk2Mp78FXwWXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612694; c=relaxed/simple;
	bh=G5j/STg2XewWx6BKeygLMbbBozt/6/sTXHCfTmo3CC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZMomW0ByR6xSSrUC5M69C0JR0kZxS1Lrv34apZj95NyC0v4yjccd6P+sKkZX/hK0yzbsZzJPq65MefvosECXquqzh08XFVZ4NdhWarVWVScuXw9snjsqHtZdwuX5TMMFO7deZni5zuBfUu1Rts2FopzZ2sv2ZWcjIKLd9XH7yJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qnyU0Yxy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e04c42fecso1602484b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612693; x=1729217493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+DbRh+OQxnx8VQK332KGl4utXP+C7MDXmmXDxMg/Z/g=;
        b=qnyU0Yxy4PE13cSwLOBwthB7pVANlNz4yDsOvPN5bdOjr0dCA/rk/d0F1erhWPjw3p
         5SI0bvERbLkPYRJ5H5PGh+3/2s0EeerZjJflaRGA0wEEc+C+Iz3Hvfp+Vjv1fKaDBPBr
         4eNT+CnrFpa66Dl8pCcoCfcKNYix7A4dmi3T5tfh5W5jdV+ypniYWYI8oMI7tYlUeisz
         ZRkRKVZMNmx2O352eSDRys63l+LbZCslREIqmnU+WYQhEC1h6xnTZw12moE8OHYz7cOx
         MknSHaId7d4Sue6OQFMI2cvlln+7cKvJcQcjc/KPpvPA/UxbbfHc1NO7reU5MvhbDz2M
         yh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612693; x=1729217493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DbRh+OQxnx8VQK332KGl4utXP+C7MDXmmXDxMg/Z/g=;
        b=sNtPmXzaHCEA5IRTnULyYaPGxtXmtwds9cVZpCvodq2dJWswGc5LnAaaORBF0pWlar
         MzjtOtdqOQ9eG4fCVXbwrwKUHQZYt/+SshR4qcuTBUlKKiTdnUBYoBFNYWI/n43dQgp+
         vDAdnXmAMQTLywGKYH95/yYd90o4aCxsoy6uUwXLbH58j1C9jxJ4/InD+tZiwuB5cP4e
         d1AqFAC446V4QFtoOmHuCHp8R6GHfQ2hJFYm/auIPZ5Ki8/gQUmq4Prj4fkVBmBBjvXz
         UUuzBmgntr0R7tuPw8+BxNi+74Rts8wLOEkorbyKdy+ZrwabyhbLk0zoULO/nvnrn4ZX
         AJNA==
X-Forwarded-Encrypted: i=1; AJvYcCXFBehnpaGgJ/F4YwWtj6CW/QYoApOCDuaMM9LBkdH7+YNHMtwBTD8gH0KaZAQcDVuBUiXmpNtPBPPucXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynpgKbN6tBxwPKjTi70bkcqKbTJ5Z48A1qCd9yWrFKQmI4pLlT
	+lXBYRCTUz5E9wwt7IHTTx37/xhps6lsz3GSOU5Y1FMS2jxsGcADcbp798fsi0vhdXLu9zlUalp
	bSQ==
X-Google-Smtp-Source: AGHT+IF5NMp0NI1CakamRfDZJw0W0RABI+lWlAVC7+uDMKwFg+XySu7vH0dBZjdw628m27BTqRJ51jdefc8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f44:b0:71e:268b:845e with SMTP id
 d2e1a72fcca58-71e26e53c16mr13451b3a.1.1728612692090; Thu, 10 Oct 2024
 19:11:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:50 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-19-seanjc@google.com>
Subject: [PATCH 18/18] KVM: x86: Don't emit TLB flushes when aging SPTEs for mmu_notifiers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Follow x86's primary MMU, which hasn't flushed TLBs when clearing Accessed
bits for 10+ years, and skip all TLB flushes when aging SPTEs in response
to a clear_flush_young() mmu_notifier event.  As documented in x86's
ptep_clear_flush_young(), the probability and impact of "bad" reclaim due
to stale A-bit information is relatively low, whereas the performance cost
of TLB flushes is relatively high.  I.e. the cost of flushing TLBs
outweighs the benefits.

On KVM x86, the cost of TLB flushes is even higher, as KVM doesn't batch
TLB flushes for mmu_notifier events (KVM's mmu_notifier contract with MM
makes it all but impossible), and sending IPIs forces all running vCPUs to
go through a VM-Exit => VM-Enter roundtrip.

Furthermore, MGLRU aging of secondary MMUs is expected to use flush-less
mmu_notifiers, i.e. flushing for the !MGLRU will make even less sense, and
will be actively confusing as it wouldn't be clear why KVM "needs" to
flush TLBs for legacy LRU aging, but not for MGLRU aging.

Cc: James Houghton <jthoughton@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/all/20240926013506.860253-18-jthoughton@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig    | 1 +
 arch/x86/kvm/mmu/spte.h | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index f09f13c01c6b..1ed1e4f5d51c 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -22,6 +22,7 @@ config KVM_X86
 	depends on X86_LOCAL_APIC
 	select KVM_COMMON
 	select KVM_GENERIC_MMU_NOTIFIER
+	select KVM_ELIDE_TLB_FLUSH_IF_YOUNG
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_PFNCACHE
 	select HAVE_KVM_DIRTY_RING_TSO
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index e90cc401c168..8b09a0d60ea6 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -470,9 +470,8 @@ static inline bool is_mmu_writable_spte(u64 spte)
  * needs to flush at the time the SPTEs is modified, before dropping mmu_lock.
  *
  * Don't flush if the Accessed bit is cleared, as access tracking tolerates
- * false negatives, and the one path that does care about TLB flushes,
- * kvm_mmu_notifier_clear_flush_young(), flushes if a young SPTE is found, i.e.
- * doesn't rely on lower helpers to detect the need to flush.
+ * false negatives, e.g. KVM x86 omits TLB flushes even when aging SPTEs for a
+ * mmu_notifier.clear_flush_young() event.
  *
  * Lastly, don't flush if the Dirty bit is cleared, as KVM unconditionally
  * flushes when enabling dirty logging (see kvm_mmu_slot_apply_flags()), and
-- 
2.47.0.rc1.288.g06298d1525-goog


