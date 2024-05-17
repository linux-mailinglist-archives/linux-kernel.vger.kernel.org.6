Return-Path: <linux-kernel+bounces-182442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A98C8B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F1C1F26026
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922AB1422D2;
	Fri, 17 May 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bf+iiWoo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376821420C8
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967604; cv=none; b=VD/xcxxNfUdw5HS2H8LAV8NCxAkNJOfiFkgAPN9YeXbMKrzc6jnYsuus7ENr6SzoVBSHscOP0XLRdisvZ1SskODdyOL08gt/2ESmd+p9XESBXLa9YpWzKhdJDMflKZ1jsbgVf5uXtk5gLVNAK+tKS+Z/QfCPvIbeWwbhfLDZxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967604; c=relaxed/simple;
	bh=W4F7sJUHxFqCTId2bNTUdmAnN3//eoKwFQZjhNWBFKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TV+7ujssVoYzXwcZ+nspluxEz25LXVF+OMr/h3njJpuX5pI4kqmSATlrT3Q9uirCEdGNy6qzRhWYdZKg4nREjM0tjvLFnEYG6HBsCu3tDOdPRtyKYyPwQRnYPseicPC7PmMhQtqrsPEIZvL3rHxHnmKjbahUVrhRPA/thDbWvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bf+iiWoo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-620a2321b0fso154345437b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967601; x=1716572401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1b3X2JvgnH28eJymLWDZCCqY4xP7X8B28QNw1JqxSDU=;
        b=bf+iiWooKboF4o7W6rhqFd7Jffk2+esxAqp/Von2WynQIc0X7DbIaUzBkA95hbv6yZ
         /HSbCxJV9wCILDXfK+GgI3hbFKEc15NMGRuR5g70AsyAZfBghVen7pTLjMdn9p/lnLrk
         sNd1lrcjU9MocDH93uvo0cZylsTC/Rqhb+dHyWxlp9jMY23OWdrjoYJy6gxhqkD5sr5c
         3oXxYNk7Xo+c7ZMpbIwtdyK+DeOswNfBPk3vpv1W3ttHbN8G2HA+hj5F2R2MD1KBWaTV
         2rTgEK5AwYUMiX9IJ4eFTSS+hfAQF9WzLKMgBpFRbrJpbtIRXQGyK1E55L8fcIL92hA1
         omnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967601; x=1716572401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1b3X2JvgnH28eJymLWDZCCqY4xP7X8B28QNw1JqxSDU=;
        b=jDeRmASHDJzs/PicCuuIEINm+SFhrj5BH7QGOrB8mtGQe+m6BXcJAHZhIJt94eZog7
         MPUcK34eMuUTun7OsIZjteR3XnuSBpSIGF30WjUswPV9aQOqppdXMG9MDPk6RtapyRsD
         V2tMTcxtex0EToUtN0OOk0TA/BCx5+/qvoT8xXMZPSJYWEpShAl1DHRDnV7pcvuXP3/P
         k6fh/AxX6usyUEQKVlneruY61dtCqABSSowEUxYzk4DTi0BAo9FkS5E7dCSl1jYw401d
         amejVfq4iwBaLwJ6LiU9ksD3Tk2AMVYaNnGg7uqukQs0mqf/gKNoWGoz/mVCr97oXE7r
         THtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTjNTxL9BhobobCtKrQHoH4NGiUzNx133gKiLcqi6SH/fPVnWcwKtuqXHY2q/rkFS2aygvnv1xdNXfXzdkwIcgkABUA03BKdDO8V8V
X-Gm-Message-State: AOJu0Yza6wCQzZyZbFDDhGQ77N2MiIRFcrrn7VT1nPeBGS2uEcNxcux9
	hSTBMI7N6syWIUPALef1A0vxT08VQpqAbbZ29nZUqtIUPXGWvVCK6Ws6uy91s6DcU6LlKZ2bEOX
	Zbw==
X-Google-Smtp-Source: AGHT+IGn0mSXHlGmapLZadEc+H9mZtBJCjVeNzVsof7AUPIDogJQNa21HHKOK/MSnxG3No8b3f3wHmbaQp8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6202:b0:61b:ee2c:d5ab with SMTP id
 00721157ae682-622aff8fd3bmr50886937b3.1.1715967601361; Fri, 17 May 2024
 10:40:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:46 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-10-seanjc@google.com>
Subject: [PATCH v2 09/49] KVM: x86/pmu: Drop now-redundant refresh() during init()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Drop the manual kvm_pmu_refresh() from kvm_pmu_init() now that
kvm_arch_vcpu_create() performs the refresh via kvm_vcpu_after_set_cpuid().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a593b03c9aed..31920dd1aa83 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -797,7 +797,6 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
 
 	memset(pmu, 0, sizeof(*pmu));
 	static_call(kvm_x86_pmu_init)(vcpu);
-	kvm_pmu_refresh(vcpu);
 }
 
 /* Release perf_events for vPMCs that have been unused for a full time slice.  */
-- 
2.45.0.215.g3402c0e53f-goog


