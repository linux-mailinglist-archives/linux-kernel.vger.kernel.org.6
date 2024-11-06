Return-Path: <linux-kernel+bounces-397527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17499BDD08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D3E1C20AC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DEF1D95AA;
	Wed,  6 Nov 2024 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H837fBxc"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C433F3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859976; cv=none; b=Xtzc7R5Sw86zyhPurqrzXuptzP9j3XPcisg142PKj5dUNQ/rtXMxgmNZ28dIqqVWHMUQ+2qnRMbMJar3XMSWN+NdxWJaKISQhJgxzlUxwWyC/j0CCHg2M6gZCRTOqBJ4BcGq6dsjfFGgFuut2fRiJHw/UXn3N81j5j99+79mYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859976; c=relaxed/simple;
	bh=IqcIPl0EFYtA1Cj7qYgAmRgz1BP/eIZR6pTyCnnifaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pV+hCFEHzw/aDYj3YKQc1sVeiBZc+mESYtwaVckFjgfGCJS98NBNK21vyBxGaHycFTdTbtjmVsp8AWihEjNl1FwGmm12TXfMq+x41BH8XdAsy7N1pqlQQj/vnCRUOe8vqSwBOflD6WCrFaUNk0kwvK2YmiuwHFLYl7Vu0mJNdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H837fBxc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3807e72c468so789432f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730859973; x=1731464773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5se4QhnYbGT+lQnc5UOmh4AtqYT5NiabNGuT0E7oDrw=;
        b=H837fBxcplh2vRH06JCqIjjjlC2OzJJV1rXCmNGfDHN5OYubT6n2W+rmtNyCmN1FDC
         dTDlOVSg+U/2Jzrd+ULCiQswiuqDjmw3XWLbdlDZVZupwFkStNDBozwJXY0wtHU7kbXq
         FMIEZz9SwaMPCzASxj1k3YkxfwIDtFOsLOPepe3D4ExsHwWK1Vvcncy+8yUKYznVHpYW
         lNR+yGmW/z1tCLw/pFFLXh0DhFauXZUp6SjezROPBG3+1WyM8o/AGimCM7hw4ozk0XQX
         WE7UOaYgpT3KieoAkmko8k8tfG8IYC+DBlp93WauBN3RxcaKQgbPju+8qKDqVQM/nEPb
         QOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730859973; x=1731464773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5se4QhnYbGT+lQnc5UOmh4AtqYT5NiabNGuT0E7oDrw=;
        b=dhrUdoFFAvGAd/h7xnN426mSQGCurbmcT1UXCsrLOnE79eAwq4C9Grsg04oCkkZxEF
         hq9s22VxCOMgUbus72D6+djn98IJpL1oJVi9wTOH4edYM/A3uh56Wt8smp8DbSv8TKeG
         1Y9b+5d5SbFGpxSPfpyoVpaz1ZUGdv8KYTvYeAC8dC8v7TqDd+GNQUcpPKkQ4BAYpX9w
         LIcji23hMOXnTtkv9XhTZx6AunrZBFtd/EqHLEseXjjzJ6avXVNitYTyLhGISilo1/nw
         gmkSxmTKyHDv7Tgo8wlnwuL2R8wkehSakgyVzI0dQ09KzKYbloN7FmQgzzwiwbQ853V7
         2p2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfziim13DJX2TOi7aM9yUAfSpa8nKuV8do6790VUQB90ntmCwA1pAee3+kwe7n4S2uaIymL4gtIWOryI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr33UXq6F2avbjfZ0uWawCoWw+D37ZERNIzg9xYYIk2i1Vb8G4
	UJdlN7MkgKPjMSY7+PAAWdOfyuXJOaeimkqWpD4hmJoP5dF+dwGn8u+aKCy+aWs6T76ryHKgnLx
	MAe+aleYnw3FddUa904vUZ6xtXZQ=
X-Google-Smtp-Source: AGHT+IE8irJBBqeVJcjXIVeeBwwp3gZtLUQXloXKo9UsbZiAcxnB73J9iulXQ1NZInRc4XlNtwjedXd9iQpA7AQR+UE=
X-Received: by 2002:a5d:64ef:0:b0:37d:2e83:bc44 with SMTP id
 ffacd0b85a97d-3806124a914mr12800038f8f.9.1730859972825; Tue, 05 Nov 2024
 18:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
 <ab9f63b2-8d02-411b-8d2f-bc1b5b748ffe@kernel.org> <CAHJ8P3L9o2RJgV=TtUf_MPj36wasgPn7bn9FnGPXu=TgpE7ATQ@mail.gmail.com>
 <22873055-370b-4240-83ff-96bcfa91413a@kernel.org> <CAHJ8P3LddwapGLV5nKmw1ULTm7qp5OMk-kFBK3s_UptPPeph7w@mail.gmail.com>
 <9199e9fc-7b5b-4069-b79b-65ba5ae1b0f6@kernel.org>
In-Reply-To: <9199e9fc-7b5b-4069-b79b-65ba5ae1b0f6@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 6 Nov 2024 10:26:01 +0800
Message-ID: <CAHJ8P3L68mKAcSdrgk-5VZQh4cW+BBroh+50ymvuzO0f5x5kMw@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=A5=E5=91=
=A8=E4=B8=89 10:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/5 19:02, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=97=A5=
=E5=91=A8=E4=BA=8C 18:39=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/11/5 15:28, Zhiguo Niu wrote:
> >>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=97=A5=
=E5=91=A8=E4=BA=8C 15:04=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 2024/11/4 9:56, Zhiguo Niu wrote:
> >>>>> If user give a file size as "length" parameter for fiemap
> >>>>> operations, but if this size is non-block size aligned,
> >>>>> it will show 2 segments fiemap results even this whole file
> >>>>> is contiguous on disk, such as the following results:
> >>>>>
> >>>>>     ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>            logical addr.    physical addr.   length           flags
> >>>>> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> >>>>> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> >>>>>
> >>>>> after this patch:
> >>>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>        logical addr.    physical addr.   length           flags
> >>>>> 0    0000000000000000 00000000315f3000 0000000000005000 00001001
> >>>>>
> >>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>>>> ---
> >>>>> V2: correct commit msg according to Chao's questions
> >>>>> f2fs_io has been modified for testing, the length for fiemap is
> >>>>> real file size, not block number
> >>>>> ---
> >>>>>     fs/f2fs/data.c | 4 ++--
> >>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>> index 306b86b0..9fc229d 100644
> >>>>> --- a/fs/f2fs/data.c
> >>>>> +++ b/fs/f2fs/data.c
> >>>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct f=
iemap_extent_info *fieinfo,
> >>>>>                         goto out;
> >>>>>         }
> >>>>>
> >>>>> -     if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>>> -             len =3D blks_to_bytes(inode, 1);
> >>>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
> >>>>> +             len =3D round_up(len, blks_to_bytes(inode, 1));
> >>>>
> >>>> How do you think of getting rid of above alignment for len?
> >>>>
> >>>>>
> >>>>>         start_blk =3D bytes_to_blks(inode, start);
> >>>>>         last_blk =3D bytes_to_blks(inode, start + len - 1);
> >>>>
> >>>> And round up end position w/:
> >>>>
> >>>> last_blk =3D bytes_to_blks(inode, round_up(start + len - 1, F2FS_BLK=
SIZE));
> >>> Hi Chao,
> >>> I think this will change the current code logic
> >>> -------------
> >>> if (start_blk > last_blk)
> >>>       goto out;
> >>> -------------
> >>> for example, a file with size 19006, but the length from the user is =
16384.
> >>> before this modification,  last_blk =3D  bytes_to_blks(inode, start +
> >>> len - 1) =3D (inode, 16383) =3D 3
> >>> after the first f2fs_map_blocks(). start_blk change to be 4,
> >>> after the second f2fs_map_blocks(), fiemap_fill_nex_exten will be
> >>> called to fill user parameter and then
> >>> will goto out because start_blk > last_blk, then fiemap flow finishes=
.
> >>> but after this modification, last_blk will be 4
> >>> will do f2fs_map_blocks() until reach the max_file_blocks(inode)
> >>
> >> Yes, you're right, however, w/ this patch, it may change last_blk, e.g=
.
> >>
> >> xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap -v 2 1900=
6"
> >> start_blk and last_blk will be: 0, 4 and 0, 5.
> > Hi Chao,
> > yes, but w/o this patch , the original code still has the same situatio=
n??
> > for example
> > xfs_io file -c "fiemap -v 0 16384" vs xfs_io file -c "fiemap -v 2 16384=
"
> > start_blk and last_blk will be: 0, 3 and 0, 4.
>
> For the case "fiemap -v 2 19006", offset is 2, and length is 19006, so la=
st_offset
> is 19008, and last_blk should be 4 rather than 5, right?
hi Chao,
it is right w/o my patch.
>
> And for you case, it calculates last_blk correctly.
So you suggest that "Should we round_up len after start_blk & last_blk
calculation?"
Thanks
>
> Thanks,
>
> > but overall last_blk will change loop counts but has not affect on the =
results.
> >>
> >> Should we round_up len after start_blk & last_blk calculation?
> > I thinks it is ok ,but just a little bit redundant with the following
> > handling about len.
> >
> > if (bytes_to_blks(inode, len) =3D=3D 0)
> >     len =3D blks_to_bytes(inode, 1);
> >
> > Based on the above situation,
> > do you have any other good suggestions? ^^
> > thanks!
> >
> >>
> >> Thanks,
> >>
> >>> thanks=EF=BC=81
> >>>>
> >>>> Thanks,
> >>>>
> >>
>

