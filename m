Return-Path: <linux-kernel+bounces-290983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986F3955BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1AC1C211C6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6011754B;
	Sun, 18 Aug 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3QcC2Ls"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4814F90
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723967173; cv=none; b=oMFUEDjfuiENSM5Vzy1f7I9lWA1vEeAk++ZYUumpMl3IxjPzwAXVeSOlLepJnE+QJsxYHPv7UWcL8JlUeQeDN+7imfgCPnrQzIKelqwptks4ol/0wnIfk7sxSlQNLa85TDyiHtW8sdNNAHiQZrme0wqdRyekeWiw/eOmaMQYNV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723967173; c=relaxed/simple;
	bh=W/Lm7KrDHEh0rrSBSpmWLY0Vn7+mnzELkdlqyf2K8Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlqX+tbCU5h9J5Ua6kYbBXBqkeEvPRBJ8vpwg++7UaqDcZPBq4J0M9r+3RMdWSX1EuEgtVL4BAcVQ9+QJ6Jxy3IdwAHNJ4lLwNQ0ilUxhQEAa6gd0wFbqAIb0R7Ixmh9O4zCezdgh6yKB77ezCqpXKkhsaj4lBkXJOpKpSctJ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3QcC2Ls; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-493e8ef36b4so1259929137.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723967171; x=1724571971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAvjJXjZn/M1UFHTVDjEXTa7UKeEb5l9wox/vLEuT9k=;
        b=a3QcC2LsMQ1hd93RTJPiS9hSNuiSlHGRA+t4N+wsJLzwHoMHt4EktppBsKYCBikNrZ
         Sdp0Fc2ECb2BFj7FEMUqalSi7H1usbWqh0Bo6v3HT4LnvzCvmgSm8mMSVmYz7Wfg1ZF3
         7tsQCe9xmkdYSVHTJV3dgPoTARcBmPDJIVF92s0s0hX9gXH1WnT3iOlQaIgfW1oynMyE
         I0HOJA6oRknOvnFzPEJWq0PUh1s+7j4/IGU5Qrk1avcIf7xU6PIW/y43ECZA6vF7G9Ir
         px9/oLsqL4sFc4AB4PaY2cIpGwTWB5XyMUI0mDfmpFwCk9Q1xTiaKyDlRAdjTP5PxNtv
         NgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723967171; x=1724571971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAvjJXjZn/M1UFHTVDjEXTa7UKeEb5l9wox/vLEuT9k=;
        b=D2FGNPD7nAcORrmTXz5z/3AN1lxHlKkAi6PEN9Ig0Rpglo2HrcdgTJYWEXkPo3Ba0T
         OnrcERno9fZyTcK3AdCMSvzmpZ/chwmO1mjJLT1ZYmNyOOxfF388rA0BzXgOTvclTDeo
         pxPtelYFN7qOcuHFF8UCOUpHD7xdj5C1sbPA1/2DKCM4cktqWv9SnCLzF2DXr0QiayoP
         RnTq+PAWQ6fMmAjIALZKxt+F1WIzEiizMbNPLi77ZePwGKekRKIN3jel7M3+LnRaO+/o
         T3q9bRVPiWJaA3dlQ83a29HadX5R6QkQDiAeLxR8Tu5IZjv16Yemld3nT01hYaw+4oFH
         XCYw==
X-Forwarded-Encrypted: i=1; AJvYcCVbcW2O4bNzY6m5sEqQbmlyduYfgXW5wGrFkOneI0PHDfOyIsWZM6cYmtsfzZ2EVfKUeCa2JIAJs6OH8+GSaoiK5qUvockgk6xxE6+6
X-Gm-Message-State: AOJu0YwB6PO71m1G0twEyT8pL7VWXxRAWOqwBDTos7YQ57jM9fMiNlAs
	7onaU8mwHQHVg6X48CeIHgO8T/++gFWBznHkqjrpoi6En3JhrX3ND8vgpdzd8eLAFr6yLoyuoFL
	t3hTob0d2zwECfDhASJ3HwhqiMwA=
X-Google-Smtp-Source: AGHT+IEKL4gMV3p0eKY4nYvTpM8TFYfkrNVFvtZvOsrm4kDB/YSfYSjZJMAPikLTM43m8TmeDSsf7cL+f5RZDwa2ZCc=
X-Received: by 2002:a05:6102:370d:b0:494:560b:6c07 with SMTP id
 ada2fe7eead31-497798fa046mr9382717137.16.1723967171177; Sun, 18 Aug 2024
 00:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817050921.18462-5-kanchana.p.sridhar@intel.com> <202408180729.M6uZh634-lkp@intel.com>
In-Reply-To: <202408180729.M6uZh634-lkp@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 18 Aug 2024 19:46:00 +1200
Message-ID: <CAGsJ_4ye5f9Jecr4tH0hNwQAbCytDM99S9t=DCNK1G3-aa22-w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP stats.
To: kernel test robot <lkp@intel.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	nphamcs@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	akpm@linux-foundation.org, oe-kbuild-all@lists.linux.dev, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 12:04=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Kanchana,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 7c626ce4bae1ac14f60076d00eafe71af30450ba]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kanchana-P-Sridhar=
/mm-zswap-zswap_is_folio_same_filled-takes-an-index-in-the-folio/20240817-1=
31053
> base:   7c626ce4bae1ac14f60076d00eafe71af30450ba
> patch link:    https://lore.kernel.org/r/20240817050921.18462-5-kanchana.=
p.sridhar%40intel.com
> patch subject: [PATCH v3 4/4] mm: swap: Count successful mTHP ZSWAP store=
s in sysfs mTHP stats.
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/2024081=
8/202408180729.M6uZh634-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240818/202408180729.M6uZh634-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408180729.M6uZh634-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    mm/page_io.c: In function 'count_mthp_zswpout_vm_event':
> >> mm/page_io.c:178:17: error: implicit declaration of function 'count_mt=
hp_stat' [-Werror=3Dimplicit-function-declaration]
>      178 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_=
ZSWPOUT);
>          |                 ^~~~~~~~~~~~~~~
> >> mm/page_io.c:178:53: error: 'MTHP_STAT_ZSWPOUT' undeclared (first use =
in this function)
>      178 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_=
ZSWPOUT);
>          |                                                     ^~~~~~~~~~=
~~~~~~~
>    mm/page_io.c:178:53: note: each undeclared identifier is reported only=
 once for each function it appears in
>    cc1: some warnings being treated as errors

i believe this has been fixed by Ryan's latest cleanup
https://lore.kernel.org/all/20240808111849.651867-2-ryan.roberts@arm.com/

Kanchana, is your code on top of mm-unstable?

>
>
> vim +/count_mthp_stat +178 mm/page_io.c
>
>    174
>    175  static inline void count_mthp_zswpout_vm_event(struct folio *foli=
o)
>    176  {
>    177          if (IS_ENABLED(CONFIG_THP_SWAP))
>  > 178                  count_mthp_stat(folio_order(folio), MTHP_STAT_ZSW=
POUT);
>    179  }
>    180
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

