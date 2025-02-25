Return-Path: <linux-kernel+bounces-530325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FB3A43210
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C19189C6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CFA13DDAE;
	Tue, 25 Feb 2025 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgWMwaP2"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6B7EF09
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444447; cv=none; b=JvcTsm3d6vUTABaSLOZUveYHD3cStGWpKw4PVWUAwg9s7iZ6XGYbbp/uyjDf+PZLG4GbcjEXXouX6zsNeIoWTXxfqq0GHhB+ThnfjvNJtlEqLlFbyC75m+hswetTQEhG5yK9Tic460Eq5ip5cu5kHS3+oupn7KXUlsejSTJEmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444447; c=relaxed/simple;
	bh=T/cQq2gbcXMKaZsXGstnUvsS5gx3e8vAXQQMeBxex2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pm5bT7ZAj7PK8nzSY+ezVUmvmfium092qhV1zgWKX1ixHntdKL7i+MM29jP9jM9HQH4dOgHBZkyIFAgFstJC5xSfen92A04XaIcQ2LLUBg14f7hplLNc0ydrywnIqK88WKYLn3mTU5MtEj2PnrC6wx9+rQnM44U5LwImHMFEA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgWMwaP2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220bf94cb40so75572035ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740444445; x=1741049245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qy8TYReQarf8Nrq0hVwWXasfFIELVED1LEfWVnYQz38=;
        b=cgWMwaP2zUthNny1UTpCRO7ZDnf74NDm+y2HrBijqK6UTg6fn0Ajt1FgNrnCXNe7Xe
         LhGPY7HYDkf6FkX2HYvDEsUhjxn4rgB+YBjrFZ3nYONoZsrWTRpRFzfad1JyRXSoocCI
         AXF3Cue03J5XrmjsirNXE5meRXWXXcKfYfIPXigUp58qXqSlIRz1R3n0RM0wSEUEYfYg
         /7tSFGMWlacD0c2CjrMoLBCmJgK0ZSZz4Kv4h8YOCNuxcL2bNgmJz5lao602WlIlVBbs
         OI1bQveXbhacCVd3I8ujznqTs+qQv2sRdDIrDC+r8/j2ugIgQbyQaCPWA2Z57Q5zsohH
         BjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740444445; x=1741049245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qy8TYReQarf8Nrq0hVwWXasfFIELVED1LEfWVnYQz38=;
        b=Q0Q+ORAF4e+dzs3QL8RRuIn6WuhXDQxEfejd+Hi/6Q5ObWs9iJ9ju3qWo7D8gyy8m9
         tRCvsZHKm1UiTmIvx/EBPxbqLTrxMcDMtTuYDQl3+rIzKWUm6AJmK8XLtQTxr6cC7U22
         3LeT67kQZtT75K3vZ1bhssDt5tX4VpB/DuP4YgKYp8ofhbw0QHPXTrpCOUthoIebP8Ew
         2tBZSxVXhhjONcLNfgTwnBIHdzF807fjCP4PPFlCnnR3OJu1jdNzhr5MaM6R30Lk2h5K
         KYViaLTwQFAL9ezSbpGb0Wj3EIAA/ILjEJf4W8gs1rJ9rodQxVI5cpdazGaM5MpABYDo
         ioDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvfR3ts/0t4ExAaBWuZbTHv1cYXQ7qRkj+iyFy09vs6RGjFqsPubpREVPwg+VyiQ8TdhKsQ7uZsRoeajk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcgLVF9BRXm7xJPcDFQkFIwrHvQJWu4DMreb/pS23rVH/ibwT
	Io3QHKe38oMaEJB4VQHwqtFiajcWRPGYMSnMyoq88zcBzTaIpqYJb96l0Mc3rwrqwXjTD+Pbukr
	zYij1Gj+dHdMsELzp+A==
X-Google-Smtp-Source: AGHT+IG5ZWwtjOfGO4up++fIH8Fd9d29YqqhhBkZbAuQom+4PbvZsYIdau1Ht7XhTV48M3uxa4Ns4uXofty1xJ89
X-Received: from pfod15.prod.google.com ([2002:aa7:868f:0:b0:730:451c:475c])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:847:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-73426ce8016mr24215790b3a.12.1740444445348;
 Mon, 24 Feb 2025 16:47:25 -0800 (PST)
Date: Tue, 25 Feb 2025 00:47:04 +0000
In-Reply-To: <20250225004704.603652-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225004704.603652-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225004704.603652-4-vannapurve@google.com>
Subject: [PATCH v6 3/3] x86/tdx: Emit warning if IRQs are enabled during HLT
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
2.48.1.658.g4767266eb4-goog


