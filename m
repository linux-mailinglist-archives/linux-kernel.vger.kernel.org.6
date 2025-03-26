Return-Path: <linux-kernel+bounces-576551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD98A710E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68A57A5A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377A31917D0;
	Wed, 26 Mar 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqoWs1/Q"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6264D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972362; cv=none; b=D6dEYS+pMMWTC+TkMqHD232vWoA+0VBdzyRUXRNW6DhwURLZQv6tDWymO7b5rAMe88uIMiR9LUZ+zzSGEfCvimT1AfVZXON52RpRpAMo9fUEXXGDdznjZZ5WMfiDWpiCnUCufxvCON7aKFSmjiYf016/hYeSjZXQu+B5hrEYyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972362; c=relaxed/simple;
	bh=o4pJTwQhKx1ogb22BxjoekeOmT8QtFxvmttKFqre+9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7G24fILipSMMoD+oe6QsvLwuXWr+RpY537MrPNCeDGnx+FdX4JS2g+qc9R3Vkor99OWoXyS14YamSKBMumEd1C18n3wi/M2mpcZvRKscrOcTXo5qk+0a3+LQ/eeXfzH+K/zm/w8pnzOxIDBx2f6bOnuKXSGSZnxU9ywVrbH4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hqoWs1/Q; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f6eaa017d0so4706223b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742972360; x=1743577160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt2QTPR0dr6VE3DPwaU0qrg+/GigT8JzO3x4vxwhPLk=;
        b=hqoWs1/QIWP+4BYSkY78BXYwJ/5Atdq3O4EXqxAAZGxHWeFRcVggWwCOgdpLQXcMln
         cRV9QIitowNrggCXOsAOTkgT+WDjxk5kXf/seWUnsA7r3KHZBxqitGglULL5Tja7x5pO
         auhUYIQtLplw60EpkHpMNqVFU80UpOXS0vk68oXt0qcZZhDIYS3NmhzHxXkIWmCecDxx
         RSK/dancHOaIrcF4dYiXQAXxgjlnsvMOQ0oIAWemhv6m16NpZ9m6IfnhuELXh7ctg1us
         XfczYLCJqq9FVM0suSe+Ut4e6vlPqjgLWN0gDMyUoFydXom1wrJPOOPoI1oZTXP8UiUR
         uqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742972360; x=1743577160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt2QTPR0dr6VE3DPwaU0qrg+/GigT8JzO3x4vxwhPLk=;
        b=CqTGajU5B7mwuBC1sHkXZX12iUc3xCG+0SJDxKXkCTNCgL02/bwxmPxGvUKCMfsNB7
         c2NSRRuQ7wWhFUNLvkHVt/14TZcc7Rdbf6/rrf43HsBNkOJcqq1j9pztKMKBtMaRNUBh
         +BIsE3OIhhts4ZbBdwgKm/5aZZoxnJzdS4UqAB/uJRkM8/sgoYSqY8a3PBHmiHrGbYzV
         Yer6Zm1PI+QKdogI9EICu3EcbWpe+OyCcgWJ/TvX9xcwkvdvXDw3VTXv+RfraBVyanMh
         pUeeH+sY+jmaVUZoC1idixLOx96B66ibcfcoFWdcMHD0TBI0UUnvQMCkSWroVS7Se+0j
         5YLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN999Na0dRMag+BNQlRpk/Rtr738Ue9k8rftp0XZ+Y9dXownZcQ4sCWQJ/lrJ2iQBMOmMRCjUcYciwTT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+MenASPs30i/gs1OUUq+rOh7umFEJ/4qvxc9tmk9m2xQz5o9S
	tb4r9xR2fTFDYBZCcLfOfdqYUC0iUdBpFs3g/ujV3Bi1cXDyjQSSMSO511/DlnTyvVeQeqIsED9
	HdtL/e9qf/pZsvYvk5mFDxgo/yLz6W/TZC+k5/g==
X-Gm-Gg: ASbGnct8svgH3NByF/40pldmYcX0PjwNG+elGN35eYxk+OTwq0pKL2bWI9fTHYGU7WH
	RUBN/5PPVd7bjxjMS3WfYKAx29t/cb/VNvnl0ebD4y0QpiQzzIr9xCdGnbveNYh/Q7Eelv/Qxx3
	SVWrs561v1cY9qfi4ucxtmwJZBmAp1MFkRBB5wRA==
X-Google-Smtp-Source: AGHT+IGkpF+jjcvOywbgej1wg2C5sn/xBVM42DFut896JZoRImXnEyterR24izyQNVyIxI770eb6+FAYE53FsilCgm0=
X-Received: by 2002:a05:6808:f90:b0:3f8:e55c:16ea with SMTP id
 5614622812f47-3febf78f4e7mr10960519b6e.24.1742972359680; Tue, 25 Mar 2025
 23:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
In-Reply-To: <20250325200740.3645331-1-m.felsch@pengutronix.de>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 26 Mar 2025 07:59:08 +0100
X-Gm-Features: AQ5f1Jq45SG7SaCOOmhWUmhN881gom88KcW957TXYjlGk-WJ-HNHypGMjlhKHhE
Message-ID: <CAHUa44G_z0b42kHcaxvRJOou=pPT+MgWkJ5-5kbEOdJOFLMsAA@mail.gmail.com>
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: sumit.garg@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org, 
	willy@infradead.org, kernel@pengutronix.de, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Tue, Mar 25, 2025 at 9:07=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> Skip manipulating the refcount in case of slab pages according commit
> b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
>
> Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab pa=
ge")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v2:
> - Make use of page variable
> v1:
> - https://lore.kernel.org/all/20250325195021.3589797-1-m.felsch@pengutron=
ix.de/
>
>  drivers/tee/tee_shm.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..35f0ac359b12 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -19,16 +19,24 @@ static void shm_put_kernel_pages(struct page **pages,=
 size_t page_count)
>  {
>         size_t n;
>
> -       for (n =3D 0; n < page_count; n++)
> -               put_page(pages[n]);
> +       for (n =3D 0; n < page_count; n++) {
> +               struct page *page =3D pages[n];
> +
> +               if (!PageSlab(page))
> +                       put_page(page);
> +       }
>  }
>
>  static void shm_get_kernel_pages(struct page **pages, size_t page_count)
>  {
>         size_t n;
>
> -       for (n =3D 0; n < page_count; n++)
> -               get_page(pages[n]);
> +       for (n =3D 0; n < page_count; n++) {
> +               struct page *page =3D pages[n];
> +
> +               if (!PageSlab(page))
> +                       get_page(page);

b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page")
mentions that more page types will have a zero refcount in the longer
term. So we'll need to add exception after exception here. Is there a
helper function somewhere to get all the pages we need? Or can we do
this differently?

Cheers,
Jens

> +       }
>  }
>
>  static void release_registered_pages(struct tee_shm *shm)
> --
> 2.39.5
>

