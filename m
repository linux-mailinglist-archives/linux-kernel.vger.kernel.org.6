Return-Path: <linux-kernel+bounces-281427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED6794D6DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07631F22C3A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690851991B8;
	Fri,  9 Aug 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gC/un9b"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622321990A3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230225; cv=none; b=WJkPCoKiw2luNwl6j+78wfE1DUUEdkboV1qZkMifc5/AHhjh8/4BBWnQEQGy2LBCByw23SNbQw5ixixJ/1ywji9r1CeHrQXCI5hFpOT9SRSuH14OzUg4reXdzPJI1+a6WoEIWOJL2fEtz7Tws/rRHysW0WTV1qmJqru89uQDTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230225; c=relaxed/simple;
	bh=yFBflmyh8QZBoiRzx8kLH3cDwLhEcq2bi6TGRbUHykE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PsaSe6ozE6ludQaBUAM9wUT2tF1oNcyDwZGsNqCmO57pAYSUpR0mus/i3/aAPZjV+nPi6zw/62r7WRLvbJnWlx1EY4ix3fSu0D9ak2RcbsWaTxF4WeMZTkLdp5dm1yanIF0avqkOqoN4iptnjYnPRvnj9k4KI0JP1aF+AsqXuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gC/un9b; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7106fcb5543so2013717b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230224; x=1723835024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dpThAu81+XUaVEIhWdG34RqJeDJX1In8gD4UvwvDbc0=;
        b=3gC/un9bqirfM3RGD3v3jM7gptwynDEfbIfTwpGFigTG0DRsC/mIrR+hCATCfNiSCT
         YTvDUajzVi6VlZzJFTmLiZLsh0ZRfAt8RyJYlmKJJBQA/tqe4bsTetWlB1r6PWHzZ/M2
         FE75/1jRldImmy0r8Ss4yIEsH9aXKy1ALMSdSjhG2M+swWYSCi+I6g7sR9C8prLeGfHs
         g8TK7Xu5H4r9JknXKrPclC/D1YJUMAovBw5IN24lfEUe6DuDUIwRfoGBulthFXzKK4dC
         aLEy+J/avsEBUrTMZW9WVfvDIPViDAGGOAQc3iUWJNgGmScAkt0P7VHs36jYiN+G5tzU
         7OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230224; x=1723835024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpThAu81+XUaVEIhWdG34RqJeDJX1In8gD4UvwvDbc0=;
        b=e1PQIcdvux5waEZU6c9JKJczn9OMSEBIg08Z/joSXXLnZfuVp/rAsr6DjjgMzYsuXy
         f5yOKgytIXinoh/4e0UreX313jwRHStzqkKM1QuRtnOIcg2bSIMROgI5zDDBpCd1HG4u
         gWVmL8jz8W9qP1BFIOvb8aumFGkLBfuoZdFlRZAJIwscfvLqQu7oFWrxMy7jotPeovnU
         huDRWkNGlbRC7G1pKiJE2ZJ0f+qFAGGqFqt/cf+hTkBHUtDy9W0ybEqD3IXQo1toQZBB
         ppnf+aAYCY29S10gCCqoV04rhSUqQvBXNBuMvRfRvhQ0jeO6JvYcMJPrmKt8JSqVFvrm
         0WCw==
X-Forwarded-Encrypted: i=1; AJvYcCVSkK+ku6bWHzhtHwhv5aZ+Xk/aaLAw0xqQHvsXSCch41yyClWMVDw6g3Trh0SgUkBLHIdFyyATIiBJHyveHbkpzXELn8hHqC+g0cov
X-Gm-Message-State: AOJu0Yw3qRMHV1+uuTjd0lI+NA0QPip7FVD5VDyrtgokCP/nQP4ucZi6
	VXE/Kv/IP7Zg/6PkxExasVQ1LdU2qvK2vaqHSzpbdiuLuLQmfoMCZAeDpsE48eazhnW131R+RAq
	nOA==
X-Google-Smtp-Source: AGHT+IEfQ8yvNuIaJdiTz+V3/PCjs/k37b1h4YSYcKmGqEYlmGjeaAnHP/jSzt4t2a2FLDINbWuuKtX0WoQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f5c:b0:70e:9de1:992e with SMTP id
 d2e1a72fcca58-710dc629036mr28643b3a.1.1723230223713; Fri, 09 Aug 2024
 12:03:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:03:06 -0700
In-Reply-To: <20240809190319.1710470-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-10-seanjc@google.com>
Subject: [PATCH 09/22] KVM: x86/mmu: Try "unprotect for retry" iff there are
 indirect SPs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Try to unprotect shadow pages if and only if indirect_shadow_pages is non-
zero, i.e. iff there is at least one protected such shadow page.  Pre-
checking indirect_shadow_pages avoids taking mmu_lock for write when the
gfn is write-protected by a third party, i.e. not for KVM shadow paging,
and in the *extremely* unlikely case that a different task has already
unprotected the last shadow page.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 09a42dc1fe5a..358294889baa 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2736,6 +2736,9 @@ bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa)
 	gpa_t gpa = cr2_or_gpa;
 	bool r;
 
+	if (!vcpu->kvm->arch.indirect_shadow_pages)
+		return false;
+
 	if (!vcpu->arch.mmu->root_role.direct)
 		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2_or_gpa, NULL);
 
-- 
2.46.0.76.ge559c4bf1a-goog


