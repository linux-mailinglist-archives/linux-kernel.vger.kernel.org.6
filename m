Return-Path: <linux-kernel+bounces-398595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9D9BF345
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D101F2255D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAE7203706;
	Wed,  6 Nov 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMzIEEOm"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712313C67C;
	Wed,  6 Nov 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910784; cv=none; b=PIHaqhAGVW7NC6ReWu/Ueo4V2a+EWyY5kGNZeV5fhUDS66ZwZBOfZwdxR++ts21Pn5rJnfck1bXRUnhgxIrtiLemX6sTJsAP2i4qUNiBhc/p/826IDPkwGv6u9mhK0fZN856qcIH7NVor20/+JRTBoh/mhMFVvbdfgnkpe9S3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910784; c=relaxed/simple;
	bh=lSs2Ql8K3qiqkapM5vsv/OoVosQPgneMzmsKxP0+3EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiZP/TXyVxCjCneDXhbJKxIsH6MVXaQJHQOMjLFYq2phcZBvp8qQ1ksEpIc1avrdALCtpfLYWdUzRbL0+QGcouUmBJLkM0hclVGICNT8FIFA63+Ubxj4E+q/St+oL10T6c8WUFfWyWLxLjQx8luhRpXwkFtEUAypV5kd9di6GsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMzIEEOm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so10335761fa.1;
        Wed, 06 Nov 2024 08:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730910781; x=1731515581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSs2Ql8K3qiqkapM5vsv/OoVosQPgneMzmsKxP0+3EE=;
        b=RMzIEEOm8gNxAcXyKo7Nu5SvUQO4fxg4APADj0ds4/oeSQxG7v4KFG9Q1YNcQmszr7
         IovGQUFLELXmbI+sCvx4yOwaB8Mt4P9uGy/2rSyJF/LTxqAN3Av1SC2OJnENqor8/c30
         IzpiFVpGVINpMQ4o1MpdZxeLF+sgagqAJCqDXH8DrUiMF5aONXe6cBQlBan2PN5Adw5z
         1Y8S6SZ15TmfMGf10ZgmU9uga93k6cLCJ6RkldG+kCGSrKnkhyN+gNiDAwc5zTgzft9J
         PynuOwbocvER2mlh+bKNNtBF1/KHJ03IwRB/65NzXee9DHNryH4UE/0oaH5ylmSonA5O
         HpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730910781; x=1731515581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSs2Ql8K3qiqkapM5vsv/OoVosQPgneMzmsKxP0+3EE=;
        b=wGoD/he1AGlYaSGR+JcogG1T/Hnv2K0aWccdEfTnVA9ePsmm/bkEKq4ae3AMeCofB/
         51swvKxtlkWIgYF0Zo0z5l0JAbO7hms6WCVk7YANol9LGotIdpwK9UF0psRJoUXX+Jir
         A7PgVGzeiyQJhTTds6D5ryQFN7dmvVniazT9zzt13ITlJ88QMgl/Olc1AVftlvcCktqq
         z9PTl2O0T+t6SIDDv16hhkldBrUwpBDLG1wdssyY+KMxiB2Sx8A99oRb+D25Z67XdtIl
         hYceLJV9/GSsHei+DZkv4TUeZFejdszGPlvGl6rkqxaBgberJC5yavSEYV+bKOIX1bFr
         qWwA==
X-Forwarded-Encrypted: i=1; AJvYcCV/sjrOV4lmU3r2FfvPebD656XO6BCgPjYmrAWx+5vrp0pDLgr87IjpBK62vLLwUCc3gRA5woR3M+8or3a+550=@vger.kernel.org, AJvYcCWuNpCiVV+WQr9MFi+vFktEBHnuHPONxgURe0tK5UtPSp70gUi1KFb41yuLJMXTSKuofs+kFTnAT4MziTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGKWdn8eaZ1pnj29dhQWa1ILU2wh4etiitLwRwXld7cDnDwFb
	7cyaXuh70QoUq+5S4Yd2Bd3Ppmhfu8FRs+UMlTts0K0cS0wq/xaIcp1TawuJi7gN7r/Rbf1nQUH
	LQvn3IOGJ5Fja6xafpXFyqbnl9Lqq82fLQZDvWvJN
X-Google-Smtp-Source: AGHT+IGtcZmvjaVyeM2br6+eLFiXa0Xbw3Mx325sPpMlFpjRtp+y/TKjry/sXXCbmZD23fjJgTCOw7j9VZxvBAK+xnM=
X-Received: by 2002:a2e:a58b:0:b0:2fb:55b0:82b8 with SMTP id
 38308e7fff4ca-2ff0cb11f69mr10376441fa.4.1730910780279; Wed, 06 Nov 2024
 08:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com> <CANiq72=9XiYOMQ9ttDrgqTt=mPZnWJuCL0EgQBjFObfqVmr1UA@mail.gmail.com>
In-Reply-To: <CANiq72=9XiYOMQ9ttDrgqTt=mPZnWJuCL0EgQBjFObfqVmr1UA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 6 Nov 2024 12:32:24 -0400
Message-ID: <CAJ-ks9kNmH2t2Lo2PdLuH5rwSC3UQRGWd-cTAX9-Q2FE6oGHiQ@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:38=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Nov 5, 2024 at 9:13=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > Doing a bit of archaeology I found the reasoning for the presence of
>
> What I meant by "in the past" is that, before the Rust RFC that
> changed it, the `PhantomData` would have been needed as far as I
> understand it, since having the `Drop` wouldn't have been enough.

I would be happy to add the relevant details to the commit message but
this is one citation that I haven't been able to locate. The closest
mention I could find[0] only vaguely mentions that this change was
made, but does not reference a commit (and certainly not an RFC).

Link: https://github.com/rust-lang/rust/issues/27730#issuecomment-316411459=
 [0]

