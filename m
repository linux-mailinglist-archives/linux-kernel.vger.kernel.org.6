Return-Path: <linux-kernel+bounces-387491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D49B51F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A05A1C22C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7848205E2E;
	Tue, 29 Oct 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHlYeR4W"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A065201033
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227167; cv=none; b=qZ7pmewodO/3D7IDxN3a11m5F1LkjpNr+Krkzjd5UneNXUbnYjJbHJeEwJMVjBMCNt5lY5pcTctpnYJ5dieBI7N24OaCUz8DFq0zsKOvMjiqfQFgjPXvuJ8t5pFGU1Hf+xl76iMMs7eT97sCnT30Avsc1HPo0lhXOtkHhpkmvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227167; c=relaxed/simple;
	bh=QIBlHzKCzpo0A0kJ+Ne7rtACUMRu45enr6WWGFjIwAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YyzH+XPSSFn2YIx+UtaS4QhPLcC17Y40i6CbS5zsYjAsRp9hffSvIxEa3TAezpoBtLd1/ZRngZ8XAivBY/KOL4Zb2Is9Xr4FiDMgzMHsd8trYfx25AGBPnHp5LfBrfEBiExcFizue8BrDigvCRy5+pxar8KLesoIXPiXsXm//vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHlYeR4W; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eb0a32fc5aso4821698a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730227165; x=1730831965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFCC0Ppe61h9DsEPIrRB8kBdqdokYkAqWCjQxVIFEok=;
        b=gHlYeR4WzPapIGrZKM3D1c9UwgcCv1ioFJsqzkm2x6I5Ncq7smnFwsaflMv8fiU5vs
         uL7As5pHRRnjfP5Gngl0HBoRslj2VFbT/DAoJ7zEAPo5uw+Z42aGUntyUpnswochB8tP
         qMmi0juYamDZm7ZOQ0fx4LvMuN04H6/ghCAD5P9Vea0G1K97IVAvY28iwufSo4+hNvLm
         sYH2kwiTwGl1iS9MUNKzm1POJf3du5biBIC70BCaNb4bZncfhJbh82ETSmWfr+St578s
         4O+CH8brHt4s56ACzrbPVSfqNebhz48Xq0c29h045xJFA2BIb0OkFi4TR5lQ9nD8ER2b
         po6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730227165; x=1730831965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFCC0Ppe61h9DsEPIrRB8kBdqdokYkAqWCjQxVIFEok=;
        b=rOdWaEU2qmYUkYE+1c0e7d7+Tytoq0rXHN9vWRvWpdRjkUo06Gcuj5xzyhrh3BTtyi
         TW+PW/u2npimU+vQ30WS2Sh93GOQj7AJL0pmvyRbLfMJIZEfTT9iOrSh2glo4HTkMcV6
         1BheoySzjRTqS3gdKPte9QsDDk6YTEJ18Bt/N0KwChWaIMZo+ffQLh8DsJA1bWw4zkFY
         LUxiPCaPNSKAh2+Cd5e1rxrcC8gsVK1xIE+6erCKqgJ4Qpk/cq94C5JZoabxdlojTBdQ
         1iWh3nJLobhtMz02BDRXekfX5ZtDI13YlAYov9CLn+dl6QplKEWvruukwPWI5Qh0m4mA
         TVJw==
X-Gm-Message-State: AOJu0YyhwxajaLDwOSnvZxbBROXR4iuUhsiokE10zjzonkRsOrxexdBP
	IuyvDFyTdRJwZJaue4FqW/R5wPDPGpW+WIc0jD59dneoaVTN+B+WLnZiCBSaTb7RgBlDkWCSs3Q
	xP1BfkFfUTVy+ApHkIlFNVnCI26lXhAZQJJSK/UCtGBIu99dOQXiz3/B/6vlSXsL+MC5wAhvjGA
	9nHUq7vlj/V3mpVV9aFm55NndtLVwtIbhl/TH11hDWY/Wpi/gWwHE2aDvl1W8RGkdokpU=
X-Google-Smtp-Source: AGHT+IHX5lwAS9LIgoFFUtnChrdz7z7B7bwmI4NPfhehjIuR/74lymdkTB0KkRffRLZp83XLD8FH6uu+JFCbE/BFSA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a63:4f62:0:b0:6d4:4eea:bd22 with SMTP
 id 41be03b00d2f7-7edd7b857bfmr21710a12.4.1730227163130; Tue, 29 Oct 2024
 11:39:23 -0700 (PDT)
Date: Tue, 29 Oct 2024 18:39:01 +0000
In-Reply-To: <20241029183907.3536683-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029183907.3536683-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029183907.3536683-2-dionnaglaze@google.com>
Subject: [PATCH 1/4] kvm: svm: Fix gctx page leak on invalid inputs
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure that snp gctx page allocation is adequately deallocated on
failure during snp_launch_start.

Fixes: 136d8bc931c84f ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_START command")

CC: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>

Change-Id: Ief6e728d0c859c24a286d8a7e49f9ad2eb47b889
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 714c517dd4b72..f6e96ec0a5caa 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2212,10 +2212,6 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (sev->snp_context)
 		return -EINVAL;
 
-	sev->snp_context = snp_context_create(kvm, argp);
-	if (!sev->snp_context)
-		return -ENOTTY;
-
 	if (params.flags)
 		return -EINVAL;
 
@@ -2230,6 +2226,10 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (params.policy & SNP_POLICY_MASK_SINGLE_SOCKET)
 		return -EINVAL;
 
+	sev->snp_context = snp_context_create(kvm, argp);
+	if (!sev->snp_context)
+		return -ENOTTY;
+
 	start.gctx_paddr = __psp_pa(sev->snp_context);
 	start.policy = params.policy;
 	memcpy(start.gosvw, params.gosvw, sizeof(params.gosvw));
-- 
2.47.0.163.g1226f6d8fa-goog


