Return-Path: <linux-kernel+bounces-445859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFDC9F1C77
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 04:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA2188D79D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F03F27442;
	Sat, 14 Dec 2024 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGis6y9U"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07762182BC;
	Sat, 14 Dec 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734148323; cv=none; b=Ee3s7EgQOlwYfmor/kfhC1hEtrVXvzlanfmW5xEi05097a3SQteyBpdYliZdmZprWElUfU+7OBJj4/J0MpjETjOpZI9JKa3+02qM20NjIdjO2jUNFjLU+JeWdXwO1DEoiKroogCMi3Gr8m5yFPr5Mcq6yi5JmrbqG9PWINMDuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734148323; c=relaxed/simple;
	bh=/BiVx2nmtFZgMA4/TFa0UeUE7KEymOIAVuY9/mXXnug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTWwZHC5Dulz3IGZ0RWg1SDBmjztr8p3zQF1z4yY8/nKYivcPB6DWkgjOit1UYht8PboGFxxhfSr+j5UIrkTZmvre1di4W+uytqnppUds1ab6fCR/YjLE3xe4CrxWznEc0w/9P7cjs1+yCaP9r1mXqFypu+msE0AdXjHsMcQwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGis6y9U; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so1636529a91.0;
        Fri, 13 Dec 2024 19:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734148321; x=1734753121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPNynSCWfcxJE+tFD90CFOksMSN61UntARTnPwKwziQ=;
        b=VGis6y9Up+H1nrLbJwzcTgB6+SJ3/iZUIiQK7BZsDUAxCke5NlUw4d6JiPAF0oxL5O
         g+vQex4isoEqluIWs5yc9zV+MY48WotCTO7kcYaxSSsp0HTC7/yarj8IAvrR3vp6wdx+
         mHJSgZ+o+jAO9qCyaYdMvVXEePgV5eaqhjuEWvsFk/Q/T0ZTN9iMMMuptdDW2Saky33Y
         Vqk+lkd8NLJjqP8+LEXXQz0s41RyOjF28p/fC25xCNcYR3yWxiFHZHwALgsO9P5LINpD
         TpW5d+aji+y/hDloxnQoEP8emloML4txRuP8EoS5FK4wWjjgRpNNTiFK+RIL9aZqmgL9
         AmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734148321; x=1734753121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPNynSCWfcxJE+tFD90CFOksMSN61UntARTnPwKwziQ=;
        b=ta//xjx0716jBwzFfyA0oW50s2TirJjn0JCiRGpBqjkuyH1r2ADxm1yDn68rEPf2h1
         JxZYur8MrejdH5dUJEIrhf8S/UbK4G7+UhNPMcTCxF4S+fq1JTXuUfQellGm9B4zBuPz
         6MbyY2+5biXy6tpxQeA+Z4eUOizXWSXPuS7wKDt+MMA3XKfaD96q1Tmk81/V0GsN6e9n
         8DCXC4QO0YXGwRYpqS+egXfFAcDQqCeX4EiQccEvzt/KR8GilhNtI31lyIRMiw9b8zEz
         AFTd7LVMZ2VZP9UAnoM62YglbGegc/zR1sPLwFZbkxbFfQEXvs1mrhJfRgMC+Kk337fs
         iFTg==
X-Forwarded-Encrypted: i=1; AJvYcCVw5Tx4ZlQECjWifN45cndr0RUHJppCgrWDnBDMHwjC3VXbf2X9U/U7Anb+1hnvm55x8oH0oNRO5XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjY5wbsw+767H3dJK0G8K9lxnWk43TDmBshWXM+6rH7PWm0vkk
	PlAWP3t0r6Mw7Oc8g8nqCwlq+7pKubm/58RM55WT9qOz6E2CeWBT
X-Gm-Gg: ASbGnct4S1uHC8Q0TxKD1VnjrTNFHvfTPIC20e1iC5jGzR+ZGu/qxq32vFxbVio6E1m
	WM/H3IFXIpEB4t1UDpMmzholXJ9OA+4X54X5tqd8olNkGsMeTYm3awZfg9IiV3O02QH1+OgwnSU
	mW1aiAxIJZN7ZEJi31ue7bMTCBYBxrF6wAoM8OwtmncOnCb9uc3hp9fQHvx9isR/nGjDBY4VChm
	Cj61q7HSlClIgHPGOwkaAPzbk8kB/RSKUc8wIV/8DybLarC6jepjZMf
X-Google-Smtp-Source: AGHT+IEIS2h9mq0zQIHtiu0UL//IaTi8j1HNmv7WBRJ/AQWp0xJ0s5GjvQkpvq+ExLXwhGCFlUycdQ==
X-Received: by 2002:a17:90b:2652:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-2f28fd6f7d2mr8832784a91.17.1734148321195;
        Fri, 13 Dec 2024 19:52:01 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1ebba00sm639528a91.26.2024.12.13.19.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 19:52:00 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 710B641F5559; Sat, 14 Dec 2024 10:51:52 +0700 (WIB)
Date: Sat, 14 Dec 2024 10:51:52 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] docs: admin-guide: bring some order to the
 "everything else" section
Message-ID: <Z10A2FG2IqgkNsoj@archie.me>
References: <20241213182057.343527-1-corbet@lwn.net>
 <20241213182057.343527-4-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6hgDdnIlmSA4ZPFr"
Content-Disposition: inline
In-Reply-To: <20241213182057.343527-4-corbet@lwn.net>


--6hgDdnIlmSA4ZPFr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 11:20:54AM -0700, Jonathan Corbet wrote:
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-gu=
ide/index.rst
> index 6864b079b391..c8af32a8f800 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -18,18 +18,41 @@ etc.
>     :maxdepth: 1
> =20
>     README
> -   kernel-parameters
>     devices
> -   sysctl/index
> =20
>     features
> =20
> -This section describes CPU vulnerabilities and their mitigations.
> +A big part of the kernel's administrative interface is the /proc and sys=
fs
> +virtual filesystems; these documents describe how to interact with tem
                                                                     "them"
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   sysfs-rules
> +   sysctl/index
> +   cputopology
> +   abi
> +
> +Security-related documentation:
> =20
>  .. toctree::
>     :maxdepth: 1
> =20
>     hw-vuln/index
> +   LSM/index
> +   perf-security
> +
> +Booting the kernel
> +------------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   bootconfig
> +   kernel-parameters
> +   efi-stub
> +   initrd
> +
> =20
>  Tracking down and identifying problems
>  --------------------------------------
> @@ -53,104 +76,120 @@ problems and bugs in particular.
>     kdump/index
>     perf/index
>     pstore-blk
> +   clearing-warn-once
> +   kernel-per-CPU-kthreads
> +   lockup-watchdogs
> +   RAS/index
> +   sysrq
> +
> =20
> -sysfs
> ------
> +Core-kernel subsystems
> +----------------------
> =20
> -A big part of the kernel's administrative interface is the sysfs virtual
> -filesystem; these documents describe how to interact with sysfs.
> +These documents describe core-kernel administration interfaces that are
> +likely to be of interest on almost any system.
> =20
>  .. toctree::
>     :maxdepth: 1
> =20
> -   sysfs-rules
> -   abi
> -
> -Workload analysis
> ------------------
> +   cgroup-v2
> +   cgroup-v1/index
> +   cpu-load
> +   mm/index
> +   module-signing
> +   namespaces/index
> +   numastat
> +   pm/index
> +   syscall-user-dispatch
> =20
> -This is the beginning of a section with information of interest to
> -application developers and system integrators doing analysis of the
> -Linux kernel for safety critical applications. Documents supporting
> -analysis of kernel interactions with applications, and key kernel
> -subsystems expectations will be found here.
> +Support for non-native binary formats.  Note that some of these
> +documents are ... old ...
> =20
>  .. toctree::
>     :maxdepth: 1
> =20
> -   workload-tracing
> +   binfmt-misc
> +   java
> +   mono
> =20
> -Everything else
> ----------------
> =20
> -The rest of this manual consists of various unordered guides on how to
> -configure specific aspects of kernel behavior to your liking.
> +Block-layer and filesystem administration
> +-----------------------------------------
> =20
>  .. toctree::
>     :maxdepth: 1
> =20
> -   acpi/index
> -   aoe/index
> -   auxdisplay/index
>     bcache
>     binderfs
> -   binfmt-misc
>     blockdev/index
> -   bootconfig
> -   braille-console
> -   btmrvl
> -   cgroup-v1/index
> -   cgroup-v2
>     cifs/index
> -   clearing-warn-once
> -   cpu-load
> -   cputopology
> -   dell_rbu
>     device-mapper/index
> -   edid
> -   efi-stub
>     ext4
>     filesystem-monitoring
>     nfs/index
> -   gpio/index
> -   highuid
> -   hw_random
> -   initrd
>     iostats
> -   java
>     jfs
> -   kernel-per-CPU-kthreads
> +   md
> +   ufs
> +   xfs
> +
> +Device-specific guides
> +----------------------
> +
> +How to configure your hardware within your Linux system.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   acpi/index
> +   aoe/index
> +   auxdisplay/index
> +   braille-console
> +   btmrvl
> +   dell_rbu
> +   edid
> +   gpio/index
> +   hw_random
>     laptops/index
>     lcd-panel-cgram
> -   ldm
> -   lockup-watchdogs
> -   LSM/index
> -   md
>     media/index
> -   mm/index
> -   module-signing
> -   mono
> -   namespaces/index
> -   numastat
> +   nvme-multipath
>     parport
> -   perf-security
> -   pm/index
>     pnp
>     rapidio
> -   RAS/index
>     rtc
>     serial-console
>     svga
> -   syscall-user-dispatch
> -   sysrq
>     thermal/index
>     thunderbolt
> -   ufs
> -   unicode
>     vga-softcursor
>     video-output
> -   xfs
> -   nvme-multipath
> +
> +Workload analysis
> +-----------------
> +
> +This is the beginning of a section with information of interest to
> +application developers and system integrators doing analysis of the
> +Linux kernel for safety critical applications. Documents supporting
> +analysis of kernel interactions with applications, and key kernel
> +subsystems expectations will be found here.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   workload-tracing
> +
> +Everything else
> +---------------
> +
> +A few hard-to-categorize and generally obsolete documents.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   highuid
> +   ldm
> +   unicode
> =20
>  .. only::  subproject and html
> =20

The rest looks good.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--6hgDdnIlmSA4ZPFr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ10A2AAKCRD2uYlJVVFO
o7ZGAP45yFq5thJrQ6+J11T14sA5OuIgRW58Cw33tAOvuky1vQD/RCtAGyGPTEG7
e5IA3yZMymGrKGKPCArRRujCn99o5ws=
=VHAX
-----END PGP SIGNATURE-----

--6hgDdnIlmSA4ZPFr--

