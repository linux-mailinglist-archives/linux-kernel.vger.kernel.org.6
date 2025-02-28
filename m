Return-Path: <linux-kernel+bounces-537611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604BAA48E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70023B76F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7C178395;
	Fri, 28 Feb 2025 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cp0XXAD1"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628ED154C17
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707071; cv=none; b=B/kdlbukQ8ljn7r9dOSqLa6SQuVlNHl4DdjYSmLh/ZtEZV88XATZKs4BZ+xtKinSu9POM13SVk+OOP2Uc2D25PLr6zPKAFXqeat9flI073hLBI+IGeBCvX/y3ZiLw+NQFJdIGeZIze8jcpy+Je5RXnvpq3WD2Z8dDNGlUnS59zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707071; c=relaxed/simple;
	bh=FrAg2JyorIe0/fbtZ6H1UBDcm6ZSzN4dgaVrSF/c0jI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=slvBF+Fxh7Wh4PPWAOI7ar9y80gEleHk6DU2eQk8JwfaY2biGLd57++bL54PzAlyOphaIxkElcmr1IFD4++EY5MTz4hC1iKkj5D3SWcUXpAar+JHhYFRA5JWkDd/GcfuIa66g3yH/DKi4UeljYBGDBVe6rcl33U4nslUH4hzINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cp0XXAD1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe86c01f5cso3514319a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740707070; x=1741311870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgg6TdslREem8G9twRIimDeFP8lrtGahRwRwSo3/dXc=;
        b=Cp0XXAD111GhApFku5uG2YgpOAvGEK24Gx6m6JEKW9+s3wNAVHAjBts/5R5rjUgB30
         W4/TfIsHzxdV/oOC0ZbcEyPXeF/uax0l+2jDfsFpgViYLwGiXsVBYqEAKcoqCN9sP9FP
         X/9rTwBMSl3uu3C4kFMtpkweQdhe7NGtwX/ff7lHfF9DozU6wY6sMsIiJuP2ukY+DP6c
         t5mmC9gbWINWO1k7aamLvgkaRGOrwZiMsFYpmOvFTR/95sOLmIwaP1g9BzgEDFBipVvF
         7ZYrk4p37koyP0cvjXT9R3QuY0oPXxEBs8fNHcNrlnfYfxBYB2Z0+7wlcjjnO6JqrzHY
         V1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740707070; x=1741311870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgg6TdslREem8G9twRIimDeFP8lrtGahRwRwSo3/dXc=;
        b=vUNRnX8dPx29oISEstIU+wqyz5e0a+z+QvOXCVvdC7VPrzXPOjdcWrzDFFKeFtk420
         edxrLg2qcdH+oZjwKjchr0gbMScBKSj+yZTgEMXQIssnwP/nqyqX9vgEyR9NjTqKxm5Y
         lrTkgEkTfQjUAABOGm/jsVOda3ovn9bvNlLFtvOztNyxUoj3CztfMIlOCLDW+d6T/Jqn
         AxhlBtJTsTT2e4zTN4KKGF/xO6EPINnFVHU4wKMqa6hGoXY4EZ7EGb0FQnJaJiLbfIzh
         PwRq3vaNK/NLGYgn+ysMV355h3ELEeDRoheCysqqR3VTXN88M2GttnzxrbLxHx7psfKe
         RNeg==
X-Forwarded-Encrypted: i=1; AJvYcCV9n4Vo2PH873wv6ysaWz9JB6y5+AlZ2Ji+OrnxDyXER37xrWe4meqGLnv+7qqOyFqkqegsyik+0/B+bYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+26jC9OjN49Hh2ITdk60Anhf8leIFngj7eZkbwXhYctTq37M
	8stXpssJratSxVwWEbrONp5/PgFO3TpLf15l+mYf1jTG83uGuHc6sr/8VggNI75QzG9EsVm4ZQa
	2VTLUjzPMmX7S4zUFsw==
X-Google-Smtp-Source: AGHT+IEKbeYwPp3VufcnDG3oxb1HHJhquHFRS3WK6izEh4VhCj6uAX2NGWoxcV/iyT0wqgmgDGn12hkLp0j/InU1
X-Received: from pjn11.prod.google.com ([2002:a17:90b:570b:b0:2f5:4762:e778])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d40e:b0:2ee:c9b6:c26a with SMTP id 98e67ed59e1d1-2febab50df6mr2614956a91.11.1740707069702;
 Thu, 27 Feb 2025 17:44:29 -0800 (PST)
Date: Fri, 28 Feb 2025 01:44:16 +0000
In-Reply-To: <20250228014416.3925664-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228014416.3925664-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228014416.3925664-4-vannapurve@google.com>
Subject: [PATCH v7 3/3] x86/tdx: Emit warning if IRQs are enabled during HLT
 #VE handling
From: Vishal Annapurve <vannapurve@google.com>
To: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, 
	afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events.

Emit warning and fail emulation if IRQs are enabled during HLT #VE handling
to avoid running into scenarios where IRQ wake events are lost resulting in
indefinite HLT execution times.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/coco/tdx/tdx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 6aad910d119d..a97ddc6a52c3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -393,6 +393,14 @@ static int handle_halt(struct ve_info *ve)
 {
 	const bool irq_disabled = irqs_disabled();
 
+	/*
+	 * HLT with IRQs enabled is unsafe, as an IRQ that is intended to be a
+	 * wake event may be consumed before requesting HLT emulation, leaving
+	 * the vCPU blocking indefinitely.
+	 */
+	if (WARN_ONCE(!irq_disabled, "HLT emulation with IRQs enabled"))
+		return -EIO;
+
 	if (__halt(irq_disabled))
 		return -EIO;
 
-- 
2.48.1.711.g2feabab25a-goog


