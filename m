Return-Path: <linux-kernel+bounces-526877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB08A404BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770AB189D085
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897B4158524;
	Sat, 22 Feb 2025 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qf5OKmMt"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893933BBD8
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740188320; cv=none; b=H4AhEd9052W0CKwIIeuey2X8+ZLw7Rd+A8Jm7AyzIgQqYcp4ZJhPe6NAUmHZSggJpCOPjXBNzEnCiR3dDiEO47vAFbsztEgAmT+ME+0pJIDT9qVRLbFkwjYHaW90I3CpUxN135oRpU0TnW//wdMv/MZnxVhr5zupdinSMd09i5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740188320; c=relaxed/simple;
	bh=MgzPXhbeQnWfdIHGhOvE78AeQc6As9NC/ChOURzRh0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lnR7FwhaBozc9RCG8FcanvBSl8w6vj03BKyi8JrCtLdG42r04ECHihQGR2ZXRa9fVt2IaJk/XgQgvMStU880yxiVdx/wQ7tIN7uN3yBILIwm4IyF0BKzGS9skIoiEJNMW2M8Y9ZaXcWnG1z7Ej4nTyYVbFHh7SyvmnyiUILPH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qf5OKmMt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22114b800f0so82334975ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740188318; x=1740793118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3Vu+gRNAq0GCQCF5tfZrkQl+KMZuK2rIsH676nBvx0=;
        b=qf5OKmMttj6LDrIsOIM4sMFhJFhClOyVPA2nHHY6zySTkZl2WszADDl5j/kT2J9MY3
         NFzvsM0Tx+Q7WikWW0ovDAJNA9wTqAvfkpQ8TSMvSC4JPGyVvlFrb0d5CaOOP1V+uyVh
         7MQX808jqnP5Oz0+evg/R0xp4IQM/MQEcZzff3v2koCgtS0/XT2KZWKMkHngRwVFjUzu
         rR3fl6j8eVYsiWNpKi1zkQc9AhdTYqmoB8lCen2ANDnXZgG1xbzC/R/x+YgtUqTBAsE5
         XrHyau1emIDvt4YF/BpOnaK1d06wt+3drgsY7/ybFDec2f+e+ZBZZ+nJWmHzQE77nhL+
         FZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740188318; x=1740793118;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z3Vu+gRNAq0GCQCF5tfZrkQl+KMZuK2rIsH676nBvx0=;
        b=hnh2tXm4g4QxZEXRPXozv1KJxCJHrYDk7CMVfuqAWGeaHnTAEmxq/26awJXJAO1VG9
         pscmGpHloYr937rmPrwLNKPsSs1cqECn32mrgx1XtBT52QfVvwpW9ifqRup4nWnlIo5P
         +xOU2gdVT8irj3mxuc2koZBJ/GV8GH4T+a112yTeOXQLlWGQAfR14MKbgXoiHL6Yv+t8
         d0uaG9pOb8CNsN3J4IYNyqUJNB2NLxbNvprBRzjhMdYr9DJJiiSv0ZyDbqkciDD35KY3
         SmE3GctvaGyU6OzTI6OZzFOPIWAIkrCOjkA2gA1OEqz3L7BvO/yvS3zF3FGwYWo2A9Qe
         32GA==
X-Forwarded-Encrypted: i=1; AJvYcCUFUBWqjyTBUdxsXCDRBRmc0RSamLwGB1WVow3V/svCFMeRFGg9JQnDKm3CxOksDbSiNRUC4MuJPiznX+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhy7p4A8CK99xzHeXjvOqjVckEVx7F/5AsrjonymqoTKQb6utZ
	7+9WdwRq34g1Xqi7qtgsna5BXwoC2mXDKTCFHwUGKDaJhs4Kk9gUCTlKHl/BEqH5JcTLus1/ItH
	5hQ==
X-Google-Smtp-Source: AGHT+IFqj6syOBY9twY8DWYHC+clFeZSCyyaV7oqTbNZDTx/kW3NVAIfcpvhOrhAmGiLgzPQH4QTEZQeeUo=
X-Received: from pjbsv12.prod.google.com ([2002:a17:90b:538c:b0:2e9:38ea:ca0f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d484:b0:21f:85ee:f2df
 with SMTP id d9443c01a7336-2219ff55fe0mr84845855ad.15.1740188317777; Fri, 21
 Feb 2025 17:38:37 -0800 (PST)
Date: Fri, 21 Feb 2025 17:38:36 -0800
In-Reply-To: <5da952c534b68bba9fbfddf2197209cb719f5e41.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220170604.2279312-1-pbonzini@redhat.com> <20250220170604.2279312-21-pbonzini@redhat.com>
 <Z7fO9gqzgaETeMYB@google.com> <Z7fSIMABm4jp5ADA@google.com> <5da952c534b68bba9fbfddf2197209cb719f5e41.camel@intel.com>
Message-ID: <Z7kqnDDTSlfv38Pf@google.com>
Subject: Re: [PATCH 20/30] KVM: TDX: create/destroy VM structure
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Kai Huang <kai.huang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-02-20 at 17:08 -0800, Sean Christopherson wrote:
> > Argh, after digging more, this isn't actually true.=C2=A0 The separate =
"unload MMUs"
> > code is leftover from when KVM rather stupidly tried to free all MMU pa=
ges when
> > freeing a vCPU.
> >=20
> > Commit 7b53aa565084 ("KVM: Fix vcpu freeing for guest smp") "fixed" thi=
ngs by
> > unloading MMUs before destroying vCPUs, but the underlying problem was =
trying to
> > free _all_ MMU pages when destroying a single vCPU.=C2=A0 That eventual=
ly got fixed
> > for good (haven't checked when), but the separate MMU unloading never g=
ot cleaned
> > up.
> >=20
> > So, scratch the mmu_destroy() idea.=C2=A0 But I still want/need to move=
 vCPU destruction
> > before vm_destroy.
> >=20
> > Now that kvm_arch_pre_destroy_vm() is a thing, one idea would be to add
> > kvm_x86_ops.pre_destroy_vm(), which would pair decently well with the e=
xisting
> > call to kvm_mmu_pre_destroy_vm().
>=20
> So:
> kvm_x86_call(vm_destroy)(kvm); -> tdx_mmu_release_hkid()
> kvm_destroy_vcpus(kvm); -> tdx_vcpu_free() -> reclaim
> static_call_cond(kvm_x86_vm_free)(kvm); -> reclaim
>=20
> To:
> (pre_destroy_vm)() -> tdx_mmu_release_hkid()
> kvm_destroy_vcpus(kvm); -> reclaim
> kvm_x86_call(vm_destroy)(kvm); -> nothing
> static_call_cond(kvm_x86_vm_free)(kvm); -> reclaim

I was thinking this last one could go away, and TDX could reclaim at vm_des=
troy?
Or is that not possible because it absolutely must come dead last?

> I'm not seeing a problem. We can follow up with a real check once you pos=
t the
> patches.

Ya.  That ain't happening today.  Got demolished but KVM-Unit-Tests. :-/

> I'm not 100% confident on the shape of the proposal. But in general if
> we can add more callbacks it seems likely that we can reproduce the curre=
nt
> order. At this stage it seems safer to do that then anything more clever

