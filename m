Return-Path: <linux-kernel+bounces-425316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9A89DC06B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CE92821A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2250F15E5BB;
	Fri, 29 Nov 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="fsxw1a3o"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042D4204E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868558; cv=none; b=F+tBO7hRryKl1hOuqWfIAyr3CAoMfEWqEb1EJ2I1Ww9VZqNsCJ//kahbvWzmbshNm2s2GDwGgjN0Hun4t3DYCLTnsqo0I0c5enrUIfyn2/zIPTFyllRLsTjyM5rsNBQqvoTbFIN8JChG/TFWj8cSM59miDip0NMXVgrfIrcfJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868558; c=relaxed/simple;
	bh=562yHw0XBNbz/d+kvGdxMM55CvOCfYE2YRMXmMQ1hpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONi0NozcXxo9nhnpuT/BLRn7kTpMPilVDdJuYfF199KLKO0/tebX9XLKnv2bAwu76iGKya4LZr8uq2m/EKS3NQeYoM7/owrLP0F9FC1qDA73l/7EPnxveno8IMhKEjbYqRvpt98h9TEVmMmp+e0xaLhbDT8MbslJEDE2djLN0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=fsxw1a3o; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa549d9dffdso214374066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1732868554; x=1733473354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpOpchybQJXD5CvZrpdSs1RBStnGyKaKUM/Uju5sP7Q=;
        b=fsxw1a3oH0tW/K4dcEKMJlJK+wlIuH5k41HtuDb/J/sybSGf8tCD32eea41z1ueiwY
         4oJunEtOTK4nxF26enPXohZ1gi4S3bhC9hbHqmiFA8TA83R4v2KIMqZyY6LsnnNl6XsR
         j+t4/FW490gyxDJHjHM5zmVjs7BNmxsfjJ2Q4US3WjSe34Fpe+TCASLVVbZgsoKUbYwI
         erIvdxY07GVREpGQuziGv5QqxSO+eCDr9FwvAvq203FbgTC2D1wh6s9goNtge7m5mYNJ
         o8qvEWZK3aERS4vembs0UY7x9fYQwN6oc6d/qPrj1bPcmiRoVbRSiy4S/zDCWGzeN15O
         2p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732868554; x=1733473354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpOpchybQJXD5CvZrpdSs1RBStnGyKaKUM/Uju5sP7Q=;
        b=ksUOJhuJDxXrJH+Gr+tQkib7F3hhCTWsWbszgEUKT5JgzUmP25OxpI4NtiDzq8wbJL
         JEyvnlvVMWUh2180tAbGdDprudZxC7vMkEvCx4VcP+2rAQssYIXMeMtFicpyAHMoKXPE
         dryvpRRGw+YxoqquURV0HD/imd7zFgtds+C0PYgoSarCM5lc4wXgLu561eLKLTbCPk1+
         IS8tkIn2piYtjRk0vdblA1FhSniKGPb8fe5QKzQiwKyywDOPjGdgqGMrkphTgJ1VMSMT
         rcs2evmY/y0FISQCk2YScARIxgIlH3UF0eZRHbi4JcOG/SEbd3GGHmpozNyqtRgpQfsu
         /B9w==
X-Forwarded-Encrypted: i=1; AJvYcCWY1Solt7P81sz7ne7v7YVlFxK+ceyhXJfJVpeUIHyp2zyyLHAjtSlDCz2XQ7+IRXOCEzUmO88YhOAXpB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTOQuFqOVnb4BVHL0UYfzOXkSByuSCtWe6QUfwSTG/v6xPi3U
	l32jKaqv8sbAboYmfaGGPnnZ/Fbmhs16R1EZCTDgkLrXcu35la9snf2mtQyXl2g=
X-Gm-Gg: ASbGnctXZBXhXqQubKARe0Klb+SBHIJwbF2iiSSk4JrTCJYk+tdZQrSn/HNFeyAtF9a
	Dr19IZ+DaP52NgSVVnyWhfX2ktD0UpTJlEirvFOA6Btlg5fsPQ7xHNeotu2zOXclMJSRUwCKc9m
	F857PmmIXqwLvMIKZE+OqRbQF5kGGzawqXyRNH+C4PxK98oGP0B4zfhUNtykbxR+fn5RA3X1mT/
	QcgbQBCxzPYFBvhNl3yUE6/kl9sFWieFfPq6Mk/BKZLv9Xbp2Y=
X-Google-Smtp-Source: AGHT+IHyI/nqfSxONykSF4kwQGUMItj0mjdcZ+BUKlRUULAfXTeC/1tNq1UOeKpwb/WJV4QJtInbew==
X-Received: by 2002:a17:907:7751:b0:aa1:f9dc:f9bf with SMTP id a640c23a62f3a-aa580eee484mr832584866b.10.1732868553906;
        Fri, 29 Nov 2024 00:22:33 -0800 (PST)
Received: from [192.168.88.249] ([95.85.217.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6d7esm148314366b.114.2024.11.29.00.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 00:22:33 -0800 (PST)
Message-ID: <0aa72bdd-7431-49bb-a6b4-e254787db0f1@sedlak.dev>
Date: Fri, 29 Nov 2024 09:22:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] rust: Add `OnceLite` for executing code once
To: jens.korinth@tuta.io
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Rust For Linux <rust-for-linux@vger.kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Dirk Behme <dirk.behme@gmail.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
 <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io>
 <230b3602-5d68-4e79-969d-0d2df1fdf033@sedlak.dev> <OCj9As8--F-9@tuta.io>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <OCj9As8--F-9@tuta.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/27/24 8:46 PM, jens.korinth@tuta.io wrote:
>> Have you considered it to be implemented like `AtomicU32`? I think™ that
>> one atomic variable is more than enough.
> 
> Just to clarify - you mean something like this? Nevermind the magic numbers,
> I'd replace them, of course.

Yes, that's what I meant. But as Alice pointed out, you _may_ be able to 
reduce it to the one AtomicBool.

Daniel
> 
> diff --git a/rust/kernel/once_lite.rs b/rust/kernel/once_lite.rs
> index 723c3244fc85..0622ecbfced5 100644
> --- a/rust/kernel/once_lite.rs
> +++ b/rust/kernel/once_lite.rs
> @@ -16,7 +16,7 @@
> //!
> //! Reference: <https://doc.rust-lang.org/std/sync/struct.Once.html>
>   
> -use core::sync::atomic::{AtomicBool, Ordering::Relaxed};
> +use core::sync::atomic::{AtomicU32, Ordering::Acquire, Ordering::Relaxed};
>   
> /// A low-level synchronization primitive for one-time global execution.
> ///
> @@ -44,13 +44,13 @@
> /// assert_eq!(x, 42);
> /// ```
> ///
> -pub struct OnceLite(AtomicBool, AtomicBool);
> +pub struct OnceLite(AtomicU32);
>   
> impl OnceLite {
>       /// Creates a new `OnceLite` value.
>       #[inline(always)]
>       pub const fn new() -> Self {
> -        Self(AtomicBool::new(false), AtomicBool::new(false))
> +        Self(AtomicU32::new(0))
>       }
>   
>       /// Performs an initialization routine once and only once. The given
> @@ -71,10 +71,10 @@ pub const fn new() -> Self {
>       /// [`DO_ONCE_LITE_IF`]: srctree/include/once_lite.h
>       #[inline(always)]
>       pub fn call_once<F: FnOnce()>(&self, f: F) {
> -        if !self.0.load(Relaxed) && !self.0.swap(true, Relaxed) {
> -            f()
> +        if self.0.load(Relaxed) == 0 && self.0.compare_exchange(0, 1, Acquire, Relaxed) == Ok(0) {
> +            f();
> +            self.0.store(2, Relaxed);
>           };
> -        self.1.store(true, Relaxed);
>       }
>   
>       /// Returns `true` if some `call_once` call has completed successfully.
> @@ -98,7 +98,7 @@ pub fn call_once<F: FnOnce()>(&self, f: F) {
>       /// ```
>       #[inline(always)]
>       pub fn is_completed(&self) -> bool {
> -        self.1.load(Relaxed)
> +        self.0.load(Relaxed) > 1
>       }
> }
> 
>> The `rust` part should be default value for rustdoc tests, can we please
>> omit that?
> 
> Will do!
> 
> Jens


