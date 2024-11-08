Return-Path: <linux-kernel+bounces-402089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 380909C239B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692951C23AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E5221FDA2;
	Fri,  8 Nov 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fohz+Qnn"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881E220D50
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087297; cv=none; b=qdkTpQX/OWng30eJj/1MjLn5ZN7thec/kv2af3acJAUV/vH1/WfDj5GXh33QpXYp39tiHf3R8JYgs4Le0ne7rl+WyBHNfWPOC2qKlcr70CcoSfz7LIswmuZ51c4dqnzbc6mkMiXqBDo9NFzsKdQGg1cRu4awS5s01B9u+l6/I2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087297; c=relaxed/simple;
	bh=m77clOypg5Bb/p6J91Pp5cNEQ360BjUrerAGfHRmROU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=b0c9lYiJC7sKBSQ5WoOjVATZcKTmLCd2Kyh8UvHKYs88D206QXos2GvkmunKxSJ/EntaY9TCmTh3lK41uTQve+6dseF2vgqk/UWmjewjz9pQDXEsOtFg+x9tAO+/svmX/q1yy2JzhzqPn0nE5UHdcUBLFKNelrsOP2QSghJ3F+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Fohz+Qnn; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([92.33.209.142])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A8HYNHV1690340
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 8 Nov 2024 09:34:26 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A8HYNHV1690340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731087267;
	bh=rOuuF4jpluR9N/k0kAaAWHUMFnZhlKp7iRd4kN/VJpo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Fohz+Qnn54Hjr9ErA1GDOIasHQsk39D+34OyXQDogYwJU6IswLzrxYM+o/u2E9+15
	 aaS+kqnoB+C1NcC5g9s/nbWgyfmdzD885ql/rQ6YJ8oUQ6wVXsmdKzd3QarBmlDByk
	 t0zynKjfKYB0GDwwzNiJKT8WO1svMLgtHzBGDfO5ouZ5TQTQCNoMVFUjEAukpjmwdu
	 aVS/jN6kWawpSJIs3YZrT8eUdnlE/8BRfqL9+a84CN8VSjMFeMpcb1nm1MPYOh4+ch
	 ZaHzIbTFCfI+mq7njTjwN3rcJN7we10AOe6Ih9CWbkPtnCvHSGzEedfBVfl8oZmVdh
	 Nuy8HFzISe3tw==
Date: Fri, 08 Nov 2024 18:34:15 +0100
From: "H. Peter Anvin" <hpa@zytor.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/1=5D_x86/cpu=3A_Make_sure_fl?=
 =?US-ASCII?Q?ag=5Fis=5Fchangeable=5Fp=28=29_is_always_being_used?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241108172920.GB2564051@thelio-3990X>
References: <20241108153105.1578186-1-andriy.shevchenko@linux.intel.com> <732CB428-EE83-455F-A5AF-C008B7541401@zytor.com> <Zy4xHC3MCtAqlSxy@smile.fi.intel.com> <4A528893-A428-4A6F-8672-1D14CC57F696@zytor.com> <20241108172920.GB2564051@thelio-3990X>
Message-ID: <106B0D31-F58E-49EA-9FEC-5573B684ACC7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 6:29:20 PM GMT+01:00, Nathan Chancellor <nathan@kernel=
=2Eorg> wrote:
>On Fri, Nov 08, 2024 at 04:48:16PM +0100, H=2E Peter Anvin wrote:
>> On November 8, 2024 4:41:16 PM GMT+01:00, Andy Shevchenko <andriy=2Eshe=
vchenko@linux=2Eintel=2Ecom> wrote:
>> >On Fri, Nov 08, 2024 at 04:35:17PM +0100, H=2E Peter Anvin wrote:
>> >> On November 8, 2024 4:30:10 PM GMT+01:00, Andy Shevchenko <andriy=2E=
shevchenko@linux=2Eintel=2Ecom> wrote:
>> >
>> >> >See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused s=
tatic
>> >> >inline functions for W=3D1 build")=2E
>> >
>> >^^^ (1)
>> >
>> >> Looks good to me:
>> >>=20
>> >> Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> >
>> >Thank you!
>> >
>> >> But another question: why the hell does clang complain about an unus=
ed static inline function?!
>> >
>> >Does (1) shed a bit of light to this?
>> >
>>=20
>> How on earth is that supposed to work?! We have static inline functions=
 in headers all over the place that are only used in certain circumstances=
=2E=20
>>=20
>> Is this a good thing, really? Or is it noise?
>
>Did you read the commit message of 6863f5643dd7 or just the title?
>
>The difference between Clang and GCC is only around static inline
>function in =2Ec files, not =2Eh files=2E
>
>  $ cat test=2Eh
>  static inline void unused_inline_in_h(void) {}
>
>  $ cat test=2Ec
>  #include "test=2Eh"
>
>  static inline void unused_inline_in_c(void) {}
>
>  static void unused_in_c(void) {}
>
>  $ gcc -Wall -c -o /dev/null test=2Ec
>  test=2Ec:5:13: warning: =E2=80=98unused_in_c=E2=80=99 defined but not u=
sed [-Wunused-function]
>      5 | static void unused_in_c(void) {}
>        |             ^~~~~~~~~~~
>
>  $ clang -fsyntax-only -Wall test=2Ec
>  test=2Ec:3:20: warning: unused function 'unused_inline_in_c' [-Wunused-=
function]
>      3 | static inline void unused_inline_in_c(void) {}
>        |                    ^~~~~~~~~~~~~~~~~~
>  test=2Ec:5:13: warning: unused function 'unused_in_c' [-Wunused-functio=
n]
>      5 | static void unused_in_c(void) {}
>        |             ^~~~~~~~~~~
>  2 warnings generated=2E
>
>I do not think there are too many instances of unused static inline
>functions in =2Ec files but Andy might be able to speak more around how
>many instances he has had to fix across the tree=2E I can see how this
>difference can be useful for catching dead code and maybe even making
>code cleaner but if it proves to be too much of an annoyance for the
>wider community, we could potentially discuss reverting 6863f5643dd7=2E
>
>Cheers,
>Nathan

I'm on the road traveling and have limited ability to look things up at th=
e moment=2E=20

However, in =2Ec files the value becomes very very small: in =2Eh files an=
 unused inline becomes a drag on compile time because it effects a number o=
f compilation units, but for a =2Ec file it is just one=2E

