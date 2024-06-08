Return-Path: <linux-kernel+bounces-206986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 222B090110C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F345B20A9B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC395176FC0;
	Sat,  8 Jun 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wz719ZCj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262F12BE91
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838058; cv=none; b=ZoxHPSaOZSjr6Bu4gs9lQCy95Lcvb0Qmrb1RngEnRNHj2gL1u/kUJHQNFq08f+svqg5dQcCjMLvDtND+xNdiVOQCUhLPeTfo5WLsMnsfzUouiIaDU71iU2R48Qq6KX0F9PgrtdJ6pKeJv/bPsD/Ly63wFIcRGsaAvDNefzMCbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838058; c=relaxed/simple;
	bh=Q/TGAr0CiNDoDYrcj03jYZOrzqb1pAXuFRC9IC55pSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mg60f5nH/IvVcQnWFHS0DsfaG4Mqkm5NgGzcXKV7a8nfSabxcjSN+Pfppusf65oB/ShxtG7EltTQ5ibwTnCmLdE7LrVBqpYa3BdRlXehuqmzIq1MexaxtrMpjctB+J2Q5SWoCNDq27cdSBF8ksnXyjZ8rQsWPzZO4mmB96AQEm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wz719ZCj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717838055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ku7v+UVkWkWp0wqpNRlbUjz2nl0FWZCw5kgGu5XvDzY=;
	b=Wz719ZCjafINrMFosjA5rr2WT+LFjf605rVVeXaKcI65T2kEoBmiEuwGlnn/jZyao0hNPx
	dcmgl4oDdFwmcuE48FA0UQtzmZZxET9HrcieiOPTJvgZEB5jYtg61QfP8iLMjJkvdDQ138
	mr2YlClEHWZaG2FyZsvhncBIpmCrvQs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-jX3gwbMgNkqyyXWKnnICjg-1; Sat, 08 Jun 2024 05:14:10 -0400
X-MC-Unique: jX3gwbMgNkqyyXWKnnICjg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c2dd7fb263so441043a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 02:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717838049; x=1718442849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ku7v+UVkWkWp0wqpNRlbUjz2nl0FWZCw5kgGu5XvDzY=;
        b=u3Gd4azhHTRTcMJSJDHXSIqau+VSlr2r3lS1GmDzkQuocjpvgPYRP7hVm4cGQypzmu
         77r5YQve0Oeckpd2TjsX+gqYrCLh5DkAE+psIIX7kA2+ORvePNpFOcgJturC+oQQu2So
         v4ZHn2m8tzQ5IFKlRro+GGTXoSFNdJzcIJGrPaH3g8s0aTXrvnFXzTCVnJFIM45UGcb7
         cLsuWhbMw4SibJWXm8ufz/Fd/IzLCyZQquVlKfGd228O0T9t4hbG0s3nlSh7daO6C5CH
         4ybV+eAQKLn7d8I2DYLtsCfbOh5jH7Njg/jXfBGcxMQR71QJOjMZU35/q0xdNytH9mNj
         7Z/A==
X-Forwarded-Encrypted: i=1; AJvYcCVFVPRbRo6hPM+M3iKtV+g7j/CtYxFWvBYVbSiESdcoirM4BDDomPa54zOrtds8RHgUW9t62EP5Xj42Tg2GdmywU4PiKe9qYGrahaI/
X-Gm-Message-State: AOJu0YyHIIjzWf9b416xWUj3Qazpc9lkLq/+cfUziz//87qJBM3Ha0sZ
	nvLz+2RglV84IM8rauJm6RWmsxozK4MuoP36DNi/MifH+OkLqU6e21C4UbuF9Og3KTm+q0UeC2V
	+Lw8CQEdBl+r97wmRocT/4l7TrTLyli9xRO3bTXP1SycCdeSzujYmpWVMN2YGmcbLZqwG/Z3XtT
	P6is859COuUpNNP/y+OTNTExc7ggjH9NRoL2Vx
X-Received: by 2002:a17:90b:2352:b0:2c2:cfca:6783 with SMTP id 98e67ed59e1d1-2c2cfca6890mr2473199a91.45.1717838049451;
        Sat, 08 Jun 2024 02:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBnTLiWOqQ8M39DA41jBBu3T4ZcnpjvGkKGIcmuIotBe6az6pnyy609CbOYHeRjWy3x6zvVVnDyy1QEi2ONuw=
X-Received: by 2002:a17:90b:2352:b0:2c2:cfca:6783 with SMTP id
 98e67ed59e1d1-2c2cfca6890mr2473190a91.45.1717838049109; Sat, 08 Jun 2024
 02:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com>
 <20240530210714.364118-10-rick.p.edgecombe@intel.com> <CABgObfbzjLtzFX9wC_FU2GKGF_Wq8og+O=pSnG_yD8j1Dn3jAg@mail.gmail.com>
 <b1306914ee4ca844f9963fcd77b8bf9a30d05249.camel@intel.com>
In-Reply-To: <b1306914ee4ca844f9963fcd77b8bf9a30d05249.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 8 Jun 2024 11:13:53 +0200
Message-ID: <CABgObfb1L4SLGLOPwUKTBusN9bVKACJp7cyvgL8LPhGz0QTNAA@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] KVM: x86/tdp_mmu: Support mirror root for TDP MMU
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 10:27=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> > static inline struct kvm_mmu_page *
> > tdp_mmu_get_root_for_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault
> > *fault)
> > {
> >   hpa_t root_hpa;
> >   if (unlikely(fault->is_private && kvm_has_mirror_tdp(kvm)))
> >     root_hpa =3D vcpu->arch.mmu->mirror_root_hpa;
> >   else
> >     root_hpa =3D vcpu->arch.mmu->root.hpa;
> >   return root_to_sp(root_hpa);
> > }
>
> I was not loving the amount of indirection here in the patch, but thought=
 it
> centralized the logic a bit better. This way seems good, given that the a=
ctual
> logic is not that complex.

My proposed implementation is a bit TDX-specific though... Something
like this is more agnostic, and it exploits nicely the difference
between fault->addr and fault->gfn:

if (!kvm_gfn_direct_mask(kvm) ||
    (gpa_to_gfn(fault->addr) & kvm_gfn_direct_mask(kvm))
  root_hpa =3D vcpu->arch.mmu->root.hpa;
else
  root_hpa =3D vcpu->arch.mmu->mirror_root_hpa;
return root_to_sp(root_hpa);

Paolo


