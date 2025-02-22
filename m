Return-Path: <linux-kernel+bounces-527414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF38A40B05
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBE13A91AA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824BB20E6E0;
	Sat, 22 Feb 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I0Gh8IY3"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15613A258
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249768; cv=none; b=SuZ8ZS1DqQ72kz4+S9NHNP5TSDZXcgohCyR52xWupo5XbsaNzM6/73LwYx9UJPbmjzVMgEppIyiNIZHKmEpbsiEVzb5m+3rBbdgl/+f1qBxnI8zkvrsbWHmJ8Rz20/Hb+cYCvIHfgFmjxvecKom3rBfTnnky7xrUDmC7XK6ki+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249768; c=relaxed/simple;
	bh=C3VVgceegZ24tig63EYv2teDL0e85OaPkzFlPQdOEzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XV+q5XeNc1xH/OrtjTDUkH2KM7LXiiDk8pIJkHjNRdegO16iOz1aw12yTTxLD2JZUH43h04/CL0Exmm1L5xSQnUAXnENpiiyZSgTpFTBuo6P8Y3cWYuBdQzDDwG+VtZWUQJHywnWUoGx5XIF4tYRPKgnN52Ew42HVFCnpBsQ0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I0Gh8IY3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e05717755bso4773067a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 10:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740249764; x=1740854564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rsdKAvmn536U8u2tCivHSpv9Bw6Q/s3vxIyTuoPRJB0=;
        b=I0Gh8IY3fgkcBRy2684NhPmR5RxJ6arAsqN55rTmto4uplpIqGZkJzFpIRnagFR/hC
         nhVMNdtcofyJsbryYnOkrse8lj4um5kpwvAxolh9fFjUoPOQexjnMJpo/+RZSAPgfCJV
         8gqu0iKrwSdc7SJhY+yk0XRUZdMGxb2u0czn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740249764; x=1740854564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsdKAvmn536U8u2tCivHSpv9Bw6Q/s3vxIyTuoPRJB0=;
        b=E4LbkUfpDtb+s6lyIcFgPjTkTPpELkEuYO8DhtPkqF2yhB81vo1U/jsFvSzHi3bkDn
         o/H4GmdOz07fMVCgMr4PiW4knbjC2xNuixGw9UAyePEDvMrZ52a4q6D/pqKlk/QxpphB
         5NmJ3mPKeLp2XkHkGsLSNyp5qwGNiiYmhg63OcW+Z9fZJiyewY6q2PkFTn+1HBbiojWb
         1lzAIqu3Pbimz9QkEU/u7CMuHZwJPorNMwJXs+fW8utBwCTUdi50QZpA/9lQFxd1rGt7
         PRuqWlvDuoYqEz1On88QCtrg2SMD5YuJusk5N/wH+wJN9vfuW9KBZ9mzJOlzqUWk++fJ
         0ejg==
X-Forwarded-Encrypted: i=1; AJvYcCViqJspcodOzktL7PgPf9D7sJnPcuIJYv7fv9NJlqaXN5920WDhfCFtBDFd2TzgLVR1KUtBRK1OBYOY8FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQi9iS5ftKwwprCIGKN0GXdoFcGa2lapo/UyfJECp3/3x0Xhhe
	1uK5yoDw0JRuslzHv/ONVNfHVUJuoZjAFUaaaHLtXU5WVFPFD3OyKQPSAUVX+NH2ZAV4qJjZpBu
	BXVo=
X-Gm-Gg: ASbGncv36ry9QwMnCilbNq0tGhdT1mmoHaUvPnwZdCKWw7Y/19gPSdhjt9U2cW7txTK
	i7vaFoC8x7QU0ClWp/ggEwLBXjqG2EzwnYa8x2TplPn/rUdiVpotUll/dwLMGL93F6g4B0dahSN
	IA1JNTNR82RpwxH7RKFWJIrgV4uUDOqX+gUpGWpm2YzYhv4djgD5eWxuPjLBys9JKPpA58u8EDM
	wScUMgQmrcKiSkDPEoEQZKLZAUUOYepsuhmOL2XTIgA9CcGonDAEz1IrTmiHvH2Vwln6W+uYSuC
	MbUwkK/a/ehnXXjE23bzFKuKGEbOWA8F2Plt4qOOCiBt4lB2wzQ+IeIeFUN8sNpZNW60TfFWd69
	S
X-Google-Smtp-Source: AGHT+IEh/eMTGw88AUgWZXyQeSy5eKhXHQwKhrz0Mz4uTAlBw1SJR+N13ofCGoi3VTkdbff7uBQb9A==
X-Received: by 2002:a05:6402:350f:b0:5dc:c9ce:b022 with SMTP id 4fb4d7f45d1cf-5e0b70e4ddemr7101217a12.9.1740249764030;
        Sat, 22 Feb 2025 10:42:44 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287d13sm15560050a12.68.2025.02.22.10.42.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 10:42:43 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbb12bea54so584428066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 10:42:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSL1yLqv9Ua8DrTqo8RsLnJcdsJHCZrCjKWpYqZ8pS25+w27xDqtr/LuW6A26sxvJU+OSjCjtGQ1njEbM=@vger.kernel.org
X-Received: by 2002:a17:907:6095:b0:ab7:e73a:f2c8 with SMTP id
 a640c23a62f3a-abc09a97a2cmr680413766b.26.1740249760479; Sat, 22 Feb 2025
 10:42:40 -0800 (PST)
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
Date: Sat, 22 Feb 2025 10:42:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQCbRA1UEag-1-9yn08KNNqerTj++SCbbW80At=rg5RQ@mail.gmail.com>
X-Gm-Features: AWEUYZlg8oWe1F8d2yA0IbMiP2eFfVc-xiIEw7rs2Mbp7C_9_vUVmvUaGEwld1M
Message-ID: <CAHk-=wjQCbRA1UEag-1-9yn08KNNqerTj++SCbbW80At=rg5RQ@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>
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
>
> I'd be very happy.

I really don't think the issue here should be considered "ret is
unsigned, so checking against zero is wrong".

Because as mentioned, doing range checks is always correct. A compiler
must not complain about that. So I still think that the horrid
"-Wtype-limits" warning is completely misguided.

No, the issue should be seen as "you got a signed value, then you
unwittingly cast it to unsigned, and then you checked if it's
negative".

That pattern is "easy" to check against in SSA form (because SSA is
really a very natural form for "where did this value come from"), and
I wrote a test patch for sparse.

But this test patch is actually interestign because it does show how
hard it is to give meaningful warnings.

Why? Because SSA is basically the "final form" before register
allocation and code generation - and that means that sparse (or any
real compiler) has already done a *lot* of transformations on the
source code. Which in turn means that sparse actually finds places
that have that pattern, not because the code was written as an
unsigned compare of something that used to be a signed value, but
because various simplifications had turned it into that.

Let me give a couple of examples. First, the actual case you want to
find as a test-case for sparse:

   typedef unsigned long size_t;
   extern int fn(void);
   extern int check(void);

   int check(void)
   {
        size_t ret = fn();
        if (ret < 0)
                return -1;
        return 0;
   }

which makes sparse complain about it:

    t.c:8:19: warning: unsigned value that used to be signed checked
for negative?
    t.c:7:24: signed value source

Look, that's nice (ok, I notice that the "offset within line" fields
have regressed at some point, so ignore that).

It tells you that you are doing an unsigned odd compare against zero
of a value that *used* to be signed, and tells you where the value
originated from.

Perfect, right?

Not so fast.

It actually doesn't result in very many warnings in the current kernel
when I run sparse over it all, so on the face of it it all seems like
a nice good safe warning that doesn't cause a lot of noise.

But then when looking at the cases it *does* find, they are very very
subtle indeed. A couple of them look fine:

    drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c:455:26: warning:
unsigned value that used to be signed checked for negative?
    drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c:452:35: signed value source

which turns out to be this:

        unsigned int brightness = bl_dev->props.brightness;
        ...
        if (brightness < S6E3HA2_MIN_BRIGHTNESS ||
                brightness > bl_dev->props.max_brightness) {

and that's actually pretty much exactly your pattern: 'brightness' is
indeed 'unsigned int', and S6E3HA2_MIN_BRIGHTNESS is indeed zero, and
the *source* of it all is indeed a signed value
(bl_dev->props.brightness is 'int' from 'struct
backlight_properties').

So the warning looks fine, and all it really should need is some extra
logic to *not* warn when there is also an upper bounds check (which
makes it all sane again), That warning is wrong because it's not smart
enough, but it's not "fundamentally wrong" like the type-based one
was. Fine so far.

And the sparse check actually finds real issues:

For example, it finds this:

    drivers/block/zram/zram_drv.c:1234:20: warning: unsigned value
that used to be signed checked for negative?
    drivers/block/zram/zram_drv.c:1234:13: signed value source

which looks odd, because it's all obviously correct:

        if (prio < ZRAM_PRIMARY_COMP || prio >= ZRAM_MAX_COMPS)
                return -EINVAL;

and 'prio' is a plain 'int'. So why would sparse have flagged it?

It's because ZRAM_PRIMARY_COMP is thgis:

        #define ZRAM_PRIMARY_COMP 0U

so while 'prio' is indeed signed, and checking it against 0 would be
ok, checking it against 0U is *NOT* ok, because it makes the whole
comparison unsigned.

So yes, sparse found a subtle mistake. A bug that looks real, although
one where it doesn't matter (because ZRAM_MAX_COMPS is *also* an
unsigned constant, so the "prio >= ZRAM_MAX_COMPS" test will make it
all ok, and negative values are indeed checked for).

Again, extending the patch to notice when the code does a unsigned
range check on the upper side too would make it all ok.

Very cool. Short, sweet, simple sparse patch that finds interesting
places, but they seem to be false positives.

In fact, it finds some *really* interesting patterns. Some of them
don't seem to be false positives at all.

For example, it reports this:

    ./include/linux/blk-mq.h:877:31: warning: unsigned value that used
to be signed checked for negative?
    drivers/block/null_blk/main.c:1550:46: signed value source

and that's just

                if (ioerror < 0)
                        return false;

and 'ioerror' is an 'int'. And here we're checking against plain '0',
not some subtle '0U' thing. So it's clearly correct, and isn't an
unsigned compare at all. Why would sparse even mention it?

The 'signed value source' gives a hint. This is an inline, and the
caller is this:

                cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
                                                blk_rq_sectors(req));
                if (!blk_mq_add_to_batch(req, iob, (__force int) cmd->error,
                                        blk_mq_end_request_batch))

iow, the error is that 'cmd->error' thing, and that is starting to
give a hint about what sparse found. Sparse found a bug.

That '(__force int) cmd->error' is wrong. cmd->error is a blk_status_t, which is

        typedef u8 __bitwise blk_status_t;

which means that when cast to 'int', it *CANNOT* be negative. You're
supposed to use 'blk_status_to_errno()' to make it an error code. The
code is simply buggy, and what has happened is that sparse noticed
that the source of the 'int' was a 8-bit unsigned char, and then
sparse saw the subsequent compare, and said "it's stupid to do a 8-bit
to 32-bit type extension and then do the compare as a signed 32-bit
compare: I'll do it as a unsigned 8-bit compare on the original
value".

And then it noticed that as an unsigned 8-bit compare it made no sense any more.

Look, ma - it's the *perfect* check. Instead of doing the
(wrongheaded) type limit check, it's doing the *right* thing. It's
finding places where you actually mis-use unsigned compares.

No. It also finds a lot of really subtle stuff that is very much
correct, exactly because it does that kind of "oh, the source is a
16-bit unsigned field that has been turned into an 'int', and then
compared against zero" and complains about them.

And usually those complaints are bogus, because the "< 0" is important
in inline functions that do range checking on values that *can* be
negative, but just don't happen to be negative in this case because
the source couldn't be negative and earlier simplifications had turned
a signed compare into an unsigned one, so it now talks about that.

Oh well.

I'm adding Jens to the cc, because I do think that the

    drivers/block/null_blk/main.c:1550:46: signed value source

thing is a real bug, and that doing that (__force int) cmd->error is
bogus. I doubt anybody cares (it's the null_blk driver), but still..

I also pushed out the sparse patch in case anybody wants to play with
this, but while I've mentioned a couple of "this looks fine but not
necessarily relevant" warnings, the limitations of that patch really
do cause completely nonsensical warnings:

    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git
unsigned-negative

Not a ton of them, but some. bcachefs actually gets a number of them,
it looks like the games it plays with bkeys really triggers some of
that. I'm almost certain those are false positives, but exactly
because sparse goes *so* deep (there's tons of macros in there, but it
also follows the data flow through inline functions into the source of
the data), it can be really hard to see where it all comes from.

Anyway - good compiler warnings are really hard to generate. But
-Wtype-limits is *not* one of them.

               Linus

