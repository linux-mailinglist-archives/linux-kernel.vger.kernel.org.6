Return-Path: <linux-kernel+bounces-273017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A18094636B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C1D1F231F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B83C165EF6;
	Fri,  2 Aug 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CP5EEHLs"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEF1547F8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624921; cv=none; b=FTs4BErH3Rc7UuqZkc7AuLJI2Q874TOM4XqeN50s+4Xv2+Vqlnxr/9TRVlknJwnhTP/7IrMwortPcbDLLUp1zeEJ4sNVPb4FWJiSjUlme2e9zVf7nOBOdY+eestQGKMiKaOs88oqbpDXhdJbuViayTHFtEtBKQ5RknijY0WO+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624921; c=relaxed/simple;
	bh=QyNQ0Oqb7FdCfzwjFj1xkToJr6T5PE0/uvPgcJWZ4C0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hHdNp7C1aqVbZY4BxQOLuxqchcW5LIuAMNBDdBXg2lyYyWWsA8Ug2/XjnQ3GwAoH47pK+OdZb7PSAtRuEEQ3M8ose1ITQBGtfgd6lzDRzTg8xN6IgAt8p3m/h7NTuS+CYXWCzTMyilV9BqpHkQ0p1T9f+MUGfFQGSvaPB3IU4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CP5EEHLs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a12bb066aaso5867429a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624920; x=1723229720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JttS58Cfh+ARtvi0QJi1xDgFsf8r3SUnJHwvWqtvGCM=;
        b=CP5EEHLshI0P9XkxDv/jIfpj/AG/uSu01rJX27pRCbvDLNDpdINA385yevp+IyYmIo
         uawy9WMwEjIlUObOGGSFbzrAP4Du9GybHpXgbmkQPwSv2EAciMGRo+lM6qk5LjFKukNl
         UNs0kzJCRC+r32vyenC7Yilv/04i/IdMCNM0S2V288rtEjbmMbF4KyTeJeorRx1QtbT1
         ApimKBXc3PiEqJg3JtwT4OJNQwCq9cCw0rMEE/xsd+Ji9woZUK81c1F6rRa89LuUOYij
         XsLVdaaLfTvfeUV7suUor3uJL4diqGuWUzb8IwgEayUjhKs8Zo0gXlm8y7u8GN5oiHY1
         TsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624920; x=1723229720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JttS58Cfh+ARtvi0QJi1xDgFsf8r3SUnJHwvWqtvGCM=;
        b=EezLhvsoZQ76S1Ezj38kLEem+EGcMipzOFVFHkbfTI/X/v9Dah46sm84+0vq0bCT6M
         4HDAULq+UAP8BshO5WwXDecl+3qU4Rx1os42SjqnzFBFXPnCbhaJVCIZfAIXhLwWm0wj
         Y9DHdxg1+UfF9gzP/89P1cjw9LJtr5qWmPaH9kUG3j+EG/HinZDjTA977SQFQ6nTcLEH
         QioXVCeQccEsRBuULy7CIMeNYNozXkh1328mqE5f9eMt9FvTlUkfd6h5AOnUcF0detu5
         dfd/AmGpLmwkBB9PxFRaxO6pkCPlGE4ubQKbE+kzuEuYYPIwllPC/EA+Bo5XWcUeT7+z
         akIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQnSSnclopJXzZvklhi+7AmpW0OSf0ISrEjuJn6s1/AlwZXiba+OduPrdwpVUBBcXOMgeP/ROqFQt/Ede2Q1HxG/XKE4RlrQBzzxqx
X-Gm-Message-State: AOJu0Yys0p2ItmWgBIUOo2V0cB0BuSIaubUZic+yjv0PyU4ZZFONlMnx
	kxWAnnt0KVlo9IFw6IxxnZYzKBO/uODW2PVJpT7WcB+THkFxMmhHp/gWMu2EfeJjpxlp9HcU28n
	8FA==
X-Google-Smtp-Source: AGHT+IGo6Vxup1v+/CZGAhM43Qpz2OsOQJshZPvUx0Dh2/2uLVkIkkMAp/Ex2vkPA4R7A6V1ps33MfM7cx8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6f01:0:b0:785:e3e:38db with SMTP id
 41be03b00d2f7-7b749040f0amr8475a12.8.1722624919563; Fri, 02 Aug 2024 11:55:19
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:55:04 -0700
In-Reply-To: <20240802185511.305849-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802185511.305849-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802185511.305849-3-seanjc@google.com>
Subject: [PATCH 2/9] KVM: x86: Disallow changing MSR_PLATFORM_INFO after vCPU
 has run
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tag MSR_PLATFORM_INFO as a feature MSR (because it is), i.e. disallow it
from being modified after the vCPU has run.

To make KVM's selftest compliant, simply delete the userspace MSR write
that restores KVM's original value at the end of the test.  Verifying that
userspace can write back what it originally read is uninteresting in this
particular case, because KVM doesn't enforce _any_ bits in the MSR, i.e.
userspace should be able to write any arbitrary value.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c                                      | 1 +
 tools/testing/selftests/kvm/x86_64/platform_info_test.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9d667c5ab1a9..a9566c035857 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -451,6 +451,7 @@ static const u32 msr_based_features_all_except_vmx[] = {
 	MSR_IA32_UCODE_REV,
 	MSR_IA32_ARCH_CAPABILITIES,
 	MSR_IA32_PERF_CAPABILITIES,
+	MSR_PLATFORM_INFO,
 };
 
 static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
index eda88080c186..9cbf283ebc55 100644
--- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
+++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
@@ -72,8 +72,6 @@ int main(int argc, char *argv[])
 	}
 
 done:
-	vcpu_set_msr(vcpu, MSR_PLATFORM_INFO, msr_platform_info);
-
 	kvm_vm_free(vm);
 
 	return 0;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


