Return-Path: <linux-kernel+bounces-424151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B349DB112
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B1616444A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD21A1C302E;
	Thu, 28 Nov 2024 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="coHkjAS0"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1651C1F31
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757740; cv=none; b=pp8wuyYDZFONRnnKsOsHxMu9NT08XQdFWMEqY5UdphFpO58lx+yy3yCG2BpZN1K1yIE1UN4siiDkBoBAh090uRNvKY81cGDLpqXYej4ENNQMMMirCWzwwFH8mnb6eo7tgTE5yq9fFfNbCDGaCK8JdvGU1YTvC5tE7amhLmzMXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757740; c=relaxed/simple;
	bh=I/YDR3JStGxjrdjAITcHrtFRex6HHvT0+U3XKq8mm6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sqZonszyBeDkJOc7hnX1ekS57RzlYym49U2Hq9XsTDYhyZJSt6GpLuHbCPw9rD66Jr74yT/5fzhjcwKI9C8W+CNHa/iVtmzUBB2rG/6MQX+D/RsysojKqWtqKRXRhMUyNbJPPXoFQWYWCVBmT3Eeau02hEu8JR+lxWEVGSHFgAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=coHkjAS0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ea0069a8b0so181375a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757738; x=1733362538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iYvz2Rhm4HLNhXyImO2FrXh2iHX5TjPw17ql6ofDjOI=;
        b=coHkjAS0VE0Ntv9SpGYT+KmW5QivqO9hdzy/8Ax60ZfvF72ph+inLrr0cuanXV5l3f
         fNX2R4CobbCm+VghtCvZciydhfQpP1cxLQdf3aX72gFWbt46AD4wqbhnb4op3InCxZCb
         98F6sD0OsuqrTRUv8BrtVJjKGNwTI1Zl1tkKjITkojEX7EWY4Jc00gwCQuBiydBco0eJ
         TwBlhlp3kGjpzVnfkOWQsTcZhFQj44bpe27d/Dn+egYGM+mzwXdYuJhsRh4Sw6O6czW9
         ZmDygonrDlAOp2myVj2NFtDPX/QEjqXDaZ7g0hYTiV0ltVIs3rQSn3bk7bI3w8zIiTlV
         SMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757738; x=1733362538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYvz2Rhm4HLNhXyImO2FrXh2iHX5TjPw17ql6ofDjOI=;
        b=kf3i+Fo2GZZW8SFToGQ2RXkDYVPp9xuHeAbZ1TUn98/wm2pWdDL6NfQ/DpwPA9Im9B
         YlPGN1IF2T2pr7JN31n8hyMY+AtYVv5HDFb91wmS3GbUwB/q2RSKj5osrcX38+IgWwIN
         mWU1zjjxjBxJECYXrcaLsT5cz2Pi3w+XF+/xVrGSif3KfGY+TuwFh9erzIhUb39PXymc
         H3Ke++mEKcYKAO48/1DVtttM6GjZeUISdwQeai0lYFq95EesvzeDflc8RoVrDwEvVRVW
         fPqMYZK7VgMXkbP/EI8oT4DVAZrzokz+IU6zYUMjjUFZ+fCVh923ZVUlkv6XdHfzQWV1
         wxUw==
X-Forwarded-Encrypted: i=1; AJvYcCX960uLYFm0elQyc1Afu1ERV68vqN/6lvW7bVSpHqaU6SAvfpHTwwrhtE7LExj60Ho6dmFlhzKv4jbQ/+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/at0n6rvkHicrFwEnQO0XeEtpRYpt3dNqt9JWyFCD0Y1tYt5
	lTzXKzljbHLp2lNexb5pjkzvUph/FyUnuxSIOIaeeDk/zDDAvSTl8JS9m021JJvk6jkUCvLESR+
	Vag==
X-Google-Smtp-Source: AGHT+IEVvsXIduk+X8FhHtMD4fvZwF9esFmBYy1M6G4Vt/JFtxhh+BZnNYrS8WzpeGLVp9j7hfA8IMyyDBc=
X-Received: from pfba4.prod.google.com ([2002:a05:6a00:ac04:b0:724:e712:5cbe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2451:b0:1e0:d45d:645f
 with SMTP id adf61e73a8af0-1e0e0b9a2fcmr9216517637.39.1732757738016; Wed, 27
 Nov 2024 17:35:38 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:05 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-39-seanjc@google.com>
Subject: [PATCH v3 38/57] KVM: x86: Advertise HYPERVISOR in KVM_GET_SUPPORTED_CPUID
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Unconditionally advertise "support" for the HYPERVISOR feature in CPUID,
as the flag simply communicates to the guest that's it's running under a
hypervisor.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 51792cf48cd7..a13bf0ab417d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -722,7 +722,8 @@ void kvm_set_cpu_caps(void)
 		0 /* OSXSAVE */ |
 		F(AVX) |
 		F(F16C) |
-		F(RDRAND)
+		F(RDRAND) |
+		EMULATED_F(HYPERVISOR)
 	);
 
 	kvm_cpu_cap_init(CPUID_1_EDX,
-- 
2.47.0.338.g60cca15819-goog


