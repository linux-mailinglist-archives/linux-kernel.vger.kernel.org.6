Return-Path: <linux-kernel+bounces-171915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC5C8BEA8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7211C23C19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268D916C85B;
	Tue,  7 May 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="2EjBENZv"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0115ECC6
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102876; cv=none; b=GQZ84bwIJ6z2RMH9AJIOxtuirxYO8bMeyaFCEA0W8kseCHMSLzXrO2uqPhnasy06uvWCWmXpOdO5+BOU2zMGAU9YWAbNIkQ5+fpDx4c0nc9AOb8C810hHA1nSJ+19V8Q0TpGa0R/DHI7O5tNS8zBpj8fZBIhRm3U9NBv0K4J4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102876; c=relaxed/simple;
	bh=qAtVRX6+AhJ4dBVDowc2p/2Pndkonubmd+TXFH88QOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQh4VFBvg+Mumz9PmaejP5IZU9K/ACqvoHGZkTfzwM9Bh1F/rJm8os9rE7CkqrZVwuDKg3/RIzcMwR9BuWHEi6mj/ocnw3tOImGkV6LcG653aWT9BEAkmBpUJ+/1IlGpJrobvavZZ3ECvAFsAcNVmC5DP5C76p0cAVR+A9ux4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2EjBENZv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b3773153feso2870663a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715102873; x=1715707673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5Kek28tyGZeO0uuW5wi6Fa/Up7QabcT+juDlPU1JOI=;
        b=2EjBENZvev/yZQ8w3LkgA0X5B9gbMWFvvhhplFOtdFZFkQwoEzeDUt9RZTBHCiQOrS
         /GIA6BABBxZebDtwCbgt9qB8V0vIdU325C0GCwQT5dST16uxpwiUQptsyXH7Snkby04F
         8rlmZHYTS3c5ENq+EHuXZ/p1FW37QMM4lM8dc/2MbdC30PLVZhPo2p0Id4YgiLY1+dBD
         GRLdllJys5XOwwq+ZONKf2onaSR6AJAtw9+OaVk0SdXEGJ91MRJK/VieZzBhDCjf464H
         +mt/MtqjJocZ7dluBiZmJ5U1Ze+19t8pidw2J7em2brafE4k7iuWJT8nAXDo5N1V+dfi
         NrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102873; x=1715707673;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5Kek28tyGZeO0uuW5wi6Fa/Up7QabcT+juDlPU1JOI=;
        b=jjSN68JEcoc6uOhT3Iswp8uRQ84TEVOSrc0Y13HBXD9DrLEjAUkqW86I63dz+6czbm
         95g7t+WlLhltBKZjgXRSBDDwhMIsmQHmIHVU+KGAV0EIZVj0Ru6wdqriq59TAZk9HqkH
         xWvm+QztEVhYTrdg/T+ym6E8FxRs/D6lqnS4lPHRMx8B4bAjzjjsW797ogKNorRWPD18
         alCj5uRYcnWTFm4q3n/LTZ2o1HF7oI9qUZSq1KTkaZzls1ial8A7kn3qS2FXAZlU9qsS
         YCNabDu35MZleIXLmM8jG3YmO7Ymg95hsNTjNx4N9Rs5otDwcLiKRCxhu6mj2fxo87H1
         Aicg==
X-Forwarded-Encrypted: i=1; AJvYcCVyTqlr+VMEMLffyAk0Fg9hq9VzX4bRug82CBZO0UxfRqL1Qpd68S6IcChKEDuWUhGSZLF9kyWbCtsOxaVAL4tGjkXCmwPhIwqb28Hd
X-Gm-Message-State: AOJu0Yy1qWusFPpew4wyD44QXG/sn74xMGgcjb6/ZH9+VG/YSGAta/w0
	oAW+vZJv0P7iGr+//a10jJEq0180tk3kNy/K8ebvh7BTr/pBSYN0PCBzjwbJygKQ1xOufUpU2s6
	t1g==
X-Google-Smtp-Source: AGHT+IG0l1mkxx+dDuT+PxtnEbJy9V1xx6mrdqXcxZFxl8blQ18NOLqtCsnyonuZ5ONom2NeA+IM4hfekuU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:a00a:b0:2b4:329e:a257 with SMTP id
 98e67ed59e1d1-2b616bf5282mr478a91.9.1715102872690; Tue, 07 May 2024 10:27:52
 -0700 (PDT)
Date: Tue, 7 May 2024 10:27:51 -0700
In-Reply-To: <4e034aaf-7a64-4427-b29d-da040ec7b9f0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com>
 <20240219074733.122080-18-weijiang.yang@intel.com> <ZjLE7giCsEI4Sftp@google.com>
 <4e034aaf-7a64-4427-b29d-da040ec7b9f0@intel.com>
Message-ID: <Zjpkl0U23qEOO3DY@google.com>
Subject: Re: [PATCH v10 17/27] KVM: x86: Report KVM supported CET MSRs as to-be-saved
From: Sean Christopherson <seanjc@google.com>
To: Weijiang Yang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024, Weijiang Yang wrote:
> On 5/2/2024 6:40 AM, Sean Christopherson wrote:
> > On Sun, Feb 18, 2024, Yang Weijiang wrote:
> > > Add CET MSRs to the list of MSRs reported to userspace if the feature=
,
> > > i.e. IBT or SHSTK, associated with the MSRs is supported by KVM.
> > >=20
> > > SSP can only be read via RDSSP. Writing even requires destructive and
> > > potentially faulting operations such as SAVEPREVSSP/RSTORSSP or
> > > SETSSBSY/CLRSSBSY. Let the host use a pseudo-MSR that is just a wrapp=
er
> > > for the GUEST_SSP field of the VMCS.
> > >=20
> > > Suggested-by: Chao Gao <chao.gao@intel.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >   arch/x86/include/uapi/asm/kvm_para.h |  1 +
> > >   arch/x86/kvm/vmx/vmx.c               |  2 ++
> > >   arch/x86/kvm/x86.c                   | 18 ++++++++++++++++++
> > >   3 files changed, 21 insertions(+)
> > >=20
> > > diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/=
uapi/asm/kvm_para.h
> > > index 605899594ebb..9d08c0bec477 100644
> > > --- a/arch/x86/include/uapi/asm/kvm_para.h
> > > +++ b/arch/x86/include/uapi/asm/kvm_para.h
> > > @@ -58,6 +58,7 @@
> > >   #define MSR_KVM_ASYNC_PF_INT	0x4b564d06
> > >   #define MSR_KVM_ASYNC_PF_ACK	0x4b564d07
> > >   #define MSR_KVM_MIGRATION_CONTROL	0x4b564d08
> > > +#define MSR_KVM_SSP	0x4b564d09
> > We never resolved the conservation from v6[*], but I still agree with M=
axim's
> > view that defining a synthetic MSR, which "steals" an MSR from KVM's MS=
R address
> > space, is a bad idea.
> >=20
> > And I still also think that KVM_SET_ONE_REG is the best way forward.  C=
ompletely
> > untested, but I think this is all that is needed to wire up KVM_{G,S}ET=
_ONE_REG
> > to support MSRs, and carve out room for 250+ other register types, plus=
 room for
> > more future stuff as needed.
>=20
> Got your point now.
>=20
> >=20
> > We'll still need a KVM-defined MSR for SSP, but it can be KVM internal,=
 not uAPI,
> > e.g. the "index" exposed to userspace can simply be '0' for a register =
type of
> > KVM_X86_REG_SYNTHETIC_MSR, and then the translated internal index can b=
e any
> > value that doesn't conflict.
>=20
> Let me try to understand it, for your reference code below, id.type is to=
 separate normal
> MSR (HW defined) namespace and synthetic MSR namespace, right?

Yep.

> For the latter, IIUC KVM still needs to expose the index within the synth=
etic
> namespace so that userspace can read/write the intended MSRs, of course n=
ot
> expose the synthetic MSR index via existing uAPI,=C2=A0 But you said the =
"index"
> exposed to userspace can simply=C2=A0 be '0' in this case, then how to di=
stinguish
> the synthetic MSRs in userspace and KVM? And how userspace can be aware o=
f
> the synthetic MSR index allocation in KVM?

The idea is to have a synthetic index that is exposed to userspace, and a s=
eparate
KVM-internal index for emulating accesses.  The value that is exposed to us=
erspace
can start at 0 and be a simple incrementing value as we add synthetic MSRs,=
 as the
type =3D=3D SYNTHETIC makes it impossible for the value to collide with a =
"real" MSR.

Translating to a KVM-internal index is a hack to avoid having to plumb a 64=
-bit
index into all the MSR code.  We could do that, i.e. pass the full kvm_x86_=
reg_id
into the MSR helpers, but I'm not convinced it'd be worth the churn.  That =
said,
I'm not opposed to the idea either, if others prefer that approach.

E.g.

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kv=
m.h
index 738c449e4f9e..21152796238a 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -420,6 +420,8 @@ struct kvm_x86_reg_id {
        __u16 rsvd16;
 };
=20
+#define MSR_KVM_GUEST_SSP      0
+
 #define KVM_SYNC_X86_REGS      (1UL << 0)
 #define KVM_SYNC_X86_SREGS     (1UL << 1)
 #define KVM_SYNC_X86_EVENTS    (1UL << 2)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f45cdd9d8c1f..1a9e1e0c9f49 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5990,6 +5990,19 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu=
 *vcpu,
        }
 }
=20
+static int kvm_translate_synthetic_msr(u32 *index)
+{
+       switch (*index) {
+       case MSR_KVM_GUEST_SSP:
+               *index =3D MSR_KVM_INTERNAL_GUEST_SSP;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
                         unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index cc585051d24b..3b5a038f5260 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -49,6 +49,15 @@ void kvm_spurious_fault(void);
 #define KVM_FIRST_EMULATED_VMX_MSR     MSR_IA32_VMX_BASIC
 #define KVM_LAST_EMULATED_VMX_MSR      MSR_IA32_VMX_VMFUNC
=20
+/*
+ * KVM's internal, non-ABI indices for synthetic MSRs.  The values themsel=
ves
+ * are arbitrary and have no meaning, the only requirement is that they do=
n't
+ * conflict with "real" MSRs that KVM supports.  Use values at the uppper =
end
+ * of KVM's reserved paravirtual MSR range to minimize churn, i.e. these v=
alues
+ * will be usable until KVM exhausts its supply of paravirtual MSR indices=
.
+ */
+#define MSR_KVM_INTERNAL_GUEST_SSP     0x4b564dff
+
 #define KVM_DEFAULT_PLE_GAP            128
 #define KVM_VMX_DEFAULT_PLE_WINDOW     4096
 #define KVM_DEFAULT_PLE_WINDOW_GROW    2


