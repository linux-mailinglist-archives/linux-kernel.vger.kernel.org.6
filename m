Return-Path: <linux-kernel+bounces-513278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E45A34829
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1B01892118
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFBE20100E;
	Thu, 13 Feb 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHi5+LjJ"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF421CEEBB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460981; cv=none; b=jOtu5gNQPgh49MJReZiuF9+ObEmHHVBHLLM7aLpLU5oKpAPWbmb0Df7tU+fn+Odc2yRdaexGe0ucnwYa/MkVk3xRwzpMSqyN9Algt+S9znkVRc1XrV87tCj5EPfWoPQyiXy4ceekNkSsRFtPUYkhE/YcbmMyiq9VQWTrOoIg9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460981; c=relaxed/simple;
	bh=rUUmr1qKa0raoRIrehordGqRHzgfGvgm6PX24wnH2XI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X6U0BjIpkTH7sJEyPG9d6MAoQUuOTeGxoPDXWMBPGbZRjgTm++bSmHhDlyKZUSMhMNj6LFGP1G21zhoTqOTy0L8PC1/X+C5gB1R3/4fLa6D2g5bCKEVMaQi+JwTAdrmiob+fp2BsgL/e7DRd+a8ifP3Q8taveGvWN4SLBTo3PE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHi5+LjJ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ab39f65dc10so126026766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739460977; x=1740065777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yY1niH8bXpIvQxfdtYMW2hEB9nSt1maMeFqvo9y07nE=;
        b=gHi5+LjJ7N5vxzSNkNrM+6Ugu2Jj/m1kWQlmxkhSZFgOmKWUCoqawpPRM0W7rcTUl/
         zqc9gt6LRHY6WGm3vBkcs3RvyLs+QThYHg8Ye6VHrs0sKHP4FzQqXtIdknlJ9hwPh5Tr
         0NZtc2/8LynfTEMHERNmSVAF2QZfcQkLkiBU9VgOVeSM+w0rYAzDDJfvpwv7OzEf3gIh
         qVfXty4YEcQSFXJ3CNt9vbV3R2GX3iH6Sankf2dValhDeCPLmu0LkKV/AKAPpjolRa1V
         uqXXDIL+Viy2nxIzzsst/RcHahIRFZqwk4G/jGnZJvzkXzn4anOHQ3dSwvKukJg9GUF8
         xjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460977; x=1740065777;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yY1niH8bXpIvQxfdtYMW2hEB9nSt1maMeFqvo9y07nE=;
        b=eLr8xfTdxrhEQAdt22cHQnax319CPx0iRI87z/tTmjTyl1+tqEeYS4v88/DB+MbvN+
         ZpvLcs1zWmxq+E8XnGsuSxdIRxTgy/Oev/wEWGaMGMyuwXPjheOSCQT7Obc8lmQq0Q52
         FbcSb5GCxaJihLt+Nphna3//gD+1207ebT6e1STqo+Q6o1Z/ClVlqk0G0+xh2CT9a0Sz
         c5986nbNCdF25cRMOblQOC/Hc0aAM3zWoKHwsUuwRfYC/J77PPn3o4oLbxgNpUAmn60h
         pbH2/wb+zqMK/XhfNLVYVzG9q+uMl3/zaU0lCBGxpP1hRhCXVaHGE5j5K/ldrVGr9d3s
         6YgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH4Akc1m0WGAAt0tB9SNUw8JM04U2O1U4l9XOZm7whT7oQ/hpfKCGWBqCQzErheJnQorC1xIP7Ns7sago=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxYnkP3Hab3D4XxU/DFjl9yyymYrCYT2TIMydX/K0rxTe5tCH
	fLDsvsro5Yzif94WDK3rmj656zALdW0dssLq5ZgofgU1zJzVrm/ywZUqsOFoX4KE6Aa7FNaGb5f
	9TecMrA==
X-Google-Smtp-Source: AGHT+IGNnBpl+X2qDDZkAqsl1W2uWg0qrWcC8MQ3Hvm0c9bsOTfUcxx6R0kvEkmQWiyS31Y+rdhEd3ntyWG8
X-Received: from ejkk8.prod.google.com ([2002:a17:906:32c8:b0:ab7:bfda:26f5])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:730f:b0:aae:fd36:f511
 with SMTP id a640c23a62f3a-aba501a9d85mr376452566b.47.1739460976992; Thu, 13
 Feb 2025 07:36:16 -0800 (PST)
Date: Thu, 13 Feb 2025 15:36:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250213153615.3642515-1-qperret@google.com>
Subject: [PATCH] KVM: arm64: Fix alignment of kvm_hyp_memcache allocations
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Keir Fraser <keirf@google.com>, Ben Simner <ben.simner@cl.cam.ac.uk>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When allocating guest stage-2 page-table pages at EL2, pKVM can consume
pages from the host-provided kvm_hyp_memcache. As pgtable.c expects
zeroed pages, guest_s2_zalloc_page() actively implements this zeroing
with a PAGE_SIZE memset. Unfortunately, we don't check the page
alignment of the host-provided address before doing so, which could
lead to the memset overrunning the page if the host was malicious.

Fix this by simply force-aligning all kvm_hyp_memcache allocations to
page boundaries.

Fixes: 60dfe093ec13 ("KVM: arm64: Instantiate guest stage-2 page-tables at EL2")
Reported-by: Ben Simner <ben.simner@cl.cam.ac.uk>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7cfa024de4e3..d9db6dfbad09 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -100,7 +100,7 @@ static inline void push_hyp_memcache(struct kvm_hyp_memcache *mc,
 static inline void *pop_hyp_memcache(struct kvm_hyp_memcache *mc,
 				     void *(*to_va)(phys_addr_t phys))
 {
-	phys_addr_t *p = to_va(mc->head);
+	phys_addr_t *p = to_va(mc->head & PAGE_MASK);
 
 	if (!mc->nr_pages)
 		return NULL;
-- 
2.48.1.502.g6dc24dfdaf-goog


