Return-Path: <linux-kernel+bounces-428536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8E89E0FC8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56876B2355D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7399537E9;
	Tue,  3 Dec 2024 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyrEkp7z"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC945027
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186095; cv=none; b=YvBYs1ziMyHnqm3lNOOfTMBCTE+eAXEOm8F/H05jt37P4kWsGKLrE/0TXFZHLwfiIJ/14AWhiHX+ERj4PrjmUm9573uCLWCCV4qukAVYo2CCKpeTBhOO/M2X2LA+gcw0hIDspV0Qph+VPcs4rBJJyiSUiIqWdOCOH15TNupfKUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186095; c=relaxed/simple;
	bh=tzCgBEFnS5ANZTBsuBljMs2o6QURCyHjOkzX4GsAvtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UmH3bsXtq7fvL/xHb/+IqxXdyspSZqiimwr5/hx4gDF61MQOESeIWW05UICz+Lb875K4D5lmAAV7fz8cXqbihVoAea+eh2bSSRSLHY3mj5uocJdRNu1hNuY5EqW9VMxFOBnzIts9HWVjFkTwXsMv/D92yYlpnTrYIfseSPu7KYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyrEkp7z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee4f3785f6so3694011a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 16:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733186093; x=1733790893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYQHLQkIXjnazxVDCOEIm3YxmS353KiSc2+5UE6FFuY=;
        b=nyrEkp7zN/N9VmjLiCN81P06WoXeNo2s9bCRL0U+o6TIGURhTourr8mLae8TuUc55P
         xlSm/YtzRS1YvO6JAisNRUkATauXpVAlplx0Y49bhkL0YXWYiCnyOcbdoYN7QXBcfkey
         VmB30huZUL8wyodCeJqH1zKeqQBaMkKHvA7PtI5ItX8rIJxs8QkQ8ZYJLTRoJEiPQqMZ
         cGqhUfBy/4WKLdUhkOSgeuQ41OKWjEpBXAK+bOr5Z5m8xY7yMg4Hf8N7pdk+X26jp49R
         9vbaXPX/JO8qdC5hLXMuoZpQBtwNw+OUP9o/zPc7cSZCjEtJuKaoE3nxMDAxmz2AScPm
         XUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733186093; x=1733790893;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rYQHLQkIXjnazxVDCOEIm3YxmS353KiSc2+5UE6FFuY=;
        b=d93h78T3G8iLnAbHkpdgh73N5Cy+v342HA4UkftDPqISLJA9ssn3taFebzXNLAhGKN
         LXfQWqyghlNhq/tWqd5b2R9A5I18uvkM//B69MeO/koMEWVHCHAav81P47rir04RWhrr
         PBT3jep5xI3koWGAoLyeJ92MRgiPIwrsgHZSPb0VURY2+lvTT+ctavUlC3q8J32+/UXd
         bQcos3AarTLLSiZq3HrFUTWtpQHv82hEuberwjTqnykGDbqikZVy/mbD7MBCkCwZQAUa
         7uHUvVcjFc8zf4AYHnfNKrfTAMyAMpvV4eQceJj7rUNIu2DCy+0AKvrYbMIimsZs6akA
         D9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXsfESg1VFr2X8jtAIiiF87DJ8FM69GCMye/XT9x5OjLm4p7M0Qr85pRquJTN+HgrGf8KOaer0w9UatojE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9mzoz6IPgGCYuK32VbxvXQ8VJnCRSzbIP6QtD+wq65sdWARJ
	lQUhb4h8SZ0ZVEpbintQuyFGdm+T/f9qZhqerdai3k8GDIbYfRB1rlDcbbeN2RHJ4J78la8CxfO
	VwQ==
X-Google-Smtp-Source: AGHT+IFNouhJApEVgkQp7EUJJUYNmOctJn9w69C+avz7PwMsCikrYJYVRnrwkIpIwxoR7p8CjdmmrhBzopI=
X-Received: from pjbph8.prod.google.com ([2002:a17:90b:3bc8:b0:2d3:d4ca:5fb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8c:b0:2ee:db8a:29d0
 with SMTP id 98e67ed59e1d1-2ef0125b2fdmr792869a91.26.1733186092989; Mon, 02
 Dec 2024 16:34:52 -0800 (PST)
Date: Mon, 2 Dec 2024 16:34:51 -0800
In-Reply-To: <c98556099074f52af1c81ec1e82f89bec92cb7cd.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121201448.36170-1-adrian.hunter@intel.com>
 <20241121201448.36170-8-adrian.hunter@intel.com> <Zz/6NBmZIcRUFvLQ@intel.com>
 <Z0cmEd5ehnYT8uc-@google.com> <b36dd125-ad80-4572-8258-7eea3a899bf9@intel.com>
 <Z04Ffd7Lqxr4Wwua@google.com> <c98556099074f52af1c81ec1e82f89bec92cb7cd.camel@intel.com>
Message-ID: <Z05SK2OxASuznmPq@google.com>
Subject: Re: [PATCH 7/7] KVM: TDX: Add TSX_CTRL msr into uret_msrs list
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	Weijiang Yang <weijiang.yang@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chao Gao <chao.gao@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024, Rick P Edgecombe wrote:
> On Mon, 2024-12-02 at 11:07 -0800, Sean Christopherson wrote:
> > > guest_can_use() is per-vcpu whereas we are currently using the
> > > CPUID from TD_PARAMS (as per spec) before there are any VCPU's.
> > > It is a bit of a disconnect so let's keep tsx_supported for now.
> >=20
> > No, as was agreed upon[*], KVM needs to ensure consistency between what=
 KVM
> > sees

Rick, fix your MUA to not wrap already :-)

> > as guest CPUID and what is actually enabled/exposed to the guest.=C2=A0=
 If there
> > are no vCPUs, then there's zero reason to snapshot the value in kvm_tdx=
.=C2=A0
> > And if there are vCPUs, then their CPUID info needs to be consistent wi=
th
> > respect to TDPARAMS.
>=20
> Small point - the last conversation[0] we had on this was to let *userspa=
ce*
> ensure consistency between KVM's CPUID (i.e. KVM_SET_CPUID2) and the TDX
> Module's view.

I'm all for that, right up until KVM needs to protect itself again userspac=
e and
flawed TDX architecture.  A relevant comment I made in that thread:

 : If the upgrade breaks a setup because it confuses _KVM_, then I'll care

As it applies here, letting vCPU CPUID and actual guest functionality diver=
ge for
features that KVM cares about _will_ cause problems.

This will be less ugly to handle once kvm_vcpu_arch.cpu_caps is a thing.  K=
VM
can simply force set/clear bits to match the actual guest functionality tha=
t's
hardcoded by the TDX Module or defined by TDPARAMS.

> So the configuration goes:
> 1. Userspace configures per-VM CPU features
> 2. Userspace gets TDX Module's final per-vCPU version of CPUID configurat=
ion via
> KVM API
> 3. Userspace calls KVM_SET_CPUID2 with the merge of TDX Module's version,=
 and
> userspace's desired values for KVM "owned" CPUID leads (pv features, etc)
>=20
> But KVM's knowledge of CPUID bits still remains per-vcpu for TDX in any c=
ase.
>=20
> >=20
> > =C2=A0- Don't hardcode fixed/required CPUID values in KVM, use availabl=
e metadata
> > =C2=A0=C2=A0 from TDX Module to reject "bad" guest CPUID (or let the TD=
X module reject?).
> > =C2=A0=C2=A0 I.e. don't let a guest silently run with a CPUID that dive=
rges from what
> > =C2=A0=C2=A0 userspace provided.
>=20
> The latest QEMU patches have this fixed bit data hardcoded in QEMU. Then =
the
> long term solution is to make the TDX module return this data. Xiaoyao wi=
ll post
> a proposal on how the TDX module should expose this soon.

Punting the "merge" to userspace is fine, but KVM still needs to ensure it =
doesn't
have holes where userspace can attack the kernel by lying about what featur=
es the
guest has access to.  And that means forcing bits in kvm_vcpu_arch.cpu_caps=
;
anything else is just asking for problems.

> > [*] https://lore.kernel.org/all/20240405165844.1018872-1-seanjc@google.=
com
>=20
>=20
> [0]https://lore.kernel.org/kvm/CABgObfaobJ=3DG18JO9Jx6-K2mhZ2saVyLY-tHOga=
b1cJupOe-0Q@mail.gmail.com/

