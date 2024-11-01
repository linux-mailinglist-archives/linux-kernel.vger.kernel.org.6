Return-Path: <linux-kernel+bounces-391858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0829B8C86
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4401F1F213AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E341514E4;
	Fri,  1 Nov 2024 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljhrAsa6"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A414A098
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448070; cv=none; b=BY3sf5i6iAnjHFAviSL6JYlo2F9/4nwfF78O+3EQSp4BUI3D2q84QeF3u9ccaH0ut6VoDJ/DvoKPlKD3IYmofogDlqR7x7X3pA3i0qm6MXOU2Bp2OcDXmUPBy+gta7UfWcAMtiwS7MN5ywBDRjQ0mVBL6MBMZmPSna5dp6vCl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448070; c=relaxed/simple;
	bh=OD+o+i3CR8ax/RTM+GO7nauMUwL1AFI0L64g1dZjeS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcVmvR6r68rK0Ny+cMpQKcXYYQsqvzCbfwZrMWR8Kcp4FtGqR9poRYt2hdw6rsNlJAiuXAs84FIuT6fUf8Kg30baGBbdDCYfX2WjtrYVfkoI4gvek2TJb4VyAn5tg7NOVeSw7aSkYokSACbSGMLT3SYT3tS9yFRizOmPKQSDCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljhrAsa6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43160c5bad8so1951815e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 01:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730448067; x=1731052867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3wFiCMxWX4GMGR14s8fXyG7FhtI29ey/QfMb0SZKcs=;
        b=ljhrAsa671V7HwYnNWc1IJLimh2YXWVmsE6a1WtdWvo5tEN5wwCEbwB26HQJneKT9P
         lHwPUwZ8RdTJSF2+jBEchpeOmfmkntciXuthFqQdgdEb5V9B9/V46I5Eu1kJBSvsufk0
         So2O8U26PbYbnx6ppbaD3IwNSnDWEBqtZXdjctJRFfakdygrUwKnHqgXd3VROTRVtAOS
         7jqrGADHSuPgwIYcsGS4UGKksfeTkc2FIt59pYxFRM4A4rBMF1+C0VUawiABxAHChsly
         5AnZPaVpLWmAsZEzbs/lypHXkZMwHqu/t04u+mpIF3TzOPqWuCO2jBNG3sQ7bomY9WxE
         surQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730448067; x=1731052867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3wFiCMxWX4GMGR14s8fXyG7FhtI29ey/QfMb0SZKcs=;
        b=FH4/zF8V2R09J+MXCq+doAJXUN56ktftbbk2JLXjC2wgIgfzUul6fsCxeK9YejUwJd
         snpEbDCmgMLlAfgOvmug3f7PYJiAbZALJWNRW/gq62oH3DtTQFJYXsNY+ysT6K8lX1Tr
         hAmT9WlC3Nlg5j7gr6bVnUuEWmf+GGFuy54gnS26rmYkf2qlu1mKNwcMLX6/Hy5Sc9NE
         hnEXdrel00O+Ee01FDWjYYaiPZq7wMhTri1yGrBpDzuN6d3DqtqlbBs3W/u6DMPjulz5
         xaHLuvtev3cOWJQp/tNC7m/bzd+qkDTHMfzkHpgXPtCcvukI1M0kgiYBTXMnZ8gV6qKN
         VdlA==
X-Forwarded-Encrypted: i=1; AJvYcCX/bu/NAq0UI2Ec+Jl3+jGGH+1inTbedxVawMioN1lAw7Brf2d5xi0LsDlBLANK0t+W9RxUXW3mMFwVgw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyY5uj0Nm0w8CuPEs0gUwY+Md1mYHuoJ7fHy9jdiqtdVw3AAPU
	0HotQksfpzk37S/+6+n6v2xUQeSZGK+YKslAMbCkXgWffzOFrXqTqhm5fw+vWEgQuM1BI3bjnpr
	9fppm/upMbzOP2YjuLFRMIyQ4Ma0=
X-Google-Smtp-Source: AGHT+IGCxG3PImKp+g5IUNAg285XEzP2peodElZALyBm5qI/sIWRVeAcmENNcln3gyGOmYpyl56Pik8YtMWqAA7by3M=
X-Received: by 2002:a5d:64ef:0:b0:37d:2e83:bc44 with SMTP id
 ffacd0b85a97d-3806124a914mr7254380f8f.9.1730448066387; Fri, 01 Nov 2024
 01:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
 <1730354393-19672-2-git-send-email-zhiguo.niu@unisoc.com> <bf348748-46ba-47dd-a12d-5111be2df95e@kernel.org>
In-Reply-To: <bf348748-46ba-47dd-a12d-5111be2df95e@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 1 Nov 2024 16:00:55 +0800
Message-ID: <CAHJ8P3LDXj1B9XTfFEqxn-3nZXkKe9cLrWmdTqjCOp62Z+mwtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=881=E6=97=A5=E5=91=
=A8=E4=BA=94 10:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/10/31 13:59, Zhiguo Niu wrote:
> > If user give a file size as "length" parameter for fiemap
> > operations, but this size is non-block size aligned,
> > it will show 2 segments fiemap results even this whole file
> > is contiguous on disk, such as the following results, please
> > note that this f2fs_io has been modified for testing.
> >
> >   ./f2fs_io fiemap 0 19304 ylog/analyzer.py
> > Fiemap: offset =3D 0 len =3D 19304
> >          logical addr.    physical addr.   length           flags
> > 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> > 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> >
> > after this patch:
> >   ./f2fs_io fiemap 0 19304 ylog/analyzer.py
> > Fiemap: offset =3D 0 len =3D 19304
> >       logical addr.    physical addr.   length           flags
> > 0     0000000000000000 00000000315f3000 0000000000005000 00001000
>
> Why is FIEMAP_EXTENT_LAST missing in #0 extent? As we can see it
> in #1 extent before your change.
Hi Chao,
after I confirm, this log came from my local code and with some other
modification.
And after I use the f2fs original code with this patch , can see the
FIEMAP_EXTENT_LAST
has been tagged,  the following is the fiemap log.

/f2fs_io fiemap 0 19034 ylog/analyzer.py                                   =
   <
Fiemap: offset =3D 0 len =3D 19034
    logical addr.    physical addr.   length           flags
0    0000000000000000 00000000315f3000 0000000000005000 00001001
I will update the commit msg in the next version after reviewing.
Thanks a lot.
>
> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
>
> Thanks,
>
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > f2fs_io has been modified for testing, the length for fiemap is
> > real file size, not block number
> > ---
> >   fs/f2fs/data.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 90fa8ab..8c9bb42 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiema=
p_extent_info *fieinfo,
> >                       goto out;
> >       }
> >
> > -     if (bytes_to_blks(inode, len) =3D=3D 0)
> > -             len =3D blks_to_bytes(inode, 1);
> > +     if (len & (blks_to_bytes(inode, 1) - 1))
> > +             len =3D round_up(len, blks_to_bytes(inode, 1));
> >
> >       start_blk =3D bytes_to_blks(inode, start);
> >       last_blk =3D bytes_to_blks(inode, start + len - 1);
>

