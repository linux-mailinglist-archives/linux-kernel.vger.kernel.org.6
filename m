Return-Path: <linux-kernel+bounces-526575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F928A4007F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05137428437
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B171FE47A;
	Fri, 21 Feb 2025 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ifx8txNa"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C61FBCB9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168716; cv=none; b=VG702SLKAp2aqisxJJ+nAO4lTD7L45duSaf6rSo3WkMlAaNVb49v4jGR8aWs0AaevvTsxfdc5+ktJDt7kEiwfSEYrLqLQ2XK384i8RWFD8xtftjhXjKtHfmykf5d4/V2EvPBfv3+XIkgUb3QL9zh5FHt4NQuTmHuoDCBcFmFwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168716; c=relaxed/simple;
	bh=sHDT7bse50uCAtNjA78tyEQ3rjAX9mJG1DMhp6e+0tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOV76dNlGV20xXxJp9NMlwuWk5BL4O3HG1iEE6nihRbjFzPpfcL6z074SAR0lYuInbjbT9Gy2cyQck3OPsrL+pwi7jBK0Pa4E8kGZVhMO/mFOeRbY6uN0HLh2sUAKbl3L4LZEXVYtuMmparvttUcMbxOYVAa5Sqf+IfuTFBgxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ifx8txNa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab744d5e567so437859766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740168711; x=1740773511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CcGCG2WSdQQovy8qS/ohnfSZbfooRumEZHN+xZ7cilE=;
        b=Ifx8txNa3aZd2mXmXPHM0flt+njiEbTk1z6/Gir+aDORjgFJm5Dz/Ho1XT983nHOgy
         6LOC1HtrxfccNwNxXG5ljX9D/RCqVcOTlAg+HwxTkAzxojeN3VGhU9/yipQ5302HUuou
         ue+e7jvHNtX2qXavZSNh0EsLLBFBU+sCMp+rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168711; x=1740773511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcGCG2WSdQQovy8qS/ohnfSZbfooRumEZHN+xZ7cilE=;
        b=Ena3hEcoJdfDInzjbUC+DDB+9xjLnGD2zv1IXK8rDexA8XC+hERr6R8wskTIpw41rl
         6j3NTqjQwMQ9xDfttjGyvCAoD8s41XCfHEyAlldehhAEbd5Em6tBNQ922h4kjq81OYEA
         83bDT5BkKyKAtiX4WaCtgHkKmTqpszd9jl/0vgHmcN4OWmls0kSW/rOwEjFZkEPZA6PV
         RwwcEOXo7pYMM+WjC86EIeyc1xWhajh6Zt4DbQYOAJBKsiOBZ32F4H1CgQkLHri2w9Pj
         hVsiOWh0OeMWGZQm+aBCzYp/ylt/DfWt0UdLUEX4Ng4XDMQU36eKK9jZ7HGUhX7tUfFx
         4adw==
X-Forwarded-Encrypted: i=1; AJvYcCVtYKg6ssHoe2MkGngmh2DD7bCHa+VZ8qkTRTZdLlBviHzjxtxW9kllThdqtpfV4L8QbNuHf9YILaIABpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJtC9sSM6fvD4pF6/U+4Hlr7vdj7Z9JYTGBfhbEH4RgCjGmUn
	ZfWjoy2m0IVhRRQeKIv+YPDzwYoSmwDK1qJt9RMr6ggA3Er8Lx/eyBgN3/GioO4vYlXzlBbmKG4
	3Cxw=
X-Gm-Gg: ASbGnct5y+GQlt5l7hzMI0Sh9/SHIRGUeL+L0Q22mTgMfj6gWsgLKlZIyuyRwJmJxxC
	N2438E5v6XYeO0ETf6iLIhfm2u3tYFfCtxFW71lFsGuhkTFbW9MnxJquintSZYpbp9RYD9vw+o3
	2Q819qeTRijZ0JZTTCoMAG+1DNuFRoj8BNlFSIt7ExSKJTbO04wVgZ0VJtG5DNV9UWqbyS93ja3
	EyVJAGqK4oZgIw8Y09TKNfJ7cG8ywRqIcbpPDCUL0IkVXGJt2qoJoZbVSorzKXAgH7X6zxfaP5Z
	5bN5pk+WcDro/1wzqjTt+/Oqjg1+0cxFSvhq1sf2rhNVotlCFpRq1tZWNdp5QrCKXky/fo++aw6
	s
X-Google-Smtp-Source: AGHT+IFxz+MUdR+20X9LRgy3je8dTzxkrH42oZXLg1wPG5UEQ1Si8jr9XbARyum+hrD/jthHTY+8+A==
X-Received: by 2002:a17:907:9721:b0:abc:675:223a with SMTP id a640c23a62f3a-abc0ae56749mr404248366b.12.1740168711542;
        Fri, 21 Feb 2025 12:11:51 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb948b4978sm1084433766b.151.2025.02.21.12.11.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 12:11:49 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbdf897503so594218166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:11:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnsZCzJxzh4H0GFKCQtWlfIbN5D9Si0QeJkPeUX6AjCANV8WCP2aja6QUadflqcB2t+EtaqHifLVbEXW8=@vger.kernel.org
X-Received: by 2002:a17:907:9989:b0:abb:daa7:f769 with SMTP id
 a640c23a62f3a-abbed5b21b4mr870873866b.0.1740168709416; Fri, 21 Feb 2025
 12:11:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh> <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh> <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <2025022042-jot-favored-e755@gregkh> <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
 <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain> <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
 <20250221124304.5dec31b2@gandalf.local.home> <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
 <6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
 <CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com> <008cc0939c130ee24fbc71a0407ff82772076668.camel@tugraz.at>
In-Reply-To: <008cc0939c130ee24fbc71a0407ff82772076668.camel@tugraz.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Feb 2025 12:11:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5Rt_xhp_n4_gEyGG9LKFOiTrsvN0ueo3q5PyjJPU+AQ@mail.gmail.com>
X-Gm-Features: AWEUYZnIN0fhlIm3BbR3TnvejgU7vmWR4MU8kuJXCz4EmowYIdocxYD5OpC83wk
Message-ID: <CAHk-=wj5Rt_xhp_n4_gEyGG9LKFOiTrsvN0ueo3q5PyjJPU+AQ@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Martin Uecker <uecker@tugraz.at>
Cc: Steven Rostedt <rostedt@goodmis.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 11:59, Martin Uecker <uecker@tugraz.at> wrote:
>
> The standardized version of __attribute__(()) would look like
>
> [[safety(ON)]];
> ....
>
> [[safety(OFF)]];
>
> which is not bad (and what C++ seems to plan for profiles),
> but this also does not nest and is a bit more limited to where
> it can be used relative _Pragma.  I don't really see any advantage.
>
> GCC has
>
> #pragma GCC diagnostic push "-Wxyz"
> #pragma GCC diagnostic pop
>
> for nesting. Also not great.

I realize that the manual nesting model can be useful, but I do think
the "default" should be to aim for always associating these kinds of
things with actual code (or data), and use the normal block nesting
rules.

If you are writing safe code - or better yet, you are compiling
everything in safe mode, and have to annotate the unsafe code - you
want to annotate the particular *block* that is safe/unsafe. Not this
kind of "safe on/safe off" model.

At least with the __attribute__ model (or "[[..]]" if you prefer that
syntax) it is very much designed for the proper nesting behavior.
That's how attributes were designed.

Afaik #pragma has _no_ such mode at all (but hey, most of it is
compiler-specific random stuff, so maybe some of the #pragma uses are
"this block only"), and I don't think _Pragma() is not any better in
that respect (but again, since it has no real rules, again I guess it
could be some random thing for different pragmas).

              Linus

