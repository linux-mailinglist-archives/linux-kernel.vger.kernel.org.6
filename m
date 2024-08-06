Return-Path: <linux-kernel+bounces-276384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BFF9492C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC40D1F21BBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE0B18D63F;
	Tue,  6 Aug 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNo3K6vl"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5518D631;
	Tue,  6 Aug 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953655; cv=none; b=NpMDvFCoBQqfuK4FhY0imMs3gJbxhhjMN9WeGMBvrJO639SgYBuTnjicUSUNZkrvbCrf+v/PMD6U0GOu0kfbidqaE32nKWq4X8CsUhbN6gRKDixtfClkhUHY+HVmMV+yUfOLpVISmzg2hH4IVUN4chTylhrCbTgHxJTxa/PmlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953655; c=relaxed/simple;
	bh=U6Dy6uIyj+7meuAbQzHOBFmp18X8IQw07sYpaEHBqf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bj10zzISLz5t4xyn9NdmZ/VnMrL1Tb1rC6ATezysVKM/2mFbR/+PhRMmgGZE8ccStGx9Qfz1gmVrsG2vuu0Db0FOG+YIRbEa1+mS6hOLIA+umz0nHCMkmRCIRZx4fJuWR0yZ4NFEKTK7Z45I7mEE9m7LIEX8/gyL6KSKFhrVKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNo3K6vl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-70b2421471aso448571a12.0;
        Tue, 06 Aug 2024 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722953654; x=1723558454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6Dy6uIyj+7meuAbQzHOBFmp18X8IQw07sYpaEHBqf8=;
        b=bNo3K6vllwUM6A2zJ1osEMYi6Bh8pPZ7TOWMvDJTYLX1BPmFQwgdDiHjdKGdqAjpzt
         VgP62mUtClaZouCPqULCfY0My6i8/nXhEGbLmOIBheuBuzevuY2y40z7PxEKV+itIUR0
         LEZ5kVHnxiqR1VtCycM3eSSmUhk71wjjW5gCw1sjp5p0eZddCSRsDNFsk3DrtbO11KUR
         eFFRFC4+pq3D03hTxxLLQyvyA76H1zSb9RYemJUQtEPlzDxPIWhl+yN4sRg3pZR6+MCZ
         AeAPSyPXUh+wtOvXgE2L7OuAtxOf3VcXiO16hhK/027nMCIyof9ao6tSpHqS3cG/P4jy
         TYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722953654; x=1723558454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6Dy6uIyj+7meuAbQzHOBFmp18X8IQw07sYpaEHBqf8=;
        b=oqLCxpmO7Ujghm2JNAZR/+OWiXPb75xl55bKiukzN2GNFD5ljouuqmbDyd15wtKXS/
         N+GdB7TfA7j5w4ScYCzhRfAf35CFOr1yFsezs6lnCj7IhRho7QKsj13Lbk4ddNdkud7k
         N52uc80+az2Y28tpRea039PYEZrWTpuTSbiUV6c+3rN5ZF9hn6i7twuOZm8VQSlTdJvF
         AduxhNC2JvGhrc8VumRLkd/fTKA7g4Sgx6JzH3UP93S04pd7od1N5xbMadZXsfQ/Rlkj
         a9Apkun2S3CVdsvpAqnrWCfIfX1Sr6A+quJSLBkuUq6ARPwiJQtk6Q3KAT/+3wFMhNBB
         xDAw==
X-Forwarded-Encrypted: i=1; AJvYcCWRMODoFtOYzgnPFqXWdfswOa5ixFA3NTOcOXPPaIVVfPvFlpoLxqPYnI4bHQBieBPm9diVL3GxQbYC/TYEpa2G3too4Mhy7nPdeCdveSAQGKGeEdHILgIfoTMEx6iEGq/7A1xK4+WpHQ++zzk=
X-Gm-Message-State: AOJu0Yx+2oZBn7K9/BWfSVKsPqZcuMI31Sx3I2Brc9KBJjOinTb+Mm6I
	GkEq60r19K/8jylzjmHgicbi2Yr/16Jop1ydRU+s7RHf/WSVaKdwZR+9MxuY+d+exxGMQM/ciaf
	UaUkfotvKvcR0wAYzZ7lrKSyC6nM=
X-Google-Smtp-Source: AGHT+IHsYgG17t9omf6LKiN8vnig3w3sIZWMN46z2geLqnGeqfG43s976RY2MGOXqzn/FVGJbB88SKeFLCV8tOo2pjc=
X-Received: by 2002:a17:90b:38ce:b0:2c9:9643:98f4 with SMTP id
 98e67ed59e1d1-2cff93dbc0cmr13412741a91.5.1722953653713; Tue, 06 Aug 2024
 07:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
 <20240723-linked-list-v3-2-89db92c7dbf4@google.com> <037f16f4-e959-4801-90b2-aafb7afcfdb6@proton.me>
In-Reply-To: <037f16f4-e959-4801-90b2-aafb7afcfdb6@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 Aug 2024 16:14:00 +0200
Message-ID: <CANiq72m4ufvpHwdLVaSZZsNoMxSCdwdRyAFM7recpy3soMozGA@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] rust: list: add ListArc
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, 
	Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:47=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> Can we start using `feature(derive_smart_pointer)` on new enough
> compiler versions? (I guess you probably want it as a separate patch
> series to avoid delaying this in case it needs anything [eg the new
> build system])
> Do we need any Makefile modifications for that or could we just do
> `#[cfg_attr(compiler-is-new-enough, derive(SmartPointer))` on the struct
> and then cfg these impls away? (and what would "compiler-is-new-enough"
> be?)

That is possible with the upcoming `RUSTC_VERSION`: you can have
Kconfig symbol for a particular version/feature/etc. Please see the
upcoming lints series for an example in the docs for that.

Cheers,
Miguel

