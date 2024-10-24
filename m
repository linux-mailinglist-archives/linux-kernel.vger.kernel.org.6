Return-Path: <linux-kernel+bounces-379116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F55E9ADA39
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3602B1C20BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02C156F5E;
	Thu, 24 Oct 2024 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhWfe0XA"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DD1537CE;
	Thu, 24 Oct 2024 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739216; cv=none; b=e9Ptwv6IoNjvek7oWmE122vFLZ6O2PS8fm8oZFBRUPQfwZfFgLP7s8KSEcXSbFHkW9vWnDcIUmRw5zcZwuaXv4Mv2n1NtC0poxpkHUpzL6aCYiyzYRTizFaLnZiDlVWwSLB7iFg5bkGDJDfieUuMDRJ0R38RcD9jqGsYgJx0MHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739216; c=relaxed/simple;
	bh=CeS6D+1QUXlEuEpzlKrZVqshJgh+wIneCWMkJ3VrhIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQjvTpzIQ1aS5XDoQAHLHiFFBnAVEvAvy9rpH26V42JQ0ihoBg466aN3jVskxJO/EIsQbnckh1ovBzfRpmYYRW1zdKxG1/vuBrDwCC0sNTNwhzVVolRC3Ekzzp9udNgXilYd252IlJkuT74wJve8hTIcmUwEYQNe4TFw8jcZnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhWfe0XA; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-27b7a1480bdso255252fac.2;
        Wed, 23 Oct 2024 20:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729739213; x=1730344013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeS6D+1QUXlEuEpzlKrZVqshJgh+wIneCWMkJ3VrhIA=;
        b=nhWfe0XAF8zB4MX5ZAA2OBtd+WRLP4+OpvVflldcEmqPSuk955c6+FRAWel1aGYvnY
         rp8ntD2KYgsNBk9kfZnd1lCkHVKC/irYiSZ0elHYVNJiomFM1flp2KSKFhiQVfxU9f0P
         cip59ZqN7/Mrjq1mPzJgPtaM3FloArO7cNmnqLA3UicXZJVXf/G5gMfIrgmLzMMChkNL
         P1yjNDL0nTPU4bEpTBcMOIGsL6FR0VsNHVBiH3fjNjPJfweJOqTJR+uHx8PiKvgmI0fe
         9lHnv9LpMNochXxwj98/jsyUJqnG8GUISBY0/agyeb5noSAWZiIfKucWk8K+xm3jKzbf
         kYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729739213; x=1730344013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeS6D+1QUXlEuEpzlKrZVqshJgh+wIneCWMkJ3VrhIA=;
        b=qME8r3QBi2WOuPJRsTi0YFNZNYrO43Jus8WDhrmcJ+/7ig9bHcM7yleHtvDM4l0Ewh
         IWEOKYXAW/spVbfH5S9A5FQ7by4c8qgue49sxrUu8+WM9PxRrML19WXbF97MasaijRdG
         Zsatcuqr8rVF4TP5IP+IU4ZrTpyzS9whw4jg7UrVIsJDqIQfCdmXu+6W+8BtfDL7jykU
         gbqxhZmKxmUlIvYOhl2UsFfFYC9xer1j/SJAznt4kKCZLunIG7hoY3sdadVfejL5Dsgq
         LAPYLVXWzSZ/9VWiFPJUX+AYKY6Hptf9LrlX93lg0naoDpesUpBlRH9gq1mFHW+kOHdp
         oaEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOuN+ZWkGOcdq6xz+DGoXkfdOKL6aV1sugd49lWYfI4tOMJ7caVldaMOCRwl+DGfHeHPzJCxbhaL0=@vger.kernel.org, AJvYcCVyefa0GxTeUC5kb/3k3YHLBD2jMkQO+QSIb8AWTRoGrP7UINXJNoQzGdesmWFwa4n17pPRH/0AdMz7ZwgthPE=@vger.kernel.org, AJvYcCX9ZtuUSLQbYcEgxt9yCMECB0VECTiKVmtxuXSQMJr1u8rjmjJnWF1sHCTkKm/atODfJkojG/FxX3oC+9tY@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFv37JpyceweengCr+Y4lAUl4lpN/kw/NcDdOatxPBxYgq/WY
	EmcN9z/MO+z0BOhefffWzK6kShPVi85MRIwhZ1hNEPPA+TjuJODKdtQr3wEb8b157MyM0R2woDa
	N+f4yGXwUTrj3ONoHU4O2bqCxnz0=
X-Google-Smtp-Source: AGHT+IF7Kh6NVN/AxY8rAa46rAxHbFpWSG21XNJdoakKmMbz7auztoXmMnfDI/WsA/BeePDLnogiyXrJZfyoAqBhLk4=
X-Received: by 2002:a05:6870:a990:b0:288:b220:a57e with SMTP id
 586e51a60fabf-28ccb68fa1cmr4788549fac.40.1729739212713; Wed, 23 Oct 2024
 20:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023062750.849951-1-dzm91@hust.edu.cn> <46e54088-ad96-4387-8a39-2e4686c842bd@gmail.com>
 <345e8f10-fe1a-4736-9468-7c92ac55d62e@hust.edu.cn> <e0c34a1b-6801-4ae3-b04f-56dbce5c76d8@gmail.com>
 <CAD-N9QV-EBbSkrZ5TSUt7j3MhsAHMozY59gFOEnSQ1HB9cUsZg@mail.gmail.com> <8a8fdd5a-44e6-42b9-a920-ff00ac7dc57d@gmail.com>
In-Reply-To: <8a8fdd5a-44e6-42b9-a920-ff00ac7dc57d@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Thu, 24 Oct 2024 11:06:26 +0800
Message-ID: <CAD-N9QVHxKUMu3AWvQ=GMA_YOMLVrz29-pNjWeVmn7eO=_DE5g@mail.gmail.com>
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of process/programming-language.rst
To: Alex Shi <seakeel@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 11:02=E2=80=AFAM Alex Shi <seakeel@gmail.com> wrote=
:
>
>
>
> On 10/24/24 10:51, Dongliang Mu wrote:
> >>>> Hi Dongliang,
> >>>>
> >>>> Good job! Most of translation are good.
> >>>> Just the above doc seems still English version, give them a zh_cn na=
me may cause misunderstand?
> >>> Oh, I see. However, you cannot use gcc or rustc since it already exis=
ts in the English documents. We need another name to make sphinx happy. The=
refore, why do not we directly use the final version of name? :)
> >>>
> >> Uh, is it possible to use English version 'gcc' links in this doc? Oth=
erwise,it make sense too.
> >>
> > https://lore.kernel.org/all/bae3c59c-39a5-4daa-b37e-bbf077d57643@hust.e=
du.cn/T/#m8a948b24401404806f53e086f57856cf3a56a490
> >
> > v2 patch triggers a warning due to duplicate links. So I crafted a v3
> > version to use zh_cn prefix before each link
>
> OK. That's fine for this patch. But for long term view, it's better to fi=
nd a way for duplicate links.

Yes, I would like to keep it the same with English for now. Then find
the Chinese version or translate in our translation team.

>
> Reviewed-by: Alex Shi <alexs@kernel.org>

