Return-Path: <linux-kernel+bounces-250730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58FF92FBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A9F1F23717
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5913171677;
	Fri, 12 Jul 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0805MYh"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB58171657
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792698; cv=none; b=G56yWCgEWLCdcifwInRkzwzQkziXEKSXvZx58jAKESb+HuOc7unUvMxks0KzrOdKV23yjrAeggXFfzbO7ICVW95r1rPovQWeohhRYNjbiB4gzCNzOtwVyYg/TIf/nalszBK74ADIT60o5W1ky5VuxAJptBzlQxcufzO+S/bsVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792698; c=relaxed/simple;
	bh=b6dnjmu5Un6BaihZYwhsVjWgYHYNPIaQ3XZE4PzSCTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbfjHas4+++HoW0yWZe6Gf9XMHEDmEPjz4muTiGaCeL9ocxeJ64IFUQRCR2DWVhR1TNkEClAc/f/5TJ2KWj3hdQGhOCX6HyDJEveffNh6VKCH5j6vqDUnIPn9yVMYVsu2PZrAzYZSaL00vZHhXwyjo4PF/J1+kadyJUMtnu5KDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E0805MYh; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c47ad9967cso1063107eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720792695; x=1721397495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAcXE+wc7QWairZz7uXKkhgYgUCoU38OEuEQx+dCRCw=;
        b=E0805MYhaRlpYslA/dNHCakxYtySIoCGGjK7Gu00uZvmQuXm+JQ2nIMyrxtw/WoQPG
         vaEL5AULKbX5J3XIlZ3wCJicm3vg7TmELUb4XGpJnHO/UQZIAJpsUDYK7C+7UEn3/BUX
         ENK8NXG6Ka7RObIj7AdqHQbv7cq8Kp0u36vDvbAEzJsfQ0Phhl/Gx5LVD6VDATjNu5Vu
         bvipDJ3nDsdDYkncwLK0CzzAFADYVZ95KPFu7AmM8XqHzn0GeOTRLuGn5WpkaeUHGzTQ
         e5KA4v2/4gnIt1Ai57nRXgKGsLKJNxJ5y+BtDvLor6OHoTEewiq008LHuZwhbwCX+mKS
         utnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720792695; x=1721397495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAcXE+wc7QWairZz7uXKkhgYgUCoU38OEuEQx+dCRCw=;
        b=B05pqNDVx4JLBy8X6LRrdU2F4uhy8QWH2z+XVL6YOREt+UuNU2SXrLPRKXxEr1/C/R
         KMYMKbGn0xMwxsXJi2KVimaJJQkr/K2uWq8Vfo1gG2snfhJ49EcePo96hTb2FmynMTzf
         VCymoplJJKLOKPaFZ/uCeouEVOKgMrVhYDj5Kd/pC+PtaVgV7ViUyFgQb+zA0MBMyiiV
         vkiFf53Wu1UI56Kv9ER5/dQKSysRlhXY7UjRDx8pi9dea9COJZNothcb7UQYKr8y0AkR
         qmGyjjD9Rz0FMCSq/m+pZKKLPUUAtjOv7/MJfIbaGgWDvFJhmcPRfsqVRQp2Q06zQI+s
         jmmg==
X-Forwarded-Encrypted: i=1; AJvYcCX94IbwkZEXshqTkT8ajcFxXxgFinMk5aDQ9X48iYKVaUHsx3j4GGrTXIcvVDdNu196bmTLnUAzXIs3cEyhh2DP/rQwIwhJ3MQFkwze
X-Gm-Message-State: AOJu0YwAPFTF1XLphaqZK82P7BgKPNHaf+XQaR2ktID3b5oogNqhLPxL
	xCK5pLSTQth9FXhyftsslUeVoJwK095mDZiDwYqQFrp6G/FlHAvrPXF3tEYppvs=
X-Google-Smtp-Source: AGHT+IH+Qfww+/ZstMAIBoDDATVHZnf4rg7cXRA8cOA6yKWm44pWlxf+b36T0xd3Qr7tRoC0SBzCQw==
X-Received: by 2002:a05:6820:2686:b0:5cc:a794:9ea7 with SMTP id 006d021491bc7-5ccde7cbbdamr2594439eaf.7.1720792695556;
        Fri, 12 Jul 2024 06:58:15 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c7b2fbd78csm745281eaf.24.2024.07.12.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:58:15 -0700 (PDT)
Date: Fri, 12 Jul 2024 08:58:08 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: next: arm64: defconfig: gcc-8:
 drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound
 statement
Message-ID: <b833c93e-ae8f-449f-b7bd-8d315aa52703@suswa.mountain>
References: <CA+G9fYuCp7Q71_o74yo9ge_5-G=Ho9bC3kJdX_JvtoqWOQujkA@mail.gmail.com>
 <CAMRc=Md5zmFxXXM89LQs6dspC0xnp_6=z=+a2SQypWjwpiRgow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Md5zmFxXXM89LQs6dspC0xnp_6=z=+a2SQypWjwpiRgow@mail.gmail.com>

On Fri, Jul 12, 2024 at 03:34:19AM -0500, Bartosz Golaszewski wrote:
> On Thu, 11 Jul 2024 16:34:35 +0200, Naresh Kamboju
> <naresh.kamboju@linaro.org> said:
> > The arm64 defconfig gcc-8 build failed [1] due to these warnings / errors on the
> > Linux next-20230711 tag. But the gcc-13 builds pass.
> >
> > LKFT is testing older toolchain support till gcc-8.
> >
> > The following recent changes cause this failure.
> > a887c8dede8e1 Bluetooth: hci_qca: schedule a devm action for disabling the clock
> >
> > Build errors with gcc-8:
> > -----------
> > drivers/bluetooth/hci_qca.c: In function 'qca_serdev_remove':
> > drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound statement
> >   default:
> >   ^~~~~~~
> > make[5]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o]
> > Error 1a887c8dede8e1 Bluetooth: hci_qca: schedule a devm action for
> > disabling the clock
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build data:
> > ------
> >   * Build name: gcc-8-defconfig
> >   * git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   * git_sha: f477dd6eede3ecedc8963478571d99ec3bf3f762
> >   * git_short_log: f477dd6eede3 ("Add linux-next specific files for 20240711")
> >   * Config: defconfig
> >   * arch: arm64
> >   * toolchain: gcc-8
> >
> > Steps to reproduce:
> > -------
> > # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> > --kconfig defconfig
> >
> > Build log links,
> > ---------------
> >  [1] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j5nr85T4iLl99RjcJ9oy9O3eo2/
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> >
> >
> 
> The actual code looks like this now:
> 
> 	case QCA_WCN7850:
> 		if (power->vregs_on)
> 			qca_power_shutdown(&qcadev->serdev_hu);
> 		break;
> 	default:
> 
> What can be done to silence this warning? Or should we just ignore it because
> it's gcc 8?

Just add a break statement.

	default:
+		break;
	}

regards,
dan carpenter


