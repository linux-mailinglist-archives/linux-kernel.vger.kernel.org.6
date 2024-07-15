Return-Path: <linux-kernel+bounces-252390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A56F931280
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67EE5B227B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04225188CB9;
	Mon, 15 Jul 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2Qwyila"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5AC41C71
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040247; cv=none; b=RevcD27X4ZmJr8QzJR5/TW9oPnz4ibJSHrzVqALNjb7G8b0LbitfRmOh5evsIyG1ucF7ByODFx+EJVKmH/wK+bhc/OJv24Tiu3bJ2fWzdCyjoS5veU18GV3ZL2jhy1Iioo+MW0EvWY5tciRvBAWuZmqIawjJUJeeUQPhtaf1Kk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040247; c=relaxed/simple;
	bh=XMXUsVqA3WkYY2uXqSIqKh4XNGjjobx5UJJk1PrkZ+8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uNQwTI6MaqQ1yeicMs6PltATlQfGDqXhHkk8erc1fCj7//1IYpPCtgWC0chQwZ5gn5wT8vsiuit++Vmx/oDiaHjw4kDSZ4Ue2AoJ7+7j1PRhJQ1JiUKl88yJ6p9Hc91eO8XiVclTbLBuw4LZpiPNm+uAkru+e4aYg3y8FNQhbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2Qwyila; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721040244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VDMt6BhM03zaBmAW1YFT8GRu72U5uXIitRTt4yVWtY=;
	b=f2Qwyila8Ylu1t/Dg5xB4Y1EXssxxxWy1Ka58fa8T7oWPErV46NCbCbAmD3xH6woPcNKC/
	IhwhfsES/SVFKf0fNp7lHolD14ks9vWyT3JTZZeGByTq9usD4OSMYPFTun/HPVjdaJHaP9
	kLD3zPhULX29UKAVHf1HcOJxPhe4w8I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-7KY0g8lcPyGUl57h6vWCzA-1; Mon, 15 Jul 2024 06:44:03 -0400
X-MC-Unique: 7KY0g8lcPyGUl57h6vWCzA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b5f559b8c8so92886936d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721040242; x=1721645042;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VDMt6BhM03zaBmAW1YFT8GRu72U5uXIitRTt4yVWtY=;
        b=XEIKD4Fi3AXwUSlp6Ozl4hc87FbZ0DqqFVMlR2MKAUnPqUP9ahB2bngBaIxCJbLMih
         b6fg0ddeI8DXMaMp/1E7qsoNU/Ni3ri22bd8Zy9ssXep1Qi2T68HpptnvXvTal7Nb6Nj
         20G7nhB0B6Xnos++z0AtrbFrK3+QOv5EzPfNN6dWSaHLjtO+VeWN2ugcyEvv4gfo9UL4
         CgbCVhzDxZZCgHttlnK9uVTJL6mWuCdksSWiuRmRhtYWfGeOVzlc2RPJOHdGSH+sLDh8
         6QNmXngcQEKfsUlwfqWQNBUsk+rxAHqbkml6m5jUA5P63PjSvC3cn7ZBUmRGvEGKRCYN
         6GWg==
X-Forwarded-Encrypted: i=1; AJvYcCXBRVQ/s51M9Nm/Z7rHUIoOm8SM0bkj+g3CoCjSnuZnY1I9f2mlqv5z0XvJRqPqqmuhzs5Oj9o6SQmwXBZskZYO8RzKLBxvmb2+idza
X-Gm-Message-State: AOJu0Yw6MUJRmokgdmTUwfZoq7KnSDsqYGnJhAk43NCiJIE2ze2wGNJX
	CKUIenptAmWL9okWC13pOZEVAVNbllAVxISHCJGnPLH4s9Gp/Wad6CPRCAeMwt1TRLwKKTry1mc
	rFU5TAVsyLxZs27rl8i8pXqcskFjPi0akKWHpf3OvspYyIxd4PVvvsylK33ipKg==
X-Received: by 2002:ad4:596d:0:b0:6b5:2be1:cd6e with SMTP id 6a1803df08f44-6b754b6be33mr172946286d6.4.1721040242543;
        Mon, 15 Jul 2024 03:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrz3doHdIu7jIfoH+wiwb6f5b4GbXN3svlFADmcupRvZiDKcsGzoKyXQkY2C/ZlEeQe0uF7Q==
X-Received: by 2002:ad4:596d:0:b0:6b5:2be1:cd6e with SMTP id 6a1803df08f44-6b754b6be33mr172946076d6.4.1721040242215;
        Mon, 15 Jul 2024 03:44:02 -0700 (PDT)
Received: from rh (p200300c93f45e50062e5f8c654844c9a.dip0.t-ipconnect.de. [2003:c9:3f45:e500:62e5:f8c6:5484:4c9a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761957786sm20124196d6.14.2024.07.15.03.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:44:01 -0700 (PDT)
Date: Mon, 15 Jul 2024 12:43:58 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
    kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
    Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 1/3] KVM: arm64: fix override-init warnings in W=1
 builds
In-Reply-To: <ZpTtTQ-ysRGw2tZG@J2N7QTR9R3>
Message-ID: <d3bd266c-922f-d1b6-5b14-edd892ad7fd1@redhat.com>
References: <20240712110332.10970-1-sebott@redhat.com> <20240712110332.10970-2-sebott@redhat.com> <8734oep96j.wl-maz@kernel.org> <ZpTtTQ-ysRGw2tZG@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 15 Jul 2024, Mark Rutland wrote:
> On Fri, Jul 12, 2024 at 10:55:16PM +0100, Marc Zyngier wrote:
>> On Fri, 12 Jul 2024 12:03:30 +0100,
>> Sebastian Ott <sebott@redhat.com> wrote:
>>>
>>> Remove double initializations in cases where that's easily possible
>>> - like extra NULL initialization in static global structures. In the
>>> other cases just silence -Woverride-init.
>>>
>>> To fix warnings like the following:
>>> arch/arm64/kvm/hyp/vhe/switch.c:271:43: warning: initialized field overwritten [-Woverride-init]
>>>   271 |         [ESR_ELx_EC_CP15_32]            = kvm_hyp_handle_cp15_32,
>>>       |                                           ^~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>>> ---
>>>  arch/arm64/kvm/handle_exit.c     | 5 +++++
>>>  arch/arm64/kvm/hyp/nvhe/switch.c | 6 ++----
>>>  arch/arm64/kvm/hyp/vhe/switch.c  | 3 +--
>>>  arch/arm64/kvm/sys_regs.c        | 5 +++++
>>>  4 files changed, 13 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>>> index d7c2990e7c9e..2c049746657c 100644
>>> --- a/arch/arm64/kvm/handle_exit.c
>>> +++ b/arch/arm64/kvm/handle_exit.c
>>> @@ -291,6 +291,9 @@ static int handle_svc(struct kvm_vcpu *vcpu)
>>>  	return 1;
>>>  }
>>>
>>> +__diag_push();
>>> +__diag_ignore_all("-Woverride-init", "Allow field overrides in exit_handlers");
>>
>> The wording you are looking for is "Silence stupid warning". I really
>> mean it. There is really nothing wrong with this code, and if the
>> compiler doesn't understand the purpose of a default initialiser, then
>> *maybe* it should be fixed rather than polluting the kernel with this
>> stuff.
>
> IMO this would be a lot more palatable if this were an attribute on the
> struct or assignment, like we asked for in the past:
>
>  https://lore.kernel.org/lkml/20190809083251.GA48423@lakrids.cambridge.arm.com/
>
> Having something that we could put specifically on the default assignment would
> make this a lot more legible and better capture the intent.

Yea, I double checked in the gcc doc - there seems to be no other means to
silence this per var or assignment. We can disable that in the makefile
for the whole file or dir or we keep it as it is.

Thanks,
Sebastian


