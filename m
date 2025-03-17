Return-Path: <linux-kernel+bounces-565180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF04A66280
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496483B25A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A65205ABF;
	Mon, 17 Mar 2025 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJv5iwlN"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C982205514;
	Mon, 17 Mar 2025 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742253305; cv=none; b=GsKaTNkIvOEbyfay8fXjKNBoqGhrw2lpq8DKgIZ3DeLlelBlbAEyDOnNoQhDgYKajnwi2qCjNZEODJ2KDDanZKKSelRrygccJU1ZARvOseB+zvUaVGbnyseYwXv6gaJO+hhudnVs5sXyt04IWLMEhFGqAF4FTSkXJb/i+/ZcaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742253305; c=relaxed/simple;
	bh=ncdHbQg4WWl2HkpnaZM/XX8q4+iiQwWnEXJZQ5HyQak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgD9PhTNIJV7yFNIT8PK1PfsHJ+ISvHyQ8Y91dpIqJlnEezcvH6SNPzAT5JKwnQWw8jHWl8YmireWWZEky9khqxdmydNjzkT7BxyZjFm9JVf9TH3cU6c8JJDhj8m0d4TzR77nRfWHXtTZMU7nlT6XAaWxUuMBtf/N7y/makn2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJv5iwlN; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86ddd80bc00so10255241.2;
        Mon, 17 Mar 2025 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742253303; x=1742858103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ncdHbQg4WWl2HkpnaZM/XX8q4+iiQwWnEXJZQ5HyQak=;
        b=KJv5iwlNIfjOyGucuRP77S+OjhaTGz8T9eg9nymEJeAKCc+GgQkWSa9SCb+HQtKzea
         w+lb7U42hJ/+WKjxLtJGFwWLkopAIgyrB30EtMDVNdyS4Ahjc8YtKaRu4McLHD+TJ6j/
         0IHykiYytB9Vts4TFIZZkQU6fQrhKxQF7N1Vo8YlXitnQmgbSIPIPVGHzVKN3cjJXW7Y
         +TRsrsbpI7PTwRC+OkixbfAnNL7zb4Qbn3Hb1Q4UPTEqk4NDmxZxy2MTsW5tfUYRAJ8C
         fbPEVovEb4XQis4zVFBd6Scv4rxTtgrx2cnOn6mMOiY1osf6a+02e0h8dC0mxmJCCofG
         LsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742253303; x=1742858103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncdHbQg4WWl2HkpnaZM/XX8q4+iiQwWnEXJZQ5HyQak=;
        b=vWZJsqu6TjKlNcGyoBjFWSCddBUfTa6YWkJ0wXg/1nNCQSZ/DGkoUSBgiZQ+yVWjJH
         RSVarmgk8QApDfrPav7ThnJnvZkWaBgG/hVYDzJvGiakhM/FluuuLY5eJhhP2uxqNAfH
         nuB0Nx0UUo7J1fTl8GOWjsY952n6A3UEbXi7gRJ2ZXYzwue/G+RziTityb2Ujdk0Ex9p
         Wn2TtG9wmNV7sZ0d3LtEufQ0ypqwCWbcwifqFYv3cnfJQOM59GipUd8R845WSysP8qKP
         +giaPDHBZ2SHZThL52JeiMSy5Kxn34sKSDyfufCpWg1F9yI8yPfjtUCdcpst8LTuSoLT
         7Qkg==
X-Forwarded-Encrypted: i=1; AJvYcCUl7XJPwGYk5OQRTdR3F/ORaG1rjsPtDISA+r38L5ZCJUqvkm4eZd/+d3Cyq/Rne6PcEcUMYhryVvipR8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5bxdTyeqwJd0CNwtK3ONwdQKRnINBV2fIq6MqDfe00wfl0JI1
	B6se2wtKsjjJdbNPFs0nYAP0R5SYt2iwR5+qsjmVyeYyTf6BeajdboyLLlqvmnzUJSWQ15T+sWj
	WroZ2EcCZb0WchYDcbgXn5F+6/8A=
X-Gm-Gg: ASbGncsr4udhBqerbx5nyc61/phTja4vd7xt9HDPBaGD0noRgp6DyVrnQeYXY9JiR3W
	i5hcfLW/9EEgpA1j4+LkHPOa+MzstbZFqNCrT0sarpzjNIqctmevphZ5SGgQhTjxptzdkaYEv/9
	4EqPAJIfwzxH/14TtfPDt9orNtxjs=
X-Google-Smtp-Source: AGHT+IEnrQlE23/xIIzmbAEijNY813Dm4zi6qzBkpu+ZQSDmwe/nZDheRwXHHVCdofrReEFVseuTf77TXCZv3f0MpXU=
X-Received: by 2002:a05:6102:6ca:b0:4c1:add9:67b1 with SMTP id
 ada2fe7eead31-4c38310cf58mr2875496137.1.1742253302834; Mon, 17 Mar 2025
 16:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314034910.134463-1-christiansantoslima21@gmail.com> <D8FXFGYZTEXT.24UM4V3HZ5MWH@proton.me>
In-Reply-To: <D8FXFGYZTEXT.24UM4V3HZ5MWH@proton.me>
From: Christian <christiansantoslima21@gmail.com>
Date: Mon, 17 Mar 2025 20:14:52 -0300
X-Gm-Features: AQ5f1Jpzj62_7FehZNrKT--VncKPhZnt3E0MigRhuzvbNGqk30Stl5YO1efv0l8
Message-ID: <CABm2a9c92FHGSHbg98B8UjPNF_=JNCV7_Pe3CambvSm2vxiBcw@mail.gmail.com>
Subject: Re: [PATCH v4] Add methods for FromBytes trait.
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi, Benno.

> It usually is a good idea to include a changelog and a link to any prior
> versions after this `---`. It won't be included in the final commit
> message, but help reviewers and others keep track of this series.

Yeah, my bad. I forgot.

> I think this section should go before the `Safety` section.

I followed this section:
https://docs.kernel.org/rust/coding-guidelines.html#code-documentation,
but no problem, I'll change.

> Why is this trait becoming safe?

I thought that if we change to a Result and get the Err case, it's not
a problem to be safe.

> IMO it makes more sense for the return type to be `Option<&Self>`.

I agree. I'll change.

> This must also require that `Self: AsBytes`, since otherwise the user
> could write padding bytes into the original slice.

Did you mean `ToBytes`? Should I create another patch with an empty trait, e.g
```
unsafe trait ToBytes {}
```
or create the trait and its methods?

> Also the parameter name `mut_slice_of_bytes` is a bit long, how about
> `bytes`?

I liked it, I'll change to `bytes` and `bytes_mut`

> What is this safety comment for?

Idk if I should create another safety comment or just continue. In
this case, I choose the first and submit the patch. So how should I
proceed?

Thanks,
Christian

