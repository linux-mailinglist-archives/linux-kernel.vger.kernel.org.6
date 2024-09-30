Return-Path: <linux-kernel+bounces-343915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D348C98A142
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113271C21075
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB19918E020;
	Mon, 30 Sep 2024 11:58:21 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B355E48;
	Mon, 30 Sep 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697501; cv=none; b=WRYM5hMlMwxpA2yPRaqJVx2S/yIyqfo/IsO5wyDZAODaBzIUcSbUauE/iaQfqTWUOPiM67HO35HkdcTCgoH8/AAx+lhZVexNkFY06pEYrmctlCqZL4vQN6NedUBhCIDuX58p50iw3kL/DI3/iC33hCSowFCnsmQXxALFyOp3saI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697501; c=relaxed/simple;
	bh=+XTe8ZTlz5bzJaoos5E98LKB5gpf/X+7byEsfZ41vpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGn0Xrb4wD7PBJuxshwb//n4YLZYaXTIUAH33fR/92evR6swX3MCIrCZnQmNfzi3lHv+2k3xII/YFLPexO0G7LiiuvcZUWIklbIJ6iAwDcsygefiQSYhte8r+/4Jg05aP6AVXrJ+MdDXfE9kp41XIMM5GhlghSZ2VElB5/kyOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso4201072276.0;
        Mon, 30 Sep 2024 04:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697497; x=1728302297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBhQUD2ivI1lM/FdIQwroSXOb0UcPWeoSjL72i76dRc=;
        b=takSN60eCGnrXFSOB/DYqpWXhW8E2b6kIGVjCE3rajz49jZTGXVuh+/ZXCKfEJ+sU0
         IZdafVvzxrGmW38hQHdd8g2kPilbNLnZkdeKpcDWa/unvmkMM9vzpzCrnFdPYEmUKv1k
         u6glfVKzuM689accT2QyBJlDoSgcnzn7aYkKZzt2tfB/ZlCnqJfHdGZ+LitZZiyXpJUQ
         wkG9O2jdQfFLi4QvVydOM7hxwCAV4vv3oOB7f6eX5lXSaNjoTzTCRpHYGQFqUfIiHHcQ
         kqkqUBpkYzvngIsd3+c++y/HreMSkZYcx4nsbuAW3kjyYv68e/yYcCKmXxvu4SVleoGn
         UudQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgATIWTiZYhBBQztJf2utsnVc2xQZ/A6DkjeL74Dtb/vMUeWsdvnDeZrqZn9sK19Ja+EIOt2vczQZsMQSn@vger.kernel.org, AJvYcCXmXLEIOf3JwY2L3NOOsyl+ZRyWqUyqE/oUPEA2znMpPh6QX2+esM6wljQSgGyXb+4vvQkdMkokRydyBo2EbIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bi7p2xNLdTCqFJWu0Ow1sVsdLkMjP5W6eBzww3jptb/DpxPE
	f9NatTzRAmI3YzkGRLK/MWRqM9NtcoBGNqBAwNzKm6sPtID6aSaoHM76MYzP
X-Google-Smtp-Source: AGHT+IEcb5rufu7wXIRzswL0FrKr1+fqdB+Zf+2a+KZc1r6tQRsSlDzSZeLONVwa944c9As2oGcd8A==
X-Received: by 2002:a05:6902:2289:b0:e26:183:92c2 with SMTP id 3f1490d57ef6-e2604b7ef8dmr9089832276.27.1727697496945;
        Mon, 30 Sep 2024 04:58:16 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e3ef9e2esm2276103276.8.2024.09.30.04.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 04:58:16 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6db836c6bd7so39926807b3.3;
        Mon, 30 Sep 2024 04:58:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI/M5PLLCHT87gXD8xPT3QxSujU+jDDmYmOo5L8HPIvMQ/gAT2HOyKKz6fWSlq/7XA4NdsyxPEsIBlidly@vger.kernel.org, AJvYcCXLos2K/3OlyghQu9RXu/d5VTWMtmoQ3Vj//dEc6cMDUB7HrLvHxiDbvspVI2hL0OZs9MZD8CBIIdMZPN8Kj9A=@vger.kernel.org
X-Received: by 2002:a05:690c:4243:b0:63b:f919:2e89 with SMTP id
 00721157ae682-6e24750a977mr72447177b3.2.1727697495763; Mon, 30 Sep 2024
 04:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930112121.95324-1-Julia.Lawall@inria.fr> <20240930112121.95324-12-Julia.Lawall@inria.fr>
In-Reply-To: <20240930112121.95324-12-Julia.Lawall@inria.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 13:58:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=y_yx8qxmNZUV9ALxW_ZcMpEgXYirnHr70SHGYnWTRA@mail.gmail.com>
Message-ID: <CAMuHMdW=y_yx8qxmNZUV9ALxW_ZcMpEgXYirnHr70SHGYnWTRA@mail.gmail.com>
Subject: Re: [PATCH 11/35] powerpc/ps3: Reorganize kerneldoc parameter names
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Geoff Levand <geoff@infradead.org>, kernel-janitors@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 1:24=E2=80=AFPM Julia Lawall <Julia.Lawall@inria.fr=
> wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
>
> Problems identified using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -940,7 +940,7 @@ int __init ps3_repository_read_vuart_sysmgr_port(unsi=
gned int *port)
>
>  /**
>    * ps3_repository_read_boot_dat_info - Get address and size of cell_ext=
_os_area.
> -  * address: lpar address of cell_ext_os_area
> +  * @lpar_addr: lpar address of cell_ext_os_area
>    * @size: size of cell_ext_os_area
>    */

Not really a reordering, but good to have it ;-)

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

