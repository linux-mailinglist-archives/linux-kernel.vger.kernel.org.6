Return-Path: <linux-kernel+bounces-396037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2183C9BC70B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EA2283A71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D701FF03A;
	Tue,  5 Nov 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgQa3fUi"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F791FE105
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791702; cv=none; b=pltGKha3ojnBSwgEPdzXQdkFdcuj+BBcPN+du8ThJTHyOxzMhfH8Ya1jyKRfX+7VOCg66KMBj5lVhqWzmM8rKd14lN6sNjCiconIP9zKq/L710Nb4H0Lai0WfJA8diklfTVwdl1Glv4UANUue9R5eC0REb3FUwnQa7g/bCYaceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791702; c=relaxed/simple;
	bh=klpkap17FjqoH1PbSy9hIcIvY77oWxk+ZRYjPel3ghU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UG3gv344UQ+mhaKeklHGdAZYION6V0E58xJtc8neQtE0YXpw61VNts3VBTOrUghYD6x/5IcKHlpBa6JRvxdSNN+xUywH1+AUhJUs++mh1Y9aRzOvmYMDuMmuG9mswmvi/IbfhWcFlq12EIt4MGZRVr+6m04ov4RJdYNwC2fXCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgQa3fUi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d5045987dso441414f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 23:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730791697; x=1731396497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR+0fJY21qOQ4pKy7qaBE0+v2RefTjKds+lqx/Uls8U=;
        b=SgQa3fUiiTHGKlZwsu7ORBjOmHfyQJGDU61ohF1m8UtFQSTnIFm4Bi4JdO/DEYVKIv
         QPGJJOqOFUSvEvduk3NhKlXHm8POPxaUqA3FOIGwCsyaTyFVmVdZNzP+eSYlEs/HPh9Q
         gmDVKv471kdqECeoj111bYKTRLrVo0jJ3y5hmU7aomWqAwSZgX5pkVuYJPx/PcnCA78l
         bWlGZpsGIRAbZHV8RtOrSsD0AQL0vWoFNFhTsdSeMVF10FhJGislA/Gt960jF7zBBWCh
         GDO9EHo721ZtujmlLuVuwsK/1UbJ1G0EinK9USilBr/X5+1E9M7ExHars+VEZS4fQXXW
         EZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730791697; x=1731396497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR+0fJY21qOQ4pKy7qaBE0+v2RefTjKds+lqx/Uls8U=;
        b=ESp6lE2JZDhLL4oY0RgSKGKru3EdUlhGvHLQTwF1A+glOfvxCqO5rikwhjtzNrfsnb
         +lHdf91kd2P9UurQVYuL1+lNA0/vTbDft2db29O0Euz1xUa52VjrOlemakUAW2r80a/D
         qKsW/dpssco9KHLtwVnjkYcNDlmSNRQckwjRl+pgYDxArPrm/ihy6KALM0qKIJPUY2OO
         TfCtS18zN2AuY/qi2G3A/4GuTWLHLuoqX3HjXu7phBc279FagIKQ79Ew7DQF9ObqEluC
         jYN0SeWCar5kUcZ69cwsMrf6c6mmKqP3/CwYIDuVWCTSQns4MmU6sJ2bqFaqeLnWl7O/
         0jDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWknCWF7C9qVlhhq48QVTd4Sn7KCMOZByVsaQe5r+fKjim3UuDMIPlaMxvsvp7gNUkt+CsOztPsksVZ1ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlC/nuHjYYIExKzO18F/S4c7FxoYAIZhT7QGWPkp9sf5jocgBZ
	wNpobE68o1kNyyeGCe2cRosDJlI611bOhP8qRGfoS65gOU6xWO8iPxlio8hE28B4EcPgQEhsL2J
	lrblmpyAkKdDKeHoNWOINSBC18gc=
X-Google-Smtp-Source: AGHT+IEGT+on1DX3p1vF1HvZpo63Gp5w5OxpW/OQ7mVoa4w2wrlFBXlYD17R3fdF7NX+uCMUjx3EuFafgtg1dRcutLI=
X-Received: by 2002:a05:6000:4588:b0:381:d004:83c2 with SMTP id
 ffacd0b85a97d-381d0048465mr2733931f8f.5.1730791697099; Mon, 04 Nov 2024
 23:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com> <ab9f63b2-8d02-411b-8d2f-bc1b5b748ffe@kernel.org>
In-Reply-To: <ab9f63b2-8d02-411b-8d2f-bc1b5b748ffe@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 5 Nov 2024 15:28:06 +0800
Message-ID: <CAHJ8P3L9o2RJgV=TtUf_MPj36wasgPn7bn9FnGPXu=TgpE7ATQ@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=97=A5=E5=91=
=A8=E4=BA=8C 15:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/4 9:56, Zhiguo Niu wrote:
> > If user give a file size as "length" parameter for fiemap
> > operations, but if this size is non-block size aligned,
> > it will show 2 segments fiemap results even this whole file
> > is contiguous on disk, such as the following results:
> >
> >   ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> > Fiemap: offset =3D 0 len =3D 19034
> >          logical addr.    physical addr.   length           flags
> > 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> > 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> >
> > after this patch:
> > ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> > Fiemap: offset =3D 0 len =3D 19034
> >      logical addr.    physical addr.   length           flags
> > 0    0000000000000000 00000000315f3000 0000000000005000 00001001
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > V2: correct commit msg according to Chao's questions
> > f2fs_io has been modified for testing, the length for fiemap is
> > real file size, not block number
> > ---
> >   fs/f2fs/data.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 306b86b0..9fc229d 100644
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
>
> How do you think of getting rid of above alignment for len?
>
> >
> >       start_blk =3D bytes_to_blks(inode, start);
> >       last_blk =3D bytes_to_blks(inode, start + len - 1);
>
> And round up end position w/:
>
> last_blk =3D bytes_to_blks(inode, round_up(start + len - 1, F2FS_BLKSIZE)=
);
Hi Chao,
I think this will change the current code logic
-------------
if (start_blk > last_blk)
    goto out;
-------------
for example, a file with size 19006, but the length from the user is 16384.
before this modification,  last_blk =3D  bytes_to_blks(inode, start +
len - 1) =3D (inode, 16383) =3D 3
after the first f2fs_map_blocks(). start_blk change to be 4,
after the second f2fs_map_blocks(), fiemap_fill_nex_exten will be
called to fill user parameter and then
will goto out because start_blk > last_blk, then fiemap flow finishes.
but after this modification, last_blk will be 4
will do f2fs_map_blocks() until reach the max_file_blocks(inode)
thanks=EF=BC=81
>
> Thanks,
>

