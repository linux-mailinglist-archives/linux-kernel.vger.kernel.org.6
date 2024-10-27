Return-Path: <linux-kernel+bounces-383764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0ED9B1FF6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A881C20912
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F9617CA04;
	Sun, 27 Oct 2024 19:52:31 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A817A924;
	Sun, 27 Oct 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730058750; cv=none; b=AVs7FALfgHWDn6Jm8TRzp/EPrmkBNMkB5qxEXdXqqJiixjPr409YmybR8Hlg6mC1742jufFPxdMuiQqDe24Z6U5DOD24DWgRVka/qeXyWmTf61QevkZbu7UFjNoEApYar4kOnuuREiYHwTcXJAgmtB8FcCRLk6N5YDTV8y9fHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730058750; c=relaxed/simple;
	bh=Slx0hadI2DF4XTksLkkSS4jxKbe3wNck6qvxZTHGNcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA7kkqZaEeC1CIqO++nXltomFXTVnq7ocjnU896QcsIIDF4lK6s+QuSkAFXpIZdoiH9W6cgHJp5Zuvv0flDDaUV/xYfyPKYk8gVxwK3bb3FucWtybP/EU0QKgzvvvZXhzq8gLNVDvoKfwK7gGNown+b/dwBAlN3c71162f4F4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5101c527611so303896e0c.3;
        Sun, 27 Oct 2024 12:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730058748; x=1730663548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeNyK1dS8fdGfFYCHz8SEYzY/h/VTeC8f7pSxMKfbEE=;
        b=ioGYoFdMSqnhG+kxvjs0nV5OTDFC3QCzvX3pSEgl36lliWhocqw1FBpWSA5NO8MRe9
         CAWC571KYfw7meGXNNbJXXE8qpH0O2XRkrnBM71MUAs2CKvwfeaFWjVF6FbjI9yCuV5y
         yMtps5Z46gAGJyZdEnHLub3YHXZvcs/2xxTxbZRRoJYZazOthC2pe/kIj1D3y0q7SjL2
         uX0U4Ei3MfsQAui80xGAbzcCkOzLJ/6z8w08/8pQnRYFDCR0WRiwf1w7r3cCBSFRjkqJ
         /Gsk4kRPDd90NVqB16iDKahyoMkn3f9J3m53e7umnjGf+mZGwAK+aC8Ta31PgqGHqXuY
         5u+g==
X-Forwarded-Encrypted: i=1; AJvYcCUhezpeWZqk7v5wHBrUj6m3WJ6Erl7FtAT89p35at6NIRdQdGbKo6XWw++Z1H4syu78OuKGDNMtgvmMzi7d@vger.kernel.org, AJvYcCX0k95KzHqc+aUt02vfdbwnOyrqm56p9BO6sRZbZwtu1WUKnQrp1yqXwUnR/HNCaHC608TrYvDPqfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTo99SKXqyTYPZSmeh253FMA379JQ+nI2b+UqEI1FiYlSKk6Nh
	IKpIESXsQyEoETMVuOV6XVxtIIifB5nncb4lMCpfvpV+jHoY48weNkR1id32a8qB9+AxZUn8uHL
	86nukwqB2emmPbFc4oV2sHtp+YxHaGuua
X-Google-Smtp-Source: AGHT+IGZIhcR1qbYPRbikr3C426yAUQjADRfHf67ahq+w0TwSO4haB8Ydbmr5zPqqCM+K04KlxvHmSH5NQbFcMW8G3A=
X-Received: by 2002:a05:6122:1ad5:b0:50a:36ab:c788 with SMTP id
 71dfb90a1353d-51014ff5f55mr3170942e0c.3.1730058747749; Sun, 27 Oct 2024
 12:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027175743.1056710-1-mcanal@igalia.com> <20241027175743.1056710-2-mcanal@igalia.com>
In-Reply-To: <20241027175743.1056710-2-mcanal@igalia.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 28 Oct 2024 03:52:16 +0800
Message-ID: <CAGsJ_4xPr3X_EXh73c4gN-cUSxaXZ-XR=_VNE750zNH61nyR-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: fix the format of the kernel parameter ``thp_anon=``
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:58=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> If we add ``thp_anon=3D32,64KB:always`` to the kernel command line, we
> will see the following error:
>
> [    0.000000] huge_memory: thp_anon=3D32,64K:always: error parsing strin=
g, ignoring setting
>
> This happens because the correct format isn't ``thp_anon=3D<size>,<size>[=
KMG]:<state>```,
> as [KMG] must follow each number to especify its unit. So, the correct
> format is ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>```.

what if 32768,64K: always?

>
> Therefore, adjust the documentation to reflect the correct format of the
> parameter ``thp_anon=3D``.
>
> Fixes: dd4d30d1cdbe ("mm: override mTHP "enabled" defaults at kernel cmdl=
ine")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  Documentation/admin-guide/mm/transhuge.rst      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 1518343bbe22..1666576acc0e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6688,7 +6688,7 @@
>                         0: no polling (default)
>
>         thp_anon=3D       [KNL]
> -                       Format: <size>,<size>[KMG]:<state>;<size>-<size>[=
KMG]:<state>
> +                       Format: <size>[KMG],<size>[KMG]:<state>;<size>[KM=
G]-<size>[KMG]:<state>
>                         state is one of "always", "madvise", "never" or "=
inherit".
>                         Control the default behavior of the system with r=
espect
>                         to anonymous transparent hugepages.
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 203ba7aaf5fc..745055c3dc09 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -303,7 +303,7 @@ control by passing the parameter ``transparent_hugepa=
ge=3Dalways`` or
>  kernel command line.
>
>  Alternatively, each supported anonymous THP size can be controlled by
> -passing ``thp_anon=3D<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<stat=
e>``,
> +passing ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[=
KMG]:<state>``,
>  where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
>  supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvis=
e``,
>  ``never`` or ``inherit``.
> --
> 2.46.2
>

