Return-Path: <linux-kernel+bounces-285271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B2950B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B123286568
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2CE1A2579;
	Tue, 13 Aug 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRkxy791"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A018C3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570367; cv=none; b=INxcNvB9ogkX4U4ei8xq8+tbIVE3mG8zu2tVBH7GnqFldNF1hl75I5twHe4/Fh2QZgTDLENyZxCf8rhXKXmJYSBteFXefjCN+JXjkF1isXvngmT+hmzuXqXRZgzKYqdFJqA+rZxYDQcmAqM27nFq0FnV1/DY3vvgLRJ46Epcshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570367; c=relaxed/simple;
	bh=unfwC0uJxuSbsQDNQx6367/xZl72c2pmYRyrWiucW64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+fQK8PZ9g+GPYR6FoBU/pr7nzuuMzwoD7zmCfcDPkQBu2q67/Duw26oZyIoXqmKnEN0XyZqJVrszJWRFHphPQBx6RU4eSwxQLDnbmCLJij+LCY5AP4pKfB4WStzqN1YmInHve9qLskP68vZkIG7Bv+IFot9F+4gaBQHyv5EXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRkxy791; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f6b67d9608so2424176e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723570365; x=1724175165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV2CIDgtQjfnfL1zkE8Kr3wO5iybTcwQL2R+oto1HXU=;
        b=TRkxy7910fwc9907fI7YVRCqzeOkAz5WgfQByLujk53S9xqcA7jQR83KrQcnzh8e4s
         azM0lesU+qgGSFLalvqHUQ6iH/GEAbH9DoCVIDlvZdg64xqSKU3En3PT+G7/xQMDR+zT
         ht5XyuRqKG3b7uNdxPan/fw3yQtXsEdazG4iRka8B0p3mt937lOlqUoxIuMyC93U/iPi
         QD/X1l9gGYNB+CapfvjX0TwVKNTpbUtmyUi/cJV3+Vyhx7f+tDJ8vUuDkybmNBo589x9
         Pjs9f3Cnk8yMznOt5Z4HmcM2M8s7TqEFbptnNnUv3iewuRbdZPND71h66mwrli+QHi8A
         LBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570365; x=1724175165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV2CIDgtQjfnfL1zkE8Kr3wO5iybTcwQL2R+oto1HXU=;
        b=Fdn3TQc4ilNrAqENvQiKbLxBbt8Jg6jb6j86w85ZUQNz8EapOJ4sDZGHvEMqc3bzFB
         QD6TrJ8dkyaFX3jq0ZxF+gdHpR7TPWSBGs0LunnxM5ukRy4TbbdXYPFNR4cAjRx8xpiv
         C2YiZVvzJ6zaeoI4IQ3mH2vRTATnwSUOErfub22Gzm85t3TNDCJNVcFPY4M7W/oQs8RK
         o5f4l7WgrDEtRyhBwYTBftXqFGUEh3w0CKZqQnCHWE7ATFBVcYMbYpnCyPeWo9WnGJwR
         xdLCRk9HL2l04etizZS5FXLzr4SOd2o9E36LEQDZP4M24Vuw6pevQrQnyBlonojCUe35
         ARqg==
X-Forwarded-Encrypted: i=1; AJvYcCUWJUX0YKpDB56rfs2ygxkSSMvr5J3uQ4fOyZzv8XVLJ/O+qJLaZsLrmItyx78mWVhTageCfcMSYfB8Dsn6V/thRBZi6KpaL4mJH90Y
X-Gm-Message-State: AOJu0Yw9wsRqtUwrkPXXfp+PffSu9KZL/dP2s4HLM+oZfJxSsfINASi2
	r13gk285VzDI5UrQKZhIXMc6tTla9c9tYeOH+nemYZWq/hzpk04WlUrsDlbTI5PZRvUF+UsZq9d
	fg3xTHXMh7cPG5jQH8XBXy0z+EEY=
X-Google-Smtp-Source: AGHT+IEG6/jPYdhGdlCbiGl93YeU1Z0AJ0DoZt7Au1/rT9b+nPLjsYqz71cc6Rq0whXRPt7NvJoDvbe7EqxkPlQ6vX0=
X-Received: by 2002:a05:6122:311c:b0:4df:1d06:eeb7 with SMTP id
 71dfb90a1353d-4fad1c4f434mr512830e0c.1.1723570365093; Tue, 13 Aug 2024
 10:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240813073246epcas1p4085b32d2b008b77119b811dc328b964e@epcas1p4.samsung.com>
 <20240813073244.9052-1-youngjin.gil@samsung.com>
In-Reply-To: <20240813073244.9052-1-youngjin.gil@samsung.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 13 Aug 2024 10:32:34 -0700
Message-ID: <CACOAw_y7g6CGCDB4NG7Y-+cg2niYxg4NVpcm5eg717j45GowtQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Create COW inode from parent dentry for
 atomic write
To: Yeongjin Gil <youngjin.gil@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com, 
	Sungjong Seo <sj1557.seo@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 12:34=E2=80=AFAM Yeongjin Gil <youngjin.gil@samsung=
.com> wrote:
>
> The i_pino in f2fs_inode_info has the previous parent's i_ino when inode
> was renamed, which may cause f2fs_ioc_start_atomic_write to fail.
> If file_wrong_pino is true and i_nlink is 1, then to find a valid pino,
> we should refer to the dentry from inode.
>
> To resolve this issue, let's get parent inode using parent dentry
> directly.
>
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> ---
>  fs/f2fs/file.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index fba8b5f216f9..1eae123f0315 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2127,7 +2127,6 @@ static int f2fs_ioc_start_atomic_write(struct file =
*filp, bool truncate)
>         struct mnt_idmap *idmap =3D file_mnt_idmap(filp);
>         struct f2fs_inode_info *fi =3D F2FS_I(inode);
>         struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> -       struct inode *pinode;
>         loff_t isize;
>         int ret;
>
> @@ -2178,15 +2177,10 @@ static int f2fs_ioc_start_atomic_write(struct fil=
e *filp, bool truncate)
>         /* Check if the inode already has a COW inode */
>         if (fi->cow_inode =3D=3D NULL) {
>                 /* Create a COW inode for atomic write */
> -               pinode =3D f2fs_iget(inode->i_sb, fi->i_pino);
> -               if (IS_ERR(pinode)) {
> -                       f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> -                       ret =3D PTR_ERR(pinode);
> -                       goto out;
> -               }
> +               struct dentry *dentry =3D file_dentry(filp);
> +               struct inode *dir =3D d_inode(dentry->d_parent);
>
> -               ret =3D f2fs_get_tmpfile(idmap, pinode, &fi->cow_inode);
> -               iput(pinode);
> +               ret =3D f2fs_get_tmpfile(idmap, dir, &fi->cow_inode);
>                 if (ret) {
>                         f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>                         goto out;
> --
> 2.40.1
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

