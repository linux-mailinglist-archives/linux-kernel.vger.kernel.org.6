Return-Path: <linux-kernel+bounces-436161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC33C9E81F8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3799B281E65
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A881547EE;
	Sat,  7 Dec 2024 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NpCBq8CU"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9078122C6FA
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603490; cv=none; b=oaxDqmawn/acea9B4clrYO89jHkkMotu+AmvJgHmJ5TodORRvmJgjHlzOCyc3T9flJ0OWE8i60zwgD5RDTPuObVcKAQIBspkSd0Enqx4qzQ/SWNsGe13T/kD/SSZi0D9A6Rwo68I5/1If9ylElButv7XVW8KqR1uLE6tsS8NGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603490; c=relaxed/simple;
	bh=ct+vM4e0Jtr5aDgyp/mMMW/kc2rgYH8fWmf1syFBJE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4hNGgbE/R1Zjlku9n5lZGiLiUsvkQ9beQz4Oju+wQlJ4r4veHXDqXDpYsHHNNbEkGUmqFq1uZfWJwVYenosAKF7w61TlUwR0vcTPTk7cpkkgYkyUYItvsoPBG33ptEi6Bym5TVawXdAB6SMyw2BeYIIHXvM7hq2mgNJ2JAZ2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NpCBq8CU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa62f1d2b21so403975966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 12:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733603487; x=1734208287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ms7Dj4PhpQjQO3I96MAeIgwapri0gFHpEAP0IFi7Ea0=;
        b=NpCBq8CUjygzKWjH64ZfO9UUZRgGKejztNLd/3gHaCdbBKv18e0FUpbNfOdNEk5iiZ
         XHHxKnO8AZT+b1A95kIMjXoe7vyumXB5hbjF/7tPQ9Fld4qWHokRq/EXyH6W0raO9Qh6
         7e7z7PPqLGkbOE3ESrpee30gU/A41NeX3eyCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733603487; x=1734208287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ms7Dj4PhpQjQO3I96MAeIgwapri0gFHpEAP0IFi7Ea0=;
        b=GZYTY1EE94V2FXPNmY/4SpVMWDPpk/LE5/6IT7Yx3bz2NHsx5popfyygFiVPe2MfjW
         4ByJLiCNkbiCPkrUdpqHP/AhVYBHpg9RRkWv/PpROAev+EuunlLe6Uw10fvcYeC77GO+
         NEAock9SbMudcWjBp5IMugSNwP2EVLlL0QU2qceJNjEDnvMmst7g4hApAA8HTQiRrwKR
         yFr0HtruBMpLFeOjKJ5gKnTT30puPxRJ9fAMLnhISCO41zqM3z3pQpEyJMND3mWsA3Pj
         RbufO5FzXVjBtmWc4AqlGlU+TOfz6ItJLpozMtYcRyeBCYRz9ORv9HpNqfGl1R82b5AK
         7Fiw==
X-Forwarded-Encrypted: i=1; AJvYcCU9aOqU2+tZDq0Jx23H1NE7zG5Rz50FDt2pJMkFBJtktAhjL6y6Rvr545IJ4m7KwRt2U0n8bdF01lFfej4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFDC9zkMeiVums7TQAaq2sK5ipLKdMnv5mu7jdQu5fDUcAYNK
	LYzKveogIc7mxgoek1jmHeM62TjnzluNToUY+3wF9BRb8RlY9C1gjlL7xvpO1etDti5sm0s85bB
	JoleMAg==
X-Gm-Gg: ASbGncvdIj+StLI7EggjdN32Llio6kYXu9xCGp1p5vl228pYYu9VvVcsV1Tt1Z5RGJG
	UPoN5opouZDLFMQSL5YObqNu7ZTj0taoYeC8aT+PvL+Oc6/+lz8e9HbCbu1gcJuxQoMkJVmz4nW
	MUd4YzTQYhZTjPNb8UjCCfGTv3W//EZ7DxvGYuFIfjcX4tN8fF579uTeheOvB3WyTz0ExGS1pkt
	iFeN/FP/RM2q5stumxyTxojvQ2lzZVIVVPy+0bahChy2t9s08NjkjGUoAeFJMbYtOty9SLyyd1I
	f1NqYeFKxg3c3Ph2Ff4Z+gJQ
X-Google-Smtp-Source: AGHT+IE+HvMYM+idQ6qsBCnzWCzGb9TYOqAbTjaHwKDeuBDHtWnuFWzkGMqYA1FWDf0+qHMKKwHx/g==
X-Received: by 2002:a17:907:3a18:b0:aa6:423c:850c with SMTP id a640c23a62f3a-aa6423c884fmr478199766b.52.1733603486958;
        Sat, 07 Dec 2024 12:31:26 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260eb8aasm427083566b.199.2024.12.07.12.31.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 12:31:26 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa62f1d2b21so403972966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 12:31:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWE3jg7cXUCaDDhfhkXlblTlECsa3GuFRj0uVef+U4IGjmRTatlhGaqLS18ZQ7Vmsi8mcguhtfhQ4Kv/Ks=@vger.kernel.org
X-Received: by 2002:a17:906:328b:b0:aa6:326a:bcb9 with SMTP id
 a640c23a62f3a-aa63a10fe42mr541173966b.33.1733603485779; Sat, 07 Dec 2024
 12:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
 <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com> <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
 <0f5c07b827c3468c8fa3928a93a98bfa@AcuMS.aculab.com> <e806dd51b1ac4e289131297fbf30fc37@AcuMS.aculab.com>
 <CAMZ6RqLOR3aCRW_js2agV+VFiHdazb4S2+NdT5G4=WbDKNB8bA@mail.gmail.com>
 <b1ff4a65594a4d39b2e9b8b44770214e@AcuMS.aculab.com> <CAMZ6RqJFReLJTd-O8s02oQNeB0SPQh3C-Mg+Nif5vMB9gFtQww@mail.gmail.com>
 <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com> <6b8c9b942ba6e85a3f1e4eef65a9916333502881.camel@gwdg.de>
In-Reply-To: <6b8c9b942ba6e85a3f1e4eef65a9916333502881.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 12:31:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzFAaksqMdYeYC=T82tny1HnGGcYu_xJTXZF1OZwVziQ@mail.gmail.com>
Message-ID: <CAHk-=whzFAaksqMdYeYC=T82tny1HnGGcYu_xJTXZF1OZwVziQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: Vincent Mailhol <vincent.mailhol@gmail.com>, David Laight <David.Laight@aculab.com>, 
	"w@1wt.eu" <w@1wt.eu>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 11:51, Martin Uecker <muecker@gwdg.de> wrote:
>
> Am Samstag, dem 07.12.2024 um 10:19 -0800 schrieb Linus Torvalds:
> >
> > If there is one feature of C I would have liked it is "allow inline
> > functions and statement expressions with constant arguments as
> > constant expressions".
>
> There exist proposals along those lines for C2Y.
>
> From a more near-term solution, I wonder if making it possible (or
> easier) to return integer constant expressions from statement
> expressions and allowing a restricted form of statement expressions
> at file scope would help?

Even a more limited form of this would have been useful several times,
but as mentioned, the problem tends to be that we end up supporting
compilers for many years.

So then we end up having to work with older compilers without that
feature, and can't actually clean stuff up until many years after the
fact.

We're currently still accepting gcc-5.1 as a compiler, although it's
time to look at that and probably (judging by what stable distros use)
upgrade to something like gcc-8.1 as the minimum supported compiler
version.

            Linus

