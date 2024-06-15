Return-Path: <linux-kernel+bounces-216037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F84909A53
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 01:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9012835D3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002F961FE3;
	Sat, 15 Jun 2024 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yv1YQCKZ"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C217557
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718492745; cv=none; b=ul97w66RE3ryU8eQve+EnAqK8hdetWJvGsvhd55jyjMfmct80q8+68SW4N9nCl3Z1VXlLPHirpoaYe2sqmaZEl6HMjW+PORGWYeds0WG0FCy5JDLPbG6uLGmJshSwAK0Rr5NY1/t42sYcdR2P0s6Wj3bcx3Lifo2kgF+aTQyEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718492745; c=relaxed/simple;
	bh=QKrZTLS38ZU/BTlcPICCum807Vg+aTf07TYtcmhDAO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTu6JTLgfwpOnlvzp3/BNjXPxiYoscuUQ9JT5lXlw90VnRnFjOmGzmW4P4ozbdsGUrk9Ja34u5yRmAK7VvnNC/VSwQbmt8lf6HOb+nIg9JdlOlpRQ2jtVwFkEAY3a4yPX2CzELVJPWr+FCYyafcCR4SE7dO9sJFH4DX3QBQQQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yv1YQCKZ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eb82f68af9so10345239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718492741; x=1719097541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2onuRdrViA9m1L4/D6JT6FGROPDNZ8pqtZf6T04znYo=;
        b=Yv1YQCKZkDD7a2A2PhRi+eHATprX+TZ0gv2TuU+FGW+0FhMXYLI4gvL9wijWy1W6gX
         Z/JnmJIlzcCpKKKCfmHP7QpOX13c0d7ayEErNhClaCHejTtn8UcucW5bolSGlRm29EDJ
         /W+Pkchz/wJ1XxiislaVEaLwc8TBEU/W9sOwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718492741; x=1719097541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2onuRdrViA9m1L4/D6JT6FGROPDNZ8pqtZf6T04znYo=;
        b=usSmIG1xJIYMYtbHiHcvcLvjjZB6qdF/nKvSQ45XUznmICxgToGvemOni/sqpuezlq
         RTmGIdxclu6YWf0JG75Woa7G+RGPEdIv9aGiE9PUB4i5ViYqQh99FiKLpQZYpbc0Lmjf
         ks/I9j+NKogEjy0WwVP/ykjntSjQrBlKLa1qiKYZH+ouigKd3AKNNrXQ7RkvOjuk686s
         6gpYzsZVqNFr95CbfGqtFM9cxQFo293H527NUN3/p06PP07Yq7beKXgwYTL/iFRrZTjI
         PMJyLsVejQJk+xEId3+GCKNgoy2vMvTR5EMpKMTaOsACZZ4+J8T8GJjFXouj+hf4QMh0
         LT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd8Jvy8xeG+SiLsI3dD5TF4qG3u7rh+a16FJoJ2DlQ2MSIwv7eXDYW4pQPvi4fFopfLhMkhLli8Nqbq4o8DUZ+lxudKwLBZtciAqQl
X-Gm-Message-State: AOJu0Yy7p9wuoO7Kh3+EtvxWc1f5moQTdFTzsdVfNzUv+27+WP+YWCmY
	oi6arYz7t3zMqkk9Z2oHDF3zupZcYDPMJiCHKj1Dv4oo30PKos2GribMj1VAqaGpTcxb/0Z/mav
	P
X-Google-Smtp-Source: AGHT+IF0NshMiJmDfeuqJLmRkzSxWF1MaRX4H/SICu5H1olxgSjOYPGnbrg0z8gqGI/3/5Qae7H2SA==
X-Received: by 2002:a5e:dc48:0:b0:7eb:6a6e:c830 with SMTP id ca18e2360f4ac-7ebeb627c7cmr647710439f.2.1718492741306;
        Sat, 15 Jun 2024 16:05:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9572e7f1bsm1750432173.126.2024.06.15.16.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 16:05:40 -0700 (PDT)
Message-ID: <2ac9b1a3-fd42-48fc-b1c8-4c1986536ef9@linuxfoundation.org>
Date: Sat, 15 Jun 2024 17:05:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Improve cpupower build process description
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240615125617.180521-1-romeusmeister@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240615125617.180521-1-romeusmeister@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/24 06:56, Roman Storozhenko wrote:
> Enhance cpupower build process description with the information on
> building and installing the utility to the user defined directories
> as well as with the information on the way of running the utility from
> the custom defined installation directory.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> V1 -> V2:
>   - Improved commit description
>   - Make changed line lenghts 75 chars
>   - Refactored the description
>   - Link v1: https://lore.kernel.org/linux-pm/20240613-fix-cpupower-doc-v1-1-9dcdee263af1@gmail.com/
> ---
>   tools/power/cpupower/README | 160 +++++++++++++++++++++++++++++++++---
>   1 file changed, 150 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
> index 1c68f47663b2..2678ed81d311 100644
> --- a/tools/power/cpupower/README
> +++ b/tools/power/cpupower/README
> @@ -22,16 +22,156 @@ interfaces [depending on configuration, see below].
>   compilation and installation
>   ----------------------------
>   
> -make
> -su
> -make install
> -
> -should suffice on most systems. It builds libcpupower to put in
> -/usr/lib; cpupower, cpufreq-bench_plot.sh to put in /usr/bin; and
> -cpufreq-bench to put in /usr/sbin. If you want to set up the paths
> -differently and/or want to configure the package to your specific
> -needs, you need to open "Makefile" with an editor of your choice and
> -edit the block marked CONFIGURATION.
> +There are 2 output directories - one for the build output and another for
> +the installation of the build results, that is the utility, library,
> +man pages, etc...
> +
> +default directory
> +-----------------
> +
> +In the case of default directory, build and install process requires no
> +additional parameters:
> +
> +build
> +-----
> +
> +$ make
> +
> +The output directory for the 'make' command is the current directory and
> +its subdirs in the kernel tree:
> +tools/power/cpupower
> +
> +install
> +-------
> +
> +$ sudo make install
> +
> +'make install' command puts targets to default system dirs:
> +
> +-----------------------------------------------------------------------
> +| Installing file        |               System dir                   |
> +-----------------------------------------------------------------------
> +| libcpupower            | /usr/lib                                   |
> +-----------------------------------------------------------------------
> +| cpupower               | /usr/bin                                   |
> +-----------------------------------------------------------------------
> +| cpufreq-bench_plot.sh  | /usr/bin                                   |
> +-----------------------------------------------------------------------
> +| man pages              | /usr/man                                   |
> +-----------------------------------------------------------------------
> +
> +To put it in other words it makes build results available system-wide,
> +enabling any user to simply start using it without any additional steps
> +
> +custom directory
> +----------------
> +
> +There are 2 make's command-line variables 'O' and 'DESTDIR' that setup
> +appropriate dirs:
> +'O' - build directory
> +'DESTDIR' - installation directory. This variable could also be setup in
> +the 'CONFIGURATION' block of the "Makefile"
> +
> +build
> +-----
> +
> +$ make O=<your_custom_build_catalog>
> +
> +Example:
> +$ make O=/home/hedin/prj/cpupower/build
> +
> +install
> +-------
> +
> +$ make O=<your_custom_build_catalog> DESTDIR=<your_custom_install_catalog>
> +
> +Example:
> +$ make O=/home/hedin/prj/cpupower/build DESTDIR=/home/hedin/prj/cpupower \
> +> install
> +
> +Notice that both variables 'O' and 'DESTDIR' have been provided. The reason
> +is that the build results are saved in the custom output dir defined by 'O'
> +variable. So, this dir is the source for the installation step. If only
> +'DESTDIR' were provided then the 'install' target would assume that the
> +build directory is the current one, build everything there and install
> +from the current dir.
> +
> +The files will be installed to the following dirs:
> +
> +-----------------------------------------------------------------------
> +| Installing file        |               System dir                   |
> +-----------------------------------------------------------------------
> +| libcpupower            | ${DESTDIR}/usr/lib                         |
> +-----------------------------------------------------------------------
> +| cpupower               | ${DESTDIR}/usr/bin                         |
> +-----------------------------------------------------------------------
> +| cpufreq-bench_plot.sh  | ${DESTDIR}/usr/bin                         |
> +-----------------------------------------------------------------------
> +| man pages              | ${DESTDIR}/usr/man                         |
> +-----------------------------------------------------------------------
> +
> +If you look at the table for the default 'make' output dirs you will
> +notice that the only difference with the non-default case is the
> +${DESTDIR} prefix. So, the structure of the output dirs remains the same
> +regardles of the root output directory.
> +
> +
> +clean and uninstall
> +-------------------
> +
> +'clean' target is intended for cleanup the build catalog from build results
> +'uninstall' target is intended for removing installed files from the
> +installation directory
> +
> +default directory
> +-----------------
> +
> +This case is a straightforward one:
> +$ make clean
> +$ make uninstall
> +
> +custom directory
> +----------------
> +
> +Use 'O' command line variable to remove previously built files from the
> +build dir:
> +$ make O=<your_custom_build_catalog> clean
> +
> +Example:
> +$ make O=/home/hedin/prj/cpupower/build clean
> +
> +Use 'DESTDIR' command line variable to uninstall previously installed files
> +from the given dir:
> +$ make DESTDIR=<your_custom_install_catalog>
> +
> +Example:
> +make DESTDIR=/home/hedin/prj/cpupower uninstall
> +
> +
> +running the tool
> +----------------
> +
> +default directory
> +-----------------
> +
> +$ sudo cpupower
> +
> +custom directory
> +----------------
> +
> +When it comes to run the utility from the custom build catalog things
> +become a little bit complicated as 'just run' approach doesn't work.
> +Assuming that the current dir is '<your_custom_install_catalog>/usr',
> +issuing the following command:
> +
> +$ sudo ./bin/cpupower
> +will produce the following error output:
> +./bin/cpupower: error while loading shared libraries: libcpupower.so.1:
> +cannot open shared object file: No such file or directory
> +
> +The issue is that binary cannot find the 'libcpupower' library. So, we
> +shall point to the lib dir:
> +sudo LD_LIBRARY_PATH=lib64/ ./bin/cpupower
>   
>   
>   THANKS

This "THANKS" doesn't belong in the patch.

thanks,
-- Shuah


