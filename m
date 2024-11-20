Return-Path: <linux-kernel+bounces-416395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045A39D4439
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC5B1F22C59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E61D14F3;
	Wed, 20 Nov 2024 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWk8ijDO"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E32E1CEAA7;
	Wed, 20 Nov 2024 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143405; cv=none; b=BCr/NyuYb+Gb0FvfxKquwm9GkKE0isjTrEKDERitv/hd/TLUpISuPl29gBLLBZKzfAcc6rD41H6cgS1z20Vs4bWZ4SuoT9Aa+AamRxHb8J8iB3wXUcj42YznTc5A5t9bxlM6SRtwN96UQsnZbwRAUBqyjjVuh+7pGG3SFcfPo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143405; c=relaxed/simple;
	bh=mThbCVsQUikN0Qj55mhMtmameID94x2xR0dsg6JSMug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2uL48tZlL32ZJoHAvamg5NoZkkubYTIz2GbaQxym9uhdYS7/LDrII7dH/MMtfPvvQ5WpeGcE3Jr46SzN213I997tLAJlzKRZBfuML+XCtlOV8VDElJjMEj3ToMJtdi2pWn+jQuTXLE15X8t+Bkvrla2kY86cWtwzAckat9cn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWk8ijDO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53da22c5863so288933e87.0;
        Wed, 20 Nov 2024 14:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732143401; x=1732748201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ro93jIqOY0loyc53cQE01JI74xq0pgbp0jULr1LtQ5A=;
        b=gWk8ijDOZrQnx1r0rKMJMoNniJYLB5GeD1Z8ZL6TS5QVkNWRYBkomMwQqjocMNvadq
         SuToN1yMKeUT5KctRMRVqkDVIoV9wRlSCiDHiC6vyGvnRJW4HH2V++xJh3ePVOXl2DnJ
         Y0PBqTxef7wagmdU5Ta8Ge1QFZPRqhFnTKMhh21mdiSqMHnnm5mUrtK+TbE90S+KXt5H
         dHlitx34mPFRbgm3kr+xb/so2sAfDKJCeW9tixOKIIekkP9kVELwROmP/wZatb5Lyxnl
         +MH65XQNN6D+3FZugqqGNTjoojyMeNOBpQ5loWus0Sk8Z6W5MQR7k0OpAOvLcVLCYsIq
         wYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732143401; x=1732748201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ro93jIqOY0loyc53cQE01JI74xq0pgbp0jULr1LtQ5A=;
        b=h+VCZO0dRUvGpRBzjLhCRebADeRPsbIzaDifwtiXHg/B9l3rCzwA40TB1fhfIjam7p
         RI20B1S8bjouY2MBUlxrA5wFe54M7bWjlPjYQ5iEX/qtrJYaYbc/Ba+omMPjPmg9FpdH
         P/fJE1opJtMoUtbo8CtkKw+yJ2bXgsBsFSeUNlU6Tm3nuJqj+aw6P+oVOd0JJYyj5KMu
         xZ5xpmLjQzuLhO6I3f7kUNNcoTGbFm7TlaToPcQU5lVvKmd2gg76fJidsZ3hh5aUJVkM
         lLn5vCuMiAnhEYgOt/sRWGxLo45NqA/UKW/7dWcphmNRJWUeApALyZ3v9g+R7zcjxYJP
         mvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDw6JZsPJ17OFAnjaZNwWGHShuHlI7k70Yvt+wypzaYGAW0+V066enHCKQ2x184Wq3+L6FapFg0Y1HimA=@vger.kernel.org, AJvYcCXsfQFYXE9G+KpNl68+f3Eh9SzDh35CK9Sl7Vrl1wzLHHhQA7ohWajZHU0K41e1Zn3xLY1HfX/FW5h9za1tc3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4VUtH42OCekTeivGEaAcOBBHie/qkZOGvIt2kn9XzZnjp/+w
	1F8Wf2sD+3/VD2NnPTlTBpe6Kwvz/WgNzT27Iyua7526zaRSomya
X-Google-Smtp-Source: AGHT+IF/5dP9tu2MCNl0giVhpvfxpp+VR6EDt2BSIi+BHBODzFNFCogG8QaW7BLqsCAzbPFydNBiXA==
X-Received: by 2002:a05:6512:b81:b0:53d:a5c8:aaa6 with SMTP id 2adb3069b0e04-53dc1339b3fmr1922610e87.13.1732143401364;
        Wed, 20 Nov 2024 14:56:41 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3ee4a3sm775318e87.12.2024.11.20.14.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 14:56:40 -0800 (PST)
Message-ID: <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
Date: Thu, 21 Nov 2024 00:56:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
To: Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local> <Zz4WFnyTWUDPsH4m@casper.infradead.org>
 <Zz4boXyYpdx4q35I@tardis.local>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <Zz4boXyYpdx4q35I@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/11/2024 19:25, Boqun Feng wrote:
> On Wed, Nov 20, 2024 at 05:02:14PM +0000, Matthew Wilcox wrote:
>> On Wed, Nov 20, 2024 at 08:20:16AM -0800, Boqun Feng wrote:
>>> On Wed, Nov 20, 2024 at 10:10:44AM +0100, Alice Ryhl wrote:
>>>> On Wed, Nov 20, 2024 at 5:57 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>>>
>>>>> On Tue, Nov 19, 2024 at 01:24:01PM +0200, Abdiel Janulgue wrote:
>>>>>> This series aims to add support for pages that are not constructed by an
>>>>>> instance of the rust Page abstraction, for example those returned by
>>>>>> vmalloc_to_page() or virt_to_page().
>>>>>>
>>>>>> Changes sinve v3:
>>>>>> - Use the struct page's reference count to decide when to free the
>>>>>>    allocation (Alice Ryhl, Boqun Feng).
>>>>>
>>>>> Bleh, this is going to be "exciting".  We're in the middle of a multi-year
>>>>> project to remove refcounts from struct page.  The lifetime of a page
>>>>> will be controlled by the memdesc that it belongs to.  Some of those
>>>>> memdescs will have refcounts, but others will not.
>>>>>
>>>
>>> One question: will the page that doesn't have refcounts has an exclusive
>>> owner? I.e. there is one owner that's responsible to free the page and
>>> make sure other references to the page get properly invalidated (maybe
>>> via RCU?)
>>
>> It's up to the owner of the page how they want to manage freeing it.
>> They can use a refcount (folios will still have a refcount, for example),
>> or they can know when there are no more users of the page (eg slab knows
>> when all objects in a slab are freed).  RCU is a possibility, but would
>> be quite unusual I would think.  The model I'm looking for here is that
>> 'page' is too low-level an object to have its own lifecycle; it's always
>> defined by a higher level object.
>>
> 
> Ok, that makes sense. That's actually aligned with the direction we are
> heading in this patch: make `struct Page` itself independent on how the
> lifetime is maintained. Conceptually, say we can define folio in pure
> Rust, it could be:
> 
>      struct Folio {
>          head: Page, /* or a union of page */
> 	...
>      }
> 
> and we can `impl AlwaysRefcounted for Folio`, which implies there is a
> refcount inside. And we can also have a `Foo` being:
> 
>      struct Foo {
>          inner: Page,
>      }
> 
> which doesn't implement `AlwaysRefcounted`, and that suggests a
> different way the page lifetime will be maintained.
> 
>>>>> We don't have a fully formed destination yet, so I can't give you a
>>>>> definite answer to a lot of questions.  Obviously I don't want to hold
>>>>> up the Rust project in any way, but I need to know that what we're trying
>>>>> to do will be expressible in Rust.
>>>>>
>>>>> Can we avoid referring to a page's refcount?
>>>>
>>>> I don't think this patch needs the refcount at all, and the previous
>>>> version did not expose it. This came out of the advice to use put_page
>>>> over free_page. Does this mean that we should switch to put_page but
>>>> not use get_page?
>>
>> Did I advise using put_page() over free_page()?  I hope I didn't say
> 
> We have some off-list discussion about free_page() doesn't always free
> the page if you could remember.
> 
>> that.  I don't see a reason why binder needs to refcount its pages (nor
>> use a mapcount on them), but I don't fully understand binder so maybe
>> it does need a refcount.
> 
> I don't think binder needs it either, but I think Abdiel here has a
> different usage than binder.
> 
>>
>>> I think the point is finding the exact lifetime model for pages, if it's
>>> not a simple refcounting, then what it is? Besides, we can still
>>> represent refcounting pages with `struct Page` and other pages with a
>>> different type name. So as far as I can see, this patch is OK for now.
>>
>> I don't want Page to have a refcount.  If you need something with a
>> refcount, it needs to be called something else.
> 
> So if I understand correctly, what Abdiel needs here is a way to convert
> a virtual address to the corresponding page, would it make sense to just
> use folio in this case? Abdiel, what's the operation you are going to
> call on the page you get?

Yes that's basically it. The goal here is represent those existing 
struct page within this rust Page abstraction but at the same time to 
avoid taking over its ownership.

Boqun, Alice, should we reconsider Ownable and Owned trait again? :)

Regards,
Abdiel

