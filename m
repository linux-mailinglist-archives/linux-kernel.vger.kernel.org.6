Return-Path: <linux-kernel+bounces-526110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43FA3FA19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE5219E2B64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF75218AA2;
	Fri, 21 Feb 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiUlyoUD"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CEA21772D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153420; cv=none; b=beUhlKxENFN4YRAAiAwXUQ1H2UcnDjX3xRVh4jsJ/Lr5vJT6aEYm+9lcOPzrl9N/dgH8ha2JRBDk0q3LW1lbU8v/bVKiFNJfeJhOZ4MNjO7N0Qb6BqhAZdEA3B52VAsVkBCkDavYWVMggQlJD6G6xy3k3F5cJrok2P9dfXh2gvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153420; c=relaxed/simple;
	bh=bhCuj4ksx8PTUKUlPiAGxklZY3obqSFJ+Q3ieR2aj4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcmrC8dn6WhQHliKSRVuy7bPyqeYH7YKjdRB+hOXBg3S8HHxEzlHciBrx9usmfpul8dV8ii4QKYlnlnF9XwiSB2L7IA5UQzHQrjei7QQWGE3euZhbxUPoK50R/iT3PB/SGsCLpgrFNSrHdAzszMQFQAMtHi6BCkT4Cqps3h/4tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiUlyoUD; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5208736db3fso725923e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740153418; x=1740758218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW57wmTj0EPUMiZ9PWhA+HFpZm560N/x1y9G/Fzly6U=;
        b=MiUlyoUDUpRlduVGaNQrKg1k3NjOuoJ0gPxWTbRvEIX1URPFy+hmH2Mtpp4UTC49Xu
         86hjIlcwiGC3nNFTFvVHoszWSz4J+N6uFwqqywiDzPTIgiaZ0qCETLvxOZcuQJSlyJKN
         7KmfgYvlu0BBR9YqssHwGFI3FFwkHJPu4CauwdTD8Y0ccQT9RTqw9zLaFrx2jUrjL+FR
         K1CWUF18rNWYbPGP5xf5SjpQCi0VB903+H9orFIjZwPTskujhe7/hFsOTFbG2ZF/jQRR
         s6CXjIZUayBYBnqYzK0Oqxc4od1j4+uDXVoUXBIyzUemA4z41QFIPebTg2ro2C7Fb/MB
         cHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153418; x=1740758218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mW57wmTj0EPUMiZ9PWhA+HFpZm560N/x1y9G/Fzly6U=;
        b=GPiHb5WuBN1CE2t7JeDYDdVO6Ue5UkvY2AwjjlZV8Z/Oj+4+xeVeqn4Yv+wupqJug4
         vHrpMBeHkSsO1vJ5v2qKy3oH/VPR04d3K92PIDhqrnXEATkex3ceMkebuwuRXi4Ns29f
         0zYAoL0HbDFhDJ0EWenRuFYovUiul62qytQS/5PA1JmlPh/glKgffbcyOjPAacbqG5K9
         9wbQDvAS62RNxqro02NFzrcf4cztha77rLx2UsPZdKbLTg8EB2e7sdiwBRD3cA3j7RQy
         ZFdudbZiN1q+vk1NQBB7TM7J7NC/x2A0jtDvXj6pTimmwgsv5Tqb3SUUb1bTbkkB8BY5
         R+3g==
X-Forwarded-Encrypted: i=1; AJvYcCVrK/2+Lr2wjgIBw1OtTRPxTx2+6ctBowNszZi8WoCwMyMO1O0B9ayxarC2wY1bfAMnQJoPes5wITrmruQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze152nBMs8N7uRy/irsymiNhvo7UwHuTObNv5aEk41pryK17Ht
	A8C+vQ8hM/VqotGZVknL93zEB0vO+DG5SQ7ENQnYpPRoSztmjNmIYSwWHeMtnti1eNfwTkzVRIF
	MeOQ3Xs8GZ/BuTdbsnsmc5TMhyC8=
X-Gm-Gg: ASbGncvVpgq5K6EJ//T1EQJ/u3ec6v8SJLyECsoI1KYclIyaWjmy87bpcm/uvjE2UpK
	SpHadal+6osSBnh7X3v8wCEMROvsPxduRY3X/TaQagKT6HBK9DTV56ulVxk3VmR9JEe5Vsmb8Rz
	cs+iSfdSkQNHYGF4RrbfqZP4z9nUb1c6+3EhjlVBI=
X-Google-Smtp-Source: AGHT+IGHwRZ8c74llSlA3WD5AWuIv6UFSApe19V2+tCR129QZ+QcEagYFQkoiJvcPPBnOTGpKvUCZtmZC++kfsiH19Y=
X-Received: by 2002:a05:6102:d8e:b0:4bb:5527:347a with SMTP id
 ada2fe7eead31-4bfc01f041emr2500563137.22.1740153417750; Fri, 21 Feb 2025
 07:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204145353.165-1-yohan.joung@sk.com> <53598146-1f01-41ad-980e-9f4b989e81ab@kernel.org>
In-Reply-To: <53598146-1f01-41ad-980e-9f4b989e81ab@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 21 Feb 2025 07:56:46 -0800
X-Gm-Features: AWEUYZkdoK3uJsFTk5HZX7XcHtaWFzduJr6mHRMXVEFKz3GS3btkedN7mqNt17U
Message-ID: <CACOAw_x2v9fhorDWx9+f4VufddSPA5S6PF22AM_56smjjD5Faw@mail.gmail.com>
Subject: Re: [PATCH v1] f2fs: fix to ensure queued discard commands are
 properly issued
To: Chao Yu <chao@kernel.org>
Cc: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Yohan Joung <yohan.joung@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 4:38=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2/4/25 22:53, Yohan Joung wrote:
> > F2FS zone storage requires discard and reset zone for each conventional=
,
> > zoned device.
> > In the current configuration, Discard granularity is set to the zone
> > size but queuing is inserted into the pend list with a maximum size of =
the
> > segment size As a result queued commands cannot be issued.
> > so we are restorting discard granularity to its original state
>
> It seems commit 4f993264fe29 ("f2fs: introduce discard_unit mount option"=
)
> introduced a bug: when we enable discard_unit=3Dsection option, it will s=
et
> .discard_granularity to BLKS_PER_SEC(), however discard granularity only
> supports [1, 512], once section size is not equal to segment size, it wil=
l
> cause bug. blkzoned feature became the victim since it use
> discard_unit=3Dsection option by default.
>
> What:           /sys/fs/f2fs/<disk>/discard_granularity
> Date:           July 2017
> Contact:        "Chao Yu" <yuchao0@huawei.com>
> Description:    Controls discard granularity of inner discard thread. Inn=
er thread
>                 will not issue discards with size that is smaller than gr=
anularity.
>                 The unit size is one block(4KB), now only support configu=
ring
>                 in range of [1, 512]. Default value is 16.
>                 For small devices, default value is 1.
>
> What about this?
>
> Subject: [PATCH] f2fs: fix to set .discard_granularity correctly
>
> commit 4f993264fe29 ("f2fs: introduce discard_unit mount option") introdu=
ced
> a bug, when we enable discard_unit=3Dsection option, it will set
> .discard_granularity to BLKS_PER_SEC(), however discard granularity only
> supports [1, 512], once section size is not equal to segment size, it wil=
l
> cause issue_discard_thread() in DPOLICY_BG mode will not select discard e=
ntry
> w/ any granularity to issue.
>
> Fixes: 4f993264fe29 ("f2fs: introduce discard_unit mount option")
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/segment.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6ebe25eafafa..2b415926641f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2320,10 +2320,9 @@ static int create_discard_cmd_control(struct f2fs_=
sb_info *sbi)
>         dcc->discard_granularity =3D DEFAULT_DISCARD_GRANULARITY;
>         dcc->max_ordered_discard =3D DEFAULT_MAX_ORDERED_DISCARD_GRANULAR=
ITY;
>         dcc->discard_io_aware =3D DPOLICY_IO_AWARE_ENABLE;
> -       if (F2FS_OPTION(sbi).discard_unit =3D=3D DISCARD_UNIT_SEGMENT)
> +       if (F2FS_OPTION(sbi).discard_unit =3D=3D DISCARD_UNIT_SEGMENT ||
> +               F2FS_OPTION(sbi).discard_unit =3D=3D DISCARD_UNIT_SECTION=
)
>                 dcc->discard_granularity =3D BLKS_PER_SEG(sbi);
> -       else if (F2FS_OPTION(sbi).discard_unit =3D=3D DISCARD_UNIT_SECTIO=
N)
> -               dcc->discard_granularity =3D BLKS_PER_SEC(sbi);
>
>         INIT_LIST_HEAD(&dcc->entry_list);
>         for (i =3D 0; i < MAX_PLIST_NUM; i++)
> --
> 2.48.1.601.g30ceb7b040-goog
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

>

