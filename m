Return-Path: <linux-kernel+bounces-534681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E95A469E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A443A5FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848123536A;
	Wed, 26 Feb 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1j3IIA3"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3E23536F;
	Wed, 26 Feb 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595033; cv=none; b=gz9wqYrG9GyfNR8X6OKLzo3CGAEmzQLCxzSKgDsKy9b14pou89jhjN86rxeS1ggYaDADjTkua/BpWMZWdU7XrPmPQ3q0ea8tLMWtlbwXosa9PNkls4BRrJ9+HoiOz0+d5jICRuafK/kyv1i8gBDK1BWWoe2tOT8Ej5hZFvgHozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595033; c=relaxed/simple;
	bh=k5ajxCLl2hy7Mwsz9QDoIJjT29KvjQa89jMM3NFwxSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxIlFtP3539YJG1zDdYhvbtmZVSibYauL2TmPNc+tvM4r4roxgdpQVa9Hjj1RajFeAebXr5UHfJaHGV6tcMFLNUJek23CAmz79r+FpBmB9kpOMA1JSDSGvy6cfcwFuFIi027FkpUPNxwjMpvRaz61o8Uio2qoCMD9agWw+aobZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1j3IIA3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso30451a12.1;
        Wed, 26 Feb 2025 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740595030; x=1741199830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDyTJwKN7xH8PBcSTb/l/mb6insdu/+iQsdQ5QiBDRo=;
        b=A1j3IIA3HP25wYytjKHm4QuxHw4F0XszGNvW6LzDLW661FCV9zDudXXwFFzTHRzZef
         1PdGkwtuX86UdRGNG8S3PWPyT5cdqO3uEaiJ6F+r54ra95oh880ey9RMNzZbhPTE21Gy
         vL1tavC9+M9xPEPT3x9+FOoLE6EZqF/XEbIWe9bP3VBZ5bFsTzM/EW1F6IK3dEcXLCcj
         /FwotQ7rosr1qj+Ud2fs8YAfQOVk/+keCvuowvNijphaPEWnlQ+HqPDr7+77Ff1Xp8dx
         2ChHdX0bQkr/rqGpA+fLk/ANS7EyO1Pohow0hvtupdPFLQGZVFCBTP/+l51qm9Ck0mwz
         3fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595030; x=1741199830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDyTJwKN7xH8PBcSTb/l/mb6insdu/+iQsdQ5QiBDRo=;
        b=ZR/My9sK9raLQ2ZMaGFOwdMaxOt9R65S1vj6+fQ3moeCDuCishNuD8uFPx9cXVJmoU
         Z8mkL2x2CyCWav+eSb30HoSwYpDp90ksQxQEzdy1yhmfLJ1xzj38NFNRbfddxsBaEY4h
         ziRgsLQ/+GOdR1RJJOjnqdsXdgapbKS3oqqicBj3m0C4w6z5EBNH1O3E8E6ZFSzp89Jq
         ybPvGD6f88bJ8uRdDKKYA51SSRkwF6I73cURwUeht1la5yWrfsRRs0icPsqS9fLxJRGp
         myTvFw3C6RQeppr8OVSVtbh+WcCMBmbtNn44d1HokPyf9qserEF8N5mcdbSkW28NQKsa
         qg2g==
X-Forwarded-Encrypted: i=1; AJvYcCV1tnCnRz1q9q0lcyMDmitt6Sw3o7nNCtiOZKuVccOi/HxA+l6Bvz0DbZ4gsr7+e+DSOYACBIj7Rz024Bg=@vger.kernel.org, AJvYcCXoNSrDKhFdYJs2eEYtl8mEY+9xS1yZbp31r0mDfXoGVn9xwAaDjSxx9UIHh6KTVFs7UCH7c9oH1RRurAvGSXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVe8IMpAey4MuHdlqy+DxUQbzRhEK8gWpRIfkk16tJkMwqJZqI
	BP72IrDZzgyJPqLox4n1g4hUws2E4iCG+f3D1mnZNH8WNdo2gW2zEdlL3/MDTb1t2i27fTcLvpT
	k3awPe5f6JToCbUTTICX7F1BYzCs=
X-Gm-Gg: ASbGnctiCRxlhYmBgTqJiGhYCaEQ0PlxMckkkadpLRDNkhk1NW6sf2MfxgdUlO1YpdX
	KcIVrktyAVXbLMvRIq8rbVoY62eV102eg4c7438L4wTOlEwGU513jjTGNVDwoT9h+LKVIhDR5R6
	7f19sj4Yhv
X-Google-Smtp-Source: AGHT+IFwLcDUFQzoI6ZilFXHLns1F2OC4wA9RbEZ2yK1MOX7/UATdtevigNUWQXX1Z3qVM5GQ+e+CMmylXNmvo/pWiY=
X-Received: by 2002:a05:6402:34cf:b0:5e4:96d6:c125 with SMTP id
 4fb4d7f45d1cf-5e496d6c286mr7924846a12.18.1740595029719; Wed, 26 Feb 2025
 10:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com>
 <CANiq72mA4Pbx1BeCZdg7Os3FtGkrwx6T8_+=+-=-o9+TOMv+EA@mail.gmail.com>
 <CAFJgqgSzqGKdeT88fJzrFOex7i-yvVte3NiQDdgXeWEFtnq=9A@mail.gmail.com> <CANiq72m8zKABR0dXtkB-UiF-GeP5J4nAGqoabdmR=CfPsJejzg@mail.gmail.com>
In-Reply-To: <CANiq72m8zKABR0dXtkB-UiF-GeP5J4nAGqoabdmR=CfPsJejzg@mail.gmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Wed, 26 Feb 2025 11:36:55 -0700
X-Gm-Features: AQ5f1JoMsdSV_5Q6RV31sCAY_-vLSrZRd2z8Vs5ljTGycnjUxfCGKTNJLyBrya0
Message-ID: <CAFJgqgREAtPkx+r_QNPnt-bOekjVjCNBv=tAuuEC6dT2HCA0jg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:49=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Feb 26, 2025 at 4:21=E2=80=AFPM Ventura Jack <venturajack85@gmail=
.com> wrote:
> >
> > I am not certain that I understand either you or Alice correctly.
> > But Ralf Jung or others will probably help clarify matters.
>
> When you said:
>
>     "In a preprint paper, both stacked borrows and tree burrows
>      are as far as I can tell described as having false positives."
>
> I think that you mean to say that the new model allows/rejects
> something that unsafe code out there wants/doesn't want to do. That is
> fine and expected, although of course it would be great to have a
> model that is simple, fits perfectly all the code out there and
> optimizes well.
>
> However, that is very different from what you say afterwards:
>
>     "Are you sure that both stacked borrows and tree borrows are
>      meant to be full models with no false positives and false negatives,=
"
>
> Which I read as you thinking that the new model doesn't say whether a
> given program has UB or not.
>
> Thus I think you are using the phrase "false positives" to refer to
> two different things.

Ralf Jung explained matters well, I think I understood him. I found his
answer clearer than both your answers and Alice's on this topic.

> > You are right that I should have written "currently tied", not "tied", =
and
> > I do hope and assume that the work with aliasing will result
> > in some sorts of specifications.
> >
> > The language reference directly referring to LLVM's aliasing rules,
> > and that the preprint paper also refers to LLVM, does indicate a tie-in=
,
> > even if that tie-in is incidental and not desired. With more than one
> > major compiler, such tie-ins are easier to avoid.
>
> Ralf, who is pretty much the top authority on this as far as I
> understand, already clarified this:
>
>     "we absolutely do *not* want Rust to be tied to LLVM's aliasing rules=
"
>
> The paper mentioning LLVM to explain something does not mean the model
> is tied to LLVM.
>
> And the Rust reference, which you quote, is not the Rust specification
> -- not yet at least. From its introduction:
>
>     "should not be taken as a specification for the Rust language"
>
> When the Rust specification is finally published, if they still refer
> to LLVM (in a normative way), then we could say it is tied, yes.

"Currently tied" is accurate as far as I can tell. Ralf Jung
did explain it well. He suggested removing those links from the
Rust reference, as I understand him. But, importantly, having
more than 1 major Rust compiler would be very helpful in my opinion.
It is easy to accidentally or incidentally tie language definition
to compiler implementation, and having at least 2 major compilers
helps a lot with this. Ralf Jung described it as a risk of overfitting I th=
ink,
and that is a good description in my opinion.

Best, VJ.

