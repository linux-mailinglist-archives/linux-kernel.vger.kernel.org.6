Return-Path: <linux-kernel+bounces-537416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C868BA48B89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DB71890C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66A276D92;
	Thu, 27 Feb 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTs1T47X"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77361281375
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695065; cv=none; b=b0OBGE+J0+EIFRut0onrD5OQhoimXrdXQ4xZl5pnL3ILPNCmyBfyMFm8UdRddVDAWWaVrb+eQdR8y03gchibRdrv4TPuWIILo8WOXbAUkbd8rooLfcpUz56AgtsvEeVx9zIRtfqFq0MlFR5yPsEVu8pHafJDr3ihHwy2qAnTsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695065; c=relaxed/simple;
	bh=l1iaY/46ebxN7Pxlf+bVDyGkotDM42snv/jC9ZbuKW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WvA5tT5KXU0W7ZmH0TckXvnD3SHhAnpLRsm7jD2TbPxPaTX7VS7YnZl6+L7eZdU0fhqOleabVddYYmf+mkS0FvNdieH2X9q+2Do0DMURxVwx/ji2Vj5txqM4YwCcDp73vOoNDVSWrQLqB29H8Go8neIRBwzChuip4mPTBe6GhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTs1T47X; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fea8e4a655so3853601a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740695064; x=1741299864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0qlBu3O+qgW1GVmSpLZOxIdN+UM1bvdDqizmqLkAsDo=;
        b=iTs1T47X2tYRwXd1yfZQAQ56agGwF4G9gaopbB7+ECzCa/slfOTia0fF2n8scE5qoN
         zITmJmlA6c5ZmfMHip2HiUMY+GDJ5B8p2cabEEQ+ayqs2yFw8SDanyME+1PR2lNtibON
         v6yd19RAYYMoTQtZkaa8UJz6Sw5ktGfWh4uY3rPAngPKrWh3Eewlf1/2Ng7KuphCu24l
         8OHX80ADP2J2DUTT0n3846sVyNhNg9VNPPxw6WnGpeH5htuUw5zeU0GfTNJ2UhVX9oZ4
         YtGPX2bSUgAT6Bon4lYYGQSAxkciUwmIq2CdwtPr+1tTEakPgu/oZAQgjOAHvSP8bi7j
         ndQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695064; x=1741299864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qlBu3O+qgW1GVmSpLZOxIdN+UM1bvdDqizmqLkAsDo=;
        b=CQ41WtT5VhB11e03w+kcSEQssv8HrsqzcO9pG71GiTtQ6h1LKPvVvJsXmNTiza+hl9
         LK7631wV0yEbZAKdECYyxLiwmxzrCwSUX/rlM7gZsIgTC5E4RHiass2soySkjmE/ecdb
         1pgnMml+VEL+mEa0JpW3BHD967pLO7U1+P9UT9SxC7Q+nNEfz0tKkz4qRvULGl5Hvu7U
         Kqri9u1HVj0Yd9N+jNornEMOlIZ1FU64styOgEVPNYZFGfQVb+2IRJT3ZxjizZm2M56T
         DKK9SD+he29f7sYQIqLmV3dJ5euTBsb+k5Fo/cKRdx1MthHaJ+r3ECaI8RtsBuXovBc5
         2qyg==
X-Forwarded-Encrypted: i=1; AJvYcCWvZpx47vC5cX0FQVI84VD6xGIPAPp9hQAGZTkwac1DmbjBoA8DgC1jGk6iA/RLpR+BP9YyqZm0hN1f0Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFy99gLyPXqHUTERjbqN6yF7I2HGunMBBdoL/2mHNaxuQJCFvt
	IJdHnj8E88H7ktyBzYwAZ+TThUTzIYc51F3ds7YSQlno5SgaE/0BGeAKltPH26xqZbRQkdgYZN7
	uzA==
X-Google-Smtp-Source: AGHT+IEAR4cGG2gi7Xmxt0qd1akR25wwXozuUf+4YWN9m+W0e/uXX0xINJ03FxGe0avbJCicY+EqJQBZUo4=
X-Received: from pjl3.prod.google.com ([2002:a17:90b:2f83:b0:2ef:d283:5089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3845:b0:2ee:c9b6:c267
 with SMTP id 98e67ed59e1d1-2febab403a5mr1668829a91.9.1740695064085; Thu, 27
 Feb 2025 14:24:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Feb 2025 14:24:11 -0800
In-Reply-To: <20250227222411.3490595-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227222411.3490595-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227222411.3490595-7-seanjc@google.com>
Subject: [PATCH v3 6/6] KVM: SVM: Treat DEBUGCTL[5:2] as reserved
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, 
	whanos@sergal.fun
Content-Type: text/plain; charset="UTF-8"

Stop ignoring DEBUGCTL[5:2] on AMD CPUs and instead treat them as reserved.
KVM has never properly virtualized AMD's legacy PBi bits, but did allow
the guest (and host userspace) to set the bits.  To avoid breaking guests
when running on CPUs with BusLockTrap, which redefined bit 2 to BLCKDB and
made bits 5:3 reserved, a previous KVM change ignored bits 5:3, e.g. so
that legacy guest software wouldn't inadvertently enable BusLockTrap or
hit a VMRUN failure due to setting reserved.

To allow for virtualizing BusLockTrap and whatever future features may use
bits 5:3, treat bits 5:2 as reserved (and hope that doing so doesn't break
any existing guests).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 78664f9b45c5..fc9f9a624d93 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3166,17 +3166,6 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			break;
 		}
 
-		/*
-		 * AMD changed the architectural behavior of bits 5:2.  On CPUs
-		 * without BusLockTrap, bits 5:2 control "external pins", but
-		 * on CPUs that support BusLockDetect, bit 2 enables BusLockTrap
-		 * and bits 5:3 are reserved-to-zero.  Sadly, old KVM allowed
-		 * the guest to set bits 5:2 despite not actually virtualizing
-		 * Performance-Monitoring/Breakpoint external pins.  Drop bits
-		 * 5:2 for backwards compatibility.
-		 */
-		data &= ~GENMASK(5, 2);
-
 		/*
 		 * Suppress BTF as KVM doesn't virtualize BTF, but there's no
 		 * way to communicate lack of support to the guest.
-- 
2.48.1.711.g2feabab25a-goog


