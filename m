Return-Path: <linux-kernel+bounces-554938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CC9A5A39E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB063A65DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DFC233731;
	Mon, 10 Mar 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rv9Nh8xd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB92AD16
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633709; cv=none; b=VCagK40cU+7rssNQkwoQ67pr4AgS05P8dm+VdX/CeF91zwyRIrPbg+MgjKp5H36nK9AzSRFPQ40xj2p/pJ5VO5wef9lmmn9t1t/V6dP4JjN50WvS/Qob7YeIb9w/4Q8L8rCpOvU8gOBSbxv4CtWaq06ynofik8FBvcHGteI2zqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633709; c=relaxed/simple;
	bh=I8WBVtWANunK2BsVVMkENeci/wdZK9By9QfvSXLeLpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5C466wjIDa5Ii3bybAy1obdGEugEimRNo70s9JxQoUSrbih7BZv58WXsIOCfqQenMpvNSK3u5Rzve6ai6u2g9VgKruf6O9hFR7zuy6/7yrHALGW9PM3Fp/GLuw2HlvIlWDB5sVf6DTZbT4QhzkstU17PKJLDKl9WoWTqoXCFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rv9Nh8xd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741633706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1SRT4mHBnbiV0+OMBjrUqLMo+A+BMJyikzuIFhqDfo=;
	b=Rv9Nh8xdCTEg+rXisvhoDvFyNHVfHRSXvM1D16vTSCKriCL+mWRRG7RcCAh9oSy+Ht9ReI
	altUiX4/sEfK920bNbCmIqhsL9cKF/556Al9gM+aqWB02M9di/ZhqMk22/hd7OR12TXRyR
	7kI8Ogpza92DVvBl1PMMejl+Iv3S/ro=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-tTJxi3lkOYqiS9c26v4IWw-1; Mon, 10 Mar 2025 15:08:24 -0400
X-MC-Unique: tTJxi3lkOYqiS9c26v4IWw-1
X-Mimecast-MFC-AGG-ID: tTJxi3lkOYqiS9c26v4IWw_1741633703
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so1679576f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741633703; x=1742238503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1SRT4mHBnbiV0+OMBjrUqLMo+A+BMJyikzuIFhqDfo=;
        b=Fa7J9jYfA2CgtpeUiUq5hescaBTb5iZ4HhcAM10lpAFG5KUYrVn1k8XgDcpsJVB+TG
         LQzYVOsiuv3iLXIC7K4MOTWyi6CMtSO3SWynKFfyhG5dWIlttsr8wFHyvVQe/W4O3jsA
         r6hL+LVx0HDrsh84nFIIJrvL9B5xQDOpC1Il/v6bALOxIEnr05QGjukb2B1qhTv1x7zE
         BURv8BjVcM4buKX3H9neyNofRMnu6ooYC9zUSnN379yhvVhJLLAsY0l89LtVQKtcSLxZ
         fzjkuCzBvlmBD4KzRFI5m73zl/dz1bdo+k4G732IOUNNtBnXb7z4erFPNQPDd/b7GGar
         ey+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEAzeEORdBB1Ekkd1Oc/CLH1L02OF+4r1zh9h1z3FjfIuGybh5DGuFfKFkRs2JZEOEbKx6BDeGd236svM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwu5Y3YZrN32W/lj5CMD5Q3xtcrR3YaDjU4aCXGjEGGnO8nNW
	AiXBePNjvArFate4p5sJRjQ3mcyijZPHbikhCIfcgxjZo64YeOT9OeMIyadR0eaT/EOHs5zFrd5
	NM/okik5emQSLGIK8Z8nfOqzrL4EKK8DCQSursWT32rpt2N5mjrgAB4kOC3sUqC1JS1TwXnzuqt
	+uweYFco5cxX/9My4MXK/hStts0eM3baQgFkDV
X-Gm-Gg: ASbGncuLAbA3ElkAP5B91QQSpoalC4JtD/UA5d7k0un/6SL0VvEqA7P17Kf608CDSPx
	vf++e0X1F7eu82SKLVlkw6qokpIVYaD8Vd9bkYiIms/mmD6IOqEzh3riRhvPZpjPb63v47F4La7
	4=
X-Received: by 2002:a5d:47c1:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-39132d2ac45mr9154846f8f.1.1741633703341;
        Mon, 10 Mar 2025 12:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGyvXXU3WZlwFBgx+HboQAJJyBSLVeAW/lF14HEQyNVdqRinVNp3MIdGujE/P/5BdCn4TEgPFhh2qIHaZhffo=
X-Received: by 2002:a5d:47c1:0:b0:391:2bcc:11f2 with SMTP id
 ffacd0b85a97d-39132d2ac45mr9154815f8f.1.1741633702980; Mon, 10 Mar 2025
 12:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129095902.16391-1-adrian.hunter@intel.com>
 <20250129095902.16391-3-adrian.hunter@intel.com> <01e85b96-db63-4de2-9f49-322919e054ec@intel.com>
 <0745c6ee-9d8b-4936-ab1f-cfecceb86735@redhat.com> <Z8oImITJahUiZbwj@google.com>
 <CABgObfahNJWCMPMV101ta-d0Cxu=RjjfMkKbOWTdRmk_VtACuw@mail.gmail.com> <Z8t16I-UXNQhcd3N@google.com>
In-Reply-To: <Z8t16I-UXNQhcd3N@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Mar 2025 20:08:11 +0100
X-Gm-Features: AQ5f1JqP7yzQO9ZWBQJYZ0hX78ZHcc3kjat0AbaztEiJ2xswLh-ni0t0t0XKYj0
Message-ID: <CABgObfbr4+y57wOiHwZZjv80rE3Bs3MujYY8HvQgDTDoctzpoQ@mail.gmail.com>
Subject: Re: [PATCH V2 02/12] KVM: x86: Allow the use of kvm_load_host_xsave_state()
 with guest_state_protected
To: Sean Christopherson <seanjc@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	kvm <kvm@vger.kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kai Huang <kai.huang@intel.com>, reinette.chatre@intel.com, 
	Tony Lindgren <tony.lindgren@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 12:04=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Mar 06, 2025, Paolo Bonzini wrote:
> I still absolutely detest carrying dedicated code
> for SEV and TDX state management.  It's bad enough that figuring out WTF =
actually
> happens basically requires encyclopedic knowledge of massive specs.
>
> I tried to figure out a way to share code, but everything I can come up w=
ith that
> doesn't fake vCPU state makes the non-TDX code a mess.  :-(

The only thing worse is requiring encyclopedic knowledge of both the
specs and KVM. :)  And yeah, we do require some knowledge of parts of
KVM
that *shouldn't* matter for protected-state guests, but it shouldn't
be worse than needed.

There's different microcode/firmware for VMX/SVM/SEV-ES+/TDX, the
chance of sharing code is lower and lower as more stuff is added
there---as is the case
for SEV-ES/SNP and TDX. Which is why state management code for TDX is
anyway doing its own thing most of the time---there's no point in
sharing a little bit which is not even the hardest.

> > just so that the common code does the right thing for pkru/xcr0/xss,
>
> FWIW, it's not just to that KVM does the right thing for those values, it=
's a
> defense in depth mechanism so that *when*, not if, KVM screws up, the odd=
s of the
> bug being fatal to KVM and/or the guest are reduced.

I would say the other way round is true too.  Not relying too much on
fake values in vcpu->arch can be more robust.

> Without actual sanity check and safeguards in the low level helpers, we a=
bsolutely
> are playing a game of whack-a-mole.
>
> E.g. see commit 9b42d1e8e4fe ("KVM: x86: Play nice with protected guests =
in
> complete_hypercall_exit()").
>
> At a glance, kvm_hv_hypercall() is still broken, because is_protmode() wi=
ll return
> false incorrectly.

So the fixes are needed anyway and we're playing the game anyway. :(

> > And while the change for XSS (and possibly other MSRs) is actually corr=
ect,
> > it should be justified for both SEV-ES/SNP and TDX rather than sneaked =
into
> > the TDX patches.
> >
> > While there could be other flows that consume guest state, they're
> > just as bound to do the wrong thing if vcpu->arch is only guaranteed
> > to be somehow plausible (think anything that for whatever reason uses
> > cpu_role).
>
> But the MMU code is *already* broken.  kvm_init_mmu() =3D> vcpu_to_role_r=
egs().  It
> "works" because the fubar role is never truly consumed.  I'm sure there a=
re more
> examples.

Yes, and there should be at least a WARN_ON_ONCE when it is accessed,
even if we don't completely cull the initialization of cpu_role...
Loading the XSAVE state isn't any different.

I'm okay with placing some values in cr0/cr4 or even xcr0/xss, but do
not wish to use them more than the absolute minimum necessary. And I
would rather not set more than the bare minimum needed in CR4... why
set CR4.PKE for example, if KVM anyway has no business using the guest
PKRU.

Paolo

> > There's no way the existing flows for !guest_state_protected should run=
 _at
> > all_ when the register state is not there. If they do, it's a bug and f=
ixing
> > them is the right thing to do (it may feel like whack-a-mole but isn't)
>
> Eh, it's still whack-a-mole, there just happen to be a finite number of m=
oles :-)


