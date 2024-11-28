Return-Path: <linux-kernel+bounces-424119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FBE9DB0D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04782B223B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5112B146599;
	Thu, 28 Nov 2024 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2aUZ6RFw"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEC13F42F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757686; cv=none; b=n75gFdklMTDSjoVVPtAhD4sJ5dSHrJlQ49rpjQzYoBWPBtNd6+TmLp64faaW/rPUdrs/qxx0U7EKBg5JZj+0s4HAXmqq+fSUxHhhcpI1Ik3ArGzWqlfMl0Sx9gGXDluE6K8uqKZ8V3YVLOXj3Yc9ZKHj5r2i40Unj+MH5YtFF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757686; c=relaxed/simple;
	bh=SfTqWTXa8BKoYVN/v8dEJW0W+ZanJ5NwKZHbFFSkXUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QoGyA7hHyfDoR7nsFiAWeedDiiM4gDMKx3qK6WOGjGznevpCCDNdQ+tMY6nUzMh5rF+xj1nQCsWQT+FIH41L+8xd1OhHnrTXKc0+e34/FK7STwgejkLlrZZFpvyHR6ZvrsdFjjNxf7xRne69dGv+xFOYQzpuC5Fq6LMne9gp0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2aUZ6RFw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ea3c9178f6so359429a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757684; x=1733362484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=G70La0fxRWvS7O6Qk47ARCLzL+vhxpEYYaoXHV45TwU=;
        b=2aUZ6RFwCXBMpKeUusYBJ01/e2fzpimey+Hqxktx3CGpqbqOfYjq4wK9OjZY+HaTDU
         LyAETmWV89bGrzV0kq+PoSREPh0jUpTickq2K8qnTzHJVNgzMrIEjXFzWF5ogVP1d/T1
         SYTdC0kRjpjKlhFAcCfI7kIVUv8c7faxEAxgn2qwhZlPd0UC0oCiRw4rv1bPK3uu9gh+
         XWLsXAMhY7fBgExwQ43j3+rLVpOqdaDS2OEfPP90H+Ye6ZrYsqBtvHXsb3ozeHhYQYUU
         HRAwFoPImLMwS/YLnCwDH+rNsC+N7EbkY8rrfVh2lJD6438a28foNFNCpE6fyt0HSSf3
         auvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757684; x=1733362484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G70La0fxRWvS7O6Qk47ARCLzL+vhxpEYYaoXHV45TwU=;
        b=ffHlQ7+3O2X6537oyQJlAUCCepiQiLMIHi+WWwSFHuXrPTDCXNot6qWAp2oM82ROyG
         n5Juw1350FdnN2mkfSTdMFpZlms6F8bfVQ3LuWWWlh2yI+GQX/pb7DS5Hxdg7HU9/j2M
         2Udok0QAsWWidKpVP76bvSyOt5gupU7QrnmC3kqq0V4N5s1IK4tdbiohDxzHPaM50V6D
         GQLZpyYJvQ/X6QcYdkcD+0Go35K6SwiAyxPOmtoeeerCDf9QGLYjkS7xppADoZY+P8oD
         1PX4yFHVup2UOCFrfEJX3u/uifmVvFJFpszsQ+3CAMUAV8rwBPJYgxmqc4r4+T1RSVcZ
         7iAA==
X-Forwarded-Encrypted: i=1; AJvYcCXELFWRj7qyaUzkYOzizcloOh+43mb163bWjpe/vQXrCH9e52G4/0BWxMwxYp4rekCWrKE0RznsBpJYNek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/vBOVpxcxDE1o/X8fzOmUNwrWy9RIEVyj7LNnsmYnc7CFGOK
	rj7BunxkXtccuK0rUotF/tb/tDI8c5BvpTHJSA7qTB6iSsryhbHF6o9/gaaroYopDX20Rv2AeN4
	omA==
X-Google-Smtp-Source: AGHT+IFToGV0nK6Lp298fFzAmw75HCs6XdDNudr1ZEVggFnYIEoMGXjFW2pcMaufdLz9kGjCHOkick7/ql4=
X-Received: from pjbqn14.prod.google.com ([2002:a17:90b:3d4e:b0:2ea:83a6:9386])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8e:b0:2ea:8fee:508d
 with SMTP id 98e67ed59e1d1-2ee097bf308mr6780563a91.30.1732757684358; Wed, 27
 Nov 2024 17:34:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:33:34 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-8-seanjc@google.com>
Subject: [PATCH v3 07/57] KVM: selftests: Assert that vcpu->cpuid is non-NULL
 when getting CPUID entries
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

Add a sanity check in __vcpu_get_cpuid_entry() to provide a friendlier
error than a segfault when a test developer tries to use a vCPU CPUID
helper on a barebones vCPU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 645200e95f89..bdc121ed4ce5 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1016,6 +1016,8 @@ static inline struct kvm_cpuid_entry2 *__vcpu_get_cpuid_entry(struct kvm_vcpu *v
 							      uint32_t function,
 							      uint32_t index)
 {
+	TEST_ASSERT(vcpu->cpuid, "Must do vcpu_init_cpuid() first (or equivalent)");
+
 	return (struct kvm_cpuid_entry2 *)get_cpuid_entry(vcpu->cpuid,
 							  function, index);
 }
-- 
2.47.0.338.g60cca15819-goog


