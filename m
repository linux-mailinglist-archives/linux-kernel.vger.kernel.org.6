Return-Path: <linux-kernel+bounces-198049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB9A8D72CC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6781C20BF1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C7E4CDF9;
	Sat,  1 Jun 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAs/xrb/"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1E47A48
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717285280; cv=none; b=nmoK6he4AvfHIUwLiM+6zqf/KDn4cgYKJQvfRYSJS8cjebc8xz0GB7rLWUM2Okhn9Zs+eOCin725CDYpj3cwLCs2QYzNb8RUe+O16f0DnWUEBIaj0UgZHcI8Wi1DD2ZVSYBU7uY5unewSjGMuoamreyC4ATa+B3Uo683I0sl7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717285280; c=relaxed/simple;
	bh=FmvqevEnqgVG3f18m0kOVP2Uxy2zchTMI7AloT2hyhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNA1AzBhahryY9ZefvQrc1r8d5cImQsuGZg6j5GzhDkVPg/+Sq3Afrp71qcZOzBlUf2JWZ9SNFywABXovHLZ5sTSm1ldxMONACsuhs38cHhZpYXfkCj6FXpE8AjyNzvR2afNmCtvwTCvgexI5yABrGVXv4NrENb8lDRb47q1lFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAs/xrb/; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfa48f505a3so3275926276.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717285278; x=1717890078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4FOUlc5EDq/I7DD/WiBWLN5W19MKLu5xl8To+MXnS0=;
        b=HAs/xrb/i2mGjXunUzuKBHfJWDSJcFRj8HnFqSA6duJS47p4KZGH51a/PGJ+FLD7YV
         8bMjasbWZxVXkyvTHoUGnnCdj6bOpY6UQqJ8oSYWC9bH6NlTyo+saF2n75loW6N152g+
         g2qVne4R9RaNTDfq2xNLaUGwa9uStYrftftNg8lWGCmzPl6EB1ztChupnQsY1km7rZ76
         bf/UZqaDu5yyZKOnaZdxrR4SDMOIs2muR2KyWjGzf0fi4bR0XQhPz/XNAx+armZ1Ndyb
         pB5yRsT4bI0gi1MCWL8b8YzT+4x99wNXWrsPvdpUJoxH5PjdHdl2HRWzZcK4bBIVX2ku
         E5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717285278; x=1717890078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4FOUlc5EDq/I7DD/WiBWLN5W19MKLu5xl8To+MXnS0=;
        b=aIK3CmwNMOQ4aBrGfAK1IBGF/nITmtnCk6fUJWedEAnUcYuh5mbE7chdFHrV45JDj/
         epaz0znKvDywY0fxMtCP9xWvScb30WwQEzzM0Bxp9dnJphnSw8KbDEP6UnjJzUoewHM2
         0lfF8H4KcCRVZ+RfgD5+B3Y3KaPGaNbOLEZ+DpCQlR3MSSc2GMe+M8kMIJ22TFBSnp1N
         8x6dhTKruLFFIVokwTfaawO4njvf2u7adIC0b4Y+z89yM+FeH5Ti6CPXDqyoUAR4Os7D
         Y65VKNXDLrV600OnREyE8l3W4ErDP5dJZrF3s4tfQf7OtfRdyWv2rKYhSUn6Ph+lQOhR
         aI5A==
X-Forwarded-Encrypted: i=1; AJvYcCXA17py2LJ/3/2xBQLHNQokHvv+Z/Eb+NVa2KMlKc3tqauFAYXkCOqMVhnvaVaeheaPOsxGaGWB+JCWJbOYN+J1W3gMgehcAcC9TRR0
X-Gm-Message-State: AOJu0YzcUXq6a/kQnEmJl2SVjPkMvnUf+g2yXBLnoQXYlu0qoEkOUxdz
	sYrml/nGSCDuhnVnh4MbqHbztUdPSHva1rklVOF7LD2ydvao9EqpyLENcotU5BXbRTaPkbrLNAE
	rxr53ljSBbkYUUCVhD3ek9w8iTVpCPINO2XA6
X-Google-Smtp-Source: AGHT+IGoJGrV89s6wgpWQzLAiysiCfFoPAHgS9BdWTDh4qzRR4oPAXSK/QX/xarY7MY0WiL5wbkjQVluVFnWtAem6Lw=
X-Received: by 2002:a25:b1a4:0:b0:dfa:47cf:d293 with SMTP id
 3f1490d57ef6-dfa73dbc2e9mr5287912276.40.1717285277431; Sat, 01 Jun 2024
 16:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405280616.wcOGWJEj-lkp@intel.com>
In-Reply-To: <202405280616.wcOGWJEj-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 1 Jun 2024 16:41:05 -0700
Message-ID: <CAJuCfpF=55_2j8oECernpWq9GXV09RjHexLS7+k4YjaOeO1=Vg@mail.gmail.com>
Subject: Re: ld.lld: error: undefined symbol: proc_do_static_key
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 3:23=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> commit: 8d469d0bee74d3f2d02f0b232933a3f084d9cbf7 lib: introduce early boo=
t parameter to avoid page_ext memory overhead
> date:   5 weeks ago
> config: arm64-randconfig-002-20240528 (https://download.01.org/0day-ci/ar=
chive/20240528/202405280616.wcOGWJEj-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfd=
cc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240528/202405280616.wcOGWJEj-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405280616.wcOGWJEj-lkp=
@intel.com/

Fix is posted at
https://lore.kernel.org/all/20240601233831.617124-1-surenb@google.com/

>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: proc_do_static_key
>    >>> referenced by alloc_tag.c
>    >>>               lib/alloc_tag.o:(memory_allocation_profiling_sysctls=
) in archive vmlinux.a
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

