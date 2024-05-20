Return-Path: <linux-kernel+bounces-183988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C78CA10E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DA22811A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7667E137C37;
	Mon, 20 May 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BaEgBlWS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880F137931
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224986; cv=none; b=Jb4ENpVAb4NXHf6xfW8pj++txkcI0cTXq0BgB47ZS/h+85Igm43R4ADo1ZVqoflyf4X7Q1tMynwTvd+dXgUsjW3sK65MavkKFKk4+5yg8NrDapJsCBYENBYz856uj4AKuBecv9yKlTDfsuApXLAkoGL5drG1L1lpiOVPXeAFtLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224986; c=relaxed/simple;
	bh=iXrU3QtcVFh8Xuzbw7FM7adPMT2MiMJT39cG1TXBTcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vAZN6UB2cSWavNlcNasc6GDo2Mf+Dt6r//2bl/OtJuwdsuz7b1Oj3YR17MfuM60CM4qZE7lE0D5Xe1x+HdEZnKPjbuIATk16FYeKok0O1mAgtSvff/KijNmlJdQDQGY0AXN/DaFa6nMSACIYNDdBaq/G61pKcZoq5QEnJHKvLp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaEgBlWS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e612376so17176955276.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716224984; x=1716829784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j30OoqLnuK99UHrofDf6Sz2fV/csd7+KiSSj9cTAu00=;
        b=BaEgBlWSRwgw6nwCIo8bR34imtDGs0CIbhsSpYOKyLXO82HVRxAlV8WUJaXBWzhInF
         dErbXUxhZno4liyZx2RhxfZjXYKIBuNrpVKxvkskHcfIukbZqx/r3PZAQD3CGWaznFti
         /jHV0wEuXbFRcxaa0WTBega2JJuZg6m9lIsXbVYDlbu/ICpy5JDXed1CAYe+hPG/2jiQ
         WDI1rnhGsiSCZ/7+hq1Xc5eHhfs5+R+gOFFCMAJkeZ21nTO+mKoAnyhhsdvth+lhkglY
         Cr5w/oT7Fts9pR3cN1AJBa8fcOF6oMDsRzaOlw+vT8MSEmJ3FF+LvKZeY9Fw9/fpGTzt
         XLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716224984; x=1716829784;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j30OoqLnuK99UHrofDf6Sz2fV/csd7+KiSSj9cTAu00=;
        b=LnNLkgupYAVPJ25EGKpXhh7XhLYEZwTnpb/M+v7T2BUoNtBeCPlz9aE+b6+DjxUpI6
         PJZewF1YyHnlVF/O1zgYOkIeVQss7GRwUaR8CQyWsPjStPvQ4Zu7vtvSxDGzkuBer+BJ
         G/IHYCH2nlZxM9lVULhIP2jg74tJTrYp9A7qUopNu1FjnQo/4eDmzuc0CNRLXuNYPM1v
         jnigmIR+sk5HO/umNQ9ANnea/aj32vU0CCj3hq7shZ4q1kedrW5aqnpcidgV0nlL1Ys4
         oHPHjYV8OUgq/iKHyGaZMa0UQVg8Bwbl18ASwO43K28q/48Nz2O/qoBws5iOg8Ff7do1
         wGOw==
X-Forwarded-Encrypted: i=1; AJvYcCWQyJL9B2T0k5ooCa7gIX/EOens2phDc6NlVsBroYmqnVGUL+VMI4koGYRkM8EnwmsQPrQuyl1+Oj+kFa7ESh+OWQz4f94TvRyKTTwg
X-Gm-Message-State: AOJu0YykA8jrzkhdPE5v/zD4PYj+vKAveaswUFncoDnFqA01v+1i4GQt
	MnaYX8h18FV+fJe8KD2Sjo4clmYX0nepdoWRElPvlBBklndxUzM5ugltbQ2jOwOshUrDk1DmBcf
	/ww==
X-Google-Smtp-Source: AGHT+IG81IiVTqSztoF8HyU0QWrzXwFvH5pJ0aEkZ4gO5+oNq81s7//SP/vyposoedqfpisyCD+zc3L4EoA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1206:b0:df4:9688:b28 with SMTP id
 3f1490d57ef6-df496880e86mr615823276.3.1716224984265; Mon, 20 May 2024
 10:09:44 -0700 (PDT)
Date: Mon, 20 May 2024 10:09:42 -0700
In-Reply-To: <a170e420-efc3-47f9-b825-43229c999c0d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com>
 <20240219074733.122080-25-weijiang.yang@intel.com> <ZjLNEPwXwPFJ5HJ3@google.com>
 <39b95ac6-f163-4461-93f3-eaa653ab1355@intel.com> <ZkYauRJBhaw9P1A_@google.com>
 <87r0e0ke8w.ffs@tglx> <ZkdpKiSyOwB3NwRD@google.com> <a170e420-efc3-47f9-b825-43229c999c0d@intel.com>
Message-ID: <ZkuD1uglu5WFSoxR@google.com>
Subject: Re: [PATCH v10 24/27] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Weijiang Yang <weijiang.yang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, rick.p.edgecombe@intel.com, pbonzini@redhat.com, 
	dave.hansen@intel.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, chao.gao@intel.com, 
	mlevitsk@redhat.com, john.allen@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024, Weijiang Yang wrote:
> On 5/17/2024 10:26 PM, Sean Christopherson wrote:
> > On Fri, May 17, 2024, Thomas Gleixner wrote:
> > > On Thu, May 16 2024 at 07:39, Sean Christopherson wrote:
> > > > On Thu, May 16, 2024, Weijiang Yang wrote:
> > > > > We synced the issue internally, and got conclusion that KVM shoul=
d honor host
> > > > > IBT config.  In this case IBT bit in boot_cpu_data should be hono=
red.=C2=A0 With
> > > > > this policy, it can avoid CPUID confusion to guest side due to ho=
st ibt=3Doff
> > > > > config.
> > > > What was the reasoning?  CPUID confusion is a weak justification, e=
g. it's not
> > > > like the guest has visibility into the host kernel, and raw CPUID w=
ill still show
> > > > IBT support in the host.
> > > >=20
> > > > On the other hand, I can definitely see folks wanting to expose IBT=
 to guests
> > > > when running non-complaint host kernels, especially when live migra=
tion is in
> > > > play, i.e. when hiding IBT from the guest will actively cause probl=
ems.
> > > I have to disagree here violently.
> > >=20
> > > If the exposure of a CPUID bit to a guest requires host side support,
> > > e.g. in xstate handling, then exposing it to a guest is simply not
> > > possible.
> > Ya, I don't disagree, I just didn't realize that CET_USER would be clea=
red in the
> > supported xfeatures mask.
>=20
> For host side support, fortunately,=C2=A0 this patch already has some che=
cks for
> that. But for userspace CPUID config, it allows IBT to be exposed alone.
>=20
> IIUC, this series tries to tie IBT to SHSTK feature, i.e., IBT cannot be
> exposed as an independent feature to guest without exposing SHSTK at the =
same
> time. If it is, then below patch is not needed anymore:
> https://lore.kernel.org/all/20240219074733.122080-3-weijiang.yang@intel.c=
om/

That's a question for the x86 maintainers.  Specifically, do they want to a=
llow
enabling XFEATURE_CET_USER even if userspace shadow stack support is disabl=
ed.

I don't think it impacts KVM, at least not directly.  Regardless of what de=
cision
the kernel makes, KVM needs to disable IBT and SHSTK if CET_USER _or_ CET_K=
ERNEL
is missing, which KVM already does via:

	if ((kvm_caps.supported_xss & (XFEATURE_MASK_CET_USER |
	     XFEATURE_MASK_CET_KERNEL)) !=3D
	    (XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)) {
		kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
		kvm_cpu_cap_clear(X86_FEATURE_IBT);
		kvm_caps.supported_xss &=3D ~(XFEATURE_MASK_CET_USER |
					    XFEATURE_MASK_CET_KERNEL);
	}

> I'd check and clear IBT bit from CPUID when userspace enables only IBT vi=
a
> KVM_SET_CPUID2.

No.  It is userspace's responsibility to provide a sane CPUID model for the=
 guest.
KVM needs to ensure that *KVM* doesn't treat IBT as supported if the kernel=
 doesn't
allow XFEATURE_CET_USER, but userspace can advertise whatever it wants to t=
he guest
(and gets to keep the pieces if it does something funky).

