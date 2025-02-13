Return-Path: <linux-kernel+bounces-513921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4F3A35046
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8FC16C3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228B3266B5A;
	Thu, 13 Feb 2025 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaMq2gxc"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D42661A9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481030; cv=none; b=EyIkIB2z7KAd1IZjfuaJV/aibLgxIThxXPnaJDw5jA/x2VCxITPWFuxyrYKYvWZh6vXGkZZreyJJFqieRLn3CNyauJ43D4gn+Mh8qUCFUHRx5YKeNhCSpcxgxg5NlEC4gn7dBc3XEK0Gtmhct9BXxGLWvOUDfGQG+V0NlniJrDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481030; c=relaxed/simple;
	bh=fbPB2g7+Pf/OZk+WU7lLUYgJUck4kov9uZUxiWM9e4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYTow6qQzv50Mn0vKtyUgMoV3zK+SivnwW9jVGoplOFO3bF423NYFIvyXQFCoe9Q+bs9ko/llX6k9A7BQi/9S7Fb/05ZYohET4NaeGHiZEMxrvxOtmaho1Fijd5V4fCPlHsVo/UDI1p8ATSA6LaOlK0EVVI6rxgcNPYm02y3t5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaMq2gxc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ded4a3bf0bso2637a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739481027; x=1740085827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3EIJlcz7W21awhaRwqJUO1L0hARhWCWmvV/tV0cCAM=;
        b=jaMq2gxchekUWazxN/Y20UmXQQkw7T9qb7u7X0OWj1ohb015bY6GMgiiE6tnWsp/Rx
         H7ZtC2ECyJl77yAfZdmON437CqPQ80XgzEDVBKQv3eY1b25lxpNrz6dOM1vfV/Pcopn0
         S4eo8lyafJDgBf6sA8tybbzPzvZy3VFX7b6G5E0gbiQMFjpm9bY7WnktfN3zNF+X8SsY
         sx5bOvo4wRBygI9ofW0rZPbeBew4yaU36M7bQPRiTadujI5k06ZczmHPzkRy60Dir+mS
         HKjt/Ig/40pdxu4ZeHxoDKXgTxJAgdKU4wg4122A0vcEZdUPwn5WRaLOq+yN6cpJwxaC
         Sfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739481027; x=1740085827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3EIJlcz7W21awhaRwqJUO1L0hARhWCWmvV/tV0cCAM=;
        b=ZIu1rMNo7cuWYZmikN8Erm6sEj2o6PX7z+E7/Tw/Eqb8AQFJgMdjCOFVS5sF68XTBY
         oZITdg6YzHGuZlhYMHHIHQEL4PlRdql0FA8gW1gfym5nX2FL/3nydmeV2We1DRk5G3kj
         UxMBCh+0Hdnb+u2vvnR49ZZLb8rpvg6VuKcNo97fpNbcrOQRegROBN67E/07dtm4Yv5S
         hIP+5dShPS4zItW2SaYT6hQru8KQxRahlO/695tHvpozxRX9jWE0oTkN0jpd5480MAGD
         JH5Xvh/Kx4Ssc0/wp/rBfk4RxMgMLnwXJ36VpVppKo4pDsl6IHWlbzbH3kUiMZ7MUfJF
         y/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWrDOnA0TB9svVs84vJ/dZYAzVFtdvVbGi5JwdKd2YLqBjtSLNLBJhdsjwxO9tyO6m0S9N6mxIv7O0bgwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HjEHzCO9aBJ7QG9Yx7OBrVE5S4Pvxa4E4Yf1OBbUo5pjxdNf
	OPX8rZWkRhWvgPgZ7b3HjwtfilomhCUwaNRDXWIuyjwD4433NoGzj4okfg0h8jP/PBDV/i5ZeZ0
	ULb25mEYaPDjSmzi068YjfpGmZGv/nuA/e/fQ
X-Gm-Gg: ASbGncv86Tty+43TnOqM5ySxI9pPIEVQZ8G0MWTxcK2PpzwJL/8jJZxMM9ur4SoABy8
	jhe4r0WUDm6Wq7gQjQkebah36FL9gAEjzl2JakATIazAz6Zre/nb1/TaLpPBIYHzsahnciA==
X-Google-Smtp-Source: AGHT+IE4EkwbKfc//9+1MZxgEsl4MWNzDPz8faVVQlldBTaEv0zhTQ1aUl8MsNRTyPEjtzoxXm+2TMxNKGca2MElpoE=
X-Received: by 2002:aa7:d693:0:b0:5de:c2ed:768f with SMTP id
 4fb4d7f45d1cf-5dedc9d3976mr22730a12.2.1739481026780; Thu, 13 Feb 2025
 13:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202502120752.U3fOKScQ-lkp@intel.com> <20250212005617.GA1701202@google.com>
In-Reply-To: <20250212005617.GA1701202@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 13 Feb 2025 13:09:49 -0800
X-Gm-Features: AWEUYZliotNteXwj_bjDaPg1_ob8hdfyT5B8Vymq6VI9KK7vl8yMk6AcuNhrdfE
Message-ID: <CABCJKufs3XXXGfNNocvtLfwh_6W8LLo7JR+SWMn2-MTXe3RMmQ@mail.gmail.com>
Subject: Re: error: gendwarfksyms: process_module: dwarf_get_units failed: no
 debugging information?
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 4:56=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> On Wed, Feb 12, 2025 at 07:55:45AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
> > commit: 9c3681f9b9fd12cdbc4a542df599f1837512f3d5 kbuild: Add gendwarfks=
yms as an alternative to genksyms
> > date:   5 weeks ago
> > config: s390-randconfig-002-20250212 (https://download.01.org/0day-ci/a=
rchive/20250212/202502120752.U3fOKScQ-lkp@intel.com/config)
> > compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 60=
09708b4367171ccdbf4b5905cb6a803753fe18)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250212/202502120752.U3fOKScQ-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202502120752.U3fOKScQ-l=
kp@intel.com/
> >
> > All error/warnings (new ones prefixed by >>):
> >
> > >> error: gendwarfksyms: process_module: dwarf_get_units failed: no deb=
ugging information?
> > --
> >    In file included from <stdin>:3:
> >    In file included from arch/s390/include/asm/asm-prototypes.h:4:
> > >> include/linux/kvm_host.h:1908:24: warning: field 'desc' with variabl=
e sized type 'struct kvm_stats_desc' not at the end of a struct or class is=
 a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> >     1908 |         struct kvm_stats_desc desc;
> >          |                               ^
> >    1 warning generated.
> > >> error: gendwarfksyms: process_module: dwarf_get_units failed: no deb=
ugging information?
>
> The issue appears to be that the files in arch/s390/purgatory are
> always built without debugging information, even though they include
> code that uses EXPORT_SYMBOL.
>
> I suspect the correct solution here is to ignore the object files in
> this directory when calculating modversions. The quick patch below
> fixes the build issue for me. Masahiro, does this look reasonable to
> you?

Ugh, we should just set __DISABLE_EXPORTS for all the object files,
not only sha256.o. I'll send a patch.

Sami

