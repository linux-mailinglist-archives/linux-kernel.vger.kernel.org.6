Return-Path: <linux-kernel+bounces-175840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7618C260B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124192845DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8EC12C48F;
	Fri, 10 May 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfdWIkN3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C412BF39
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349043; cv=none; b=WL6HygN5cT+qPSvUZqZnacdUQgS/75cUeamqFcq4BqJKNG2+QmoM2lo1h7yTtr5mzklp7v4p8bMNrC6lNc1Zyz0NA2beF0qgRKD3H3jebN5zPtMbTsYMT5ezWyAaO54eUlgoqxcDQBm2y+Qw4Qnt53GuWWQzY76WwuMC6dHoPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349043; c=relaxed/simple;
	bh=I7z5nYT1NGtQi+9Q7VZZIxP3Ystgb6nUWLm9idhStWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTF2XE8nW5ivutEK8hDbKx0vXkqNEzVbjGTxK5QZDuzHFu+bLTNIsx5D1s1SxBkr4lyeAOMlvwgBiINnJ2MDiKdGEzT7NAyNsezMXWclTtKiXmOcPZKAFnXYn8b8VLL7h1FZHQEuvwSRhjZtlkWDzNmITYGD4twi/YI+SkV0ZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfdWIkN3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715349041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzf9kZEryhnm+5290e4qBYeBBj+VU2djvO6AxGd9L7w=;
	b=RfdWIkN3VJkyeoi/fjRKbE3gcA3DhsSOBEJJj9kQ0HB4Dr8taEMxdBs2g/9jpUwxIkkIug
	E8CDXESGdx+1o5gDNjVRedQFDzZi/iKA+68NUAgrY92ze5J7t20kHg04XDZrEuAd6ZMLxl
	m/KPUixkfR86Jlf7sX4O69qNVxcz1eE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-j0ylN-VcMQqYw6wTctnElw-1; Fri, 10 May 2024 09:50:40 -0400
X-MC-Unique: j0ylN-VcMQqYw6wTctnElw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34d7861a1f4so1089617f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349039; x=1715953839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzf9kZEryhnm+5290e4qBYeBBj+VU2djvO6AxGd9L7w=;
        b=WrFojzwRdI8jDKsI7tWnfFmNVFUvkWbgQS/ZAA7WHMGcehH8cX+6QJWzhx/Bbj9CP1
         zA4VCUg/I4XHP1dpUT4uQUo1YtHlk+cRKqoBTAvCH3Mg9OC0mA7dRnVUgE9/u9aCS+6i
         Fc1Vn5Ko1Gmo6WfGRCE9I/zzjgq3XJN6dFroJ6v0V39vBoC1k3nSfv6B5AQQ2FNzZWVr
         v+VMVzDYiG5ejHhNTOMlsXzBKvqNWbeWjFxvJhJVGkGuwvOSKpLqGxMgUSNnvVat5fb6
         +CcVPeYz/pS8mIsXo6c6Gv0oO9AzWSJUqk/g3diaYAORuOcvmZ6Z+mqYsqss2bfq4/8J
         +F0A==
X-Forwarded-Encrypted: i=1; AJvYcCUoiyL4Ihyat4tNrI3BlmZ4KCxGgU4s1rZ3VeNaAAGEboQbt5yUO8/nh7ZG7gFb3cCKmVWKUv+1g7loMlSt7wZGcpblc3VDRcq1zczY
X-Gm-Message-State: AOJu0Yxh5bSgnK/bRU06YV0Xw1luMhKaBWXnvgaAuDbY0GMGWU1UI9G7
	W4OaWplmXmCBk+Ibi8gFl96B78m1mjCVy3TFEc/FxNjrWo181rS/o+q6s0WhtI2EndPazb+ySk9
	bpjIzMUVACTOE/ZUXIoil3ABSmYyZDtQaGZfdHX+Yr1YUyRcdiDLu4DZx7NwrdVdeCC3Ix6GPpg
	a3+q9bo6tkCtFliucMxt5+vIfKPzQspGcr0XY1
X-Received: by 2002:a5d:5351:0:b0:343:e02f:1a46 with SMTP id ffacd0b85a97d-3504a62fb12mr2102076f8f.2.1715349038935;
        Fri, 10 May 2024 06:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHucRBfWSHvPvamu1WRWuBFTrQrQkQyBe+ROxdfO0QRjONS8tJPWThU8+2GOiv3nf4H2QrNLg23m2TZKw0gXJM=
X-Received: by 2002:a5d:5351:0:b0:343:e02f:1a46 with SMTP id
 ffacd0b85a97d-3504a62fb12mr2102054f8f.2.1715349038422; Fri, 10 May 2024
 06:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501085210.2213060-1-michael.roth@amd.com>
 <20240510015822.503071-1-michael.roth@amd.com> <Zj4lebCMsRvGn7ws@google.com>
In-Reply-To: <Zj4lebCMsRvGn7ws@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 May 2024 15:50:26 +0200
Message-ID: <CABgObfboqrSw8=+yZMDi_k9d6L3AoiU5o8d-sRb9Y5AXDTmp5w@mail.gmail.com>
Subject: Re: [PATCH v15 21/23] KVM: MMU: Disable fast path for private memslots
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, papaluri@amd.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 3:47=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> > +      * Since software-protected VMs don't have a notion of a shared v=
s.
> > +      * private that's separate from what KVM is tracking, the above
> > +      * KVM_EXIT_MEMORY_FAULT condition wouldn't occur, so avoid the
> > +      * special handling for that case for now.
>
> Very technically, it can occur if userspace _just_ modified the attribute=
s.  And
> as I've said multiple times, at least for now, I want to avoid special ca=
sing
> SW-protected VMs unless it is *absolutely* necessary, because their sole =
purpose
> is to allow testing flows that are impossible to excercise without SNP/TD=
X hardware.

Yep, it is not like they have to be optimized.

> > +      */
> > +     if (kvm_slot_can_be_private(fault->slot) &&
> > +         !(IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) &&
> > +           vcpu->kvm->arch.vm_type =3D=3D KVM_X86_SW_PROTECTED_VM))
>
> Heh, !(x && y) kills me, I misread this like 4 times.
>
> Anyways, I don't like the heuristic.  It doesn't tie the restriction back=
 to the
> cause in any reasonable way.  Can't this simply be?
>
>         if (fault->is_private !=3D kvm_mem_is_private(vcpu->kvm, fault->g=
fn)
>                 return false;

You beat me to it by seconds. And it can also be guarded by a check on
kvm->arch.has_private_mem to avoid the attributes lookup.

> Which is much, much more self-explanatory.

Both more self-explanatory and more correct.

Paolo


