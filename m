Return-Path: <linux-kernel+bounces-524898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BACA3E880
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC2D7AA5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC97267B88;
	Thu, 20 Feb 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2dqq6Kp"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C7267B01
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094207; cv=none; b=pvwsRo5e1f7ktnEV2OJQCcUREQu2FJ+VpXZbQClrCwPQDF3ZGgitETfhcfDifqg/UtJ/Dg22bhzcMq1qFWITMYtMKSjnminaXe33znkUwtNXsUde6G5XPnysew2fxoru5fYn4j/yZ+4g+qRxdmbx3jYJFPitlSB3V1cuH9ElCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094207; c=relaxed/simple;
	bh=Fq8ncCchsrCrQKzLlD/2bWJsivf8RZKsUMKlivyOCis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z6khakHCRW4yDFlQ6rm1sKohl/I/bpLxmidSdK8zHlNn3aTvu+iL7ZOD1bnwgnjgWlGvy9zWInm6HP2Xf+TtqnmxkTuBbeND1rlovxiUVA15e950MYbbHHqPLQMqyg8xXXM0heDR/M2xluACU8uqX0hl7AHf0gQgmqCFe8zJq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2dqq6Kp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1e7efdffso4843021a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740094205; x=1740699005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWRXbppsiEDXYIZyPawrnpzOZz1QBOlzbaekCOtPmh4=;
        b=G2dqq6KpID2lHOI9enGwIclsha+QLdenLhKYcW6u/emKZoy/JTDWAVFNCvt5q0o5bH
         blKt1ihzrwCAFi0avFohtePC7BeoJNjtvuo6YVTN+2bwU5lnISE4tmWaNVmSVY2QQNLm
         bqt/UEMzCOl5UDk/TzkpHeVsHk0q/+1aVOm5B640TEMKR09xZGzS/0SpA6HvjJ6OJHl2
         thwnWeuivK9V1xAgtEmRdMeE3E6pW4jWM3Z68nBs/KqzeUcXUWQ6pkp6YVaL6l9Dp/Xt
         qhKQUoSBrZ5z+IxuGw9w0+rTlzNNh3eviao2M/yB6nekL2iChihDJRp5YHu3pzokr3j0
         Gb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740094205; x=1740699005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWRXbppsiEDXYIZyPawrnpzOZz1QBOlzbaekCOtPmh4=;
        b=twT0Qj/DiC4iOb/FFrUrcIv4MlAvput9c11OwV5XLHCh0n0YfSpmSK1KTGAN9PUsmD
         OEdWzSidKLqpY/9gNL3XxXCyviBXR9mb0J14y5O5gFEmCDfQxKCoPrklutMOTR2+K/Sq
         7mN9dejqwncxdqYL2tQ9ltHbHpFL2CTzkRN2uVYcdbaCbR4jQ5p73qi5ro5ceuFIYzNu
         Y9tOpTcmpqd1ImTPHVuXS+ze6usZ1CI+nvLfReqO6YNnl5wNxxBrCo/SSguQtvjUiHAm
         AjCQ1KjDTvQjQqFuk8d/k5gH2JM0kpci3o/Pffrp2cjn+72J6OwMgAPcmN8AT5N5EgTO
         n8/A==
X-Forwarded-Encrypted: i=1; AJvYcCWqsOxdlc0kXiaB/sm1nq2D1kw5CQubyeJPoFGZmg9cIePz0Vtije1a/QG98oDtBlnfjaYwYZIsfEX8p6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn405mFALHtkuO/6rQoJxccSMHaDboBrEpCEvCId5DowcsrPM0
	LAmiLmmeTHLo7vZkJL5w8MYXm28noA9kx+AOSS29RcOKkGL38Alxi5XpQzd0KMX947TcDX0U7Qn
	taL1yDCI4/g==
X-Google-Smtp-Source: AGHT+IEJgmi64wdMWyANqEO34cKSZI9Wuz5tHq4A/owmtalUI629cLYAyrOiwBDklXhEIDQhnrCFWifbpOyeVA==
X-Received: from pjz8.prod.google.com ([2002:a17:90b:56c8:b0:2fc:c98:ea47])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2590:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2fce75e1b18mr2115049a91.0.1740094205662;
 Thu, 20 Feb 2025 15:30:05 -0800 (PST)
Date: Thu, 20 Feb 2025 23:29:58 +0000
In-Reply-To: <20250220232959.247600-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220232959.247600-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250220232959.247600-2-jiaqiyan@google.com>
Subject: [RFC PATCH v3 2/3] KVM: arm64: set FnV in vcpu's ESR_ELx when host
 FAR_EL2 is invalid
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Certain microarchitectures (e.g. Neoverse V2) do not keep track of
the faulting address for a memory load that consumes poisoned data
and results in a synchronous external abort (SEA). This means the
poisoned guest physical address is unavailable when KVM handles such
SEA in EL2, and FAR_EL2 just holds a garbage value. KVM sends SIGBUS
to interrupt VMM/vCPU but the si_addr will be zero.

In case VMM later asks KVM to synchronously inject a SEA into the
guest, KVM should set FnV bit
- in vcpu's ESR_EL1 to let guest kernel know that FAR_EL1 is invalid
  and holds garbage value
- in vcpu's ESR_EL2 to let nested virtualization know that FAR_EL2 is
  invalid and holds garbage value

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 arch/arm64/kvm/inject_fault.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index a640e839848e6..2b01b331a4879 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -13,6 +13,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_nested.h>
+#include <asm/kvm_ras.h>
 #include <asm/esr.h>
 
 static void pend_sync_exception(struct kvm_vcpu *vcpu)
@@ -81,6 +82,9 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 	if (!is_iabt)
 		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
 
+	if (!kvm_vcpu_sea_far_valid(vcpu))
+		esr |= ESR_ELx_FnV;
+
 	esr |= ESR_ELx_FSC_EXTABT;
 
 	if (match_target_el(vcpu, unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC))) {
-- 
2.48.1.658.g4767266eb4-goog


