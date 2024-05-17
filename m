Return-Path: <linux-kernel+bounces-182495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E428C8BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454311F2937C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5C14389D;
	Fri, 17 May 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXH8b6kX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8813FD9A
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968458; cv=none; b=JO/Lmwnw67EjFux70p9F+K5Hx5vAVg5QKflXbpXMA5XM+BBrdxNYYb0fN3IIfGVvvciblDfMCHK3G81/1Lut2ENAHz/X0/AYXUdC9QypWwvvPniPA0/U2bhNPqUoQfBUhWTIXoOO7n7OOo6yKoZkACb/PDlkvsWhEiZNbeVYGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968458; c=relaxed/simple;
	bh=fIE6oholh89hcyn+Mle9O7jrGtzYqHfvDqdxqhyIcuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvxUUIVcgkYC+y0ywlqszgstTiBNgN6c7Ma40q3ptQPOpBE7+ueGhfXYnWQsXh4MNrNffLW8+sFo0LNQW3+vw2rC62aenG6F2Po3GRBp2LMHYjpPKxQMMr8aQVf6BKyGks5DifY1/hBGM5NWcTrQJM8SyTZcQ/TX1PXNcjaiC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXH8b6kX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715968455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Me9x3IUsC1z+bCQEZVRKdGqYAG/0M8JKwxm1DyG55YY=;
	b=eXH8b6kXGHUYlpalRTDr0y9SdiBZhblmeds34a4Zg/WMubJm7XDu/fMZ5aMZHy77lYQPGK
	jnUqZtQe44zBpvckmXxx8BQni71CucKg70jNz0O2AsJqlnhULX06HYxiHVcnZxkev9vv8P
	qOg+/X1W9yBpaiXOO4q9Dttc01YEXBI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-s610DBGjNHqfu8Z9etiwOQ-1; Fri, 17 May 2024 13:54:14 -0400
X-MC-Unique: s610DBGjNHqfu8Z9etiwOQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34f1b148725so4310499f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715968453; x=1716573253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Me9x3IUsC1z+bCQEZVRKdGqYAG/0M8JKwxm1DyG55YY=;
        b=EsUREq6IAP8NWZab5LSLVFyj6D8C5OtQ0EE08+JOlH/UP0d2SnMPzfwvOYtbwABkyC
         Xgjd2egUKJ8IIv2lTUYXeibb0cZwsXd9GsWw1036X9p5jJfeiOjpnKzHmQH9gultL5yF
         4XopbQsdBoJEtWqf4MUuJL5BY5LoiMz1zqYHWO2IvH70fmKNtpbz28kv1WXEeFd7C4RZ
         Uon5ttTlrI4LOq+0CDjvpaf0UKFOwZoug4soGhJkT7tbt/HVu8Y33jxV3UDpcdWXgmkF
         gEH1iHcWBP742foJiYhnza+J5CLBgs6rIh7gkUfNOI7gCdtc5/FXfWjnokgJJHt8YOYy
         YaQw==
X-Forwarded-Encrypted: i=1; AJvYcCXz4zrPQGF/dYRk+x9gNxruAvFXi8ZnYxJAWpASJ1ItKQbBmcRN1M8773tb/HJ46lmwn0VF3AXL/xVlu61b32wT8IguVLr4swGgQKay
X-Gm-Message-State: AOJu0YxXwjfrTHtW46iTQghm1pj+MiqnHMKAa50y2hYeisSMYh3bl+Jo
	DxmzFVzxnSURL3mywMTzaHRBnky/z+g5mHZc0MOgw1pQpe1Aj1b7+vRvsS1VbpO7UlzRIofoeiZ
	sOn6vOYyWOf3RooniVthd588XERqyV0j+cPWuI4ZR5uCQyisan7f+wazvVf94vg4Goa3XawfO+B
	flEWYzgKZmyOGJS+YXhZE/sVsypy4czNYeryLt
X-Received: by 2002:adf:f683:0:b0:351:d2e6:9296 with SMTP id ffacd0b85a97d-351d2e69673mr5014787f8f.41.1715968452885;
        Fri, 17 May 2024 10:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElctJ7kRvI21RK2MiLgARCr0ZBPBVbvh3h/+iaUMpetOWOrRkVEQ5gzIhclzKnEFCdM7or0B/27rXrZqW8hcI=
X-Received: by 2002:adf:f683:0:b0:351:d2e6:9296 with SMTP id
 ffacd0b85a97d-351d2e69673mr5014770f8f.41.1715968452489; Fri, 17 May 2024
 10:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 May 2024 19:54:00 +0200
Message-ID: <CABgObfbYL-8KN8naUtm7PcA2z06aqshcSJ_5TyswtiA4hN0yaA@mail.gmail.com>
Subject: Re: [PATCH v2 00/49] KVM: x86: CPUID overhaul, fixes, and caching
To: Sean Christopherson <seanjc@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 7:39=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>  * Disallow KVM_CAP_X86_DISABLE_EXITS after vCPU creation
>  * Reject disabling of MWAIT/HLT interception when not allowed
>  * Advertise TSC_DEADLINE_TIMER in KVM_GET_SUPPORTED_CPUID.

This is technically a breaking change, and it's even documented in
api.rst under "KVM_GET_SUPPORTED_CPUID issues":

---
CPU[EAX=3D1]:ECX[21] (X2APIC) is reported by
``KVM_GET_SUPPORTED_CPUID``, but it can only be enabled if
``KVM_CREATE_IRQCHIP`` or ``KVM_ENABLE_CAP(KVM_CAP_IRQCHIP_SPLIT)``
are used to enable in-kernel emulation of the local APIC.

The same is true for the ``KVM_FEATURE_PV_UNHALT`` paravirtualized feature.

CPU[EAX=3D1]:ECX[24] (TSC_DEADLINE) is not reported by
``KVM_GET_SUPPORTED_CPUID``. It can be enabled if
``KVM_CAP_TSC_DEADLINE_TIMER`` is present and the kernel has enabled
in-kernel emulation of the local APIC.
---

However I think we can get away with it. QEMU source code on one hand does

        /* tsc-deadline flag is not returned by GET_SUPPORTED_CPUID, but it
         * can be enabled if the kernel has KVM_CAP_TSC_DEADLINE_TIMER,
         * and the irqchip is in the kernel.
         */
        if (kvm_irqchip_in_kernel() &&
                kvm_check_extension(s, KVM_CAP_TSC_DEADLINE_TIMER)) {
            ret |=3D CPUID_EXT_TSC_DEADLINE_TIMER;
        }

        /* x2apic is reported by GET_SUPPORTED_CPUID, but it can't be enabl=
ed
         * without the in-kernel irqchip
         */
        if (!kvm_irqchip_in_kernel()) {
            ret &=3D ~CPUID_EXT_X2APIC;
        }

so it has to cope with existing mess but it's not expecting the
opposite mess (understandable).

However, in practice userspace APIC has always been utterly broken and
even deprecated in QEMU, so we might get away with it. I don't see why
one would use no kernel APIC unless the guest has no APIC whatsoever.

And no guest that doesn't find an APIC is going to use the TSC
deadline timer (sure the MSR is outside x2APIC space but how in the
world would you configure LVTT), likewise for X2APIC since you need to
turn it on at 0xFEE0_0000 first.

Paolo


