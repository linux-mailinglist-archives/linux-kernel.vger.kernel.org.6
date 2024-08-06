Return-Path: <linux-kernel+bounces-276795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B07949886
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05CB1F244C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2495149001;
	Tue,  6 Aug 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q9O1jiAW"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECB145FFE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973139; cv=none; b=N+Ij+oO5r8x1aH6IcWQABbJqUAP9OwPA2+t9Yh6+dhbi8Mq6v/g+sr4gR9nD5Y3Yhw2S5YXq9A9L+bm20cY0M6egsO5HdD3+lMCVk1Me1c0drTuY2zyKhETiXczhN/msCdo7uerD1udp2uufvmbDi9roa86DVkbZuyDIlpiD1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973139; c=relaxed/simple;
	bh=Ch3nccCFbXy+E8ddckutXkGeZ/TROWFl9jlfAcFeN68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jytb4ondaC9dKjqvbYsdB3IwE/1Tk+LeHKZ3BZrY4VsBgxOp1AliojJ2YHUJdgxmZrhXBpTEJk7V+DoQLnKkrl5ad+7A1xO2Ewmf/dv7LX3uC5jcDr7vIgdFSDB3pJakl/+ON5sOeVddHnOJBNoJTwentt3sB67ZH9VXwCP6qtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q9O1jiAW; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25e3bc751daso597108fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722973136; x=1723577936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlFNYpd0IYP6guEubr0BNxauC4m2fYvxVetxkmvQtjo=;
        b=Q9O1jiAWJB8aMhevyOROgpAZceZroKMhFPpfXWZvpJuK/+X5ps25pgDP+bjN1Oc2IO
         HZExYaG+FUDfZQ82Ct1Fxq0rDgXBOQx6EvVkTcoMckKooBO3HqPXYL0Veql/YZeAsbG8
         PIytKfoVd4PkFpMaDgntM3KSRsUZKA8iLNsZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722973136; x=1723577936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlFNYpd0IYP6guEubr0BNxauC4m2fYvxVetxkmvQtjo=;
        b=FdjC8m7fadPvIbEInr7ZTQMnUCuQIDDLS13ClKqZLBin5fILbILuptE62XiZ14hxHY
         axNhY1VuBzEQi500DOQgHMhggPVW+BoLNnoO/dOigeq7fJOx/JRq7hI/b9nJ3/Vf7Ycr
         /Nxy8e3v9/UY9KfGs8acgKRHU9A81NxiaQlY1qMdQBNXPMIdHAD6yRYKwwF5pAcVNXoE
         rYtBcF61nBELJKoQhM+BQ+ENbflnLDE4HT6xtauh2OJrl5NCVUYsfMmr31vBGnzo479d
         Rc/tFAVvHefY64OMfB/Tz2VawKDmVdrVHoC/SZ/2SYcD2aSlgnXzhYCrgKgRQDHJC787
         F8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXxKdi/STPt7fRQU8b+y9YCn0JEOIz9gjsgGQ874ZrN2jkEn5+I3x03y1eUMkYXhyTN4wP2U1YGkdEd7Sk8E1gF8fdM9c6cn6/pS7I
X-Gm-Message-State: AOJu0YxX2emWELjmVsB6XqxncqJ6EzzWSFixCwc4lC8tQSmUxJTAZF8I
	2RT+s+Qep7OFC3EcBfdWWtw8oJsHsX43xIixAVDvjMMLziSiM+u2NefrW3wgtJ66vsiBzazzGe0
	nmGwnPO1fUGzxScnJgJTkiixJZPruJ6jrVfMk
X-Google-Smtp-Source: AGHT+IGyjcl26h/1zCWitujEcTkP6HcPzv5vO0txxb0wrsN0TXPikKeKrXfOwaCZzg0wIS2eaWQXf6FImcTz1S0LRQc=
X-Received: by 2002:a05:6870:214:b0:25e:7a1:ea8f with SMTP id
 586e51a60fabf-26891ee21d2mr19369134fac.47.1722973136534; Tue, 06 Aug 2024
 12:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801170838.356177-1-jeffxu@google.com> <202408051400.C402BE97E@keescook>
In-Reply-To: <202408051400.C402BE97E@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 6 Aug 2024 12:38:45 -0700
Message-ID: <CABi2SkWTOPy3zRjh7mtuDGmZHH3kLSbJxX1WuJySh3a7Rvp3Zg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] binfmt_elf: seal address zero
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com, 
	adhemerval.zanella@linaro.org, ojeda@kernel.org, adobriyan@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:01=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Aug 01, 2024 at 05:08:32PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > In load_elf_binary as part of the execve(),  when the current
> > task=E2=80=99s personality has MMAP_PAGE_ZERO set, the kernel allocates
> > one page at address 0. According to the comment:
> >
> > /* Why this, you ask???  Well SVr4 maps page 0 as read-only,
> >     and some applications "depend" upon this behavior.
> >     Since we do not have the power to recompile these, we
> >      emulate the SVr4 behavior. Sigh. */
> >
> > At one point, Linus suggested removing this [1].
>
> For users, I didn't find much in a Debian Code Search:
> https://codesearch.debian.net/search?q=3DMMAP_PAGE_ZERO&literal=3D1&perpk=
g=3D1
>
> I see rr uses it in testing, and some utils have it as an option, so I
> think maybe just leave it supported.
>
Thanks for checking, I will add those in the V2 cover letter.

> >
> > Sealing this is probably safe, the comment doesn=E2=80=99t say
> > the app ever wanting to change the mapping to rwx. Sealing
> > also ensures that never happens.
>
> Yeah, this seems fine to me.
>
> >
> > [1] https://lore.kernel.org/lkml/CAHk-=3DwhVa=3Dnm_GW=3DNVfPHqcxDbWt4Jj=
jK1YWb0cLjO4ZSGyiDA@mail.gmail.com/
> >
> > Jeff Xu (1):
> >   binfmt_elf: mseal address zero
> >
> >  fs/binfmt_elf.c    | 4 ++++
> >  include/linux/mm.h | 4 ++++
> >  mm/mseal.c         | 2 +-
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > --
> > 2.46.0.rc1.232.g9752f9e123-goog
> >
>
> --
> Kees Cook

