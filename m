Return-Path: <linux-kernel+bounces-531369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEA1A43F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBEE1665DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5462686A1;
	Tue, 25 Feb 2025 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYnegNyn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D91991BB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487384; cv=none; b=q92ETao1/d8VxR4fZNQV63qVSA1NOGbnKYsZ5VGEIeakYE1HxSfR4rdSGRV8Sb3w36rsDXOEINNCuwWPtrRWs7iXpN3WpqvKSmuW8TfgY+jwYs/HKhQ3WVWsU6w1K5ftZn+qaN57v2G6s7nT5pW8w87vH3d0fvzT9leTyzvlMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487384; c=relaxed/simple;
	bh=+AOFxSySUhot2+5onVFAKqb7Ah8dKshYKFv5iKtQECI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt5Z8H+J0uacxEprAfSasLn1y+t9G5xOlj1Iz2bDXgsMgiDYUICeCUVW2GcIn/qTLOGhq6XNT4xUvuwfJqH5OAvfHy/BdAh3c9XjB0dMoSvcQl+3aPwQi+33VFuboRqTKnof1Xf4wAEVRlO7IH8WP7p8z4nBXFKrgvrfgGahDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYnegNyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE8CC4AF0C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740487384;
	bh=+AOFxSySUhot2+5onVFAKqb7Ah8dKshYKFv5iKtQECI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jYnegNync+myT5S5yF5lXK33Y6REmDyyUsAfm7bUj6sFBye59UDV4T3GTv/SkXTMF
	 iTV9TjUVcR64NnSdM3mlecdDXcyEfpwa5x6ahr8udlukGmR6muw3+QyDYTFM5dWRq6
	 coJdtwSm0F4yzfKMAjPyUVCo3DtPNWRorkgJpc/xl5yIHLYer6kvRbadd2t7gwnc80
	 soNCcsgG2+GU8pYeTOtroszHnSvWZIj1NP9kClwgo0vdzuxSFq34pKr7ymD6YzB6jA
	 ZHCGZgptGGil3V4FmifWxmkmdhGLRr+gjxNQMKsB3T8mobLL2pO19UtRPkioKcP68V
	 PDV0y+KxPZ/0A==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1107413766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:43:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX52KEOQYqsVErvoRdlbm1rXl/JYPe5PJVGA+MAL7W6jwCDUCFXyfuImzyR93J2z+ycRqDiQ1xpzdxLzXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fbY29jy393VZSSvNI07aq6ityAVVxfqTMkLkFYcU32xGQ3ln
	y4VxVyvc81Tjey8FgkHZf/zzK8dFGNZeZhpYZLjYZ5V8LBTXG2gpABUqkC+IZY4x9PXpWWj3sHE
	nvwC1UF6dKgJd6+xJMvQK2gx9tW8=
X-Google-Smtp-Source: AGHT+IEMrY2KdpjvJanrQaPVfRJhihELXWh9ammSg2RTlD9pPhnjIZ1kfPFYyLbSnW65/PL16pZdKrTll/EawEWSFE8=
X-Received: by 2002:a17:906:3085:b0:abb:eec3:3941 with SMTP id
 a640c23a62f3a-abed1069a01mr295085366b.45.1740487382696; Tue, 25 Feb 2025
 04:43:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0301CBCF511C5594+20250224184555.1562943-1-wangyuli@uniontech.com>
In-Reply-To: <0301CBCF511C5594+20250224184555.1562943-1-wangyuli@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 25 Feb 2025 20:42:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5RTVwkHKkHx19xA5HuMgret10jSYuCCgOW5uaF4Z_R5Q@mail.gmail.com>
X-Gm-Features: AWEUYZl1_7myyOFr0-ugqOLWMALNcT19pl4Vw9telQeVK6-G4V5K5dbq9wDq7g8
Message-ID: <CAAhV-H5RTVwkHKkHx19xA5HuMgret10jSYuCCgOW5uaF4Z_R5Q@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: acpi: Eliminate superfluous get_numa_distances_cnt()
To: WangYuli <wangyuli@uniontech.com>
Cc: kernel@xen0n.name, maobibo@loongson.cn, guanwentao@uniontech.com, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, chenlinxuan@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Feb 25, 2025 at 2:48=E2=80=AFAM WangYuli <wangyuli@uniontech.com> w=
rote:
>
> In LoongArch, get_numa_distances_cnt() was not in use, resulting in
> a compiler warning.
>
> Fix follow errors with clang-18 when W=3D1e:
>
> arch/loongarch/kernel/acpi.c:259:28: error: unused function 'get_numa_dis=
tances_cnt' [-Werror,-Wunused-function]
>   259 | static inline unsigned int get_numa_distances_cnt(struct acpi_tab=
le_slit *slit)
>       |                            ^~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> Link: https://lore.kernel.org/all/Z7bHPVUH4lAezk0E@kernel.org/
> Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
> ---
> Changelog:
>  *v1->v2: Drop the relocation and one more useless variable.
> ---
>  arch/loongarch/kernel/acpi.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index ee471a80763e..193f81920074 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -249,18 +249,6 @@ static __init int setup_node(int pxm)
>         return acpi_map_pxm_to_node(pxm);
>  }
>
> -/*
> - * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
> - * I/O localities since SRAT does not list them.  I/O localities are
> - * not supported at this point.
> - */
> -unsigned int numa_distance_cnt;
> -
> -static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit=
 *slit)
> -{
> -       return slit->locality_count;
> -}
> -
>  void __init numa_set_distance(int from, int to, int distance)
>  {
>         if ((u8)distance !=3D distance || (from =3D=3D to && distance !=
=3D LOCAL_DISTANCE)) {
> --
> 2.47.2
>

