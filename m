Return-Path: <linux-kernel+bounces-178956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB118C59C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081841C21148
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572C95FEE4;
	Tue, 14 May 2024 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vMkDV0cB"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300612E7F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704427; cv=none; b=QeVBh9OPQlXmX55BPmtg7vLFHl04h2jEBKFZ5bcxV/VUSaFQvn+ZeSNgO4Xu5gyKAilaYfJ6NbmHYXYkIPE4YS5TInZgABfeAMYd3Fg40eJFRkbY+oXCNJpIWNpEckrZ+l1diofKK31HFEMf8NR96V5928odLBPtdr2oXL+RGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704427; c=relaxed/simple;
	bh=ZveMAhEpxPkTHD7VDMcwAi8X3FGU/ioBy7n4/jBydvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si4V2H8RuW1f/cDSxxq9l6tw4SrmaSj5Ld1t7txd3k5DN+yVtDF38HmfMsHAeD7KlCGyAiNLCLu7i+ae8vC5SysftJCKYHV+IRSYbVffxU6XR7Ti860YIIMhOx/XPjiBd2vRtAHxbmBMSZsxroex0YGregF1YftgXTXeGKy8pos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMkDV0cB; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de46b113a5dso5628021276.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715704425; x=1716309225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv1f0KwnCkLw87/jdn7pXfBoRVPGPnbjvCSHZ433+XE=;
        b=vMkDV0cBF9yKDmN0CrkCDpwEvQboypA/hQX76774IlgU3XwqZqBbwUkX0bncGd8f7E
         n/+bLFE82J4CFRlKqRyuxH0iFpo+Ymb60JHw/dMMC69djcwaVf7wQMBNKXqD3CgAv5sA
         Uns0SQEckyDIthn+mY7PL5g01nRXvh5v0/ZLSe5w3/mRQESvHeMCb4y97W70um2IDLF/
         ut7MRdt22FMi5tRYTWKOjc0fqhbwti/qNQP2LgwPri3A62LGIqJuy3LWQvcFpcqKtR/X
         6vQHL4TWIQe/gc56i+YW5aDU3pcXULKD7BGJUT8IctwSQP58VpK8i1TIusTqaHafO+YC
         K0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715704425; x=1716309225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv1f0KwnCkLw87/jdn7pXfBoRVPGPnbjvCSHZ433+XE=;
        b=DsJe0XFHf/FwEGPx6KyOy81c45k2rCfFQgNlwcgzFxSdKQ5uCq1xXG2+I8PWum2uN0
         ntLMKN51EMC5HXKsAHOpdYKkL4HHNvqZd+ulIUYky/Q+tcPh5WNnm4ZY/M1QiA7Uusyp
         JqLZBTZr80oJfKh/4Q2gILBcC8Hy1ZrWEue7Lq9ekPvoaBXezg1AbAUZ575qGqzQKXeS
         6cTeGMXni5gzNZmlX19vg/vogQ22K/a+k1o1goBkATVcSvn4xQOvCeJnchp7a9+AbZ5c
         WQb5IZE4w5qrmxBUnoXjkX0JSkh+CVQesOGc08gRQm6hMQHf77Tbry6XMiDgGX/T/MDJ
         5Ebw==
X-Forwarded-Encrypted: i=1; AJvYcCV3EoxiuZQb1cff54RfUSJCNaTc24PMQXTzwR9ouJ6g2fpQvZciR3HOWbQIL4MnvJ9GE8RdhW8uX+w18WNIcuit6xap3jH2QCNwHGPk
X-Gm-Message-State: AOJu0YwDhVF6FOmKsGb8Br+3E/ZNe/9P0u0nP7kbmeImRafkPQtzB+1g
	KxqR5O78jAeQRGjYmh0IH67hqqX2SWqpOWCfZkfjXBNoiP29lZ7nZSb819OWF3UbWnbOS5qiLIi
	NrmX+e/N3++EFs01/fUrsBC8fKFnbDHWd3RfS
X-Google-Smtp-Source: AGHT+IFXAhCGaHN00zLb69EIyY6q0TTwNMCUOErAVF3O54yE63mv0vw48TLat8wi/llUL4sBRr0HPLAvGtQ1nDzkffU=
X-Received: by 2002:a25:b283:0:b0:dcb:b072:82d5 with SMTP id
 3f1490d57ef6-dee4f39c9bamr12638368276.64.1715704425109; Tue, 14 May 2024
 09:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514153532.3622371-1-surenb@google.com> <CA+CK2bCmy1PhDgDvEX2Pg=_HvLLD2msJmTV_rgMxifbd-y1wRA@mail.gmail.com>
In-Reply-To: <CA+CK2bCmy1PhDgDvEX2Pg=_HvLLD2msJmTV_rgMxifbd-y1wRA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 14 May 2024 09:33:32 -0700
Message-ID: <CAJuCfpGfcY9NLM2ShxBaspwzOK5=B4WFrT0cGDRwTPJMkE+wWQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: add version into /proc/allocinfo output
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 8:56=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Tue, May 14, 2024 at 9:35=E2=80=AFAM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > Add version string at the beginning of /proc/allocinfo to allow later
> > format changes. Exampe output:
> >
> > > head /proc/allocinfo
> > allocinfo - version: 1.0
> >            0        0 init/main.c:1314 func:do_initcalls
> >            0        0 init/do_mounts.c:353 func:mount_nodev_root
> >            0        0 init/do_mounts.c:187 func:mount_root_generic
> >            0        0 init/do_mounts.c:158 func:do_mount_root
> >            0        0 init/initramfs.c:493 func:unpack_to_rootfs
> >            0        0 init/initramfs.c:492 func:unpack_to_rootfs
> >            0        0 init/initramfs.c:491 func:unpack_to_rootfs
> >          512        1 arch/x86/events/rapl.c:681 func:init_rapl_pmus
> >          128        1 arch/x86/events/rapl.c:571 func:rapl_cpu_online
>
> It would be also useful to add a header line:
>
> $ head /proc/allocinfo
> allocinfo - version: 1.0
> # <size> <calls> <tag>
>             0        0 init/main.c:1314 func:do_initcalls
>             0        0 init/do_mounts.c:353 func:mount_nodev_root
>             0        0 init/do_mounts.c:187 func:mount_root_generic
>             0        0 init/do_mounts.c:158 func:do_mount_root
> ...
>
> This would be the same as in /proc/slabinfo:
> $ sudo head /proc/slabinfo
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab>
> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
> slabdata <active_slabs> <num_slabs> <sharedavail>
> pid_3               2730   2730    192   42    2 : tunables    0    0
>   0 : slabdata     65     65      0
> ..

Thanks! Addressed in v2:
https://lore.kernel.org/all/20240514163128.3662251-1-surenb@google.com/

>
> Pasha

