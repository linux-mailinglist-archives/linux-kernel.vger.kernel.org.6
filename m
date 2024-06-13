Return-Path: <linux-kernel+bounces-213879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FFF907BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FD21F2426E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAFC15351B;
	Thu, 13 Jun 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYca01sR"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95114E2E7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305269; cv=none; b=dvrgRqRQuMOE3JjBFU/uf2k3KXTRz8iy5yqDv4HNMQW+kDsNVKexghrhgJNAJftAHniuxE4IW9ZzEnJiMgnnWnfSgGNPEbkfXhZjEyqQ0lD1o6DKD5tJOuKLc0VVL4mvGRVeaqfasGqDEq/2pgViy4fTQ6+NwP1XC+3HciyiSTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305269; c=relaxed/simple;
	bh=EdM3NFAHtqf7iO6j5P+sTJg6E55g7ZvNba3lzMdLcdE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IvOeean247zFzudNJNgd+HHAS38mdS2tarX0jz2Z7TYyKWi16/tqo9KS7TP0jiNVTmd39yM7RCXzxrof9kg4WUYqFw7xSMaevJuVcnyuZjAtHEUlJzpNSZ1NQzV09UWehBMXlP9KTE9LkCh9kuavgnqIL7gVmjH8ikWqw1eAu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qYca01sR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfef7ac17f8so1729584276.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718305266; x=1718910066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4scoAI3xWobVP6E+XRq1RKOC326O2un8fjhuaP6CeHI=;
        b=qYca01sRmt9Aj9brAT+UPLIs7l0+oYKqRqCdLIFggseMPqFNIvCGdQKYzu3G6LkuRf
         /6IXUddcTmCvfrhLk+OKM7VPwHlga6pXoBhVev3J9CEn50qyZH9xA/OERr0AIXYu6eIQ
         HmN4mVEDGQ0om0bLFmUIQ+HOtvgfhTZIZXW4sqfy9LGH+TmTT/5zm5gZdAsMFzLFPb5N
         LgD1sRo3jvYXQCoQKfsuerzbTFNBITMNqF1S1cyT6Rec4SVBYlkdWiP1MuowViX/IV3b
         zjWyZzIlgbu0CeJqHuQXKILlTCfXw0sitpV+e2bA+HCL1XqxFyzeMx47UUnk3i2cf/S7
         /XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718305266; x=1718910066;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4scoAI3xWobVP6E+XRq1RKOC326O2un8fjhuaP6CeHI=;
        b=QqaXOQS0s3thypNHq9+/0aQ0Lf1UfYE6H3fZQkDnU56G6/E3rlDFH6S4Uo5hVfvKMB
         LlUo/HBEjNBIUuk/tCTS8UGeU3kiv5OX0qG38c/kEv7IAVuvYzErjTHndR8I/oc8kOYY
         zSYHr1cyY5+4g/A/kOLcqMkoSmjQRwg8BGEOwqmia/9FQUdeTMEIyjHS8p570U67SSGE
         xMM43Ve28MNOHkyZwU31xE2Jj1H/RXXRrBVVH2+dEWFu21ytFS5KPxdWFOXtIXiTDxI3
         nhdX9vm0eDUQN1VuCvuF/y215bUPjS+GckynOIVxrH3T+9w3/qOlLpHvC9GNDgsXQOIS
         SJTg==
X-Forwarded-Encrypted: i=1; AJvYcCUmoXHCaYomXCmdYYnMXDIbTasaaLYNW6B8ZCzLt4EIpS5/YAdGPJvC5rZszZnkh4p+qHHkH9z/xMGdJJmw+CYA6seiIn2UCk9ZOzZ+
X-Gm-Message-State: AOJu0Yx0Vg6gk1xN1nDa3k/O1Of7P/9rqvQU+CDVgCDPoEsndvmRTpV8
	B9DeVxnqy8s/OmrarimZT25NRQ4EAmkJOetzvDfxkmFksyWw7OWJFyvyaTmiTSb0db/XV5M7WkD
	aDw==
X-Google-Smtp-Source: AGHT+IEz/kaKBHJHUJSiWymGtpYz5LODHuIW1raDtRMykoNrYAMEWe+IYh3gOJ/yB9zn1NGxXheewdBDEx8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bfc7:0:b0:dfa:ff74:f262 with SMTP id
 3f1490d57ef6-dfefed12278mr647712276.2.1718305266142; Thu, 13 Jun 2024
 12:01:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Jun 2024 12:01:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613190103.1054877-1-seanjc@google.com>
Subject: [PATCH] KVM: nVMX: Update VMCS12_REVISION comment to state it should
 never change
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Rewrite the comment above VMCS12_REVISION to unequivocally state that the
ID must never change.  KVM_{G,S}ET_NESTED_STATE have been officially
supported for some time now, i.e. changing VMCS12_REVISION would break
userspace.

Opportunistically add a blurb to the CHECK_OFFSET() comment to make it
explicitly clear that new fields are allowed, i.e. that the restriction
on the layout is all about backwards compatibility.

No functional change intended.

Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmcs12.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
index 01936013428b..56fd150a6f24 100644
--- a/arch/x86/kvm/vmx/vmcs12.h
+++ b/arch/x86/kvm/vmx/vmcs12.h
@@ -188,12 +188,13 @@ struct __packed vmcs12 {
 };
 
 /*
- * VMCS12_REVISION is an arbitrary id that should be changed if the content or
- * layout of struct vmcs12 is changed. MSR_IA32_VMX_BASIC returns this id, and
- * VMPTRLD verifies that the VMCS region that L1 is loading contains this id.
+ * VMCS12_REVISION is KVM's arbitrary ID for the layout of struct vmcs12.  KVM
+ * enumerates this value to L1 via MSR_IA32_VMX_BASIC, and checks the revision
+ * ID during nested VMPTRLD to verify that L1 is loading a VMCS that adhere's
+ * to KVM's virtual CPU definition.
  *
- * IMPORTANT: Changing this value will break save/restore compatibility with
- * older kvm releases.
+ * DO NOT change this value, as it will break save/restore compatibility with
+ * older KVM releases.
  */
 #define VMCS12_REVISION 0x11e57ed0
 
@@ -206,7 +207,8 @@ struct __packed vmcs12 {
 #define VMCS12_SIZE		KVM_STATE_NESTED_VMX_VMCS_SIZE
 
 /*
- * For save/restore compatibility, the vmcs12 field offsets must not change.
+ * For save/restore compatibility, the vmcs12 field offsets must not change,
+ * although appending fields and/or filling gaps is obviously allowed.
  */
 #define CHECK_OFFSET(field, loc) \
 	ASSERT_STRUCT_OFFSET(struct vmcs12, field, loc)

base-commit: e4e9e1067138e5620cf0500c3e5f6ebfb9d322c8
-- 
2.45.2.627.g7a2c4fd464-goog


