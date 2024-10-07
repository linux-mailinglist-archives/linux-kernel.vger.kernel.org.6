Return-Path: <linux-kernel+bounces-353814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92383993309
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE0D284298
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD511DA628;
	Mon,  7 Oct 2024 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdQir4PS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555271DA2E5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318238; cv=none; b=bF/L6ECON6u7qQllS/5owEYBUjQEAq8kPomddk10vP0cmNV0bcqXWvrilKhBLmC4DAgL8XpWO+d4PmlqY6MXAZd4jR65JII7gOco0IVfCYGMORIvW9iyYws8sssyIJ+x46o/v3ciDcnfyq+3XZuiGV3hqJm/uSiAtz3OXFXzsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318238; c=relaxed/simple;
	bh=CSBFQS88igW0jUCGuwCmGf0rpqBIDOAPpzkbjoA0v2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgHnabnAbSVwie2beZu9u3NBnohvA/B2iW0z84Jv1hshKbtY/j0rxgqNpnR44dfjHm6C5mEmTM4EhbdFef4Y2r0nNlJbInRx002tbgmiBt+y6Qlt5PlInyFaDiD9eyJx7upBbplRM5JNF5jmyEOMr0bRWptH464h4dmHJB+pkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdQir4PS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9943897c07so291306766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728318236; x=1728923036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DjhLFwVBpKRr9Z2MwbXlQuaVUI2IN6bC3xXF+EK/4g=;
        b=gdQir4PSIlQmXatDIhHUxDQOLSbD7cD8T4CL1ABZCzy3eb5DRksM0qlVjU1vkyUYt9
         q5/J/WHlnPAzWxQp1r/bZrwA/WW14ZK9eslJVI0U1swETkfQt5n9RTdb/tx9+XeZRcVu
         IkX4VT+IKWDe6n3PyWzUCJTxmM7Vx5X+xdRp0Dp5XunSAjxdqCNzk1frplXtrucThtJ/
         8Yw4kG95j7Z6kIkDrX6U728HkLitFDIax4nOnuNk0q2To7ibNZ0MX1NF8EnGYtqbckB3
         3oVwc72KhoSXveftUxwkPviFfq/QYJFgptZL2fCdQYsq/qa762JfyrA3ZbTH6jCCn7tU
         2oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318236; x=1728923036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DjhLFwVBpKRr9Z2MwbXlQuaVUI2IN6bC3xXF+EK/4g=;
        b=jX3wZ1ATsdfRLJ88oc8nzxpxfLkXWdAJvVJNArr4dzatLAoKZg7avqNqvdxcYHNOon
         Tp9Hqj0BmcCxLlIVGv4OcNVSd0BmPr8jdCRiI9HZCSQcuMeGGxidzP9wjCpefg2e6HfX
         P3d3/d3jM+SOhL8pyw7jmS2ijIZYGDxkVXoiKQh81MkreCX9aRPuZAX1+SEtxJCs3rff
         /yehbt1J6xbUZVS1TDZvCrqmnwKwY78Adkh3pUbDWU6H6zKgIpB8RJqJhvJhsriDK/FY
         tmV68f65NlcQwtEIx/VCfJ1nfE88DnCIqB4SZRQQXt5ja2O936eIxlSooc7CXq3MkKj4
         4JkA==
X-Forwarded-Encrypted: i=1; AJvYcCUMCqAd1gfVqN0Yt47pOkThde5v5ayBrsdCdYrJOSLCNcTcfYI2zcg7HSQIGe5ZZRd0xK1QGgVXpTf75R0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LK3Javau5zEYxh400HUbvq7FXpHjsmjGTIfIUjAUCDqVkoEB
	XlDp/8wpmuwxMpG/zQAaZivsqiB5EswazGUAkGFoD2XYueXCKaABmdbgqD8IlvLHngs5gsQ3jeJ
	LFCS9cl5Z6v+pKgu58XMC042gFTQ=
X-Google-Smtp-Source: AGHT+IEhWSRFZqVhC3rbl0UHvbwLLLlpn38m/GYhWm2qL50BAg4U+z5JzqqQw152dm0AYm6pv3+IQ51UGtTJYfZ34DY=
X-Received: by 2002:a17:907:a0d:b0:a8b:ddf4:4701 with SMTP id
 a640c23a62f3a-a991bd47985mr1349645766b.16.1728318235289; Mon, 07 Oct 2024
 09:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003120655.53663-1-vamsikrishna.brahmajosyula@gmail.com> <202410060802.Ln9ygpuY-lkp@intel.com>
In-Reply-To: <202410060802.Ln9ygpuY-lkp@intel.com>
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
Date: Mon, 7 Oct 2024 21:53:43 +0530
Message-ID: <CAJvTgAg-8RYjo9Rapor86G5o10aTws7B1NmZVuN64KRy5kjzWg@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm: set gamma_lut or degamma_lut based on HW in setcmap_atomic
To: kernel test robot <lkp@intel.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, oe-kbuild-all@lists.linux.dev, 
	skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 6:31=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Vamsi,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 7ec462100ef9142344ddbf86f2c3008b97acddbe]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Vamsi-Krishna-Brah=
majosyula/gpu-drm-set-gamma_lut-or-degamma_lut-based-on-HW-in-setcmap_atomi=
c/20241003-200835
> base:   7ec462100ef9142344ddbf86f2c3008b97acddbe
> patch link:    https://lore.kernel.org/r/20241003120655.53663-1-vamsikris=
hna.brahmajosyula%40gmail.com
> patch subject: [PATCH] gpu/drm: set gamma_lut or degamma_lut based on HW =
in setcmap_atomic
> config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241006=
/202410060802.Ln9ygpuY-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241006/202410060802.Ln9ygpuY-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410060802.Ln9ygpuY-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
Based on the kernel bot compile failure I received,
> >> ERROR: modpost: "drm_mode_obj_find_prop_id" [drivers/gpu/drm/drm_kms_h=
elper.ko] undefined!
I realised I can not use drm_mode_obj_find_prop_id in setcmap_atomic
(in atomic context).
I am exploring atomic functions which access gamma_lut and degamma_lut
via state.
I will send a v2 with a new approach.
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

