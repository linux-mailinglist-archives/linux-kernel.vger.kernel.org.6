Return-Path: <linux-kernel+bounces-546101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305BA4F654
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C733AAF73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF41C8629;
	Wed,  5 Mar 2025 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwVVZGY9"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B6B2AD2D;
	Wed,  5 Mar 2025 05:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151597; cv=none; b=MzbF7LbDaQnsCU31d/4r3cZg331w+r7C8tWGQpF34/VbpP5GQMfvtD4YqzkkVrx1Gke8Nnr7YZmcKnytFCJO5xrwosqjHQw61idbndOKR7M3kGWRUFPqcvBtG7LgTG2Z+R2sYid9EQJYiYDg1Zvlp0DiLS45dcuTam32HmiW/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151597; c=relaxed/simple;
	bh=q0BhGC6HUxOE4XplZuS/4jndjnSHZQ5oqFPeN6Mlcss=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TwlVl/yygZ/WKYwcw90ouTkgNOolsigrynEaTSCcmIQvoaUFGPH8ourwYsevzZdNM2I9MSmSfMgMTfeMaHCaBVRW11dsJiFH7ukW2j/ZSseS3f8hEBWYBgLfe1wxcWPTtrL3by/4QovaV9Uo3HjdmD6Am0ph0Ut88kmdz6cda1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwVVZGY9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f44353649aso10219462a91.0;
        Tue, 04 Mar 2025 21:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741151595; x=1741756395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iI2i5cV2QPSlpE280H3wgvcz67NO3pUTtRCcIr6Aq80=;
        b=gwVVZGY9uyqNpxaOZlvBhysMQezcwYJtmlwWRsSQwpiYbUieCd55RL2tUqOOgQ4AuG
         moxtV1KdMcczMyWzgmBcWWkoVgg4HuYaojbBf6aQ4rZ6K4B5QkMQ0uinpqWUj3qb9Fho
         uuRFb4a8AgBri/1RytcJc4/6lVXHysWaZTofqmCVFdVkIG29MKZ0ThwhpI9oMgNpgsEY
         wWYc+5kOnNw8nOrQxLlFBSdSKiDGICzw8c2odUfGZ1pMgj50w0emjT/hb4g7mO9yQPaN
         TGASenKHi2kAxNJJQAVwrHIybbcg9IsR7W7vxrWL1G3Bx6H0laEZFdHm0EkWRzyhLqK1
         MkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741151595; x=1741756395;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iI2i5cV2QPSlpE280H3wgvcz67NO3pUTtRCcIr6Aq80=;
        b=q7NRJ6OQCCP7m5larQbiOMLopZt6AX9YCMmXlqd/3kHJqn4rAli2cBVOyZ3q+/yqSN
         JE0sX69FJZAKN3902Oz2o7AmEzp3stpkO072thB8LFZlEIGE1PwS8VufBOEEcfypvo8R
         JhkV6Of1jIBskMGjiG1V6EcYT/N2RbeB2qtaPgCsX/uEMMoVE5v3N8J1mSpiEg7rwqAp
         0PWYpP3ZyjigqiiA2qE9kBFQlthFrk7bMt1PhcptL4vBm5ApheK62HLOWesNhTZnl3w0
         cZquTa8VaepPdPFTDw54rx7zZKPexJCRR4sG/RVucRPuIhqgyCUU01uR7+4uWtrO3pvE
         7iYA==
X-Forwarded-Encrypted: i=1; AJvYcCWie1eTe2Ppv88KxsBmJGT8mW2LKMS+Op49tKNdfIaM3teU9JI+WLk5G7W+bLndauehWjmiFHmgFT+ob2gQ8Ak=@vger.kernel.org, AJvYcCXkk0tCvm/EN8W4WnPd2fVcFfJf67bOG3Pr1nIeYgRlXdb0f11YHfdWfYmch2p1S0Os5FPHF84wP1tE9pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWR5k0R7GlVaoRWSdW8x3defuADC9FktKp0zQsR1cWg4aGZzEI
	QOYosPISrc+jnVSbEVBZAwl2Bh3n56ouEsL3mQ/mGeFfjC1bhyam
X-Gm-Gg: ASbGnctO7x0BwoJdCetw2TNAHxDelPge7ZeDAfOCFXMCa7JAsG8hyNDnje+ib/ecpVW
	1meH08PZy+8HREhk5ptVql86gFzFyo/VOBaSQeLbpsQXhPC89rETGB3arNaqIs1WKnJP9TIQWIK
	nck7x+Ipieu/sZ0UgsUbTiF0PTxNEy6gLHFoyVLJ1L+7H4D1SWRHbCQsZ+s0N5/VlXDTyigjydF
	C7d4uyxj3vQWcutRgX4w/2mrOY4qvt4DIPGspEVxj8wSs6QYrZvK3Luq015OD+Bayfd16fYsIXT
	npMd8sIzS2M1XKuSbV2Owar5JuDbS1OwEJIPgJhvhkQIbd3neXcPChtqOPKmD7p6oSTz4yycmhr
	YXkvG9y78sy3GUy5TpZXBEKyPjdc=
X-Google-Smtp-Source: AGHT+IFMSQhAQ13isO5dfJNAPGUjk16diS7qR+TcB+buuYoTv6JifWXgE+o5nAJ3u7mlLeqgq39i1g==
X-Received: by 2002:a17:90b:5688:b0:2ee:bc7b:9237 with SMTP id 98e67ed59e1d1-2ff4979cee1mr3291553a91.27.1741151594826;
        Tue, 04 Mar 2025 21:13:14 -0800 (PST)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e78a991sm380662a91.24.2025.03.04.21.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:13:14 -0800 (PST)
Date: Wed, 05 Mar 2025 14:13:07 +0900 (JST)
Message-Id: <20250305.141307.586794213367343251.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
 hpa@zytor.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, tangyouling@loongson.cn,
 hejinyang@loongson.cn, yangtiezhu@loongson.cn, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v3 5/5] rust: Add warn_on and warn_on_once
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgjX9hh+QRrKggOKr+6p+UwqHSavzu4UXy9iGNL2wSJXtg@mail.gmail.com>
References: <20250213135759.190006-1-fujita.tomonori@gmail.com>
	<20250213135759.190006-6-fujita.tomonori@gmail.com>
	<CAH5fLgjX9hh+QRrKggOKr+6p+UwqHSavzu4UXy9iGNL2wSJXtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 14:33:39 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> +#[macro_export]
>> +#[doc(hidden)]
>> +#[cfg(all(CONFIG_BUG, not(CONFIG_UML)))]
>> +macro_rules! warn_flags {
>> +    ($flags:expr) => {
>> +        const FLAGS: u32 = $crate::bindings::BUGFLAG_WARNING | $flags;
>> +        // SAFETY: Just an FFI call.
>> +        #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
>> +        unsafe {
>> +            $crate::asm!(concat!(
>> +                "/* {size} */",
>> +                ".pushsection .rodata.str1.1, \"aMS\",@progbits, 1\n",
>> +                "111:\t .string ", "\"", file!(), "\"\n",
>> +                ".popsection\n",
> 
> It looks like you're doing this so that you can reference the filename
> with "111b", but could you do this instead:
> 
> const _FILE: &[u8] = file!().as_bytes();
> // Plus one for nul-terminator.
> static FILE: [u8; 1 + _FILE.len()] = {
>     let mut bytes = [0; 1 + _FILE.len()];
>     let mut i = 0;
>     while i < _FILE.len() {
>         bytes[i] = _FILE[i];
>         i += 1;
>     }
>     bytes
> };

Neat! I will use this in the next version.

> and then use
> 
> asm!(
>     concat!(
>         "/* {size} */",
>         include!(concat!(env!("OBJTREE"),
> "/rust/kernel/generated_arch_warn_asm.rs")),
>         include!(concat!(env!("OBJTREE"),
> "/rust/kernel/generated_arch_reachable_asm.rs")));
>     file = sym FILE,
>     line = const line!(),
>     ...
> );
> 
> with
> ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}",
> "{flags}", "{size}")),
> 
> That would be a lot simpler to understand than what you are doing.

Indeed.

Thanks a lot!

