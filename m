Return-Path: <linux-kernel+bounces-538455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2901A498F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EE718991A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF326B086;
	Fri, 28 Feb 2025 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y6J1ySYO"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638626A1CB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744844; cv=none; b=Kdx8WoOB95281XKO+tJL79mo++Dlil/d72SgI4a6rAt17lYxUbyVRjrGWdKVew9PoigLMHbnrnZnsp/afTYK95dGNfSebOLCBF+RQg4Tkd1mRZTPg+SuW4jo5DkG5J+Fk8Qamx35gD3JFdgmJi6tZz1TPo3eaWG3XOYHezdXhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744844; c=relaxed/simple;
	bh=0ZkqQIQxKscqn0KefL+cIWMenlE6zl5KTQEb5CgqYWU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tyCYp2IFsLYHDUnvpr2m712duD3VmIO1JfFvPFvfrO3J56hYOMiEM/RnYrYF0Xoufi4KJ8aSkx3REFoxCoO3BMHaHoT8WAxaLNrbrmesm0hmXygxbMbUG2d/U7ORp4H1CO6IPe+EoDhZRL166ffKg0gAt+w+/CDiz/BST4hcBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y6J1ySYO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394040fea1so10785305e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740744840; x=1741349640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TNd3VmeY+7xSqSUKAYqv/5mTt/52Q+ubddKUOdAsyfE=;
        b=y6J1ySYO/MtYSxGOkLUi+SVFivOACOHoizotPONo7FNENEgJnNwme6Oyem9U6/vq4d
         q/bh5FxWdOrGlkf0FNbeh686WfwiDNe7xAIptpo1+6bQ+tbgoIJ7rMsh19XxXwsRoiEg
         EI2Dy+QKZu1Q4xaoSJ6Sad9ehyB9JvBmiQLyiF8Uxm72X6ah622Hq54EoncdetbveWwc
         mA6qLLB/ukwsd5vu59NmGHEEflCqqaq9i5u6RGZIm2esylF2GhjpgYKG0TUg6HVL49qs
         IiGm1bzBU2HdXMT0+yDboCmK/Q5x5owf/nLyd4rgthIGYwGLNvPhjpB2EUiWvSlFajve
         FSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740744840; x=1741349640;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNd3VmeY+7xSqSUKAYqv/5mTt/52Q+ubddKUOdAsyfE=;
        b=lNpUeWgq8F649HIDXBsrbqYGJ1+VlG7NNcy6/3yJdjjWXhW/7uJt6Rq+NiMNA04O9R
         aD8wVGcHNz1P/bBPZoy2L04MdeDcZT00/Eqqj14XPKIIUhL3pX7ceiWKfPOLfoSQ3oaJ
         t752UbRnvRshJ/fwHhjslQwAijkBNgWUDpLfRi98woSApeIi1c6kf53GASjhzknoP67K
         G15E9drhYbJ891Zn8glv9qV78CGbMv4LDKoUL36rgTdq5bEA7hCpgz/qe1mhQ1wepiOP
         F1+fJWVfWmZ6lqInBOXbNjimcJokWViAoTjZeb5R8/F1rC2JgMBssXccj6cclpBdmWW4
         Bung==
X-Forwarded-Encrypted: i=1; AJvYcCU7i3dwpOuu2WbX4yyGZoCwheTiBM2ZzECf8978rWYP4iw715BAL0mHPGXl7AcgXT/NI2W44Y8sQcI/4y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlmZyUYx0Jq1pMC75oejviI/nFqpwrvM89TDF6uGL5vHbAio41
	YK2LGYANcjhy8+ayEwaTJ3sFderTc/0FgmZ4BudTGAOUq8zi/hK9dL7tY8UqaHjPm9SElDqXVCd
	kCmwCHf6E55hT4GVHzg==
X-Google-Smtp-Source: AGHT+IG4L89EaIN2eXPjkLGcoxrC+ORfJM4P6Y4KMuCicg/cPi8Y4oD53yPu3O03f+S5mbgyiQt9/c+vvm0KdwsX
X-Received: from wmbep25.prod.google.com ([2002:a05:600c:8419:b0:439:54cd:da63])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e12:b0:439:9536:fa6b with SMTP id 5b1f17b1804b1-43b04dc34d4mr64976615e9.13.1740744840263;
 Fri, 28 Feb 2025 04:14:00 -0800 (PST)
Date: Fri, 28 Feb 2025 12:13:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228121355.1377891-1-vdonnefort@google.com>
Subject: [PATCH] KVM: arm64: Count pKVM stage-2 usage in secondary pagetable stats
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Count the pages used by pKVM for the guest stage-2 in memory stats under
secondary pagetable stats, similarly to what the VHE mode does.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1f55b0c7b11d..c2e022c41313 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1088,12 +1088,18 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 
 static void hyp_mc_free_fn(void *addr, void *unused)
 {
+	kvm_account_pgtable_pages(addr, -1);
 	free_page((unsigned long)addr);
 }
 
 static void *hyp_mc_alloc_fn(void *unused)
 {
-	return (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+	void *addr = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+
+	if (addr)
+		kvm_account_pgtable_pages(addr, 1);
+
+	return addr;
 }
 
 void free_hyp_memcache(struct kvm_hyp_memcache *mc)

base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1.711.g2feabab25a-goog


