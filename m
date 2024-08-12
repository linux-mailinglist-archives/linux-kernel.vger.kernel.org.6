Return-Path: <linux-kernel+bounces-283136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEDF94EDBC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4120B1C21461
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED76D17BB33;
	Mon, 12 Aug 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBvfTgvr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2CF170A1C;
	Mon, 12 Aug 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468082; cv=none; b=XB2hhliNlI0M2515e/s5EiSk3o5VeyaaKCxd3tLdoq6SDIKXl0E8h3a9SwDUduxUwVBHUDt70OaTA3tCVOdwsYjUsiopBMyzBXxY5XhxlVyjFUACtOId1ufRfzFfAQBGru93is92+TYqiU2MKzIv63GDVTRVXWMhwrdj4mQg2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468082; c=relaxed/simple;
	bh=mNOmgZvssvqvOmmQmFvMAXtyfF1xbPceHUTYeWaEFTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYR9qqisl+P92j1hcylBVUuhdI+Ziln2r+cdVRI44Y1Bs+j0tcXzseSi7miSYxh/PQDnbd/6neogo301Hqthktnj0KKyrAR6eqQu3aqsHyqIVh2yI+ADmjoNRGCFGutUTzhh2bwKzZyV9qao32hMEMqSybNDE+EcRaYJ0mdJE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBvfTgvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC35C32782;
	Mon, 12 Aug 2024 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723468081;
	bh=mNOmgZvssvqvOmmQmFvMAXtyfF1xbPceHUTYeWaEFTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qBvfTgvrGP/vxPP3bkzuGEF/AgYxIw2GfAVRf2qWOtXZC+C0NjR2RjCu52v7X6XEW
	 sm6pnpg3pBT/1qL4iyQ1uo2PAxAEtwiYJuei6xT8RZKceKDpz/hEIPqyP0SasP5adV
	 CAAdGnHEJfuMfQUNTtmC6W/D+Y/ZGEnwh5hlzALYDY/6wFmP7zvJ+YWO/Osbwu8BvU
	 zOcOQ9bkCDtHTHVACY2aohYLWJztM5FkdPNIhIlL6DHKGiyP/o5GQdxaH3gWV0Z5j9
	 tfrt2JcduLBBjDDekTNB8soSdZ6rOqPzpl8mKG9iPf7YQNVdCzaEjoAstOE++3IAgC
	 BtdyGCciRl7jg==
Message-ID: <d7e43b0d-e76e-4a23-9225-261ca1484b02@kernel.org>
Date: Mon, 12 Aug 2024 15:07:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/28] rust: str: test: replace `alloc::format`
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
 airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-mm@kvack.org
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-27-dakr@kernel.org>
 <51d38447-9906-42fd-9e5e-b43983d3a366@proton.me>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <51d38447-9906-42fd-9e5e-b43983d3a366@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 9:22 AM, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
>> The current implementation of tests in str.rs use `format!` to format
>> strings for comparison, which, internally, creates a new `String`.
>>
>> In order to prepare for getting rid of Rust's alloc crate, we have to
>> cut this dependency. Instead, implement `format!` for `CString`.
>>
>> Note that for userspace tests, `Kmalloc`, which is backing `CString`'s
>> memory, is just a type alias to `Cmalloc`.
>>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>   rust/kernel/str.rs | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index 0b6ffbade521..8f234224cbf5 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -523,7 +523,28 @@ macro_rules! c_str {
>>   #[cfg(test)]
>>   mod tests {
>>       use super::*;
>> -    use alloc::format;
>> +
>> +    struct String(CString);
>> +
>> +    impl String {
>> +        fn from_fmt(args: fmt::Arguments<'_>) -> Self {
>> +            String(CString::try_from_fmt(args).unwrap())
>> +        }
>> +    }
>> +
>> +    impl Deref for String {
>> +        type Target = str;
>> +
>> +        fn deref(&self) -> &str {
>> +            self.0.to_str().unwrap()
>> +        }
>> +    }
> 
> Don't actually think we need this newtype.

Right, but I thought it's a bit more extensible and cleaner than...

> 
>> +
>> +    macro_rules! format {
>> +        ($($f:tt)*) => ({
>> +            &*String::from_fmt(kernel::fmt!($($f)*))
> 
> We could just do this:
> 
>      CString::try_from_fmt(kernel::fmt!($(f)*)).unwrap().to_str().unwrap()

...doing it inline.

I'm fine either way, but unless you really want me to change it, I'd
rather keep it as it is.

> 
> ---
> Cheers,
> Benno
> 
>> +        })
>> +    }
>>
>>       const ALL_ASCII_CHARS: &'static str =
>>           "\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\x08\\x09\\x0a\\x0b\\x0c\\x0d\\x0e\\x0f\
>> --
>> 2.45.2
>>
> 

