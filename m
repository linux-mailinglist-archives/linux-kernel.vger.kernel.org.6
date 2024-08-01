Return-Path: <linux-kernel+bounces-271757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DBB9452F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1A11C23D02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7E1494A7;
	Thu,  1 Aug 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbV9Ee+M"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF30143743
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537603; cv=none; b=qUyRrcnBTdTJM0IrNFBUJssooDgG5yUzY5lAFbwiDdxfnUx96Guz3gofnsklbsof5/WMqORHhtUTKBXwzWruSvaQh2xEBPwBqU4VRIZPcIuCzPLQ0EFAU1a5+Lcz0ttJK/KLO23N/wyoGsxXfn+huvrhNdgnL5RaagxZl8GtE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537603; c=relaxed/simple;
	bh=v3ngMtvWawUbNngrsCnmsU9HoWKp4/snJm8LhI4ZsL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j3Plzg/5oyKZSYviCRVB54cK+w9I0RCQR60jfF2BbGPw86LyJWyjo41UA/DWoeJ02gr6XS4mSJpzRULweVgQhaosZXF834CSfmONlTbqwenI6DztKnkYdvoQnJI/ema/IyAgNm3VQVB2X3vLGSe7nlzCoy3fnz/7j4SXX/QnSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbV9Ee+M; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66a8ce9eecfso35554647b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722537601; x=1723142401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T6yPRhC8+VoSP5QSl7WqotG6f6x/q7DmyfyOAFIfGXQ=;
        b=KbV9Ee+MtjGJK1M4YAjAMLV3ULX7QteAlLM+xkVtQ+G87phsLuSszTOxbVLq1SZrN7
         ZhOsRgsCVXgzb8+G+EW11lHLfn8xKdESGbnDBTK4N4YlI+cFx2vg2BntPcHssnVfnTCG
         fMel8f7pcPTnxZq1xthPjlpI9OdEEiKrOXWC8MOzn8Ns/pp3Diz/CZLbJmu5BfUgiAfh
         DS3rhJ1z8rA0Z67GeIxEhCNG0KYrXPV/GSExTH+D9dgRz25Fb67PNhXRymZXz3rjEAJK
         MHO3Wqz3wYYcqMNhRe0VVv9ZCkfANUdEo2WxSAqKkGdPdjHS+KUlIgwQ6t8GObJsSVb/
         q4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537601; x=1723142401;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6yPRhC8+VoSP5QSl7WqotG6f6x/q7DmyfyOAFIfGXQ=;
        b=qedIne9u1ol+SAhPM9ms6jT/EPDhwUlhTHEwipNReiTFjDSjDBI8OxSFvDhkcjpY/X
         etpvD+k0WU4De0dMYrxtO4Tg6h6Keiew+VScQMTCDktll87vLVN7BXzU0MX7Z8IBNRUc
         RFvCGnatIthmoEBYuYDFKpo7/ZOdwuu8ssr8XVHfnPtsNCG6rsp+PioBZFlaDy7rateA
         Tcxe1ApHtcWaASR+zDg1CYMNwWDBM12MNwXNAHz1omajdOX13GmD8qnzVWi89rL/WDs7
         e44ViUYbD2LHS9ZnPNsnq4iYU9EdVV1D46BiAThp/A7wceror6ZX9mMdD9f69IWqW9T1
         wUag==
X-Forwarded-Encrypted: i=1; AJvYcCVXbXQAg43zrZP2sEZ0NtBkmbQgBRJxOIlBzu1ndCn8k2Zq5Z0plg6LVsQhxwbMze34I3lukfmz3MFwcTXNkB3HYAhdfAx34VcyrcY8
X-Gm-Message-State: AOJu0Yw6s6sGPsZgsuJB4gpbPnHUq9BbIWPqURvxGXIRYz3xwz7Ur4+i
	CtxtlAGjiV35fNFRNX4Z6gb44ZQIxPBhZjja0gfJQ8wRm6gkCO3cmpl/Pc8v4VWNFlspelMiGKg
	mdfzxncNaijwsZ2kcTQ==
X-Google-Smtp-Source: AGHT+IHYOqsisgtCA4aJn8iiJrhlOqWcWkXhmH+zVo7bk8yf1CWdZe9U3mUn5G8dyhc0nxA756eyNP+k6DuS+1MQ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:dc7:b0:64b:2608:a6b9 with SMTP
 id 00721157ae682-689643921c3mr457477b3.3.1722537600846; Thu, 01 Aug 2024
 11:40:00 -0700 (PDT)
Date: Thu,  1 Aug 2024 18:39:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801183958.2030252-1-yosryahmed@google.com>
Subject: [PATCH] x86/hyperv: use helpers to read control registers in hv_snp_boot_ap()
From: Yosry Ahmed <yosryahmed@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Use native_read_cr*() helpers to read control registers into vmsa->cr*
instead of open-coded assembly.

No functional change intended, unless there was a purpose to specifying
rax.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/hyperv/ivm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b4a851d27c7cb..434507dd135c5 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -321,9 +321,9 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 
 	vmsa->efer = native_read_msr(MSR_EFER);
 
-	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
-	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
-	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
+	vmsa->cr4 = native_read_cr4();
+	vmsa->cr3 = __native_read_cr3();
+	vmsa->cr3 = native_read_cr0();
 
 	vmsa->xcr0 = 1;
 	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


