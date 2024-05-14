Return-Path: <linux-kernel+bounces-178892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892138C5927
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CFC2859D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879D17F385;
	Tue, 14 May 2024 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="BEZfi27Z"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05417EBAA
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702220; cv=none; b=e8nUa8aZ2TQGKWpRwdM31KlneP6WUIjibO3mFkncssoe7ucXKS/7dOCLX38D1xrTPMpQd2arussgea1WiaSLPRrfJlJ89HykoZQXRAiUcDbKVAgkPJX4UxJ7dT9rNWIBE4CqbyK8/y/dZ8kSPZi2uRlBIiBMDWqhCHcKalzXI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702220; c=relaxed/simple;
	bh=YA6pyQiLLslarUnTKZZJMUBTQqHbLA/4c4NUOUNEKQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3MdD6AIji2urKyz++uqhaRc/48Y49wZ/1gFZe1fir5f++sTHhCWc9vklKagpKDNAH0z6X50KWKsIhah/oOVoBOtYWQg5C9FNdbVarbB3pRgpXrdO+JeGmcGFPBGopvTzqpvuFOfZtOZCRdXAsHlzdIMEicUjzswK8vT3/0D7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=BEZfi27Z; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23f9c2f1df6so3558730fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1715702218; x=1716307018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6MGF0tcuYUW8jKv8L9+C0X+Q6Jb+20y5kn9DK3CWgc=;
        b=BEZfi27ZDNKXrOlGC6H4b2KBKrmFzURdAkcRuh/XjsLwUc1u/nlgbuHz1XLw2voJs8
         gl1DyRl9q+MqTFU8WdiJwQitgc7JBW7qOdDnrqNK+Y3drR53XdeiODHqylIMO/GizBNx
         6Qjr8mB05vCGnwWxfu6D4tUt/Za8dNP2ahsacSmufIedPFfL18JkC9Ps9DjHuEMgndZc
         DIAbaA+JjLP65q3yxB/JSy/wY1fud3CtylOUudGF0Aw00l5vlsHgxSxMD6bvVi8ANvBS
         Xwh1OMp6EcqBxbK448NnZ/7iHF6dhq1j9+03QmiyK1N9TVfl5ZXRDXgUuk1rDGxm2Thh
         TwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702218; x=1716307018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6MGF0tcuYUW8jKv8L9+C0X+Q6Jb+20y5kn9DK3CWgc=;
        b=xIt1q1FQFsbWyiBcOBE22XrFmt+FghPv4uGPuevf22IamU+UvzvFmQAY7iTBEn5XgK
         CyWaO+Eb8+RLL69GkPPm/vIVjPjhb5fMNeot/Se/CCvyi1000oMrKhgvO7tK+wml5dG/
         zRydTQo9OoATuGXrT8RtM3goeYN1htw9mZ8hwDAHn8ejgDQ1Cjo6qiDd6U1u0eG4i9Bz
         QjzDkF1AWTXf1UvgpVChWx8mS11kj1HtBLFKE6iaNJykTC/p/2DYO8VEAJROkqAathpI
         nO3J8udJ6W6b7RV3ZPEQaInLmZH1hqwDSAD1zse/0vJz2dlLR72u6XVx7hCKz+89UPul
         8oYA==
X-Forwarded-Encrypted: i=1; AJvYcCVLR3YUO3JOtm+mvLPB8l4KANJyXKQnzvg3jvg/mM7Ctrenm05De/of/p7TZ4OA8O8ItPpSUYbVgeOlO/0xdXrr4WqcYrPpgvbQ/Dop
X-Gm-Message-State: AOJu0YxGyGup1vX2LlO+GFBkwlERMMJ3YZmQ/H6WJTyAoFsQ196mC0sl
	35qkCZy1ag5Uth4xzzMNcbacGBn3jlCEfirJCdgAIAumH65CuIQbA84lxQXEwdZHebEIHqwdRDx
	jEvrgUPGEvSz/DG92tHFkrUlXP2lIstJxyWnjZA==
X-Google-Smtp-Source: AGHT+IEQ/4e3Xdlw5o+oGBoYc/qjPodJ1x+HDfCTQwbUcL2+yeysXxIOfH8cuC7q3IN5+SY5krebRZTNRqtrnD1+EdY=
X-Received: by 2002:a05:6870:9722:b0:22e:8ca0:36ba with SMTP id
 586e51a60fabf-24172bd7029mr15691437fac.22.1715702217977; Tue, 14 May 2024
 08:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514153532.3622371-1-surenb@google.com>
In-Reply-To: <20240514153532.3622371-1-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 14 May 2024 09:56:20 -0600
Message-ID: <CA+CK2bCmy1PhDgDvEX2Pg=_HvLLD2msJmTV_rgMxifbd-y1wRA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: add version into /proc/allocinfo output
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 9:35=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Add version string at the beginning of /proc/allocinfo to allow later
> format changes. Exampe output:
>
> > head /proc/allocinfo
> allocinfo - version: 1.0
>            0        0 init/main.c:1314 func:do_initcalls
>            0        0 init/do_mounts.c:353 func:mount_nodev_root
>            0        0 init/do_mounts.c:187 func:mount_root_generic
>            0        0 init/do_mounts.c:158 func:do_mount_root
>            0        0 init/initramfs.c:493 func:unpack_to_rootfs
>            0        0 init/initramfs.c:492 func:unpack_to_rootfs
>            0        0 init/initramfs.c:491 func:unpack_to_rootfs
>          512        1 arch/x86/events/rapl.c:681 func:init_rapl_pmus
>          128        1 arch/x86/events/rapl.c:571 func:rapl_cpu_online

It would be also useful to add a header line:

$ head /proc/allocinfo
allocinfo - version: 1.0
# <size> <calls> <tag>
            0        0 init/main.c:1314 func:do_initcalls
            0        0 init/do_mounts.c:353 func:mount_nodev_root
            0        0 init/do_mounts.c:187 func:mount_root_generic
            0        0 init/do_mounts.c:158 func:do_mount_root
..

This would be the same as in /proc/slabinfo:
$ sudo head /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
slabdata <active_slabs> <num_slabs> <sharedavail>
pid_3               2730   2730    192   42    2 : tunables    0    0
  0 : slabdata     65     65      0
.

Pasha

