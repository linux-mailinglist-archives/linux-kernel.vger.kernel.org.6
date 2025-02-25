Return-Path: <linux-kernel+bounces-531368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29386A43F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5613AB653
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3326869F;
	Tue, 25 Feb 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3x5m+ce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4B3A1DB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487344; cv=none; b=fYWulfN3Kx78TmoVzZQx8waSlyzDMLEdm2+MOPiLKHJNP+YWUFeVzBIOazIZG65KeN7W31nSd9Osv9FvQaN9XaF9tdQK/Q4IPFKxfYV/iQgTdBJFBzQIz2+2ndQiMkq7pB4HqL4P5F5gq/oYCMadpgJWE0Bw/RgY06W3A3U/6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487344; c=relaxed/simple;
	bh=RG5zQ3Orfi9kNoYpBR8awwCkHpjOu+LogwFQlJMRD1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knhDr7YHf9mwXvdR+UAsoBQx3R12RyROKNKC8efolWz9g6uvOfmnGCSeq3XFSWcm7TaWvS6eh9erafohAy5QKM0gT6fQjXClmalmTNmaijWEkfc9PwBWEBlEZiGHFxdusciFyhob2fXz95WxfCB9BqB4MzaLx8i8uTVxbsea8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3x5m+ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C05C4CEEA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740487343;
	bh=RG5zQ3Orfi9kNoYpBR8awwCkHpjOu+LogwFQlJMRD1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i3x5m+ceCgM+JGyhuH3ga5mgo61BVP+RTkfvh1n8Pc+qWzg6fF9xfRoxWvmjW9mtY
	 IvATULkfctLZ+1Rc9s9TN7Rl/Q0obZ9LIRnEeyfvVEsSGDTB0CYIHQyRblMY+Wm092
	 vP7WRwwf0Jiw0F1wHL238EO/ud/WTF7IS9DjEq4dFrqIWqwdxkKFwk2ep5aXXaA3bp
	 hB6rs5G/JD7RBltVGQW7EDxXLp2gaUDqayhlLtXWTK5dOZ34edWYg5iJMg+vSNJCOL
	 AWtQDxuHCIV/Nz3dbuDx+i5QSCcdozRXTTs2rt9SUgKmbxel6XP4IxlzlgiBlpjpJ5
	 DGvMvHj0iiJhA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso854027766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:42:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcqZpLFdxCnhtTf76HEXnqaMSF0xdD4k+aGutmIZCuqkGW0sx1VpoLiQWpZF/S5IAnSLv95QB60opDhf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5l95oCzMUFm83yp07fGzV8hKSrMxuCTg7C9s5mKOSYLq8S3oj
	gI3e8Wzte1cIsj/z3hEBnsvft9arVI/NOoR5BIrbBv1+301OEU1PY11OCgeOdiE7ApfdNrYNPaj
	yIlTZrB8gzKvXfw5haiwT0TWqIDg=
X-Google-Smtp-Source: AGHT+IFlDNKrDvjPWTrqIgkrsabfuo0vqvfqq0fvScYNvBKd2vxsXrMgleZ6SWqt96ebVWYj5ZISikFHPuCie8h8lgM=
X-Received: by 2002:a17:907:97ce:b0:abb:b209:aba7 with SMTP id
 a640c23a62f3a-abc09abecf4mr1509608866b.26.1740487342408; Tue, 25 Feb 2025
 04:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225092420.1599954-1-maobibo@loongson.cn>
In-Reply-To: <20250225092420.1599954-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 25 Feb 2025 20:42:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Q8RTkmN1dbgwz01b7GgKd176cx-6uO7pitr7t7LgQww@mail.gmail.com>
X-Gm-Features: AWEUYZn-hy6r80xRyM7xpc1OiwaQMsj-1BDglEge4Gd3f7ENAH3B_Fipy7g2y_Y
Message-ID: <CAAhV-H4Q8RTkmN1dbgwz01b7GgKd176cx-6uO7pitr7t7LgQww@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Select HAVE_VIRT_CPU_ACCOUNTING_GEN always
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Feb 25, 2025 at 5:24=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Option HAVE_VIRT_CPU_ACCOUNTING_GEN is selected by default for 64bit
> system in kconfig file arch/Kconfig. There is another selection in file
> arch/loongarch/Kconfig if SMP is not selected, it brings out some
> misunderstanding for non-SMP case. Here always select option
> HAVE_VIRT_CPU_ACCOUNTING_GEN for future possible 32bit system.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>   1. Select HAVE_VIRT_CPU_ACCOUNTING_GEN always for possible 32bit system=
.
> ---
>  arch/loongarch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 2b8bd27a852f..8d0885b165a2 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -175,7 +175,7 @@ config LOONGARCH
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
>         select HAVE_TIF_NOHZ
> -       select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
> +       select HAVE_VIRT_CPU_ACCOUNTING_GEN
>         select IRQ_FORCED_THREADING
>         select IRQ_LOONGARCH_CPU
>         select LOCK_MM_AND_FIND_VMA
>
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> --
> 2.39.3
>

