Return-Path: <linux-kernel+bounces-353613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD599304C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9533F1F2473E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792651D6DB9;
	Mon,  7 Oct 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5pFAtIJ"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F816EEC9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313253; cv=none; b=Om/LF5WxrRD1hcIxIeBnvNAaa2HQwMGbeGKqwUlCIQqqS4nZfrHisYe+ZOsfFnwgz4CXVoxCKeGAfNpKpFHs0n9BnCQGD1JsqjFZXzg0zEN4l5aE3BFHvIF0BY/1xajLQfWg7CFs+FgSj9VoZqefbmdQanJVjWEdfsO8uF8xCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313253; c=relaxed/simple;
	bh=eeLGTaY8KqxzkNo9oqB+n+UXnmZmzTM0bn/5+C2T2hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4M1jPDa3b3/wR4ITa3O8t9WUP5CHsaERayjvMwzoKTmLoR8dGwKX35NFHbipXYyM2ghhjF42xJBc4Nhzi4US4K5wEsG5hwfuuSLFZIusIW8cGsjdia8BzwtXZdHaONG16UMgrbY0WrdVftDO3UAVJb+VtX1MHUxfbgrLnrOIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I5pFAtIJ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-287ce8c289aso292979fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728313251; x=1728918051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc57RBPlFJ6sr22T7uR9ml2TEcMyvPjZh/UA86D9Fkw=;
        b=I5pFAtIJsbZJR92ZF9Ugr8NxMk/M0WfSipG3o8ff8YpoQ4GYwpQZzWa5U2Icp3bDtv
         iGGImHsxmCaNUR8TzgnDe5cQVeujAGR5TZmeT+5kMZI9tVmbAo6OQbFBQAB8Le/6Unow
         8y2gqSdDRRaGxLmaNHY5W/aE3qcEN/lLHMRUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313251; x=1728918051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc57RBPlFJ6sr22T7uR9ml2TEcMyvPjZh/UA86D9Fkw=;
        b=HyuQ30b4DhCYiZR2GOnuoa/xksjcgGcEVgXtBN7e/SBUdfVpDM0Z5uOAqIRPhNL7KH
         Wyrf+FN24IdcnHxldT2s77mbV1Pt3/eu4aCc/PAuBHAepT7UND0YV2QugHr7aM+nE5n5
         VR0O/zmbBomPobOaXLFI2A2/k2w4Gr4C6Gpxw5hItAiUasfywKceMnneCWIcG4nN9ano
         zqGBzLEb7Oi04lm5A4kSK0yg2zy4URL7Z+fxaWtVNAdppw/fDxGU6QqoBf0AxeraP0Hv
         dfLGATh8ImcFlFQBwJ7RnN8g3NbSUD3nf60p8N9lTUdloxs/HpHrQLayclWMo3jmi6zY
         Tdpw==
X-Forwarded-Encrypted: i=1; AJvYcCXSjWv2bAOstYy+upbH+hvIYq6+0t3ys8w06JVwBB3WDFjxWdx63Bpnk/fyN+YpVPlthjVjrRfLQiAZz7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Bm2EaTtWtTynmMWD21vEDiQmeHXoHEsb3keAP3kc/4LKzGpo
	aN/1XYwmSEembjgZfVuviYmKps0WMDKxO1XIEvwrWL3Ftp2JaiVZ6u4p9qr//k5xxJIfuBGWodV
	s4ZQhGTsIhhFNT2svdSQww1W5KIVWQBOZ2EgJ
X-Google-Smtp-Source: AGHT+IHFS/U+IzTBLUlqNS98m4n1M2wUlsBQufb/OJIUKIaVZlSRTFRaFeWPqL3+7T+d/Wx/XC6deEwpzONz55ZPW/Q=
X-Received: by 2002:a05:6871:58a8:b0:269:1020:a8a0 with SMTP id
 586e51a60fabf-287c1e0d926mr2733439fac.4.1728313251339; Mon, 07 Oct 2024
 08:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004163155.3493183-1-jeffxu@google.com> <20241004163155.3493183-2-jeffxu@google.com>
 <20241005200741.GA24353@redhat.com>
In-Reply-To: <20241005200741.GA24353@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 7 Oct 2024 08:00:00 -0700
Message-ID: <CABi2SkV7wXa-41d3w+oL=+1zCcT=qjynRTdWnkVr+BoDqQK+3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] exec: seal system mappings
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, mike.kravetz@oracle.com, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 1:08=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 10/04, jeffxu@chromium.org wrote:
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the mapping of vdso, vvar, and sigpage during restore
> > operations. Consequently, this feature cannot be universally enabled
> > across all systems.
>
> Can't review.
>
> But as for uprobes, I'd prefer a simpler patch which doesn't need the new
> CONFIG_ and/or kernel boot options, something like the patch below.
>
Ok.

> And I don't really like the fact that this patch changes the behaviour
> of the "generic" _install_special_mapping() helper, but I won't argue.
>
This makes the minimum code change currently.
 If in the future, there is a special mapping type that can't be
sealed, we can refactor _install_special_mapping() to support that.

> Oleg.
>
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -430,6 +430,8 @@ extern unsigned int kobjsize(const void *objp);
>  #ifdef CONFIG_64BIT
>  /* VM is sealed, in vm_flags */
>  #define VM_SEALED      _BITUL(63)
> +#else
> +#define VM_SEALED      0
>  #endif
>
>  /* Bits set in the VMA until the stack is in its final location */
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 40ecab0971ff..388373c11593 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1510,7 +1510,7 @@ static int xol_add_vma(struct mm_struct *mm, struct=
 xol_area *area)
>         }
>
>         vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> +                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_S=
EALED,
>                                 &xol_mapping);
OK.

>         if (IS_ERR(vma)) {
>                 ret =3D PTR_ERR(vma);
>

