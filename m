Return-Path: <linux-kernel+bounces-322413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AF9728BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811BE1F22251
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A19158DB2;
	Tue, 10 Sep 2024 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D67x91aO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F75219F3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944420; cv=none; b=DMfceV1ffs22GP5JD+3upQWg/BVXeCvhRYYH7qSv6JnaPWv8o2wiPvpprzMWcDaiC9mWoQ463URYYXxCvbYSOfUfJ426xnhpgoPDO4TvtPWPl8dSRVhQzJa88GEUKo8bZ0ge6XZ59h7vayJpiePeEugStvuXMq/nLk2sH4IDQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944420; c=relaxed/simple;
	bh=+mPkBYdlkTALZ5eam5h7JwhqrC5Q65xme4gr4dPabEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cEh/6/9fYp+DTS6ItPAo1TprQQvGuFm+PgHYM43KHAi81eAPLQZ8vWnuGj/L/faqEy/yb7/RDguUU8nSrsAMdq2A1jjpawB58BvIwQrk3DRGZ6rhpJDRY5MGa3Me6ErM1yS3zAYpui1d8L5Z9bRR78Juh4p3eLPDtYCYe0H2ycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D67x91aO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b2249bf2d0so153553557b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725944417; x=1726549217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyVHeazKKBSYbddGbsspYAJ9K5Cl0g2D2L02ZZx4czY=;
        b=D67x91aOrcQR6eGkVo8bCuyOGfHLFI8SgzonkxZMG9oUmN3CM3ag2oFPN3ddEzz3MZ
         C7Wq3za96fM5DiGyUE0DyGHQpu87BLdjrmWmbhJOYuM+7eiC10vONwg/2EIRejV27J3N
         VmB1Hjo8bLIkTMxQ9ZMIAVJqzf+hHeOVdqngdjs1IPb1u4TdzPI5rHf0STAFRJThwvQd
         W2br7tZGjisLWr3Q6hZ1iyr4cUhhYPbUUPYnVN1LrqXidoNnjy+ax1bUz24vWyQnLUb5
         IBux0kQKwcTeODAum3kMPyGN+2nlVsKi9vQ0vcAG45Iwpj1hgrK7lzdvTIpe+ZDtn7pS
         OVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725944417; x=1726549217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyVHeazKKBSYbddGbsspYAJ9K5Cl0g2D2L02ZZx4czY=;
        b=G2BM6ub4+25H0IbODKEY4kpxhDdWHlWIHUdgVWnVz4nX1Hf/Po2jhmlXqrLPXZbXWo
         iNPkFYn9bQPr5LA2K02G8wz0w2dz9rz+cD+vLZFu7jGLVuRkMCVs3Gg+w9OKoysPubcM
         thPl4Y3Jb0y1VPh8ceiZLRdZ4EwIBcsRIXFlaNGGG74Sv71hDVMs3sab6EjbBlX6TnuV
         zA0hYLsSKUODCaNksXLT3AUKK3kSJ/m+9nIz378ZN8wmstEd8XnEGKLj7fvs38WgVboW
         NDHRMW5m4xbI+1RqjkCObKYevD0iB5nkdAqh+ExgtJlaX0eUKqghAvJODJw5y+OJRaT/
         aOHw==
X-Forwarded-Encrypted: i=1; AJvYcCVVaGOm9OH8Fq3mbqXLNwnuEcJS2atOLhWpXG9/GNJ56UYkg8+KPVuuCvezfXw1edmDug0b+w4fhbDhScU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3t2v4EHOadq+8fZOLjFuUPGzOXzuWYfLSBOA8n135Gnk3srAl
	X7m/MKGvMofcYVWPIiUv8q6II+c07dWGHOBOC34LBH5NJoFfDDvuDZ7gqj9hZJemMrrtE3jdnSU
	nTg==
X-Google-Smtp-Source: AGHT+IF3O82VpOCGfr/hN3AaMQnAQc8/5Gn5YhrJTUu0VunPz6vJ899PJVQG0rhjs/Y3qNyv0ML043MSz1w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1810:b0:e1a:7808:c409 with SMTP id
 3f1490d57ef6-e1d34a49449mr30023276.7.1725944417375; Mon, 09 Sep 2024 22:00:17
 -0700 (PDT)
Date: Mon,  9 Sep 2024 21:56:42 -0700
In-Reply-To: <20240906043413.1049633-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906043413.1049633-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <172594254948.1553040.1513231357668918094.b4-ty@google.com>
Subject: Re: [PATCH v2 0/7] KVM: nVMX: Fix IPIv vs. nested posted interrupts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Chao Gao <chao.gao@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 05 Sep 2024 21:34:06 -0700, Sean Christopherson wrote:
> Fix a bug where KVM injects L2's nested posted interrupt into L1 as a
> nested VM-Exit instead of triggering PI processing.  The actual bug is
> technically a generic nested posted interrupts problem, but due to the
> way that KVM handles interrupt delivery, the issue is mostly limited to
> to IPI virtualization being enabled.
> 
> Found by the nested posted interrupt KUT test on SPR.
> 
> [...]

Trying this again, hopefully with less awful testing this time...

Applied to kvm-x86 vmx.

[1/7] KVM: x86: Move "ack" phase of local APIC IRQ delivery to separate API
      https://github.com/kvm-x86/linux/commit/a194a3a13ce0
[2/7] KVM: nVMX: Get to-be-acknowledge IRQ for nested VM-Exit at injection site
      https://github.com/kvm-x86/linux/commit/363010e1dd0e
[3/7] KVM: nVMX: Suppress external interrupt VM-Exit injection if there's no IRQ
      https://github.com/kvm-x86/linux/commit/8c23670f2b00
[4/7] KVM: nVMX: Detect nested posted interrupt NV at nested VM-Exit injection
      https://github.com/kvm-x86/linux/commit/6e0b456547f4
[5/7] KVM: x86: Fold kvm_get_apic_interrupt() into kvm_cpu_get_interrupt()
      https://github.com/kvm-x86/linux/commit/aa9477966aab
[6/7] KVM: nVMX: Explicitly invalidate posted_intr_nv if PI is disabled at VM-Enter
      https://github.com/kvm-x86/linux/commit/1ed0f119c5ff
[7/7] KVM: nVMX: Assert that vcpu->mutex is held when accessing secondary VMCSes
      https://github.com/kvm-x86/linux/commit/3dde46a21aa7

--
https://github.com/kvm-x86/linux/tree/next

