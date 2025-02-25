Return-Path: <linux-kernel+bounces-530381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17931A432AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C7C3B99AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C991494AB;
	Tue, 25 Feb 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zc/IEcwh"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5A1422A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448421; cv=none; b=GnW2tKpMWojYrtgBqolE0WHCWGwONA+4PyEA7yXkOS2aWR65dldhopdDBFtGKetj4iEXa2ahzuvQ5pkS9dqiG9S2lEnF4HonHIYcj65J+uWLeskqEKJ6Hqp8CtTTVBL6AzOo94FMuY2PxbZo433Gg69YpiPcCnrPYSd2OgUr6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448421; c=relaxed/simple;
	bh=uk9F9tBYFF/EkJD9htt1GD0op2QMyfK9bfcyZ5umxhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rk5gtblz5ql07g9tXKoH4Y2cmGhdIkxENBmkaw/7p5UCpHN9hp9zNnWPCSSUIU49hceNp2sGt1IJH+g+5GIaiUZWrp0wFrm7jvvRzgFYxYmaPnPkuXa2QrSjAdAMrJDGjW9JSI0SM0VaVO6JNnnQ6WhpJGg1lu5ZvAWPeQ1GFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zc/IEcwh; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abbc0572fc9so427112566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740448416; x=1741053216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVBQg35LScynYQPBsFgs3dGrm+AD9n8KyZeHIALpKpg=;
        b=zc/IEcwhDsFcdEsi8OaI9irOI5TFvAgd1GfpP+RVhiGJq3eJouRaYwC1fZPDr5wdMj
         s/NB86vVJQJ9AiPEwCW0jusJjqp7y4XJvRia76wychrlaAt+smf4z53zs0kHsmNJAuxI
         YtyszDKKvKgMkhtQc/jnyEDKVu1m2n9ku5vSwlRlodVIZpWu7nUYAL9hoKYfroc8zBuE
         D/NleV7nHetEPsFfdIgjAGI9fn0pZa9kwbATYUTYNruatFlnoy3PKqx7P38o5Ie4MQhv
         JnXZJlX3DoAFuvjVwMptAzUGdEYEI+qoG8FjZ+RRw+5v6z2ls5zifDPmBYiFzJh+/1HE
         ilrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740448416; x=1741053216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVBQg35LScynYQPBsFgs3dGrm+AD9n8KyZeHIALpKpg=;
        b=RpOQtu43QVZIfhEa37PoCKVOBy+hn2wyhSRXi5ucIieqYAX23NTQGyQQGhh6gUw6c6
         FTJV7TAkB8hy1q60yKp/IDRSMuTu5SsaiD1MnWGjiKwoRXGGkjtvy3BI6ZrMsEsIRVHy
         utgoSYuLAGfLM+seoPKy7foXmPc+80HFMPnEik+xE9bCKywicMnbcKutYrZh5v/PM9Gc
         Xr8KhPRei5brNG9Yd3gnJFL29sd9ulAwOGSObmhCE8QWp2/duGyjPk/ZpprlENbkXSJz
         lCii7s7I7R2o1dpShA1LOatssaU+XYJkesOa8+tmpPzSS+sLV5y8pFz2efCeqq3B0DTe
         S4/g==
X-Forwarded-Encrypted: i=1; AJvYcCXYevVUDzLuTzVeKaphIiyv7gLLK76z5WA45K5q9/0wNDh6MdcBLnLfgv0b0tYH7BDfPTAXv8Q3f0/+RlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuvDSAEGaBKGCHdxlMksLhAIbYIYkqse1m1pAaJhFFDxjwd9Uv
	7kEnnA9OzrcnNL+0q3FkVQH/CUa65ayRB+O6Z06308RwdsUXTBiaCFh3pS9dfJqOfjnoNAuVvnh
	YvnYKqQ==
X-Google-Smtp-Source: AGHT+IEOA9rIjA6uekoY3WihM+tF/K0vVRrG2dIyIogwJ20oRerMsyDc12AtygClhb6MD/mhH+yOzfP2W+Kp
X-Received: from ejcvg17.prod.google.com ([2002:a17:907:d311:b0:abb:78a9:ce4a])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7801:b0:aa6:7737:199c
 with SMTP id a640c23a62f3a-abc09a079d1mr1474527866b.15.1740448416319; Mon, 24
 Feb 2025 17:53:36 -0800 (PST)
Date: Tue, 25 Feb 2025 01:53:26 +0000
In-Reply-To: <20250225015327.3708420-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225015327.3708420-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225015327.3708420-4-qperret@google.com>
Subject: [PATCH v2 3/4] KVM: arm64: Selftest for pKVM transitions
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"

We have recently found a bug [1] in the pKVM memory ownership
transitions by code inspection, but it could have been caught with a
test.

Introduce a boot-time selftest exercising all the known pKVM memory
transitions and importantly checks the rejection of illegal transitions.

The new test is hidden behind a new Kconfig option separate from
CONFIG_EL2_NVHE_DEBUG on purpose as that has side effects on the
transition checks ([1] doesn't reproduce with EL2 debug enabled).

[1] https://lore.kernel.org/kvmarm/20241128154406.602875-1-qperret@google.com/

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/Kconfig                        |  10 ++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   6 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 111 ++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c               |   2 +
 4 files changed, 129 insertions(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index ead632ad01b4..038d7f52232c 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -46,6 +46,7 @@ menuconfig KVM
 config NVHE_EL2_DEBUG
 	bool "Debug mode for non-VHE EL2 object"
 	depends on KVM
+	select PKVM_SELFTESTS
 	help
 	  Say Y here to enable the debug mode for the non-VHE KVM EL2 object.
 	  Failure reports will BUG() in the hypervisor. This is intended for
@@ -53,6 +54,15 @@ config NVHE_EL2_DEBUG
 
 	  If unsure, say N.
 
+config PKVM_SELFTESTS
+	bool "Protected KVM hypervisor selftests"
+	help
+	  Say Y here to enable Protected KVM (pKVM) hypervisor selftests
+	  during boot. Failure reports will panic the hypervisor. This is
+	  intended for EL2 hypervisor development.
+
+	  If unsure, say N.
+
 config PROTECTED_NVHE_STACKTRACE
 	bool "Protected KVM hypervisor stacktraces"
 	depends on NVHE_EL2_DEBUG
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 978f38c386ee..31a3f2cdf242 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -67,4 +67,10 @@ static __always_inline void __load_host_stage2(void)
 	else
 		write_sysreg(0, vttbr_el2);
 }
+
+#ifdef CONFIG_PKVM_SELFTESTS
+void pkvm_ownership_selftest(void);
+#else
+static inline void pkvm_ownership_selftest(void) { }
+#endif
 #endif /* __KVM_NVHE_MEM_PROTECT__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index ae39abc7e604..46f3f4aeecc5 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1083,3 +1083,114 @@ int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu)
 
 	return 0;
 }
+
+#ifdef CONFIG_PKVM_SELFTESTS
+struct pkvm_expected_state {
+	enum pkvm_page_state host;
+	enum pkvm_page_state hyp;
+};
+
+static struct pkvm_expected_state selftest_state;
+static struct hyp_page *selftest_page;
+
+static void assert_page_state(void)
+{
+	void *virt = hyp_page_to_virt(selftest_page);
+	u64 size = PAGE_SIZE << selftest_page->order;
+	u64 phys = hyp_virt_to_phys(virt);
+
+	host_lock_component();
+	WARN_ON(__host_check_page_state_range(phys, size, selftest_state.host));
+	host_unlock_component();
+
+	hyp_lock_component();
+	WARN_ON(__hyp_check_page_state_range((u64)virt, size, selftest_state.hyp));
+	hyp_unlock_component();
+}
+
+#define assert_transition_res(res, fn, ...)		\
+	do {						\
+		WARN_ON(fn(__VA_ARGS__) != res);	\
+		assert_page_state();			\
+	} while (0)
+
+void pkvm_ownership_selftest(void)
+{
+	void *virt = hyp_alloc_pages(&host_s2_pool, 0);
+	u64 phys, size, pfn;
+
+	WARN_ON(!virt);
+	selftest_page = hyp_virt_to_page(virt);
+	selftest_page->refcount = 0;
+
+	size = PAGE_SIZE << selftest_page->order;
+	phys = hyp_virt_to_phys(virt);
+	pfn = hyp_phys_to_pfn(phys);
+
+	selftest_state.host = PKVM_NOPAGE;
+	selftest_state.hyp = PKVM_PAGE_OWNED;
+	assert_page_state();
+	assert_transition_res(-EPERM,	__pkvm_host_donate_hyp, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_share_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_host_unshare_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_host_share_ffa, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_unshare_ffa, pfn, 1);
+	assert_transition_res(-EPERM,	hyp_pin_shared_mem, virt, virt + size);
+
+	selftest_state.host = PKVM_PAGE_OWNED;
+	selftest_state.hyp = PKVM_NOPAGE;
+	assert_transition_res(0,	__pkvm_hyp_donate_host, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_hyp_donate_host, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_unshare_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_host_unshare_ffa, pfn, 1);
+	assert_transition_res(-EPERM,	hyp_pin_shared_mem, virt, virt + size);
+
+	selftest_state.host = PKVM_PAGE_SHARED_OWNED;
+	selftest_state.hyp = PKVM_PAGE_SHARED_BORROWED;
+	assert_transition_res(0,	__pkvm_host_share_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_host_share_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_host_donate_hyp, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_share_ffa, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_hyp_donate_host, pfn, 1);
+
+	assert_transition_res(0,	hyp_pin_shared_mem, virt, virt + size);
+	assert_transition_res(0,	hyp_pin_shared_mem, virt, virt + size);
+	hyp_unpin_shared_mem(virt, virt + size);
+	WARN_ON(hyp_page_count(virt) != 1);
+	assert_transition_res(-EBUSY,	__pkvm_host_unshare_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_host_share_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_host_donate_hyp, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_share_ffa, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_hyp_donate_host, pfn, 1);
+
+	hyp_unpin_shared_mem(virt, virt + size);
+	assert_page_state();
+	WARN_ON(hyp_page_count(virt));
+
+	selftest_state.host = PKVM_PAGE_OWNED;
+	selftest_state.hyp = PKVM_NOPAGE;
+	assert_transition_res(0,	__pkvm_host_unshare_hyp, pfn);
+
+	selftest_state.host = PKVM_PAGE_SHARED_OWNED;
+	selftest_state.hyp = PKVM_NOPAGE;
+	assert_transition_res(0,	__pkvm_host_share_ffa, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_share_ffa, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_donate_hyp, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_share_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_host_unshare_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_hyp_donate_host, pfn, 1);
+	assert_transition_res(-EPERM,	hyp_pin_shared_mem, virt, virt + size);
+
+	selftest_state.host = PKVM_PAGE_OWNED;
+	selftest_state.hyp = PKVM_NOPAGE;
+	assert_transition_res(0,	__pkvm_host_unshare_ffa, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_unshare_ffa, pfn, 1);
+
+	selftest_state.host = PKVM_NOPAGE;
+	selftest_state.hyp = PKVM_PAGE_OWNED;
+	assert_transition_res(0,	__pkvm_host_donate_hyp, pfn, 1);
+
+	selftest_page->refcount = 1;
+	hyp_put_page(&host_s2_pool, virt);
+}
+#endif
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 46d9bd04348f..54006f959e1b 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -308,6 +308,8 @@ void __noreturn __pkvm_init_finalise(void)
 		goto out;
 
 	pkvm_hyp_vm_table_init(vm_table_base);
+
+	pkvm_ownership_selftest();
 out:
 	/*
 	 * We tail-called to here from handle___pkvm_init() and will not return,
-- 
2.48.1.658.g4767266eb4-goog


