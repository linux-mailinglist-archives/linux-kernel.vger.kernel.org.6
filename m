Return-Path: <linux-kernel+bounces-424885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA49DBACE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248EA16137E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020361BD039;
	Thu, 28 Nov 2024 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etmNtl/Y"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613421B2195
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808654; cv=none; b=k5JE/bpK0XB4hRKOMCpvTPx7Wb7pixRHgl9v2F/4VMepKjs/OfbDKOvEqnjGzBvDr3SevWrozzdDHTAIfpHHovelCzQXxQib6dHrJui7sSVZ8ENOzxaC4WfKIKEm0G9Fk3xXTEJ4jWov/f0msCqFM0WU5hBpLLP+/lAoPT0QTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808654; c=relaxed/simple;
	bh=zefgSlkWiBMEgrarllE+ZW2iPiBzKadDUa8/gGaDrLc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R0qvq1h/IFwi9Iu9IC0N5WR6jfNMmT4bZZF7lmxHqrVTbC7RIktcA03g19H2ZOsAOPddkGbHsqEyQwg4wWo68P8blVNTH/VGWqFvY+BTtXJZ2R5YDOnNSfvmOAIeYRiPbnvgoBZh4tI5HvI9dKnSnIa5juCkBDLg346i9PnAZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etmNtl/Y; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ffc3b6bb58so7122831fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732808649; x=1733413449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=khn7hS+L97wWEkf+qZmLW9FxPYu9tRvP0eTp4rFXqec=;
        b=etmNtl/Y4a0i5a4PyD20er45g30mQOIWGAJ+nbCrgVcWSLmTZ7hrxbDXxktXcbOG6t
         D7H2pLk/jzPUZZLkmnFCPV84tPJ6fja8go0lr7QSWCKwoB8jwzc44F/rvYgF3CmYpfSx
         s5JGtO8yKVGWrusE69Dawb5ljARqQTZvvJEKKqTf8abz9f5fqFOGW13qca1wKEU5zQYi
         01JCiWd/n9bi9Z2kCrmnN4DM5qpewhCsHkI5snd+uHjRJpbEvwlwGHJpoSH1OGHl3D6z
         GC1QGsB61tFh1eXwjTRqtb5gh9v6HwsOftxJIiepveDOj2R4LYtwjWFKkH/TREf7whbc
         2HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732808649; x=1733413449;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khn7hS+L97wWEkf+qZmLW9FxPYu9tRvP0eTp4rFXqec=;
        b=S55Vi/nc0hxF6CXfhI7eZxaO/CnEzeRxOdnzTL4Epb25QK3fafqgMP0THPQrM6w+Ys
         PNIV+yOjvEAB3V1b1FqnEhSuUGBHcTjovwxGWgwaAaPx3luHBn2g68XcWsf23zpY0NVc
         gaSKKHmCaIfUnbk118UNxSWbjJX5aeIyOCV31NbVvncWhM+OoeZYfpQVCedQfkTNoKIQ
         kBz9Gj3Rzo6BzmiR1+XGVtuYNYse0NJffhDL4lT1WVM0nmn3tl5IWERhch+XHFM7eqCW
         jLn+TTl3PIGGmkW7JUiqdD/P/LdY2HUFKBcLDMow11CzBHsE+mqKDyY4TsU9EerKVkTc
         ernA==
X-Forwarded-Encrypted: i=1; AJvYcCXek6bvT1zq+I8sQOjBcjOmEdFQEtiZCdCBYuH9opBDjxDvAvtqbPHHKbYzEwC/yeMkaXup80mMkZNs6HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVBm6cCnk0C6JZu37ymxTSK+d1KX+7W485uW94pXzegf6SZ1E
	8kcBIKMs2U0iHcQ6667T1W6aheEgLKOTODdEk+IX/XXvTdCfhBMTVkygjJIFojD7Pe4wziV++H4
	FN2ElyQ==
X-Google-Smtp-Source: AGHT+IEA0vqV24/H61fVxAlPgPYdRuvNXFKWFHK/tbHMkyqpm9uAL9gzQ7g11kF30kEuklavdgUcHm1MkzJh
X-Received: from edso5.prod.google.com ([2002:aa7:c7c5:0:b0:5cf:e1dc:7d98])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:be0d:0:b0:2fa:d84a:bd8f
 with SMTP id 38308e7fff4ca-2ffd60cf809mr40534651fa.30.1732808649614; Thu, 28
 Nov 2024 07:44:09 -0800 (PST)
Date: Thu, 28 Nov 2024 15:44:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128154406.602875-1-qperret@google.com>
Subject: [PATCH] KVM: arm64: Always check the state from hyp_ack_unshare()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"

There are multiple pKVM memory transitions where the state of a page is
not cross-checked from the completer's PoV for performance reasons.
For example, if a page is PKVM_PAGE_OWNED from the initiator's PoV,
we should be guaranteed by construction that it is PKVM_NOPAGE for
everybody else, hence allowing us to save a page-table lookup.

When it was introduced, hyp_ack_unshare() followed that logic and bailed
out without checking the PKVM_PAGE_SHARED_BORROWED state in the
hypervisor's stage-1. This was correct as we could safely assume that
all host-initiated shares were directed at the hypervisor at the time.
But with the introduction of other types of shares (e.g. for FF-A or
non-protected guests), it is now very much required to cross check this
state to prevent the host from running __pkvm_host_unshare_hyp() on a
page shared with TZ or a non-protected guest.

Thankfully, if an attacker were to try this, the hyp_unmap() call from
hyp_complete_unshare() would fail, hence causing to WARN() from
__do_unshare() with the host lock held, which is fatal. But this is
fragile at best, and can hardly be considered a security measure.

Let's just do the right thing and always check the state from
hyp_ack_unshare().

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index caba3e4bd09e..e75374d682f4 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -783,9 +783,6 @@ static int hyp_ack_unshare(u64 addr, const struct pkvm_mem_transition *tx)
 	if (tx->initiator.id == PKVM_ID_HOST && hyp_page_count((void *)addr))
 		return -EBUSY;
 
-	if (__hyp_ack_skip_pgtable_check(tx))
-		return 0;
-
 	return __hyp_check_page_state_range(addr, size,
 					    PKVM_PAGE_SHARED_BORROWED);
 }
-- 
2.47.0.338.g60cca15819-goog


