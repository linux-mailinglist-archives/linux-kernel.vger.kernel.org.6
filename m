Return-Path: <linux-kernel+bounces-272749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4F2946093
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450D7285A74
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6EC175D26;
	Fri,  2 Aug 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7IAhDGL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD8175D20
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612811; cv=none; b=n18eC9OMfc1GUm7bDGB1fhQqiiCpKGynYNr7foMb+KpEU68OeysKzzfUFGExQ19Xa1tv5Qrt0xIXxJvt0oa6lBtUIHWE8OEuyQMC9ts27wdvamtCr8UweRXWmJOEszqE4LFzJg/e1N2hHP3vjFRZMjyS3aKxyJSPVZhBRM9hyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612811; c=relaxed/simple;
	bh=UQAo0QZ/039NrnppXw12rWPd6jf++IZECrCt5WdAMI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBjxg2mibIoBTjvjGkBFcH373Jo+e0BVYZFv4r9yTRzUF6h4JLHubbZQ0F+8Y3tzcxu5gLreldVAuEATIJyCFzkt61krHYY/bk467BUxbF8BkIYCL8ugmMtT+IkdM7dJtHY9nBoLjAy+qfeEiCOFiDEkUA2h9cMWkUAKFQiWITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7IAhDGL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722612808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKAV3vEzVWJ/I1alYAAc4EA//cveM0hj0CwgdtdH9lo=;
	b=V7IAhDGLx4BSLiA8ZEd7NkXVXPXi8RY07Bzp2Di2cQnnstTb41ZF8Acr/ERQKBhPH49inl
	DTWqRU7HY0lnzOEzG+VPGLiOouab9U+87+fOSwjJ2bH0CxquytIIn8+SLmHmZ7e1WVbNpg
	C3hvhXZ4jrXuNhE7ktr7oKWlfY1aEmg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-KayPjKvxM3enninlC6-YdA-1; Fri, 02 Aug 2024 11:33:25 -0400
X-MC-Unique: KayPjKvxM3enninlC6-YdA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428e187aedfso11337985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722612804; x=1723217604;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKAV3vEzVWJ/I1alYAAc4EA//cveM0hj0CwgdtdH9lo=;
        b=Sp64wKxfQB07SnPUXkY4Gj8Leq0iJXXczGB6+HLgOez3RXJO/iaRdXhnzWzUkeJymf
         3QjAbzErB6+QHvMjbeOPN5yC+xoR0lSGg0Cd9eGB+RMNM68aNaJ6dfIyF2/xOKGS2IoK
         tU0WyGAyUdFXk7ySxWsUW2tof5Oix8q3zU++s3keViryJ7CV7Rzs6VmwoBcQv/vyRX4C
         8Uo9lnZHf93I7RkrZOAGc11ptAuIWwrH0AYtwd3pmnFN0rnN+8bz+tAvRgD0evq8fG/2
         iHhh22ZwnBlL0RPDa3wqkRWsEaKzagCe+UH0TqrhGuLBoeOVRPrqdHsMecATygEQaG8R
         05BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbzOk3lhJ98vhSISZCmlp7jUiN53sRKoE3mvcgqNurk1R1qUihF/U6nJcH7Gt8Y8omXjP/aJUZLrkor09bJjXAK2HawnjgT+HZP3Ua
X-Gm-Message-State: AOJu0YxSlM5twDOxsHVmpb66q1yFnYFqoL+tZTtjhMwf4AyEdVThE4ho
	QW0VDHuhSwZ2di/XIZFdy5+5QF3iYS5jWmbDgdRnFCArEel9/nUJM5MtZiOxoaiugbNZ2aPXnS2
	133+eNHV3P9tuUjZCZR2xnGChwcPM65oGADJVp1iSYsIsZmxphr9nRWCyF9SUdA==
X-Received: by 2002:a05:600c:4509:b0:426:6252:61d9 with SMTP id 5b1f17b1804b1-428e478e42amr49629325e9.11.1722612803702;
        Fri, 02 Aug 2024 08:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHed4IQ4hT2Ft8Jl9YnIgnAjblkExYSjhZSgnkWMr45iTYGAreFTMGYFrW+5fLtJD2unClEw==
X-Received: by 2002:a05:600c:4509:b0:426:6252:61d9 with SMTP id 5b1f17b1804b1-428e478e42amr49628715e9.11.1722612803197;
        Fri, 02 Aug 2024 08:33:23 -0700 (PDT)
Received: from ?IPv6:2a06:c701:77bf:9b01::1? ([2a06:c701:77bf:9b01::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e11c8eb9sm65806265e9.16.2024.08.02.08.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:33:22 -0700 (PDT)
Message-ID: <6d043ba2be415fae75d0789d1b7b4d432032a113.camel@redhat.com>
Subject: Re: [PATCH v3 0/2] Fix for a very old KVM bug in the segment cache
From: mlevitsk@redhat.com
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>,  linux-kernel@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>,  x86@kernel.org
Date: Fri, 02 Aug 2024 18:33:20 +0300
In-Reply-To: <20240725175232.337266-1-mlevitsk@redhat.com>
References: <20240725175232.337266-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=D0=A3 =D1=87=D1=82, 2024-07-25 =D1=83 13:52 -0400, Maxim Levitsky =D0=BF=
=D0=B8=D1=88=D0=B5:
> Hi,
>=20
> Recently, while trying to understand why the pmu_counters_test
> selftest sometimes fails when run nested I stumbled
> upon a very interesting and old bug:
>=20
> It turns out that KVM caches guest segment state,
> but this cache doesn't have any protection against concurrent use.
>=20
> This usually works because the cache is per vcpu, and should
> only be accessed by vCPU thread, however there is an exception:
>=20
> If the full preemption is enabled in the host kernel,
> it is possible that vCPU thread will be preempted, for
> example during the vmx_vcpu_reset.
>=20
> vmx_vcpu_reset resets the segment cache bitmask and then initializes
> the segments in the vmcs, however if the vcpus is preempted in the
> middle of this code, the kvm_arch_vcpu_put is called which
> reads SS's AR bytes to determine if the vCPU is in the kernel mode,
> which caches the old value.
>=20
> Later vmx_vcpu_reset will set the SS's AR field to the correct value
> in vmcs but the cache still contains an invalid value which
> can later for example leak via KVM_GET_SREGS and such.
>=20
> In particular, kvm selftests will do KVM_GET_SREGS,
> and then KVM_SET_SREGS, with a broken SS's AR field passed as is,
> which will lead to vm entry failure.
>=20
> This issue is not a nested issue, and actually I was able
> to reproduce it on bare metal, but due to timing it happens
> much more often nested. The only requirement for this to happen
> is to have full preemption enabled in the kernel which runs the selftest.
>=20
> pmu_counters_test reproduces this issue well, because it creates
> lots of short lived VMs, but the issue as was noted
> about is not related to pmu.
>=20
> To paritally fix this issue, call vmx_segment_cache_clear
> after we done with segment register setup in vmx_vcpu_reset.
>=20
> V2: incorporated Paolo's suggestion of having
> =C2=A0=C2=A0=C2=A0 vmx_write_segment_cache_start/end functions=C2=A0 (tha=
nks!)
>=20
> V3: reverted to a partial fix.
>=20
> Best regards,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maxim Levitsky
>=20
> Maxim Levitsky (2):
> =C2=A0 KVM: nVMX: use vmx_segment_cache_clear
> =C2=A0 VMX: reset the segment cache after segment initialization in
> =C2=A0=C2=A0=C2=A0 vmx_vcpu_reset
>=20
> =C2=A0arch/x86/kvm/vmx/nested.c |=C2=A0 3 ++-
> =C2=A0arch/x86/kvm/vmx/vmx.c=C2=A0=C2=A0=C2=A0 | 10 +++-------
> =C2=A0arch/x86/kvm/vmx/vmx.h=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> =C2=A03 files changed, 10 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.26.3
>=20
>=20

Any update?

Best regards,
	Maxim Levitsky


