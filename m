Return-Path: <linux-kernel+bounces-224358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D000491214C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850D128A34F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910FC16F8EB;
	Fri, 21 Jun 2024 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz36Mecs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932A82D66
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963581; cv=none; b=cdR0HU1mtBEdPD5zmumvWtpgCl2+zxL73nvC9xU3JBdungeiIzAknkGLzgg33WK1wqzMtOXFwytgqfd2NIhnSqLSX+gW91+EG+u4/y+275I3bOgYjgOf69hZz5JhuKq+QcAfBPYbCRogwXHdMTUh+MhyRYGXIEqyuruFNLSt8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963581; c=relaxed/simple;
	bh=i5bfEeplWnyWogs/5yMTdMhW3dUlLLlGYGg7SlEI0oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkMDiXNxKoFGl7/agmWTCpxibvgDKXOYE9QOZBxufWRSWwBUVbKoV+LrvzOdFrUHMOLjxIuAAUVEH1lormfyarCKIwArlpkmc485Sb5kDB5dCnNCRv5cvCRb4a7TJaixEmHOM1pWN6VbZXa15y65S5BJ4p+nx69EMjcsCVk46Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz36Mecs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4BAC4AF09
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718963581;
	bh=i5bfEeplWnyWogs/5yMTdMhW3dUlLLlGYGg7SlEI0oU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tz36MecswDHgsv+lPB1rkILFu9WMmxBQmISr/2P3hk/1XeoiibIXvaDT8pUiQ7IZA
	 xI7e1avmEjbexZDCNJ/6Mcww9re/HOhuDkDs/IBks5bDwkiN40J3boJ2uShhRIm6lC
	 FyD5+K9x9jnrRuwpd2xkXxCu/Owa67WaBKzMYlq7i/9BlnSvzkfs7Q/5vtRzIGMvTU
	 ynydXQ6s/4j/GiCbrFXYiHyTd4BCR7XUeRoOXQ6CSo6vjcmptthSfvHziDqTIttvHE
	 2a15VCQHlIYldtgg3p03je5/HCX/kENcu6E1GmXVyZfaJ2QRB6g7eUL/5OuQ1Z4X4E
	 iYJl6g0PkyDQA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c94cf4c9bso2300003e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:53:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9vE6/I8x1xbmU04tbVug6+aaW3UzuM+7XNvJbBEn3xaTj3+dc3t95p5pQoyCjgqWL47ZYZt84NBKy5HKF3ZXhKMfM1Gact2vYySAn
X-Gm-Message-State: AOJu0YwPvELfMjd84Y1viUNpkXAEbYo35AQeMWw1iccL1UgJOz6rGg86
	A20WVDQV8m336jD3ualkz+s0N6pQHBQNMF1V2M+bLrifKeCXA1pcl70cX3iMlvUSy6551Gfw31s
	cfBkvIcmQ/ooGlYSZ+m5diqMWl4E=
X-Google-Smtp-Source: AGHT+IEoBNnkImkbHiBM6XSY+i0yKhYlNhhX/wuINaWl9Idb2f8QzczAmnsMxc1VAsOwbaXZdDyAjrAk3OPqfJYRHLI=
X-Received: by 2002:a05:6512:b20:b0:52c:842b:c276 with SMTP id
 2adb3069b0e04-52ccaa53e9dmr7320353e87.53.1718963579690; Fri, 21 Jun 2024
 02:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621092809.162-1-yuzenghui@huawei.com>
In-Reply-To: <20240621092809.162-1-yuzenghui@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Jun 2024 11:52:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEH0ohn57DUrCu6S-AJW=B9CyrpMwyabpjBpD9tD4VV=A@mail.gmail.com>
Message-ID: <CAMj1kXEH0ohn57DUrCu6S-AJW=B9CyrpMwyabpjBpD9tD4VV=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: Clear the initial ID map correctly before remapping
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, wanghaibin.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 11:28, Zenghui Yu <yuzenghui@huawei.com> wrote:
>
> In the attempt to clear and recreate the initial ID map for LPA2, we
> wrongly use 'start - end' as the map size and make the memset() almost a
> nop.
>
> Fix it by passing the correct map size.
>
> Fixes: 9684ec186f8f ("arm64: Enable LPA2 at boot if supported by the system")
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>
> Found by code inspection (don't have the appropriate HW to test it).
>

Good catch!

Even though memset() takes an unsigned size_t, the zeroing path in
arm64's memset.S does a signed compare on the provided size, and will
zero at most 63 bytes if the size has the sign bit set. So in the end,
it does not clear anything. Note that in this particular case, that
doesn't actually matter - the memory is reused immediately to create
another copy of the ID map, and any unused regions containing garbage
will just be ignored.

Nonetheless,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>




>  arch/arm64/kernel/pi/map_kernel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
> index 5fa08e13e17e..f374a3e5a5fe 100644
> --- a/arch/arm64/kernel/pi/map_kernel.c
> +++ b/arch/arm64/kernel/pi/map_kernel.c
> @@ -173,7 +173,7 @@ static void __init remap_idmap_for_lpa2(void)
>          * Don't bother with the FDT, we no longer need it after this.
>          */
>         memset(init_idmap_pg_dir, 0,
> -              (u64)init_idmap_pg_dir - (u64)init_idmap_pg_end);
> +              (u64)init_idmap_pg_end - (u64)init_idmap_pg_dir);
>
>         create_init_idmap(init_idmap_pg_dir, mask);
>         dsb(ishst);
> --
> 2.33.0
>

