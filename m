Return-Path: <linux-kernel+bounces-382060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF6E9B088B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152BA1F24B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB217333D;
	Fri, 25 Oct 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TpvGSdcT"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5C1531C8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870795; cv=none; b=OCzBMn22F8qD5z05LPxx3GRsp1aHg1emw46d5op/THFrjUfmKFf7lUu4ghrGnnPfTQW9uCqAJCOxfNKs6orLZ5rSP8W8ovsdNPGrmBUTklth0G/WijCK3T11BJkqTnTGt/Gcf+JIjUII0p7rIk5iL2kH0tk7s1kL7mVLt+wNEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870795; c=relaxed/simple;
	bh=rQlrpJeMlo0ujThTpOYvcpe79KLo/FclwrwMw4u04eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0PG9Q+nsxiEc6iMGgzM5dXmI7C0NRWj5KelHn7elCUuwTvSItSPWItBrH6IDG/NoRuu03Lp0JDFZq0vQ6lqIdlDGEX98pYCW1ZXza5JNNGj6sTQcVhQISlUOvN6I3MkHAprtKWzIdtZLPcqPrQTl7v3lh5UbHwSburAepKNtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TpvGSdcT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so34499391fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729870791; x=1730475591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW4PWRSrVVHGdUnyVYJbesCr/e/f0yYNSHSjjDEYDZ0=;
        b=TpvGSdcTsoSC+31gMfygNXolxGoEyz4eOFZPM8UF2POFA0xcjxvsMAKZBqvo6tNNRt
         sh9la3jEZWCh/KNkZ8vUYY51TfbcAo1lERu50Rx9uR2loP1kS9cBbbUtgKWh886hjwkA
         kotmD1XNpbZqUZNO0B8XxoBXa9n9ffXU13+dalMmPy+aKti5uvsVHWEm/H9ACenYmYVS
         4oKMkgnu2Fd3U8/hYDDWwsoA/skEOt9+jrpvg5g6zbykAm7O0UYtKzAVGRbdDEnRId7e
         PKclQRFU6/ieiqM3Nig8g30oPUpW6A/P3nqUkBIJ8xhdNJ0Ln3tos2w7doqNC2z23qgI
         Hh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870791; x=1730475591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xW4PWRSrVVHGdUnyVYJbesCr/e/f0yYNSHSjjDEYDZ0=;
        b=uCLQuVVXUI8q7licHrmLetAmCQF4NIZiXdaI0YKd1NK8gQXqXqFLuvBuIOZzCOHok6
         0ObeBAwZpV0IR/qUfI/wbfOXrol44LhJN++tSFJlF3NU9x6ZbIKiu4aQR5dbpK930Qao
         d2DKZvk3yueh236Bnvh3/wg91XKKkx6g3UaKDymi1JiQKthlKo+ugMsCJlTL+hsv2EAy
         8NS2okiRMDN6CtEW6MLImXFqdHs7RTEWwxeeFuJum5RFQHcq9bhNcQpA3NamGjSsFx8E
         N8rRu6+FuRKbJMpzqA5/25JrMmB1NWzEQoF+qZBuGP7hCvVEBEpfYlRMUA718WEzGG9q
         mMWA==
X-Forwarded-Encrypted: i=1; AJvYcCXNDL2Al3rrK23GRpacmBBX8JJTnRNrslLqWQbq0cI4iUew1rWDNLvOZlv3vdnjv9EhY82CqEwQPeOCLs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dUmY88eyxl4Jr1U/yPRtXeB5xnLWAYhWKSnoN7f0L5esN2pC
	xN/hbU3DXUTnHpiHsx36/9ryxUW5+mIDWFqEMSbKMJbXcfgSuxKjwg7JP6sNSh/YcrqinvY4xNF
	4uzrim7bduQHszBhF1kxMYXHZHov192z+x/CJKg==
X-Google-Smtp-Source: AGHT+IEVPJcpNaS8Dh7KXg2L847e2aERI9aZUfHLpTDrx377enJsjmc2WbeZ9cZnIv6gDlcIhu81wtKqRimneYbSjao=
X-Received: by 2002:a2e:b2c7:0:b0:2fb:36df:3b4 with SMTP id
 38308e7fff4ca-2fc9d37ff0emr67856561fa.34.1729870790725; Fri, 25 Oct 2024
 08:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024192758.91748-1-brgl@bgdev.pl> <202410252227.4k7pn2o5-lkp@intel.com>
In-Reply-To: <202410252227.4k7pn2o5-lkp@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 17:39:39 +0200
Message-ID: <CAMRc=MfDKzKOT0Q2zGv2AnnoRDoTQhrDXKqyj1vqWx0jABa41g@mail.gmail.com>
Subject: Re: [PATCH] gpio: relax the Kconfig dependency on OF_GPIO in drivers
To: kernel test robot <lkp@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Paul Gazzillo <paul@pgazz.com>, 
	Necip Fazil Yildiran <fazilyildiran@gmail.com>, oe-kbuild-all@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 5:08=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Bartosz,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on brgl/gpio/for-next]
> [also build test WARNING on linus/master v6.12-rc4 next-20241025]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewsk=
i/gpio-relax-the-Kconfig-dependency-on-OF_GPIO-in-drivers/20241025-032925
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gp=
io/for-next
> patch link:    https://lore.kernel.org/r/20241024192758.91748-1-brgl%40bg=
dev.pl
> patch subject: [PATCH] gpio: relax the Kconfig dependency on OF_GPIO in d=
rivers
> config: i386-kismet-CONFIG_GPIO_SYSCON-CONFIG_GPIO_SAMA5D2_PIOBU-0-0 (htt=
ps://download.01.org/0day-ci/archive/20241025/202410252227.4k7pn2o5-lkp@int=
el.com/config)
> reproduce: (https://download.01.org/0day-ci/archive/20241025/202410252227=
.4k7pn2o5-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410252227.4k7pn2o5-lkp=
@intel.com/
>
> kismet warnings: (new ones prefixed by >>)
> >> kismet: WARNING: unmet direct dependencies detected for GPIO_SYSCON wh=
en selected by GPIO_SAMA5D2_PIOBU
>    WARNING: unmet direct dependencies detected for GPIO_SYSCON
>      Depends on [n]: GPIOLIB [=3Dy] && HAS_IOMEM [=3Dy] && MFD_SYSCON [=
=3Dy] && OF [=3Dn]
>      Selected by [y]:
>      - GPIO_SAMA5D2_PIOBU [=3Dy] && GPIOLIB [=3Dy] && HAS_IOMEM [=3Dy] &&=
 MFD_SYSCON [=3Dy] && (ARCH_AT91 || COMPILE_TEST [=3Dy])
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Eh, OF_GPIO pulls in the OF and HAS_IOMEM dependency so his must be
done on a driver-by-driver basis.

Let's drop this for now.

Bartosz

