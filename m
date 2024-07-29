Return-Path: <linux-kernel+bounces-266565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93309401B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF731C21BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4518EFC9;
	Mon, 29 Jul 2024 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z3vYaULv"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E41288BD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722295295; cv=none; b=FHMxcvzp6XDyrXuBTfWx0LwmD/saaPRJhdeYUGcnE0kkw8oYrcrMQz5UXDBaMHn7l86QbN8n/ggebhq9/MeeoJUd8MeDZDS/Wa039FDQokkdmGwaFsdCTQVjhz8ga/TFEJo49IN75RJsm9xgbK/ZR+bjoJPVQ7YXs1G+TsqIi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722295295; c=relaxed/simple;
	bh=/9phoNgPp9WyJlxkDiCD3Qa9K9Jpubg/nndC9LmlfAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5T/y5cJi2yZ/Jw0bNCM7py1nx4B5Y+CvSee9BqVes+TpIk97Xg3bQRkrup9WC2t1+BYmcy9S4YGLJz/3OlVfgH4oW9SHt5sN52Ta2M9uT5vLFrkvqT/rPngbeflWLwU6mpsOiTEbx17z/GhKslRt/J4EbTTQEQlb4Lzy0auYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z3vYaULv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7ad02501c3so480540866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722295292; x=1722900092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LASEM829adRkz7w4jW5HtRBYZiPJZupt6BwirTSZmIk=;
        b=Z3vYaULvrUIuL6K6i9OAQDinorzTzpcsJZgH4HDtWdb8OZo34Rwx6jiILO/ZDKbTgU
         wecLfMNUOmG1lEXVFcV0uOExLkrfG/qgXaw+2kZXRbCKT93ob/kJhz2ckhqBwyrj0Jne
         1suWCSqQmsFqawQLv3nXAxJIzuKpLVMPJn+Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722295292; x=1722900092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LASEM829adRkz7w4jW5HtRBYZiPJZupt6BwirTSZmIk=;
        b=vJ4omqGpC9TMFPGxLhzncM5xrKmLqmRAT3qeePwhFODOa/JV5K8QEydhqjBZdF6W1g
         xGQucnQI9C1KcFGUp/jgwlkbyEQ76FSYCNiXKvA7e6z526XuZ9rtfCSfwDMtcG6Ifmu4
         egsfeqk9xx12VkzXJVDyyZFCXxtIAEyolbHx4zxCf7QUJBy/Iuse80tg4TIXI4s1Orev
         cosrbhmmSOKCP1IlTCouK7UND5XKTMCPdbqu0hRJcMHWDtHWnfC8nn3mUsILHX478zZA
         vm65n/jn07YCTjg0Vvq8mziAUes74FgEmAXLFRHvw3E1RfmRWHY/6d+C48CwYNtpqGgK
         DNzw==
X-Forwarded-Encrypted: i=1; AJvYcCUYUp3Q497pnvSABo1VnXg9/E3uT4BsxvxJr2euCVuOawNvguz/F3QX2OUA4R9kGsVtfphZexH02M1bA2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbct3ywLFMsVBTOKaIw63Bu1I/JOq1h4VB8nAi4U42sYqhPoSH
	ENiFYG7xaT6cNA6UWNBVpK98abJB50kW5hueo7swlXhoNAXjtDNjRP3THqB98jKvCYTfDe1eVVD
	gU5/o5w==
X-Google-Smtp-Source: AGHT+IGVWQM2k1xsvp3XkwSrrONIpTaqlE4YzWSw+I0Q5zkCTPO+iKpafcnnPNSLPhZE+/cxn2pIXg==
X-Received: by 2002:a17:907:96a0:b0:a6f:ddb3:bf2b with SMTP id a640c23a62f3a-a7d3ffe615bmr831949066b.41.1722295291589;
        Mon, 29 Jul 2024 16:21:31 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236a2sm564232666b.29.2024.07.29.16.21.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 16:21:29 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so5793045a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:21:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX00PulBkxg1V/310CVTcBsg4p704C4FTzvd6OxXn5TCUrGnERDTqFVcWpPF39UMwfI116HYW7yFMhXVdQ=@vger.kernel.org
X-Received: by 2002:a05:6402:3496:b0:5a1:1:27a9 with SMTP id
 4fb4d7f45d1cf-5b020ba7fe5mr7307860a12.18.1722295287486; Mon, 29 Jul 2024
 16:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com> <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com> <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com>
In-Reply-To: <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 29 Jul 2024 16:21:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
Message-ID: <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: multipart/mixed; boundary="000000000000cf58ab061e6b1ea8"

--000000000000cf58ab061e6b1ea8
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 15:25, Arnd Bergmann <arnd@kernel.org> wrote:
>
> - My macros use __builtin_choose_expr() instead of ?: to
>   ensure that the arguments are constant, this produces a
>   relatively clear compiler warning when they are not.
>   Without that, I would expect random drivers to start
>   using MIN()/MAX() in places where it's not safe.

Hmm. We have known non-constant uses, which Stephen Rothwell pointed
out elsewhere, with PowerPC having things like this:

  #define PAGE_SHIFT              CONFIG_PAGE_SHIFT
  extern unsigned int hpage_shift;
  #define HPAGE_SHIFT hpage_shift
  #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)

and honestly, considering the absolutely *horrid* mess that is the
current min/max expansion, I really think that using MIN/MAX for these
kinds of expressions is the right thing to do.

I don't worry about architecture code that has a boot-time
pseudo-constant for some inherent property.  I worry about random
drivers doing crazy things.

But it is *not* a constant, and any MIN/MAX that disallows it is imho
not a good MIN/MAX.

What we actually care about is not "constant", but "no side effects".

And obviously the typing, but that ends up being really hard.

We could possibly require that the typing be extra strict for MIN/MAX,
using the old __typecheck(x, y) macro we used to use. That literally
requires the *same* types, but that then ends up being pointlessly
painful for the "actual constant" cases, because dammit, a regular
non-negative integer constant should compare with any type.

It's a real pain that compiler writers can't just get the simple cases
right and give us a sane "__builtin_ordered_ok()" kind of thing.
Instead they push things like the absolute unusable garbage that is
-Wsign-compare.

Anyway, I also completely gave up on another absolute standard garbage
thing: _static_assert(). What a horrendous piece of sh*t that is.
Replacing our use of that with our own BUILD_BUG_ON_MSG() made a lot
of things much much simpler.

Attached is the patch I have in my tree right now - it complains about
a 'bcachefs' comparison between an 'u16' and a 's64', because I also
removed the 'implicit integer promotion is ok' logic, because I think
it's wrong.

I don't think a min(u16,s64) is a valid minimum, for exactly the same
reason a min(u32,s64) is not valid.

Despite the C integer expression promotion rules.

             Linus

--000000000000cf58ab061e6b1ea8
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lz7m4th50>
X-Attachment-Id: f_lz7m4th50

IGluY2x1ZGUvbGludXgvbWlubWF4LmggfCAzNCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9taW5tYXguaCBiL2luY2x1ZGUvbGludXgvbWlu
bWF4LmgKaW5kZXggZTNlNDM1M2RmOTgzLi43YWQ5OTJkNWU0NjQgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvbWlubWF4LmgKKysrIGIvaW5jbHVkZS9saW51eC9taW5tYXguaApAQCAtMjYsMTkg
KzI2LDIzIEBACiAjZGVmaW5lIF9fdHlwZWNoZWNrKHgsIHkpIFwKIAkoISEoc2l6ZW9mKCh0eXBl
b2YoeCkgKikxID09ICh0eXBlb2YoeSkgKikxKSkpCiAKLS8qIGlzX3NpZ25lZF90eXBlKCkgaXNu
J3QgYSBjb25zdGV4cHIgZm9yIHBvaW50ZXIgdHlwZXMgKi8KLSNkZWZpbmUgX19pc19zaWduZWQo
eCkgCQkJCQkJCQlcCi0JX19idWlsdGluX2Nob29zZV9leHByKF9faXNfY29uc3RleHByKGlzX3Np
Z25lZF90eXBlKHR5cGVvZih4KSkpLAlcCi0JCWlzX3NpZ25lZF90eXBlKHR5cGVvZih4KSksIDAp
CisvKgorICogX19zaWduX3VzZSBmb3IgaW50ZWdlciBleHByZXNzaW9uczoKKyAqICAgYml0IDEg
c2V0IGlmIG9rIGZvciBzaWduZWQgY29tcGFyaXNvbnMsCisgKiAgIGJpdCAyIHNldCBpZiBvayBm
b3IgdW5zaWduZWQgY29tcGFyaXNvbnMKKyAqCisgKiBJbiBwYXJ0aWN1bGFyLCBub24tbmVnYXRp
dmUgaW50ZWdlciBjb25zdGFudHMKKyAqIGFyZSBvayBmb3IgYm90aC4KKyAqLworI2RlZmluZSBf
X3NpZ25fdXNlKHgsdXgpIFwKKwkoaXNfc2lnbmVkX3R5cGUodHlwZW9mKHV4KSk/MSsyKl9faXNf
bm9ubmVnKHgsdXgpOjIpCiAKIC8qIFRydWUgZm9yIGEgbm9uLW5lZ2F0aXZlIHNpZ25lZCBpbnQg
Y29uc3RhbnQgKi8KLSNkZWZpbmUgX19pc19ub25lZ19pbnQoeCkJXAotCShfX2J1aWx0aW5fY2hv
b3NlX2V4cHIoX19pc19jb25zdGV4cHIoeCkgJiYgX19pc19zaWduZWQoeCksIHgsIC0xKSA+PSAw
KQorI2RlZmluZSBfX2lzX25vbm5lZyh4LHV4KSBcCisJKF9fYnVpbHRpbl9jb25zdGFudF9wKHgp
ICYmICEoKGxvbmcgbG9uZykoeCk+PjYzKSkKIAotI2RlZmluZSBfX3R5cGVzX29rKHgsIHksIHV4
LCB1eSkgCQkJCVwKLQkoX19pc19zaWduZWQodXgpID09IF9faXNfc2lnbmVkKHV5KSB8fAkJCVwK
LQkgX19pc19zaWduZWQoKHV4KSArIDApID09IF9faXNfc2lnbmVkKCh1eSkgKyAwKSB8fAlcCi0J
IF9faXNfbm9uZWdfaW50KHgpIHx8IF9faXNfbm9uZWdfaW50KHkpKQorI2RlZmluZSBfX3R5cGVz
X29rKHgsIHksIHV4LCB1eSkgXAorCSghIShfX3NpZ25fdXNlKHgsdXgpICYgX19zaWduX3VzZSh5
LHV5KSkpCiAKICNkZWZpbmUgX19jbXBfb3BfbWluIDwKICNkZWZpbmUgX19jbXBfb3BfbWF4ID4K
QEAgLTUzLDggKzU3LDggQEAKIAogI2RlZmluZSBfX2NhcmVmdWxfY21wX29uY2Uob3AsIHgsIHks
IHV4LCB1eSkgKHsJCVwKIAlfX2F1dG9fdHlwZSB1eCA9ICh4KTsgX19hdXRvX3R5cGUgdXkgPSAo
eSk7CVwKLQlzdGF0aWNfYXNzZXJ0KF9fdHlwZXNfb2soeCwgeSwgdXgsIHV5KSwJCVwKLQkJI29w
ICIoIiAjeCAiLCAiICN5ICIpIHNpZ25lZG5lc3MgZXJyb3IsIGZpeCB0eXBlcyBvciBjb25zaWRl
ciB1IiAjb3AgIigpIGJlZm9yZSAiICNvcCAiX3QoKSIpOyBcCisJQlVJTERfQlVHX09OX01TRygh
X190eXBlc19vayh4LCB5LCB1eCwgdXkpLCAJXAorCQkjb3AiKCIjeCIsICIjeSIpIHNpZ25lZG5l
c3MgZXJyb3IiKTsJXAogCV9fY21wKG9wLCB1eCwgdXkpOyB9KQogCiAjZGVmaW5lIF9fY2FyZWZ1
bF9jbXAob3AsIHgsIHkpIFwKQEAgLTcwLDggKzc0LDEwIEBACiAJc3RhdGljX2Fzc2VydChfX2J1
aWx0aW5fY2hvb3NlX2V4cHIoX19pc19jb25zdGV4cHIoKGxvKSA+IChoaSkpLCAJXAogCQkJKGxv
KSA8PSAoaGkpLCB0cnVlKSwJCQkJCVwKIAkJImNsYW1wKCkgbG93IGxpbWl0ICIgI2xvICIgZ3Jl
YXRlciB0aGFuIGhpZ2ggbGltaXQgIiAjaGkpOwlcCi0Jc3RhdGljX2Fzc2VydChfX3R5cGVzX29r
KHV2YWwsIGxvLCB1dmFsLCB1bG8pLCAiY2xhbXAoKSAnbG8nIHNpZ25lZG5lc3MgZXJyb3IiKTsJ
XAotCXN0YXRpY19hc3NlcnQoX190eXBlc19vayh1dmFsLCBoaSwgdXZhbCwgdWhpKSwgImNsYW1w
KCkgJ2hpJyBzaWduZWRuZXNzIGVycm9yIik7CVwKKwlCVUlMRF9CVUdfT05fTVNHKCFfX3R5cGVz
X29rKHV2YWwsIGxvLCB1dmFsLCB1bG8pLAkJCVwKKwkJImNsYW1wKCIjdmFsIiwgIiNsbyIsIC4u
Likgc2lnbmVkbmVzcyBlcnJvciIpOwkJCVwKKwlCVUlMRF9CVUdfT05fTVNHKCFfX3R5cGVzX29r
KHV2YWwsIGhpLCB1dmFsLCB1aGkpLAkJCVwKKwkJImNsYW1wKCIjdmFsIiwgLi4uLCAiI2hpIikg
c2lnbmVkbmVzcyBlcnJvciIpOwkJCVwKIAlfX2NsYW1wKHV2YWwsIHVsbywgdWhpKTsgfSkKIAog
I2RlZmluZSBfX2NhcmVmdWxfY2xhbXAodmFsLCBsbywgaGkpIFwK
--000000000000cf58ab061e6b1ea8--

