Return-Path: <linux-kernel+bounces-201558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6C68FBFFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3491F25EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D037114EC77;
	Tue,  4 Jun 2024 23:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuOSeUJZ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E114EC6A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544308; cv=none; b=Dr6FxW/e/yHGALQtEl9u5RYnXdxVZrb8kmMO50dJgX2OjuG8wGE89YaplhpyNzvtqnC8aJ4WY7PnZDj1gRkpk8prpSBDQX8ArsSNcigC9TwB+g/vTMpZAQP9vG+5XZSQFt3miuHFLBM/Nxa2nm7RJ+q2O6HPNCIQUiwCQxm9rZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544308; c=relaxed/simple;
	bh=BwM/Os4KBTmVspcHVSCHvte4rPtpmmrdzsSMdfB8t54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NQ70UEFQjRuoBC5O8cdJov3qg7mdPVK2JraM54sc+pTarl+WIXd4OzXcHu+sBhBHs6Zh7Yu1VRB2UBIKM71m2i6NWlbbksr4ipWZmDYZNZWr6mUWzSjLfauw6BmZvfXUcCftDQVi8NsAQ2mv85kfuB7HEuaNyDCUtELrJdR3d60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuOSeUJZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f621072a44so38435985ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717544306; x=1718149106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErQRA4AMy3XWNUVtztRHO4ECy31oAB3jfpLBipdw7ZE=;
        b=IuOSeUJZWZLs1rZM7UGBAWvyrYtiqqK29uaXyOVxhzSr4bz/ZKW/owGBaCYc0x3a78
         PcCfH1JEMCXVIiBuGQzmcnZ4G0wo+W9eUD3JVRH53njLrVlM5HAPVgS26dYq0r/ZZyla
         AZWGstH7cGJueRCVITVhCIUzuLE7nVPbjYEsVYGJ2KD2cM0NWtDXa27OX6qG8WuKIHUw
         dCFUEXLC/FhzV9pOsm5oNNCMJPILS48913GL6POCZAZmd3GNKsMWLwofqKQfhHyWJWXk
         mO81JECfCyjgHf6fGmwpKIRRdVwmFkiwD4lkB3n9Axza6mdZXctpLMG8UFuXKlZ4M8A+
         Rl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544306; x=1718149106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErQRA4AMy3XWNUVtztRHO4ECy31oAB3jfpLBipdw7ZE=;
        b=HlkGe7lsMHjg91ll7Xn07fiwI6Ur45xNeFNnSCFdK0Mt0iyHBkL6glxZsZTpZDXAu2
         ubXpkWnepRZ105HXFlyv/cgHbWMF38P2fzLWKSr2qIZV/YFeRoXM4ySL7xDuYqjmq3Os
         Z1dbmGSG/597ntSVWAg8vC6L6+ijrEJ/eQmYleQyUAO1EbvG6PDw8YfVISj+ZlddjA4Z
         za6u4MPv8JS3IaHsjfLxR+7B7nMzgoJx/al8BjuxQdyaNiPx/duH4zqGoMIQejjI8N1L
         HwQIj2+4q5SA6gbX7shMgtunab+hruBoOtzV1csWyAu3O4xJhptDlKsxoE/6vfgtZC32
         tVsw==
X-Forwarded-Encrypted: i=1; AJvYcCVI+XAaArK+KcXdFOQiy4JtXYmK8W3IaEss1HIew8LU57CWCXA0toGAxcgG0cIPbgMSbAGMWn/E30U9kxCPVkN74zCURmV4qpK371ea
X-Gm-Message-State: AOJu0YzVBwZ9OrX4UulI6V8wJ3TSg9XSjZNjOK/9hceLNrWHAU3nQlp7
	PnIMeB9mflMH3LpsTakiXpUSHO+bKNcOsHFzh1k7IzB0gpYvX+RGJtwouU+4t21DwG/v6ZDgu3x
	1Sg==
X-Google-Smtp-Source: AGHT+IHN3cqzNcnm3C3UZ1Isf/IVeA2/aICMXKNKfdksQ1tq7WWRpJ2J61he5DBCW5Wt08nJcw0DRAMYOyg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec81:b0:1f6:8033:f361 with SMTP id
 d9443c01a7336-1f6a5a12dcbmr287285ad.6.1717544306034; Tue, 04 Jun 2024
 16:38:26 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:35 -0700
In-Reply-To: <cover.1714081725.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1714081725.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754361450.2780320.9936421038178572773.b4-ty@google.com>
Subject: Re: [PATCH V5 0/4] KVM: x86: Make bus clock frequency for vAPIC timer configurable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, isaku.yamahata@intel.com, pbonzini@redhat.com, 
	erdemaktas@google.com, vkuznets@redhat.com, vannapurve@google.com, 
	jmattson@google.com, mlevitsk@redhat.com, xiaoyao.li@intel.com, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, 
	Reinette Chatre <reinette.chatre@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 25 Apr 2024 15:06:58 -0700, Reinette Chatre wrote:
> Changes from v4:
> - v4: https://lore.kernel.org/lkml/cover.1711035400.git.reinette.chatre@intel.com/
> - Rename capability from KVM_CAP_X86_APIC_BUS_FREQUENCY to
>   KVM_CAP_X86_APIC_BUS_CYCLES_NS. (Xiaoyao Li).
> - Include "Testing" section in cover letter.
> - Add Rick's Reviewed-by tags.
> - Rebased on latest of "next" branch of https://github.com/kvm-x86/linux.git
> 
> [...]

Applied the KVM changes to kvm-x86 misc (I'm feeling lucky).  Please prioritize
refreshing the selftests patch, I'd like to get it applied sooner than later
for obvious reasons (I'm not feeling _that_ lucky).

[1/4] KVM: x86: hyper-v: Calculate APIC bus frequency for Hyper-V
      https://github.com/kvm-x86/linux/commit/41c7b1bb656c
[2/4] KVM: x86: Make nsec per APIC bus cycle a VM variable
      https://github.com/kvm-x86/linux/commit/01de6ce03b1e
[3/4] KVM: x86: Add a capability to configure bus frequency for APIC timer
      https://github.com/kvm-x86/linux/commit/937296fd3deb
[4/4] KVM: selftests: Add test for configure of x86 APIC bus frequency
      (not applied)

--
https://github.com/kvm-x86/linux/tree/next

