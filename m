Return-Path: <linux-kernel+bounces-537024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D49A4872A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83373B86E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957621EFF80;
	Thu, 27 Feb 2025 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJylnsOu"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557D8199239;
	Thu, 27 Feb 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679274; cv=none; b=QCSNpRH6/vIfo+Wr6SOqbjWT+OkyaRIFc84GWlNj6EkEE/MlSYFxwURZY8ynOVXFhV+LZQB5pRZigKSMkqtbwbQ0JhZzxd27O2Z1NleTBvsXkOK4r2uhkmMPNP9OZer3h1BuAq2mVKuVX3nAFdIcPsMGecqhT9kwrrEl4RKR7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679274; c=relaxed/simple;
	bh=GiSZjH82D/MUaCubZKcQoptOrPFmx5LV+oTUDQTeVxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6lSZwbE8nhE/IdsK9VPoZCrO85z+r9tDXYIFMx0vr0yveh+Fonr5Y2TsqxCOEZK8Ru3FtN/qr33/NIvprY68x1n8QZrsK06G9B4TWS5rLd0MX5VBTRZdvKpKNpPA31FBe37mdg2Y+TlbXNL9KLEsyMAInYDg08hIVCVaxWatWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJylnsOu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so14319331fa.1;
        Thu, 27 Feb 2025 10:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740679270; x=1741284070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o/mfaqlPkxYSZ/nQyeOcTy2xeSV0yUhY5MQIdEddiU=;
        b=UJylnsOun3LqQCsM+nvo7q63DaO57wUQr9+x4bNGMtddVjQ5iX/Wz3WLeT7r9ARDpw
         83ucF/jhflRuv119M9uOlM0JJlmULnPVu+Nfit0Ctoyng9V5/CGUVsXisCjFnDHiTuAq
         db+Ob/tM1LriaUM5t21idN3FYwnzVxaci2f1t1/hPN3/e2wXqeZDH9UTXHJE3pXXt6x1
         gs5mX2chsqQIr4s2hfq7xOQ+t7AeBIRX4fe24Q4m5+XCRCWDPokKZc/nSHjaG7kVOgax
         bshaXDEUNAQ67H2MzLqnpjJCnJBXnqjTc/FHZS1qF8T0aa+uPAv2+5nO9a0VFu9awprs
         bEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740679270; x=1741284070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o/mfaqlPkxYSZ/nQyeOcTy2xeSV0yUhY5MQIdEddiU=;
        b=s1DUkJYI1+wLrozI6M7Yz9pqKKmubkXRRjMgcnHovYBYmzcksjxwIRoj2Q5EfreJZl
         KWV1WbtQRVcgs1TrOdL9yvhOr2Y3g3vyKMiD5UxeBpc16iFhi8rXiSRlux+KGP34sDp1
         ViDCu0+hQscH9G+tlTrEmQluZ0ds93cPU/SEPfD4EXt5Or7YUn2Uk0ts1IwxDRsr9gps
         L3RKPRS6N1+lvYmh6IWiOY+/5SSCTLjZ7msa3F8oza62QI8jbPhkFH/ZpVU8eMf94kQC
         ZnvCOkVjUHcfyou8pZVaLKa7GWFQf8tv1ecQS/YZzzbLhD+n8gq6p/LTUi0qGOnDv7ek
         u3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVMIXplSA6nTKka+DVr2xJFA9GUV+mf08tdjqZwsQD+LpPWrN6n0zyArwMt6VdMJUh3WSVChW5sbQvHic7Siew=@vger.kernel.org, AJvYcCVsXriUfUH7U/gHFD33+aO6WKu3rrUYA7+uYFCzvqsDWl2goSNcy//cBFBCVrlhcriXonN85Z+o0sw3NE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1wB2HSaPBTrabpWJrKVBwZYpLwPYYI12k6W857xRPRcmqam6
	+pgTPsqsR0mHbfNlV0LJbxbZKoO/3y+mt1cc7BrAtTS83htcYdfKTubJs32AHGlEL1Hpm5j9utQ
	Wn2bidgnhLzdMqZqjP/UMDbibzPE=
X-Gm-Gg: ASbGncsMiu/Z99+pj8I5keWmchneBc2DKeDd2+lpJ3fV5mP0VsyObP/jAYyuHy2yQz/
	qVjQbeWOye5k7iZnZJAqaAyqDgIoSZ/Mgbza5z69eHpDIcukjPQBrgH/ivVvDI1kUDczow7WTWC
	NAs0IQZZkz
X-Google-Smtp-Source: AGHT+IGddreFNVOzoUZapNkQajljSYHbz2UsY8f3WD3AmwAySMFtTBjwjOH1OT5w7/u7dL9VWeCPC2MbQAMZOy+ncXY=
X-Received: by 2002:a2e:7813:0:b0:309:20b4:b6d5 with SMTP id
 38308e7fff4ca-30b792d683fmr45802831fa.28.1740679268723; Thu, 27 Feb 2025
 10:01:08 -0800 (PST)
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
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at> <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Thu, 27 Feb 2025 11:00:55 -0700
X-Gm-Features: AQ5f1JoiIR8LzflO5KrxyB6x2yLat_eBAQ5tFqFf5YTstbEnwtms4585RZGDqbU
Message-ID: <CAFJgqgTkzb3MeQrkbkd7Kuw0_JGs7VFj2xJuBaKTpYgt40fTJw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So "safe rust" should generally not be impacted, and you can make the
> very true argument that safe rust can be optimized more aggressively
> and migth be faster than unsafe rust.
>
> And I think that should be seen as a feature, and as a basic tenet of
> safe vs unsafe. A compiler *should* be able to do better when it
> understands the code fully.

For safe Rust and unsafe Rust, practice is in some cases the reverse.

Like how some safe Rust code uses runtime bounds checking,
and unsafe Rust code enables using unsafe-but-faster alternatives.

    https://doc.rust-lang.org/std/primitive.slice.html#method.get_unchecked
    https://users.rust-lang.org/t/if-a-project-is-built-in-release-mode-are=
-there-any-runtime-checks-enabled-by-default/51349

Safe Rust can sometimes have automated optimizations done
by the compiler. This sometimes is done, for instance to do
autovectorization as I understand it. Some Rust libraries
for decoding images have achieved comparable performance
to Wuffs that way. But, some Rust developers have complained
that in their projects, that sometimes, in one rustc compiler
version they get autovectorization and good performance,
but after they upgraded compiler version, the optimization
was no longer done by the compiler, and performance suffered
from it.

Best, VJ.

