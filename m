Return-Path: <linux-kernel+bounces-360371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296E2999A25
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71F128390A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2631F9A8D;
	Fri, 11 Oct 2024 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPREzY0J"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4E1F9420
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612676; cv=none; b=oiBQ1Dgznxa0KicYYpoMiMhxAKavPVOjthdKKCHYcqPoJ6JhCLOJM0xDnIHysqB3vliwBBy1A1X4kKkbM10Z3eTJXX0J1RXz7ryN9MrzVaa9e6MFwfBlsbejs18axBFfRtRKKwaq4wZmwyEGK8i0723PH5f/EnJqATw1YrT9g/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612676; c=relaxed/simple;
	bh=aKgSp3XrLYNy8hNKG4jop6hvDJmh/ChMqz+HQoJA+wE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k4p0pebN++3i0qAVxOuJvFYNjUntP/FIKMG3g6MpW67waECGQh4pCQaMKM9dko+G0ZJGMhdwTH4blfVg5AFM/IIIK7/+e450DlR+Bb4A0nA1jTWhvmdDbTIp1h1mM7YAlZYd3M3BL781e4vZq8ILdXIPX8rGbyd9T33GBnJSI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPREzY0J; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e163641feb9so1759595276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612673; x=1729217473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TrIlp1Guds3zrlzSMYuxG6o1rQn3R2bekD4gqwcbBS8=;
        b=BPREzY0JAOiY1f8lVJCq9+YxrYjDQeMYdT+GFTMze8Spr+ZcQB9GCEuqBA1MJX06Kx
         ETO7NSzcDw4/w7aK68EgUr1aWHSCDjRZjJgL5eGxKQ44AWm7CF6BeOJBcwZWTNLW63BD
         fHjv++pmJRKO2odF5gN0NkFTYs/0cyvNUy3U84h9wFJYhsmyq093fFFVeNDswgshT/bP
         pGEHgA7WvZ92VnPu4GVRZTSHkK7Xj5kEPEheZJGqwgkWm9TOfZhbGpXDoQu8DeJpz51I
         YYd/gQEPHtJJNRodIvLm/Hx386nUYwap44oZ9kbPLSqvm6yJPJIqzdMR99Tl2sGDFZIy
         8TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612673; x=1729217473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrIlp1Guds3zrlzSMYuxG6o1rQn3R2bekD4gqwcbBS8=;
        b=NWAScQcoaVsXzrNGnXNR18EhBuBl0ZI7a6O3HCfP58Cs7mwY8LoLdgRLEgCgfMWWFf
         uFH58pu4BXkVMwhmypB7TMo2u9xtA/uiAVwl38Y86dPum/JUdZQqMqqN9TKw8KdvgSCr
         8t1uVEC+gvveF73yN5+iIFvTYgZ9+ceQOXNSIR1h67iL8hYr2dkYYyN/NddlnjmhXpQU
         K8Z+UwDWG9zC3Is/wN4WqPXzrd20U3f29DIzoYeO+l6sdd5X8bDlHiYaiY/Qa/zUCG6z
         Z+jkHVdYf96X5or9c86zS0zOFEGFIhspqRxS/H7jCvRYu+elBqNW82u+2CfKOEwSaw4i
         u8TA==
X-Forwarded-Encrypted: i=1; AJvYcCU7iThF1sgdSGdaEmSjHR5MlB0ExH1CxHPW/n1cHFAB+iQ/Zz8VCLTejszEaAF0L3xFns2blNrM7OeCSvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzGdoisuc233sA8ZTKaS4J0h0ktyBw1/o3+zjgbYmPE93Je7h
	UOu3GwN7kYZJTE88VAFq/rHJ9bEvpJrMkVdBuOp6LHtpmfQ+L1Xyb/5Kv7eXYM16N7aTcZfdU35
	aTQ==
X-Google-Smtp-Source: AGHT+IElEKizd4vm3idzgibROUYOU9UMUvmYhyDSJ+LMWh+4cN4KYm1fNLHVNNLdSguOs2K4bXih+kBr8mQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1349:b0:e20:2da6:ed77 with SMTP id
 3f1490d57ef6-e2918421de9mr9964276.5.1728612672856; Thu, 10 Oct 2024 19:11:12
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:42 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-11-seanjc@google.com>
Subject: [PATCH 10/18] KVM: x86/mmu: Set shadow_accessed_mask for EPT even if
 A/D bits disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM doesn't use shadow_accessed_mask to detect if hardware A/D
bits are enabled, set shadow_accessed_mask for EPT even when A/D bits
are disabled in hardware.  This will allow using shadow_accessed_mask for
software purposes, e.g. to preserve accessed status in a non-present SPTE
acros NUMA balancing, if something like that is ever desirable.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index c9543625dda2..e352d1821319 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -419,7 +419,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only)
 	kvm_ad_enabled		= has_ad_bits;
 
 	shadow_user_mask	= VMX_EPT_READABLE_MASK;
-	shadow_accessed_mask	= has_ad_bits ? VMX_EPT_ACCESS_BIT : 0ull;
+	shadow_accessed_mask	= VMX_EPT_ACCESS_BIT;
 	shadow_dirty_mask	= has_ad_bits ? VMX_EPT_DIRTY_BIT : 0ull;
 	shadow_nx_mask		= 0ull;
 	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
-- 
2.47.0.rc1.288.g06298d1525-goog


