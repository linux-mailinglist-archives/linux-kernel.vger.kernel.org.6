Return-Path: <linux-kernel+bounces-216889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4765790A81D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B0AB2532F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527CE18FDCB;
	Mon, 17 Jun 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKLc7JbQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F318628D;
	Mon, 17 Jun 2024 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611589; cv=none; b=fnAOpOWAjXQjAEt8V+LGUYrV9yB64xEWtqTJakRYrurYgP665X12WK2Y35VrBFagwCYjhdAyqGLlua094cfso5J8HK0BTDA675J6/nmW6kbTO6P++61vhvwnb9w6lZebTr1I5ycYVC3M87tvOFqPxNssfwvcFTvbqzKL8cO2M6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611589; c=relaxed/simple;
	bh=qV0f68IO2hFc1RMbpFCNfD+bhD/X0kb584yxIMUptks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6Z4yelJC0EwccfZcK0izo7oY9pN6UVZErXeUJARf8SKYhd1iiHFVk08wUnXgGv/Q9sLXwHYY3/O28XheIutcr5aEDeOHVdz3K7koF7F/Lte3rFOjjAH7r9cXJ69+WNH9sH58MrjVRykDOpW6hu/ntjptF6z7STNgWK2IBZSwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKLc7JbQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718611587; x=1750147587;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=qV0f68IO2hFc1RMbpFCNfD+bhD/X0kb584yxIMUptks=;
  b=LKLc7JbQb/1tg6+DY1i7iMLe5omkyyEHehJ8ZlX8ApYCymWqHJAr7m6I
   jobhlpmtFbhQlOEDDGj7l6Mc14Y1Aol2zNzH6nt0R7CS96U8PkMjB6oUl
   +reAjNTLuDX9kSBH6Y+MSfLimUvaNEgyYDOe4GWRL4KNwHZ7S1mTGk1Pu
   +9rJjxCiyzC3lY+YD/vFTvar+CrTp6aFAcRxVj76UTwDkluCRZ53+7tK8
   A6WTvowD99HEIC2OYy0bBk3EBpMjnmFgNj/q3o2WLVlNWlKTSxVpMIM42
   YS0Rse3CdtWKdJttHTnb9fJbc/HkGVaUBG32FBZBaJGfaU7ywelmSiYhd
   A==;
X-CSE-ConnectionGUID: VJDzYodIRzaiJ7Ha/TFsng==
X-CSE-MsgGUID: yN3Bctb4QBO+oBZ+NXcM/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15549746"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15549746"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 01:06:27 -0700
X-CSE-ConnectionGUID: ntyVLAjBRIKz4a3KN+HdOQ==
X-CSE-MsgGUID: UvY3X5dbQXW3H7RMiL1UGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41221785"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.85])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 01:06:23 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dongliang Mu <dzm91@hust.edu.cn>, Jonathan Corbet <corbet@lwn.net>, Alex
 Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Dongliang Mu
 <dzm91@hust.edu.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] doc-guide: add help documentation
 checktransupdate.rst
In-Reply-To: <20240615035323.909650-2-dzm91@hust.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240615035323.909650-1-dzm91@hust.edu.cn>
 <20240615035323.909650-2-dzm91@hust.edu.cn>
Date: Mon, 17 Jun 2024 11:06:19 +0300
Message-ID: <87v828gfic.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 15 Jun 2024, Dongliang Mu <dzm91@hust.edu.cn> wrote:
> This commit adds help documents - Documentation/doc-guide/checktransupdat=
e.rst
> and Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> for scripts/checktransupdate.py, including English and Chinese versions
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1->v2: fix some issues according to Randy
>  Documentation/doc-guide/checktransupdate.rst  | 63 +++++++++++++++++++
>  Documentation/doc-guide/index.rst             |  1 +
>  .../zh_CN/doc-guide/checktransupdate.rst      | 62 ++++++++++++++++++
>  .../translations/zh_CN/doc-guide/index.rst    |  1 +
>  4 files changed, 127 insertions(+)
>  create mode 100644 Documentation/doc-guide/checktransupdate.rst
>  create mode 100644 Documentation/translations/zh_CN/doc-guide/checktrans=
update.rst
>
> diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation=
/doc-guide/checktransupdate.rst
> new file mode 100644
> index 000000000000..4ece330882d6
> --- /dev/null
> +++ b/Documentation/doc-guide/checktransupdate.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Check translation update
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +This script helps track the translation status of the documentation in
> +different locales, i.e.,=C2=A0whether the documentation is up-to-date wi=
th
> +the English counterpart.
> +
> +How it works
> +------------
> +
> +It uses ``git log`` command to track the latest English commit from the
> +translation commit (order by author date) and the latest English commits
> +from HEAD. If any differences occur, the file is considered as out-of-da=
te,
> +then commits that need to be updated will be collected and reported.
> +
> +Features implemented
> +--------------------
> +
> +-  check all files in a certain locale
> +-  check a single file or a set of files
> +-  provide options to change output format
> +
> +Usage
> +-----

Why not document the argument parser and tell people ot run
'checktransupdate.py --help' here? Duplicating the usage here is just a
maintenance burden.

BR,
Jani.




> +
> +::
> +
> +   checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-co=
mmits] [--print-updated-files | --no-print-updated-files] [--debug | --no-d=
ebug] [files ...]
> +
> +Options
> +~~~~~~~
> +
> +-  ``-l``, ``--locale``: locale to check when file is not specified
> +-  ``--[no-]print-commits``: whether to print commits between origin and
> +   translation
> +-  ``--[no-]print-updated-files``: whether to print files that do no
> +   need to be updated
> +-  ``files``: files to check, if this option is specified, the locale
> +   option will be ignored.
> +
> +Samples
> +~~~~~~~
> +
> +-  ``./scripts/checktransupdate.py -l zh_CN``
> +   This will print all the files that need to be updated in the zh_CN lo=
cale.
> +-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/proc=
ess/coding-style.rst``
> +   This will only print the status of the specified file.
> +
> +Then the output is something like:
> +
> +::
> +
> +    Documentation/translations/zh_CN/process/coding-style.rst       (2 c=
ommits)
> +    commit 6813216bbdba ("Documentation: coding-style: ask function-like=
 macros to evaluate parameters")
> +    commit 185ea7676ef3 ("Documentation: coding-style: Update syntax hig=
hlighting for code-blocks")
> +
> +Features to be implemented
> +----------------------------
> +
> +- track the translation status of files that have no translation
> +- files can be a folder instead of only a file
> diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guide/=
index.rst
> index 7c7d97784626..24d058faa75c 100644
> --- a/Documentation/doc-guide/index.rst
> +++ b/Documentation/doc-guide/index.rst
> @@ -12,6 +12,7 @@ How to write kernel documentation
>     parse-headers
>     contributing
>     maintainer-profile
> +   checktransupdate
>=20=20
>  .. only::  subproject and html
>=20=20
> diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdate.=
rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> new file mode 100644
> index 000000000000..37c0bb518ab8
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/doc-guide/checktransupdate.rst
> +
> +:=E8=AF=91=E8=80=85: =E6=85=95=E5=86=AC=E4=BA=AE Dongliang Mu <dzm91@hus=
t.edu.cn>
> +
> +=E6=A3=80=E6=9F=A5=E7=BF=BB=E8=AF=91=E6=9B=B4=E6=96=B0
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E8=BF=99=E4=B8=AA=E8=84=9A=E6=9C=AC=E5=B8=AE=E5=8A=A9=E8=B7=9F=E8=B8=AA=
=E4=B8=8D=E5=90=8C=E8=AF=AD=E8=A8=80=E7=9A=84=E6=96=87=E6=A1=A3=E7=BF=BB=E8=
=AF=91=E7=8A=B6=E6=80=81=EF=BC=8C=E5=8D=B3=E6=96=87=E6=A1=A3=E6=98=AF=E5=90=
=A6=E4=B8=8E=E5=AF=B9=E5=BA=94=E7=9A=84=E8=8B=B1=E6=96=87=E7=89=88=E6=9C=AC=
=E4=BF=9D=E6=8C=81=E6=9B=B4=E6=96=B0=E3=80=82
> +
> +=E5=B7=A5=E4=BD=9C=E5=8E=9F=E7=90=86
> +------------
> +
> +=E5=AE=83=E4=BD=BF=E7=94=A8 ``git log`` =E5=91=BD=E4=BB=A4=E6=9D=A5=E8=
=B7=9F=E8=B8=AA=E7=BF=BB=E8=AF=91=E6=8F=90=E4=BA=A4=E7=9A=84=E6=9C=80=E6=96=
=B0=E8=8B=B1=E6=96=87=E6=8F=90=E4=BA=A4=EF=BC=88=E6=8C=89=E4=BD=9C=E8=80=85=
=E6=97=A5=E6=9C=9F=E6=8E=92=E5=BA=8F=EF=BC=89=E5=92=8C=E8=8B=B1=E6=96=87=E6=
=96=87=E6=A1=A3=E7=9A=84
> +=E6=9C=80=E6=96=B0=E6=8F=90=E4=BA=A4=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=89=
=E4=BB=BB=E4=BD=95=E5=B7=AE=E5=BC=82=EF=BC=8C=E5=88=99=E8=AF=A5=E6=96=87=E4=
=BB=B6=E8=A2=AB=E8=AE=A4=E4=B8=BA=E6=98=AF=E8=BF=87=E6=9C=9F=E7=9A=84=EF=BC=
=8C=E7=84=B6=E5=90=8E=E9=9C=80=E8=A6=81=E6=9B=B4=E6=96=B0=E7=9A=84=E6=8F=90=
=E4=BA=A4=E5=B0=86=E8=A2=AB=E6=94=B6=E9=9B=86=E5=B9=B6=E6=8A=A5=E5=91=8A=E3=
=80=82
> +
> +=E5=AE=9E=E7=8E=B0=E7=9A=84=E5=8A=9F=E8=83=BD
> +--------------------
> +
> +- =E6=A3=80=E6=9F=A5=E7=89=B9=E5=AE=9A=E8=AF=AD=E8=A8=80=E4=B8=AD=E7=9A=
=84=E6=89=80=E6=9C=89=E6=96=87=E4=BB=B6
> +- =E6=A3=80=E6=9F=A5=E5=8D=95=E4=B8=AA=E6=96=87=E4=BB=B6=E6=88=96=E4=B8=
=80=E7=BB=84=E6=96=87=E4=BB=B6
> +- =E6=8F=90=E4=BE=9B=E6=9B=B4=E6=94=B9=E8=BE=93=E5=87=BA=E6=A0=BC=E5=BC=
=8F=E7=9A=84=E9=80=89=E9=A1=B9
> +
> +=E7=94=A8=E6=B3=95
> +-----
> +
> +::
> +
> +   checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-co=
mmits] [--print-updated-files | --no-print-updated-files] [--debug | --no-d=
ebug] [files ...]
> +
> +=E9=80=89=E9=A1=B9
> +~~~~~~~
> +
> +-  ``-l``, ``--locale``: =E6=A3=80=E6=9F=A5=E6=8C=87=E5=AE=9A=E7=9A=84=
=E6=96=87=E4=BB=B6=E8=AF=AD=E8=A8=80=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=9C=AA=E6=
=8C=87=E5=AE=9A=E6=96=87=E4=BB=B6
> +-  ``--[no-]print-commits``: =E6=98=AF=E5=90=A6=E6=89=93=E5=8D=B0=E8=8B=
=B1=E6=96=87=E5=8E=9F=E5=A7=8B=E7=89=88=E6=9C=AC=E5=92=8C=E7=BF=BB=E8=AF=91=
=E7=89=88=E6=9C=AC=E4=B9=8B=E9=97=B4=E7=9A=84=E6=8F=90=E4=BA=A4
> +-  ``--[no-]print-updated-files``: =E6=98=AF=E5=90=A6=E6=89=93=E5=8D=B0=
=E6=97=A0=E9=9C=80=E6=9B=B4=E6=96=B0=E7=9A=84=E6=96=87=E4=BB=B6
> +-  ``files``: =E8=A6=81=E6=A3=80=E6=9F=A5=E7=9A=84=E6=96=87=E4=BB=B6=EF=
=BC=8C=E5=A6=82=E6=9E=9C=E6=8C=87=E5=AE=9A=E4=BA=86=E6=AD=A4=E9=80=89=E9=A1=
=B9=EF=BC=8C=E5=B0=86=E5=BF=BD=E7=95=A5=E8=AF=AD=E8=A8=80=E9=80=89=E9=A1=B9
> +
> +=E7=A4=BA=E4=BE=8B
> +~~~~~~~
> +
> +-  ``./scripts/checktransupdate.py -l zh_CN``
> +   =E8=BF=99=E5=B0=86=E6=89=93=E5=8D=B0 zh_CN =E8=AF=AD=E8=A8=80=E4=B8=
=AD=E9=9C=80=E8=A6=81=E6=9B=B4=E6=96=B0=E7=9A=84=E6=89=80=E6=9C=89=E6=96=87=
=E4=BB=B6=E3=80=82
> +-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/proc=
ess/coding-style.rst``
> +   =E8=BF=99=E5=B0=86=E5=8F=AA=E6=89=93=E5=8D=B0=E6=8C=87=E5=AE=9A=E6=96=
=87=E4=BB=B6=E7=9A=84=E7=8A=B6=E6=80=81=E3=80=82
> +
> +=E7=84=B6=E5=90=8E=E8=BE=93=E5=87=BA=E7=B1=BB=E4=BC=BC=E5=A6=82=E4=B8=8B=
=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=9A
> +
> +::
> +
> +    Documentation/translations/zh_CN/process/coding-style.rst       (2 c=
ommits)
> +    commit 6813216bbdba ("Documentation: coding-style: ask function-like=
 macros to evaluate parameters")
> +    commit 185ea7676ef3 ("Documentation: coding-style: Update syntax hig=
hlighting for code-blocks")
> +
> +=E5=BE=85=E5=AE=9E=E7=8E=B0=E7=9A=84=E5=8A=9F=E8=83=BD
> +-------------
> +
> +- =E8=B7=9F=E8=B8=AA=E6=B2=A1=E6=9C=89=E7=BF=BB=E8=AF=91=E8=BF=87=E7=9A=
=84=E6=96=87=E4=BB=B6=E7=9A=84=E7=BF=BB=E8=AF=91=E7=8A=B6=E6=80=81
> +- =E6=96=87=E4=BB=B6=E5=8F=82=E6=95=B0=E5=8F=AF=E4=BB=A5=E6=98=AF=E6=96=
=87=E4=BB=B6=E5=A4=B9=E8=80=8C=E4=B8=8D=E4=BB=85=E4=BB=85=E6=98=AF=E5=8D=95=
=E4=B8=AA=E6=96=87=E4=BB=B6
> diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/Docum=
entation/translations/zh_CN/doc-guide/index.rst
> index 78c2e9a1697f..0ac1fc9315ea 100644
> --- a/Documentation/translations/zh_CN/doc-guide/index.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/index.rst
> @@ -18,6 +18,7 @@
>     parse-headers
>     contributing
>     maintainer-profile
> +   checktransupdate
>=20=20
>  .. only::  subproject and html

--=20
Jani Nikula, Intel

