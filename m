Return-Path: <linux-kernel+bounces-318525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1956196EF2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DE81C23A73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274261C7B9B;
	Fri,  6 Sep 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkxVbj8m"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6781C7B96
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614884; cv=none; b=dYMgwNgSVtHgxQffeO5QsjoqlMWzWvaatyOHfGrEoVYA/OxLCwlS9KO8A7tUjOSsu2PoSwiCksZzjJwvAtxf9WCqh2JVGAx6jzZXOYl9ZY79oGvjnFqsarxnfDK/cpjGRhJ6Mxpro2JVw8BUJ3VvCodbCmNyFymR4DEeLNaja2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614884; c=relaxed/simple;
	bh=luTtkRSdHP9G0pXhIP3ysKRyBfMKHTLmhzeh3Hgyprs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pUu8HBf/GjGnVrMxmDeHWvocZ/wQuz/wB1Hgucdz6mA+UKrZRLyESh1kSzELOKy1sdGLIAiiyvrv6im+JgiJOr64gUaNNTHV93EFbhGFJ6hcL5kon+s/BI2ztCIRpPnqhRjvdtND+/58UJH9Y4RRxcQFJrBC+HxoEt82G7qNetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--snehalreddy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bkxVbj8m; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--snehalreddy.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e163641feb9so7243581276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725614882; x=1726219682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NL51OiKKXYrcwrjtHOrpmmV+PQMlb7GKuARQtOGoLlU=;
        b=bkxVbj8mSCXfPN1pse2H+fP4CsbttShraRmtbxPPt44BIRklSGQAQu1X1VK2hCL6fV
         tnGnIS1E6OIMn3c3qNPbVrPKAvF8nHDJGWWrUuPz4G7tD+SVI6cDBnKQoAaF1UqTvVBZ
         u+6lEzXp2amjP+gcFP5X5711aDbQZ0XaqtvPyzh2ax5PujFIKX8WSKG78vyKUNrSSAVi
         mJj1S4QqiXHNOFf5IhBqMqZmshN7WnzEVQYR7kDmGSkPMav/gPTU0BES2Qn/WGqNbjJ2
         ZEDIHBhprFxYu80Ij4JOaCk0rOBnlsVA850GTrfH9p9ehIuTH2p4yWa8948K9vyk0v/u
         2CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725614882; x=1726219682;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NL51OiKKXYrcwrjtHOrpmmV+PQMlb7GKuARQtOGoLlU=;
        b=Ew/oLAIojxjhyZZzlpnrl9UmAuLgWGS/UkBHGOKxdAH+DD9RNiJckqatbyHD8P2FIj
         q/FpvHK1lTtuRt/cusXuhh/A4DOTV0GhJEHQEU6+52xO+ooZyl/dgZiYKpeok+P/AMW3
         DMTjnomc+Hjglt2QypFOXmAFGBx4fb0/BDO+qUoczMM/1ehAjcKn0SGXmVtOWC+q7aKC
         qye9ygSpJ+if8PS3bro7vvQaWY8+mLpy15d2TGxymWYUcJDFU5LEz9pGHLh0+QBBBMmK
         palxDGv/9wG6NOLao8ymBXmjRe3nDIBOvMubzRVsWk0srapX971jL0ie9aogTLZ70oMh
         +fxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9qFO66Es3b4OBlQVK1bPIIZy2fCoy1X8OCfXGhxY38dLkN0kA0a3G7H+cO9wAEmD2Kon7if7wagsP41c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEz6jgT+4JlBjsmlzafuAm67rYMlPVObnKIrKJSHieQOEIwFh0
	anikilyx5fXWitByrYU+C73F7oCo3OMGQlc48Jv2YHghEO+/GP8b7iQzfmWX3SnmQftzhv45sOr
	Too0a6lWq+pNUNJ6P7ufgxA==
X-Google-Smtp-Source: AGHT+IETQ552AARnKz58C7KCw8wpKdRMaB3Kp2FZFfwlE+pb0fqKNxnYrW28FK9E2Bv9ErnO1UiOPc6M5jWgsKuFYQ==
X-Received: from snehalreddy-1.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:c1f])
 (user=snehalreddy job=sendgmr) by 2002:a05:6902:2d43:b0:e11:593b:b8e7 with
 SMTP id 3f1490d57ef6-e1d3463e2d7mr11298276.3.1725614882036; Fri, 06 Sep 2024
 02:28:02 -0700 (PDT)
Date: Fri,  6 Sep 2024 09:27:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906092732.113152-1-snehalreddy@google.com>
Subject: [PATCH] KVM: arm64: Add memory length checks before it is xfered
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

From: Snehal <snehalreddy@google.com>

Check size during allocation to fix discrepancy in memory reclaim path.
Currently only happens during memory reclaim, inconsistent with mem_xfer

Signed-off-by: Snehal Koukuntla <snehalreddy@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index e715c157c2c4..e9223cc4f913 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
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


