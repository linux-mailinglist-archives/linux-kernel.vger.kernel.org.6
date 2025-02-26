Return-Path: <linux-kernel+bounces-535090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B584DA46EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F7B16DAA9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31825DD1E;
	Wed, 26 Feb 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRPd5n+a"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E025DCF0;
	Wed, 26 Feb 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609921; cv=none; b=BLmyaQJjb7x45GQFQRl21Y6/nzznNGCNufc4/zdOcmcOuSLjOIoQZud8ytFeAKOKD/PUxBONYWoXaHc2IFp+76IFRc4PSXa5qVsjSSD7Lz+xDwGISM3SC9ayeq0qwYpafUqKoTcJPziFluz750zenAud4pC01a8sf5CqEIOrjTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609921; c=relaxed/simple;
	bh=4UVInMS4tv9biv/bwMI9v0/JxHTrZ/Bs/uQ+9nGhqOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ju/scOVaiz2eCFZMYNtpYSIUugo3poYeflrTT1foFS5by/6nMaDGStQiDr6VVyoGzaJpveqkd8frE+SGbtbSCoYlcSGKgGFbfQZSp+ektAhHqueEyBjOaq8WqCudLtNqi9a0RuH0XP8/TSsPUCcLHk8tG1yQG5l/UUTN7AlGgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRPd5n+a; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f24fc466aso151759f8f.2;
        Wed, 26 Feb 2025 14:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740609918; x=1741214718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fungY5bDN0475Mx+5aT/SrTRB4XbDglBaa6SO+Fa5Kk=;
        b=XRPd5n+awi0Cg63zbSzIO++SV49cmn2d2ZWNDQ6NEGNPw2at9cgg6wNZAy5MtF4Dan
         Sl3u84qs8zmrKEJiQ3JjWUHUGEVWHQigu/byqqtvrt46/N991ApbgUU03XZzpAhDRK2w
         FShidf6IyExaPRdA15d/thHQNIW4i8lIfdVhKU7iUB3AlJQoovo+tWr0IoU61bPz755q
         oRf/4D5OF45ct51s6uastiWM5V6UAYTQw3w9nsJ6DLAEQzONOmJOnammurDoqSYYZVkn
         744aVo0u9EOWWLpduejCWlglWgdbd7r1Cq7FCG/Sa/bQEUtbzi+xHZjRqP7e2wKudQjg
         IP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740609918; x=1741214718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fungY5bDN0475Mx+5aT/SrTRB4XbDglBaa6SO+Fa5Kk=;
        b=afH5NZRA+A2rhlcbCvQ9z0Q4SZuok4ReDVVpH85B6XuHuxwpkimu1uZWeIOo/HvMtc
         fpUpuqcbrVqP5PJVbvacXxjKlO4MXkv/qTVaboFUNQbtUGEn+POfgkVEqyu9uBfMa7QM
         B48SM6jixTskTFE9/F5E9hTXuB7WOtLSgid5R6awJWNug6QjCsA3qWy1zqesJFtxYVb7
         Gqv5F/K7cDqzoTCsMBJv0majEB3JHp08bY7vMsztWg8Ila+Mw7lHKGv79svQopmmdFvX
         X5ighIdgTk0mdSr8x1ZPLLdOvs+l8YnnZ/3NT/4QBocbhAHmbzEtnaTCKsk+oTaF2XFp
         1Reg==
X-Forwarded-Encrypted: i=1; AJvYcCV7gWygMuEYv8XM0TrmjPgyUSn6AOfcI9fzUzsUxjq1TyDfnVVvzZRcXJECGD9Tvhs93jr3JvAixihrgh0=@vger.kernel.org, AJvYcCVomgXBcqst+dJTnMwt2WWwB1Pv3mU9SgUoZ3P8VS8qCb5Cfrxe3aDHELz6KOdlDHYYtXXJd9aqFLTN/vpiE8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwsi9McMxeKm7TO3Xx5/ShKh8cPZ5bF+bYmM3HJcH1mClSJ9dc
	Wu+z79UUQd3x51IhAfcpxOeG+WFz04ItrSVXhXgnGXRIZMHvlEFn
X-Gm-Gg: ASbGncu6wlOsbTiojxT/bMOwTnNPbSfW1Pi3S8AEDNcu7ddhqQZEtRourhU4U7RFsaU
	lyo50vm8tLdkKMssUSYstSHZKqT2IhMNBMi5Va/QiO55Oq8ZQkhNMqMcW5TVmKC9KJzQq15h1oh
	Jk8nksrUpysqGtHsK1+pDhopecZPGxnxrAL7Hw4yBBB50ZP+G/OyoXUX9Soq6UcK4b+0eBBYQa/
	KqmhN9IvQYPGs4vusPw9eLK+i52Upp+YZaqbvS1cQwqtKrMAjLdp186tiOaRGMy2mnw/Uc05g0s
	Fi5WgdhveH824gq4yFuxBEU3TMh0qE9unL4D02xyXXtFeFEAaBKkGDxO2pMHVS0A
X-Google-Smtp-Source: AGHT+IHfa0Da3Dsc6dUNmlhxWx5A7ERkfnnAoMxP8iyrOb7NjpkpXiGNxsSey1NtIbSrIu00F1cV6g==
X-Received: by 2002:a5d:5450:0:b0:38d:dd8c:51db with SMTP id ffacd0b85a97d-38f70859603mr16661370f8f.53.1740609918235;
        Wed, 26 Feb 2025 14:45:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27abd6sm3160445e9.26.2025.02.26.14.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:45:17 -0800 (PST)
Date: Wed, 26 Feb 2025 22:45:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ralf Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>, Ventura
 Jack <venturajack85@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, ej@inai.de,
 gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226224516.7d4d28ea@pumpkin>
In-Reply-To: <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	<20250222141521.1fe24871@eugeo>
	<CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	<6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	<CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	<CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	<CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	<CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
	<5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
	<CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 09:59:41 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 26 Feb 2025 at 05:54, Ralf Jung <post@ralfj.de> wrote:
> >
> >      The only approach we know that we can actually
> > pull through systematically (in the sense of "at least in principle, we can
> > formally prove this correct") is to define the "visible behavior" of the source
> > program, the "visible behavior" of the generated assembly, and promise that they
> > are the same.  
> 
> That's literally what I ask for with that "naive" code generation, you
> just stated it much better.
> 
> I think some of the C standards problems came from the fact that at
> some point the standards people decided that the only way to specify
> the language was from a high-level language _syntax_ standpoint.
> 
> Which is odd, because a lot of the original C semantics came from
> basically a "this is how the result works". It's where a lot of the
> historical C architecture-defined (and undefined) details come from:
> things like how integer division rounding happens, how shifts bigger
> than the word size are undefined, etc.

I'm pretty sure some things were 'undefined' to allow more unusual
cpu to be conformant.
So ones with saturating integer arithmetic, no arithmetic right shift,
only word addressing (etc) could still claim to be C.
There is also the NULL pointer not being the 'all zeros' pattern.
I don't think any C compiler has ever done that, but clang has started
complaining that maths with NULL is undefined because that is allowed.
Is it going to complain about memset() of structures containing pointers?

The other problem is that it says 'Undefined Behaviour' not 'undefined
result' or 'may trap'. UB includes 'erasing all the data on your disk'.

	David




