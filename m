Return-Path: <linux-kernel+bounces-211705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06E9055BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8BE2830FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7C17F392;
	Wed, 12 Jun 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKK+eTCM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083717F37A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203911; cv=none; b=Oj/rAfGpdf1ptWB5rv5mKluhcDB2lrymBIh1U5wWSuDovQXEsc2tUYaXrlD0cifYuUhAuLMduj+o0SNFiFYgsFENUVneoVTR/UBjYm28uf9wcSCUfqftnkl79EGUaN8V+qVm7nIV0LknZmHtRYiCyeKMdYobHpF3ocq2h1tgEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203911; c=relaxed/simple;
	bh=uQnPob09RXsb+k15cJ24zoa5K6h1QNmp6SDtPOiGCwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d60844IFqQVc7PiFABz7vk9+RdYyWdhtva41YAaLggMZYhWLrTSvcMa75u452g6T9TiSFIpdQ3raMxVukOKkl/lx3Xe0O7xmamEkJkwsrU4Q/5KDkGZyoslhG9UY89bqYRezPV7gstGL/KcQgW6JIM4w+cdlH1LsD59T2ezo5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKK+eTCM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718203908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVmTidelMG1PiYfixcVkCNJNOeFZsMw+GcpMsMjUemA=;
	b=fKK+eTCMktY8/OT/jreSyfik6twXjIWkeZwKMVUfy05lhV3Hd1vWgEGPwgFrltPVNFHdMx
	iraHV64Wf9wCbmel3I+OcTqJ1zfZk/csYfSC6Qi2i3FBEwvGK7vZbIdUYNXbogb+OQMIWU
	iFiIY59oBisK8hNGFGUVOu3aqy5SJfk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-hpAR25ixM8ayzx1X-aL49g-1; Wed, 12 Jun 2024 10:51:46 -0400
X-MC-Unique: hpAR25ixM8ayzx1X-aL49g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6f4af1c655so39791766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203905; x=1718808705;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVmTidelMG1PiYfixcVkCNJNOeFZsMw+GcpMsMjUemA=;
        b=DoaBw6MlyOwhEq7+A25mAQ+p4IkvKVzURCS+XDjGmOLxPyikGmmq1LR93D96hMMldY
         QjdeLqWQeGHqR1fAXxuwpNcgivBWozB7aY7WHmA2xVtC7LFPG+pKnwYfAAk7aLZHGjPp
         sNUfzHZb3oUQHqD0TPQ38syzJdUucnXi1W8+aRCJNHfxWeDgs9xHPrPRxHn0RAxL/pE6
         nllXiL6yBUqMHI6zMF1uAU9Cm5sBhQwHunzffaz2xmX1xnXb3psz29RND9E9pvG3DUpn
         JrstW4D6oCCS4uZQb3vgWtypJAz90N6klUfNeD/uqVBGzg0JyBi8YY3PZZAsTGtRRJ8D
         YykA==
X-Forwarded-Encrypted: i=1; AJvYcCXWWNfUBrY+9NCRzzesbe2VqAuHZbUYw/Wq9z3Hn+zLnGmiuGgvyWZWrFvQ0UTxFx08p7swXlkQIUpKRPHdGogDGBnXMChYOhJPn8pf
X-Gm-Message-State: AOJu0YyfMZ/A2J+aA9AkkqhF1cD6VjaQPrjRwigepbJnDVr0K4pYdgyG
	r0d4zmlxi5bmKhXM0n0lzPF5Y34J/R7QJDf1APj+WnDeyw8c/9v2DMkI2EPZF4txMo5OPotNJQ3
	EKqwKBBsiXT3qeF/uUS6Q299g9A/c247Ewc5b1jC4424jUj/1dYYVTNImKzbrhQ==
X-Received: by 2002:a17:907:7e87:b0:a6f:e36:abae with SMTP id a640c23a62f3a-a6f47ce6c8bmr168031266b.42.1718203905079;
        Wed, 12 Jun 2024 07:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbGf3kVGrfya669fPpWGOZYpQmZGTofto5bcgn7UtgXwLAm8zLWXejA536NlRPQkJg4vVVqg==
X-Received: by 2002:a17:907:7e87:b0:a6f:e36:abae with SMTP id a640c23a62f3a-a6f47ce6c8bmr168029066b.42.1718203904649;
        Wed, 12 Jun 2024 07:51:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f102c4494sm539231766b.112.2024.06.12.07.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:51:44 -0700 (PDT)
Message-ID: <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
Date: Wed, 12 Jun 2024 16:51:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: add abstraction for struct device
To: Boqun Feng <boqun.feng@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, mcgrof@kernel.org, russell.h.weight@intel.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, pstanner@redhat.com, ajanulgu@redhat.com,
 lyude@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-2-dakr@redhat.com> <ZmdID8AlXtoxUfC1@boqun-archlinux>
 <ZmhPW9yq7y6jbmIg@pollux> <2024061136-unbridle-confirm-c653@gregkh>
 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 18:13, Boqun Feng wrote:
> On Tue, Jun 11, 2024 at 03:29:22PM +0200, Greg KH wrote:
>> On Tue, Jun 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
>>> ...hence, I agree we should indeed add to the #Invariants and #Safety section
>>> that `->release` must be callable  from any thread.
>>>
>>> However, this is just theory, do we actually have cases where `device::release`
> 
> @Danilo, right, it's only theorical, but it's good to call it out since
> it's the requirement for a safe Rust abstraction.

Similar to my previous reply, if we want to call this out as safety requirement
in `Device::from_raw`, we probably want to add it to the documentation of the C
`struct device`, such that we can argue that this is an invariant of C's
`struct device`.

Otherwise we'd have to write something like:

"It must also be ensured that the `->release` function of a `struct device` can
be called from any non-atomic context. While not being officially documented this
is guaranteed by the invariant of `struct device`."

> 
>>> is not allowed to be called from any thread? If so, this would be very confusing
>>> for a reference counted type from a design point of view...
>>
>> What do you mean exactly "by any thread"?  Maybe not from interrupt
> 
> The `Send` trait here doesn't really differ between interrupt contexts
> and process contexts, so "by any thread", it includes all the contexts.
> However, we rely on klint[1] to detect context mismatch in compile time
> (it's still a WIP though). For this case, we would need to mark the
> `Device::dec_ref` function as might sleep.
> 
> Regards,
> Boqun
> 
> [1]: https://rust-for-linux.com/klint
> 
>> context, but any other normal thread (i.e. that you can sleep in), it
>> should be fine to call release() in.
>>
>> thanks,
>>
>> greg k-h
> 


