Return-Path: <linux-kernel+bounces-235105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409AF91D034
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3E22819D6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD7D3A1BF;
	Sun, 30 Jun 2024 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OgvTQ+88"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C83E467
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719730403; cv=none; b=K4IRvozza/vX7cNu9rUfPtTCd0Hwa3VaxIg1/RVeFpSF+Q7t69yG7Y1mvkwUaYvZWhkEyN6WZUzLdolrAaX+dAFLvNWz1gpNgITXMtL/PuCD//ovG7tB5WBpEzowBXM6DWbnLPoRncqeoMQQtHWEQg631CIz2kL4JD4jKqWg3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719730403; c=relaxed/simple;
	bh=92Fr2FI0hzTIr3j6+QoFA8EzGb3LeRI2MHqAshn6kcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UxgJrxPFagcsjhWoTaCrngZ8Ytqv1PGRc5ewxGVnizctZgmpdD8K6mDb/Hw1k8/OvG++p1BAe5j3J/LDZSOVIPM5QBnRNX7BAqGxnlkfi2J3fQJkwNU64Xx/KmtYnKh8F80g4FovRgxaygod9iJGGuVoZ8oW5NVhdP6iGvw8tLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OgvTQ+88; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52d259dbe3cso2083568e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719730398; x=1720335198; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ew4KWJgmKbpOxqo+GQy5qo/brhj1D5g+M8tiJYpqXX8=;
        b=OgvTQ+88fFeaCfXlI8EFoQuCKPhtVYqHFlcvmQJvvBq+j1LbNhl+l8+KBAFtaZQ1fU
         SyySRibUemRUuSyYhWN2xwdlWuXbNJMCGa5mQu4JJE2mBH2LezKFnMi4VBPeoLSHQ6bW
         aREPZ7EptC/50NiwJzADOJ74JhwXBUzTgVceypJLRD7T4IySH3g32YnEsXbQmxaMvcm/
         kgleX4cAkHCzCScVh6GaFDS50LiWGfBlj5hHc/v144GqmQzIi/iBCiyEhst2cMufJf3w
         0CIlqw31L4cvIPJzaEdJJ5kbAtYlZpCRztVAaJ/cMaL8DBY5L1baDcCcYITd5xE15dFs
         cNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719730398; x=1720335198;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ew4KWJgmKbpOxqo+GQy5qo/brhj1D5g+M8tiJYpqXX8=;
        b=YofUZ0YQAID069rWujNCY6EhmLnQjpp0uQXYA5h8JgFLRNxJb62GwU0Gykz+8ImtVq
         N35OOhpBGjP8Jcd4pSpslnuEXDpZl2YtHPDUhfaiMOT07LXmi0yD5eSHxPA9IPim7TCc
         nIralG+Z08lSeF2XvgHPDiWw85l0WwFDelmETRoVFYkri2d881d2CGO3iNGJFEGa5SWq
         AlxHYBpwD4q1ZvD+ycWNYXKVPY+SWnN7mj5P6jt/OIk/AA6VZq86LTj8ouYAq0UXgWkU
         8H877r2daBUqT4Qluv4JIshiJ4Xilwg4NQujM4mDuLO4V/L/ANTKyAirVNM0UCt3IJ2w
         t9hA==
X-Forwarded-Encrypted: i=1; AJvYcCUJbsSRnOBfJ84VnZdN3nnIlIsEs84a6UYbTzWIk+Jou/n1wDJIp3O9EQHpCRylS61/HIq613fKhz2ckriHNMWw65XoBDCSdxOzA0QE
X-Gm-Message-State: AOJu0YwVOffkTG0YDgpiiIhRO3jCOH/5+rJ5lrz5MIyvvELGS/v1U7SI
	qnwSKChnbkxtlCrLgPBz0y1R83Y5zPS8egCMYGLSwEaS17+9MKmJQ7CiLlACSpY=
X-Google-Smtp-Source: AGHT+IEnzCb0ZjEgk4HVemu0D2vV5LVoJK9bnWbsrBx3BpfdiC+g0YptGg0s/NfloHGeam0Y9qPU0w==
X-Received: by 2002:a05:6512:4014:b0:52c:b479:902d with SMTP id 2adb3069b0e04-52e82643b97mr2093475e87.4.1719730397113;
        Sat, 29 Jun 2024 23:53:17 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:51e2:ba1a:8ad5:52c9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a073sm100168595e9.32.2024.06.29.23.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 23:53:16 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: kernel test robot <lkp@intel.com>
Cc: Mark Brown <broonie@kernel.org>,  Liam Girdwood <lgirdwood@gmail.com>,
  Takashi Iwai <tiwai@suse.com>,  Jaroslav Kysela <perex@perex.cz>,
  oe-kbuild-all@lists.linux.dev,  alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
In-Reply-To: <202406300718.iL828kaG-lkp@intel.com> (kernel test robot's
	message of "Sun, 30 Jun 2024 07:29:29 +0800")
References: <20240628122429.2018059-2-jbrunet@baylibre.com>
	<202406300718.iL828kaG-lkp@intel.com>
Date: Sun, 30 Jun 2024 08:53:15 +0200
Message-ID: <1j1q4ej50k.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun 30 Jun 2024 at 07:29, kernel test robot <lkp@intel.com> wrote:

> Hi Jerome,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on tiwai-sound/for-next]
> [also build test ERROR on tiwai-sound/for-linus broonie-sound/for-next linus/master v6.10-rc5 next-20240628]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jerome-Brunet/ALSA-pcm-add-support-for-128kHz-sample-rate/20240629-201915
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
> patch link:    https://lore.kernel.org/r/20240628122429.2018059-2-jbrunet%40baylibre.com
> patch subject: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
> config: i386-buildonly-randconfig-004-20240630
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build):
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406300718.iL828kaG-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> sound/usb/caiaq/audio.c:179:2: error: #error "Change this table"
>     #error "Change this table"
>      ^~~~~
>
>
> vim +179 sound/usb/caiaq/audio.c
>
> 523f1dce37434a sound/usb/caiaq/caiaq-audio.c Daniel Mack 2007-03-26  176  
> 523f1dce37434a sound/usb/caiaq/caiaq-audio.c Daniel Mack 2007-03-26  177  /* this should probably go upstream */
> 523f1dce37434a sound/usb/caiaq/caiaq-audio.c Daniel Mack 2007-03-26  178  #if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
> 523f1dce37434a sound/usb/caiaq/caiaq-audio.c Daniel Mack 2007-03-26 @179  #error "Change this table"
> 523f1dce37434a sound/usb/caiaq/caiaq-audio.c Daniel Mack 2007-03-26  180  #endif
> 523f1dce37434a sound/usb/caiaq/caiaq-audio.c Daniel Mack 2007-03-26  181  

This file is not in mainline or
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
branch ... Don't know what to make of this error ?

-- 
Jerome

