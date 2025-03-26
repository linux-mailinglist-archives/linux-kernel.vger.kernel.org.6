Return-Path: <linux-kernel+bounces-576847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD1BA7151C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF151891B82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5031C8614;
	Wed, 26 Mar 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMZN1T7X"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993694A29
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986325; cv=none; b=HxLj112dzFXgjILhs/gEHUCPx2VIueRFoARVjItlx4v6smPFDWz6oJDPjVNaE9rFarsTKxKqDQNpRe5wc53G6jys4XGrfGBqL0epxs++bLfb6rOBuyYyeehUy5BSTNT9zJFkO951l6aG+pGgP4rDExMqtm64pFBZ0phllrSEhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986325; c=relaxed/simple;
	bh=vNWY2OwiWQ+4yd4kLSCCNfAs5OrWfCACnSfqQS8BOvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qlfbz2ffJ45ZWErmX+H4UJ0KbEwtvSLHjVFdhNfLM6WkiFmLn5B3GgEdvSHvyJZTnS10tUqsr8mg8M03zyN8ha3r0+TCWVfrs+toGc1q6DmXxkpiCxPDOZJRhLKb3oDXsuDqW9YPAxnd4TOL5dq00bogaPPSz56zrU2E7WufhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMZN1T7X; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe99f2a7so4053575e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742986322; x=1743591122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUiJ39e9rjS2bB3JIWPFSpS7Z7JQ7PGJYyhz9hoeqh8=;
        b=QMZN1T7X9xPrpZfxCbSAEbYjR9ZHsuvPk5nMBfD7ZPf305aav5HW7grnizN6xqSYAW
         WdkgIajPTQ5DrBD86TYa0ch77ux0OBSpd9o8m8wPeygdnnHok12ddBK8zj2WXFpTVPKD
         msvIjFHHS05PQQzWNcH7HsB+sDaOQ6uCXtr1cXiZDsbJq0wGuKY0bzbIvCZ8dz57JkGR
         2K63YSU8/QtcGh1+01pAAUtjRLiF0meptlqxNYJG6qPnD123i9ootYfqlkYIaYbFJfPj
         fv19hj19Sxxb4qARZf/vmP3zj8LNf1jG7ikQxnRvObxywIsPqseuu3/1Rb1aD63dCq1P
         2WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742986322; x=1743591122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUiJ39e9rjS2bB3JIWPFSpS7Z7JQ7PGJYyhz9hoeqh8=;
        b=dqKxhfv2bgHQfLH4Hx0NhAhJxNsWyMbjZ4yt6CeWQBV0M0yVimA+7EPOhZyCFRzSlc
         o0qoBTMO6OAZ4w9IoTSJh3cBhmBrb+KZDtNGqyX8LtWPR8yt0TvMm6tYU7aMeOnFfglA
         qAh7ON+pnMGJs8knQaChoe/nybnpmODk4OIppavNX0cF77uIx3QbFKExQTXmWU2NWe28
         xiQtpzIAbOMx437/6TxrRabJXTx1pSqkMe+ujXUfhLTedLW4ZxbG7N7Fi6YXvANQoZg2
         EYS8SgzH24kQnHLuqFdM1tfESwe2xpSm1/2AywU5OS/03p/Nr6X3IWk+OrQ6QNgh9ABa
         +zmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVESZOa2jf6ve4s1E2CutdLqW6pPT3AC+aatSMf+CUcAtgLGbxb49X8zI2WatfDG3vd3WPolKpH57XFR78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGrkfSrqaFeu8IasRIxwwOOqJ0tsFf3qpCk5ouYzkGlv4k+C3
	iVw8O1870FDNdb0CUHWvs0hmIs66wJZ9fSWh59LmD8IcMsAdAYQkjTq0ZK96jBRio+AUlaasQVg
	pL8+plh56RnGuaZDMZXurLCN0WAU=
X-Gm-Gg: ASbGncvyyb7IM+q0tgwpp3ZjXSRyheCkpmHWLzfPpDLLSIkir2fnlBo2NexkUW5NXf8
	l1T2/4wnqAfwFh1RNv0rFSWMYVnHiMlm44Q6s7vOAaDNFhgGzdMv77Gn6jpc1ajghztFOj+etgK
	I0BmnR53c5Za3qiJAjZu9O6eWjW68=
X-Google-Smtp-Source: AGHT+IHvKYFrqGOaDXxYEwwFVrmnAAfI2Ac4I6FgReAxx3WGv0wMQQ4aPo7xkXF6L+B8JiFrf/klaBgj4vK++v/TIZI=
X-Received: by 2002:a05:600c:4448:b0:439:a30f:2e49 with SMTP id
 5b1f17b1804b1-43d6fcd0f23mr24454315e9.5.1742986321514; Wed, 26 Mar 2025
 03:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1742978761-16264-1-git-send-email-zhiguo.niu@unisoc.com> <e4fb11ea-a97b-4ba0-aa28-f6f93e5a6134@kernel.org>
In-Reply-To: <e4fb11ea-a97b-4ba0-aa28-f6f93e5a6134@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 26 Mar 2025 18:51:49 +0800
X-Gm-Features: AQ5f1JqKX6cSDt9h78JSWvel5VEJL_MOqY8616rTktHLRZ9xdX5kgNh_fTSxbb4
Message-ID: <CAHJ8P3JWABsntymD3u5=0YR7=0it5x0PP49S4ftwBEjC1UreOA@mail.gmail.com>
Subject: Re: [RFC PATCH] f2fs: remove some redundant flow about FI_ATOMIC_DIRTIED
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, daehojeong@google.com, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2025=E5=B9=B43=E6=9C=8826=E6=97=A5=E5=91=
=A8=E4=B8=89 17:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On 3/26/25 16:46, Zhiguo Niu wrote:
> > Commit fccaa81de87e ("f2fs: prevent atomic file from being dirtied befo=
re commit")
> > adds the processing of FI_ATOMIC_DIRTIED in the following two positions=
,
> > [1]
> > f2fs_commit_atomic_write
> >  - __f2fs_commit_atomic_write
> >   - sbi->committed_atomic_block +=3D fi->atomic_write_cnt;
> >   - set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >   - if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >   -    clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >   -    f2fs_mark_inode_dirty_sync(inode, true);
> >   - }
> > [2]
> > f2fs_abort_atomic_write
> >   - if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> >   -    clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> >   -    f2fs_mark_inode_dirty_sync(inode, true);
> >   - }
> >
> > but [1] seems to be redundant:
> > The atomic file flag FI_ATOMIC_FILE is still set here, so f2fs_mark_ino=
de_dirty_sync
> > still does not set the dirty state to vfs. If FI_ATOMIC_DIRTIED was ori=
ginally set
> > when atomic file is committing, then FI_ATOMIC_DIRTIED is just cleared =
here, and
> > then do the repeating action of setting FI_ATOMIC_DIRTIED?
> > So is it enough to do this only in [2]?
>
> Hi Zhiguo,
>
> I checked the code again, finally, I got this, could you please take
> a look?
>
> Ping Daeho as well.
>
> Subject: [PATCH] f2fs: fix to set atomic write status more clear
>
> 1. After we start atomic write in a database file, before committing
> all data, we'd better not set inode w/ vfs dirty status to avoid
> redundant updates, instead, we only set inode w/ atomic dirty status.
>
> 2. After we commit all data, before committing metadata, we need to
> clear atomic dirty status, and set vfs dirty status to allow vfs flush
> dirty inode.
>
Hi Chao,
these looks more clear.
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/inode.c   |  4 +++-
>  fs/f2fs/segment.c | 10 ++++++----
>  fs/f2fs/super.c   |  4 +++-
>  3 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 5c8634eaef7b..f5991e8751b9 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -34,7 +34,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bo=
ol sync)
>         if (f2fs_inode_dirtied(inode, sync))
>                 return;
>
> -       if (f2fs_is_atomic_file(inode))
> +       /* only atomic file w/ FI_ATOMIC_COMMITTED can be set vfs dirty *=
/
> +       if (f2fs_is_atomic_file(inode) &&
> +                       !is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
>                 return;
>
>         mark_inode_dirty_sync(inode);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index dc360b4b0569..28659a71891a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -376,10 +376,12 @@ static int __f2fs_commit_atomic_write(struct inode =
*inode)
>         } else {
>                 sbi->committed_atomic_block +=3D fi->atomic_write_cnt;
>                 set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> -               if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> -                       clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> -                       f2fs_mark_inode_dirty_sync(inode, true);
> -               }
> +
> +               f2fs_bug_on(sbi, !is_inode_flag_set(inode, FI_ATOMIC_DIRT=
IED));
but FI_ATOMIC_DIRTIED may  not be set when atomic file is committing?
thanks!
> +
> +               /* clear atomic dirty status and set vfs dirty status */
> +               clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> +               f2fs_mark_inode_dirty_sync(inode, true);
>         }
>
>         __complete_revoke_list(inode, &revoke_list, ret ? true : false);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 9a42a1323f42..a5cc9f6ee16a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1532,7 +1532,9 @@ int f2fs_inode_dirtied(struct inode *inode, bool sy=
nc)
>         }
>         spin_unlock(&sbi->inode_lock[DIRTY_META]);
>
> -       if (!ret && f2fs_is_atomic_file(inode))
> +       /* if atomic write is not committed, set inode w/ atomic dirty */
> +       if (!ret && f2fs_is_atomic_file(inode) &&
> +                       !is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
>                 set_inode_flag(inode, FI_ATOMIC_DIRTIED);
>
>         return ret;
> --
> 2.48.1
>
>
> >
> > Cc: Daeho Jeong <daehojeong@google.com>
> > Fixes: fccaa81de87e ("f2fs: prevent atomic file from being dirtied befo=
re commit")
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >  fs/f2fs/segment.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 396ef71..d4ea3af 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -376,10 +376,6 @@ static int __f2fs_commit_atomic_write(struct inode=
 *inode)
> >       } else {
> >               sbi->committed_atomic_block +=3D fi->atomic_write_cnt;
> >               set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> > -             if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> > -                     clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> > -                     f2fs_mark_inode_dirty_sync(inode, true);
> > -             }
> >       }
> >
> >       __complete_revoke_list(inode, &revoke_list, ret ? true : false);
>

