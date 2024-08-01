Return-Path: <linux-kernel+bounces-271739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE59A9452C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638151F24321
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0614B07C;
	Thu,  1 Aug 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2gB1DkB"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF314A4F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537304; cv=none; b=ebF3lTCsFbJt8xOJAYZEwlbyVNfSlEIrQfh/uba1upHtjaoKlgJSZWKIIsSiRxuWQXCAQRDQeOFEK6BDB55+22nUBFZ0kAMhu7W6dqlo2HF4llr3zJHB1WhhEA4cXVsRGyHan54rFeD9G8uIMY+b2yiwbnrzg2mGL3FAqQyCGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537304; c=relaxed/simple;
	bh=Vh7Yjg37p23UJZ6ej/K5Cd4ShyYhS3DKAU1YW8l2Bu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=StNwAbVcUTqTmsp+/fApkwyTtxHPoDaCMrGwXOQRBuk99l3y+LlkNgQr+j5+7C7Fs5cbj86G2M6tCFkK+ocLQFZY/6e2GLb/wf1I3eBZsJwdF/skJ5ZIjpLllBGEfxJQfcB8GPJOyRR/We686xxT7O+SX+laKFhRHK/hBKYiPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2gB1DkB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-669f8778d6bso161990767b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722537302; x=1723142102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1YHjewNqSuQw+aKISRkd4hlaIK++6vC5e9hG8f7rkrc=;
        b=Z2gB1DkBTKg5tFcjlUi+t1manENVuYnoPqTdf6wIhk/QXJLXfQMlQdcPBiCPfxWTRw
         JR/f1k7qLLxyAmValomylwHEkd7dVs/kYm6g87bObW4+LsM92kL3aYEDTpvfuEMmabq8
         c8Jb4zVyjtL1FDTTvQ8uG2198/5pfyfWykaW0MPsmvApdt/AJqUW74j2bSm1fV9UyTzV
         ztUt52sm5f8womKcA1fOKwXufZm3m7hCcT4Wze8VQf0/KaaWDdWwMUvIR9N5ovW7P7lu
         zG8NmSmqf33ZnsbkfdQve+aMnTFofH8OuYP9hdde0EKfzeQE+9j31WzI94py3SDlyFuM
         A8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537302; x=1723142102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YHjewNqSuQw+aKISRkd4hlaIK++6vC5e9hG8f7rkrc=;
        b=m9xwuMbt8k/9k9BUeg24DneUO6x06sQ2GJyxYqHfBmIj1l3F157WE9VAs1btQ1KnTG
         913xezyz/RwVfhOK+RGcFACLQcGXFHpjN5+1lLCGmoeKSl26nEL5tuTSTMHU93skk+SQ
         EMBGfJhOQ4gtEA3+5viE+HaEGCFLbGTu/IBV00M33WBuseQ2YkxV/HXFCm1+NhEPibn8
         3Lx9Rt67dVFiFyYz4nhbtdXWJMFnQzOc2tV4nYO3GFSOlQ2AdbIhO5UpCTDH6Jbnss2z
         mOq6WoKmHHHfoAzV+S4OWtUye3iGe8nSpk960/BuyCBREJpywxs43/8U4DBX31wFkqFx
         fQeA==
X-Forwarded-Encrypted: i=1; AJvYcCWM907jAt2qFBaV7OXyUosSpwyvz5l2+aOnHdTdXm23oqK+7DtxBhCQYjXl3hpQZxuN/9gCk8M/CuBXCuN8+zeMwZSUGToYHEgd32Ig
X-Gm-Message-State: AOJu0YwMRu62ppuEXg3oP4Gl4xJsv6t5jMrA8TT35kaiKIfV2X6PiDDp
	oH3/weeMjWUzIFMFYsOe3gOf3s3yPmxY4YwAvfJQArm3OfWinsIQK18lsw7F9pLhiulzAunFidV
	NYw==
X-Google-Smtp-Source: AGHT+IEAyNBNNAjkoq0+TR2DU9aO3yJBNbaHwXM7Z2FBl7YPBn99Zn4C9dL3lWrRoy2Zle815Z1OJBKpL3o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:660c:b0:61b:e73d:bea2 with SMTP id
 00721157ae682-68963706dc0mr17197b3.5.1722537302250; Thu, 01 Aug 2024 11:35:02
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Aug 2024 11:34:47 -0700
In-Reply-To: <20240801183453.57199-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801183453.57199-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801183453.57199-4-seanjc@google.com>
Subject: [RFC PATCH 3/9] KVM: x86/mmu: Set shadow_dirty_mask for EPT even if
 A/D bits disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Set shadow_dirty_mask to the architectural EPT Dirty bit value even if
A/D bits are disabled at the module level, i.e. even if KVM will never
enable A/D bits in hardware.  Doing so provides consistent behavior for
Accessed and Dirty bits, i.e. doesn't leave KVM in a state where it sets
shadow_accessed_mask but not shadow_dirty_mask.

Functionally, this should be one big nop, as consumption of
shadow_dirty_mask is always guarded by a check that hardware A/D bits are
enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index cae45825617c..a0ff504f1e7e 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -441,7 +441,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only)
 
 	shadow_user_mask	= VMX_EPT_READABLE_MASK;
 	shadow_accessed_mask	= VMX_EPT_ACCESS_BIT;
-	shadow_dirty_mask	= has_ad_bits ? VMX_EPT_DIRTY_BIT : 0ull;
+	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
 	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
 	/* VMX_EPT_SUPPRESS_VE_BIT is needed for W or X violation. */
-- 
2.46.0.rc1.232.g9752f9e123-goog


