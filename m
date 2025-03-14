Return-Path: <linux-kernel+bounces-561645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014FA61481
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623E016AC71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD0201261;
	Fri, 14 Mar 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbrREaYE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09B200132
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964831; cv=none; b=XlzZBmFrKM4aebgmc6ZvbIiiRkvj8XNTLIB+BwfCHL3eh0arR/tiNtAbHyKy6zOti+HA4sGo0X+oa5SkqgoPX9yV2pDs3r+GTH7Lywf0hNU5YV8+TJGPNeYOc0Ewx/OnVX9AeEehMvndOD8J/KLThukwi3n2CnYkn3I2dGwAHas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964831; c=relaxed/simple;
	bh=sJLeBuGvwZPCRgRoqF1poNdktXHv+fF6Kpyzh6hyzno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dr6snhgdDL5rk7lexdh63prIP5w6dd8KqfxcCBe3M/zatY815P8ZWI64vbdKWEVU1QYd69DGt4DP88ygohUWxuvvZxNmO6V99QEW3qtFb0grM5Lhq6v9mzJr8XqajH+pgx2aYlh7E7Pj8xov0+5pxu+p0XGa7/7mZbQywa+AR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbrREaYE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741964828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w+rX8sLBoLqwgm6ggmdeXPxqg6ljE9ON3jRGhrKcK/c=;
	b=QbrREaYElSBTpVM81CjTR6K3jaSr32ML3BqJs1L3yuX1ZxPCvQS5X66iVmQhZbw145NKhJ
	VWKSocpwq2Wb9pSpda3VGTzpZ/uY9tiTloN7Mn+usfebX0/+Dw9M5b+AYR0U/+Bu9Kaanp
	LItxtaOYAzCHT93MxcfG+l94H+3FfwI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-G0TyiEOMO6-Hdl-WvMWeWg-1; Fri, 14 Mar 2025 11:07:04 -0400
X-MC-Unique: G0TyiEOMO6-Hdl-WvMWeWg-1
X-Mimecast-MFC-AGG-ID: G0TyiEOMO6-Hdl-WvMWeWg_1741964823
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac287f28514so212485466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964823; x=1742569623;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+rX8sLBoLqwgm6ggmdeXPxqg6ljE9ON3jRGhrKcK/c=;
        b=f9zTNV7JbNjGaqy2oDwi0N5pvd4sGBxD7s6enaTVZlVH7OusROfDprNlje0+sQKJew
         cLWsHYi6hjuzTqV/9C4wmpbTASEwH/9HNyJwyozgOHT7z3/92EL3kvg++4MX0f2LTnHd
         wM7kn31lIRgzbO83Vzbw/jnjU0bHOWBBj8d4cInB8fdD4C1UMWm/Id4dpCX0FiUqzodj
         Rqe9lE5RnsYQHmH4iIFEyI5zy8DZUvjpwdEf/ENBYO4FtSomuXt08zn8VAlrBB1ZKqm9
         K4vMqrGy13jb7dBreDQZ/RkbX6kdo8tjmbmHh0LuesiHi4FzrfXeXf29Pk89yPFFwUGs
         oERw==
X-Gm-Message-State: AOJu0Yyen/1pZLILEEWgcBLTpL1mKN86aQSkb5FXVYmlrTawmvZ/sMVH
	+6C4M5PjHjGXI+wS/7B/7WVkWVvRT+3tGU3RtnRdWGEadqzfDC2rybQMG8vc6Kr9zwcP18c4D2z
	Ivofdxsfu8wnO64+7tYkiAM95sswuzXAO9FGGL2fJ/c9TMdTMNda/izn7Pz2+Rg==
X-Gm-Gg: ASbGnctcUMxcEA+GfSqjB8YfnVk9lU63Sx6s620CRFx++mj4QhiIGa2DHzQS9D3zjIK
	o2J0JaBJMU+3RLQmvlRI0BcHCc7KMIOwzTHicl05hj3O/JpIIOUg9UNQfRPfE1uGw8VgOe7eEyg
	Oi+0t6SvAovZ+Mwfdpz3EmTnxnCWpURMQr6ljoHNxfCPF8bra6VKuJIOLSKutI5Lk+udwF7HcrM
	VzrW9inmIEvlCYJ8V/DKxSF03WFw2cvPmuRhJHBghUuD+gofbKei9Q0jH2OpYJF2em8t91YWSVd
	t2JV7thQofae4m63lNpQ+A==
X-Received: by 2002:a17:907:9281:b0:abf:49de:36de with SMTP id a640c23a62f3a-ac330108ae9mr389746766b.1.1741964823146;
        Fri, 14 Mar 2025 08:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv3yXbg91jrMnmT82WQ9ZPMV3M6T+c8Q0TlFzgSgulAU4LUdCAOG3A2FJOSRB/FpAdyRdzkQ==
X-Received: by 2002:a17:907:9281:b0:abf:49de:36de with SMTP id a640c23a62f3a-ac330108ae9mr389741566b.1.1741964822725;
        Fri, 14 Mar 2025 08:07:02 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3147ed1e4sm238196566b.66.2025.03.14.08.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 08:07:02 -0700 (PDT)
Message-ID: <2fd1f956-3c6c-4d96-ad16-7c8a6803120c@redhat.com>
Date: Fri, 14 Mar 2025 16:07:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Provide a capability to disable APERF/MPERF
 read intercepts
To: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250225004708.1001320-1-jmattson@google.com>
 <CALMp9eRHrEZX4-JWyGXNRvafU2dNbfa6ZjT5HhrDBYujGYEvaw@mail.gmail.com>
 <Z9Q2Tl50AjxpwAKG@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z9Q2Tl50AjxpwAKG@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/25 14:59, Sean Christopherson wrote:
> On Thu, Mar 13, 2025, Jim Mattson wrote:
>> On Mon, Feb 24, 2025 at 4:47 PM Jim Mattson <jmattson@google.com> wrote:
>>>
>>> Allow a guest to read the physical IA32_APERF and IA32_MPERF MSRs
>>> without interception.
>>>
>>> The IA32_APERF and IA32_MPERF MSRs are not virtualized. Writes are not
>>> handled at all. The MSR values are not zeroed on vCPU creation, saved
>>> on suspend, or restored on resume. No accommodation is made for
>>> processor migration or for sharing a logical processor with other
>>> tasks. No adjustments are made for non-unit TSC multipliers. The MSRs
>>> do not account for time the same way as the comparable PMU events,
>>> whether the PMU is virtualized by the traditional emulation method or
>>> the new mediated pass-through approach.
>>>
>>> Nonetheless, in a properly constrained environment, this capability
>>> can be combined with a guest CPUID table that advertises support for
>>> CPUID.6:ECX.APERFMPERF[bit 0] to induce a Linux guest to report the
>>> effective physical CPU frequency in /proc/cpuinfo. Moreover, there is
>>> no performance cost for this capability.
>>>
>>> Signed-off-by: Jim Mattson <jmattson@google.com>
>>> ---
> 
> ...
> 
>> Any thoughts?
> 
> It's absolutely absurd, but I like it.  I would much rather provide functionality
> that is flawed in obvious ways, as opposed to functionality that is flawed in
> subtle and hard-to-grok ways.  Especially when the former is orders of magnitude
> less complex.
> 
> I have no objections, so long as we add very explicit disclaimers in the docs.
> 
> FWIW, the only reason my response was delayed is because I was trying to figure
> out if there's a clean way to avoid adding a large number of a capabilities for
> things like this.

True but it's not even a capability, it's just a new bit in the existing 
KVM_CAP_X86_DISABLE_EXITS.

Just one question:

> -       u64 r = KVM_X86_DISABLE_EXITS_PAUSE;
> +       u64 r = KVM_X86_DISABLE_EXITS_PAUSE | KVM_X86_DISABLE_EXITS_APERFMPERF;

Should it be conditional on the host having the APERFMPERF feature 
itself?  As is the patch _does_ do something sensible, i.e. #GP, but 
this puts the burden on userspace of checking the host CPUID and 
figuring out whether it makes sense to expose the feature to the guest. 
It would be simpler for userspace to be able to say "if the bit is there 
then enable it and make it visible through CPUID".

Paolo


