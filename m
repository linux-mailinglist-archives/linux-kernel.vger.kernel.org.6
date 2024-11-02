Return-Path: <linux-kernel+bounces-393196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125419B9D87
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805E3B215E2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06901552E0;
	Sat,  2 Nov 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZcnIknN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA1147C91
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730530507; cv=none; b=e+CTEHs1O9ttdSL0N8hmNjAanJ+IlJwrus96kDwJWFTQi5J1DTANPcnE45msOIomwS/L2SxWtmtnQFXNIG0IzkdZVwRk+rMOAK1LWZaVLfWHdWbqkTvmTuoYIZqcsNWx4ukjOWeNiHLkGEjU8s4846fbW2h7vmzQMvP7M14mvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730530507; c=relaxed/simple;
	bh=0I1DQy20ZsN3jGPIaSzE5ehs0uxuG2KmKk+7DTZIQU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6ZEdYyopt7RBJzj/nwII+1AkWtaMUfG+n20/hu3VDGZ91ow479qHYZ+UU8HlBcs/UbgygbpUo74qa1gA+h8tz9zbvX5yyBVZGxxNYMBVo6/Zt94Bv6qg38RLVIQU+FDHZ4mi3gtV9z8s29sBnDAHvXcjDI+yE/SwRndnbi7kws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZcnIknN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95BCC4CED6
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 06:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730530506;
	bh=0I1DQy20ZsN3jGPIaSzE5ehs0uxuG2KmKk+7DTZIQU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bZcnIknNjYm1oW8w4JW6/N3KH6J+NOvqzBsPCuq8anT0MuUPr4dADMsFsJf+v0tqo
	 gQv+P7UIwRpRly9K/JV6K5XzVy8HyzHYARPcYV+KdZXl0JZyzYsR0BOmnsa020Uf9o
	 /ZWWaP914vJopyKh/xAUmYv/QU/mMkmnZSwNW2ZfKs3UHt8v6YP3/qxpP7+c24MnbS
	 PLfRYjnlNwHiCfAHjAGLMor+rn42okyJ0LSPUDhK0GNwhAW+2PclN64BvBKrW4uQ5j
	 R22IqDwCtnouiq45L8y9skTORYOIDlNfFu5y+RzV9NHyJ10EWspqmTPYQZR9uZInxe
	 ZKY4hzgS/3DNA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso387393366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 23:55:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViQVBhzh0AtV313P0ZgiKghFfU85vRTUTqu3AfzPNhHaxWxCmwAIXxCHS8HATnMSBDv1v8Os4jh5uhyYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7qlWQuX9PL0rDbFAh2t6kDT7hgAZ/uElyF0TxhcdhIqrx2nAn
	iRRnKl8Su8AMJQW0PIFSvrVF8Ogxyk23ykHI0GmK9ixJqqpICku+ADDie7qWP8DpUfnaa5H7GuF
	XuF4XJq+ZQiEPOFV2zvBIB1arGnk=
X-Google-Smtp-Source: AGHT+IF+kxzrhOPRHXeAvjclibJ4Q6vgFesowad96wUbVa9iR0NfGPakD2U8YVzQWD6mp5KPhRyxe1Hug/ykzu3i0P8=
X-Received: by 2002:a17:906:f90d:b0:a9e:733f:eaf6 with SMTP id
 a640c23a62f3a-a9e733fffd4mr321831566b.6.1730530505312; Fri, 01 Nov 2024
 23:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1BC681DB785E0181+20241102054042.74847-1-wangyuli@uniontech.com>
In-Reply-To: <1BC681DB785E0181+20241102054042.74847-1-wangyuli@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 2 Nov 2024 14:54:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4cW3ZhxHULF7BK4j3p2XWMMSeQCQRWV1c-=1=uSY_tKw@mail.gmail.com>
Message-ID: <CAAhV-H4cW3ZhxHULF7BK4j3p2XWMMSeQCQRWV1c-=1=uSY_tKw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: mm/vma: define a default value for VM_DATA_DEFAULT_FLAGS
To: WangYuli <wangyuli@uniontech.com>
Cc: kernel@xen0n.name, tglx@linutronix.de, max.kellermann@ionos.com, 
	arnd@arndb.de, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	guanwentao@uniontech.com, jiaxun.yang@flygoat.com, zhanjun@uniontech.com, 
	anshuman.khandual@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	geert@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued, thanks.

Huacai

On Sat, Nov 2, 2024 at 1:42=E2=80=AFPM WangYuli <wangyuli@uniontech.com> wr=
ote:
>
> Commit c62da0c35d58 ("mm/vma: define a default value for
> VM_DATA_DEFAULT_FLAGS") has unified default values of
> VM_DATA_DEFAULT_FLAGS across different platforms.
>
> Apply the same consistency to LoongArch.
>
> Suggested-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  arch/loongarch/include/asm/page.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/a=
sm/page.h
> index e85df33f11c7..8f21567a3188 100644
> --- a/arch/loongarch/include/asm/page.h
> +++ b/arch/loongarch/include/asm/page.h
> @@ -113,10 +113,7 @@ struct page *tlb_virt_to_page(unsigned long kaddr);
>  extern int __virt_addr_valid(volatile void *kaddr);
>  #define virt_addr_valid(kaddr) __virt_addr_valid((volatile void *)(kaddr=
))
>
> -#define VM_DATA_DEFAULT_FLAGS \
> -       (VM_READ | VM_WRITE | \
> -        ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
> -        VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> +#define VM_DATA_DEFAULT_FLAGS  VM_DATA_FLAGS_TSK_EXEC
>
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>
> --
> 2.45.2
>

