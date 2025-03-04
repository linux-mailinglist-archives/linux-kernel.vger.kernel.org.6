Return-Path: <linux-kernel+bounces-544943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE2A4E842
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1AC8C3BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48363294F33;
	Tue,  4 Mar 2025 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="lvQwbgg3";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="STMehVH1"
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20D294F32
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105376; cv=none; b=Mrtg6e0gPd3sm+rVFQ4egMUVaseGK2pGxMIIg5bqPE/cRdnOymrcGvOCKunr5alHvHU5dH8p8cuQYf3smiRaFmO+qRO95eSd6OoofgUMpNJHBj0PzPFo7eBPgFSB/mnQggZLAVabY00u4jIwLWJ6CgZsAfU1hoexVHpsabpxG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105376; c=relaxed/simple;
	bh=VGglBfIaRK07fXSRcIEH5LilDn9u5idf9wuZZdAGxs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH4/pjhP7Mv3WiP5uYmA2iksqg6nXljQI/fF6hKvM4Fo68NXLeFdHi+Il33/O4gsRBCjWlKPuGXzK0FNLrZsD6z4pJt30WH07nllODFgV/m83blH1oAeIECcEu6UGopeWoUqxvpDnejoRl7q7MJqAF9FhwmjcpUqKcBj/EXHIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=lvQwbgg3; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=STMehVH1; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Received: from mail-lj1-f198.google.com ([209.85.208.198])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.98)
 	id 1tpV2j-00000007yS3-1PqV
 	for linux-kernel@vger.kernel.org;
 	Tue, 04 Mar 2025 11:22:53 -0500
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30baf71caeaso14794161fa.1
         for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1741105373; x=1741710173; darn=vger.kernel.org;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=n1kIt/Zb2J92ItnZUKC5Mv82gjnufT3NgYnrI89szoY=;
         b=lvQwbgg3/UJcjwXeBY3RjzYEsL8vrqaQIkV4TYtNGt6Tpu3IrDIDsL3WGsHAHhiUS5
          yboWADFFTB8LrUhflkauf34QZsOtKyzvxEWaCZ6emhKYpVREkCCF1vHaxmsHRa9TdAy5
          6ykPZ8zPPY00fRWBSeegz71wSmC9WIPYGxjk0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1741105373;
  bh=n1kIt/Zb2J92ItnZUKC5Mv82gjnufT3NgYnrI89szoY=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=STMehVH1WsJmrAbv1kYPhOu4C2QZ7FRSVaVDLRK5RaCzoZgSj53CBorUz8LHoJWNx
  qxuYZcot/3Aw4y+F2D/ADnntUfX/bl+RISV4dS43RECX5YfOUjlQa+RzkVPe1wD4x2
  lLtBUjc2RnYooLcEk/vWwt+7vNZCBlES5cr6nV2pqriMbhi16kQTM06nzSf1K53lja
  mvYyCWTtid+4VN2Db3pVpiSsjiMZKXVHV9Qp/G3iukHnUPwbKSR6+KYLO4q/ZaAh+s
  Xxd/s4Ul40a1FTQ2OzWtmnorFUklsY2iBWPMivcmlp9PP2IfasJA/Yt5/7sNTLAwi2
  9zPjPaZhYlung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20230601; t=1741105373; x=1741710173;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
          :subject:date:message-id:reply-to;
         bh=n1kIt/Zb2J92ItnZUKC5Mv82gjnufT3NgYnrI89szoY=;
         b=auDmuMv9jEje70mziF9+0cBFlwLOh6XMHaMA239h+1mYuOY+VBZfJmn7AQgvuH8LsQ
          pQW9U5iW5QmY7vv+84d3Q+Jqrj5ZLNpnAPHAI3tHKxE1fggymxkpRpRlgpUhdbQ1q0lt
          Uib6MLxHxgVaJkYb9+Z8cXZSO8+QPVTwzHMlhm5FAowsAqKIzQestScVMQeADup+i25r
          4r7s2ar1DP9BQiOwlzmyXbhYvaHHxCCszGRy9TJ2NBnXSvjtnUPbCmo+ORw3B5Ii00dX
          2PuRW7OFK4cq6L19e6iGmVmsCTqf91rzgPx4htpV26gX3s0vRm0/PkCqK0m29tsUHbNt
          4y2A==
X-Forwarded-Encrypted: i=1; AJvYcCW99oU1vUB4Ooz7rAtsE0RM3biQfb7eUqnc69hJqJHk1fpGVxBCol+wJrN2q+Ig/jDUQQxu0roO88JnbQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqw8kdFfAEweo5zUVvMz6682ce4dUPMBz0nJa9PA+34W4cKSx7
 	UTxojMFirPWIAafhInD6UHPxtIx0fAzN8higzrsaQ0WzQPwKYFj2KV2WlEN6BQICBvyGqd+kdsK
 	Y7qi6ejxJOS5mVe5LXquQ+QAjTPr1lwx+zpAywInT8KI9TBbF+ywff03m2aw2mMIdMSKuoiy5lo
 	979GPcvJVyOiD73Pvkvgdu1b4ypDxutV4bYK4=
X-Gm-Gg: ASbGncuWVqX/zIXeKNkVJjUd0u5ePD0Grxh2/Yoj5SOIJdu0B9rRDkOSb7ddojDxVkA
 	mhrfORo6FMBvGryieAulL4/2TeRzOfG/OFocohnv1hiG5K1nHIxbxaXEArtOYmsWKXyUnqULs
X-Received: by 2002:ac2:4c48:0:b0:549:5769:6af6 with SMTP id 2adb3069b0e04-549756c43f0mr1362516e87.9.1741105372598;
         Tue, 04 Mar 2025 08:22:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKnU4ZSarTKRnV+oj9MOr7rBHWM4/oPZXxnuH48AVXZAmAOBC9YJNu8/mPFsx56Tmge3pWO9/RZ8Lv066VDGY=
X-Received: by 2002:ac2:4c48:0:b0:549:5769:6af6 with SMTP id
  2adb3069b0e04-549756c43f0mr1362511e87.9.1741105372191; Tue, 04 Mar 2025
  08:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304130533.549840-1-lilingfeng3@huawei.com> <20250304130533.549840-2-lilingfeng3@huawei.com>
In-Reply-To: <20250304130533.549840-2-lilingfeng3@huawei.com>
From: Eric Hagberg <ehagberg@janestreet.com>
Date: Tue, 4 Mar 2025 11:22:40 -0500
X-Gm-Features: AQ5f1JpWDTlD8yNaLk4Z5rugcYcWpex-b6rtvuo_2YQvkwR_VAxv5St6JcefNYc
Message-ID: <CAAH4uRAZAii6bL9UPx3dJ9x0jUW_UNrY8Bm07_k5znZT0Q=2jg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nfs: clear SB_RDONLY before getting superblock
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org, 
 	linux-kernel@vger.kernel.org, linux-nfs@dimebar.com, yukuai1@huaweicloud.com, 
 	houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 	lilingfeng@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

BTW - I tested applying both patches and the second one did fix the
issue reported in
https://lore.kernel.org/all/12d7ea53-1202-4e21-a7ef-431c94758ce5@app.fastma=
il.com/T/


On Tue, Mar 4, 2025 at 7:48=E2=80=AFAM Li Lingfeng <lilingfeng3@huawei.com>=
 wrote:
>
> As described in the link, commit 52cb7f8f1778 ("nfs: ignore SB_RDONLY whe=
n
> mounting nfs") removed the check for the ro flag when determining whether
> to share the superblock, which caused issues when mounting different
> subdirectories under the same export directory via NFSv3. However, this
> change did not affect NFSv4.
>
> For NFSv3:
> 1) A single superblock is created for the initial mount.
> 2) When mounted read-only, this superblock carries the SB_RDONLY flag.
> 3) Before commit 52cb7f8f1778 ("nfs: ignore SB_RDONLY when mounting nfs")=
:
> Subsequent rw mounts would not share the existing ro superblock due to
> flag mismatch, creating a new superblock without SB_RDONLY.
> After the commit:
>   The SB_RDONLY flag is ignored during superblock comparison, and this le=
ads
>   to sharing the existing superblock even for rw mounts.
>   Ultimately results in write operations being rejected at the VFS layer.
>
> For NFSv4:
> 1) Multiple superblocks are created and the last one will be kept.
> 2) The actually used superblock for ro mounts doesn't carry SB_RDONLY fla=
g.
> Therefore, commit 52cb7f8f1778 doesn't affect NFSv4 mounts.
>
> Clear SB_RDONLY before getting superblock when NFS_MOUNT_UNSHARED is not
> set to fix it.
>
> Fixes: 52cb7f8f1778 ("nfs: ignore SB_RDONLY when mounting nfs")
> Closes: https://lore.kernel.org/all/12d7ea53-1202-4e21-a7ef-431c94758ce5@=
app.fastmail.com/T/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  fs/nfs/super.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index aeb715b4a690..3e5528c2c822 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1304,8 +1304,17 @@ int nfs_get_tree_common(struct fs_context *fc)
>         if (IS_ERR(server))
>                 return PTR_ERR(server);
>
> +       /*
> +        * When NFS_MOUNT_UNSHARED is not set, NFS forces the sharing of =
a
> +        * superblock among each filesystem that mounts sub-directories
> +        * belonging to a single exported root path.
> +        * To prevent interference between different filesystems, the
> +        * SB_RDONLY flag should be removed from the superblock.
> +        */
>         if (server->flags & NFS_MOUNT_UNSHARED)
>                 compare_super =3D NULL;
> +       else
> +               fc->sb_flags &=3D ~SB_RDONLY;
>
>         /* -o noac implies -o sync */
>         if (server->flags & NFS_MOUNT_NOAC)
> --
> 2.31.1
>

