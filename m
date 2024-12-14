Return-Path: <linux-kernel+bounces-445960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A205D9F1DD9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5EBD7A05F6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C916DEB3;
	Sat, 14 Dec 2024 09:38:19 +0000 (UTC)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F22433D8
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734169098; cv=none; b=RI44YtvxFXmWSZJgq25znU+0qd1bdFPqLWvtFh+yUYXmP1mpzi6ZNd7aKQ70rD89MG6PrYcDOPB+4fMCnZO/9oc68HqbcX1s1TqnfAb40iiL4WzjzNIz6qNJxX/jlThfWubKSG7DXnePzyk4O3brI3KTyMs1bUkVHoHsQWx682E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734169098; c=relaxed/simple;
	bh=BgUvSwtiyy6xMmf/edL05K4EgKAwt0ZE05fNIuaoIKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zda8NalBJBxRzgJMsU9ijGv6bC0tSDN86vjNUOKFf1acFTfODNlWmoVQWz0crDy0BM2JjAV4TfbzDjAL+EUmV/D8KPABjVBuPPqm4fD8Trj3Jq85p3K0+99RzFK8nUq7ls/RqaF0dQRZ6HCbI3JmAb3z44XaHN1kSqI6h7L8kwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a8ed4c8647so17308615ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734169096; x=1734773896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cml146Fs5k+G4PjNChFTpGbRGu78pseB/DaGmrlqOVo=;
        b=xIZ3rKkuhVvK54RxSZ5moGvvs8pBqBdVw6stfktb0D6FGGJ2340qR8SMHjUg9xW8C/
         FunbzrGn2TTt2mLRGfNSHtm4fKBajhMdBzldFFpMswq0QRXuSmEF2hGETKOIGLrlYnmP
         9+MRshuKcE1t8qGeFyjztrWYp49orCqZ440FE/WviPvFhBW8DcZrDmI8zek7BiFAIiEk
         Sp2UFQexsuPy4iknzaqrJ5pp9j+RHYttG7ACqq0QowL99cNV75P3maD/E/OoaFSbFb9M
         XZEpdB/q4GXwZfK3IG29EQuxGvkLBExosOW69dgEcCsBSOjvuu1r1dDrY9cnog5t2yTh
         pNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ngW7HqQ6Heg50PbAd4DzpYaQDEeVQsN80ZLMDVo2t+SssYz8idXM/dNkEavnrqJeh8rZkcgHUQWl1yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkofiC9/+yNqjVNMW4HE200DG0ROUvWe+79SJoJnkemwFNMQ1j
	T0827mxQOOrYIaSBJqY8xgTQtIVGP4SvxMnop47eJ67R8gtSPgF1xP0vDYz7
X-Gm-Gg: ASbGncs8bOVsajuCM9Ln76tgaETLPLEfP8hnIDG91XVy3rGXM8wJ6xjLQOwRmnUYq1b
	ecUbeJdqOCIem9r2sWeJdm9mHUhwH8RlTg6Aux2fGSNhbKB3KyMwU1KzMA3/EvBeFH0lAk9Omzp
	jFxsgW5JtPvNohbGUDN1HQP9RGqbZ1VJJ+skaN2BmZFEhQ9ei37GDYHRVtX/L62YRT7SfO/4ouo
	hZJiWVB6FXufZI38uBup+Bh639hR0JO5tKVgfNPLlWPZjscXeHHWNGVWlXT0RVVE9Upbu/uAMKX
	AimweiDqQjlzbw==
X-Google-Smtp-Source: AGHT+IEhrLGsPgSTILY9g2Lhv9l3NCxPLu+7Zj9o0Zga8Ohexnb/WmMQzfXYwVr6oQZ8JkTvFHnu8Q==
X-Received: by 2002:a05:6e02:3712:b0:3ab:8f76:bcfd with SMTP id e9e14a558f8ab-3aff19b7418mr81358025ab.20.1734169095745;
        Sat, 14 Dec 2024 01:38:15 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e0a3e542sm273186173.55.2024.12.14.01.38.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 01:38:15 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so123411039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:38:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWswrr1cTn6iIpkIT+AtyVMmI22oNgZ8u/vip4XviJK2ZCodl1hcKSL9oxDYSioeRE2GPc1Wgq0qm32BgE=@vger.kernel.org
X-Received: by 2002:a05:6e02:1541:b0:3a7:776e:93fb with SMTP id
 e9e14a558f8ab-3afee2cfd8cmr67761055ab.8.1734169095423; Sat, 14 Dec 2024
 01:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214091937.203842-1-lsahn@ooseel.net>
In-Reply-To: <20241214091937.203842-1-lsahn@ooseel.net>
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Sat, 14 Dec 2024 18:38:04 +0900
X-Gmail-Original-Message-ID: <CANTT7qi=wZvOQP4PFEi7300MbNjsJ2q=WXceHch1BUrtL-WFDQ@mail.gmail.com>
Message-ID: <CANTT7qi=wZvOQP4PFEi7300MbNjsJ2q=WXceHch1BUrtL-WFDQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: fault: replace the behavior of fault_info[18]
To: lsahn@ooseel.net
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Mark Brown <broonie@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just figured out that do_sea(..) isn't the right function to deal
with VMSAv9-128.
Please ignore this patch.

BR
Leesoo

2024=EB=85=84 12=EC=9B=94 14=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 6:20, =
Leesoo Ahn <lsahn@ooseel.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Replace the behavior of 18th element of fault_info with the 'fn' member t=
o
> do_sea(..) and 'name' to 'level -2 (translation table walk)' based on
> the information[1] of the latest reference manual[2].
>
> The information has described in the chapter, D24.2.40 of [2] and
> DFSC[5:0] bit (stands for Data Fault Status Code).
>
> [1]: Synchronous External abort on translation table walk, level -2
> [2]: Arm Architecture Reference Manual, for A-profile architecture
>
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> ---
>  arch/arm64/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index ef63651099a9..b1c08289a5cc 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -863,7 +863,7 @@ static const struct fault_info fault_info[] =3D {
>         { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 3 permissi=
on fault"      },
>         { do_sea,               SIGBUS,  BUS_OBJERR,    "synchronous exte=
rnal abort"    },
>         { do_tag_check_fault,   SIGSEGV, SEGV_MTESERR,  "synchronous tag =
check fault"   },
> -       { do_bad,               SIGKILL, SI_KERNEL,     "unknown 18"     =
               },
> +       { do_sea,               SIGKILL, SI_KERNEL,     "level -2 (transl=
ation table walk)"     },
>         { do_sea,               SIGKILL, SI_KERNEL,     "level -1 (transl=
ation table walk)"     },
>         { do_sea,               SIGKILL, SI_KERNEL,     "level 0 (transla=
tion table walk)"      },
>         { do_sea,               SIGKILL, SI_KERNEL,     "level 1 (transla=
tion table walk)"      },
> --
> 2.46.1
>

