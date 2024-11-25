Return-Path: <linux-kernel+bounces-420360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A349D7959
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E203B228CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874242119;
	Mon, 25 Nov 2024 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QbG9DeKj"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD3624
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732494968; cv=none; b=U54kZe9rk3vi/fRx6/5no4tilFQ/6PrgsgC7Xn+4b7g0Ok9WmjQZVDWsyjb8AX5Sor84wLfnXJQdmRt8jA7ee0rCYb6pf1khbl07rAuZPfdhB5RPajhEOPmZqeXQvU0xYQ6WTpADs4kVSd/wNvAxYcMAYp3ptn45ptGNJuJJb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732494968; c=relaxed/simple;
	bh=mJ6R19ozl3x2b4Nzu/TLWs8H0h7AmS69JXIMrtLf2YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFFbs+Qg7M9rTdSk5uBCwXtSD+uHXH7T9ch+2mFY0GvH34U+6Ls9g7Q1SJUWF+XrwKHkGu70zwHORyHnJizEetMra9ItXn1aZxsY4xMOA18KJJ2GmM7Tq0C+U/VC7FoQe07KMJSa6nAx7x1WUp0+pEmxyV5XC71QXTdpbE85CDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QbG9DeKj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4668194603cso168241cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732494965; x=1733099765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSr5CKG++eQFb8qJOcGd2IEj8NNY5oqI4H+gHDu2PDk=;
        b=QbG9DeKjFZk/1wbr2xq5h6Pg85MHUNb4mVSoadOR0UJppClcqHn9Cq6sNk3tXWKVLT
         6hRywApN1mWULIDhmBzxAcRfQxVZttPUT6Iqd1pzBDwf5Fvk4IlK6KJjp9L/FSAyPmRt
         Iy6+Yikh5eef9/BzegZNl+nd5p2w/MuHrGoDiBjUfsTj1mcxekRTBLrPGmYrFcCuo7/S
         z+yVPbyb98xCaCMSBu+GKxIrH72ISX5k0Rasl4O8Aekupusuh/TZo0MnDduJ5jsouUvb
         76VgsCZ0qWUBwJfIDOWN5nvOKx8YgPdLUKPk05z4GJxP7Aj6uEj43QhY4WFfJw5LLsEP
         WUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732494965; x=1733099765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSr5CKG++eQFb8qJOcGd2IEj8NNY5oqI4H+gHDu2PDk=;
        b=oJKk4eQGw+px8TqKrFkUcQrmu6uqbJ1EA6/KTDPO8uRZH+eKFVwhiNSas1cNtda6my
         9YtYLpyfuJONl2qfvY5lr1fj1ZpqBMh9rhy8bShtLFfqH6J0VvR0ZwQoL4hm28+fuAgu
         1Rhl2BbszlsiheUrnKnxlY8/Jo/GbTXhr9iVmYJ+CtuSgxUqNGC9fpq8K+iPiZNis6Om
         iLMX0rw98SQFlV1W0YFgVwgoxzZxzLuAcvakCtJcQJfbFz1OEVqlChRfkrpYbHoUNgOo
         BcJnLs2Fv6HNlCMCz4aXqtBuESidAYxfne2uqY5A1VOwBXbrt3bbV8B8QFnQZTVmJsCu
         Hq2A==
X-Forwarded-Encrypted: i=1; AJvYcCXFs6TsjO3xsoPvkByzDg9puT3y3Qrp5UTT5ZZDpPsJ5lyElEoBW/wPHKvHVPlUbWfqSbPHHgbWY0IiprM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZyy9cW1zsTRCxz0tgv1hVRWutK5iOtFJ0yz5sTiB+wL8ZnyU
	odu+BIrCJ4d66Z9zDTVouc8xNAW9sL5SYmJaRwxKskz9Kioxsxq2JqeRRPKitDaEyFfvdOr2MKX
	+xGvP35GlhI6OTQhElHWilq+q9iZItLE+PhuCEkgR5g3GMRUXOHPb
X-Gm-Gg: ASbGnctNEUasWrnP28Yghdnl8udnQlbkmUik9rylXlukIgJOQHTsBF6kC/kFKpc1FOU
	TBdrHCV2D2Sh3G/Jns/4ZsosskuMW9Eo=
X-Google-Smtp-Source: AGHT+IHpQkcf21LWF/eq1nMarXV3Jg37V3xldrg84EfE6dT8okzfWKpHhE58b8kQL7O6mw8W2D9k8m9/BfmFZdHcL7M=
X-Received: by 2002:a05:622a:4286:b0:466:8906:159a with SMTP id
 d75a77b69052e-46689061a24mr1902811cf.19.1732494965078; Sun, 24 Nov 2024
 16:36:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124074318.399027-1-00107082@163.com>
In-Reply-To: <20241124074318.399027-1-00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 24 Nov 2024 16:35:54 -0800
Message-ID: <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
Subject: Re: Abnormal values show up in /proc/allocinfo
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:43=E2=80=AFPM David Wang <00107082@163.com> wrot=
e:
>
> Hi,
>
> I am running 6.12.0 for a week, and today I notice several strange
> items in /proc/allocinfo:
>
>        -4096 18446744073709551615 mm/filemap.c:3787 func:do_read_cache_fo=
lio
>  -1946730496 18446744073709076340 mm/filemap.c:1952 func:__filemap_get_fo=
lio
>   -903294976 18446744073709331085 mm/readahead.c:263 func:page_cache_ra_u=
nbounded
>   -353054720 18446744073709465421 mm/shmem.c:1769 func:shmem_alloc_folio
>  10547565210        0 mm/compaction.c:1880 func:compaction_alloc
>   -156487680 18446744073709513411 mm/memory.c:1064 func:folio_prealloc
>  -2422685696 18446744073708960140 mm/memory.c:1062 func:folio_prealloc
>  -2332479488 18446744073708982163 fs/btrfs/extent_io.c:635 [btrfs] func:b=
trfs_alloc_page_array
>
> some values are way too large, seems like corrupted/uninitialized, and va=
lues for compaction_alloc
> are inconsistent: non-zero size with zero count.
>
> I do not know when those data became this strange, and I have not reboot =
my system yet.
> Do you guys need extra information before I reboot my system and started =
to try reproducing?

Hi David,
Thanks for reporting. Can you share your .config file? Also, do you
see these abnormal values shortly after boot or does it take time for
them to get into abnormal state?
I'll take a look on Monday and see if there is an obvious issue and if
I can reproduce this.
Thanks,
Suren.

>
>
> Thanks
> David
>
>
>
>

