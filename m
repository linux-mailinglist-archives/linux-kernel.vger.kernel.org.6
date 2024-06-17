Return-Path: <linux-kernel+bounces-217138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B8890AC64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27FDEB2920E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11689194AF1;
	Mon, 17 Jun 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3dsAr1x"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD56D1C7;
	Mon, 17 Jun 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621136; cv=none; b=JOboR2tg0PDH/sSpK4AiL5Q3on0lvAIVqEz79l+xvxBXVq+XJPibumQi5KqJEaf3Mx6x8TgSF4wI5TcQoX5s9P7d7YGEKLPoqFUlRER2GPye/cEgkepi6w2DuNd6IOGJPwvMM2Vw2klvlAt5VhOJbG7F56ZNBYLPo7eJ9kM/Y8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621136; c=relaxed/simple;
	bh=lLsSW4XbxLzv78IVmwQc671Fdwl5X2aJm6ywh4DqDik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpYdg3bkAh6taubhiItzoIBjUa1AUG15gBwK3bYs6YyH43pB2rjekLUTSZ0yVb7uk9nA7BE7LVU0Y+uOOiIBIZdXz9eO3TKO6Z4FuYbZFgmyxKw+jaRsbbX3grznsBiQMqiSXmZoHD4GdKnZ5+xvdZwcdY6vUg11liWSyujEvCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3dsAr1x; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ba33b08550so1977140eaf.2;
        Mon, 17 Jun 2024 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718621133; x=1719225933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDLauPxb+HVcWDog+LTpu5XRFYgNA1dPtktArEVT8/Y=;
        b=L3dsAr1xRPUeZVxqh2mNzbQ2m54tcmsFFwRGPqEDqU+MYekqtrYrT+95yD2v3NcOVi
         CfULsfT9lBoXFCmqY3mJZLf/VsryGbXO4KyLtPWGyAuSnttP/AopT58kc2mdHf6M0iCp
         J8+1/TLRxXiANx/ev6ZesKZXhbdDLQq5iLNNzdPIuCQdsmFgWrtEog/WT0gN7+Qwb+2c
         lGOJQvY1mLlG4BN0j4FpHMKuzH3CIBg2AKMDdS/qBS7/IDm2knAeCaRn/EKl00xCkZ/3
         Rc7iCBDV9III4nO3ELT/+ZKwOG3NBYcjNAgz2QcCh5ZGENrZyGKD1Gw1hE8srV9b2idA
         ckBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718621133; x=1719225933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDLauPxb+HVcWDog+LTpu5XRFYgNA1dPtktArEVT8/Y=;
        b=QdpHjBMTHDUw4H8cc7v5Gfx16dLko33AVbxAnt7MdDRTSzcAo+r982oVdAyPrq5LT4
         hhiKBJv4L5GdxzNHZ9op3u9u08T4E/zbXvUbG2AdAAFsDVddD/GdwAdIsExcYMMOAKYS
         N/5O9GWjERKpkNs+kdiRK9eS5h9b6FocDMuhmU7lyN4T75IeR0xvOT8wrgOpKsCNxYpW
         m4tcAdYLttfrWlBqkgS94grqgB3pf6NVEhDpgZN5zlSVwDW5yphoCS2CY8VOel12OZzw
         lqG3WEDMsKPnQ9qY25a6KgnWQVKMa7LzKib5mZZR3b23lxKqQm0TO+CFfoWGgOJM6SIv
         mCtg==
X-Forwarded-Encrypted: i=1; AJvYcCUEHCdzOVzKZV0noCR1t+LelquJPI6eHdKf0oDY6+ammM9YYAxzoCxOHepKl5+hc59a1Nnrzsb37XGs3CkRHBqGP/XXtCZx2X5UGLT/wMBtm541yV7A4V7Mt1YvbgLwVG8WACWE/8Vf
X-Gm-Message-State: AOJu0Yw+Vn882tjfMDFc7l/3jCrCeYOjB+UlU6v2pawGV3nLkRZLNviX
	k1C6ultRsdXcmbrdtlpItmZ7ixtXqbw6qrgVr7scT+09GMxc/m0HknDBCi7XbmVBFcT9f9+RPPW
	Pp5yyb0Jq+dmS4R/JOKdHLDBd7QI=
X-Google-Smtp-Source: AGHT+IHFLCL8ceoGv2471F/sqi3RE4qFLvaeK/VXa4l1ZtiS7s2l+x4o38Y4G4zK9ZSUQljJSrJR8LodyLNYGOEixRo=
X-Received: by 2002:a05:6820:1c88:b0:5ba:e2cb:c853 with SMTP id
 006d021491bc7-5bdadc30cc3mr9082503eaf.5.1718621133095; Mon, 17 Jun 2024
 03:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615035323.909650-1-dzm91@hust.edu.cn> <20240615035323.909650-2-dzm91@hust.edu.cn>
 <87v828gfic.fsf@intel.com>
In-Reply-To: <87v828gfic.fsf@intel.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Mon, 17 Jun 2024 18:45:06 +0800
Message-ID: <CAD-N9QUBdMjfr3ULuFE_S4JgLeMSRW2OD7ftj+7ArrpF2iwSpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc-guide: add help documentation checktransupdate.rst
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 4:32=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Sat, 15 Jun 2024, Dongliang Mu <dzm91@hust.edu.cn> wrote:
> > This commit adds help documents - Documentation/doc-guide/checktransupd=
ate.rst
> > and Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> > for scripts/checktransupdate.py, including English and Chinese versions
> >
> > Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> > ---
> > v1->v2: fix some issues according to Randy
> >  Documentation/doc-guide/checktransupdate.rst  | 63 +++++++++++++++++++
> >  Documentation/doc-guide/index.rst             |  1 +
> >  .../zh_CN/doc-guide/checktransupdate.rst      | 62 ++++++++++++++++++
> >  .../translations/zh_CN/doc-guide/index.rst    |  1 +
> >  4 files changed, 127 insertions(+)
> >  create mode 100644 Documentation/doc-guide/checktransupdate.rst
> >  create mode 100644 Documentation/translations/zh_CN/doc-guide/checktra=
nsupdate.rst
> >
> > diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentati=
on/doc-guide/checktransupdate.rst
> > new file mode 100644
> > index 000000000000..4ece330882d6
> > --- /dev/null
> > +++ b/Documentation/doc-guide/checktransupdate.rst
> > @@ -0,0 +1,63 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Check translation update
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +
> > +This script helps track the translation status of the documentation in
> > +different locales, i.e., whether the documentation is up-to-date with
> > +the English counterpart.
> > +
> > +How it works
> > +------------
> > +
> > +It uses ``git log`` command to track the latest English commit from th=
e
> > +translation commit (order by author date) and the latest English commi=
ts
> > +from HEAD. If any differences occur, the file is considered as out-of-=
date,
> > +then commits that need to be updated will be collected and reported.
> > +
> > +Features implemented
> > +--------------------
> > +
> > +-  check all files in a certain locale
> > +-  check a single file or a set of files
> > +-  provide options to change output format
> > +
> > +Usage
> > +-----
>
> Why not document the argument parser and tell people ot run
> 'checktransupdate.py --help' here? Duplicating the usage here is just a
> maintenance burden.
>

Thanks, this is a good suggestion. I will modify it in the v3 patch.

> BR,
> Jani.
>
>
>
>
> > +
> > +::
> > +
> > +   checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-=
commits] [--print-updated-files | --no-print-updated-files] [--debug | --no=
-debug] [files ...]
> > +
> > +Options
> > +~~~~~~~
> > +
> > +-  ``-l``, ``--locale``: locale to check when file is not specified
> > +-  ``--[no-]print-commits``: whether to print commits between origin a=
nd
> > +   translation
> > +-  ``--[no-]print-updated-files``: whether to print files that do no
> > +   need to be updated
> > +-  ``files``: files to check, if this option is specified, the locale
> > +   option will be ignored.
> > +
> > +Samples
> > +~~~~~~~
> > +
> > +-  ``./scripts/checktransupdate.py -l zh_CN``
> > +   This will print all the files that need to be updated in the zh_CN =
locale.
> > +-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/pr=
ocess/coding-style.rst``
> > +   This will only print the status of the specified file.
> > +
> > +Then the output is something like:
> > +
> > +::
> > +
> > +    Documentation/translations/zh_CN/process/coding-style.rst       (2=
 commits)
> > +    commit 6813216bbdba ("Documentation: coding-style: ask function-li=
ke macros to evaluate parameters")
> > +    commit 185ea7676ef3 ("Documentation: coding-style: Update syntax h=
ighlighting for code-blocks")
> > +
> > +Features to be implemented
> > +----------------------------
> > +
> > +- track the translation status of files that have no translation
> > +- files can be a folder instead of only a file
> > diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guid=
e/index.rst
> > index 7c7d97784626..24d058faa75c 100644
> > --- a/Documentation/doc-guide/index.rst
> > +++ b/Documentation/doc-guide/index.rst
> > @@ -12,6 +12,7 @@ How to write kernel documentation
> >     parse-headers
> >     contributing
> >     maintainer-profile
> > +   checktransupdate
> >
> >  .. only::  subproject and html
> >
> > diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdat=
e.rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> > new file mode 100644
> > index 000000000000..37c0bb518ab8
> > --- /dev/null
> > +++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> > @@ -0,0 +1,62 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +.. include:: ../disclaimer-zh_CN.rst
> > +
> > +:Original: Documentation/doc-guide/checktransupdate.rst
> > +
> > +:=E8=AF=91=E8=80=85: =E6=85=95=E5=86=AC=E4=BA=AE Dongliang Mu <dzm91@h=
ust.edu.cn>
> > +
> > +=E6=A3=80=E6=9F=A5=E7=BF=BB=E8=AF=91=E6=9B=B4=E6=96=B0
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +=E8=BF=99=E4=B8=AA=E8=84=9A=E6=9C=AC=E5=B8=AE=E5=8A=A9=E8=B7=9F=E8=B8=
=AA=E4=B8=8D=E5=90=8C=E8=AF=AD=E8=A8=80=E7=9A=84=E6=96=87=E6=A1=A3=E7=BF=BB=
=E8=AF=91=E7=8A=B6=E6=80=81=EF=BC=8C=E5=8D=B3=E6=96=87=E6=A1=A3=E6=98=AF=E5=
=90=A6=E4=B8=8E=E5=AF=B9=E5=BA=94=E7=9A=84=E8=8B=B1=E6=96=87=E7=89=88=E6=9C=
=AC=E4=BF=9D=E6=8C=81=E6=9B=B4=E6=96=B0=E3=80=82
> > +
> > +=E5=B7=A5=E4=BD=9C=E5=8E=9F=E7=90=86
> > +------------
> > +
> > +=E5=AE=83=E4=BD=BF=E7=94=A8 ``git log`` =E5=91=BD=E4=BB=A4=E6=9D=A5=E8=
=B7=9F=E8=B8=AA=E7=BF=BB=E8=AF=91=E6=8F=90=E4=BA=A4=E7=9A=84=E6=9C=80=E6=96=
=B0=E8=8B=B1=E6=96=87=E6=8F=90=E4=BA=A4=EF=BC=88=E6=8C=89=E4=BD=9C=E8=80=85=
=E6=97=A5=E6=9C=9F=E6=8E=92=E5=BA=8F=EF=BC=89=E5=92=8C=E8=8B=B1=E6=96=87=E6=
=96=87=E6=A1=A3=E7=9A=84
> > +=E6=9C=80=E6=96=B0=E6=8F=90=E4=BA=A4=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=
=89=E4=BB=BB=E4=BD=95=E5=B7=AE=E5=BC=82=EF=BC=8C=E5=88=99=E8=AF=A5=E6=96=87=
=E4=BB=B6=E8=A2=AB=E8=AE=A4=E4=B8=BA=E6=98=AF=E8=BF=87=E6=9C=9F=E7=9A=84=EF=
=BC=8C=E7=84=B6=E5=90=8E=E9=9C=80=E8=A6=81=E6=9B=B4=E6=96=B0=E7=9A=84=E6=8F=
=90=E4=BA=A4=E5=B0=86=E8=A2=AB=E6=94=B6=E9=9B=86=E5=B9=B6=E6=8A=A5=E5=91=8A=
=E3=80=82
> > +
> > +=E5=AE=9E=E7=8E=B0=E7=9A=84=E5=8A=9F=E8=83=BD
> > +--------------------
> > +
> > +- =E6=A3=80=E6=9F=A5=E7=89=B9=E5=AE=9A=E8=AF=AD=E8=A8=80=E4=B8=AD=E7=
=9A=84=E6=89=80=E6=9C=89=E6=96=87=E4=BB=B6
> > +- =E6=A3=80=E6=9F=A5=E5=8D=95=E4=B8=AA=E6=96=87=E4=BB=B6=E6=88=96=E4=
=B8=80=E7=BB=84=E6=96=87=E4=BB=B6
> > +- =E6=8F=90=E4=BE=9B=E6=9B=B4=E6=94=B9=E8=BE=93=E5=87=BA=E6=A0=BC=E5=
=BC=8F=E7=9A=84=E9=80=89=E9=A1=B9
> > +
> > +=E7=94=A8=E6=B3=95
> > +-----
> > +
> > +::
> > +
> > +   checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-=
commits] [--print-updated-files | --no-print-updated-files] [--debug | --no=
-debug] [files ...]
> > +
> > +=E9=80=89=E9=A1=B9
> > +~~~~~~~
> > +
> > +-  ``-l``, ``--locale``: =E6=A3=80=E6=9F=A5=E6=8C=87=E5=AE=9A=E7=9A=84=
=E6=96=87=E4=BB=B6=E8=AF=AD=E8=A8=80=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=9C=AA=E6=
=8C=87=E5=AE=9A=E6=96=87=E4=BB=B6
> > +-  ``--[no-]print-commits``: =E6=98=AF=E5=90=A6=E6=89=93=E5=8D=B0=E8=
=8B=B1=E6=96=87=E5=8E=9F=E5=A7=8B=E7=89=88=E6=9C=AC=E5=92=8C=E7=BF=BB=E8=AF=
=91=E7=89=88=E6=9C=AC=E4=B9=8B=E9=97=B4=E7=9A=84=E6=8F=90=E4=BA=A4
> > +-  ``--[no-]print-updated-files``: =E6=98=AF=E5=90=A6=E6=89=93=E5=8D=
=B0=E6=97=A0=E9=9C=80=E6=9B=B4=E6=96=B0=E7=9A=84=E6=96=87=E4=BB=B6
> > +-  ``files``: =E8=A6=81=E6=A3=80=E6=9F=A5=E7=9A=84=E6=96=87=E4=BB=B6=
=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=8C=87=E5=AE=9A=E4=BA=86=E6=AD=A4=E9=80=89=E9=
=A1=B9=EF=BC=8C=E5=B0=86=E5=BF=BD=E7=95=A5=E8=AF=AD=E8=A8=80=E9=80=89=E9=A1=
=B9
> > +
> > +=E7=A4=BA=E4=BE=8B
> > +~~~~~~~
> > +
> > +-  ``./scripts/checktransupdate.py -l zh_CN``
> > +   =E8=BF=99=E5=B0=86=E6=89=93=E5=8D=B0 zh_CN =E8=AF=AD=E8=A8=80=E4=B8=
=AD=E9=9C=80=E8=A6=81=E6=9B=B4=E6=96=B0=E7=9A=84=E6=89=80=E6=9C=89=E6=96=87=
=E4=BB=B6=E3=80=82
> > +-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/pr=
ocess/coding-style.rst``
> > +   =E8=BF=99=E5=B0=86=E5=8F=AA=E6=89=93=E5=8D=B0=E6=8C=87=E5=AE=9A=E6=
=96=87=E4=BB=B6=E7=9A=84=E7=8A=B6=E6=80=81=E3=80=82
> > +
> > +=E7=84=B6=E5=90=8E=E8=BE=93=E5=87=BA=E7=B1=BB=E4=BC=BC=E5=A6=82=E4=B8=
=8B=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=9A
> > +
> > +::
> > +
> > +    Documentation/translations/zh_CN/process/coding-style.rst       (2=
 commits)
> > +    commit 6813216bbdba ("Documentation: coding-style: ask function-li=
ke macros to evaluate parameters")
> > +    commit 185ea7676ef3 ("Documentation: coding-style: Update syntax h=
ighlighting for code-blocks")
> > +
> > +=E5=BE=85=E5=AE=9E=E7=8E=B0=E7=9A=84=E5=8A=9F=E8=83=BD
> > +-------------
> > +
> > +- =E8=B7=9F=E8=B8=AA=E6=B2=A1=E6=9C=89=E7=BF=BB=E8=AF=91=E8=BF=87=E7=
=9A=84=E6=96=87=E4=BB=B6=E7=9A=84=E7=BF=BB=E8=AF=91=E7=8A=B6=E6=80=81
> > +- =E6=96=87=E4=BB=B6=E5=8F=82=E6=95=B0=E5=8F=AF=E4=BB=A5=E6=98=AF=E6=
=96=87=E4=BB=B6=E5=A4=B9=E8=80=8C=E4=B8=8D=E4=BB=85=E4=BB=85=E6=98=AF=E5=8D=
=95=E4=B8=AA=E6=96=87=E4=BB=B6
> > diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/Doc=
umentation/translations/zh_CN/doc-guide/index.rst
> > index 78c2e9a1697f..0ac1fc9315ea 100644
> > --- a/Documentation/translations/zh_CN/doc-guide/index.rst
> > +++ b/Documentation/translations/zh_CN/doc-guide/index.rst
> > @@ -18,6 +18,7 @@
> >     parse-headers
> >     contributing
> >     maintainer-profile
> > +   checktransupdate
> >
> >  .. only::  subproject and html
>
> --
> Jani Nikula, Intel
>

