Return-Path: <linux-kernel+bounces-276938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C6949A33
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7A9285704
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E6B16D9B9;
	Tue,  6 Aug 2024 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH6LohWg"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2914BF9B;
	Tue,  6 Aug 2024 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979800; cv=none; b=PZHeHC9MNp7ekeEbbYkOBIX19Ic35Z/ORHkJlY8hyuSGUaeVgOBW7runRvgX+DoIPX578ezNXTHdX6eP+r1Tmc66NbghyymqSoSzg2wMhjrYz+hNEHY2gUqk/fk/Thnmzs9y89IwJ1528dD354tJjxCj1ATGYc+1Aijcw/mGYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979800; c=relaxed/simple;
	bh=YAYm883qR2b+0OMMEKEDDwX0rE3CyHC+yxTlu4vjzeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7JBVePcXEb3vJ+aR/b3hd1iPJ7cQORQYGRd6Eo7nF3I6xzahhH9+BDVxH6hec51Y1SqrM5TjpeN+mx28fj7D/a3fCKNlV0COyWk9fHX0LYwB/TG8Y2x+n+OyZcc76S850DxWk370I5xc+zP+6o8+i5VWXWzkIk5HRqoLCoY/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH6LohWg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb7cd6f5f2so835581a91.2;
        Tue, 06 Aug 2024 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722979798; x=1723584598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAYm883qR2b+0OMMEKEDDwX0rE3CyHC+yxTlu4vjzeM=;
        b=CH6LohWgP8/Zr9nWw/mQwjad8zqJbTLk2iR6epdtUvJwRFjEGShafjQpEcSzx/O5zq
         7Axb5F7QIVrpx/lWj/dUj1fqy+IuTTdt8ZZHlo3bo39nvGIRtGDofb0ts0PFA2A8pNR1
         uywWB0eED0SK0K2LH2hqC2AKGw1DnWlwZt6Qpyvi8ILIz9I4MUYLF/18YzejVdN/zp71
         zpWpN3IDbqN5hiltCPC6qgW+wenTshp8hvmGpQ9IHtXX4wT/MuBIucw/XU3XMsHuGaJ5
         GelVjtU9zqHb/WRrzR+8MdVOEHVLel5z0IC4HDUcXbMfcgsURRoRBxcRH9BTbYr6uUT8
         x1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979798; x=1723584598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAYm883qR2b+0OMMEKEDDwX0rE3CyHC+yxTlu4vjzeM=;
        b=gszG08Brc9+jP4g53xmlRKDpNrinGh+T7nNOQ1qRXUVeE7BggUdF+5v5bOPL6m2sp0
         AW8wa3AkLZCBR8gvYWKf2ToaynKlOX3tVWAUjpTrjmdd+NBTOrJVIdyMZ6szvcp7kBpi
         4Cuixdt9wPmosc8tInLv6HCQvihLzbT9wta2/PgBg1Tn5iqRQJrBfHdMWkOokY1wgeZb
         iEu1hSc6J6PsREAhW6TGSzx+7lgAPzWJBVxSvFC5njONQGVrbqGGlonJB2gBoqAZghPp
         xCLetB9MDQHlSVXf8b5qaP1qQiXRCk3DuMCM5AwQLPX5GlRP718TUihz2aRYK/iqhmtc
         Wz7A==
X-Forwarded-Encrypted: i=1; AJvYcCVhQjFMJ1mQ1Ucw1T5lRjYZJPeKRcBal3BQD8B+4P1TFnl6LpXMUYTqUH0nf/Cmi7a8HEMgXmcO5+YQekdtjdLl6m1VcnXMlEiPZhnlJDGeSCGlVs340SgBeqmfIEJJeKgvQ7y0BGiyMwStYYA=
X-Gm-Message-State: AOJu0Ywl30TS/JSD0Iaj+awGwVwS1JdPdLPnwrLPvwVUPJ69Cl4DLOz4
	H+6UfAb9H4gPnyNsQ9xFkoNx9J++6gYpdDV14xzTO5KXgH41IMgewcOFt+SQ1dkYoqDaGb49NqU
	HuLa6ZlNNf/uSAlxxlT2qyVX8rco=
X-Google-Smtp-Source: AGHT+IEzClk6wi93u2N1ixrRD20SSYcAePSE4oKBt1hQ8ZNBYd1wNxcRTjFOXdxvnz2DSbe4P7vhA5aUuctrQ5oTFLo=
X-Received: by 2002:a17:90b:1652:b0:2cb:55f9:b7c5 with SMTP id
 98e67ed59e1d1-2cff9415bbfmr19564109a91.12.1722979798377; Tue, 06 Aug 2024
 14:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725183325.122827-1-ojeda@kernel.org> <20240725183325.122827-6-ojeda@kernel.org>
 <202408061241.855CB28@keescook> <20240806202217.GZ37996@noisy.programming.kicks-ass.net>
In-Reply-To: <20240806202217.GZ37996@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 Aug 2024 23:29:46 +0200
Message-ID: <CANiq72k1OvLEV2uf56vDXGvWX30YWa_r6ewS2fGoqxVGcqf9LQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] objtool/rust: list `noreturn` Rust functions
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:22=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> So it would be fairly simple to make objtool consume a magic section
> emitted by the compiler.. I think we've asked the compiler folks for
> that at some point even, but I don't have clear recollections.

The section sounds like a good approach -- we will ask the Rust team
about it. Then perhaps we can get Clang/GCC to implement something
similar too -- for this sort of thing we can use the shorter cycles of
`rustc` (and their unstable features concept too) to experiment with
these things :)

I have also added it to our `rustc` sublist of things we need.

Cheers,
Miguel

