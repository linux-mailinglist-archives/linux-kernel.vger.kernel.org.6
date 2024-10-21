Return-Path: <linux-kernel+bounces-374961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805569A7280
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D0F2838BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC91FAC3A;
	Mon, 21 Oct 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLeci8tg"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E531E3DC2;
	Mon, 21 Oct 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535875; cv=none; b=dkdIi7P4B8xpSxZbEcTWVkSF3cbS48JapOXpeGiGVDn1scGIlSrR7H0qp2jcXIfSm4jUudpRRuJN8eeZCWPIwuPx4usB/0sJb/3OwR+5xaxii5I2I0+DepzOAAj23q8Ppk0Nc/tPy4d/sy2eoK+h56Dj0akVXaPR3c7H6Hg258c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535875; c=relaxed/simple;
	bh=pPa4shKlpre8CCrtyYHix3LMUxn8btblnNGd08k03bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBN6Lui+799u6ASLcqWlQj3SsXAdvDMdPNZyV3w6WiO1fporDurKK7bkcaQovQ8YALNVBOmiHcZK4zN6GOfQ2cAvSZABfj+1pc5q74eIMuDJvBgec81NhMv0K4sJXClN+6euu0VzvPZUpnmdOwFig2HAvIfjECSA8mxcBT6fg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLeci8tg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so678306a91.0;
        Mon, 21 Oct 2024 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729535873; x=1730140673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPa4shKlpre8CCrtyYHix3LMUxn8btblnNGd08k03bc=;
        b=cLeci8tgNdmlDgelWMyDV6CZWPLCDSaQiwNfmFPcF3k989RFhXkLlvWd2EzpdFTmUG
         b1wq5y4KFMFSSPGewC8hEdY8olSXXlyjM9Qy1XtEcBq4icNdO+TyO0Ovk06gYvp7VoU5
         EhziXHSUZiGooLzY2UorZ0Z4Rn6HWLWUsqaohdFKYZq47FLK6ToSveOkZpk8XvBgA+Oq
         UW3m+jilcPykFvL7SqTmEFHjI2T66TROY2ifTy32nfY3rD9j1U+RbKsAJ3JYVO/jwAa2
         aGaj8RYfuIyGGVqSR7SwIMB7cMjw8V2+ytkwUy69NBdQ9YxB9fOAlDPp6FRulI9TEprf
         HKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535873; x=1730140673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPa4shKlpre8CCrtyYHix3LMUxn8btblnNGd08k03bc=;
        b=WY5/8amUoLK2gn8cCKzeipVQIhf+R5oFR1gDR9I/qtewCzLNlN9+BLh1vD76qUSPaG
         OnJdk0BKj4Op3FILhaXqoTFBOT5Z1sGTLi5E/Bnl1Pj8oihcL+Pia9vRTWqnkBY9hd1Q
         fXa77G/Q1KkSyH+kkn8iVgGL0rWs5wsIXc2c0KaMcFgZIjnd09zb88Uu2m8T44qzxWcT
         5C0hk4z+gpDqx4DY45VO5MfsSUNlUbSQSDDTt6aWRnebwNAvJb1lKxP7sN5wNekg5USs
         k8iaJCQxn1vJoJ3L/HX83OswT9x8k4d5vNl5oeuL8Tfp/4OmT7ASINszPwKOn6v6CC7H
         vxdA==
X-Forwarded-Encrypted: i=1; AJvYcCWYu2VSoC0c0Paf01/Ii3Foi4RoWQktfQ3PK8bwsprzLNESebnomvyz5QpzHV0M9inLh1UkidZu3Z3BSvl6QTI=@vger.kernel.org, AJvYcCXOoGry2amdXmfjENe8oTlkiOvWEkP8ct/tse5vA24/9MlSliesK5nonfxpZT4s/pBcJHnXyAdDiUCOGkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7zq/KYnCLjbaCD2Ih95es9SeufQ2RoLHB1+YoRqqgJa2sge5
	ImNsCDrxjNmDA3LAzxDbTo4qWP9Mb5UL+I64tbBCQIHjqFiPVadJvA1jKFuX1K680hBvy02fkxw
	05pjQifD5H5bUHufngxEacXQYMo4=
X-Google-Smtp-Source: AGHT+IEolFR29ebiY6smiX7o5ywww96PkVHeVkUC1ngQi/CoyrPZPWQvsI8DNKWsf266VJ3gPvBCLisaAHu/YecZBvo=
X-Received: by 2002:a17:90b:358:b0:2e2:a60f:289e with SMTP id
 98e67ed59e1d1-2e5614f7a55mr6189002a91.0.1729535873470; Mon, 21 Oct 2024
 11:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
 <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com> <CANiq72mW8seB=938XZM7bwdSU43z0eePXinE5QPYyybvNfbUeA@mail.gmail.com>
 <dc5e7653-8d6d-4822-9c29-702ece830717@nvidia.com>
In-Reply-To: <dc5e7653-8d6d-4822-9c29-702ece830717@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Oct 2024 20:37:41 +0200
Message-ID: <CANiq72kuQ-fNTYw33czgN3_DYjixzk01+hahFhR4QSkENeDBkw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:35=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> Is this another case of C and Rust using different words for things??
> Wow. OK...

I am not sure what you mean -- by BE I meant British English.

See my other reply as well -- I just changed it anyway because Rust
apparently uses "parentheses".

Cheers,
Miguel

