Return-Path: <linux-kernel+bounces-234678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0291C960
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696D8B23CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BF212EBE8;
	Fri, 28 Jun 2024 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvXQQ4eg"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AB85285
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615411; cv=none; b=DtAmTAF0p84oY8o4v8whHrs9xV/T3zHqzu0qAN/Brv6wd5tJOAuGExtS8jTw461yVCiy+I+cJZV8RxAYsjRzD7JKW1D5lbzluYF9J5drbVuHANu8P7WokaEeJB8tqoRW9TTdFKFzL957kM6zhpaDmOhi/3BU63+j7XLZAZegaCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615411; c=relaxed/simple;
	bh=/95xVCWbm3t7YOVXqDkLboZ53C0OpBAqJPDDngxswyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eoNvwFkhh7vhFAmtmDoO8wYout80qFhM/kUpbJf0Pb0YAhDI1qIU3zHckZuaD1PQCmXMNi3v5d1JC2UnoHi59zlJ9pSIiOBOQQfaSPGP2hb137rK9V1S6S3BXw7oyTpw5abckag3u7lKBGb2bY1/u/TTG2czjgSshf5fpFsLuoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvXQQ4eg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-706a87c62a4so961099b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719615409; x=1720220209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrzQMotGRkcotbLCLtHhohCQXvG4H2zp0GaZ+YJKEmc=;
        b=DvXQQ4egg3/X4wpL34XdHZrdKBhFUuisVUXdoq2Nc1G6h+Ypnbp05gFZNwHTn2Ym0Y
         8EkMKNReiaY1fixoXz5cE6oVeYp0+p6mB7+LJsXVnfZ9HRHnCDP8rvCVRb2444IVkybF
         JTGv4QFI5wgCGFZ2340/z7TGgR1mpbjYPWLqMRQdbjIPOwqqAWSjOxAbOravwLi5lbDb
         67oTVx6YaxQcUsriOjDodX/3eH3oVTDK4nUdSkb4wJhr31ZW8i/B6jA0c/beEIXInWXe
         4OEe74ej95bY5gRNnuIY21lKDGFR6FFJnHnfzxjYIf1bt2lK06LuEkPgKuiGmz6ETgHS
         EALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719615409; x=1720220209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrzQMotGRkcotbLCLtHhohCQXvG4H2zp0GaZ+YJKEmc=;
        b=mqY7RK/yka5ZEoFxkuTRzE1A6JTL8APxnPZ1zhkoqXFbBkIuYA3KV1CPLaE4pKEtDm
         XZdCrTb8IdMnz+voWWYg8Zc0Q4rMUwMJ56Yz2LNJ5RDSGd0AOjELLHsodmwy/CUHglW8
         TInmwYGnEikYdzrBgvvopXgLflr7vPNau8S4fWrqqmFs2uNQye8Hpwryi4XYter5uKkf
         8IJUzSDvk6FS5BqAvjHM6JxqWMTbldXTU3KzCOPClzMLWcbtzYcpfLUXvTp+o0Qq327a
         4TyFWLe+fkXEvwM7slv+UytdszgRxUeJ9AjhfssdK/dsR4JhiEOn8IiCQGaJxxbkb/AO
         H56g==
X-Forwarded-Encrypted: i=1; AJvYcCV1e2IOO7ABPd/P9o2DSFQGjjbF4cMtJlZ50pbLXBX41FHvtOMX7fgObQf6UGH7/l1Wkm923btCHFuT1I9rcpK0++IBmb9/osDyvrA9
X-Gm-Message-State: AOJu0YweELncupgPcW4IudMtKDaSkuLbORmepe/DloEMGPpcDqOiizru
	kM7ja1qqCCq263h0f4S0TZIU0r/58jhkXUs7sgUFMysTGJv3qH2ZHTMHhNhnq+izOq4KSlUrucn
	mew==
X-Google-Smtp-Source: AGHT+IHjjNFn6x00E94c9EEhfaVJtnscf0oMNDv0skTLcGCcmAGv48P1/+4wcAHD2P1pLHWR10rR3ydjG4k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6c93:b0:706:3421:740d with SMTP id
 d2e1a72fcca58-7067455298amr194274b3a.1.1719615409520; Fri, 28 Jun 2024
 15:56:49 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:55:30 -0700
In-Reply-To: <20240627021756.144815-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240627021756.144815-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <171961447393.238177.16381669170137224353.b4-ty@google.com>
Subject: Re: [Patch v2 1/2] KVM: x86/pmu: Introduce distinct macros for
 GP/fixed counter max number
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 27 Jun 2024 10:17:55 +0800, Dapeng Mi wrote:
> Refine the macros which define maximum General Purpose (GP) and fixed
> counter numbers.
> 
> Currently the macro KVM_INTEL_PMC_MAX_GENERIC is used to represent the
> maximum supported General Purpose (GP) counter number ambiguously across
> Intel and AMD platforms. This would cause issues if AMD begins to support
> more GP counters than Intel.
> 
> [...]

Applied 1 to kvm-x86 pmu, and 2 to selftests.  Thanks!

[1/2] KVM: x86/pmu: Introduce distinct macros for GP/fixed counter max number
      https://github.com/kvm-x86/linux/commit/f287bef6ddc2
[2/2] KVM: selftests: Print the seed for the guest pRNG iff it has changed
      https://github.com/kvm-x86/linux/commit/ea09ace3f8f3

--
https://github.com/kvm-x86/linux/tree/next

