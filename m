Return-Path: <linux-kernel+bounces-227513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526F9915271
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B90A1C213AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D819D061;
	Mon, 24 Jun 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNJO/mQk"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641D13DDB8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243143; cv=none; b=rFtltTv3aY8M6/JRN+w0q/1heySfyFHnkivb/By2+I84PDreD5Nn2nbxa8w1tf6Ol2oFm0mDKBBiXDKvkJ6scEcZJuT8O80AKN2b4jBEJ1YMxadq13gL9cwpQZZM01wDDG8pRxx/2HfNn5PX49PRQxf0uymNcvSTFqTuLtB9yME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243143; c=relaxed/simple;
	bh=WawAVsLJ2wrVp06E1yLAnPzm2a05JueYQ9ExxNigc3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZWueveHI4nbVgyKlYlyhGx5L718hx2w9+Oj6cS2zxGAVPe47+3m3go3TRxlnNoh5Yg4a6QCpDyE7DUs8aJMJzk3ZTAZvpGtZueZZfMUQQ2qx6boZERG1UYLX98u6Hq1OZ9ZkIB8CVE0hVQnx84cu9q1SAnlWkpB0NvjhKUNBK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNJO/mQk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c7d2380cb8so3818680a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719243140; x=1719847940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WawAVsLJ2wrVp06E1yLAnPzm2a05JueYQ9ExxNigc3k=;
        b=VNJO/mQk+GxT8wD6aDQAXS8zflMK9Ro6iIcPDqtNmNju/Uve6L8KxkevvPePWzhIKh
         Tw6zdF5TkfVl61LpzJNykotarPm3UBBUnbhjVrg7G9mLOvQLmerbGW5lBtqUTiQ5EAyI
         Cx4geUZXKTYDAQUWcRdMZxaimKeNiGM2Pnoo+TwnDzDIyzuRp0aWLQfnyHli7sA+9kIT
         GKlJGys/i1FtUoo5zSkW63wND6PNQiq1V7EJWxrPLkvfeDGvnxVfaCTdNoqFEBKAt95w
         GubCAPj58lvBOJPkRb2SFuxzqnhfIqd3CJ/bKd5vk6vnPTFTTOvGFRK2CkJHetjdAUY7
         ox3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243140; x=1719847940;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WawAVsLJ2wrVp06E1yLAnPzm2a05JueYQ9ExxNigc3k=;
        b=nfaZP7DMT8lVPYRmWP4bMTJmEFhg0yvZior1788wOz5OdrzwuLM3UaI3JDwWdLAYMZ
         rR69lAII4xSYijed8UB7MaEpysE3Njpwz9NVH/67s6tLti9QArwbNG90wfKXvfIK02qP
         yDMhVHj5UoKpvAeNmzHAVzEH5yMCZXMKN0L8HBHwTUY5D8qi5GkP66MTG86x8wf/s97U
         qxyJE+SzEi1YuGl5Kz8MLw6e0+KDx4ZayWNPwG8t2j5n7NTfv5GRCnCYBVNk7KxoNTOQ
         ThCjtwmbjyoPYB3Cie4Zsc4ozfZ0KjJacBGvI2myKSAlXUW5wVCWygAMJycjFwwJKy4e
         91zg==
X-Forwarded-Encrypted: i=1; AJvYcCWcZ0fVtVzQs5+eD5ECtNqskOI5nf9q6vVgQ8RZXMofq+7Gn2bfUph73mAF9GDybV8SCx0dgEO/Go3yVjUSQvRPlgCK2DXN9m8KW3Nx
X-Gm-Message-State: AOJu0Yya6HxWYHSz+GgqKYhgabZRvO1IEw9g1+GDoUcrwbIuDSgyi+Vq
	W23A1Bz1x6/CiT7r2dvBwi2XB/tdaM5qnLHH3/WooXYXvsPYybPvAYwg/x4gsJAIasbHYsEFb1w
	hMg==
X-Google-Smtp-Source: AGHT+IEtazAEW7Z9YwGGcKXL++Dckd0kAEwC6pBQKn1v/nxqOqzOdwWoLb56caKLmrQdFmUesETPkh89cIs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2ecc:b0:2c6:d13f:3f9e with SMTP id
 98e67ed59e1d1-2c8489b9ed7mr123696a91.1.1719243139430; Mon, 24 Jun 2024
 08:32:19 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:32:18 -0700
In-Reply-To: <504fa0a7264d4762afda2f13c3525ce5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com> <504fa0a7264d4762afda2f13c3525ce5@huawei.com>
Message-ID: <ZnmRgqD6FmXNNzzI@google.com>
Subject: Re: [PATCH 00/26] KVM: vfio: Hide KVM internals from others
From: Sean Christopherson <seanjc@google.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Anish Ghulati <aghulati@google.com>, 
	Venkatesh Srinivas <venkateshs@chromium.org>, Andrew Thornton <andrewth@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024, Shameerali Kolothum Thodi wrote:
> > This is a borderline RFC series to hide KVM's internals from the rest o=
f
> > the kernel, where "internals" means data structures, enums, #defines,
> > APIs, etc. that are intended to be KVM-only, but are exposed everywhere
> > due to kvm_host.h (and other headers) living in the global include path=
s.
>
> Hi Sean,
>=20
> Just thought of checking with you on this series. Do you have plans to re=
vive this
> series?

Yep!

> The reason I am asking is, on ARM64/KVM side we do have a requirement
> to share the KVM VMID with SMMUV3. Please see the RFC I sent out earlier =
this
> year[1]. The series basically provides a way for KVM to pin a VMID and al=
so
> associates an iommufd ctx with a struct kvm * to retrieve that VMID.=20
>=20
> As mentioned above, some of the patches in this series(especially 1-4 & 6=
) that
> does the VFIO cleanups and dropping CONFIG_KVM_VFIO looks very straightfo=
rward
> and useful. I am thinking of including those when I re-spin my RFC series=
, if
> that=E2=80=99s ok.

Please don't include them, as the patch they build towards (patch 5) is bug=
gy[*],
and I am fairly certain that at least some of the patches will change signi=
ficantly.

I expect to re-start working on the series in ~2 weeks, and am planning on =
actively
pushing the series (i.e. not ignoring it for months on end).

[*] https://lore.kernel.org/all/ZWp_q1w01NCZi8KX@google.com

> Please let me know your thoughts.
>
> [1]. https://lore.kernel.org/linux-iommu/20240209115824.GA2922446@myrica=
=20

