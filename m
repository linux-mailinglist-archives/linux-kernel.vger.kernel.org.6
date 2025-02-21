Return-Path: <linux-kernel+bounces-526786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD4A40345
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1CA87AEE1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299BD205E04;
	Fri, 21 Feb 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UjsL/1Bh"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B561FF5EF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179067; cv=none; b=t5pCVE/eSz4gBFzvrFgklBkZQDjMqC0U7Z2NOv5SERKrycotTrWBlNL2YKsgm1jk9/neqYDVKbvqE/etOvDKQqkIDaXlTheEaHOO/Wvsr7I5+JMgy0QnVTG5EwdhhPDhmJPOvb3Vcev6596t/k5BxMEbUlfaDkWyQWvWABv4BIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179067; c=relaxed/simple;
	bh=TpbP32x3fqhhq+Cun0agcs/GSxbQZ4+wDorQANa2i5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9owK4frUYGz4L0aoDQHaH7itAkXCgnWgVxCfXhdoCRf1G3aHsdnMMTSl2/M7ijzz0iEaGnfGEUnjwJVjIOPsliN8B+ss715QvL4C3p87xU7GWZKNKuUPlwSsz1xUlBp+2CkhWHht176qyzvIri23zctVK0kiktTaUML/RRxX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UjsL/1Bh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaec61d0f65so519561566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740179063; x=1740783863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IYwQB8m9ANwEOGQVayzecy1Wa9/uVkJW9TozXVMdMGM=;
        b=UjsL/1BhIczzcsE2cKwavuXXOXablBhssaGhPAygYuta0iR5GcbURCb2I9yy7vMU8w
         casD+P4nvqo64t9OWtMweoUlstr9b9X1g+ZQejT5DMMq/8qddPYeYHmeKXM/QqUOO4zr
         3Exoo182M0d8Q36Y9pdKX6K1pmzzF+t3zY+LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740179063; x=1740783863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYwQB8m9ANwEOGQVayzecy1Wa9/uVkJW9TozXVMdMGM=;
        b=Er3e1AOpHDGJhgfyrbipa+63IUf/Dfx0ygpBBI46DqEO1IxVe58MF1PZEg8cgKULY1
         Xr5VX/ylJGEKYrfYyafY4MMho38hQOwDK6JAU3WERB4fP/5l7RzU74HZfZ+LuBSwfy8z
         K4GAjhcICENSHIvLgqq4n5k2/7nXb+aLyXAAEYK6UcofERl4u/YZR4ArPpmbG6WTLYfd
         qBhSg/d7qrGbX05vzZmYGGnQCMDEyvT9eT3Mcwde0QccnQPLYt9h1QC/a401lUvvnYUW
         6OybTrofTR8WHIHecRXgifaZ4Zn5odvs6Zy5JrnCpjaKdZxaGkUy4MniXiY0RvetlPZi
         8jlA==
X-Forwarded-Encrypted: i=1; AJvYcCUIiSt9pwqH82v5PWm6nSHLZ6K+KIKS+FUij0eK5Qzt7KVLBJvCxJf092PdoloBxGX1SU3k6WeUbhZQ4eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCSNTOxNrhfUGUfjveIyX9iF4/650nRx2z+1Br8KTOYuE+/bM
	AkTo/rF+grceK/yFGyeNAz1QMIsuMqUD0eaXW0N2h4thOAGPfi9r+NMhbP/THYW4IRnTeck/KpY
	UMgQ=
X-Gm-Gg: ASbGncuaIQTxtFM4YZNNbhWUt4wf74jKE0Yp0W/Hvb116Y5FuyiQ1YZqA3GJUT/qP1R
	XOiyAoqd4q9nYBZLZws8vATgHj43SEjLzria9AsuXZjM1R3pMrecGfEOme1IM+1933vo2o3l8pj
	7xPoINfSEMy0XfSTwmfcR5wyN2Z1aKgFyraInt6AMG/fLH9F8RsnforAU70Z1f8+dgO8tamlymh
	iLc4+VKViXoqZKg2TGds+ylMJPybGJtnGdPRcEZWb2IoInefa9k25G0K1PUtmId83FwDP60qiXx
	POwZk83St+Kq+tFQfHQvdDewp59c+devu0M7tdaZWoze8FxS4SM4fMJ210lgFcI9aBby82vy7lz
	i
X-Google-Smtp-Source: AGHT+IHwg7xu1IgzsUCkMhknZbEqNLbrwQ7Gd9tC0CA1MlMUG8e8PvVp1y1Da54G/J7XXMwPcKKn+A==
X-Received: by 2002:a17:907:7743:b0:ab9:137d:f6e7 with SMTP id a640c23a62f3a-abc099ca6bfmr475001166b.7.1740179063327;
        Fri, 21 Feb 2025 15:04:23 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb78ea4c1asm1282214566b.123.2025.02.21.15.04.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:04:22 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaec61d0f65so519553166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:04:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgcsikV6F8h1Hb6o7iDIoNJCpjypBRTr9MoD2FHe9Lswjbm70oW0foe5/mz0YTtOz/bjBFsVINlejPIEc=@vger.kernel.org
X-Received: by 2002:a17:907:96a5:b0:abb:9d27:290f with SMTP id
 a640c23a62f3a-abc099d60famr532638966b.9.1740179061249; Fri, 21 Feb 2025
 15:04:21 -0800 (PST)
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
 <CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com> <20250221172415.5b632ae6@gandalf.local.home>
In-Reply-To: <20250221172415.5b632ae6@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Feb 2025 15:04:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQ94GipftbNo0PbfuUxFMXFyp2bWGJJPNUngyf17Ai8A@mail.gmail.com>
X-Gm-Features: AWEUYZnMjA5m9nYAw69o9RC1JcJoFjtIPhAhLMih9-38H4I5IZG87DXfXWjPW04
Message-ID: <CAHk-=wjQ94GipftbNo0PbfuUxFMXFyp2bWGJJPNUngyf17Ai8A@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Uecker <uecker@tugraz.at>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 14:23, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> If I could just get a warning for this stupid mistake:
>
>         size_t ret;
>
>         ret = func();
>         if (ret < 0)
>                 error();

Note that my main beef with the crazy compiler warning is that it
literally triggers for *RANGE CHECKS*.

IOW, it's literally the "if (a < 0 || a > XYZ)" thing that absolutely
MUST NOT WARN. EVER.  If it does, the compiler is broken.

And gcc still warns of it with -Wtype-limits. So we turn that garbage off.

It's worth noting that "-Wtype-limits" is simply a broken concept for
other reasons too. It's not just the "unsigned type cannot be
negative" thing. It has the exact same problems on the other end.

Imagine that you have macros that do sanity testing of their
arguments, including things like checking for overflow conditions or
just checking for invalid values. What a concept - safe programming
practices with proper error handling.

Now imagine that you pass that an argument that comes from - for
example - a "unsigned char". It's the same exact deal. Now the
compiler warns about YOUR CODE BEING CAREFUL.

See why I hate that warning so much? It's fundamentally garbage, and
it's not even about your error condition at all.

Now, what *might* actually be ok is a smarter warning that warns about
actual real and problematic patterns, like your particular example.

Not some garbage crazy stuff that warns about every single type limit
check the compiler sees, but about the fact that you just cast a
signed value to an unsigned type, and then checked for signedness, and
you did *not* do a range check.

Warning for *that* might be a sane compiler warning.

But notice how it's fundamentally different from the current
sh*t-for-brains warning that we explicitly disable because it's broken
garbage.

So don't confuse a broken warning that might trigger for your code
with a good warning that would also trigger for your code.

            Linus

