Return-Path: <linux-kernel+bounces-377872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C89AC7E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADD7288F77
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D5A1A7265;
	Wed, 23 Oct 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8BOqF7o"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD31A7240;
	Wed, 23 Oct 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679182; cv=none; b=VTe4TG6S+NAKruwKm+zKM0HPs05tLO/rPF9msT9DcjJUks9e8XhRjax1XUl/6EZZy4Z4/GZwC3nHDkuhbmsnfS6O4sZBW3S5Kys8m5KK0eppLK2BSCJeQgpbzmlvvzBKggVudQ2WDSJhyf6W24uXuRYYYGhoQoECYo5KV09zEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679182; c=relaxed/simple;
	bh=/rY8Bix/A3eVXwrAPy6PsBPfRtj8YorTvFp2uXlNHQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCUkI+FGkiW4FsB8WAN/9hmK8uIvvN78ow6pPJBLrwwzJ2m8fezRIPTPiyaUQlj+xVJzzXAjBtissoRguJMRC3phSvJJu7s0REwgEeLotmCh7HkLQAjQRtwEYH29Sk958GBUjLqMpSL91TN87QTOIICUfIgi1YYxCezBOl5vlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8BOqF7o; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f84907caso7507504e87.3;
        Wed, 23 Oct 2024 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729679177; x=1730283977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEzfxMbPEV9VQ/sTcsJTaL4CVZMzEblAgELJ3Wx2y6Y=;
        b=R8BOqF7o5UeBT+exrF3glswfLa5iCLtKxqGXRxtcfy79ZwUQ6Ynh3sK7OXn6BwAvYu
         wwDo/hoNzmZX+CazGGL7Jur7m+CVil/p8EyST58IGW2D4sSBM4fltvzP707GrMcs/Vwi
         o5MZFvs+Z0i+uMmGo/RO0w6O5JdMSZQccpBDfBpNnm0AsypyQWcjg9SmslrSX7dCAxqX
         S0e2NUj5+aT3UtlmS5nnXPNnB+68GHhu5vpg8bJtbpsePGqu3aRxbxodOz46dBCpccLA
         ZAKGx+LX2abYlGLtJUg5kSCxtoeQgaSOMEFGvpZb7AnT7bDKOkSYEcTytNk1DDHa8I8E
         +DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679177; x=1730283977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEzfxMbPEV9VQ/sTcsJTaL4CVZMzEblAgELJ3Wx2y6Y=;
        b=NT8fvedwbUv8ZAxYohNL90uu6vQqhocn7oM1Vk43PNJq80sYCXN3oawpFVkn9Vr4Kk
         e97Dpy/u4iBRpU9zrmSCT2HDMX9pcXnGjvaZ5wj9lJw/v7fYGZ27TEahOfvQgDSobWYj
         8xYeGBNJr9QGQvr7fc7AnCam10+Jcz5gpVRUQiD31nci4SW/PuKXqxPPd9LZmSoIIK49
         uwIo7I7WM1bdG0oTyjf6EHbdwAhfK8vddPzllcu8XmAVhq18aVOmNm/J/DA8gxNc44gS
         /lka/tKhgG5atOQ1CBdnE3GEbI45pM/KYHFYR/VfULQoLErPrzvhbu1SU7aKf8QSqnKb
         f6FA==
X-Forwarded-Encrypted: i=1; AJvYcCUdCex0Q9ngmh/VS6jYGse22nAWzj9hl5HgwQJkPw9bVInKhTNKk3ODh2S8NpNKB2zRbNiOhLqJH9l0XSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6ZKwZ3jTie0nCL9dUtC92AyNMD9fK5R1nzFa0KG5+w+ElNts
	o28zh2EY1L+rx6GxfjYOiegxupXpCBT0tfAjWOAl3ogwiwUJ9qiSxzEPLQ==
X-Google-Smtp-Source: AGHT+IHQViEDeVEDA5/FOENcYb86azyDwtpqrmo9m3FxrmDFVkYX3O9g7YTfCmOA6sNWyjYsQYCMjA==
X-Received: by 2002:a05:6512:1325:b0:539:e88f:23a3 with SMTP id 2adb3069b0e04-53b1a3c9300mr926638e87.60.1729679177117;
        Wed, 23 Oct 2024 03:26:17 -0700 (PDT)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2242fbaesm1005518e87.182.2024.10.23.03.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 03:26:15 -0700 (PDT)
Message-ID: <b154dd13-8cd8-4066-ba3d-6597959ca5c5@gmail.com>
Date: Wed, 23 Oct 2024 13:26:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] rust: types: add `Owned` type and `Ownable` trait
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, dakr@redhat.com,
 linux-kernel@vger.kernel.org, airlied@redhat.com,
 miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-2-abdiel.janulgue@gmail.com>
 <CAH5fLgjZ91xFo4hV4dPnDXLFr9jX3na60tVt_KuNU_c6WhhzAA@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgjZ91xFo4hV4dPnDXLFr9jX3na60tVt_KuNU_c6WhhzAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/10/2024 12:28, Alice Ryhl wrote:
> On Wed, Oct 23, 2024 at 12:49 AM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> Add the 'Owned' type, a simple smart pointer type that owns the
>> underlying data.
>>
>> An object implementing `Ownable' can constructed by wrapping it in
>> `Owned`, which has the advantage of allowing fine-grained control
>> over it's resource allocation and deallocation.
>>
>> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>   rust/kernel/types.rs | 62 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> index ced143600eb1..3f632916bd4d 100644
>> --- a/rust/kernel/types.rs
>> +++ b/rust/kernel/types.rs
>> @@ -429,3 +429,65 @@ pub enum Either<L, R> {
>>       /// Constructs an instance of [`Either`] containing a value of type `R`.
>>       Right(R),
>>   }
>> +
>> +/// A smart pointer that owns the underlying data `T`.
>> +///
>> +/// This is a simple smart pointer that owns the underlying data. Typically, this would be
>> +/// returned as a wrapper for `T` in `T`'s constructor.
>> +/// When an object adds an option of being constructed this way, in addition to implementing
>> +/// `Drop`, it implements `Ownable` as well, thus having finer-grained control in where
>> +/// resource allocation and deallocation happens.
>> +///
>> +/// # Invariants
>> +///
>> +/// The pointer is always valid and owns the underlying data.
>> +pub struct Owned<T: Ownable> {
>> +    ptr: NonNull<T>,
>> +}
>> +
>> +impl<T: Ownable> Owned<T> {
>> +    /// Creates a new smart pointer that owns `T`.
>> +    ///
>> +    /// # Safety
>> +    /// `ptr` needs to be a valid pointer, and it should be the unique owner to the object,
>> +    /// in other words, no other entity should free the underlying data.
>> +    pub unsafe fn to_owned(ptr: *mut T) -> Self {
> 
> Please rename this function to from_raw to match the name used by
> other similar functions.
> 
> Also, I don't love this wording. We don't really want to guarantee
> that it is unique. For example, pages have one primary owner, but
> there can be others who also have refcounts to the page, so it's not
> really unique. I think you just want to say that `ptr` must point at a
> valid value of type `T`, and it must remain valid until `ptr_drop` is
> called.
> 
>> +impl<T: Ownable> Deref for Owned<T> {
>> +    type Target = T;
>> +
>> +    fn deref(&self) -> &Self::Target {
>> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
>> +        // safe to dereference it.
>> +        unsafe { self.ptr.as_ref() }
>> +    }
>> +}
>> +
>> +impl<T: Ownable> DerefMut for Owned<T> {
>> +    fn deref_mut(&mut self) -> &mut Self::Target {
>> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
>> +        // safe to dereference it.
>> +        unsafe { self.ptr.as_mut() }
>> +    }
>> +}
> 
> We only want Deref, not DerefMut. DerefMut both requires uniqueness in
> a way that is stronger than what we can really promise, and it also
> implies that the value is *not* pinned, but we generally want to use
> Owned with pinned things. Thus, we can't use DerefMut.
> 
>> +/// An Ownable type is a type that can be put into `Owned<T>`, and when `Owned<T>` drops,
>> +/// `ptr_drop` will be called.
>> +pub unsafe trait Ownable {
>> +    /// # Safety
>> +    /// This could only be called in the `Owned::drop` function.
>> +    unsafe fn ptr_drop(ptr: *mut Self);
>> +}
>> +
>> +impl<T: Ownable> Drop for Owned<T> {
>> +    fn drop(&mut self) {
>> +       // SAFETY: In Owned<T>::drop.
>> +       unsafe {
>> +           <T as Ownable>::ptr_drop(self.ptr.as_mut());
> 
> This uses NonNull::as_mut which creates a mutable reference. You
> should use NonNull::as_ptr instead.
> 
> Also this code will look better if you move the semicolon so it is
> outside of the unsafe block.

Thanks for the feedback! Will do that in next revision.

/Abdiel

