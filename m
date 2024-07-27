Return-Path: <linux-kernel+bounces-263961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AE93DD34
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 06:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EF61F22D86
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC74A15;
	Sat, 27 Jul 2024 04:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dHvxKA1y"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA41878
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722053677; cv=none; b=dUPaRxz0MzC8GBW6xYSpFVK7GeDP6pG9USK+IFknQ4fknGa1FF64RB+FQs6Txyr7s5lBdhedk3PZ17uzzbOdiaQx188kSIeCvwhWrczY1jvGf2drEoBn4vdyP1cF6Ry42ySmxjp1aADqeUqRvZBslz6MXrnKz3Phq+MSvz9mT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722053677; c=relaxed/simple;
	bh=ifQlKN1PjdPIsxjRv4FyhRN4lI0qg+pxZuRgccls2JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFRl6XTuKfzTMsIUg/I3Z1uD7IXjg7gR9gc87BRl7ldSZuaeTjH36NSMysGBgJliKHacq7QHP1/1HnCQ7a6CppzV2aX4R6U8xbtT+1itCZG9l5zRh4MNgQeCGWsgrdqfr4a4eiSD5GHQkCBLfWV7H278hL005iApIROvfitOcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dHvxKA1y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so2868813a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722053674; x=1722658474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdoGPVGOJdTSJBEJYz1txw6FSr0M3uKfD65VIGxFtV8=;
        b=dHvxKA1yFJcR42y8AKP7plYS9XXA0tYb7ZJ5NOVIDuW+FqrqbSIGDLEmNv4aBojQaj
         exduu2BCqVZUb7ZwTfsDzW9pVWOvMxLNYIYwTjRYpC/wSaXBg7CkCX50ebQ9f4LVyiOb
         UT3JpLEtu0IgpsvIQUMrIJerGHD3Hc8RcElSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722053674; x=1722658474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdoGPVGOJdTSJBEJYz1txw6FSr0M3uKfD65VIGxFtV8=;
        b=h0jSOVcmTxTCpSFi9tN509/58JAfRgbiRNdEW/KGfYAMrpwmr9TpNNBiQUywa/4q+9
         lV0OqwzV/WqxBsjEY/v/sLK1D1YUBUAKWUd7geiwDwm2JIMaZeGV+g9AEEErpt6LXpQg
         ybk6bX4MhqFQBW6vMxiITbNaqHVbgDeZAzOpuGtZaVoaxtWdpl9lnsrCWez/Wov2fBRJ
         kv8p+VmmkA1MNbApG15r3PWzLKAMLYnir9AklUhJkH6ZpcLOuL0iuulkx9eRF3WWkhHU
         Rh43s4tZS7/j6ImHdqN9os3xswg/3kBdZzAoCevzSDXmM4RJMkDb83uqrgbCA/31AVCf
         z8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVXrt0Mjy3i0LnPf72dKu3HCmmodoW/i7J3CrkDupCciTFaWi/ci4QMW82WaPTsCSvBHM4RcRixrsMp+pMr2RxRCtwvVxezAnGsMQwa
X-Gm-Message-State: AOJu0YxvXmDfZjsVxhOVIEdSerZ523Q2UC4rLaoROPLhgCWapBVA8pUB
	yHD9sgiUfpyNkM654l/TU5bqRTyxAuXMA9SZOj6t5Gd4KmKxwppxezQ4jO+DK8XqGnVmHS41vMq
	R0KhZvw==
X-Google-Smtp-Source: AGHT+IEfoESYys6NWTk+UqVejVZ0GF9k9e36DuOoBZbS6deBMG5htxuBc/LNcOSE7jCZUmOjT6Pgbg==
X-Received: by 2002:a50:d55c:0:b0:57c:78fb:1a32 with SMTP id 4fb4d7f45d1cf-5b020ba8220mr713491a12.19.1722053673760;
        Fri, 26 Jul 2024 21:14:33 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6358fa5esm2627640a12.32.2024.07.26.21.14.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 21:14:31 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so3768503a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:14:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAJMmh5Dphg5ok/Tm3kIZ9n4LYpYD4ZgFpvTVzI0DOiwZI9+YtPavA7SWMjLNXsQNhO9JC/KTTk8tAtxioq8zE+72au8cxTtwBkj7n
X-Received: by 2002:a50:aa8a:0:b0:58b:35ef:88c4 with SMTP id
 4fb4d7f45d1cf-5b0223da61bmr541713a12.37.1722053671382; Fri, 26 Jul 2024
 21:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local> <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local> <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local> <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com> <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
In-Reply-To: <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 26 Jul 2024 21:14:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbKvEWejk-t9s_k=JJk0bj4Wtz=QsKCcYJUij3OS3_pQ@mail.gmail.com>
Message-ID: <CAHk-=wjbKvEWejk-t9s_k=JJk0bj4Wtz=QsKCcYJUij3OS3_pQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="0000000000005e5339061e32dd05"

--0000000000005e5339061e32dd05
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 21:13, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> Anyway, I'm throwing this out in the hopes that somebody will use this
> to go "look, file XYZ generates a ridiculous X-megabyte line".

Oh, and by "throwing this out" I meant to actually include the updated
"longest-line.c".

And somebody sane can write it in two lines of perl instead.

                Linus

--0000000000005e5339061e32dd05
Content-Type: text/x-csrc; charset="US-ASCII"; name="longest-line.c"
Content-Disposition: attachment; filename="longest-line.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lz3ma6ik0>
X-Attachment-Id: f_lz3ma6ik0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxjdHlwZS5oPgojaW5jbHVkZSA8c3RkbGliLmg+
CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8ZmNudGwu
aD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CgpzdGF0aWMgdm9pZCBkaWUoY29uc3QgY2hhciAqcmVh
c29uKQp7CglmcHJpbnRmKHN0ZGVyciwgIkZhdGFsOiAlc1xuIiwgcmVhc29uKTsKCWV4aXQoMSk7
Cn0KCnN0YXRpYyB1bnNpZ25lZCBsb25nIGZpbmRfbGluZShjb25zdCBjaGFyICpsaW5lLCB1bnNp
Z25lZCBsb25nIGxlbikKewoJdW5zaWduZWQgbG9uZyByZXMgPSAwOwoJZG8gewoJCXJlcysrOwoJ
CWlmICgqbGluZSA9PSAnXG4nKQoJCQlicmVhazsKCQlsaW5lKys7Cgl9IHdoaWxlICgtLWxlbik7
CglyZXR1cm4gcmVzOwp9CgovKgogKiBCeSB0aGlzIHRpbWUsIHdlIGtub3cgdGhlIGxpbmUgbGVu
Z3RoLCBhbmQgaXQgaGFzIGJlZW4KICogTlVMLXRlcm1pbmF0ZWQuIFdlIGNhbiBjaGFuZ2UgaXQg
YW5kIHVzZSB0aGUgdW5kZXJseWluZwogKiBkYXRhIGlmIHdlIGZpbmQgYSBwcmVwcm9jZXNzb3Ig
bGluZW1hcmtlci4KICovCnZvaWQgdHJhY2tfY3BwX2xpbmVfbnVtYmVyKGNoYXIgKmxpbmUsIHVu
c2lnbmVkIGxvbmcgbGVuLAoJaW50ICpsaW5lbm8sIGNvbnN0IGNoYXIgKipmaWxlbmFtZSkKewoJ
dW5zaWduZWQgbG9uZyBudW07CgljaGFyICplbmQ7CgoJaWYgKGxpbmVbMF0gIT0gJyMnKQoJCXJl
dHVybjsKCWlmIChsaW5lWzFdICE9ICcgJykKCQlyZXR1cm47CgoJbGluZSArPSAyOwoJbGVuIC09
IDI7CgoJbnVtID0gc3RydG91bChsaW5lLCAmZW5kLCAxMCk7CglpZiAoIW51bSkKCQlyZXR1cm47
CglpZiAoZW5kID09IGxpbmUpCgkJcmV0dXJuOwoKCWxlbiAtPSBlbmQgLSBsaW5lOwoJbGluZSA9
IGVuZDsKCgkvLyBSZW1vdmUgZmxhZyBhdCB0aGUgZW5kCglpZiAobGVuID4gMikgewoJCWlmIChs
aW5lW2xlbi0yXSA9PSAnICcgJiYgaXNkaWdpdChsaW5lW2xlbi0xXSkpIHsKCQkJbGluZVtsZW4t
Ml0gPSAwOwoJCQlsZW4gLT0gMjsKCQl9CQkJCgl9CgoJLy8gUmVtb3ZlIHNwYWNlcyBmcm9tIGVu
ZAoJd2hpbGUgKGxlbiA+IDEgJiYgbGluZVtsZW4tMV0gPT0gJyAnKQoJCWxpbmVbLS1sZW5dID0g
MDsKCgkvLyBXZSdyZSBkb25lIHdpdGggJ2xlbicgbm93LCBkb24ndCBib3RoZXIgKi8KCXdoaWxl
ICgqbGluZSA9PSAnICcpCgkJbGluZSsrOwoKCWlmICgqbGluZSA9PSAnIicpIHsKCQllbmQgPSBz
dHJjaHIoKytsaW5lLCAnIicpOwoJCWlmIChlbmQpCgkJCSplbmQgPSAwOwoJfQoJd2hpbGUgKCFz
dHJuY21wKGxpbmUsICIuLyIsIDIpKQoJCWxpbmUgKz0gMjsKCgkqbGluZW5vID0gbnVtLTE7Cglp
ZiAoKmxpbmUpCgkJKmZpbGVuYW1lID0gbGluZTsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KQp7CglzdHJ1Y3Qgc3RhdCBzdDsKCWNoYXIgKmJ1ZjsKCXVuc2lnbmVkIGxvbmcgc2l6
ZTsKCWxvbmcgbG9uZ2VzdF9sZW4gPSAwOwoJY2hhciAqbG9uZ2VzdF9saW5lID0gIiI7CglpbnQg
bG9uZ2VzdF9saW5lbm8gPSAwOwoJY29uc3QgY2hhciAqbG9uZ2VzdF9maWxlID0gIiI7Cgljb25z
dCBjaGFyICpmaWxlOwoJY29uc3QgY2hhciAqdW5pdDsKCWludCBsaW5lbm8gPSAwLCBmZDsKCglm
ZCA9IDA7CglmaWxlID0gInN0ZGluIjsKCWlmIChhcmdjID4gMSkgewoJCWZpbGUgPSBhcmd2WzFd
OwoJCWZkID0gb3BlbihmaWxlLCBPX1JET05MWSk7CgkJaWYgKGZkIDwgMCkgZGllKCJvcGVuIik7
Cgl9CgoJaWYgKGZzdGF0KGZkLCAmc3QpKSBkaWUoInN0YXQiKTsKCWlmICghU19JU1JFRyhzdC5z
dF9tb2RlKSkgZGllKCJOb3QgYSByZWd1bGFyZmlsZSIpOwoJc2l6ZSA9IHN0LnN0X3NpemU7Cgli
dWYgPSBtYWxsb2Moc2l6ZSsxKTsKCWlmICghYnVmKSBkaWUoIm1hbGxvYyBmYWlsZWQiKTsKCWlm
IChyZWFkKGZkLCBidWYsIHNpemUpICE9IHNpemUpIGRpZSgicmVhZCBmYWlsZWQiKTsKCglmb3Ig
KGxpbmVubyA9IDE7IHNpemU7IGxpbmVubysrKSB7CgkJdW5zaWduZWQgbG9uZyBsZW47CgkJY2hh
ciAqbGluZSA9IGJ1ZjsKCgkJLyogRmluZCB0aGUgbGluZSwgTlVMLXRlcm1pbmF0ZSBpdCAqLwoJ
CWxlbiA9IGZpbmRfbGluZShidWYsIHNpemUpOwoJCWJ1ZltsZW4tMV0gPSAwOwoKCQlidWYgKz0g
bGVuOwoJCXNpemUgLT0gbGVuOwoKCQkvKiBUcmFjayBwcmVwcm9jZXNzb3IgaW5mbyAqLwoJCXRy
YWNrX2NwcF9saW5lX251bWJlcihsaW5lLCBsZW4tMSwgJmxpbmVubywgJmZpbGUpOwoKCQlpZiAo
bGVuIDw9IGxvbmdlc3RfbGVuKQoJCQljb250aW51ZTsKCgkJbG9uZ2VzdF9sZW4gPSBsZW47CgkJ
bG9uZ2VzdF9saW5lID0gbGluZTsKCQlsb25nZXN0X2ZpbGUgPSBmaWxlOwoJCWxvbmdlc3RfbGlu
ZW5vID0gbGluZW5vOwoJfQoKCS8qIExpbWl0IHByaW50b3V0IG9mIGxvbmdlc3QgbGluZSBhcmJp
dHJhcmlseSAqLwoJaWYgKGxvbmdlc3RfbGVuID4gMTA0KQoJCW1lbWNweShsb25nZXN0X2xpbmUg
KyAxMDAsICIuLi4iLCA0KTsKCgl1bml0ID0gIiBieXRlcyI7CglpZiAobG9uZ2VzdF9sZW4gPiAx
MCoxMDI0KSB7CgkJdW5pdCA9ICJrQiI7CgkJbG9uZ2VzdF9sZW4gPSAobG9uZ2VzdF9sZW4rNTEy
KSAvIDEwMjQ7Cgl9CgoJcHJpbnRmKCJMb25nZXN0IGxpbmUgaXMgJXM6JWQgKCVsdSVzKVxuIiwK
CQlsb25nZXN0X2ZpbGUsCgkJbG9uZ2VzdF9saW5lbm8sCgkJbG9uZ2VzdF9sZW4sIHVuaXQpOwoJ
cHJpbnRmKCIgICAnJXMnXG4iLCBsb25nZXN0X2xpbmUpOwoJcmV0dXJuIDA7Cn0K
--0000000000005e5339061e32dd05--

