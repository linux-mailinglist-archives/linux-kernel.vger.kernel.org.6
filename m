Return-Path: <linux-kernel+bounces-535255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF923A470A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B9B188CF72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0424B28;
	Thu, 27 Feb 2025 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5bwLIWn"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A476034
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618079; cv=none; b=GTtt/gm9jzMTFMluLQKJvGAltCkUJudvbnXxto/ZQn9PaViWR7uuGe9x2XffW57+OvsIRg/a9PdrOOV/pinMf/vL78UpqC83AytjGQ6k9qM/BOtQP6UkjPN8ihp3nhEpHAPw7iDoFl6qjmG10Gb6BCyhCrF17KJ8sKvzIOYcjbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618079; c=relaxed/simple;
	bh=WlG71nbfhMG+iZLSreFus8KOoSWVnI0WTDVJb/q9jyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XrObacmnDrHoNQGVyhsf/nZ4nmAoGPT+s9JHmlf0U35VWwY7IUVmGt8iqpciHP05l1yNzBzNH6fGOSJ1bImUlDgH5M/yVS878xS3isMnqlk4WBYze5jYTcFeNekNzx8u5ZRFUKNxfjnaYVCJPayTnIHe4OIKbrqCHJTU5R7Z7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5bwLIWn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6cb3097bso7795635ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740618077; x=1741222877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vBrLV0hVNi1a5D0W6BOn6trR5W1NotqikKgQ5Tv/tAA=;
        b=h5bwLIWnwuwrVytdM2CbIkyHDKiwxHsBucwH/HVkYoAGvzRRf2ExPXlMyntnUdjoas
         QobhzuDj107Ca/zGaDS+w8BQFr4aSwDVqMKP3XztP9CbtwtNVGlmpelAT2ovNx+GajMm
         MW2gB//r/0CeMbPWGRG9avSqFq6QfKj/zmv+4MgIL9RTU8bo18I1u6ZRNezMD64Pd+AZ
         N/m+tHyM9GIw+bIwKehFhe/KSUdgemEDxI44vQrKaHbMakUVB9awcY8nIHSsZKgi5LWS
         pogQZ+xysPF02k+tial2LdtKDUuLvHQJ/awgaLnsIvwGX+oUiAzO6f50wXg4+AtF/DPw
         orjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740618077; x=1741222877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBrLV0hVNi1a5D0W6BOn6trR5W1NotqikKgQ5Tv/tAA=;
        b=iVOCKEtBrb5ZkrrKrHSupT+ALVwKV769i3ughln+B8y1ruF4IfCmTJc5CIa9OE0/KP
         QQL9OTWmct5sUevsOaWNQD+1RQQXwoIYKeTkaBzOkMSG1jbVOIvTaLmi/BrSuIhT4dqg
         mrcYcdM9zAasK7lN65hZMGOsdejhogArzOd68EtbFTJhAg3RPCRI8H8CTgZP6pS4zc/+
         adqf4JPPcno1ghP1jg4j2LWuLRf1WAuZkTECtpnZdij5de+V7DE99sDVHg9zu7CP+K8z
         B38+7M47gs1pQn3arNRphOwlii5dJwGD+KwTg2qjmCoHo4NsdrMvDwk0CpItDlvOBaF2
         h4eA==
X-Forwarded-Encrypted: i=1; AJvYcCXbEnXuCaHTBuw6cddEa2VB1jsLbHmDGVrxBLz+yh5AQljsWYzESnOTvBhgKfR54fSeSLFAWvjmdQxvtmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNF+/opLk7TFnYd5dTu9kJpUImAJw0EdLzAzB0iLTdj6vnOjm
	2habi62rxd/tHaMO433y7EzB/026wgSVx6Q8wegGMTrkAjhRbZLnvqquApG1aiEMPs70MSn/mql
	kIA==
X-Google-Smtp-Source: AGHT+IHs7OvM6rkyJG6uPTB8OuiiFrOfEIijhU66O7j1sKQRSBCikrQVvi/YgsIilD/6fEgCFLkFRZL+ErE=
X-Received: from pfbfb26.prod.google.com ([2002:a05:6a00:2d9a:b0:734:4341:5d97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eccb:b0:220:ea90:1925
 with SMTP id d9443c01a7336-221a1148e99mr409270715ad.35.1740618077666; Wed, 26
 Feb 2025 17:01:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:01:11 -0800
In-Reply-To: <20250227010111.3222742-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227010111.3222742-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227010111.3222742-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86: Advertise support for WRMSRNS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Advertise support for WRMSRNS (WRMSR non-serializing) to userspace if the
instruction is supported by the underlying CPU.  From a virtualization
perspective, the only difference between WRMSRNS and WRMSR is that VM-Exits
due to WRMSRNS set EXIT_QUALIFICATION to '1'.  WRMSRNS doesn't require a
new enabling control, shares the same basic exit reason, and behaves the
same as WRMSR with respect to MSR interception.

  WRMSR and WRMSRNS use the same basic exit reason (see Appendix C). For
  WRMSR, the exit qualification is 0, while for WRMSRNS it is 1.

Don't do anything different when emulating WRMSRNS vs. WRMSR, as KVM can't
do anything less, i.e. can't make emulation non-serializing.  The
motivation for the guest to use WRMSRNS instead of WRMSR is to avoid
immediately serializing the CPU when the necessary serialization is
guaranteed by some other mechanism, i.e. WRMSRNS being fully serializing
isn't guest-visible, just less performant.

Suggested-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 97a90689a9dc..ebecfe4bea1e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -992,6 +992,7 @@ void kvm_set_cpu_caps(void)
 		F(FZRM),
 		F(FSRS),
 		F(FSRC),
+		F(WRMSRNS),
 		F(AMX_FP16),
 		F(AVX_IFMA),
 		F(LAM),
-- 
2.48.1.711.g2feabab25a-goog


