Return-Path: <linux-kernel+bounces-396312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FAB9BCB5E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395A11F23D35
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56201D359F;
	Tue,  5 Nov 2024 11:12:59 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38141D358B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805179; cv=none; b=mN9UAhFvVko2hfKBFBlKzbeJPARN1vcE9LRHUbfk8mX1bK9azVdkVw33LyA14jTGxUzXeK1YT8fztcxyF6yNFaNWoxF402myauBaYOKOrQo1DJ0hXEDkDFIpOElqpFNv5Z3wD12xczeIrobAlEUvGd7L3+wsdBvJbo9YVx3qAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805179; c=relaxed/simple;
	bh=joG4P4jYyblotj9+AuYdZ9+B473TN45NIpAJQxIZkWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nleYV7IuOMFzEEyWVo8kzDdrwlH0xZUdf2tJsxrRxZ9PCUWEvJiwqLT8QIjTcxwGlzKCJkcIVaQ0ngB9DQ0tBAvCP/D19n6Y3uxBknujojjTaIK0wrvU2MxARLcrwUiwR7nzxpNPaz9iJyM+mO11u4bF7R8Sch3WGQ5yoizlQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so4639361276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805175; x=1731409975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7u7cesrN6fwiNOOUz+RnFnfBh4Cv9POsXdrOPXkwZn8=;
        b=lE4r3wgnI6h5LupQfjcgDP3DQHLRRqNYv0H8OC0A3KBt2XZqFQQtqxhrlVjrz1HMFu
         MLFJj14Qp03cMcMGZuspeTIg2f4pxpI8fglTH7k1CTKCHgHNB5jp2OCytJjVM6v3E7OJ
         DypcNow9LNBjnD30Hg4HBEyvTvE3wf5pD0DAjzU1IPoqJeR3aSxAVdRypilOvV1v8NDm
         KljwhY7IfbZhF1QISiVRD7K4awvBjPLrMs3mYUwLXOPsWX0xv4XeHhQSu68qyZATkyRN
         1Q/C0AMofUuIe2U5roj5koWAW+HvPXbs8QO7vfgXHf0ozQw/yvxMAOX9tNxtywLqL+Mg
         2wow==
X-Forwarded-Encrypted: i=1; AJvYcCWOKn55fPyHyNmHhVeuy1D7gyTQoZI3ZfUYsKhzDuUExtMCZEw6NnFqVG9ObDJnRs23MYi5ZeT5Lco8txU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuCGOYwCEwQBc0slrtu9ZPcezhypLZxQxP0okdJaq/rHGyD9b
	TynhTWnlWTu2oh3STA6CyaefTFIqIJutu8u5ZBahZ7twsozTf/AttUrk8E9t
X-Google-Smtp-Source: AGHT+IE7ni60EvUuWoD14SwT84JSqmRz0l9hXABfQCRMLkKr9C2raakWxNwtK/Ghab+TSCUdVdTayg==
X-Received: by 2002:a81:fa12:0:b0:6ea:47cb:c886 with SMTP id 00721157ae682-6ea52520b99mr150677137b3.31.1730805175159;
        Tue, 05 Nov 2024 03:12:55 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea7c26d7dcsm14213877b3.54.2024.11.05.03.12.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:12:54 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea85f7f445so25171047b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:12:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUn2j8GnMEvkcjkupSHSAlN/hG0MGlDRcVR354XfndZkxVvFXq31ud/v41Aa8P1oKDSk2JB1KbmmQpdWo=@vger.kernel.org
X-Received: by 2002:a05:690c:9a03:b0:6e2:985:f4df with SMTP id
 00721157ae682-6ea52546b5cmr206450377b3.44.1730805173824; Tue, 05 Nov 2024
 03:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030195638.22542-1-arnd@kernel.org>
In-Reply-To: <20241030195638.22542-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Nov 2024 12:12:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXivFLfonRACeQC-VXQDg7Bnj+QYuW+8UH+ht8Bij=g_Q@mail.gmail.com>
Message-ID: <CAMuHMdXivFLfonRACeQC-VXQDg7Bnj+QYuW+8UH+ht8Bij=g_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] [v3] m68k: move sun3 into a top-level platform option
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:56=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> From: Arnd Bergmann <arnd@arndb.de>
>
> It is possible to select an m68k MMU build but not actually
> enable any of the three MMU options, which then results in a
> build failure:
>
>  arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclare=
d here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
>
> Change the Kconfig selection to ensure that exactly one of the
> three options is always enabled whenever an MMU-enabled kernel
> is built, but moving CONFIG_SUN3 into a top-level option next
> to M68KCLASSIC and COLDFIRE.
>
> All defconfig files should keep working without changes,
> but alldefconfig now builds support for the classic MMU.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408032138.P7sBvIns-lkp@i=
ntel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3:
>  - fix coldfire+mmu build failure, by taking out the m68020 default

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.13.

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

