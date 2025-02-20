Return-Path: <linux-kernel+bounces-524271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA341A3E158
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298FB7A9F23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3AA20DD4C;
	Thu, 20 Feb 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M9DdC7w6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14720C00D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070040; cv=none; b=bEJKUP4+cB2+UWBoF1gC8rUbcGR2G9pdBQueYyKf7ffyoZrmwe/qzOjrSn97khRyTmUoio0zRlicJIBwc3dwg5pLbuLHCxQM4ljH3T5QQI2IwYrcZFAHk0jl6Zq9ddszY52dj+CLELzEdIRRhrw/O1DqV0IDGz/sug9Jpp5WlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070040; c=relaxed/simple;
	bh=dQbcpcb/Fr1fg1CoD0pZkGdNzzEl80AydjsiI1ZsQkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJeRND2ZZo2GnRxkkXm7kRaFQMGtAli21/OjlS8mplk2WE6UyhGKcUT5ZQcSG/0BnKUrzV69uPhV0iKL35DpuoO2KevDK/cVrIho8lV7dN9nsyL5qlNnClRqurIhL/eze2B6EjbjphZXMSj4/SN7DoKV82o2cREgSmdTTF76itA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M9DdC7w6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb9709b5b5so225876166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740070037; x=1740674837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YZPfZYNg8NOtUAiK1S11L7/kf32fZfQ/BKwR+IkGA/Y=;
        b=M9DdC7w6260jKTOFJ3Pu+r1l27iOppTCtLWLJfDJx9HT7DmC2QjkqDXiDB65wTZGle
         FAZ3KmLsi/KxhmU8GSJqJJ0ECGdLIsfE5KfCrumYYKNW2Nya/1Pdwx0pykO/Lb2ycAhw
         h78tTpZ3dF3vsrzhxV69qGPJXkE0Eva+FZMps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070037; x=1740674837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZPfZYNg8NOtUAiK1S11L7/kf32fZfQ/BKwR+IkGA/Y=;
        b=Ikj3B5wMgzKQlFfVLdFh04wCVWGDhPbgfD65lqtWfoNCtn2eof1PRgufsilhk2/EBv
         Ch5ROcr3+4ZWIhCWTKtlWj/iudvq0pjvk75TJsZgb0t6maD44K9UADTdyZFfOULrqP5C
         aQr6vDcSmJyKYoCdpkxFEiv0l47cpLo5EisVzgIWQtvdJ78aLHoUXgpxAtD2TG7XZLXi
         2SaBKmtWHEds60kwvdnY1lDRuJGY401J5/NIzfgJItLWX342S+3CE8Cj6pYvLGKaAPiC
         twDYnQPig2jQjgaz2/dAmBatgWWjYhMV6fKFWogHRBZHDYziHcv0Fbr8h6Jp8UKsrs3a
         P2VA==
X-Forwarded-Encrypted: i=1; AJvYcCV/PoYOG28sX/gB5EvBmwyb3603IacULa5z+pr+hsNTL/jZaiX7LCTeb0776sFzNOcCKXfW3dq1CGAQHjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExTj5waHFYkWYO7Gs/Tq82VF8jORwyOJ5/uWw7gqpxiJSJ7jb
	qixVobXAg2EEcpzj34za00Z14yujr35+lLKjEfZHbQgyrTFsXW6o3UUipUuwqk5Wk1KyHs/PcYJ
	g1tM=
X-Gm-Gg: ASbGncvn1p3LK8tGb9fU2EAWmX5/elf9esn3ZdjhVEIMgnmrNF9cM0y3GDK2aaYdmZQ
	PJkxJEWQABh5iTZ36IQiuC2SthCqFbeWctjXRtsZfx9ZtZacxIRv1k5GbOd2BFOlSQZIvf0J5cV
	wDHEPJnDciuTRC5qEELZywqYpuybTZ9XrspNe4r6G8wpmXVz7NIyjZ0Yyu8VVomh3W/TEvWsHzf
	0XgnqrZ1X3e4ZMGIuTMdi9X/0+MBEFrsvNktpStwBKydlTS2kqfMpZ6t4gR83PSa+MOI+yhtFtf
	GPnLVS3v30pa+IIiz1uWUhiFUIl12ENTnyBD15DQyfc3GLKTmzP/HefjN/CluIBfOw==
X-Google-Smtp-Source: AGHT+IFhqFoTEmCUyfzzP4aVbghhg8Ga5Q3lnrBpap68Vke8Q3uTyIENRIkyZwG72k+bUs7mHCrTnA==
X-Received: by 2002:a17:906:c113:b0:ab7:8930:5669 with SMTP id a640c23a62f3a-abc09a43488mr2641966b.18.1740070036805;
        Thu, 20 Feb 2025 08:47:16 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbab9e9863sm685870766b.64.2025.02.20.08.47.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:47:14 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaec61d0f65so248213566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:47:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUymc4T88knJTH0ataPyV1K9V2jSwMKnePvc7pC9K0byzJBD7enJUt/jdLerqIKKIrRvFpfa07Zi9CrWRA=@vger.kernel.org
X-Received: by 2002:a17:907:7743:b0:ab9:137d:f6e7 with SMTP id
 a640c23a62f3a-abc099ca6bfmr2068366b.7.1740070033907; Thu, 20 Feb 2025
 08:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh> <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh> <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
 <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
In-Reply-To: <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Feb 2025 08:46:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgb1g9VVHRaAnJjrfRFWAOVT2ouNOMqt0js8h3D6zvHDw@mail.gmail.com>
X-Gm-Features: AWEUYZnMkN-x0Rtej4417GBTUm2ZZTOyavgfNoxIwCkZFobkcHssn8sD-O-61LI
Message-ID: <CAHk-=wgb1g9VVHRaAnJjrfRFWAOVT2ouNOMqt0js8h3D6zvHDw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Jan Engelhardt <ej@inai.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 07:17, Jan Engelhardt <ej@inai.de> wrote:
>
>
> On Thursday 2025-02-20 14:23, H. Peter Anvin wrote:
> >
> >People writing C seem to have a real aversion for using structures
> >as values (arguments, return values or assignments) even though that
> >has been valid since at least C90 and can genuinely produce better
> >code in some cases.
>
> The aversion stems from compilers producing "worse" ASM to this
> date, as in this case for example:

We actually use structures for arguments and return values in the
kernel, and it really does generate better code - but only for
specific situations.

In particular, it really only works well for structures that fit in
two registers. That's the magic cut-off point, partly due calling
convention rules, but also due to compiler implementation issues (ie
gcc has lots of special code for two registers, I am pretty sure clang
does too).

So in the kernel, we use this whole "pass structures around by value"
(either as arguments or return values) mainly in very specific areas.
The main - and historical: we've been doing it for decades - case is
the page table entries. But there are other cases where it happens.

The other problem with aggregate data particularly for return values
is that it gets quite syntactically ugly in C. You can't do ad-hoc
things like

   { a, b } = function_with_two_return_values();

like you can in some other languages (eg python), so it only tends to
work cleanly only with things that really are "one" thing, and it gets
pretty ugly if you want to return something like an error value in
addition to some other thing.

Again, page table entries are a perfect example of where passing
aggregate values around works really well, and we have done it for a
long long time because of that.

            Linus

