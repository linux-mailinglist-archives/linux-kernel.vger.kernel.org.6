Return-Path: <linux-kernel+bounces-396249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15F9BCA10
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B6F1C225FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086201D1F50;
	Tue,  5 Nov 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFTf6o0n"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F421CF7C9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801391; cv=none; b=OlDgVIYy1ytFHqq/wFBucTwThE+toJqljUPc3a2rgYrRAuq2fiUZI4aBpegolEUMAU9/IteslXsU4Kotu/YH1/tjht4/6k5UWVkmPJDStbncIArWoh/8pkoTb2A+7wrcPY0hKM35i3AfjOXDHWFhg0nCKOL/NqcoTsaYCGhj4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801391; c=relaxed/simple;
	bh=RHeVziAoN8CGsuY1ZAh7sRIuK3iFRADOSuijtUbubnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mG7hS5rJVtVrK7dUz2CS+pkIdM+xVNQ08ea8GHq+km/1L5+ah1ZAgBGAM03RilVRtoLdF99YMNa3ZRPRse67bSSzqjRrahaIApN5yq8XH3jYJQ9tQy0hupoGw3fFuEKeqT6Lnf7nxDhWRswZFJI0hNI09GoiOenusEJO8HmCc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFTf6o0n; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso4444184f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730801388; x=1731406188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bWo52DOYiB3ZcRQB3C1o4jMfb9oGGlF3xYVSdDQ1Ec=;
        b=FFTf6o0n54o4i2v0X7XHEgglxvp927x04fIe2eFg+3T1YkmE+GxHbDtoKKcLVV4Tqy
         897y6oHDoNRyh0CA4oBB2CVp221GGLa1olj6Vny4czYWlaQ3f8FGhIQluQVroFgjWTjy
         s3tMBCBOXSqrETaFcWzoHuhpwihHQLc5AfrNzWKCCr5mEwidIgNij4nTVcjTj3YJ+fAl
         lI2E6JVl6Nb2EVSybIyjfy9P+UPXkLT0JIBZxUdQGqALPftKo+XFTz5QIvKjDKcMKopU
         ws4wVIb9ieQcD0ZNHdTItxl96lR2drwNzfrReBSt+UMHTiEHSiT/XKJ0Jz/18syof8S8
         pbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730801388; x=1731406188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bWo52DOYiB3ZcRQB3C1o4jMfb9oGGlF3xYVSdDQ1Ec=;
        b=BV7OA8gKqIAESgn/3poJKc7gywTwSitcQzm4S80AvG3Tz7xe6KFZC8oqBbFs/t0u8C
         kRLhU3ZyjHfGJQoMxFd0aygxtH4cor6dM97qakLJdmP2Ghxj2B3glbknBYME/lvXW/Zb
         DlYXOb73AP2GCrQnp8/EuTFO/HxWjoYk4qgLE7Li2MGma2nkPpme3b6MO+6GDnW9XXAl
         CNN2SRz2VgA828tvFQlm4HbiYESImcDZZfnSGIQXT/4iybll/8nEwBlQLlpHYFJwdUpA
         QV39pniXAAnbrIg3vwIWmIOLB7wRBa/Mlqkl7T4NH9fFZzwKpByAxorvEszcofAGMBmb
         VK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXX6H9h0i2SqRLncZhyLTRqfdfQfD3phimoKzfC4UMIv9hmW+N/ls8NHrgPljXeYbLYc6Fq1df/LwNKXGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6mNzWMqlto+xNwb0ZPEld6ElFPq50wGWq9YlQM8fWDZvyRn+
	I5P8Znn7tbQhZ60Yw4Y+79MdCx+3auYy0Wp4117ShHe3f1TEvb1bxRIWl+gQ6chsv7kqu2/cKbQ
	9VtMPQje77o7SXVQVr1ECho3j0h2CdEWzFBVv
X-Google-Smtp-Source: AGHT+IGXYx42z9SXdXlET0RfHWNg/+rG8WhSiYHUJbNJqzBz9Ox0kXsvFU1ogU1d5wdLYDMTLQVLF1Y95kbBYBuSXJM=
X-Received: by 2002:a05:6000:2706:b0:381:d88b:2bb9 with SMTP id
 ffacd0b85a97d-381d88b2bf4mr5164411f8f.51.1730801388247; Tue, 05 Nov 2024
 02:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
 <CAH5fLgjdDm3nNvR8g-a6Z8UsSnEDygLJ8i3u63aCrpG5ambQ3A@mail.gmail.com>
 <BC47085B-4160-4D9B-89F4-06EDE706CD5A@collabora.com> <CAH5fLghv3cBGO0HEH-5GXiDZZWyKSJYxQu8s0fi8D=eneS-OXw@mail.gmail.com>
 <935A78FF-0851-4A72-BCCB-C33E3F4BF61C@collabora.com>
In-Reply-To: <935A78FF-0851-4A72-BCCB-C33E3F4BF61C@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 5 Nov 2024 11:09:36 +0100
Message-ID: <CAH5fLgiirkt-JOF3XWNAyEFWZ=nGBPumqVVBOc_-PvfqriD-fw@mail.gmail.com>
Subject: Re: [PATCH] rust: platform: add Io support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:28=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi Alice!
>
> > On 29 Oct 2024, at 10:46, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 7:23=E2=80=AFPM Daniel Almeida
> > <daniel.almeida@collabora.com> wrote:
> >>
> >> Hi Alice,
> >>
> >>> On 28 Oct 2024, at 12:37, Alice Ryhl <aliceryhl@google.com> wrote:
> >>>
> >>> On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
> >>> <daniel.almeida@collabora.com> wrote:
> >>>> +    /// Returns the resource len for `resource`, if it exists.
> >>>> +    pub fn resource_len(&self, resource: u32) -> Result<bindings::r=
esource_size_t> {
> >>>
> >>> Should this just return usize? Should we have a type alias for this s=
ize type?
> >>
> >>
> >> I guess usize would indeed be a better fit, if we consider the code be=
low:
> >>
> >> ```
> >> #ifdef CONFIG_PHYS_ADDR_T_64BIT
> >> typedef u64 phys_addr_t;
> >> #else
> >> typedef u32 phys_addr_t;
> >> #endif
> >>
> >> typedef phys_addr_t resource_size_t;
> >
> > Hmm. I guess they probably do that because phys_addr_t could differ
> > from size_t? Sounds like we may want a typedef called phys_addr_t
> > somewhere on the Rust side?
>
>
> By the way, I wonder if that connects with Gary=E2=80=99s work on unifyin=
g the bindgen
> primitives somehow.
>
>
> I think that having a #ifdef for `phys_addr_t` is pretty self-explanatory=
, but I have no
> idea why this is not simply `size_t`. My understanding is that `size_t` a=
nd `phys_addr_t`
> should be basically interchangeable, in the sense that, for example, a 32=
bit machine can
> only address up to 0xffffffff, and, by extension, can only have objects t=
hat are 0xffffffff in size
> at maximum.
>
> This behavior is identical to usize, unless I missed something.
>
> Maybe more knowledgeable people than me can chime in here?

It seems PHYS_ADDR_T_64BIT can be set even on some 32-bit machines.
See config HIGHMEM64G for 32-bit processors with more than 4 GB of
physical ram.

Alice

