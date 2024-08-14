Return-Path: <linux-kernel+bounces-287245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E12952547
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD4B22822
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9414AD20;
	Wed, 14 Aug 2024 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCJ9rm9X"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DA14A4C3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673367; cv=none; b=R1647neVvEVe7DkG/xAmk1K+YsxOt4aDSNFMl4e99bTqRsn3y4ghsnukYPNB3Urb/TwtYDZMiXDE6sXWaAiilRUvsNP+MxBKKMo7pwLItSZ3lWequoHeQg3hg5dD38P68fd/3TTCiN0/qE3R364oyymiWVcjge3wQUiV4h2wtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673367; c=relaxed/simple;
	bh=hJ1F+BABCqhd8mnn8LW81zLM4QyyfSANhNA+NOn3UdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=stUBcNj//zhDwAJEfklnCcg2yx/M0rehz54yzOJXNJtTFfVl3+aTKpu/9Tvqqp6sw0+0FJL5vUPG1XsZId4sp/Ybw25vb9dY233MLt9TELqOD+LUhxWbjLMZo1Z5ohby1I0pPlBjqJ0F43eN6fTjnNWh1jzNHgY+N8OiqkvBRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCJ9rm9X; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a2787eb33dso293029a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723673365; x=1724278165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SzMRJqrcGTRtt0dLvyq0skJ6+9ho1nK29bEvZqO70M0=;
        b=zCJ9rm9XxM9sBsuqxod9aSjTgSxsnITJD9n1nSfY8w+b2mVOXtoF1/lfHqax2Z9uKT
         RAjvMUEJQL6zpWAKyZHpcJwoQqAdTj0ya6DRCpGd6g0di7WlKnlY5oYFZClxgzJlRqmk
         zALS29/WnP2KuAl38NlUjQyGvQASprPsdQOpBJ3POxuwnTljn66TtkXlTbf+JVaTNsH5
         j/YgHD37khiIUaOWgRW+shwdcwxq26PaES+Onsbo4eoGZEyWOoyGHjpkf7xN24lQWlll
         1MBetxlCiBxgNMcvey37s95iknuc4cVlpyIV45hQmkOZP6vJS+WU7TO7nOyfwI6nZAlI
         uj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723673365; x=1724278165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzMRJqrcGTRtt0dLvyq0skJ6+9ho1nK29bEvZqO70M0=;
        b=hESJhfUOHZJ6Wox8S86r2DiI/1GvFDUUOIbxP41wpoAUVnUwVk0JD75udCNgWIYck2
         rxNk1OVN1CpUCw8Td9NBvE05ofDer6owq2gqTLl0p3N5KegT5EurqrGdD8b0nFqxcrox
         UBu7tNjgb2Gj8uoGW4gmOvh+0Gz8q7IItysly6lbfqwjh9tSaVgLHqwq6wE6sOCMHmDg
         IiytX/qDuB1ph9Ckl63n0TAFuQ/OOBp28u9m+hC+6S6i4QzkXcJ+aLR0dNCC5LkivVMU
         GHOijYpiMrZtXXA9H+M9JwN0DTZf3KqiQeHcZXNe5Ym1OxD17AdmZb4aDMw0+TQPX+/O
         MMrA==
X-Forwarded-Encrypted: i=1; AJvYcCVApxR3FxDBxh4+vn98AE34Cr0FGB5so0MOwAtBQW7i+XT0qcGWI13H6ud6R4G6bRUV3gb5gyg6Kc4wrcVL+YpWTpNNrGhIPRMmvNDE
X-Gm-Message-State: AOJu0YxOATANLxuo4P9TG6xMaZqp+3yEnlfbqvXCzPhzgCoGV+2gJJzi
	ZnAIyl66ZS5CHMXetbsKEz/el+v1YX048iIv+LGe2xNYuLKZCyMItGP40649Gs5uPdBGdWYD9Pq
	zsQ==
X-Google-Smtp-Source: AGHT+IGI7VUT5R4AtdyMV2dcw/q3Z3QvHeYT861H5b6dEAzqj3pnx2yv1NieIiNXgQ+hzI4Tg07SJIzyokw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c8:b0:200:ac2c:677f with SMTP id
 d9443c01a7336-201d6467e41mr4206905ad.7.1723673364872; Wed, 14 Aug 2024
 15:09:24 -0700 (PDT)
Date: Wed, 14 Aug 2024 15:09:23 -0700
In-Reply-To: <87mslff728.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b44227c5-5af6-4243-8ed9-2b8cdc0e5325@gmail.com>
 <Zpq2Lqd5nFnA0VO-@google.com> <207a5c75-b6ad-4bfb-b436-07d4a3353003@gmail.com>
 <87a5i05nqj.fsf@redhat.com> <b20eded4-0663-49fb-ba88-5ff002a38a7f@gmail.com>
 <87plqbfq7o.fsf@redhat.com> <ZrzIVnkLqcbUKVDZ@google.com> <87mslff728.fsf@redhat.com>
Message-ID: <Zr0rEy0bO1ju_f1C@google.com>
Subject: Re: [BUG] =?utf-8?Q?arch=2Fx86=2Fkvm=2Fvmx?= =?utf-8?Q?=2Fvmx=5Fonhyperv=2Eh=3A109=3A36=3A_error=3A_dereference_of_NUL?=
 =?utf-8?B?TCDigJgw4oCZ?=
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 14, 2024, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Aug 14, 2024, Vitaly Kuznetsov wrote:
> >> What I meant is something along these lines (untested):
> >> 
> >> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
> >> index eb48153bfd73..e2d8c67d0cad 100644
> >> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
> >> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
> >> @@ -104,6 +104,14 @@ static inline void evmcs_load(u64 phys_addr)
> >>         struct hv_vp_assist_page *vp_ap =
> >>                 hv_get_vp_assist_page(smp_processor_id());
> >>  
> >> +       /*
> >> +        * When enabling eVMCS, KVM verifies that every CPU has a valid hv_vp_assist_page()
> >> +        * and aborts enabling the feature otherwise. CPU onlining path is also checked in
> >> +        * vmx_hardware_enable(). With this, it is impossible to reach here with vp_ap == NULL
> >> +        * but compilers may still complain.
> >> +        */
> >> +       BUG_ON(!vp_ap);
> >
> > A full BUG_ON() is overkill, and easily avoided.  If we want to add a sanity
> > check here and do more than just WARN, then it's easy enough to plumb in @vcpu
> > and make this a KVM_BUG_ON() so that the VM dies, i.e. so that KVM doesn't risk
> > corrupting the guest somehow.
> >
> 
> I'm still acting under the impression this is an absolutely impossible
> situation :-)
> 
> AFAICS, we only call evmcs_load() from vmcs_load() but this one doesn't
> have @vcpu/@kvm either and I wasn't sure it's worth the effort to do the
> plumbing (or am I missing an easy way to go back from @vmcs to
> @vcpu?). On the other hand, vmcs_load() should not be called that ofter
> so if we prefer to have @vcpu there for some other reason -- why not.

kvm_get_running_vcpu(), though I honestly purposely didn't suggest it earlier
because I am not a fan of using kvm_get_running_vcpu() unless it's absolutely
necessary.  But for this situation, I'd be fine with using it.

