Return-Path: <linux-kernel+bounces-254415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950279332F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70721C22775
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F471A01DC;
	Tue, 16 Jul 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbwdMmEY"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FF3B784
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161777; cv=none; b=P4ii2z923szKU52NPuvdw/rX4Z1WCPFpC3fp9fJtXvDeeSssBDd3J53FolhGiXXTzqSaG3hoYUaeyj1g2yYLy4LubfwTpz/sICZMz6C6qEyVfGH+Snvb85y9cJW0L2ZuOBTV6vAFOdDRRFeOfNQvXDY5szXYI6R77XDzNZGOiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161777; c=relaxed/simple;
	bh=Yhuhmc5ref3VmS6JXOcfK0IohaRteaXk3J4z1O4kN40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tpp05UnHXmhhZIPpRDf7pbma0/v0kgpdX/PQxz/8LadpgktO7/5iMoFoGUdBYelewzEjPzzu6f55hL9UxKzBmm6DIVLJBS94DNMcEJIhsDmdyFJFJU7muV0WKBZIzv7sGq73ekFpRTUocpea2u0HbDHdU60eLDMvNGDVK1I2D7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbwdMmEY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so1191355a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721161773; x=1721766573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bbPj/PZFGIDhT7c0ujDQ6E8Mz16O/2FBR9KQusTsgDg=;
        b=nbwdMmEY0NTg9IWIkgVAwywUnPLwvHAtByVr0aLQW+TAEgNyqHoykQjVREcD71cBdj
         Rd0jY5SU0ju5pq+R9z6vazIw2WknZttGVwaBMfssCVLsIC5pbdJsdVJO1qw3Eky/3Kmx
         OjApGc7C1oIyjZvzYrQFMf13+N5C188Vqu4pNOKVqcx8nCIestQ23aFs3XSo9n1JXEsl
         rxyqMxTt4mJq1sJs4FhrOlpwcumjSoIRwYERrMAYHEbtIBIEjl3xbKEOagrxKmjIQ0mc
         DE1aQpzAcVBONd/Z7zXSUqXmvlhaLWASlIYd8XKnhF+I+DjF8Ioury8ibnMFbIJf8/Yf
         vEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721161773; x=1721766573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbPj/PZFGIDhT7c0ujDQ6E8Mz16O/2FBR9KQusTsgDg=;
        b=KKsB8OmxKAU1YSB8tQTAr1c/tSO3uXgWFSP2CTlutELWZRYpNZg5B+FQJYHJ7dkn6A
         IIqSwYKVxL/0u3jhYBIkkcwMOWlJkddCYQIcTIw2X+gMyvOSUY8v8i7nv8G9m8C3AM0N
         L5cRv/giH0K4LECuHalQVl2ctV2Y5L9Zmm/A2sYnp5SX0wbFuvvkYjmLPS5sSQHzYewD
         1IIJsKhrTXKDGuoP7b2LyGOkK/ljSeHcTWR3uIPe2H/YgfreGDxDKDzr/ra8X36uUugM
         BzD3FiCqquJULbwNHQHk9RpocV2EOQo6tOgV2h0jVYBDvtx8lK4dVnJTKYcOL2+GkfpP
         qKqg==
X-Forwarded-Encrypted: i=1; AJvYcCWlsAk1YpxJ/teMZFHwooU886wW38CreSEjMSpYiG/MzFoZwxyrYYc6ZM3U79anfKWnGX1HNNoeN4HxruCF08j6oFxtqjlvOck+6bJv
X-Gm-Message-State: AOJu0YxjVjzgIyEhbcBmaRkQxnhKENAwHRnEoyIY4/Bp1PBSRB63jv6j
	4DGi26BTfpGXIxmAEL70zN1TvS24IPyqmZd1//b3UmrP1l7SBPaX8WthLhh7NUdG1dg9qAVqE9+
	E6Od9eJmFh267mE0ahw0fVkSr4cAHndwxzhUU7Q==
X-Google-Smtp-Source: AGHT+IF+ga++87qZIL9GesqchqNJ7nMQoknpRRE8QlgGw72R1Ft17dXna2B9Rqo1YtNOnhci3c7g/FHe4x02at6YBzY=
X-Received: by 2002:a50:a696:0:b0:58d:b529:7dc3 with SMTP id
 4fb4d7f45d1cf-59eef45b5e4mr1989963a12.19.1721161773520; Tue, 16 Jul 2024
 13:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152746.516194097@linuxfoundation.org> <aaccd8cc-2bfe-4b2e-b690-be50540f9965@gmail.com>
 <ZpbDlwpfBwViDonu@duo.ucw.cz>
In-Reply-To: <ZpbDlwpfBwViDonu@duo.ucw.cz>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 01:59:21 +0530
Message-ID: <CA+G9fYtosFR2O3A+bgYKV4q+13dWdfqGFqmB+NVu3Qfdfa3Ghg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/96] 6.1.100-rc1 review
To: Pavel Machek <pavel@denx.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, jonathanh@nvidia.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 00:31, Pavel Machek <pavel@denx.de> wrote:
>
> On Tue 2024-07-16 11:42:39, Florian Fainelli wrote:
> > On 7/16/24 08:31, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.100 release.
> > > There are 96 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.100-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
>
> > Commit acbfb53f772f96fdffb3fba2fa16eed4ad7ba0d2 ("cifs: avoid dup prefix
> > path in dfs_get_automount_devname()") causes the following build failure on
> > bmips_stb_defconfig:
> >
> > In file included from ./include/linux/build_bug.h:5,
> >                  from ./include/linux/container_of.h:5,
> >                  from ./include/linux/list.h:5,
> >                  from ./include/linux/module.h:12,
> >                  from fs/smb/client/cifsfs.c:13:
> > fs/smb/client/cifsproto.h: In function 'dfs_get_automount_devname':
> > fs/smb/client/cifsproto.h:74:22: error: 'struct TCP_Server_Info' has no
> > member named 'origin_fullpath'
> >   if (unlikely(!server->origin_fullpath))
>
>
> We see same problem.

Same problem as others have already reported on the
arm, parisc and powerpc.
+
The old s390 build failures which were reported from
the previous stable-rc 6.1 release.

* arm, build
  - clang-18-nhk8815_defconfig
  - clang-18-s3c2410_defconfig
  - clang-nightly-nhk8815_defconfig
  - clang-nightly-s3c2410_defconfig
  - gcc-13-nhk8815_defconfig
  - gcc-13-s3c2410_defconfig
  - gcc-8-nhk8815_defconfig

* parisc, build
  - gcc-11-defconfig

* powerpc, build
  - clang-18-defconfig
  - clang-18-ppc64e_defconfig
  - clang-nightly-defconfig
  - clang-nightly-ppc64e_defconfig
  - gcc-13-defconfig
  - gcc-13-ppc64e_defconfig
  - gcc-8-defconfig
  - gcc-8-ppc64e_defconfig

and

* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org

