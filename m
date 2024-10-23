Return-Path: <linux-kernel+bounces-378750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60E49AD4ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112EB1C21DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDCE1D47CB;
	Wed, 23 Oct 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghIGXDhN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBA1A0AF0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712270; cv=none; b=fUZfaxzjheUgxAVcIIvgogW9tCJBq4mEOGU7L6axWtyjq6iJ3yr68Qv6v+HvJQoExGNzrYvAXkgD9jd3vnz0NAZrvZ+2CmGS9dpC/YnVd1bEfpg4ECh3dgtIw5T5/a9mZfw04Axw5q4Z2Lket4bNbwVFT2yVEv7qucImLhGGVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712270; c=relaxed/simple;
	bh=vk/FW0uRyjtg6oxehehOKzEOIARdwQsuFnOoLse/8iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9Px4MptLBC79aoyTdT4lJrROgaIiQ7DjKjegq5Eko9brinIpL1CH2U36JyHisuYoVsAEKkSiVHMxDJMwYmJdnaCqCfEPjjq58AwdCeNuyvs0FGr2uy0sF83xngRx2b2HP3MDg+8mBNcSGI1bedtoiz3k1j25qduKGwIcLQ2Q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghIGXDhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73EAC4CEC6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729712269;
	bh=vk/FW0uRyjtg6oxehehOKzEOIARdwQsuFnOoLse/8iQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ghIGXDhNVew32ZD2gMYlCt9/Pt1neNoOGigXStw4tc/98IiT0GqedekdnXm9UH+WM
	 cUATonbfsih9F6Snpj/d7OSeX4g23jygN8E08c1v7mVHOQNIIIFmqzrisbLpGn1cHj
	 dppdmDZ1GfzUizbjehCAmcCDXrpUysl9vglyIwIk8tDEnENo9+9QB8zc7o9WCm7uMg
	 Dz642l3sOhAFmALPJr17iNQX8NdEPgMAhdGgvqUce6ss30duPqF9HPsLbqxL4PrAEQ
	 dP1cjlyuWZgOSoufbw7EFP86+JlqwGAMdWoyUguIdsQ0vf98lg785QExfeWMUwJysD
	 jYxI/D2Tp9kYQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f6e1f756so172273e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:37:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwLTnX+mETWQo2l99MbUPtJbSuJvPXG7VF4kbmXsvUiZUJVz6eRlbab6F17Y3FhL+lqUmekggTBOSY+qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycTBNDpsrUd6u+Q+qQFBpfNXw6vTlC1OzN/uHVmuAIPGU/Od8u
	91C1Mm0aX5q2nZg3hXZ/TCTJ1TZemyjVW7vOfXQF3fjF3F4GTiHFWh3BIJ91yOKKypnsjgdwFIY
	n7u1tNbd5eUPK807UyxaUNXox1LU=
X-Google-Smtp-Source: AGHT+IFQGuMX2jeh0Jz5r6yINKID7eudPZRo77vcpztx/Pw+oCsd+qyagqPgVWuX6sGYES1W9s3KudctWdki1aWxFYg=
X-Received: by 2002:a05:6512:280b:b0:539:f51e:17d3 with SMTP id
 2adb3069b0e04-53b1a303093mr2066930e87.14.1729712268212; Wed, 23 Oct 2024
 12:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuVefYJx9JsVx1Wz5pV1jKCp9eCPtwZD+FVhdk841q1Zw@mail.gmail.com>
 <b153383c-797c-42f6-801d-a6dcc7bfc4f7@stanley.mountain>
In-Reply-To: <b153383c-797c-42f6-801d-a6dcc7bfc4f7@stanley.mountain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 23 Oct 2024 21:37:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFXimHaGdeDBH3fOzuBiVcATA+JNpGqDs+m5h=8M_g+yA@mail.gmail.com>
Message-ID: <CAMj1kXFXimHaGdeDBH3fOzuBiVcATA+JNpGqDs+m5h=8M_g+yA@mail.gmail.com>
Subject: Re: drivers/acpi/prmt.c:156:29: error: passing 1-byte aligned
 argument to 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
 unaligned pointer access [-Werror,-Walign-mismatch]
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, clang-built-linux <llvm@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Anders Roxell <anders.roxell@linaro.org>, kobak@nvidia.com, 
	"rafael.j.wysocki" <rafael.j.wysocki@intel.com>, rui.zhang@intel.com, mochs@nvidia.com, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 21:06, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> > Config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIm4ZOkWenPJ71UOZG57R0jXE/config
>
> > drivers/acpi/prmt.c:156:29: error: passing 1-byte aligned argument to
> > 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
> > unaligned pointer access [-Werror,-Walign-mismatch]
> >   156 |                         (void *)efi_pa_va_lookup(&th->guid,
> > handler_info->handler_address);
> >       |                                                  ^
>
> The problem is that efi_guid_t is alighned but guid_t is not.  I would have
> thought that Clang would say that even though the alignment in for &th->guid
> isn't spelled out explicitly, it would still end up being aligned at 8 bytes.
>

Yeah this is bizarre tbh. The alignment of the type should be irrelevant here.

> typedef guid_t efi_guid_t __aligned(__alignof__(u32));
>
> The relevant code looks like this:
>
> include/linux/uuid.h
>     13  #define UUID_SIZE 16
>     14
>     15  typedef struct {
>     16          __u8 b[UUID_SIZE];
>     17  } guid_t;
>
> drivers/acpi/prmt.c
>     54  struct prm_handler_info {
>     55          guid_t guid;

So this should be changed to efi_guid_t.

Doing so makes the following pass:

static_assert(__alignof__(((struct prm_handler_info*)0)->guid) > 1);

(it fails with the original guid_t type)

