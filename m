Return-Path: <linux-kernel+bounces-249573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A99092ED77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA699285DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D116D4F1;
	Thu, 11 Jul 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2Q1jkqJ"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48716D4E7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717768; cv=none; b=OE4x5SSSuEU1Dmzpn1gJZaZkmXiuPHMazfJte8qEfMYhnRscge0TNnWDzTcgU9GR3hTnuA5fjOLl1pWVHVlkJvQgpEP3VpZ6FumGM+49dcWmUGqJw06typ0DScT7mj0ldUyQKgvtCnUHSWWeBsBQGpyKtscMvnBzkEf2VpyV8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717768; c=relaxed/simple;
	bh=C3F9jB3kZe372d/2FqZSOc9k/pEeRRtlSpwAdrHy+RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfVtzT9aU+Cd8DBuoh7dy7E073KdOjZfVtymErv9UIKI763sp/wCG7LEwl/2/siG+QZv7uU3wXTWNV1hNAGsJFju+KkB8N3W2qsrgNa8Lyr+Fb8p+D83lGepnJXRFsYApKDTydvsLXwuX5NzS+byX71rMe1c45fSh6wiU/PDoj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2Q1jkqJ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e03a6196223so1114868276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720717764; x=1721322564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT4Q0fDnQo1b1rbWAFdQTaPbqeR+6myjThNugn0g5s4=;
        b=b2Q1jkqJkdrBKBoPlQpg1AvpEWUqpYJbM9G5sE/t56Xesvk5d4XYp1DhVcuXjlcZjG
         lGUcC1WGRtn4v2pQshjeHSdz2P1HT/UjPKndBfiQRrpI3uDr41XkyYdX2bxg77HHEI3Q
         82HYJ3OJb+LaQy5oX4CM9gNP5Xll6PmfYJvKPhqFUeuI+pziLZL78GmNrk3U1+Mxlt5W
         OkczD52qpVo4K6l9PNvIR4S02INIY2I6Z30R+Fh0rZij67dgrvzIqlE8wgCk0CDqiFKm
         gS0ugE84PpCJVHfJD/U3ghI+r3zrv5O4lEoA9pPZ8fb4c3C59wL5yaNknKTa6oJtMQIJ
         +0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720717764; x=1721322564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT4Q0fDnQo1b1rbWAFdQTaPbqeR+6myjThNugn0g5s4=;
        b=dLMrUJbtP8PNNX711f/QhRvdkaygO7tR6HchHH5V4HCXKt1AO/p2JUnFQpcf7nJl0y
         5DIcJzUkNdfQx1pzSgqPgxQyyZLmeOeXmNtDvuR0VPXSfVgOoDRKG2aNgcg/FIyo5gYU
         wgiG5uv5clbIaCK824tp4azvljr46wFNQPZDIpRo9iLisaEnQNVORp6TQrlYXACqddi9
         /7/JPKsVQQ7Bd6Nr/3VE//OEedD8Q6IqjHVM1hzeev8aiTPCHKzlsp8Bl2/WaWoy6VKg
         zoYPEjvD74XrRduO9pMo71yVJ8gKKpLxGA+/7O5VMoCl/P3iEAGfbnL0P3gZJKtGNnND
         iq3A==
X-Forwarded-Encrypted: i=1; AJvYcCVtNdgw1IHiRibzrVxGfMcK64IFYWPUCbplWCYIaUHO7ulzPePuSsfKkFJAzVA5II7Me3X8CEzjREBfxjI+0g8vZEL0eEGMQbibF9mc
X-Gm-Message-State: AOJu0Ywzq3tGQXodsBXz6073wZVO6eNX63S08qdyLiLH+473eoIeJhk5
	4ogklXXlQhsfmx9pHBGTcWrlxjhYVfEvNcaWKm60a1ViRNKAwatHr5qAM2fZZzeGIIYUYndCcs+
	/gvfvamP7McI3Ot6MuwLFhU5gYnCWq7Tm/jzM
X-Google-Smtp-Source: AGHT+IFhB7a+a8BufuhlkTWktjp2U5ed8yphy1GsV9RSCnMPrnocZGbTiFQNSoEMqZd7f6XE4G2m/LQxA5D5a5Q+8sc=
X-Received: by 2002:a5b:b0b:0:b0:e03:ae1c:8d0f with SMTP id
 3f1490d57ef6-e041b17328fmr10346582276.59.1720717764206; Thu, 11 Jul 2024
 10:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407050845.zNONqauD-lkp@intel.com>
In-Reply-To: <202407050845.zNONqauD-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jul 2024 10:09:13 -0700
Message-ID: <CAJuCfpEwNE5tsm+iZTzZc-hdR5sBXAKd57tOGum67_fAu2Gi3A@mail.gmail.com>
Subject: Re: mm/slub.c:2077:1: error: unused function 'prepare_slab_obj_exts_hook'
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 5:35=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   661e504db04c6b7278737ee3a9116738536b4ed4
> commit: b4601d096aac8ed26afa88ef8b249975b0530ca1 mm/slab: fix 'variable o=
bj_exts set but not used' warning
> date:   10 days ago
> config: x86_64-sof-customedconfig-amd-defconfig (https://download.01.org/=
0day-ci/archive/20240705/202407050845.zNONqauD-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a=
15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240705/202407050845.zNONqauD-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-lkp=
@intel.com/

Fix is posted at
https://lore.kernel.org/all/20240711170216.1149695-1-surenb@google.com/
over slab/for-next baseline because that branch contains another code
refactoring [1] which would cause merge conflicts.

[1] https://lore.kernel.org/all/20240704135941.1145038-1-surenb@google.com/

>
> All errors (new ones prefixed by >>):
>
> >> mm/slub.c:2077:1: error: unused function 'prepare_slab_obj_exts_hook' =
[-Werror,-Wunused-function]
>     2077 | prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, =
void *p)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 error generated.
>
>
> vim +/prepare_slab_obj_exts_hook +2077 mm/slub.c
>
> 0bedcc66d2a43a Vlastimil Babka    2023-10-03  2075
> 4b8736964640fe Suren Baghdasaryan 2024-03-21  2076  static inline struct =
slabobj_ext *
> 4b8736964640fe Suren Baghdasaryan 2024-03-21 @2077  prepare_slab_obj_exts=
_hook(struct kmem_cache *s, gfp_t flags, void *p)
> 3450a0e5a6fc4c Vlastimil Babka    2023-11-13  2078  {
> 4b8736964640fe Suren Baghdasaryan 2024-03-21  2079      return NULL;
> 4b8736964640fe Suren Baghdasaryan 2024-03-21  2080  }
> 3450a0e5a6fc4c Vlastimil Babka    2023-11-13  2081
>
> :::::: The code at line 2077 was first introduced by commit
> :::::: 4b8736964640fe160724e7135dc62883bddcdace mm/slab: add allocation a=
ccounting into slab allocation and free paths
>
> :::::: TO: Suren Baghdasaryan <surenb@google.com>
> :::::: CC: Andrew Morton <akpm@linux-foundation.org>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

