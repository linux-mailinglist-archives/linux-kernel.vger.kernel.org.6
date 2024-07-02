Return-Path: <linux-kernel+bounces-238168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36267924626
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90605B21FA8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D81BE221;
	Tue,  2 Jul 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npVAbzeP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EF63D;
	Tue,  2 Jul 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941499; cv=none; b=OVEWv4CVSiE9jD7q2EAVUiDK2wCM3ve7AcbzViYSEao4PkbQ+OfmDpAZNOgYmWOgXRn2S6cALBjmIJRKIToc8M6tnZLbQoPNt6fmtK53OkbblJ+BxQc1smSjOfNLvCfQA3YYNef/DzORNDgc560Bb8McEBQDDZnARA76h2zvd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941499; c=relaxed/simple;
	bh=eLSpiG/nG5LqRYTxklKZZEHMe3WYQm9lPZRlciGPDo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtMdjYwzEQ08dRK1W2cxgnjcr5ChWBcc2S9jTm5AoritqMlt+vgZhjxMjBaEWMUvE+lYQVR0auEJDD0bSbBm5NVx92DVZO5KA7pzQD138VolPw45BC+BJqhoru+21XOjLs9brE5wGQYD969YlDH1Qy7hNW82H17w5Xpj3qGt5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npVAbzeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882B5C116B1;
	Tue,  2 Jul 2024 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719941499;
	bh=eLSpiG/nG5LqRYTxklKZZEHMe3WYQm9lPZRlciGPDo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=npVAbzeP6GC5K7lt2m6oCPpyaO+MAAGpjUWRCPmbnQh45yX+RcHbZmE65TKVLdyqx
	 gMxrVJa38JQlF01CLzxXc+GsmsFAVE4qoPNva9NtyLPrGzlE9Tyc/LoWn1CX1bYd8c
	 moVhn6krLEqKKVbj7g4Mi1Ej+VVscFjL1w6ydPEmt4O5ZtO00NzRtI/xNTPGl0aMdE
	 wPHzOHXKQFS9fx6q/UfAW0+uXnaRlOubAnUqq26ljOfdMOnjrvJ4fKe10nX8SiXLjN
	 PprggjagVTHV5alsUl+q0MpK/lkSqetIc18wIS+nkgAAgVN/hfzLklYzeGQ40/+m16
	 gGl0OX+i9hYQA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee4ab5958dso47078321fa.1;
        Tue, 02 Jul 2024 10:31:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaIFg/o2sVamw107e8RDxT91coBmEqSKjnjhUabLV1ptWFoKqtDJQiztHGgFD0FLRu/7zba8BNb80j3IfLVk8v013bzAILZfRNC1YWZSBlGORzQ7K2OunNtL0SwS8QghFqKNAw5C0xsg==
X-Gm-Message-State: AOJu0Yy15ta/3wurxRxSD1wbmRrvaHM6e6/CONGxJv4Y1h9uE2/wvxCH
	JLveJxJkZkLJtP2Uk+xSxNFM9kYP25MDzHiHhGYBUou24sZd3RGiIMnQD/ehkv/pCk8GF7yxYNx
	qTZlYGbOPzbpa/sz1ilct4JLOoQ==
X-Google-Smtp-Source: AGHT+IEZT7uAluQOGnvOb1tbCNAEAJsZkxrg3kb2tdkIeIRFQ0kkyoqsja8EfoWi/URPTFgwd1QrcVY+OtVG9W0TzCo=
X-Received: by 2002:a05:6512:104a:b0:52e:941d:ade8 with SMTP id
 2adb3069b0e04-52e941dae76mr109325e87.9.1719941497915; Tue, 02 Jul 2024
 10:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701215441.54353-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240701215441.54353-1-heinrich.schuchardt@canonical.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 2 Jul 2024 11:31:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgsD2UN2FTvz3AByc8TSdGsrSJZGUM1Fr-v2yhu0gh-g@mail.gmail.com>
Message-ID: <CAL_JsqKgsD2UN2FTvz3AByc8TSdGsrSJZGUM1Fr-v2yhu0gh-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] libfdt: check return value of fdt_num_mem_rsv() in fdt_pack()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:55=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> fdt_num_mem_rsv() may return -FDT_ERR_TRUNCATED.
> In this case fdt_pack() should propagate the error code.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  libfdt/fdt_rw.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

This needs to be sent to David G and devicetree-compiler list to be applied=
.

>
> diff --git a/libfdt/fdt_rw.c b/libfdt/fdt_rw.c
> index 3621d36..a307701 100644
> --- a/libfdt/fdt_rw.c
> +++ b/libfdt/fdt_rw.c
> @@ -490,8 +490,11 @@ int fdt_pack(void *fdt)
>
>         FDT_RW_PROBE(fdt);
>
> -       mem_rsv_size =3D (fdt_num_mem_rsv(fdt)+1)
> -               * sizeof(struct fdt_reserve_entry);
> +       mem_rsv_size =3D fdt_num_mem_rsv(fdt);
> +       if (mem_rsv_size < 0)
> +               return mem_rsv_size;
> +
> +       mem_rsv_size =3D (mem_rsv_size + 1) * sizeof(struct fdt_reserve_e=
ntry);
>         fdt_packblocks_(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt),
>                         fdt_size_dt_strings(fdt));
>         fdt_set_totalsize(fdt, fdt_data_size_(fdt));
> --
> 2.45.2
>
>

