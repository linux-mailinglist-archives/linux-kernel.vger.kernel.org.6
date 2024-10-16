Return-Path: <linux-kernel+bounces-368853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FF19A15A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7756CB25B87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4451D433F;
	Wed, 16 Oct 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APnLeXqX"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7421D4153
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116633; cv=none; b=OO6Lnf9AFbt533f+WSnj25YfWkKtoWwah4HZFf19H9gW/CJVDrkTYxl5tnRuhoa/GJA7ebwNxEWGSi1aDFRRR/Z3SalPgDo1PWsKYnLMCOL692wop6ON3gRLgQwGm7Ok1qdTFXQtTLhOBvboL3z9R9CrvwAzJaUKZY0wJIH8cyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116633; c=relaxed/simple;
	bh=9vVA4Agfm0WSbaBtQ7P8QVyvTZdi13A+uushqRFcJ2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNVWGd268UTkjoaYmoSTg/TFzWPhkX6+hwJiVFb/drFOXWzXLAy7oDLr6FCliAloUM69upRls+P2g4yfHKxz49VxeXQVlNkHMIFV4pqZjmiTcx1GCZSMmdi+YCHplcvIJFaZVBFaX8qlBKV8baeEx2cAkVoBUQwGG4YU1NnZfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APnLeXqX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e66ba398so10012e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729116630; x=1729721430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXS/2y3cDHrS1yNVghWeZ7jeBDzAVXN+tv3JZQz7G6o=;
        b=APnLeXqXb4fREg8CQvUNjGwhTbrBVhWbVRIcuFF5xLpXzzef4agKVoMVXW1NF3bZ26
         yersV4cxWCXvfrvmUWMz6wlVT2/y59arp28r3sy+DbpiipdGme4eWxs1If111XOnKgyp
         LCqeMnodzmavpwgGMHlOqQU6nAE7EADXWR+eV6kZtg/Ks+nVSUtuI/U9zm/TSGiNsbi7
         OSYYE3lFbtBggbXp7uwgvVdCeTS/SV8PTcaadIQAqRLxK8w5AYNH7HCuwwsFzWAvKczJ
         yHd0D/FHBGfvDpY9yR3NE5vAIAEpcGOy/9RqOv8T47jEFSgOlKm3+F20840dd6mTqZPt
         mtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116630; x=1729721430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXS/2y3cDHrS1yNVghWeZ7jeBDzAVXN+tv3JZQz7G6o=;
        b=PizLB9zme5drPUB9m0zP9I+YblAEE7Bv4Tp/qJrNQO7qji3WdhzIYJ97N51ncdQoiS
         oe5FpbUxPktBcm6a9+VEMHA7ewGd5g3Pz51vNvdNK/EfMR0OPlPdX/70/rSyDrncniNk
         wgYRo2zdZBfwgqMFTvwUsOl12GFEO4mgRkeE6ZRdnH6se4OVOJ8uwuMGP7FwZoAIHk5p
         VUGZ4fdqAoBq91Rn3ybGAKHboA/ErJ974qfkbCXLT86y01Q3W/HY+S0ZiIyC4eROEQey
         pldSRQ88ipx54mryEMTN1OTZJwaoTRx9yZh/5IScuS2BPwGk0ENNetMpGLhg0UcT/4L2
         rS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFbCDYprNEUSm+jA3bA86lOa7PFf72h+hI55mdhyg49WJ8lgSp65mdMlX1jZktXiCF3Dg8B7AtIooMexA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCncPtn5iQf3vxm/fVE7q+ydbOsdkvGQ+Gj4GJEib5b4l5k9N
	QsTKR3vsRGHm4ZYKowz8cVSmqpwr3m1cxiCdxRj3tU9gql9nnwTjl3BmnZLnJfGo1tQrtcIfgkB
	m081MaJ221X5JlwTqusmhi/nN9y0MdxrmW9VW
X-Google-Smtp-Source: AGHT+IGid7az1jkIvwZA3Kt0ZPHkpN0/0Zlh1FYVlYC6ShT16mDxfQbgPQEzXVlyZjm46CayfSlmNAItLI3mX+IGBUA=
X-Received: by 2002:a05:6512:3b8c:b0:539:d0c4:5b53 with SMTP id
 2adb3069b0e04-53a0d20607emr137084e87.4.1729116629349; Wed, 16 Oct 2024
 15:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com> <202410170234.hthSWOJg-lkp@intel.com>
In-Reply-To: <202410170234.hthSWOJg-lkp@intel.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 00:09:53 +0200
Message-ID: <CAG48ez050bFWVkVJMzG8b-bCPORRoZ9g=OKYGxS9S+-rOJD6Ng@mail.gmail.com>
Subject: Re: [PATCH v2] comedi: Flush partial mappings in error case
To: kernel test robot <lkp@intel.com>
Cc: Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Frank Mori Hess <fmh6jj@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:36=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 6485cf5ea253d40d507cd71253c9568c5470cd27]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/comedi-F=
lush-partial-mappings-in-error-case/20241016-022809
> base:   6485cf5ea253d40d507cd71253c9568c5470cd27
> patch link:    https://lore.kernel.org/r/20241015-comedi-tlb-v2-1-cafb0e2=
7dd9a%40google.com
> patch subject: [PATCH v2] comedi: Flush partial mappings in error case
> config: m68k-randconfig-r071-20241016 (https://download.01.org/0day-ci/ar=
chive/20241017/202410170234.hthSWOJg-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241017/202410170234.hthSWOJg-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410170234.hthSWOJg-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/slub_kunit.o
> >> ERROR: modpost: "zap_vma_ptes" [drivers/comedi/comedi.ko] undefined!

And this one is also a nommu build, so I guess it's the same problem
as https://lore.kernel.org/r/202410170111.K30oyTWa-lkp@intel.com even
though the error is different.

