Return-Path: <linux-kernel+bounces-396302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2989BCB28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0CA1C224BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9601D1745;
	Tue,  5 Nov 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTqcQ4qh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D72B9B7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804560; cv=none; b=lszjaiCli3DhVCk1rOvebJcKmNkhUmHHwNnahv0CPCFEHVw6R1g0WiLtGlorscvarM3lBQHU4VopLXbp+uZjfPIF6AKKlJdtz7xz22VyjEzvEhglqqeTDduKX9fbPSVrVJH/03+C5rsV4DcXSHXp5gwZ3LsnNCX7AEGayge5AGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804560; c=relaxed/simple;
	bh=KA3SYCgNgr61M0UarM3kh0RsiVB+BiaqwPhAaDeKocQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXTDYVVnS5nNHVh00VPk00Gv2yvjqM7H68JCLbm7qUTpNXjdP3+E/fV0RoahIxbOpNzt+jOw8aLkPr0Qs+drggrrv/QFncVjNf4ljrpI5q9XGJmX9VsMtcP/ubIj8JWTpAvaxpRcx+xcnk4h7exQ8xkvwPFBytmWQXj/mWHv0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTqcQ4qh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314c006fa4so4333025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730804557; x=1731409357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9Q2XSPdbWw/XHrk06jSmD1nKL1tt11T7tn+QZs5Wd8=;
        b=dTqcQ4qhomF+Nb85uWyo/oeOmuIMzUQLLMB1YnX+On2uReAR6KXE4A6qr2UUMCeLzp
         MaEUxQK1xI/yXWwFt0MZlI7ZAe0nnt0kb8K3nI/cYuJiqgEdc+7aYRKL+8FBt34kQmxJ
         GPsaBwZssyMLZRvpYJBZ1M1dXZBuUStxrtikK06NGo1WGvvvYsI60KsokIlZ7tO/UjZ9
         PZmy5xDRBWkpFXjrnqJ8vWhEKyaR04ljyYp6L0K+AK8bGuLQyOy/85pkSOc174ZgRNny
         EVA54aAhyjbWb8bqVBJ5BwuH8F1nog7+SI2DM8DKqu9h2Lhv1L+6elAiWIQa+21BOJqe
         xedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730804557; x=1731409357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9Q2XSPdbWw/XHrk06jSmD1nKL1tt11T7tn+QZs5Wd8=;
        b=ijlqN3xFGDzedPbGAIsL6ZTFkhqoAeFHe1QzzfA77eILGHLYCjTmJ87xOp1zcsgGa+
         2GAiv7J85dk91xUPfdhQIfh0yPUvvl7qAGzCyXt2hfrBe0s4oBuPY6GNDqjp33n1e0Dx
         Il/FGpWHzz0FJdpoX40AHgj9mI/YbfSCj0bNNf3+0nHqtEs+h4bqSv2rq/PcqmXf0R/x
         y6PvoQ9LzdwzEzOTEffrrgmNzcUHl3t7n8FnPyPWdOc3sjgUbDvDoxRoC4tNDmwdoFCS
         CasDpZaasLZY8wD/x64/v52BvMV1njAfy3rbUWPzqvyvKQ/rg5EP6nq6chn9CWknsiH8
         7OSw==
X-Forwarded-Encrypted: i=1; AJvYcCU6s6ifEt47r+D/lgMw8iMIwS4vhEJk1q5kF7Kt7oUF87jJKC4gzGUTUCXiw9go9S7A0TmYToyGN2UixvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23oEDvgtMYP+mL9bEYeRncAgZj3FeO4bkGYBq9GVRuhupQjqR
	0NNyx2axcB2Wc2ZKl9RsKC12QsfrdvM7r183oFuVpAmnWVLzKjRJSuJ4nRxBvu2Ik6aZmAR0e+u
	MdRdARCKnmRebh8YI8Ln8LC15C6Y=
X-Google-Smtp-Source: AGHT+IGEFiblHd/C5YPdchfjvzY1MXIM17YhPAHpNMi+UUqXIYyUgvOOf8MbfKIPAKVC2b3yCdq/4ZGszes65+uFhbg=
X-Received: by 2002:a05:6000:1fab:b0:37d:47a4:ec2b with SMTP id
 ffacd0b85a97d-3806121a2b6mr11543526f8f.11.1730804556375; Tue, 05 Nov 2024
 03:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
 <ab9f63b2-8d02-411b-8d2f-bc1b5b748ffe@kernel.org> <CAHJ8P3L9o2RJgV=TtUf_MPj36wasgPn7bn9FnGPXu=TgpE7ATQ@mail.gmail.com>
 <22873055-370b-4240-83ff-96bcfa91413a@kernel.org>
In-Reply-To: <22873055-370b-4240-83ff-96bcfa91413a@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 5 Nov 2024 19:02:25 +0800
Message-ID: <CAHJ8P3LddwapGLV5nKmw1ULTm7qp5OMk-kFBK3s_UptPPeph7w@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=97=A5=E5=91=
=A8=E4=BA=8C 18:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/5 15:28, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=97=A5=
=E5=91=A8=E4=BA=8C 15:04=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/11/4 9:56, Zhiguo Niu wrote:
> >>> If user give a file size as "length" parameter for fiemap
> >>> operations, but if this size is non-block size aligned,
> >>> it will show 2 segments fiemap results even this whole file
> >>> is contiguous on disk, such as the following results:
> >>>
> >>>    ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>> Fiemap: offset =3D 0 len =3D 19034
> >>>           logical addr.    physical addr.   length           flags
> >>> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> >>> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> >>>
> >>> after this patch:
> >>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>> Fiemap: offset =3D 0 len =3D 19034
> >>>       logical addr.    physical addr.   length           flags
> >>> 0    0000000000000000 00000000315f3000 0000000000005000 00001001
> >>>
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> ---
> >>> V2: correct commit msg according to Chao's questions
> >>> f2fs_io has been modified for testing, the length for fiemap is
> >>> real file size, not block number
> >>> ---
> >>>    fs/f2fs/data.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index 306b86b0..9fc229d 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fie=
map_extent_info *fieinfo,
> >>>                        goto out;
> >>>        }
> >>>
> >>> -     if (bytes_to_blks(inode, len) =3D=3D 0)
> >>> -             len =3D blks_to_bytes(inode, 1);
> >>> +     if (len & (blks_to_bytes(inode, 1) - 1))
> >>> +             len =3D round_up(len, blks_to_bytes(inode, 1));
> >>
> >> How do you think of getting rid of above alignment for len?
> >>
> >>>
> >>>        start_blk =3D bytes_to_blks(inode, start);
> >>>        last_blk =3D bytes_to_blks(inode, start + len - 1);
> >>
> >> And round up end position w/:
> >>
> >> last_blk =3D bytes_to_blks(inode, round_up(start + len - 1, F2FS_BLKSI=
ZE));
> > Hi Chao,
> > I think this will change the current code logic
> > -------------
> > if (start_blk > last_blk)
> >      goto out;
> > -------------
> > for example, a file with size 19006, but the length from the user is 16=
384.
> > before this modification,  last_blk =3D  bytes_to_blks(inode, start +
> > len - 1) =3D (inode, 16383) =3D 3
> > after the first f2fs_map_blocks(). start_blk change to be 4,
> > after the second f2fs_map_blocks(), fiemap_fill_nex_exten will be
> > called to fill user parameter and then
> > will goto out because start_blk > last_blk, then fiemap flow finishes.
> > but after this modification, last_blk will be 4
> > will do f2fs_map_blocks() until reach the max_file_blocks(inode)
>
> Yes, you're right, however, w/ this patch, it may change last_blk, e.g.
>
> xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap -v 2 19006"
> start_blk and last_blk will be: 0, 4 and 0, 5.
Hi Chao,
yes, but w/o this patch , the original code still has the same situation??
for example
xfs_io file -c "fiemap -v 0 16384" vs xfs_io file -c "fiemap -v 2 16384"
start_blk and last_blk will be: 0, 3 and 0, 4.
but overall last_blk will change loop counts but has not affect on the resu=
lts.
>
> Should we round_up len after start_blk & last_blk calculation?
I thinks it is ok ,but just a little bit redundant with the following
handling about len.

if (bytes_to_blks(inode, len) =3D=3D 0)
   len =3D blks_to_bytes(inode, 1);

Based on the above situation,
do you have any other good suggestions? ^^
thanks!

>
> Thanks,
>
> > thanks=EF=BC=81
> >>
> >> Thanks,
> >>
>

