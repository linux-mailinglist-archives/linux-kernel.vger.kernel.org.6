Return-Path: <linux-kernel+bounces-294907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF595942B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824341F23601
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7132166F28;
	Wed, 21 Aug 2024 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="catZ45pv"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791B79D1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218720; cv=none; b=EyEGWHHYZ1BiE/s94+BOEsmGn05WKr/q8uKBJcrrMZftBrSHLkkjRQNJzrvs81Sxt6NDL497EVZqKxw+8JgAzgVus5XVoWWCRGgxLfuBG5HSFJTH/6wg8ON3ckDDASbnvWZFl0j8hBrN2y6m4H04pxtIIq4735ynboxMDvqGJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218720; c=relaxed/simple;
	bh=qcwRerGhMNHH5bFLcgO3c9q9hSt41Jyxu1bfZMPsyGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8KHmkT4xKpyW/1nht0cV7XZjPJu8pjuKJqax8pse1++WFIYTcjleajrQ/tj//ItyPyHuY+bZJI9Jho3iFG9JV/K+7pr9l3CYitYZkcbpl6n0MwYFCShTWXrG/F6SmxX2PwhcJC7g0Z5BxU7QVTMJigfNlj07YcxV5vnFzdmhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=catZ45pv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so5509934a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724218717; x=1724823517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEVnSr8C5YchSU5ywJyrXPgyuO/IkLhd8eUlHXSN9/k=;
        b=catZ45pvQsqFf+Vdc5cAmUdUfriR0HEF2kOgh1+FnI7DANmPVRgfeyhvLmefI4ICGs
         Rw+52LC+QiGuInl6qdsAvgfQEZf2EXpjor+OnX/KOq/uTenCdNGHlDQh9vTPv5/PtjG/
         twkBj2Q2vs/nqvteVqQlLUiJ11MHL7BG08ZuZie98tP4FgU0jfxRWVM9uITQdw5TtyY+
         kOV9toStgSaKMa8yACvsH0GUFMD2xhYgDNqz4gaEPOmq3EMG2vbEiQMLQ6+iROKbEWPr
         XOJUjkssKOW00xyaeYNJKfUPtN5DOVNpPwGHd72Kxb1SabPFup0B/w+FqkI427zVfjwK
         yxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724218717; x=1724823517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEVnSr8C5YchSU5ywJyrXPgyuO/IkLhd8eUlHXSN9/k=;
        b=vKQnPJ+WN1VgpmGcRYKDvyPP/yDGvMuuJA0g37iru5e4znxSkvvuU8HyfJaAfRP6Bo
         wusaydmSBnTk5pcy8zqMUHIP/CIXOMYrIK4jpnNS47TGCmCbeY8i+TtGBjs56O4/cgNL
         TTIyoFMPsCl0Cs5RqLBseP3RhGcL5U4gb4GPWTFTnkJK2FQA2D8Qsb/CWNur9Zgn7Fqv
         pmx/K+Dv6q5zRY90mbbY24EyGJ7Ztk8RDoAYzO6/7MzFSdTFIj0NBg/gBuTUQzHmIHAq
         grxrCAuWlh3R4rsv+cite13Knu2N2fAA1GByBG/ehi2B+dSYV5jyK6zMf3MraZwBX/A1
         7/zw==
X-Forwarded-Encrypted: i=1; AJvYcCUmz9efP0uMrZvCYGsRqV6pcfTRRB5SkMvOv8XxDUr74Jc7v6mTxU1014LkJx6EoX3+GaxCWzKFfjiuejI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMsadWWVpIiLX8nYOl4bFsqpLSA5pMxXZkzSgNcJx7Sae4ZLI
	JUYaLo8El00xkr9GJtRHAEH+G8jilwamIuaq0NuRlp2Ot3s622MBFSwyc8naKFWc3uaDsktrauH
	7Zr1jGC/KY/deT7o7hYCzJNGUuF0=
X-Google-Smtp-Source: AGHT+IE8LhyhcVGn/pjElzMk5GRcBkIsTmKs5R1UnyoaWBNwJcbGKJamF6lGxMJDxSUPo3YdXl+Xi1sbe/MkRU8oUWg=
X-Received: by 2002:a05:6402:40c8:b0:5be:d704:e724 with SMTP id
 4fb4d7f45d1cf-5bf1f0d2be5mr624335a12.10.1724218715891; Tue, 20 Aug 2024
 22:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821033239.2233508-1-lihongbo22@huawei.com>
In-Reply-To: <20240821033239.2233508-1-lihongbo22@huawei.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Wed, 21 Aug 2024 13:38:24 +0800
Message-ID: <CAHB1NajVYd-_aXy49aBe=zuJmGgWWBGkaGp31zJ3PnEiV9GJCw@mail.gmail.com>
Subject: Re: [PATCH -next] scripts: make macro_checker.py executable
To: Hongbo Li <lihongbo22@huawei.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good to me, Thanks.

Hongbo Li <lihongbo22@huawei.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=B8=89 11:25=E5=86=99=E9=81=93=EF=BC=9A
>
> Set 755 for script macro_checker.py as other scripts.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  scripts/macro_checker.py | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 =3D> 100755 scripts/macro_checker.py
>
>
> > diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
> > old mode 100644
> > new mode 100755
Reviewed-by: Julian Sun <sunjunchao2870@gmail.com>

> --
> 2.34.1
>

Thanks,


Hongbo Li <lihongbo22@huawei.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=B8=89 11:25=E5=86=99=E9=81=93=EF=BC=9A
>
> Set 755 for script macro_checker.py as other scripts.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  scripts/macro_checker.py | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 =3D> 100755 scripts/macro_checker.py
>
> diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
> old mode 100644
> new mode 100755
> --
> 2.34.1
>


--=20
Julian Sun <sunjunchao2870@gmail.com>

