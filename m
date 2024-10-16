Return-Path: <linux-kernel+bounces-368844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9319A1591
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F6A282344
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350BD1D278B;
	Wed, 16 Oct 2024 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMLc4Iyg"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7518732A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116346; cv=none; b=sxutZ5lECYVNnsLgdsC90HcNFwdoNc0XvsQTHxWvCeAi3xcjf5h4Mn74CRnJUFIX445ajoBbN3bZvrxKQBS9z7A6WSBCS0sW16qt6Xz7wpxXtu07Su1xLUuDHNqCIUmocVCin0hEd4X7XHXQLq/Rk0GM5i/UuKIQ3nUDenmZ1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116346; c=relaxed/simple;
	bh=yaHkrgyzxpqCXu/uo343VjqBZzEv+dPomLknhyVwq/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRRC8iuTm0pDIHs2/oHqqPUo7CuO8hQdpi5zudpPvq0B5KTTf/L9KVCNoywGjZpcniGKPBG55Bz0plcIL6gVc4O0biKOEI29b9+vQhI0aCMRQ2Qv1Z5GIOtn2YINFka4O04/hxswo2o6TdMLSg1C4O7mZ5y9f48bq3QGCQ9vegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMLc4Iyg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so9993a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729116343; x=1729721143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF2hnyZnur4FAKXfn/pZIiJIZnA1uCI/DSTuBMf9wzw=;
        b=MMLc4Iyg3bgS0k1/BdsqJ8ME2QLkHQKe6BKlrVObmM1auBDJHeQT6Fp5RK/klTSqFs
         fsXgPKJRHDaq5Ma6apZCMG6872PNcBWgkLQZG7somQjEu8zKcLeVNkH9vutwmdqUmdO0
         Knpocd7g6LuZOjkhvRP3dndiscGu0pIpRA6XO0AYhw7XX+loCYiOjK7sq6HqT6DOmyKm
         6f6+VZwwZIuBVifrwnISbCEL1oNPO24MkLW9yNG8HzeTC4ru28jrKY46hmyYI/MjnzmH
         5RaY0pt5IXfvFgRfAEOkY/TAIdRjiCWvYTG7UyxauqpA5j+sIkFlcYSH6TkSs0ytYZ1L
         Mr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116343; x=1729721143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF2hnyZnur4FAKXfn/pZIiJIZnA1uCI/DSTuBMf9wzw=;
        b=SCHot6nIEcEO6Lqg0JPbqChxd0vngBuJOGDbKvLb0xOKUU80kkZAjYYX6ZKq4VogqM
         v7kAHXH4ccj1sUeUi9Z3PLfDSE+cQVlLYCXY1kfVFou5fq21GKL3Y3II70zUjB10E29o
         QvULmF6q5TGH76OijYd22xLnnxu24bJ8uE6cHMREerkpEL8r4NrOTIxIS8gbyr1QKVO7
         EIIy2PCU4SOw71JaeYz37c7vMtbcRpj4h40QP5LT5bd992Im1CSdGqTmwMbq8rXjnsjm
         XPNYisL4DMFBm+630eSQ20Z0eqovtjDYv3uB81NmDS8S68/NWS/0SmzV4R9z74Oe4Gi1
         4DJw==
X-Forwarded-Encrypted: i=1; AJvYcCXK37GrKAMYUa55nm42FKoDFZUrKDL5uZoDhRiZn9iRtLI0ThNWDmIiRob/D91Ffz1ysvd+Pgfb/lYvopE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPmnr5MG8fftgk/Te6SanwbjnoaOFZHIBDTk4YyBc421feQc6
	Ysj7mAYnswy7i5V6DRRJ+Jrbu0gi0fG/ekfLOTx4q+mo8BA9v5Dl8f3R7sbxCC/D6slQPZn+JD/
	X38QMPMIuhoQVlec8jhDF8pviGxvEMNKkMS09ptI1/yGPpnAzG/Vg
X-Google-Smtp-Source: AGHT+IGWQlAeC6qRe3pdoM5AfU64wh8xVIi8TV2ZZ0HmaHRYqEs3AU7jnrQDT6YQ/IkPj8v31ncDQjs3jK8USoOl9Ho=
X-Received: by 2002:a05:6402:5107:b0:5c5:c44d:484e with SMTP id
 4fb4d7f45d1cf-5c9ebb55cf8mr64042a12.1.1729116342627; Wed, 16 Oct 2024
 15:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com> <202410170111.K30oyTWa-lkp@intel.com>
In-Reply-To: <202410170111.K30oyTWa-lkp@intel.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 00:05:04 +0200
Message-ID: <CAG48ez2T7i_qCAcGi3nZqQeT8A3x42YSdL=rWqXOUDy5Eyaf6A@mail.gmail.com>
Subject: Re: [PATCH v2] comedi: Flush partial mappings in error case
To: kernel test robot <lkp@intel.com>, Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Frank Mori Hess <fmh6jj@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:05=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
> [auto build test ERROR on 6485cf5ea253d40d507cd71253c9568c5470cd27]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/comedi-F=
lush-partial-mappings-in-error-case/20241016-022809
> base:   6485cf5ea253d40d507cd71253c9568c5470cd27
> patch link:    https://lore.kernel.org/r/20241015-comedi-tlb-v2-1-cafb0e2=
7dd9a%40google.com
> patch subject: [PATCH v2] comedi: Flush partial mappings in error case
> config: arm-randconfig-004-20241016 (https://download.01.org/0day-ci/arch=
ive/20241017/202410170111.K30oyTWa-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241017/202410170111.K30oyTWa-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410170111.K30oyTWa-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    arm-linux-gnueabi-ld: drivers/comedi/comedi_fops.o: in function `comed=
i_mmap':
> >> comedi_fops.c:(.text+0x4be): undefined reference to `zap_vma_ptes'

Ugh, this one is from a nommu build ("# CONFIG_MMU is not set"), it
makes sense that you can't zap PTEs when you don't have any PTEs at
all... what really impresses me about this is that the rest of the
code compiles on nommu. I'm pretty sure this codepath wouldn't
actually _work_ on nommu, but apparently compiling it works?

I don't know what the right fix is here - should the entire comedi
driver be gated on CONFIG_MMU, or only a subset of the mmap handler,
or something else?

