Return-Path: <linux-kernel+bounces-321442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D83F971A74
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D8F1C23D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9A71B9B46;
	Mon,  9 Sep 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2AAtqU+w"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FE1B9B29
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887325; cv=none; b=ahwoDoiiQqaOwF6mAbKRFV3yxy4geRmYLS9/CDBOSOoWQbvZiq0PpQmxX2a1d6CBZt2ZHCfloY45D0RBrVnxCy/k9zsnBRQfX+LEvPZR5tvP4JKKIvg1nQbO2Zz6xR86HT9PYIr+lzAUAmqZnsHPpSn/yjzK1P6WIy3pMoq3654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887325; c=relaxed/simple;
	bh=VimrJNUrhgwuXOUZQj8K1x4oJhjSufEAbZfaXLz2Bbs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jvuHZe3oCoWSKT3gPLOTyQNOSYdPzPV2Kox3muZMB64BkQg5aOT7+L11LcsC/r9rkv2iKwFewYfL+x2zCmHrqgbQxb2CMg0Ibp79k6KafVECwfl/lr/d0rr6GMunyHNXfJ4xJIEgbhrQGpQ3UufByYGSvIaOu795o41zx0upeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--snehalreddy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2AAtqU+w; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--snehalreddy.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1ce191f74fso8886223276.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725887322; x=1726492122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gkcR1LQPE4FCQJPuyJ1psNJiBytHsKUOZJ03Mjoli6E=;
        b=2AAtqU+wLIIf083ZVx2DddXM37MbC+oQY1EnRJx1mKcxvosHIPFoQOkZnNqOHIfylo
         zxE9BMQnKVAwqq5U9YNG8qLUvtSMP1qoNdBDYZOBmCA3zq3yNxwA9X+wJfRAEG6mtPNx
         Xb7p9aPgNubg3I91fbnN2R/YbXUrGWzdJHuTcY0jUc37VUrUYpM+XftsauVSvYfWh0+q
         2jHLfcyGCRThgvy3CSJiW4MxbgrOIGLcBBLiiLNa/tIceMZzdjmWqpFOmoap17hZvtRn
         4AOFSikmdEyfcehrRsSbzAFAFiT+dPhun0hnQ7RYUdRqw5DuDLwLKzwllEJNHxwxJEW2
         CrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887322; x=1726492122;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkcR1LQPE4FCQJPuyJ1psNJiBytHsKUOZJ03Mjoli6E=;
        b=xVbLJ4hmEmiHhw4O9JyQXPCTFEbESdRy2xvjc9blR0lkhhw9+zAZRWCXzd8e7jM2WY
         2tUf6eLPZVdFAQ8SACy92AyRWScIKIHc1VWUvUbjPeAQQIm6U84IfeDzNt+svNudiyYX
         Bhz4jQLb8QMlcyRrnmph7rlVq7gEsaHVwl9fUFlirdTjBYl8iDXMZe9n8Vv0srB57rxs
         d5bEQ/Nu1y0M+oI6zhX97RLuIWG58no8sT/rExD957mV+x0REYUUzMW9E1wNBe2nBDuR
         mwk5EYVJGxq2p9Q6ENfUavo2/J7tEoZEpXr6PSmCIbwIUR6QLlgJJvmk5OIhx/W33l2x
         Dh+g==
X-Forwarded-Encrypted: i=1; AJvYcCVUtXXo8EpfpG3WtlNMuKT/wRTNcynJtSraO1BsQGwpV5pr2zRdhgPJLOqbNe85xUG7AJWuEeGsJftFy2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTKOJm7ivwOU8JU1kOT2w6f1OeSFC+Nc3yeq99qnQHOuw2aWk
	Jqx/XhuBh60ref1i2qu2G3WlcRUelT9wx3Wl2uLK7v13iSATlWhRPP8X5FESR3eM9leD5c5VRzg
	Tkgg9DEZhKX2HALSKNqWX7A==
X-Google-Smtp-Source: AGHT+IHZHeeJzJA+rBQ2ukVV7/hhG+otbYJ/RCdAhQjZtiHGvPzEoizdzLQoCYDilJms56oKXlfXRy7wmQN6XoFmtg==
X-Received: from snehalreddy-1.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:c1f])
 (user=snehalreddy job=sendgmr) by 2002:a05:6902:4d1:b0:e0b:cce3:45c7 with
 SMTP id 3f1490d57ef6-e1d349e38d5mr19825276.9.1725887322131; Mon, 09 Sep 2024
 06:08:42 -0700 (PDT)
Date: Mon,  9 Sep 2024 13:08:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240909130832.1203849-1-snehalreddy@google.com>
Subject: [PATCH v2] KVM: arm64: Add memory length checks and remove inline in do_ffa_mem_xfer
From: Snehal Koukuntla <snehalreddy@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Sebastian Ene <sebastianene@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Snehal <snehalreddy@google.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Check size during allocation to fix discrepancy in memory reclaim path.
Currently only happens during memory reclaim, inconsistent with mem_xfer
Also  do_ffa_mem_xfer() does not need __always_inline

Signed-off-by: Snehal Koukuntla <snehalreddy@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index e715c157c2c4..637425f63fd1 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -426,7 +426,7 @@ static void do_ffa_mem_frag_tx(struct arm_smccc_res *res,
 	return;
 }
 
-static __always_inline void do_ffa_mem_xfer(const u64 func_id,
+static void do_ffa_mem_xfer(const u64 func_id,
 					    struct arm_smccc_res *res,
 					    struct kvm_cpu_context *ctxt)
 {
@@ -461,6 +461,11 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 		goto out_unlock;
 	}
 
+	if (len > ffa_desc_buf.len) {
+		ret = FFA_RET_NO_MEMORY;
+		goto out_unlock;
+	}
+
 	buf = hyp_buffers.tx;
 	memcpy(buf, host_buffers.tx, fraglen);
 
-- 
2.46.0.469.g59c65b2a67-goog


