Return-Path: <linux-kernel+bounces-368975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C29A172D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55791F26216
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E975813BC0C;
	Thu, 17 Oct 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knlKz6cQ"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5613AD29
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125001; cv=none; b=lSGtpw84fb3F7f7MGK4A6bVifL4FvMcIavqi7z2mtHE6FSo/AlXXumkLxQbMNdQdwaqpXE4cNfai8lf7+df8Eqsfb7P4PgkI7mnwJ8YZecaGVMdHByS11rxajLbBtAuRtHjdp9/UuyeQcyachD3WGTNkQoXLssMrpp0v8j9awWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125001; c=relaxed/simple;
	bh=QQ3yPlmHif47DLR/Zn5xQDSKv4ALd+gwooeN/Tt/rWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJ1N2O7gjHHpeC51YelAKDY20+UZndlA/GiMRtCRA5sqNdIs4ElKDZ+c/pU5H31SlT5b8QjuEtdlLWmresJIF5M3DOVUYgfXqBVHrdFv+Eox6pdgjgbBQbdnF3DODwAh4tv6OhNoNheSGSHvRpI9CzxD7+s8U4zCzUcvoaoH8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knlKz6cQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4601a471aecso76471cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124999; x=1729729799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH0Z2Dabr0v6/YTuA2hPIezpeV5Gwf0kakguPcEDLYw=;
        b=knlKz6cQ9l8OXoh5ZK9yrXf8FmMKeX+eYOwo9Zvz7UY/o0CHJH2+BbM042VPovmCRa
         PC+4/bAMZ8Q8giLj2+ORXmqOqEzNoVDTEvYXeyLJrkW8VVyky7yqLEynyxDcxOqQX3X5
         O9e4Gj7whQ/lsd4riUTn28IvpLB/ioC1qO+V3uUWgi//o8QFA2CwEYCpmGjKUzg/ulML
         7ChVRA1wlM/GwhR3jEXiqSoGCreX/JCb/xC87C5b4v50TSWWs8dvecomGtyKW4KSZ8dS
         rlsA+VI8V9CC65d2o8n0uuJnAg7HUFuiI/sSBHqzzqY3lhqCrqpNjVs92pnzAtx1ufGr
         wRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124999; x=1729729799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LH0Z2Dabr0v6/YTuA2hPIezpeV5Gwf0kakguPcEDLYw=;
        b=kVlzKkbLDzxhd0Bw7i8afp0tN9iSo8CAJ+muccmtvgNHtFOdC3etkiM6PmiovqPIw6
         ZbCz1wwATwswQxhtJJbJvuo2e/tVO4y9Z3+Y4Rki8Cn3Owg/lH/vmr6GI2+t/JaNwMvs
         CgKXzw/M84OdoY5LejIYZUwjky68lrzHS70JW5bW1A4bPKmxOriI1s2rZPPpeYzY4EFc
         7amYc/trRws3f76iI+xcwp+1tQGFsgo4mKV97bTqr6kGeooPAt1YhwIsvhXlCmzfuMng
         7LgrRitbEgJu9tgikcVCtudyf5hr9eqsBNqASfsSk4wM1j9t/wvnyFBEpdMQGJ+NhS2t
         14qA==
X-Forwarded-Encrypted: i=1; AJvYcCXDEDmH5GyPqF6FrIWTiu28NyZHWsfHb6nK9BGZrPr/glqmUXdRlgAZXoeVPbDvO2XLV5licwQ0pVJsk8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrV/5QYN9GKH195DaCvYFhxEyZYSXxOfgYGq/XroYhDN0U05GJ
	JhWIjLXzk/hqzWziJonWjy2s2TtGhZmiebiLE10kYedmup8d29j0sU99D1WwKKlaXj7xuIVi87O
	moYuG6aqtNTOMORCwA/A0rycDqseoJs3L8c6C
X-Google-Smtp-Source: AGHT+IEkiqlXHuKYOU8SwBMR0dV+VSeKX1cEYOa+jnRE7HTVIAIwDiHxxERyXoPvpzA18MmYhkLujQjjhoStViWu6eQ=
X-Received: by 2002:a05:622a:a313:b0:453:5b5a:e77c with SMTP id
 d75a77b69052e-4609c7856e5mr1655011cf.10.1729124998247; Wed, 16 Oct 2024
 17:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015231925.3854230-1-mmaurer@google.com> <20241015231925.3854230-2-mmaurer@google.com>
In-Reply-To: <20241015231925.3854230-2-mmaurer@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 16 Oct 2024 17:29:21 -0700
Message-ID: <CABCJKudqG+8-MdxXRfdu7pYe=UniiiAV1P4QnbP2c1R3Q8DC=Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] export_report: Rehabilitate script
To: Matthew Maurer <mmaurer@google.com>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2024 at 4:19=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> The `export_report.pl` script was broken [1] a while back due to a code
> cleanup causing the regex to no longer match. Additionally, it assumes a
> `modules.order` file containing `.ko` in a build directory with `.mod.c`
> files. I cannot find when this would have been the case in the history,
> as normally `.ko` files only appear in `modules.order` in installed
> modules directories, and those do not contain `.mod.c` files.
> This patch makes it able to report symbol usage counts for a build tree
> with modules and MODVERSIONS.
>
> Since the rest of this series will change the format of `.mod.c`, this
> change fixes the script to work correctly against a current build tree.
> Given that the regex no longer matches the format used in `.mod.c`, it
> cannot have worked since 2019, so updating this script is purely out of
> an abundance of caution. I am unsure who uses this script or for what
> purpose.
>
> * modules.order in a build directory uses .o, not .ko files. Allow .o
>   files when parsing modules.order.
> * The .mod.c format changed [1] how it expressed the section attribute,
>   leading to a regex mismatch. Update it to match modpost.c
>
> [1]: https://lore.kernel.org/all/20190909113423.2289-2-yamada.masahiro@so=
cionext.com/

If this script has been broken for half a decade and nobody noticed,
does anyone actually use it? If this is dead code, I would prefer to
just delete it.

Sami

