Return-Path: <linux-kernel+bounces-424127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E59DB0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED47165465
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15549149C54;
	Thu, 28 Nov 2024 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5RgidBp"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8FC158531
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757700; cv=none; b=nzZW/FWuaXWqYoZ0M2n38DbYaAcmzajpu/T+wpojrK29DfkJrk2zY7AiZ/hRLR+3KFTPNMtWaA0uHmd9194cysrdutnzGfHqYYYuRPelhtmKr/w1XCIYhf4VFP8LEGcjuTI9HMuAlrdQqh6E7CAp8I8leynNAGU2hquW6GYBV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757700; c=relaxed/simple;
	bh=Tc8LIiOIRM3QxaxI7g2HZv8WVUrEZKdFo0OMioOb8C0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iVCZmX/Fmn6Ozgmduh6tmGeOM6E2kpBAMeopd+DoT2m7vGXKWy/O4OhXVzCyMqD2qFQRK5cXc5d81OIJ7YWN9Muj0w5giOod9SufZH9Rt6IW3UOk85NuXT37x1frA8jl842whqX5kdHs8s73CB1t0DyiDBDFAQJbmM0foL0nA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5RgidBp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7f8af3950ecso259344a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757698; x=1733362498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WU83/DfF7T0ds1+fthR3W+eEtQHUVkaSLt/xQXIjOoQ=;
        b=G5RgidBp4Smax495yQK+ifwCBDsN4yrGOEC52Es0bufU/SUSSj6idwevrovN2a+c8u
         8tTc0XRtNKM+SzIza2vSN3PvngS4Cy4KLigW29+DdjoLBG5pYXr9hABkvISLKKcrzrQy
         ykTVmUEYVbAnGqyQ6CPr1jT989zDah7REOmF1ZEt3jQWwL19RZ5Ub5WAGVcCjgAj3Oz3
         eB0Beef/GC5ebrUsgyzzAgaACrTg4vR/h1/lmxXWj0XwWbSGQLv8A04poAjxTnNHstrn
         hdzepW+cgjccw155Phtdf/scMeADxJy+cOgR1p+NbGrFfw0eEJ32kJ8VdTjYFGd3tIB4
         cIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757698; x=1733362498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WU83/DfF7T0ds1+fthR3W+eEtQHUVkaSLt/xQXIjOoQ=;
        b=Y/gwOVFpUxGn8NUZ/lVCv/D802snlN6wOOL1gHGamVdOesS+fCTCHoiv6ftipvIX0y
         6jJobuuf7XgkCWR5t3h9r6IQBXrmXdNtNwqrcGegXWHIOJGi5zUiu2n4GpXafsP7i5+I
         kdX6iVaZDYVMyL4gRN5i4ekYDP+W9aQtSJ+C31i1UXO5tJsYUtbK74taRswzcq40COzn
         o3tnSwS2UOWnhJJa85bHiR1Z76WSDyWS3vPBet9w7nLtgWTkx85+HJeBXzZoKuXLSQ1T
         z/DG0eRFB7+cey77oOeVEkJDlQSou+5K+4lFsEDepubvQPHyK78BMIsdS3RhXI0kAuAD
         o7cg==
X-Forwarded-Encrypted: i=1; AJvYcCXnVYKHCc87eosV3OXg7TOJbVh597clxaxtPyQYusHgyLAmjIaIqLWcMg6YeC0v8PBBdIy5CJTz2tBmcYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9OTAJzFzKF19sUzYZgamR3hQ70BoUxB1XXe16ARd9DGUTBYvk
	bN/P10FOcSi2YKW2SBK+H3VW5PiHpkQ+DBD4si2CzpxNRSaIVFoA1YU8aIoN26Tut70+3aQlET8
	9WA==
X-Google-Smtp-Source: AGHT+IEJCs9N2XclscA1jtpo8yGvgCHz9DiT6omS7XIoj+KtuSKV1V8k6WtPz+JiSgyWErvjoDkzmWslk0Q=
X-Received: from plblk8.prod.google.com ([2002:a17:903:8c8:b0:212:45f:e087])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a105:b0:1e0:c89c:1e04
 with SMTP id adf61e73a8af0-1e0e0c5cc36mr7869843637.43.1732757698381; Wed, 27
 Nov 2024 17:34:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:33:42 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-16-seanjc@google.com>
Subject: [PATCH v3 15/57] KVM: x86: Drop the now unused KVM_X86_DISABLE_VALID_EXITS
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

Drop the KVM_X86_DISABLE_VALID_EXITS definition, as it is misleading, and
unused in KVM *because* it is misleading.  The set of exits that can be
disabled is dynamic, i.e. userspace (and KVM) must check KVM's actual
capabilities.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/uapi/linux/kvm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 502ea63b5d2e..206e3e6a78c6 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -617,10 +617,6 @@ struct kvm_ioeventfd {
 #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
-#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
-                                              KVM_X86_DISABLE_EXITS_HLT | \
-                                              KVM_X86_DISABLE_EXITS_PAUSE | \
-                                              KVM_X86_DISABLE_EXITS_CSTATE)
 
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
-- 
2.47.0.338.g60cca15819-goog


