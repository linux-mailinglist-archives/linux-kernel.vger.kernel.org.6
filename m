Return-Path: <linux-kernel+bounces-385254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB569B349B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C9A282B55
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688F61DE3A3;
	Mon, 28 Oct 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVJ2bUYT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70BE1DDC1F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128725; cv=none; b=dkZEviJDCVNfa/wock8zOh0c1zgPccWODhKijLX33+whARpkvzZNk9yQ3onnPkKeeUoaQDi8qyi7IeewSXO8Ii1lcUufHFRCfwrvGnrJCwVXxW6ZQ4Bmq+NTyXV4Ua9oK5UCgSYIKnKoetHNNTIaytiZsRKXzUCDiqZLb4cGOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128725; c=relaxed/simple;
	bh=FFGgXtmohDrPrQL03n2MnbMWwTvtG4p7zdfgNy2sDPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wok1pYUfSM0bu8vnsmvWrvoAg73emkr3ajW+iAbnNgg/39TfOKm1Ks+2qJjDmSDPb2Mt5/ujmtHgN+RN96w6QJi80WExXXW71zZ9wwB2EICGp1nihESotvvxO3t9N6MmW8Gt/2S+K09BFX9NPPH7Sk5YsHSXEiLeFmbARn5t5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVJ2bUYT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43163667f0eso43099985e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730128722; x=1730733522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFGgXtmohDrPrQL03n2MnbMWwTvtG4p7zdfgNy2sDPc=;
        b=hVJ2bUYT+ikpnvkgnSpy9+yn6mRwqtiRrrslR4zMpoMwqUD+Z5UM85wYJI0XHfg+mm
         nU8/7gcwEeYfnT6qwRS6KOYgqqhWSeyub5Jndt+XXo9PQc0qZKkGFFTwBLwE/5lZjcCJ
         pexfYEkTluAfh8n21EcIEimFJ+blt1Ll0QH3/xiYnDlAXbz6kTFYGqI2q3Jowq0iESRJ
         MmamSBrnDgSGVh/oIGtl2NyilgIJ6YrwGNPPTHP06Zvsifvyk2WUHC3I+OV6BlTnKmsz
         4dOPb73wm/sIJFDhuK/8c00wIAyL5pjaJOR1krHy8lREXOyP98LieN0Day37vsNlhKwb
         MJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128722; x=1730733522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFGgXtmohDrPrQL03n2MnbMWwTvtG4p7zdfgNy2sDPc=;
        b=dfJwg5ht/5Q40WL9JwvtkT+2OhgnfjIlVzD2PKEkao8tObl+g54jnFP/BrN5GwXDs2
         vG2RPQ/LgVq9JyM5h2QCUJFrfn5nRsX0rMp2gCmDnVbtKiX0OOCATaFEei/67KlFY6tB
         eix38Qq7raApR9n3sn3m9bRvp7l90CeRlOmlh+rLggYkbCiI3AW3s3az3683lDTuj2eO
         j/7ZMEivkJJdL1vn2vldOTBcHvrbtIzLB5M3UVFBo6t0bzcaPVwfx0j4PLuUM9WenD8M
         ZA3E/174Le3CI6ul7j71LX4WUXoOwRPb/i2Mu0SF+b2H3l5mwz/eLDbgGv78P+PgCpkG
         9REw==
X-Forwarded-Encrypted: i=1; AJvYcCVVeOjCPaCKvm0+myVczc3UxDhK5FnOUDaF+0sWsyvLxv1LyQe7N15GAQZ6CZ2jzPw7rvAaJjzrjQByhC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXuIP+JiFzVq/GMK7n7leFItvQZaZq/Iz9pGWn/nfaLHIx0puv
	zN1examir7vn74Q3HEaYfLHqFue8fmcOmuZXw2hypoQ6obn6S5N5Xt1J7PP/cokFhNZ45dtFm50
	1Vem40LTvpqI7Gj6p8qlA4fCeyxiRuXwTj0IO
X-Google-Smtp-Source: AGHT+IFCfEPhAw9HPgrzvc46aO8rpB3uCJMi4adwyiE9ANLaOsnM2tIHUodhhI9fuMWFoiBRyNCB1M+5kBEYzj1/FM0=
X-Received: by 2002:a05:600c:5118:b0:431:3a6d:b84a with SMTP id
 5b1f17b1804b1-4319ac77f17mr63256925e9.4.1730128722180; Mon, 28 Oct 2024
 08:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410281414.c351044e-oliver.sang@intel.com> <CAH5fLggdtev=scJ1C9EefZf-fVrMvgMbfD+b_T5vFfHqNTn8Kw@mail.gmail.com>
 <CABCJKudR2UwvR8x4MwKYPmHETMz+aoiXEXz135BoufTF9Pt2Gg@mail.gmail.com>
In-Reply-To: <CABCJKudR2UwvR8x4MwKYPmHETMz+aoiXEXz135BoufTF9Pt2Gg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 28 Oct 2024 16:18:30 +0100
Message-ID: <CAH5fLghwEGCAxCR+OifGYh3jKK4jJqa-AX3gMUdN0HETBNBkYg@mail.gmail.com>
Subject: Re: [linus:master] [cfi] 8b8ca9c25f: CFI_failure_at_do_basic_setup
To: Sami Tolvanen <samitolvanen@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:15=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> On Mon, Oct 28, 2024 at 1:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Hmm. This config has:
> >
> > CONFIG_CLANG_VERSION=3D190102
> >
> > Sami, is the fix not available as of llvm 19?
>
> Looks like llvmorg-19.1.2 doesn't have the fix, which means it won't
> be available until LLVM 20. :/

It's not going to land in a patch release of llvm 19?

Alice

