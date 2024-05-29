Return-Path: <linux-kernel+bounces-194115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F48D36CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562F11C22641
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF14D522A;
	Wed, 29 May 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qr75Kwcn"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E5610B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987262; cv=none; b=oJMQbz3SVhkYe9VBNTZS4BkAB0EIofsu34Hovk9nMHBxRuXqa6gZtSScNIplkaA8rcwUUAWDoGxQ6/+smlVEK8UD0y/iYEfzTlX2q2URc8AzCe5LOcc/s4CAsp/QdT3ov2pYD87K/MNS1lRXen53YsoAkfEZI8Oe5KwmAJ7Cn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987262; c=relaxed/simple;
	bh=7C3Ln9w/sSUWPP+BUdVx+PL58R8HTzOVmDKg36W3xec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DBZhJKTGfV5SruF/UbusO4sXB7CC00tN2hbmHsD21y36zJ0QEvNV1ORsqIq22fBmKI01GSEDfMMKv/WGwXdp4wq18a2vMJ6wMSZ8vs7V/vuY0wjpyEKQdJhnb2YiqDzIiC7h9d8bhZ/ouHK4BbvfYlMHuDVCt9p9SFwXV065A9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qr75Kwcn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-657fb8090eeso1807214a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716987260; x=1717592060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KVQFhVFh80Fdd96OAcePaAYKBvjrIO3JB8q5MbeFQU=;
        b=Qr75KwcnmaLB6hyceGLId91IQy9WUT6WoEc5sC6/ZFDCJQ17GugJFmP6gB7OqfLxA+
         5XF6peoGIywBkFwXgrj9x/K4z5W3tb13P/hZsHQ7DeTvGWySn0z70f0IP+IlroYMI3YB
         1d6SBMUF0jFsKvkvHNP9Uq1BOL6aQMdiNJkFQGm4JarV8AehHGfr7Ricox8JUokT8ph+
         kwZgStJQ9TtnzzvHl88er7RJ8UcVe/rCDf4nGQhhgINZtPRNIVbnthVpVKSVoDTgbAXO
         ATRNPHhV17dd4uuPea/JeAnVPbA0WrnUm4XAlqGfzXUaUDa8BucIM9LSQKaZmN8J7kn9
         b7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987260; x=1717592060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KVQFhVFh80Fdd96OAcePaAYKBvjrIO3JB8q5MbeFQU=;
        b=uzykZmKgtoZEqC5xF4RkJWLHgjJDalWw2GUjlnUTrbEU52p1qtUhVRL9RDDNYQu4ho
         2B6pJlg2wr9wHiFW5SldvKdExRkyWJQEPtqqe/y00ubYODghpPoMeXKhMGPw0Ehx6f9A
         PSDj0m6Es5dPmRVzkWOcj2AMVp0RZDTKls47zwugmrTtXnBF7xGXu3zmk5G5f/u/78dt
         lX5QZMkviGKkUiNzE1caPQh0QG6xFkpO/B9T6TGgDc/wmieIv75n1EZ7OFCvq0k40sBM
         a5KnctRRFHhkYk999wTf+8tRYLAFjcEjJ9prkmzGSqRlwMNVRGDxinh1R0vTustLDRk+
         OKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP1FVUfk4Nj+ZG+ZkFYkR8xfSZP7ZsUU42Q+xj+rEmUwgH8A1aAbSe58qawnl8gaRx3eTOAaxOYRfYorGPPsMY2Qd5V6vlIreGwKkU
X-Gm-Message-State: AOJu0Yx4jm11FRlDPuNQYwSZRwaA8gkSSO1k4YrlX9KUhhNfx1u4DJof
	1wxfvJWZC8LhkPd6gHt4EvbMFKCHtnbaDfqVpv92UtErMloRmyRcG8kXxr/kE7Lf789rhzxYg+H
	HGQ==
X-Google-Smtp-Source: AGHT+IHBbZP8iE9LJoz88cSwyGPtf4IYoLcqAZBm04Syis1dHtNGwvMpLLvLxNB1S+GJVlzsrbdgQQ4xG0k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:1421:0:b0:680:1ce8:ba9a with SMTP id
 41be03b00d2f7-681aea7d0ecmr40830a12.11.1716987260030; Wed, 29 May 2024
 05:54:20 -0700 (PDT)
Date: Wed, 29 May 2024 05:54:18 -0700
In-Reply-To: <2a221116a03f57dca8274b6bc2da7541b21d86bb.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522014013.1672962-1-seanjc@google.com> <20240522014013.1672962-4-seanjc@google.com>
 <c77f3931-31b2-4695-bd74-c69cba9b96c1@intel.com> <ZlYte16cvQpPGHkx@google.com>
 <2a221116a03f57dca8274b6bc2da7541b21d86bb.camel@intel.com>
Message-ID: <ZlclevRvntUMYG6O@google.com>
Subject: Re: [PATCH v2 3/6] KVM: x86: Fold kvm_arch_sched_in() into kvm_arch_vcpu_load()
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"maz@kernel.org" <maz@kernel.org>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>, 
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, 
	"zhaotianrui@loongson.cn" <zhaotianrui@loongson.cn>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "anup@brainfault.org" <anup@brainfault.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 29, 2024, Kai Huang wrote:
> I am not familiar with SVM, but it seems the relevant parts are:
> 
> 	control->pause_filter_count;
> 	vmcb_mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
> 
> And it seems they are directly related to programming the hardware, i.e.,
> they got automatically loaded to hardware during VMRUN.

"control" is the control area of the VMCB, i.e. the above pause_filter_count is
equivalent to a VMCS field.

> They need to be updated in the SVM specific code when @ple_window_dirty is
> true in the relevant code path.
> 
> Anyway, even it is feasible and worth to do, we should do in a separate
> patchset.

Ya.

