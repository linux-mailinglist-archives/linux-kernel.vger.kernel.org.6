Return-Path: <linux-kernel+bounces-361987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B132799AFAF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17015B224AA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9BB9454;
	Sat, 12 Oct 2024 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YswAkNgY"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2628F7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728693065; cv=none; b=LRGtiVXoeUazsKulrCa2Enc7y9BJijFJ/Ft3TGrbP60xFiUt26ybl/0raGw3Mo+a+VUD7ZvMm6hV6RX0nXw/bsEDvTtUSQjxn3k354M8KJlU1v/TWL8kkv4j8fkvICsicGdooTsRxGuLU0LnIZG4jEFhRGbMKamVoIxsOYAbsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728693065; c=relaxed/simple;
	bh=abPuDlGAZOCwFmBDPYtgCz/VJjFeLYN9OPEzocR2J2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swiTAfFhv+rcFa29A9j1jAkH3x6dnSVFzoAu3cW+0V9kfESBO8MFE3sf5dH1f5XqWMIdx77r5JQyFNR4Bbg/KJbAcsWieiylQ3gI835pt0N+7RKRqFq7exg/4oZ/o5yNaLCiBUpABiXudJF1xIdY95iDhOZ5AVMMrh16ajgcmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YswAkNgY; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460395fb1acso97441cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728693062; x=1729297862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJGsN3O4dmgvmvJTfWN1EB6FV9LDR+z6vamKRwbxBD4=;
        b=YswAkNgYieE8OEj9AlpoJDlAd1WZADTgINunYX+EU9l4tutxUw6J5f2j0GaFTk7NaO
         PbDYAmHjZ0/5zwmJT6/pwJd6iYwpGrw5J9gCVmcqwTBveegO6ind2BzHzWNcZBqkKsae
         7gbJSkB3q7TQRRGUOWePfPTy0vz6SLD4HSY8e8MwWvFkEggValZfo1mqhEWJOrdGgL79
         B41o2dg9CoK5oj87/k7KSs8ziWh0kicsfee32BlNx7AxDY9fg27XFYQPjmDMulYsXqs/
         Se0rHKhlNJkgv2TanUJ1CQQ74Fmmuf6KReuAszNVn8nLZqPmrebod/Fc+QToGIiJXjkN
         buWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728693062; x=1729297862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJGsN3O4dmgvmvJTfWN1EB6FV9LDR+z6vamKRwbxBD4=;
        b=TXrHyO/2ToULkIx2XmuEgXBM7SAO0AXfl1V0cSCIFbVYscrtbg9GBs4YpNaZJ8dKsB
         uHWBpazKEZNxGytxboMQHtnRE865JicHlAPCX6K0dXP7hXy66x8OxZhbP5hK00BduJoD
         ayo6i1a+05rOY/cg/ezGPQolf/7z/8lX3z/8Y+Ara2GMrZonCGao8FQb/skfRV66BGFL
         qmoa4W/bC14BOnb5Lx4Fo1KV0hVKkKaCs9l4i8HUUtC1dClng57UKI3TWpHPEJpfDJDm
         fyx828AKirDrzrMYRO7Mys/hZWBDAQqH/JlOPeqamkrqnP3SD6CDDA6EVNdSOCz7fl+H
         3Kog==
X-Forwarded-Encrypted: i=1; AJvYcCX03Y8hOirJfkNzazwcnC9Edr9yBoS1Lix7Rrq2AtC8BYIcNMyZ8PX0UAFxTKQO8Q9J5e9hLkieSrE85DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYTF0zNu09cNXe6AAthJTn2lTcVyZyVD1HhOgBcfXXHxmD5Cx
	/In2xEsAPpwoQpXXgcnR7n37Xi8n1SVC3BO/uyvs2LYq4w8lavOd9gxIVOKY+h1gh8cnf3C0pMR
	M5NKAmdKAekIZoA7mQC7KNn2/THEGLNVmrXo9
X-Google-Smtp-Source: AGHT+IF62uzsrTbog5umzZidYkR3ujw904388lXiegQU7aUwsewaU31QThGqPwmYjMh9iiWNwOimm89BXflxS19eetw=
X-Received: by 2002:a05:622a:768e:b0:458:14dd:108b with SMTP id
 d75a77b69052e-46059c44444mr506521cf.13.1728693061828; Fri, 11 Oct 2024
 17:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com> <Zwm3ykuiyI3ugr44@bombadil.infradead.org>
In-Reply-To: <Zwm3ykuiyI3ugr44@bombadil.infradead.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 11 Oct 2024 17:30:22 -0700
Message-ID: <CABCJKuc6w0bYRmWMk49_KRAiB0ZaHFOPRSP=sEQAbz0ArN1ORA@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] Implement DWARF modversions
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, Sedat Dilek <sedat.dilek@gmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Konstantin Ryabitsev <mricon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Fri, Oct 11, 2024 at 4:42=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Tue, Oct 08, 2024 at 06:38:24PM +0000, Sami Tolvanen wrote:
> > Hi,
> >
> > Here's v4 of the DWARF modversions series. The main motivation is
> > modversions support for Rust, which is important for distributions
> > like Android that are about to ship Rust kernel modules. Per Luis'
> > request [1], v2 dropped the Rust specific bits from the series and
> > instead added the feature as an option for the entire kernel.
>
> I think its important to mention *rationale* why I recommended it, it
> let's you more broadly test coverage / support with tooling so that its
> not just Rust modules which tooling will have to support. It gives the
> option to have *one* unified way to do things. Not "rust is special",
> oh no, do this instead. This also allows us to empirically evaluate
> if this new solution also has benefits. If so what should we look out
> for, metrics, etc. If there are proven benefits, then by all means
> why not make the the default.

Sure, I can expand the cover letter in the next version to include
this. I linked to your original request, which gives the reader some
more background, but you're right, it doesn't hurt to mention it here
as well.

> > Matt is
> > addressing Rust modversion_info compatibility issues in a separate
> > series [2], and we'll follow up with a patch to actually allow
> > CONFIG_MODVERSIONS with Rust once everything else has been sorted
> > out.
>
> So this depends on that work? What's the ordering of things? That work
> seems to be aimed at addressing long symbols, and that is also
> generically useful, and there were odd old hacks for that for LTO.
> Bring the patch reviewer with you, as they may not have all the
> background.

These patch sets are fully independent, but they are both needed
before we can support Rust. I'll clarify this too.

> > Short background: Unlike C, Rust source code doesn't have sufficient
> > information about the final ABI, as the compiler has considerable
> > freedom in adjusting structure layout, for example, which makes
> > using a source code parser like genksyms a non-starter. Based on
> > earlier feedback, this series uses DWARF debugging information for
> > computing versions. DWARF is an established and a relatively stable
> > format, which includes all the necessary ABI details, and adding a
> > CONFIG_DEBUG_INFO dependency for Rust symbol versioning seems like a
> > reasonable trade-off.
>
> I think its important to state that most distributions enable CONFIG_DEBU=
G_INFO
> already, so this means Rust modules won't be asking much more from
> distributions.

Ack.

> > The first patch moves the genksyms CRC32 implementation to a shared
> > header file and the next 15 patches add gendwarfksyms, a tool for
> > computing symbol versions from DWARF.
>
> In case I find issues with this patch series, let's split up the patches
> in the next iteration by two sets, one which is the cleanups,  moves,
> and non functional changes, and then a seprate set with the actual
> changes needed. This let's us carry on faster so I can apply the first
> set.

I think the first patch is the only one that matches your description,
but it's only needed for the gendwarfksyms tool we're adding, so I'm
not sure it makes sense to merge it separately. I did have a couple of
other patches in previous versions that would qualify, but they've
been merged to -rc2 already.

> > When passed a list of exported
> > symbols and object files, the tool generates an expanded type string
> > for each symbol and computes symbol CRCs similarly to genksyms.
> > gendwarfksyms is written in C and uses libdw to process DWARF.
>
> OK so a new lib dependency at build time. What if that's not present?

Then the build fails. We used to check for libelf (part of elfutils
like libdw) in Makefile before, but Masahiro explained in commit
0d989ac2c90b ("kbuild: remove libelf checks from top Makefile") why
it's not necessary to have separate checks for the library
dependencies:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D0d989ac2c90b5f51fe12102d3cddf54b959f2014

> > Patch
> > 17 ensures that debugging information is present where we need it,
> > patch 18 adds gendwarfksyms as an alternative to genksyms, and the
> > last patch adds documentation.
> >
> > v4 is based on v6.12-rc2 and for your convenience the series is also
> > available here:
> >
> > https://github.com/samitolvanen/linux/commits/gendwarfksyms-v4
>
> Thanks! OK so I'd like to see next test coverage.

Thanks for the links, I'll take a look and see what tests it makes sense to=
 add.

Sami

