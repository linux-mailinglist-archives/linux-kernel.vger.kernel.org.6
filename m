Return-Path: <linux-kernel+bounces-396355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A29BCC19
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E34F1C217EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D7D1D516E;
	Tue,  5 Nov 2024 11:46:51 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256871C07D9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807211; cv=none; b=QKCp8i31Cz164EWmXEnSkdzirtulSFE7D52jqrW0q32ChrpIB/CugLSBh7d2xgGc1GRCNfusPPF7JRakC2wbhIAFWT6jmTomsvsRg/AHXnyuKEsLuTNurXwhLktwJNqwJkDlzJA0ERCdS6jtakALWMsLyeihNTOxXx3veD62pvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807211; c=relaxed/simple;
	bh=EB6BVBEHwy4lNA8BRuQQ6n10LLY4CRUMYEHx38pj6V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GACVgI3+ASvqprlPg4b9VS22zhSy6gPG0r0ndMUBSqGE4nZd90cXwzHxWv+p1Z9eXxVyMCYSkevvwpZOUz+muImr8DlF8TmygAZ9QwdCq7HYiQDtRMy0zz6qBWWobAjSuWqrV3TkHyoIs9OeWFj9kQJq+VIPr00TFHR9RcWx6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea5f68e17aso51848017b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730807208; x=1731412008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHC7oFJtvsZgG1ZL9aZqTXm+RYI7T1aIIkhsKRXH7Hw=;
        b=QNE2uatbiXoyaF8oNAdb+n72E155e6zI0Ga/RUd4isrXM0l4IdFhqs048ijGPvUO5D
         pLgJr9KJLIVot4CqoHuUHNX5hrkabnM4D9f3BYDWSayqCqQoUGEejAwDOJ2N8hJoP5sy
         q4yqVypIIAW+ELXNa44DtHQtMNd7TyMPvuzb3D2bC/KPcGKGPgjkWJuhUoITKsHlW26E
         MuHYvgMVH6hfKwVIx4sefeg2UbByXT/zZKQ/q8nizKOj6hCen3GoZla8s8xoDPl/WbF2
         /PyJGySf/IpbjpguPlqXa14LR/gwoYxFaYkgDWa2UXffGhytujCqukUsRKb2GztOPHiz
         wm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk9Jfknj0prQvnNLJvdv9ErmX70TEC8TXJe5MMbTBVeRSghQMX5Ky8amY9AXCbM9ksVSZOKjgTIDyz7xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxuB8SCdkUTj5ztBNHFK1bFpJm5nAUIPevn3J3t8vvuGHYxnyR
	j7KYeJwxB3tx49+R+wo4fHx0cHu9CilB11ZgrbYEz3KumKhOUCzqTi87BGQJ
X-Google-Smtp-Source: AGHT+IGXHjl45el8zhtWPou5E94a4KTMZkVUfUV1ccKooBQXGOwAWz5YQR28CYPLAz/1W1+VKnLUlQ==
X-Received: by 2002:a05:690c:4b09:b0:6e3:b6c:d114 with SMTP id 00721157ae682-6e9d8ad309bmr370058797b3.38.1730807207754;
        Tue, 05 Nov 2024 03:46:47 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c459f3sm21696767b3.95.2024.11.05.03.46.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:46:47 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e9f8dec3daso41324687b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:46:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5YkSQCuUeXefA8SnOWClnocm3r5B9e1iKogvi9rKphyaYt4kUkmEM9sDz5PVGUZJnoitHXWW4UDDFo1w=@vger.kernel.org
X-Received: by 2002:a05:690c:87:b0:6ea:3313:f98c with SMTP id
 00721157ae682-6ea3313fa4emr257739277b3.32.1730807206940; Tue, 05 Nov 2024
 03:46:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113133209.1367286-1-gerg@linux-m68k.org>
In-Reply-To: <20231113133209.1367286-1-gerg@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Nov 2024 12:46:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZh6-64hfx1jgOijBEG6cTftinqf+4fZvqjJtV1hO95g@mail.gmail.com>
Message-ID: <CAMuHMdVZh6-64hfx1jgOijBEG6cTftinqf+4fZvqjJtV1hO95g@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: use kernel's generic muldi3 libgcc function
To: Greg Ungerer <gerg@linux-m68k.org>, arnd@arndb.de
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg, Arnd,

On Mon, Nov 13, 2023 at 2:32=E2=80=AFPM Greg Ungerer <gerg@linux-m68k.org> =
wrote:
> Use the kernels own generic lib/muldi3.c implementation of muldi3 for
> 68K machines. Some 68K CPUs support 64bit multiplies so move the arch
> specific umul_ppmm() macro into a header file that is included by
> lib/muldi3.c. That way it can take advantage of the single instruction
> when available.
>
> There does not appear to be any existing mechanism for the generic
> lib/muldi3.c code to pick up an external arch definition of umul_ppmm().
> Create an arch specific libgcc.h that can optionally be included by
> the system include/linux/libgcc.h to allow for this.
>
> Somewhat oddly there is also a similar definition of umul_ppmm() in
> the non-architecture code in lib/crypto/mpi/longlong.h for a wide range
> or machines. Its presence ends up complicating the include setup and
> means not being able to use something like compiler.h instead. Actually
> there is a few other defines of umul_ppmm() macros spread around in
> various architectures, but not directly usable for the m68k case.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/Kconfig                   |  8 +++
>  arch/m68k/Kconfig              |  2 +
>  arch/m68k/include/asm/libgcc.h | 20 +++++++
>  arch/m68k/lib/Makefile         |  2 +-
>  arch/m68k/lib/muldi3.c         | 97 ----------------------------------
>  include/linux/libgcc.h         |  4 ++
>  6 files changed, 35 insertions(+), 98 deletions(-)
>  create mode 100644 arch/m68k/include/asm/libgcc.h
>  delete mode 100644 arch/m68k/lib/muldi3.c

I had this in my local tree for about a year.
Is it fine to queue this in the m68k tree, or does this need a broader
coverage?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

