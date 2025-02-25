Return-Path: <linux-kernel+bounces-532660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99013A4506B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDEA7A27A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730092222DE;
	Tue, 25 Feb 2025 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqnRFAdK"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3843D2222DD;
	Tue, 25 Feb 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523389; cv=none; b=evJKDmI3CKAttF4872mCxflFR1zHhgH5u2KZYRkSboDp6VPwwxjRgIQbM5EvRmHpdHg8rCLVxJ9S1EYhoGUrmv1KI0GJRCDDHscwEy6N7nKtm93cZzvO8DII2u0ox2aSllWtH6OE8w6fy+ilmqRYpyu/sdeCY+U60Bc3EklCVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523389; c=relaxed/simple;
	bh=t2y+1hyLZ9tCfpnu5MkiJTZ0i7gEN7OmTpDXZK1o+Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qD2eWb/r0qyR9Wy2eVjaeuMcejTLjeH0furgyXlPH4EMyQTCmfOiPQxg3+yP3x+308VJf3WvI5ry175YGEVwxSmWBXNdEvjzOrjq6FytLKfCup6U0tIndyBx4pRxclqVhOV9/bIB7ifFP+CEe+duSKu7f0+rgFGtNahOBE4xnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqnRFAdK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a2e3c8158so4766831fa.0;
        Tue, 25 Feb 2025 14:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740523386; x=1741128186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Yga5K/x6Wl6/t8h2fecPgE6qaCtJyQQ9C0xTTZzLcA=;
        b=fqnRFAdKxYCbxA0xwjB6g6b4SE3XKDF78A7HRZ62qIcmyouH/eWSmHDrq5G/O2+97S
         qeLYhIEfATORs8/veAYgQ7CnSE1sQsNjM/f70KtRigWvoF61X1i9L5wPGxjRGKJAsWR4
         w484RIxJ8IkNWlGzfjOV2ZL88ZVFeMr9WuTPy/AbnUoosKqits1WL0T/irjJg0D5r4xc
         mqYMlg9CoFBkBnoCZxLDLFc8ADO8lPSoaTRDrGmPjRDNe1T2zYdelowIEtslHZXFL/aV
         ZddazAhQobl3hb59pok0gFqTeRybTW/W9oq9XvVsDz2SBWYiN5gV1HXq9EyRxBVOzqqu
         FVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523386; x=1741128186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Yga5K/x6Wl6/t8h2fecPgE6qaCtJyQQ9C0xTTZzLcA=;
        b=uoRwYpcRGYvAqfoXOYXAL5pgGkulJBwJ+efmfIWaArC3/tcj3oma5Tx+FCV5Gtmc8u
         bvuwCuAhmW6mc5ZTL+xlcVgzFRJwXuKExEZSVfYRD632SVakeKtgx/R6eRkKyvgeJiEt
         nrkXJhhZ8lC//LtKVoXzJFNBEb0E9ahkveXtNjDVkT9mmp9HpC+dR3Y54wpC4jJj+CnL
         m+AcXCjGQ7RT1CARmMPRj2V1dJN9OjpdYVKNdVGL4/TbMTdAxqzF+0LZQs/xrCrWsaRw
         aF2XQbhnEDRApPaZo1l9VKrFgBgUMDhzzHqzl9Jy1BopepWWNeWWudfSHiJfFfJvqd3L
         6NwA==
X-Forwarded-Encrypted: i=1; AJvYcCUpNBV29GVRxFLYD9QrE8KkE8A47fYlFLnzlalpGqM8JdFBmawcSENmo/K1XQUmB+MGsY/k138la1nNpF4=@vger.kernel.org, AJvYcCVV4Mq2Z0J0H8/S2M9+78Xqbne59nLcFIcYR5G1FHixaG0FuD2tzENgUaF1ox9LA/f5Ke7TCv3WTEod80zNFkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCD5G45nhIqDP99omt7bGn8yrGwyx2fxskBeDlSFgxIe22siZ
	pXoVRtV4IQS0RH+zTo65I0tzQYX9cxKrOLoMRUt8NYlUR3R/IRKQecUiVCDPJAkxPWyfbpSEZaG
	FPLCtS0xZsFmCffrDp8lHfX8anYg=
X-Gm-Gg: ASbGnctRJ5wRvak2o30sIbMGs7TppRHmo2lzBeAXg68dSGDfoLiDft+qGGqDvJh1IkV
	ck9ZI2ekePGpm5Fd2TiMR1TD9Uwf+QsIV7RouiHAs1NSODDoWwWWVizQe7PFc/PXJRrbWmHSh+2
	qBtlmkblw=
X-Google-Smtp-Source: AGHT+IH/KKQWDeEI5zLaYzjMloaCm9aig6LY9VFFxT2Lj+vROONYUCNWMwM7XEj/ITbW4w1Lc6MlqvDYNKFyUzA7glU=
X-Received: by 2002:a2e:bd06:0:b0:308:e54d:61a9 with SMTP id
 38308e7fff4ca-30a599bd6c1mr33802571fa.10.1740523386027; Tue, 25 Feb 2025
 14:43:06 -0800 (PST)
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
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com> <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
In-Reply-To: <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Feb 2025 23:42:51 +0100
X-Gm-Features: AQ5f1JrnWqaTGiu3U7FTh9LsfrjKTJW24XGJwpEE92tGL6toEdwgbBX4AyneZuc
Message-ID: <CANiq72kd2eTaPMcYSiQ61tZ2nX0jLM9SgsnbPEEbdNx+JQYFdg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:48=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> I think the one thing that's missing w.r.t. aliasing that Rust could
> maybe use is a kasan-style sanitizer, I think with treeborrows and "now
> we have an actual model for aliasing optimizations" it should be possible
> to write such a sanitizer. But the amount of code doing complicated
> enough stuff with unsafe should really be quite small, so - shouldn't be

Miri implements those models and can check code for conformance. It
can be used easily in the Rust playground (top-right corner -> Tools
-> Miri):

    https://play.rust-lang.org

However, it does not work when you involved C FFI, though, but you can
play there. For more advanced usage, e.g. testing a particular model
like Tree Borrows, I think you need to use it locally, since I am not
sure if flags can be passed yet.

I would like to get it, plus other tools, into Compiler Explorer, see
e.g. https://github.com/compiler-explorer/compiler-explorer/issues/2563.

Cheers,
Miguel

