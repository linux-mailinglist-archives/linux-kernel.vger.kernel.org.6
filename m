Return-Path: <linux-kernel+bounces-272968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E6B9462EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE2A282C9D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9E165F0C;
	Fri,  2 Aug 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hiqnT3b/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1A1537CE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622782; cv=none; b=Edr7fz0aX5841GzmGzcJIZ05cLuvanckawoEJqUcOzF0gd1oVC3YkDO3h8dhSxKt+lLZhM31KHwEzv7hFAWlDXItwHqw6/vbM4Twlxxznd2xnuwT9EaF5XiCRWuKm7JZswiuaO9YsePeYp7CbaFwspStAyA+Zlxq6j9qS597VBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622782; c=relaxed/simple;
	bh=PqAkbeX46Q/uqruzqqUfbvSnJ64882JvtNzQyytCBAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c/hdSN9cw05brZM5ev9aNnkrGjC+HgscOk+4YvIewLa7Ss7tJ/PqBU5rVstmnNMJOsvIqJiyHaGuYNc4wB7XCyMbGqx/ORNCNtc8YsQK3RzBtjUOOxhCDR8wh/+XXZBh8GtSRdNSXNNoH1KOI8L8PcHt49046htXsV2iXZs99lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hiqnT3b/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb4e6725ccso10459839a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722622780; x=1723227580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jQvD2XFUOoXKh/qvHzE0oWtyWzaKX7emTzrWlGmUYVU=;
        b=hiqnT3b//4qEz60ZslEs2FYz1j2vX05lU6bI4eOSCbB608l5M2wq9W9cY1Ggi9Nexl
         2B6XQvhIEgfF7Mq86iWVM2zNmfhvHUF4b6D2C7cViz4tRFuLm/d6/Zo928TXsCztE0ol
         b2Hc5T6XGaXKbr/lVb9TDca8tpq3v6pIWuKawRmdPsLl5WUlvscmPuFjjKDAF2XNAYJl
         MTJjUe1Hqd2X+SepUWGtuSCg1PhDvH0VzDBKRYeGYxpACX8apFYIbKmt2j/pr3N7nNiH
         naFJeCeriNxNg8DedqBgx/x7jSiA7EqZDYQffQAnAankoNhUl/zlb0NPiCvot9H6x0mS
         wy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722622780; x=1723227580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQvD2XFUOoXKh/qvHzE0oWtyWzaKX7emTzrWlGmUYVU=;
        b=mGqFAbodsnYIYXXyQ9K65simStvOB8zhGBI9ydIT8gGUQbcNtscWcr5whid5URd9sk
         OmqPGpuS03U1MdRMdbMNVuNXtU9TKJumnHiUh8I+hZyMNNvGr4YYFnd5GbvdKo40/lHg
         MJZl4QG2bBFJyaOZSllxa7Z1p+Lpah/9JOnVV469pmZSellet1L4KdKss/lGnbBp/wgs
         lX05Iy6Y/udHkCdVo7RWaXfz3rkzN3Ai682DIJ36eZSXKK3KFj3PiommT03aEgYc42dG
         5E06mmAOZYkJY5nlbEIs4x01ZR/Jr/fF40cNiRNMSFTUfjKC7TnxlB5v2VTLTW1ewYAu
         F82A==
X-Forwarded-Encrypted: i=1; AJvYcCUjL/hiIJyz9jLdsmSGC/k3vBrIpQxY4lFa0+D+HUOU4THJANt5PGnyVQPVLFLFB5wxUL35L+8jSOSKngtKJQvnkxyKz6V0FkGb1ymT
X-Gm-Message-State: AOJu0YwaLZS6KbuoVPrL7Bw/RWkPhL94BEwadgEjBDvbXJdSs9cL/so+
	bRE0Z8zp9CLqSVWzBawwbDVg2f4XYE7k1CK8xofCpYLX3FemsT3/1AqraGFLOpzHNwiPNDRHI1A
	kNA==
X-Google-Smtp-Source: AGHT+IG6uu1lx5JAUSYw/bNj45a08OL8ZJ97prbP8I5rSjynR6V2S9qofwrzh1JA+MVBjXVGnS3x1i7++1I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2354:b0:2c9:7fb8:ef1d with SMTP id
 98e67ed59e1d1-2cff952b45fmr67521a91.6.1722622780012; Fri, 02 Aug 2024
 11:19:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:19:26 -0700
In-Reply-To: <20240802181935.292540-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802181935.292540-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802181935.292540-2-seanjc@google.com>
Subject: [PATCH v2 01/10] KVM: SVM: Disallow guest from changing userspace's
 MSR_AMD64_DE_CFG value
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Inject a #GP if the guest attempts to change MSR_AMD64_DE_CFG from its
*current* value, not if the guest attempts to write a value other than
KVM's set of supported bits.  As per the comment and the changelog of the
original code, the intent is to effectively make MSR_AMD64_DE_CFG read-
only for the guest.

Opportunistically use a more conventional equality check instead of an
exclusive-OR check to detect attempts to change bits.

Fixes: d1d93fa90f1a ("KVM: SVM: Add MSR-based feature support for serializing LFENCE")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c115d26844f7..550ead197543 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3189,8 +3189,13 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (data & ~msr_entry.data)
 			return 1;
 
-		/* Don't allow the guest to change a bit, #GP */
-		if (!msr->host_initiated && (data ^ msr_entry.data))
+		/*
+		 * Don't let the guest change the host-programmed value.  The
+		 * MSR is very model specific, i.e. contains multiple bits that
+		 * are completely unknown to KVM, and the one bit known to KVM
+		 * is simply a reflection of hardware capatibilies.
+		 */
+		if (!msr->host_initiated && data != svm->msr_decfg)
 			return 1;
 
 		svm->msr_decfg = data;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


