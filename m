Return-Path: <linux-kernel+bounces-211631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C169054A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C7D1C21DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414EC17FAAF;
	Wed, 12 Jun 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flqluAD5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898F17F514
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200793; cv=none; b=q4X771kVaIh93cpCQtlSi3fPOAsvZmr3NLOSr/OO6DX7qVVgPHF/wZ/mTiH0Yz4ikyLmmgSyzLQiS2D4UOFxsWDsBWMupJNKYti3s4FrgYWhZZDjybVbRXH5a7A3V0Jvae0DIi9sgAp3nfQmmfXW6tD/I12QJj93jv/sMGg2dsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200793; c=relaxed/simple;
	bh=LnL6vXABxodRA0g/3uUnvhhic5N3VDGXGX/xdceAgHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzV+/lokahlRLizLRU3muMQ7Au9qquoD311aQQPLsTTiPFPVG9tyfgTuPRRs+ksNodyveB2NdIhSvksM1VbiYkVcTNXfC/3y3pgpySntbSHpb+1WVZs74HUkehw/Z/K0pMXiljBNYVw2fmluAjZTq7fcvt/dc9ObEZx50ocEugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flqluAD5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718200790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+lgoZYSUH8a1r7cAFWJj8pD+hPUc4udC9LVoFE9F2E=;
	b=flqluAD5pZA8fEaodTEueQ2oKt6z0FaZvngIaLAyf8mUBGwwuYOvBkmQZVjlbR56nwIacE
	aB8OfLkSSUAg0OrGNdlbOVnlUCOZ5eviKAXb3Z+g8Zb3qfrt1dfREnnMOpqT0HrkMVLN+z
	vDqTprnL7CQxnxB9L9Yl0n+KdvOCWzI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-kVkSzBjwNZ2v8eGXgaSUnw-1; Wed, 12 Jun 2024 09:59:46 -0400
X-MC-Unique: kVkSzBjwNZ2v8eGXgaSUnw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42117a61bccso49970395e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200785; x=1718805585;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+lgoZYSUH8a1r7cAFWJj8pD+hPUc4udC9LVoFE9F2E=;
        b=VzUQNfVOVstbZNAQ+QKCej/1+FRsTuqyFbGyjQKCiTti9/CAIchWulN+cz1811VtUs
         GaCxZ61xYH4Mi7jAFcqRx5knnt8JeOlWLhCslqtvTEZTbBpnDIQmPf7p2hfTCWauHbB1
         lbZxB8i7AYrdiR2FJFwpmEtptmqSJWeEBcbZrOAEZpMWahPC/7Zl/uo3+ezW7pi3vEzQ
         OhrysLMZnjvArFw/D+7t+BoDyUUpbRXSH8DwTHwp0583k9gw8cS/irsAOy/7YwvFlQGR
         UuoMqGLnawaQ+VpE2nvK9jTOinzratCJc3eAMUYH8shubI0fUj9F0innaiuyoVYNnpZj
         dO2w==
X-Forwarded-Encrypted: i=1; AJvYcCUfeUJtaQ/bIzRS7NRAseZ730PL7r6cOofNqHvtCTV4YSTYe/PERm/ZXwvJhlqKb23EA0GakMKdg/B8PmoK3PD+pLA5pN97RehHvjO8
X-Gm-Message-State: AOJu0Ywyqj0UKNF60PKM0hGc+ChzklR8xxTAxEHDIiJLTohfC4Yl8HPN
	Y4Aqw2+ddKxPD6/tXzebH+E9e2qTKlHsc5g+aq4pqvv9mU2wFtBIesNTNnU0m+GBFZb5h3lcEF0
	aW92dje0H2d2cecNrPQbNtiYYEXMMQxz6d2D6A0WTFcZ/NLCzkLoixZfWIq6eqw==
X-Received: by 2002:a05:600c:350f:b0:421:7aa1:435 with SMTP id 5b1f17b1804b1-422866bcd1amr18072865e9.25.1718200785529;
        Wed, 12 Jun 2024 06:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd2vyH6GtmeuAXkuJpdbwpHi6ddrSvmUfaRuvR9d+72lJ6HKDEGhZiKptTfeidD7H06+zUvA==
X-Received: by 2002:a05:600c:350f:b0:421:7aa1:435 with SMTP id 5b1f17b1804b1-422866bcd1amr18072605e9.25.1718200785207;
        Wed, 12 Jun 2024 06:59:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0e49e898sm12964745f8f.22.2024.06.12.06.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 06:59:44 -0700 (PDT)
Message-ID: <975fec7c-6abd-40c3-9eeb-b718960ee206@redhat.com>
Date: Wed, 12 Jun 2024 15:59:43 +0200
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

I think once we can detect it on compile time we should do that.

As for the might_sleep(), if we want to have this check, we should probably
do it in device_release() [1], rather than in the Rust code only.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L2557

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


