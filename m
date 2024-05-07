Return-Path: <linux-kernel+bounces-171791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE418BE8C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507351C23A24
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE6016C44F;
	Tue,  7 May 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7K6i1j0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C9916ABEA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099062; cv=none; b=OWEbKbu5+8zFVsJDi1HyxriT5OsnF8QEcKF+9PKMga7sfujgNnGkdRT1U0OFXX7hKaV+Iy0fwTmVcVFRm2jPGCCaBbyPNy0MBQylLmZshk1vcg7rSVSQvpcVn3rIviGUoS5e9GY8+9TMp+zqy5KKGbZf3OjuWieZb2WjWVD4HNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099062; c=relaxed/simple;
	bh=wJbp6WjEK+6FtVYJhPdauEq2bIrS1FhcPXI3PtQy6wU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RfT45XjfNAer3gzygXQbfggxKqvAcS1+g3dDzcwIrbxHrOei09kaViNRXKMSEF3iV9pEsxElZfvkj+aGx8HOoHosfIXCmxDs3ri2yWCh0zoY/HeYr9we18Bx37RneMksAs5haW0wvUYHQ30Euv8/cKlNMpuI1SAPeHPe/iJIdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7K6i1j0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so6507150276.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715099060; x=1715703860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zDm0nic8Bf4ROxi6HvrqFLQrZg3PZkT7VQQx+aQhnBY=;
        b=n7K6i1j0CKyRAITHjMEkX8wOIaFkNBux9wU875LGgXTUDjA6mWdy0g7obvcMlINETx
         phVZICSPfWT1nQVGKBynSfnFcQ/9neh83sUHGf1oTu6vW8oMIJs63b5Bcwfh5VgrDZDm
         kwWYcFCyldVwrqJwLwEMhyUlQA07BUUjC5SHDEEtPolQoWhCjZH+Rr6MB2Wub2Yq6m6/
         3SaDgw9P/6tXWe3rOF7UVwJ2DhKqSo7T0WyVDdhslLM3q+WrxXH/puAXlNftOR1RLbmM
         LFdaEF3H7A7H6mFCg7eK2gXMN4t2FzSDJRUGdSYkzImsyVmFVsd2Nvk0ivENfVF2YPHt
         h/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099060; x=1715703860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDm0nic8Bf4ROxi6HvrqFLQrZg3PZkT7VQQx+aQhnBY=;
        b=S6gcBTJ4u/RtrjzyjleHl7I+FCTHqtkDRimrE8q8Rf+jLpVi8GdosCym23HWfa57WH
         RHiBR7u6exwC4csUokGBdyYuvXD7BbdCZ0HAxSeRNMFrAbkNdhy6IqFWro0a5DbWEUwS
         Nv7wkt8KFKRfvMw0wVyCfbVZEPfPdI/0MD4FPT7Z/MW/Be+OzBBTcitq3uzk1v5P1h/3
         1nb560wrr1r7g4ER2bSKIsmAfnDyrC/R38P+ZKwCbvQH8datFgOQko9csywvmBg/Bdoo
         BVgJsGt+9mBTDKbxIztKkGtOAB1cycyG2Mx8dySJXGTmdqpb+VnB/CyJBy3o81ozdiDM
         AcHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxOR2OxXomo8ydu2lNEPzSVzSbEiEh+XC3vWusQXJ6vtdpR0PIrUeaO2dtDVZq+gpKRHEMzgz7FXi+QV5pPvOtglaMNBTVRQDyPLlU
X-Gm-Message-State: AOJu0YwZ/lxTKF7JZzhGShiGPdjyr6Bolfh40ZAhoe5oiUu70QPX7NfF
	uPPu33o3qJ8ifyjC/phWxrV315WbN+C/G6Ho0K03tscMtbPhL9NyfeP6tRbrsmHC/699VB4Mpto
	UKw==
X-Google-Smtp-Source: AGHT+IHEV9Hww+r9vbzxSYmAo5y0EjAd48qQLH6oEVfcJ7yZe2szu31qLFICvdM4H82xlI8amm0za/20DLw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:44:0:b0:dc2:466a:23c4 with SMTP id
 3f1490d57ef6-debb9d86d55mr29973276.4.1715099060476; Tue, 07 May 2024 09:24:20
 -0700 (PDT)
Date: Tue, 7 May 2024 09:24:18 -0700
In-Reply-To: <0ddb198c9a8ae72519c3f7847089d84a8de4821f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Zh7KrSwJXu-odQpN@google.com> <900fc6f75b3704780ac16c90ace23b2f465bb689.camel@intel.com>
 <Zh_exbWc90khzmYm@google.com> <2383a1e9-ba2b-470f-8807-5f5f2528c7ad@intel.com>
 <ZiBc13qU6P3OBn7w@google.com> <5ffd4052-4735-449a-9bee-f42563add778@intel.com>
 <ZiEulnEr4TiYQxsB@google.com> <22b19d11-056c-402b-ac19-a389000d6339@intel.com>
 <ZiKoqMk-wZKdiar9@google.com> <0ddb198c9a8ae72519c3f7847089d84a8de4821f.camel@intel.com>
Message-ID: <ZjpVslp5M0JJbPrB@google.com>
Subject: Re: [PATCH v19 023/130] KVM: TDX: Initialize the TDX module when
 loading the KVM intel kernel module
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Hang Yuan <hang.yuan@intel.com>, 
	Bo2 Chen <chen.bo@intel.com>, "sagis@google.com" <sagis@google.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"isaku.yamahata@linux.intel.com" <isaku.yamahata@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 07, 2024, Kai Huang wrote:
> > > So I think we have consensus to go with the approach that shows in your
> > > second diff -- that is to always enable virtualization during module loading
> > > for all other ARCHs other than x86, for which we only always enables
> > > virtualization during module loading for TDX.
> > 
> > Assuming the other arch maintainers are ok with that approach.  If waiting until
> > a VM is created is desirable for other architectures, then we'll need to figure
> > out a plan b.  E.g. KVM arm64 doesn't support being built as a module, so enabling
> > hardware during initialization would mean virtualization is enabled for any kernel
> > that is built with CONFIG_KVM=y.
> > 
> > Actually, duh.  There's absolutely no reason to force other architectures to
> > choose when to enable virtualization.  As evidenced by the massaging to have x86
> > keep enabling virtualization on-demand for !TDX, the cleanups don't come from
> > enabling virtualization during module load, they come from registering cpuup and
> > syscore ops when virtualization is enabled.
> > 
> > I.e. we can keep kvm_usage_count in common code, and just do exactly what I
> > proposed for kvm_x86_enable_virtualization().
> > 
> > I have patches to do this, and initial testing suggests they aren't wildly
> > broken.  I'll post them soon-ish, assuming nothing pops up in testing.  They are
> > clean enough that they can land in advance of TDX, e.g. in kvm-coco-queue even
> > before other architectures verify I didn't break them.
> > 
> 
> Hi Sean,
> 
> Just want to check with you what is your plan on this?
> 
> Please feel free to let me know if there's anything that I can help. 

Ah shoot, I posted patches[*] but managed to forget to Cc any of the TDX folks.
Sorry :-/

[*] https://lore.kernel.org/all/20240425233951.3344485-1-seanjc@google.com

