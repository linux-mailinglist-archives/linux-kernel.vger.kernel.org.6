Return-Path: <linux-kernel+bounces-528172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739CEA41484
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 05:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497A016E0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3F61AAA1D;
	Mon, 24 Feb 2025 04:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u43xayBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684B2F3B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372548; cv=none; b=dI/qZR2LB46QyjSNXwFiIOiH7z6KKq29py5yUP9X/akvwMca0Is1fVCMdI26+d8qM9/8h1iw+GXim0o6ih0+V3o9POzS6DQ9GzMM2391IVZ4QqQn18Mp1vwHl+Wan+jPt67Km+nCjyMTdHKeawedRWe2anRf6537xHCO90NuF4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372548; c=relaxed/simple;
	bh=+tSJ/CV4ag5BPKgIT4cToWUp7lkZ5lgsFJpGIxZN57M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVKvGDK1aiyBR8u6BxbwgdEptJCzlFyhZ0YKHulWRpVb0dcipUJNnSuUlqJ6Kry+VnWikYNKcuqi/FOuRaRBTecMgjqXWMbRzseic5RLrs7qbGjLBXM0v0CDlW8kF4kUMX0xv+SpHgnrK8mZCnvXq4TC9Sq+PLdlns6rC5RLw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u43xayBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7999EC4CEE8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740372547;
	bh=+tSJ/CV4ag5BPKgIT4cToWUp7lkZ5lgsFJpGIxZN57M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u43xayBRuDT1amaEhIlS+UCRwX8Mam6i+p5yVxHpcFuutIHvkMqeZ7lTbM6Z6Y5D7
	 D2L5lSGNzHwiYGAP/i9yUyERel+AheT0lbqq6QgUZPC5G9/oUgLUCHqiw4Q9Y1iB/N
	 bR+oWtDZGyCMFDb4xv49jx0RLLKQxUZUXhmJLR6QL5vtHNMJWKRduGVHU/ALeEK23l
	 Bb3cofOCUx3ljHx0Qt2WyWY3E5QE2wBsnr/mf6Zwo+ShJCiRKTzcTWi1DLhc355I8O
	 X/WQScK41usyfP+ai1Ch4TeKZ94aty2mp9rmk/ZqTL9D+ZN2EmGZ3VyUyhs7HCevdF
	 Yn0ElJ4srIHIQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so778918666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 20:49:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXO76uOhpVy5TrY+gDsUAMnCK9vtrlzboOwz/OK8vtAcnj75rcCwtZfQJLo3ztmLsmPD1gbF5+UsNkMm0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZxZd8QG/GQIh0cc2+9jz6PffDZLUPVN9wQgq7jldnznA7uLy
	xec0p7a+zRTQCbqH3ZgvPDpF6cYSRNg3utjwtl3ZWg5jWvW/+WgjIqkZly4X2DuONQkqVM5EQGQ
	v/K/BbQ9Cszbpla4y7R9HQlxMWhg=
X-Google-Smtp-Source: AGHT+IEKW5vIXjTzOHrompLOAPwklgOd0a+ZAbqn71KeUOAndWapGBnmaG5irOdKpG3m5J7DZWq2c8pb6BBiBzlLQ8U=
X-Received: by 2002:a17:906:c0c:b0:abc:ad5:eee1 with SMTP id
 a640c23a62f3a-abc0ad5f0a6mr1104615966b.3.1740372545953; Sun, 23 Feb 2025
 20:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114132856.19463-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250114132856.19463-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 24 Feb 2025 12:48:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4giTorYbo4uL_KNL1MmHWfWKX8EnhKdC_Yz0_sX17PvA@mail.gmail.com>
X-Gm-Features: AWEUYZmN-OTr9hSy8TtD6Pr3OSYtzFaOXORrLZ6CEn7dpUO4IxI5WYWdY8z04ys
Message-ID: <CAAhV-H4giTorYbo4uL_KNL1MmHWfWKX8EnhKdC_Yz0_sX17PvA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] drm/amd/display: Stop control flow if the divisior
 is zero
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Nathan Chancellor <nathan@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 9:29=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> As far as I can tell, with the current existing macro definitions, there
> is no better way to do the minimal and proper changes to stop the control
> flow if the divisior is zero.
>
> In order to keep the current ability for the aim of debugging and avoid
> printing the warning message twice, it is better to only use ASSERT_BUG()
> and SPL_ASSERT_BUG() directly after doing the following two steps:
>
> (1) Add ASSERT_BUG() macro definition
> (2) Add SPL_ASSERT_BUG() macro definition
>
> This version is based on 6.13-rc7, tested on x86 and LoongArch.
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> Tiezhu Yang (3):
>   drm/amd/display: Add ASSERT_BUG() macro definition
>   drm/amd/display: Add SPL_ASSERT_BUG() macro definition
>   drm/amd/display: Harden callers of division functions
>
>  drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c  |  2 +-
>  drivers/gpu/drm/amd/display/dc/os_types.h           |  7 +++++++
>  drivers/gpu/drm/amd/display/dc/spl/spl_debug.h      | 11 +++++++++++
>  drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c |  2 +-
>  4 files changed, 20 insertions(+), 2 deletions(-)
>
> --
> 2.42.0
>
>

