Return-Path: <linux-kernel+bounces-527494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8FEA40BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076A63B2A7C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1920013A;
	Sat, 22 Feb 2025 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6x+4lGL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439A1EA7EA;
	Sat, 22 Feb 2025 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740262376; cv=none; b=Ya27j1X/TmHmAq40fe4C+v4zsFm2C1KDxDyHzD1IGUbL6Bn2jGB+nrrS7VYyqpdBzsq1JCpDO1ZEttDOc1+JiKMOG2nnhs1LB6JnRSiIWa7yUww+yXEajwrPH/FRFjRE25XnCd+qhO7RWbX7wW9zoaZbEFZslt6KvPU4wSAcyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740262376; c=relaxed/simple;
	bh=0kVZChQIdT05i2ugJJnK3LxJC0uLV6WBEoEYYYnfB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH1adHY8izptFZRO+bxhsCTI1rrhY61TUyQ39Btk7UTKAatrrJMwNPNr7b7PdtxLjBOanuTZPUeemuFKQKFcWMnX8pqfxW7orAbgocDdHSdpsrjnRk+XWDAtcpvAmyd3bYIm28SfXFjVyMkfWlEYH114K89TN9kwBaZCh+VfvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6x+4lGL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f2f748128so1453344f8f.1;
        Sat, 22 Feb 2025 14:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740262373; x=1740867173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XocSJp5y9VHtgpY1Xznfpqr9ru+r8Xd3NaR0HKrcKs=;
        b=P6x+4lGLNub2urV5oBjuYl1RSmGFN45tW+91oy4gHvVOwWj1fQodZbAPHT+hB7xDLB
         uTSSYjeijjxzGnSs/GesK3NzR388NmU+KLyQHg5El0EkhZFWdq0e8Q2Sbw+looAoQOOV
         CKgcRltyR7wkNgb2dVJa3g5UuDiGcHJTzDczevokloKps3NjAH9RuqHRfReEv2znFsuU
         QQIBY92rGob+j4cqXx3lptt4ZtguunlFbvZwxfJjuhhQb0q15PGZZGs8im/4pFX/dzOJ
         nNqXNej1RM8smsYAO5kgIHOdOMbFT1IKzJIUFL/1fL68umlgU4ECXpTEv2q3c1rBEiKh
         pu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740262373; x=1740867173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XocSJp5y9VHtgpY1Xznfpqr9ru+r8Xd3NaR0HKrcKs=;
        b=nYanHo5iyqgBYo8VKI3xSv8+IchP1ILH9uYjCLV1c6GLGYk1ujflLqGc6iN0w3z6mq
         NZGqUJO/H72IRvRrnAxz1oAxKDyjnXVtXCtKk0pnJoggbQVjL+iUvfJRlSv17P+cTujW
         ZLepTXM8uissTjclEodV/bP1Q+oN3B8Cxi5D09J/1ww39buUgNDzhSCBT8BeAZPuIQxy
         NiVcxs/m72UlPaJYDo1n6N24VbnFJ1SKoW5SGXudyNxQJLJJaxB0Tl9bVybrbtG2yKPT
         xB3ltqYsdX7pSnCpScZGUsucV6tNpnElJc+RI5DtXFjLVBjA4vB5QJ35F1gjBqGT/w/k
         SsSg==
X-Forwarded-Encrypted: i=1; AJvYcCVuBULrs6DSKCrRxqWg6zDedELSL/Acviykq53XTfbowLXqOqCJhXdB+hDWl01WNKY+h5NQ6QiVeMjvHVzLdp8=@vger.kernel.org, AJvYcCXmdAWZLlRSIskBzWAKHIfZ2+xStdSzcvnXzbgXfj/xmEpvWbhb5uDh+R4Aqr4OuubhrYIY4x2xB3N/WnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vszBNaFwyLHgGOCBXLNEFyoMtckuPUBICpcew8qHymJLbRh3
	S6xaDL5PfpO/snggL4o6O6ATP82sB9Y1auRu4T4YzMv6Jec8JAeR
X-Gm-Gg: ASbGncskICOlffdY2wTUNUgQ8H0ZvyV9riOqBIxyxuPk2nHUGn8NMjWYfBrri1g9T/Z
	fP/WOlUPF9JTG0EA7ZEfHoK3IeGnGU7ISCZwsOdupFjifXYpRXrqwCJtjSgWWf9TpWXhioV981v
	P5vhJtGe/hww4mUZSH19say+XutgOo+l33gVoVMXDR87L/lFzNmM8iMAaCKhqYQ6WjxxMPqZ6ru
	HvgraP7PonTi0x0xKqxjCXIe7E24wsGZCbravXSZ35DS6a0U1H8C73mrxb3+m1TQoMc+7aYEtm5
	nF6xm6hIPAHJz+kwb631DximL1wmmOnRQOab9TV/hwZjIPNLbUF2o7A9jeWL8JFw
X-Google-Smtp-Source: AGHT+IH++ps/T2w03Bu4CN8he1k98DEeg+N3rfDsfaT/b0Jrqdk/zL6D2AMk8zqDe8Q6Vd2lstNpbQ==
X-Received: by 2002:a05:6000:144a:b0:38f:4d40:358 with SMTP id ffacd0b85a97d-38f6e7587c5mr6985640f8f.9.1740262372632;
        Sat, 22 Feb 2025 14:12:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4314sm27002426f8f.9.2025.02.22.14.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 14:12:52 -0800 (PST)
Date: Sat, 22 Feb 2025 22:12:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Ventura Jack <venturajack85@gmail.com>,
 Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250222221248.772b4bf6@pumpkin>
In-Reply-To: <c3spwcoq7j4fx5yg4l7njeiofhkaasbknze3byh4dl45yeacvr@rb6u6j5kz7oe>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	<20250222141521.1fe24871@eugeo>
	<CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	<6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	<CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	<yuwkqfbunlymofpd4kpqmzpiwbxxxupyj57tl5hblf7vsvebhm@ljz6u26eg5ft>
	<6EFFB41B-9145-496E-8217-07AF404BE695@zytor.com>
	<c3spwcoq7j4fx5yg4l7njeiofhkaasbknze3byh4dl45yeacvr@rb6u6j5kz7oe>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Feb 2025 16:22:08 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Sat, Feb 22, 2025 at 12:54:31PM -0800, H. Peter Anvin wrote:
> > VLIW and OoO might seem orthogonal, but they aren't =E2=80=93 because t=
hey are
> > trying to solve the same problem, combining them either means the OoO
> > engine can't do a very good job because of false dependencies (if you
> > are scheduling molecules) or you have to break them instructions down
> > into atoms, at which point it is just a (often quite inefficient) RISC
> > encoding. In short, VLIW *might* make sense when you are statically
> > scheduling a known pipeline, but it is basically a dead end for
> > evolution =E2=80=93 so unless you can JIT your code for each new chip
> > generation... =20
>=20
> JITing for each chip generation would be a part of any serious new VLIW
> effort. It's plenty doable in the open source world and the gains are
> too big to ignore.

Doesn't most code get 'dumbed down' to whatever 'normal' ABI compilers
can easily handle.
A few hot loops might get optimised, but most code won't be.
Of course AI/GPU code is going to spend a lot of time in some tight loops.
But no one is going to go through the TCP stack and optimise the source
so that a compiler can make a better job of it for 'this years' cpu.

For various reasons ended up writing a simple 32bit cpu last year (in VHDL =
for an fgpa).
The ALU is easy - just a big MUX.
The difficulty is feeding the result of one instruction into the next.
Normal code needs to do that all the time, you can't afford a stall
(never mind the 3 clocks writing to/from the register 'memory' would take).
In fact the ALU dependencies [1] ended up being slower than the instruction=
 fetch
code, so I managed to take predicted and unconditional branches without a s=
tall.
So no point having the 'branch delay slot' of sparc32.
[1] multiply was the issue, even with a pipeline stall if the result has ne=
eded.
In any case it only had to run at 62.5MHz (related to the PCIe speed).

Was definitely an interesting exercise.

	David


