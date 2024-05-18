Return-Path: <linux-kernel+bounces-182712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85758C8EBF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8731F22546
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D43EAD4;
	Sat, 18 May 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhbH19bc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40161C13C
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990683; cv=none; b=ctav/fprY5URNuQGtz4nmzI04q+1zmXvVG2WbLX40zwSjCfKBJ76D4nlD52Cq2uYKn9OJnLf7qwwWb0X2GiyMQcbUrbeCvtUSKDAfwSuJItwJTM/zOCxsekIZrBPP/AK2vf2icj36TtcAkApKswXYPYQb8px/ymwTpkGPZ36FIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990683; c=relaxed/simple;
	bh=KJtLDlzQg0wy9e57GzodTPJt6UlMTvdQZUilMOrGkZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ufjo+3yHO+ic4Ptia1CVxKBkod2JAnPNQiePGQkqy2q5GQfZ+qOgaXA1LOFGSZD9H75XEaJEsg6CwDiAX/Yxe6sdWuZbjGIa/QpgVRHssQQOAEG3CaN7Tax2Brn8xTsmJAxvvICPszVEDTnHlGczUJHSROqjF9geerFEe5Ozoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhbH19bc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61dfa4090c1so152972967b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715990681; x=1716595481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GM5SO5v27GV7rdeXp4FaIGBag6GhBo/t/KPBUjUr/dw=;
        b=NhbH19bcmfe4ldcoAO3NE9GVpwtCA6D9eAfUCFgbuyxwEH2yeq/TwObXqgo/sL8Znp
         7gx9NdSpsG8F7vCFm1kGnzLl104nxADxXwzF4pfn83qTffGUicz8cpG1inMABCQ7EtCE
         sFS/0mGym5xAIup5YYUqdLtrjqmJQ7FMN/ynlBT/u/RdxShDwKqfNc59BWKWo1ZU7AHj
         n3O859kUxlvtmZFB7T56pqERplAGe8F73As0/dfJO+aBL5ZMeaibla46nC/swC5NTf6I
         q74w3wOGfgqr+UMM/8rCW2lt85mfphBemUrvjMcdGIZ+71iGbDBD3pVNKCE1BxFdw3oy
         tE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990681; x=1716595481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GM5SO5v27GV7rdeXp4FaIGBag6GhBo/t/KPBUjUr/dw=;
        b=ZCcyO7AZdefR03lUcx34vQW5erDBCjFoR0NbiM1PIahtnbwP7qU3aIYax8WEm9JTMd
         jBBHBeSaRQV17YrnQckmNF/k63naz55qYI+QCazyB7Rf6c0lCA9lYXd85JvxB1NcbYnM
         yzMAKDFpg6mPE7LF46SxdmAVIBqkXqXK1nNlW2g8QK65w98A/LwGVLWj9UsdoOF+7iZ7
         igRoqh9Laj4XYsdqfbWKsukM1EF6HU6WM6Noq30pDrn0KaapVc0BqlbG2Wggv9uoEVT+
         B+7npPK/AMGCFutUgVbVGvfWM6OZoxyLprhRSjDhdbkp1FYBX/LOXhKX+4VBrilz9w8o
         GM3g==
X-Forwarded-Encrypted: i=1; AJvYcCXi7ETKsbnCbVvJm02M8CTmIbx/PjGbiTEG6v5IsqJdza59aq89eTeY0U/EgOB0q/xDcoqNFfTblyK8Ive1RdekG9iCyiDUqAoisujY
X-Gm-Message-State: AOJu0YywFuRaibTLZ4biDGuvC62vrtY0wvUKPHFCn38c31OBbF3KK02X
	u1usbbqXuCGaY+2q4EMmasxEN6Xqxxv9a0cC8ttBr5JRfd0PZ00qq6CQz1Y5+43i4OMLD5WKQ55
	opQ==
X-Google-Smtp-Source: AGHT+IFuoSzVp7PcfFD1Q1RorBxgwCQkq06IFSmtCXpMTO3G31frkl5Q+wTnbphKiOylmI+xCkIbpuIbE84=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:dd85:0:b0:627:7563:95b1 with SMTP id
 00721157ae682-6277563967cmr14645877b3.5.1715990681328; Fri, 17 May 2024
 17:04:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 17:04:24 -0700
In-Reply-To: <20240518000430.1118488-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240518000430.1118488-4-seanjc@google.com>
Subject: [PATCH 3/9] KVM: nVMX: Always handle #VEs in L0 (never forward #VEs
 from L2 to L1)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Always handle #VEs, e.g. due to prove EPT Violation #VE failures, in L0,
as KVM does not expose any #VE capabilities to L1, i.e. any and all #VEs
are KVM's responsibility.

Fixes: 8131cf5b4fd8 ("KVM: VMX: Introduce test mode related to EPT violation VE")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6798fadaa335..643935a0f70a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6233,6 +6233,8 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 		else if (is_alignment_check(intr_info) &&
 			 !vmx_guest_inject_ac(vcpu))
 			return true;
+		else if (is_ve_fault(intr_info))
+			return true;
 		return false;
 	case EXIT_REASON_EXTERNAL_INTERRUPT:
 		return true;
-- 
2.45.0.215.g3402c0e53f-goog


