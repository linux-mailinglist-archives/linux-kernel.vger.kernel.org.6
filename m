Return-Path: <linux-kernel+bounces-296191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05B95A6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2390281624
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA51179665;
	Wed, 21 Aug 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvtH3MC/"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9BD1531C3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276869; cv=none; b=NVCqAWH1toGoxyxh/mmMdOIWTMnX/rI2hJnVR+b8MHu3+Jl4M4JlkzEcY0zV5wNUXj4fsCTSFQmUk445FGMOZODx97rnvRXeRyrY9H0Cz98j7yQtXl6ROIZ+MeDjEt9NBfWYGGY6fO6vAylb7F0wgYHR0g27TXwZCUTUX40C30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276869; c=relaxed/simple;
	bh=5xwsm4q+oEtOPgmW58wlQq10qR/Mga5nEPHHluceLUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keBtN1yFxSgsLNGX+4r4YR4WdmoEriF6WRFlYvNoLUraHKH5VYQpuEuW80LaBfHwEcYFxxBL6Egk4cqZX5nRUBGzWsmQfGhtMYmedV/QSx9e3dwTSxrz0vDsxzaTyKjSc6LVxnJRpfnWjh1pr+HaHt2Z2QL6XVgzlT2heqsvI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvtH3MC/; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4fc7bd8763cso49607e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724276867; x=1724881667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98sniykhgHyIjDFEFBrJSB+NsoobwZCkbD/WwKcnXqA=;
        b=gvtH3MC/O6vUEWUymuXHBuwoSDfM9A6aQhCoBWcLjWzticUIJwR2ePO9G0JZciJzqr
         VdD2LAOIwcHevjlcGMNAwtWKnwF8XLeDgi3zqQmBiwcb1tgV0xWg2c1kNz6ZwP5ixC4L
         UKQOiZ3CpI60aZbsdHLpsPlWB3zDY1A+WILvSy6PEi6ZNKXQ4rJNS8w24ep3ZAfCrlWb
         GVdOz33pXWuIP82V8wx5hJ0KDg2YZHoT52pFkivC5td8aftWpt9DNurev/tbvXe3TQEp
         XjvIlO0ECgaHyhvoot3BkNipmVLUjg9bzL957IoZovlgKL8xjwsfZBxHmhG/K80JNGE8
         s2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276867; x=1724881667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98sniykhgHyIjDFEFBrJSB+NsoobwZCkbD/WwKcnXqA=;
        b=s9JOAzzzbUUF3XUPCmR2IwULCfo/x3E16uw03ofbDv1wXR4qOm3227PyDb4A++9zuV
         hSN3FKYZUfgkdLVarym0h8VsCGhzZZ2LeFm/K3i8g71eb+RupWm1GDE7BAcAj0p0knrx
         cRbvp0gM50j4DraDn7IzbALdwQNowAXbGfN1PVG6DHar408xOaI/SeAd338qu0WKnDb4
         ziYBcMyNpLLY4G9tBgHK0SbsqyidlxRz46HA6IJXl+Uc6KZUEclAMxFpu/fJmNbH//WH
         STiB1I7g3YZT58r96jwQYAddHFJ70K3IiXswOJ5GRnamLevb5ykTXQOypLsIUvkRikZy
         VvjA==
X-Forwarded-Encrypted: i=1; AJvYcCWoYx5St29IJpy39JO07BDZwqpAorYElJ9hQfNBo9xoQrTUrgQMoV9IgHfGgm1wYya/4MRoVbDRfMFHiGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1iSXBnGG/ngehgjvZaW6/i/gNmOhM7kSjxc9SkoJWqX02vnLS
	OqEzoi2u/vhls2SlRWnLeY0WH0TA+1gsupgFVZrjysGeyzh2aYHrhAJ6a3zM112lHngNd0TDEeX
	AZfIrROtuwFtwdBK7yOwEYta4fZc=
X-Google-Smtp-Source: AGHT+IE4i6KUS8cNvu8h5bdx1rDgorR2H6gZqTPtMis5YSVU9JCyrkwyPbPBpidyC+Iut0PWkgr1fkIqlTo/oWqOR34=
X-Received: by 2002:a05:6122:31a3:b0:4fc:f1e3:d238 with SMTP id
 71dfb90a1353d-4fcf1e3d3c8mr4395884e0c.1.1724276866613; Wed, 21 Aug 2024
 14:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com> <ZsXho27uAbQ5rEgS@tiehlicka>
In-Reply-To: <ZsXho27uAbQ5rEgS@tiehlicka>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Aug 2024 05:47:34 +0800
Message-ID: <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: Michal Hocko <mhocko@suse.com>
Cc: gaoxu <gaoxu2@honor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Shaohua Li <shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:46=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 16-08-24 07:48:01, gaoxu wrote:
> > Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_lazyfree=
_fn:
> > 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If it's
> >    moved to the LRU tail, it allows for faster release lazy-free folio =
and
> >    reduces the impact on file refault.
>
> This has been discussed when MADV_FREE was introduced. The question was
> whether this memory has a lower priority than other inactive memory that
> has been marked that way longer ago. Also consider several MADV_FREE
> users should they be LIFO from the reclaim POV?

The priority of this memory compared to other inactive memory that has been
marked for a longer time likely depends on the user's expectations - How so=
on
do users expect MADV_FREE to be reclaimed compared with old file folios.

art guys moved to MADV_FREE from MADV_DONTNEED without any
useful performance data and reason in the changelog:
https://android-review.googlesource.com/c/platform/art/+/2633132

Since art is the Android Java heap, it can be quite large. This increases t=
he
likelihood of packing the file LRU and reduces the chances of reclaiming
anonymous memory, which could result in more file re-faults while helping
anonymous folio persist longer in memory.

I am really curious why art guys have moved to MADV_FREE if we have
an approach to reach them.

>
> --
> Michal Hocko
> SUSE Labs
>

Thanks
Barry

