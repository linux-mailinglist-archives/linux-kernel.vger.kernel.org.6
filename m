Return-Path: <linux-kernel+bounces-535010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC505A46DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6929016CC51
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D14B25EFA7;
	Wed, 26 Feb 2025 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CRwoUGz+"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C925C6E2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606171; cv=none; b=EPhG/YMQY4p+tBf0QT9QPm80KimewsFVGu2+FqnAKYzHAjIUBr8DndKMwlNXD6YJUjp9glUZ50QejN00I+Yg8hIkDuMuARUPAFkINyoKx0oSYCnhAOJm7U07bZ4UfWr9Q/1mS3iQNNYarmGG8VtbmnaVXxrNy6sa2DNvdXASjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606171; c=relaxed/simple;
	bh=joVlM9Oxd8UHscjQG38CfBVUrd1wTQ59FM/22gfbBMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0P1MtWdIRD9y4ruLeyH4G4eR8YRG/ICwN0o/tn6ya6RBVtHjRBzi0+9mpvFwhtp0ChT5i6sKiKvVvt3aBLm/+yavQwC57MCb5LAZ1l0l8rMTO5T60ySb4/lVgWd14WI/04WEcPmoEaZ8+tpDwFmYK3PECjk5MhnmsSecNAgZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CRwoUGz+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaecf50578eso41502066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740606167; x=1741210967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vkIlnQJGQMWO96KVR0qNL+LIULnDs79lQffNbO4YK8=;
        b=CRwoUGz+YZSlnn0HIno5B+EanR0m0GjggjnJ/pRkjsn4BU6iUFgzzPqGt56RqqzDpL
         tjPCFfJ3B3JeBFh/gdsvF4bHY+w88SogsfvjuHdBQ4XOHbt1ktv1fJ1DNfSuqZrbIvpF
         4+4DugvO2Ohpbj9wwI+gwnWH9dZbih/vZfuRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740606167; x=1741210967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vkIlnQJGQMWO96KVR0qNL+LIULnDs79lQffNbO4YK8=;
        b=Le7PAfbwc0RTdnKm568F8ZTdl9WbAKbJHUi+vPdOq3lFhacoW1C9M7W84NFnJPI1qZ
         GwliwIqNcQaCPDrhn+O3B7PoWd0IcG/vX9wwkn2hx5QmXRuPU9UNRt1Nl3rHeXkWc+Dn
         ZF1BB1hiBBNiVnv7SacTDm5JPIv0sVV0xkVERLRaQ+9k18z3seYy+PEpWGtGPCHmqeqr
         ugcOHhdbDRCobmWdxR+WNrvRXN1Ro0cT0ER/E9b8Azrhw4bmk6pejjQLfSJXWhtt6NdA
         BWUWkE6g07vmGRxI9wJgs/4a9PFXNgRwEtBjWaLxbLT+Sydr2BjgwIjnYxKqstzzI6eZ
         STwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvFAb6EpzdbBxfCd0SS3voUhjYwjLMsX2EKfP2OrKIzweankmJwMnhSkP5l5TZuLUAI63flE46gppwRac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLTBGeGOO8nShzS38bplj3yVCBjFccYaONh/X/lzKfgG958fA
	TMtTs3IRD49DLWjpmEn5CdEiXPRFwPuG1Bm/rHb6G6O+AxrM+Bk7i8SYXDC7DTSH1FHTuFEum8L
	vFBncKg==
X-Gm-Gg: ASbGncvKbWtvXCfjGQsLhVOeYymMrY/OHgN5oucnTeTjJnpqgIUOYbzse05+wZfYGnv
	5yFHv9hFDiv6vGwU6X6k/G/YzIcBxkVDRZB6E8T809M44no94T3Q/WbgJK2A4ySv7SrtI/h5DHr
	LqBCLKXdzGmfXvUTkKH4trBZ6gmTH0lOwLv4VfY9RFPhwewksjlvTkwniPSPbt7Z+EroPhaHzrn
	2THbpiAzCSdpY3BASO1+TxBE4dVaQH0qg2sLCWZR/0PaGR+7JA1zj8nSvFqiz2QHE7y6mdm6ME0
	laChoJ4gkSf2mcocKUbAT7y4LParSLzpEwjdf7PzRERujLm1qQ0HCCS49mdaf9WzEmZ2QluNCMU
	H
X-Google-Smtp-Source: AGHT+IEq3QKYWlRvbdVe2fxu3XnjSGLgo5Dy2L3xszfAO3i+0F73HKds/XBt2jzSBdX6QJa9nf+wFQ==
X-Received: by 2002:a17:906:60b:b0:abe:dc71:883 with SMTP id a640c23a62f3a-abedc7109c8mr719506966b.19.1740606167483;
        Wed, 26 Feb 2025 13:42:47 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75e499sm7974366b.149.2025.02.26.13.42.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:42:46 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso41498066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:42:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1Rx6DpRaaQdzZcw+7b4+1ZFSoHtjglrF5VAZc2zlvJNPv0+3vPYK4DiMgus5mzMEkEQOekGbOR9VWRGA=@vger.kernel.org
X-Received: by 2002:a17:907:d16:b0:aa6:b63a:4521 with SMTP id
 a640c23a62f3a-abc0d9dd9ecmr2539199666b.15.1740606166076; Wed, 26 Feb 2025
 13:42:46 -0800 (PST)
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
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com> <20250226162655.65ba4b51@gandalf.local.home>
In-Reply-To: <20250226162655.65ba4b51@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 13:42:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
X-Gm-Features: AQ5f1JrEbuV6Jnfb71LIwDoIVXl971WHAwc1W1BbVzsqQnjOHGkQlzERgSNPg2U
Message-ID: <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 13:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> As a bystander here, I just want to ask, do you mean basically to treat all
> reads as READ_ONCE() and all writes as WRITE_ONCE()?

Absolutely not.

I thought I made that clear:

 "IOW, doing CSE on reads - and combining writes - when there aren't any
  aliasing issues (or when there aren't any memory ordering issues)
  should absolutely be considered ok.

  And doing speculative reads - even if you then don't use the value -
  is also entirely fine. You didn't introduce any observable behavior
  difference (we'll agree to dismiss cache footprint issues)"

all of those basic optimizations would be wrong for 'volatile'.

You can't speculatively read a volatile, you can't combine two (or
more - often *many* more) reads, and you can't combine writes.

Doing basic CSE is a core compiler optimization, and I'm not at all
saying that shouldn't be done.

But re-materialization of memory accesses is wrong. Turning one load
into two loads is not an optimization, it's the opposite - and it is
also semantically visible.

And I'm saying that we in the kernel have then been forced to use
READ_ONCE() and WRITE_ONCE() unnecessarily, because people worry about
compilers doing these invalid optimizations, because the standard
allows that crap.

I'm hoping Rust can get this right.

               Linus

