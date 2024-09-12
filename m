Return-Path: <linux-kernel+bounces-326894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B4976E35
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D5E1F215DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53B91AC89B;
	Thu, 12 Sep 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp7bRR/I"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF444C8F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156394; cv=none; b=QBBkBebxn+uc7q6mOCrZtqalJ9yG+ymEHWfY0E/10jT+mAse5wPcjL9KLjdp86ez64p38nGcBu+MG2rNk34AdobmAFUkqVgTSfhl7dgikMwrl73W+5w313dB+D2hGUz26xuyg0njFqB7HpzM5qtu0yZgSsosHUcJe3cseyxYTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156394; c=relaxed/simple;
	bh=dFG6Gy9TwNPY7C/BKtVWczp8E2TwOwjAUN4EXuuqdws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h08AT4QRqiBdI3ajEixYbhxA3tpFGuXONIDlZiMgYBp+h18OgWzw7K+oxbVBhZdFEb+YbCxFZ591hRPQNhPMqVAvB8+IJNzYsjjdj6bGlQBDNo6CHJ6NVxSH9UaRlPadRNlCjxLR2LDH0w+u3tB0nazqpjCsd6Y74i68YmdN9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp7bRR/I; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e033e37bc9so486459b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726156392; x=1726761192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxnpoyeenCvXuA2nqNEXl2ArMBmJRvgYP93f5UbGcnE=;
        b=lp7bRR/IZ+kyOVH3nQsO58dHFAGqVrBu3CeQkuhS/M1CpSxmL478vmTRyyp71MASm1
         HsOlN3fRhpHR9R7fUPtSTMCReVxYmcJxC7z6GDkT7ihk9pAyohfDPOHyOhF8IxXbFgD7
         oXlouAKhdwTmkZgXo9n3snbACR8OS821N6RjSMzX7+216RL0GgqM50gDP8zzWswe8NFc
         DC11oIxP20btzkHxBgkBLiu2d9K1n0w0Hsw329KLg9XeuNPjPZddVisHX0V+KdqDiMeu
         tUUal9sXf4J82xUhnMPGGZtfm9WCpoJdJGny0ScQO5iIJx+czgn7/U9adR8N//2VFmiv
         a9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156392; x=1726761192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxnpoyeenCvXuA2nqNEXl2ArMBmJRvgYP93f5UbGcnE=;
        b=V1KOch2/pyQ0JGRFUR30PX8F2UjWg+uGtT1H8HfMZQNS0GuKyma/SI97ooErbPzw3L
         zYcA7Htsa+Mm9z7mbGqneTx9HtSoLKzXcd1NrLkFpwg53l9yrr0sX6BcN4AotXvuPP81
         ECd+UNinvSnYv6fdc/IcijtA5wQepplbiB1IYEaIMINKAcFaudy89nwFoNNrVMYrbOEv
         rpqwEyyRyOvm2EFEW3puIYujgjEM1gEdXDlCH1dbtoio/Gt5HZPmIgER4XeyXUUHOcQz
         JhGl+zL0cT468cm32b094csEgOm9rshpXNlg5rN0bPVwsn6+z/yP5AgYOcNoa4FT2cwz
         k2hA==
X-Gm-Message-State: AOJu0YzC1SgXxkSU6/NeHCTWvGSoYdi1wH/rHK73YbWblvnJ9bzgKaqN
	DPzpeO68/oHbTZO1VgqAbdmhiL1oKd/L3uUjzCfMUuatNywR4w246TkmzsdanK3Z4+Sp9uNbgvX
	pCmf7tp+XYZjh0gOZ76S5NccQsuOSf179
X-Google-Smtp-Source: AGHT+IF4prtzYunAHi7fsTonLppA1SK/JmSOLrzIP03Np1jPT2i5TwY1kRUtM7ACvRgIn6nTyJ2HO8yoi1aO+MMA0+E=
X-Received: by 2002:a05:6808:f93:b0:3e0:5167:248b with SMTP id
 5614622812f47-3e071aa63fdmr2138011b6e.20.1726156391815; Thu, 12 Sep 2024
 08:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911213031.183299-1-daeho43@gmail.com> <ZuL-pAo6A0VVBwYG@google.com>
In-Reply-To: <ZuL-pAo6A0VVBwYG@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 12 Sep 2024 08:53:00 -0700
Message-ID: <CACOAw_wXis4oF=TYSyf7PR0YPre6qip5VWH+OWXJh-POwopAMg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: forcibly migrate to secure space for zoned device
 file pinning
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 7:45=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 09/11, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > We need to migrate data blocks even though it is full to secure space
> > for zoned device file pinning.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> > ---
> >  fs/f2fs/gc.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 724bbcb447d3..aaae13493a70 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -2010,8 +2010,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
> >                       .iroot =3D RADIX_TREE_INIT(gc_list.iroot, GFP_NOF=
S),
> >               };
> >
> > -             do_garbage_collect(sbi, segno, &gc_list, FG_GC,
> > -                                             dry_run_sections =3D=3D 0=
);
> > +             do_garbage_collect(sbi, segno, &gc_list, FG_GC, true);
>
> Do you mean this, right?
>
> do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);

Oh, after ZUFS GC patches, we have six parameters on that. You're right.

static int do_garbage_collect(struct f2fs_sb_info *sbi,
                                unsigned int start_segno,
                                struct gc_inode_list *gc_list, int gc_type,
                                bool force_migrate)
>
> >               put_gc_inode(&gc_list);
> >
> >               if (!dry_run && get_valid_blocks(sbi, segno, true))
> > --
> > 2.46.0.598.g6f2099f65c-goog
> >

