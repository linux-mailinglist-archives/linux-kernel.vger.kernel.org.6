Return-Path: <linux-kernel+bounces-359558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B06998D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B44283BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAE91CEAB3;
	Thu, 10 Oct 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQSRtCg8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2E7DA62
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577470; cv=none; b=OtbnLPdtSHP1i3R9AowklTVUoDD2k/JoxN6Acp0bdHU9cXluBnV6h0LvfsOq2pHcSJwEt4CeTRkTE2VPd8r9NiPbz+16itqkqWRAOC8ZPw50elWTvg2TTS6qGu7HacrV7aQfbJ41CL0djj0S2eey97atoJHeHbf/z3I36EMVi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577470; c=relaxed/simple;
	bh=QBVdNb4X6f8yuV8IA5V+zDgeVHF/4N7Vou4Rtba1u8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIJw3/bZH4aTg7pCeC8nsUixBs32DYRm3pPGA2ksRhLxlHkFV2TR7UmwRjTnGBy8bownnzODfTpEMj8r9VP0Fx3KeDN/rCHRwUfu1NHwhEyhELBa/XFQSBkl0acop5m46oIisGJ5fUvqqo921G8uxeMZS99pTfFllYLSTAGPTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQSRtCg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728577468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqKXpH36dfv9uG+fY8ea1xXDrNeQHdPWULm3fpYA1qI=;
	b=EQSRtCg871/wW4OL/CCYPZ32FGSH3WwfEmuRoGAFSMx9HmKwd1fnSIGp8enhji66r2s6+1
	b3fX/9YSsC5G+Ujc0Gm5L13geC5GGctJojP6kI3NxKEuKAIIV8tGmOgeJf1EfPOUZCze/v
	DOjGey5ojGjDaMAZKxVVdXFM80SIPQM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-S4I3ePKXPjSHJTeE6qigmA-1; Thu, 10 Oct 2024 12:24:26 -0400
X-MC-Unique: S4I3ePKXPjSHJTeE6qigmA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d504759d0so326321f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728577461; x=1729182261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqKXpH36dfv9uG+fY8ea1xXDrNeQHdPWULm3fpYA1qI=;
        b=KiS5Bscvn0BVMK5faE4ooU/rkcYxYZg+8SfDwUnW7NorkNytk5+JumhDNk6rPcs7Xt
         yrjcZ0hqOz9ACC0cwCiODscUWR9UzUXOZG3CaTaN2RzwLRJZ9uqVjSGN0n/y3fSK7hgQ
         N6UbV8aolBHwnFeH4vni1/JJOaK0DpiD9oRcRa3f4w/tMOAA/YgOF+7OypC37wlm5zZH
         dWggTFlYnc+q/LbSh0k5WsfAuB6RO9IrIfjAFz1AC6RL0uHvSLb/Pl6/zHlR8NpSAdHM
         +87TFEf4lsP2LWtEjYU22S+pd5Cuq3qz6xCvSv3KDj/M5mdm0we9+mP1RMb/1NkhxwYh
         G5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUHd1V37FUUSxkPrtEL+YHqXtKBhceYTusFebNbFx5RLYOlfYgI62+xfbb5QBeqpqLxVwHasK2G251zuFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0pWjQ9YzJGRDacCDEP7IXVKbhxIk96AP1y8TdxyUXA6WZ297
	MSzeO3Luhv2Q7jUK8oZTz5rsAc2cBjtYXArGzaZBnLzp+n0lcN6VDaMdNnztqeQUgHeSC9t/EAx
	9qz9h/TLQm/0pyp8bvUxW0xtqHM/vpUaTlV7eJDzEEr6FO5MRmvnXrQjdNyVY/Quc7ZEIglLkKZ
	88zYRtAZe5bQmoWd9DRaLgjOBvHxoV6A00Tza7
X-Received: by 2002:a5d:526e:0:b0:37d:2ea4:bfcc with SMTP id ffacd0b85a97d-37d3aa3e0b3mr5431164f8f.13.1728577461005;
        Thu, 10 Oct 2024 09:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOpHuEnNwHPkh32sVqmcpShjg6f2VSeZjXf+Zw4AE4kSoSpmKcwl3S+T/q6TmJMxn3LegqxVUVb4KT/sS+RO0=
X-Received: by 2002:a5d:526e:0:b0:37d:2ea4:bfcc with SMTP id
 ffacd0b85a97d-37d3aa3e0b3mr5431150f8f.13.1728577460594; Thu, 10 Oct 2024
 09:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009175002.1118178-1-seanjc@google.com> <dade78b3-81b1-45fb-8833-479f508313ac@redhat.com>
 <Zwf-EX_JVfAGmrPj@google.com>
In-Reply-To: <Zwf-EX_JVfAGmrPj@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 10 Oct 2024 18:24:08 +0200
Message-ID: <CABgObfYU4=bZYHXqjh-wDDFHdF=qkbdX6Do-DobQgrqikA6zTw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] KVM: x86: Fix and harden reg caching from !TASK context
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 6:17=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Oct 10, 2024, Paolo Bonzini wrote:
> > On 10/9/24 19:49, Sean Christopherson wrote:
> > > Fix a (VMX only) bug reported by Maxim where KVM caches a stale SS.AR=
_BYTES
> > > when involuntary preemption schedules out a vCPU during vmx_vcpu_rest=
(), and
> > > ultimately clobbers the VMCS's SS.AR_BYTES if userspace does KVM_GET_=
SREGS
> > > =3D> KVM_SET_SREGS, i.e. if userspace writes the stale value back int=
o KVM.
> > >
> > > v4, as this is a spiritual successor to Maxim's earlier series.
> > >
> > > Patch 1 fixes the underlying problem by avoiding the cache in kvm_sch=
ed_out().
> >
> > I think we want this one in stable?
>
> If anything, we should send Maxim's patch to stable trees.  While not a c=
omplete
> fix, it resolves the only known scenario where caching SS.AR_BYTES is tru=
ly
> problematic, it's as low risk as patches get, and it's much more likely t=
o backport
> cleanly to older kernels.

Ok, this works for me.

Paolo


