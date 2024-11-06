Return-Path: <linux-kernel+bounces-398470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0419BF1B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D141C23691
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E9D2036F7;
	Wed,  6 Nov 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyXcW9St"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001F203704
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907012; cv=none; b=SVCqCEcRbG+OcokfHfhwXqahPE/5+iITqrQ/TOHOJP53WpcFE1hR94ggxdWkLYEgdcu+YIJ7ABH85PW0GfKASJ7IOu183jJzMme5N7X5GIY94QwdrWqydEUSuXqIfaG7MMu4+MQmKsBNWdx/f/v0751T3Gx17iUG/32Y93X8Sdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907012; c=relaxed/simple;
	bh=dtSFWhS+miN5aZpkYJUpgHDtDeC0gvc+87KXOLrh29E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z6olbcW5UcGW8j9TgjQ4E5qkeXh3uaLq99lpof0FXmrJJCzKN3j8aIRYtTncceZyiMjQDtyA5zNrXwsqMuPsBJykVgt6bThJhGsGiG2wLAUyztIDwYV8LdQ/Rg+b4kWpkYxQPId9QFhWdZNE6BjvdypjpH51zlFbCrIRj1sCIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyXcW9St; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2d17b0e86so6865783a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730907010; x=1731511810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsBhbUtkiFCV/FsrzlcCyG8rzV32ZiUxSoiLe78knMI=;
        b=dyXcW9St3hVLSZmpnwxmR9qA2sfN1QgmLuj/Dx4aJG+rhzBoSHO7BjH2s/Ny5L2aUr
         PscGMNfmM7TGUzJPdXNW+p0Spp8rANKOA92/H0DZm7v4LFmMd1avYRwusNOU0me77yxS
         p2umjMV8XT/4v/E8upF/a4iKxa/ZuyHC2CMOQ2xVHyy+XGxZnQseekw82WyvuHBI0ieF
         /9Er1N2rGB++8QBLw1C4BgKvRJ1RhS9No/YVF4h1NwY8HMEmnq2u29gUDjSmc/BVk6KI
         gmyI1yfHsxrjLgP7c+bsIxaquriH6KDB/Ai1IaEJoDMgbK3Alnsqv0FTzNb/mxyP25Lv
         XhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907010; x=1731511810;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fsBhbUtkiFCV/FsrzlcCyG8rzV32ZiUxSoiLe78knMI=;
        b=eqRiGOHMcyL81Rsgpdba1OGGMGvnF4tOfb3y6wIjR7fdiavZdwSPQ+8lcc/xnvjp4x
         uZKdAJlKMg+nJw12vC0F/9v5SaAy4txiIeaBiPACrzAN7cIihZGKtTFjFSjvFCRkPMp7
         pzEW6wuUhdTLZmffnd101TR7sBb6YW0nfM71VuL7IfwfbUVDhraRDxnUli/tIL/l4aBR
         O01dYteAcKoWQFQ3bED2furhcqoL6xzwDBrYh2DPP8lkrUOklsjD86Rd7KiELNP14der
         j4/XG74aAuAbIngLvZjqaUtilGrmwwvWusUfuy35cLGFS+AkAGGBKO4fjzeOEpq0Msy7
         AfMw==
X-Forwarded-Encrypted: i=1; AJvYcCVtrAF2mFw+FtWc7AA/Oakkw8HY0fGmMyaq6Ps3nHT3KJ/x6NRtCzbppLHgo0f1q6tnvT7y4D0eIC6yAtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHuRY/KxfAe82rGm4b01bqiY0elwyK7APivXXlC0ikhfn95TSU
	zW/bxeXhNZ82aoC0JH8Cgkqqy1blHEz8Rdnh6u3ugGD2mx2mjPZiqZ5B548VW8bmN1SSS2bvu3e
	uvQ==
X-Google-Smtp-Source: AGHT+IGKQHNKS+7Ak+6aqNVefPS2IXAs2Ic9KYt9yUn1rFvCR8SBX93AbpPqcJjM+99s4d9IaZInqln9zog=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:db91:b0:2e9:3299:76ab with SMTP id
 98e67ed59e1d1-2e93c1f98f5mr99827a91.8.1730907009333; Wed, 06 Nov 2024
 07:30:09 -0800 (PST)
Date: Wed, 6 Nov 2024 07:30:07 -0800
In-Reply-To: <b7fd2ddf-77a4-423c-b5cf-36505997990d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZyLWMGcgj76YizSw@google.com> <1cace497215b025ed8b5f7815bdeb23382ecad32.camel@intel.com>
 <ZyUEMLoy6U3L4E8v@google.com> <f95cd8c6-af5c-4d8f-99a8-16d0ec56d9a4@linux.intel.com>
 <95c92ff265cfa48f5459009d48a161e5cbe7ab3d.camel@intel.com>
 <ZymDgtd3VquVwsn_@google.com> <662b4aa037bfd5e8f3653a833b460f18636e2bc1.camel@intel.com>
 <cef7b663-bc6d-44a1-9d5e-736aa097ea68@linux.intel.com> <e2c19b20b11c307cc6b4ae47cd7f891e690b419b.camel@intel.com>
 <b7fd2ddf-77a4-423c-b5cf-36505997990d@linux.intel.com>
Message-ID: <ZyuLf5evSQlZqG6w@google.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check hypercall's exit to userspace generically
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"yuan.yao@linux.intel.com" <yuan.yao@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024, Binbin Wu wrote:
> On 11/6/2024 4:54 PM, Huang, Kai wrote:
> > On Wed, 2024-11-06 at 16:32 +0800, Binbin Wu wrote:
> > > > static void kvm_complete_hypercall_exit(struct kvm_vcpu *vcpu, int =
ret_reg,
> > > >  =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long=
 ret, bool op_64_bit)
> > > > {
> > > >  =C2=A0	if (!op_64_bit)
> > > >  =C2=A0		ret =3D (u32)ret;
> > > >  =C2=A0	kvm_register_write_raw(vcpu, ret_reg, ret);
> > > >  =C2=A0	++vcpu->stat.hypercalls;
> > > > }
> > > If this is going to be the final version, it would be better to make =
it
> > > public, and export the symbol, so that TDX code can reuse it.
> > Does making it 'static inline' and moving to kvm_host.h work?
> It doesn't have a complete definition of struct kvm_vcpu in
> arch/x86/include/asm/kvm_host.h, and the code is dereferencing
> struct kvm_vcpu.
> Also, the definition of kvm_register_write_raw() is in
> arch/x86/kvm/kvm_cache_regs.h, which make it difficult to be called
> there.

A way around that would be to move the declarations from asm/kvm_host.h to =
x86.h,
and then kvm_complete_hypercall_exit() can be inlined (or not), without hav=
ing to
deal with the kvm_host.h ordering issues.

IMO, KVM x86 would ideally put as much as possible in x86.h.  The vast majo=
rity
of KVM x86's exports are intended only for the vendor modules.  Declaring t=
hose
exports in kvm_host.h is effectively bleeding KVM internals to the broader =
kernel.

I'll go that route for the series, assuming it works as I intend :-)

