Return-Path: <linux-kernel+bounces-402576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F049C2949
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DCE1C22C30
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0C21E505;
	Sat,  9 Nov 2024 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmon7ya9"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2917C7C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731116457; cv=none; b=Tvo0A7gY3eifXL8oYjk8NAR3+6MykMFf6yk/RdLhPapRCVEhnyJdWQVGUi+x5bmhbyZ0sNPJJHnupYPkaLy4h5QdA4tutOPKuYdgw7nXgoTruaEbkVrEtvCk6bN7Qxv6colIrZfntAIxCOquxD4+UY53lOk2Ha9m1mDzlxcNK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731116457; c=relaxed/simple;
	bh=4v3b9DveW4J0U78ScHdmiW1Kb1kwqoXa9t5jN97rw0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faLi7MVtlnwGqsJ9hM2pgv4BeAM6Rz8zXa9dVl4W8qLvx/L/29msEbh7O0VwYod3uG0MtoezY0l5J2gdCivpD+msjR2y9mbgBpjon442mBNqfxks6DyxDUyBNz+8bUr+BsWlkELIe1LiIRd6u5/PV1DFKHRqzDcg8xoQJG19y0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bmon7ya9; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e3cdbc25a0so29702067b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 17:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731116455; x=1731721255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alYAJozbBoFMlkHoZsLDELchn1HKPRNFJXfllAHwhsk=;
        b=Bmon7ya91K6hgeW9O3WS/TJCU9DNY9SnmGQ7i10vBXA3i4XGczxvBwG8pDuEYNySxO
         aQJf62IIr39QwiDDSNR43ICIYKbT0hM8p1hDCUH/Ey1EFWs7vt9Xeu8AsXea6qfWySxF
         lm6IfVyV0WXYQ3X0ypFjNbHEG4dJ02UMIbpkKPRbCFZnjE64tM4F5L69bA8QdK7NtMiN
         BnBeSoPJqoglcnip6xgYIKwm4tYRwT2MOlZjAXgxw3J5ZZSmEDuXKWLG4Fthg2x6mbak
         8xyKVTuILG5k6KmmvJix5O52BfLm41z6gu7Pt0nvulKXts2KDUUjZvvBJrOZVbSzsE1s
         rulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731116455; x=1731721255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alYAJozbBoFMlkHoZsLDELchn1HKPRNFJXfllAHwhsk=;
        b=sxGHVlbO9U8n5fqU3TzTsrzs+f9DvmVvNyF4nF29KRt7juwfAC9zr4z1CLKbCrI6UP
         iK5LEhNI1EMXVXx8RW0LeDXRg0lBY1uRW0PsdY+Tepz25dfGyhaql2cKZ8wQIs9AG5GT
         QpWi2j9QpS6Tc3zbuNYi7YEHmIOPMQNaeGY56GvndhT9L0xIN9if5jnmRG3F6x97iivL
         JyKvYFKQqtjlqXyEu0n96wuzleLbpRjk267yJaskWsf/N898oXzT06h9ikRMSctuRdv8
         mGpfRToNmpdYqDy6A+OqkTarTG/AOnZy9H9dBk56Qczd+LR+KFKUWwIzyTpimzt7gE8w
         VPaw==
X-Forwarded-Encrypted: i=1; AJvYcCV5+zY7QycvIe3l1EdbKb9bKvx4OR8JKF6fQ8iR7eLFKzLEvw/azcLTxOnH/6b4pzPSAc5fTBa14RP32f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9CEEO/wBkyOjqpmpSwE6uzV0+3acKtuZUHu+SjLb7zSe1NM5
	m1JEcEXmrmwABpsgeln/E34bsg++ijxwomL+j8ffWRG9L0dWSYBImQAHcUnENZ7x5069SMXlssj
	/HbDQUSEma7tpY/k85sTcfV2GE2c=
X-Google-Smtp-Source: AGHT+IE65QQH5vxKcHYJFh7ya9QxQWKveCsogo/+blQwMlt/NfBp7O7Kxfqq2lNd+lRWWCZftGnWtdIxU1VU5gS6mRU=
X-Received: by 2002:a05:690c:3346:b0:6e3:2608:d5af with SMTP id
 00721157ae682-6eaddf7e5fbmr59882317b3.26.1731116455164; Fri, 08 Nov 2024
 17:40:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106025858.495458-1-danielyangkang@gmail.com> <a1471ca1-e119-4106-8965-cd954c373a62@kernel.org>
In-Reply-To: <a1471ca1-e119-4106-8965-cd954c373a62@kernel.org>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Fri, 8 Nov 2024 17:40:19 -0800
Message-ID: <CAGiJo8Qd_Xd=u-Q84dpR6krU-svVjgA1hHdPHBr9kHkMwpX8qA@mail.gmail.com>
Subject: Re: [PATCH] parse_options(): replace deprecated strcpy with strscpy
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, 
	"open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:47=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/11/6 10:58, Daniel Yang wrote:
> > strcpy is deprecated. Kernel docs recommend replacing strcpy with
> > strscpy. The function strcpy() return value isn't used so there
> > shouldn't be an issue replacing with the safer alternative strscpy.
>
> It's better to add "f2fs: " prefix for commit title.
>
> >
> > Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> > ---
> >   fs/f2fs/super.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 87ab5696b..ee8861b95 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1158,7 +1158,7 @@ static int parse_options(struct super_block *sb, =
char *options, bool is_remount)
> >                               break;
> >                       }
> >
> > -                     strcpy(ext[ext_cnt], name);
> > +                     strscpy(ext[ext_cnt], name);
>
> Needs to handle return value of strscpy()?
>
> >                       F2FS_OPTION(sbi).compress_ext_cnt++;
> >                       kfree(name);
> >                       break;
> > @@ -1187,7 +1187,7 @@ static int parse_options(struct super_block *sb, =
char *options, bool is_remount)
> >                               break;
> >                       }
> >
> > -                     strcpy(noext[noext_cnt], name);
> > +                     strscpy(noext[noext_cnt], name);
>
> Ditto,
>
> Thanks,
>
> >                       F2FS_OPTION(sbi).nocompress_ext_cnt++;
> >                       kfree(name);
> >                       break;
>

Ok, I've added the changes and sent a v2 of the patch. Lmk if there's
any other issues.

- Daniel

