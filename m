Return-Path: <linux-kernel+bounces-355083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFE9946FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E014828884E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F161D0F76;
	Tue,  8 Oct 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h63EiEiG"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564CE1CF5CB;
	Tue,  8 Oct 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386996; cv=none; b=jr/oR9Mm31eK41yIjHitJlncAXSmF58MVOpTqLdGeQftEAkxq69n4mzKgB4cyHrpThBGjmzKsLecA1T4cLQJBzP7mwmpXfU63zb7xF3FXZjz6sDUlbtS3QgxXvKd2DVXo6hhOZ+63mg84c209eQaLwhxNYezjEMW8rJqKA3Up2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386996; c=relaxed/simple;
	bh=XEhL8B9ZHZuqa9Rf1wGdDBWMg1qSW0HJ0qprBF2S6SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQQndNMiRltzAJHnWaqot/spJGiutxizQEnNX08jKTyKZiRCHro7p7jGoZYut4tw5ey4FhM23DJMohJ8xHeFRGr5ZfRUbwPpddq8mZYjhDcsxLrvg5cRQ39ja3lonk3VVCMYWYIFsCbZHRNM2U0k7VFrY0xn0Icvd4KJ7xAsgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h63EiEiG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2faccccbca7so46111431fa.2;
        Tue, 08 Oct 2024 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728386991; x=1728991791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCEhIjy0Ii63KqQAZHvelDsiL973f6b2g+RCeAuEfC0=;
        b=h63EiEiGAYpcns5+uRxIFGAnKbMGu3RW7FQnw31cqE/KGHnY85MfS+h9jgk2lFkIu8
         0kp5cdhuW0N/7j1cWbD/gKTgGTUnJ52p54DZ8YYrUWabZwZ5+aoZ/3Y83xQH8fX5aAH3
         melVzjKY0U2iI96YN2TZsA8tJ0NFPamaXkF+PFVDUuMVoagijZTWPivqsqqKWJXDfLkB
         wrangaJ11as1UoEXKb0qAYi8CHJjFaO1qoP0/2Hg9r/Kp53tQMTeGe5b5S0OzhwYa057
         ImMDED/yVAknH3Ipo6vnr75klTvvV1M1Nw85/sD94+4dve8G1iajHRvBZU+jBGJm5eq8
         FDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728386991; x=1728991791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCEhIjy0Ii63KqQAZHvelDsiL973f6b2g+RCeAuEfC0=;
        b=k/BnjwsQJGvVtLArAPkES2dHBTPzDx8mvZQcEH7jo+67++eMn6Mf9cVshP1Z9guKKn
         SRD7Z3wubiY3J8eA3DMYx2TP8z2e03vN7WszxdITQGiXeOj8irtbn6931Ir7SDhWMUXy
         FP03d5loG66IEnvFKBIegDazav+Ystp/sapw+v0I+shbxNHRTqh8Xq0WO9a1Rl1lQVyB
         VhmCoCNnzXYj/E3kT6h2AtzyRYTVv3M0JBPFPojN1sCauC/gv4xZZ871ZP+05pItm4QZ
         cD1F84zpaMunfVut0FaipcNu2z3aUtt0u6Ia6c4dpPdAT0d/DNlZHvIGXjT+l71AcpMY
         xfug==
X-Forwarded-Encrypted: i=1; AJvYcCXINXn3YX34+bMicRlE0p/s/tbyP0BKZPjif41bSgJORurCvLQd5x+/ArI4dvphEbYqXY9rliYNQkRCF/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4L45d9kpUSePyr8Jd+d9B7+LSEXD27W4pMszypsyeSMRU495
	PawPAVz5VZsOtVC1EIcnhoLXFKYBGPOPKILsY0O6coQCsLkMpat9
X-Google-Smtp-Source: AGHT+IFyAFlz0t4sEhcN2s8NpOd1BOKvqa0rMuf5AziHq0Kvxjkh3fQEyC1zsCJyeaBsQ+nrwoxFPg==
X-Received: by 2002:a2e:9145:0:b0:2fa:bb65:801a with SMTP id 38308e7fff4ca-2faf3d72559mr61086401fa.26.1728386991072;
        Tue, 08 Oct 2024 04:29:51 -0700 (PDT)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9ab0767sm11490101fa.14.2024.10.08.04.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 04:29:49 -0700 (PDT)
Message-ID: <2b56118d-a0f1-470e-9e36-65811a87a177@gmail.com>
Date: Tue, 8 Oct 2024 14:29:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: page: replace the page pointer wrapper with
 Opaque
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, dakr@redhat.com,
 linux-kernel@vger.kernel.org, lyude@redhat.com, airlied@redhat.com,
 miguel.ojeda.sandonis@gmail.com
References: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
 <20241007202752.3096472-2-abdiel.janulgue@gmail.com>
 <CAH5fLggkpELOx2mfz32d2C0xE_aSWs3GQHAkufq5H=30xB3MUQ@mail.gmail.com>
 <ZwTZlqHMhexdkXJ7@boqun-archlinux>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <ZwTZlqHMhexdkXJ7@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/10/2024 10:04, Boqun Feng wrote:
> On Tue, Oct 08, 2024 at 08:58:56AM +0200, Alice Ryhl wrote:
>> On Mon, Oct 7, 2024 at 10:28 PM Abdiel Janulgue
>> <abdiel.janulgue@gmail.com> wrote:
>>>
>>> Replace NonNull with Opaque to make it possible to cast to a Page pointer
>>> from a raw struct page pointer.
>>>
>>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>>> ---
>>>   rust/kernel/page.rs | 19 +++++++++++++------
>>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
>>> index 208a006d587c..08ff09a25223 100644
>>> --- a/rust/kernel/page.rs
>>> +++ b/rust/kernel/page.rs
>>> @@ -8,8 +8,9 @@
>>>       error::code::*,
>>>       error::Result,
>>>       uaccess::UserSliceReader,
>>> +    types::Opaque,
>>>   };
>>> -use core::ptr::{self, NonNull};
>>> +use core::ptr::{self};
>>>
>>>   /// A bitwise shift for the page size.
>>>   pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
>>> @@ -25,8 +26,9 @@
>>>   /// # Invariants
>>>   ///
>>>   /// The pointer is valid, and has ownership over the page.
>>> +#[repr(transparent)]
>>>   pub struct Page {
>>> -    page: NonNull<bindings::page>,
>>> +    page: Opaque<bindings::page>,
>>>   }
>>>
>>>   // SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
>>> @@ -65,15 +67,20 @@ pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
>>>           // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
>>>           // is always safe to call this method.
>>>           let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
>>> -        let page = NonNull::new(page).ok_or(AllocError)?;
>>> +        if page.is_null() {
>>> +            return Err(AllocError);
>>> +        }
>>> +        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::page`.
>>> +        let ptr = page.cast::<Self>();
>>>           // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
>>>           // allocated page. We transfer that ownership to the new `Page` object.
>>> -        Ok(Self { page })
>>> +        // SAFETY: According to invariant above ptr is valid.
>>> +        Ok(unsafe { ptr::read(ptr) })
>>
>> Using `ptr::read` on the page is definitely not okay. That duplicates
>> the contents of the `struct page`. You'll need some sort of pointer
>> type around `Page` instead.
>>
> 
> Agreed. So may I suggest we introduce `Owned` type and `Ownable` trait
> [1]? `alloc_page()` can be refactor to return a `Result<Owned<Self>,
> AllocError>`.
> 
> [1]: https://lore.kernel.org/rust-for-linux/ZnCzLIly3DRK2eab@boqun-archlinux/

Thanks for the feedback. How do you propose we move forward, do I take a 
stab at implementing `Owned` type and `Ownable` trait?

Regards,
Abdiel


> 
> Regards,
> Boqun
> 
>> Alice
> 

