Return-Path: <linux-kernel+bounces-344496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8F98AA6D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FCF1F236F6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C0B194083;
	Mon, 30 Sep 2024 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0iuG0Ka"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF3824A3
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715567; cv=none; b=Y6uD1wwL04bgaLfVQOF0KEub1N/QJjJYU0wi2xEe+LCaItC53Z9EQSFMh58Ypab80wvjy13Knw7+/uxZwGYZWwRc1Ywzz/WMkEW33shS+daKcxU4coSZ2c53aT2GbD9OaQGe1iXQ7R5EAutwtw1lKupp4EeugaDx8grakFSSTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715567; c=relaxed/simple;
	bh=mpDyGUfvZ6cW6FC+/ooRi2/soKjiJ1QWLIJ1aDemLWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICDHROHrUw3+ApTeqZ+PSDKzcb1o6aSFPjAw2zyfQVtVq2KuXv/pDcWzgF7xcT16k2Cb2kPA8tdlGdJ7LxG+w6/ger8nrZKhE/dL6yNb4a5M405IuDLDq2x5LIhEVHPTSGQBtCsC9sRk1bFH4Y03OG3sh1VEBo31fcg2G+MU378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0iuG0Ka; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a90349aa7e5so688830366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727715564; x=1728320364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sPIh55xyEmHFruRAlgKDCIyzWUlAinLbg4WbuV5gsM=;
        b=h0iuG0KajgMHD4k+UPsj2MfsC32V2iASCIViJp9YMICKDXGOEqA+1lto2kMJfa3BQd
         70IjtqWtJvGsrNLOy1MlhaFiUs34cd9brdeWDtFk8L1MGJHxfcNrzgT+W7fXWhxpWyW6
         AIU/QYDEW2kP4UQ+PI+2anE3MzIaRJ2W/QCDv/1aUwbK8Unfam1Y8WY9tsj5owAxXhj7
         mbNjrQO2KGwIE/iUV6mPouUZ4uzO0Gt5tz9xt3NT3dWcAfyONkYae86LQOH8RxFJCd3w
         xE+AmeWLYEP78Xf3FlM51WimOXdimD8UPadgnkYRZ4UnxDFpgPB6RHOT61LHVr0fdWo4
         zI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715564; x=1728320364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sPIh55xyEmHFruRAlgKDCIyzWUlAinLbg4WbuV5gsM=;
        b=CZvjsvye3Tm+Q/pKplSy2TWVlcHemAtI+6LlXZaJZyMtrprovSV9eavTnmpcKNjyMg
         yVv2iOMpIH8be3R055zILn/WFi45adCdI+MCCkbqRNzwqVxO8vEHV58FylxQ2TjXxmA6
         YgcXu3JmD+2wxQ59djX9yPRmrhbp1IbvMDLj+HUd/3vgkHsj89tkY1VyrBF4LENL4nRf
         b+b+h78Q4GoqhURMSxNoJHcrjUS+V30fEPmlKUQqe6vamjGpX6/jMf5eBziO0YTcZCir
         F7VzIgs2zA0+rHIfY23MgyNxYBlogAHdWXh+WQkEn+ZvtrSq37G6dDhaaKECgH1Jpe6R
         G49w==
X-Forwarded-Encrypted: i=1; AJvYcCXkLK/9yPLAdCcHi6B9nvCWz8YOr6a0VUaA9EIS52xgHjqAzYY4znNpZGtW3zKb9EoK5i3AxEVJvpeG6S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+6q2TDBZZcnCsXinMKfckHadeq2F+qSf/Gaizf/lhV4vX1Va
	DRtZkSDKosy+qdjYMq7CfE0teOxeNUa8PC9KylefnNWVx1A6G/nq8jyRpzMsSJSRKpCGYTOEVPo
	o5HW6tpw0BDDDMkZPdDAy+4DCzwY=
X-Google-Smtp-Source: AGHT+IGjxMu/1wY7FQTDw999OIOaX2fpsoxB8OBjSVxN1EeYPJiqVdsezEwHm+KFTC0wK04QwfCLrYnfP+d1qUVm0gs=
X-Received: by 2002:a17:907:9488:b0:a8d:6073:2c13 with SMTP id
 a640c23a62f3a-a93c4946d42mr1309282466b.33.1727715563660; Mon, 30 Sep 2024
 09:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927194856.096003183@infradead.org> <20240927194925.498161564@infradead.org>
 <CAADnVQKQED2pit_DcpDWPuueHH3RLXe4pB++tU888EU=8UrNpA@mail.gmail.com> <20240930082726.GF5594@noisy.programming.kicks-ass.net>
In-Reply-To: <20240930082726.GF5594@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 09:59:11 -0700
Message-ID: <CAADnVQK8s4N_W_BH5zPZ7V-NW9FRegK27Nk-67UqiJzCxrdtxQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] llvm: kCFI pointer stuff
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 1:27=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Sep 29, 2024 at 10:53:05AM -0700, Alexei Starovoitov wrote:
>
> > > +  // Extend the kCFI meta-data with a byte that has a bit set for ea=
ch argument
> > > +  // register that contains a pointer. Specifically for x86_64, whic=
h has 6
> > > +  // argument registers:
> > > +  //
> > > +  //   bit0 - rdi
> > > +  //   bit1 - rsi
> > > +  //   bit2 - rdx
> > > +  //   bit3 - rcx
> > > +  //   bit4 - r8
> > > +  //   bit5 - r9
> > > +  //
> > > +  // bit6 will denote any pointer on stack (%rsp), and all 7 bits se=
t will
> > > +  // indicate vararg or any other 'unknown' configuration. Leaving b=
it7 for
> > > +  // error states.
> > > +  //
> > > +  // XXX: should be conditional on some new x86_64 specific 'bhi' ar=
gument.
> > > +  EmitAndCountInstruction(MCInstBuilder(X86::MOV8ri)
> > > +                 .addReg(X86::AL)
> > > +                 .addImm(getKCFIPointerArgs(F)));
> >
> > If I'm reading this correctly it will be an 8-bit move which
> > doesn't clear upper bits.
> > If consumer is in assembly it's ok-ish,
> > but it's an argument to __bhi_args_foo functions,
> > so should be properly zero extended per call convention.
>
> These kCFI 'instructions' are never executed. Their sole purpose is to
> encode the immediates. They are instructions because they live in .text
> and having them this way makes disassemly work nicely. As such, we've
> taken to using the 1 byte move instruction to carry them with the least
> amounts of bytes.
>
> The consumer is the kernel instruction decoder, we take the immediate
> and use that.

I see... and after decoding imm bits in mov %al insn the kernel will
insert a call to corresponding __bhi_args_* stub that will use
cmovne on corresponding register(s) to sanitize the value?
That was difficult to grasp.
A design doc would have helped.

I wonder whether this whole complexity is worth it vs
always calling __bhi_args_all()

