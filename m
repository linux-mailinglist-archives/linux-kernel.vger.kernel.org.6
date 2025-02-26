Return-Path: <linux-kernel+bounces-535022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D8A46DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16ED91886DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F0225E47E;
	Wed, 26 Feb 2025 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHcyn65e"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7225B68E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606543; cv=none; b=lyUQRu+xu9+to/AUXqiT0t9KgmsYDp04WZdbjuWCfo42L6JAW8qBQ0ckA2iVQRFImzTDrwVEMf1nu2kEnuifYx1BKFvOksmCBbxQx11oZD0zyQvZBGNlmVNa+P1DEJMS20kUVLzBdko0UVIDZz4eLOJfm9VgBMsG8GWtIj9emS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606543; c=relaxed/simple;
	bh=susFi+HTLhMiXge6xuA23CvYjFDj7xjmElPFv39hxTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RShsqSqj7sQutDqDkE2Qxol1Wyrx86aRWtxblKsdrV+plw2XRj/2+jyR4ShOhi+pf7NqBLCNKORbIZBYtMfz+qTJFDrGbXC/PQcCIa1StwntAlGLveLeGavXFaavS/oI79n3O/PO6APa/K+ZeNenCN2etQ7NCmMFJY+otGmYu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHcyn65e; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43988b9ecfbso1370045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740606540; x=1741211340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEVZ05L77YjD9i0FV4RPZx+ynfSX0ZTLa/fS8nUdHrQ=;
        b=tHcyn65ebxji3ikCnYH96DlI/1KrDmqtsRvWB1DMvWty77T7zbytZug9a6UhwBi9O6
         c4CAfOMMEg9XkAlmd09a2iTV99ggmHZUvbKm2suzWHkx/KpYGI9ae57VMaTpaZ+l6Xj0
         65lLHWyOF2RNb4E7zzju52whITRleXN3SWuz/NG8S1MxdCZd5o7woN0UvW0JrSDFc+Fv
         zXFwU2NHgWWkBrgNMJEsn64TtllSXfK4zZ0VYZvmVp2i7YGDwngZWEFDum5KJzTxEJzz
         mERhWLme9jnp5rj48UQNoyHuePF7URzAavkucMjosC3EJqHW5iQW8bNH+62dLkHpguHb
         8vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740606540; x=1741211340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEVZ05L77YjD9i0FV4RPZx+ynfSX0ZTLa/fS8nUdHrQ=;
        b=ChLvKWzSs6AUA2i3h2yIiEY1VbWRAD9wFSEA7LBqkwem3gbE/LkySnJHlfoLCkxWRr
         Q8fGnVvzpjP5CnSRgW+dxmEBCpDD4hS/onq57C5g8T5fVaRzqzGxFwq7O7sjAOJQk9zP
         6NULlVGw3Jn/mEBRQotAw81FCJI8It5/jAj6eFIJXH87MMSb6XWsFnlSttfbFeBl5D0c
         bZWk1oDdaYrQCJjkEtnZbNYGtZtKXIC88Qyo2Pi3M+W7Iu2pSmY7HF15Uim6rZRhhFAb
         NVYhoR9JlTmZb33vBTtOHaR9SCbXBtub+t9fsnmvxhqgIn8vaOT6JHZByLfTqtnHUAzJ
         pmAA==
X-Forwarded-Encrypted: i=1; AJvYcCUN6pc4dBw1yP8F6lPQJhSTx0nLJwyimw5nTkVOZyT4Mp9PiVdV5gYbsy1EoAGwFVEXzF2gJGdOICj+0B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKokOmjqTfL2hiHQqXb4/QIFHYZoedckDqVzejr45b8GKWAVEl
	Gvgbz2e5/g+t8ElSW7lEZSGg8EY6fQ4RDfcB9vipiksJG0Cc9Co05AZEg/w4ngVQMyFaPaI3xfM
	L+XZtv/Dsd3mjqeYS2znSU7o/cQ==
X-Google-Smtp-Source: AGHT+IHPl9CpNA4ye6HGWodohtg7w7nq3kIEmHB83VCNwiFw4/jBDdSe7IDZ/dv5OLUf4FF1pq99Aao3VGjq0FuCrDU=
X-Received: from wmbfl9.prod.google.com ([2002:a05:600c:b89:b0:439:9985:3882])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19d1:b0:439:9225:2f50 with SMTP id 5b1f17b1804b1-43ab8fe957dmr50990375e9.16.1740606540005;
 Wed, 26 Feb 2025 13:49:00 -0800 (PST)
Date: Wed, 26 Feb 2025 21:48:51 +0000
In-Reply-To: <20250226214853.3267057-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226214853.3267057-1-sebastianene@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226214853.3267057-2-sebastianene@google.com>
Subject: [PATCH 1/3] KVM: arm64: Use the static initializer for the vesion lock
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Replace the definition of the hypervisor version lock
with a static initializer.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index e433dfab882a..6df6131f1107 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -69,7 +69,7 @@ static struct kvm_ffa_buffers hyp_buffers;
 static struct kvm_ffa_buffers host_buffers;
 static u32 hyp_ffa_version;
 static bool has_version_negotiated;
-static hyp_spinlock_t version_lock;
+static DEFINE_HYP_SPINLOCK(version_lock);
 
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 {
@@ -911,6 +911,5 @@ int hyp_ffa_init(void *pages)
 		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
 	};
 
-	version_lock = __HYP_SPIN_LOCK_UNLOCKED;
 	return 0;
 }
-- 
2.48.1.658.g4767266eb4-goog


