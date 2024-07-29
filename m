Return-Path: <linux-kernel+bounces-265124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818293ED07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5172812D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26008823A9;
	Mon, 29 Jul 2024 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="cO7sfZZw"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EAB64D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722231734; cv=none; b=fnTmLGHSPLK1dd7m9fGDq0xSrPZ1VRDK48oZpKUPM8KYQzHFeB6WNYrVGmCoGQQ5i3/6zF6Y/fIYwG+EBgssh3bKht7tQLcsJkZTOCIHcyYy2ajh8Hi7i47QFHV8Ke+/Q7FGsR0n6cK3rtoJx3tH9DNDfMWyGD+vfGDK0kGStjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722231734; c=relaxed/simple;
	bh=0TJmuJU4eKgARsq7eU7w4gR4BuXIj5QsqwFjlKXbZ4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7oHlkeFVFBdGsaBSoQwOZSESA4QljudGxzzn+N1HvBrL2Q7LHD7VDhduxhGXJaN2FL2/j+q/gU+ME5ArzA5IFQksUyxQCWfPqVqn1pqKOa0OMs4jXv953OvmSN59eYlSWTYRzoD6r1ZSljrBVaE+VASCDE9qip2eSBrwbOe+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=cO7sfZZw; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1067282276.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 22:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1722231730; x=1722836530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxFmntA/gfUvH86oYMSnyn42Q25EmQczHEO2HUWfKdY=;
        b=cO7sfZZwcx23UnZwecBdbY7+Kiy8UmENwu0huLGut1B+ETqrDpU86tkkubYq+CZwq8
         xj0/4sjWJtyGeEEaQcGC+SE5/kVJcK7U+DB40DaairdPXGYcrtLfuUWJyGmtpFPOCqXZ
         xjAfML2KpekIbQ+W1zXAllosIoHt5q4g8nStrLoK9mdSjpuOqyg/4u2jmxCPJOJf+WlL
         PgI3Z6GYvFLGAVdlxVAZeop+Wkh09C+J2WpqPcCCC8RKHFyIAHeBBRG2siGOfg9aHuX5
         2QKGCUt897LJSlU1TXNPaOhQg3DRatwe2ooIQSbVE208DUxq9unjcl8PHQgBHcohdgxY
         uvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722231730; x=1722836530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxFmntA/gfUvH86oYMSnyn42Q25EmQczHEO2HUWfKdY=;
        b=Y0Cu7EHz2GtaKRpWS/LkJlf+HUtnJrbRfAWAPfR2EYx4/UIjFN+zVPZ3BJfI7SVw1t
         z0B/HdIlJgja6DgGM2VP1LLdKGAivxeDA1MNCfoqMa6i7DAimXbyWoPZrSjLFWMKe/qI
         0OblQ4J4vTG7mXa2QrzTEDi+VAqPMwCGy+FQbsQkm5TeMs0x5Fm1EQICTqAWLnu/Zzqj
         1x5L248VMknF/86eNT5LOlKAvZX5CfSnVZJ3NPaNueMWE+PScI27Kw1wpotdZCtxBuQu
         KSDNPYjBozeRGY+/QwVmPT+2cZ2N6juqr1Bf3xQc8DSoUc+T70gT9h6TzDdQoCp6Bs0U
         jFAw==
X-Forwarded-Encrypted: i=1; AJvYcCVNN4Z2tMlyVRIHTzVFAdCRhJ9e/jjB+tLW/7vJ/CyZHa73LN8/xVTjWSfVKQY6T/ofH8+77ApenpCOgx+BAet/YXTEb0BtL3pRLorz
X-Gm-Message-State: AOJu0Yz/hrxxVaHCie3lYbTI88rkcemKYioOCN+XelQMEE3RkIa/7yod
	FJV9OuZWDrmlzUr4NeVJDpbTgW9uBPw3vWlte35TmDSf2VnciSGaUaB96SQ6ZMWh7TshraKe0RH
	O4D7PXj23WKs4Fre5bMRfIm91vQtRZXmmy9jl
X-Google-Smtp-Source: AGHT+IEfaBtyvPUHEqj/0+VfBK1q6xrlnS6dOIrWKgAfYyft57d3CSKTJjnzS/K5b7i3VJjkS2qYzJBv/bw4T/r8wfU=
X-Received: by 2002:a05:6902:2402:b0:e0b:49e0:1422 with SMTP id
 3f1490d57ef6-e0b55989cdbmr5200213276.24.1722231730014; Sun, 28 Jul 2024
 22:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729053327.4091459-1-rppt@kernel.org>
In-Reply-To: <20240729053327.4091459-1-rppt@kernel.org>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 29 Jul 2024 07:42:01 +0200
Message-ID: <CAHTX3dKZuWZVMeL8BfjVnExeKBLqn9zS-j8+aARDyiQ2UwSKgA@mail.gmail.com>
Subject: Re: [PATCH] microblaze: don't treat zero reserved memory regions as error
To: Mike Rapoport <rppt@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Wei Yang <richard.weiyang@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 29. 7. 2024 v 7:33 odes=C3=ADlatel Mike Rapoport <rppt@kernel.org> napsa=
l:
>
> Before commit 721f4a6526da ("mm/memblock: remove empty dummy entry") the
> check for non-zero of memblock.reserved.cnt in mmu_init() would always
> be true either because  memblock.reserved.cnt is initialized to 1 or
> because there were memory reservations earlier.
>
> The removal of dummy empty entry in memblock caused this check to fail
> because now memblock.reserved.cnt is initialized to 0.
>
> Remove the check for non-zero of memblock.reserved.cnt because it's
> perfectly fine to have an empty memblock.reserved array that early in
> boot.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mike Rapoport <rppt@kernel.org>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> ---
>
> Looks like it fell between the cracks.
>
>  arch/microblaze/mm/init.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index 3827dc76edd8..4520c5741579 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -193,11 +193,6 @@ asmlinkage void __init mmu_init(void)
>  {
>         unsigned int kstart, ksize;
>
> -       if (!memblock.reserved.cnt) {
> -               pr_emerg("Error memory count\n");
> -               machine_restart(NULL);
> -       }
> -
>         if ((u32) memblock.memory.regions[0].size < 0x400000) {
>                 pr_emerg("Memory must be greater than 4MB\n");
>                 machine_restart(NULL);
>
> base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9
> --
> 2.43.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

