Return-Path: <linux-kernel+bounces-357918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FEE9977C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496F5B21E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9C1E282E;
	Wed,  9 Oct 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="VJfR5l6d"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681D16BE3A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510433; cv=none; b=NiZzX6zO9LOejCk7GZFCtBvy0kZnoxXtZvxVjYz+0t20BlyAsbEVRtqqRMs3E7kSqo7vJ0eCyGiRie8fB5ImT0904EPIXgadeQuM3eEdoHrzEs081MwcMrJlTNRrpMi92CUCuAxE1Qt4+SiMcXq6dBL+EMcls98/AQnFSYKtftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510433; c=relaxed/simple;
	bh=WRSEJpRqVGEx1p+7xonbAfeXiywHBYSCQGtICtTvn0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gjj4K03yVxtqUAp0oivMVwuPY/VF9XVDrrgOMNmCi2rOdvBVyZZ0yyhpFi0AcckzOl69140t72+VStDd7l47hfrScuUca8I2S/URgKmmUNBsJP439ddB63kt1bcLmj3DLmOVBSV7J00lf53UhhmXhvSWPYQ4RToTGvB1PdaqULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=VJfR5l6d reason="signature verification failed"; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9963e47b69so43357966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 14:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728510430; x=1729115230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNY7/3aGEch2q8J1pUCbG8jb+yZy5FZa1A6L2jUg/rI=;
        b=VJfR5l6dtd9a/+JQt3YSOHQmUJKnatyiYlKK/SpEsJ+WUaD3I1DfHcZ81yosCdx/6/
         LK1MI9LX+vZGsXAIL5JDJbj7sOe1CXbr5nk+GQGbF+nisFeDobhWY28+AZcC5cEdh7C9
         floUWkv/R3XMzKGWiVQcfziqZ0//RhycRsCJYuMtqHC0ALrDpd2cWtgTCAAxoGa7iq1R
         zA+AFZt7VvnpvHIB4ZvIKJc94hh2v1cYgI3b3tPishACbnjJSJtTXgQ14RnYtPVqNOPl
         MjyRWUd8AjgicLnVx+0GdB3ztC4Csg+mmgrVRtMO8MsM1mvUH5W+T8eLpf8GkS810jg3
         LvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510430; x=1729115230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNY7/3aGEch2q8J1pUCbG8jb+yZy5FZa1A6L2jUg/rI=;
        b=IYgpN6keh5b9H4RpjWqHdREwNIx91uPbySVAoPgnBAMiWcGPb+IrhSxAOdpNyS5lCN
         J43awlkaHnEU4rWoyt0FvwvEtOOd0zLiw14Ku3rS9Kvj5XaoTj/01SP8n3cQozefkV31
         kbBp7etwFwF5iIKqoEI9vMmNXIY6qFAdb2cvg2urOFd53pPksGOCEZ1vTjLgVXKZoc5F
         AnzPdem0ZVKCHYKmKUyr5XxcMq9XrAkYAnmH49aHLEG3w8XRJf/sm5QoPXFK0pjm+Q+r
         Z4kT7eFvKyik3dyRQ5d1qRooG+1kqZHgsFpma2tK871JECIxHEyNhHXkjElHRlrdRYeX
         ScEg==
X-Forwarded-Encrypted: i=1; AJvYcCWayYCc3Hog1EqUzpqKa4aUbaJmTjlkbqP2oChkIQ/9ch8ktHA2kBdAtnOCtdGwaRn15oqhGmmJmvlWzUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMIGo04KXZnzMQ28Wd47FvuI/40zm0YELbBq5MCUS/Z+v3DaS
	ydC9XxK7I81umWrJHEsejyNSJnsixHkxb8mB132Mt5VS8+YAyWfXT9X/O/wDl60DPtAPzMHRCth
	2urW7Bw9hTFDuFuOJS/YXGp4nD9K1tOtR/xGilA==
X-Google-Smtp-Source: AGHT+IE0zrBekMp0OzxByMeyrTa/R8Zyl4m1iSYWvDd5iqQvPvAHYK8tkB354xAtc2sJTVb+vxYrRLAQYa1UDXMGTC8=
X-Received: by 2002:a17:907:7d8d:b0:a99:497f:317 with SMTP id
 a640c23a62f3a-a999e8f7daemr122394266b.62.1728510430088; Wed, 09 Oct 2024
 14:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009200528.36343-1-everestkc@everestkc.com.np> <018e525e-809c-4c69-a948-a1278af1ff2d@linuxfoundation.org>
In-Reply-To: <018e525e-809c-4c69-a948-a1278af1ff2d@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 9 Oct 2024 15:46:58 -0600
Message-ID: <CAEO-vhGcPRQxzZBjDZZA4GZoWwcaOjgK85tUydvr9t7CtD-HGw@mail.gmail.com>
Subject: Re: [PATCH][next] fs: Fix uninitialized scalar variable now
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:38=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 10/9/24 14:05, Everest K.C. wrote:
> > Variable `now` is declared without initialization. The variable
> > could be accessed inside the if-else statements following the
> > variable declaration, before it has been initialized.
>
> It could be, but it isn't. I am not sure if this change is needed.
If you look at the full code then,  if  `ia_valid & ATTR_CTIME`
evaluates to False then now is never initialized.

> > This patch initializes the variable to
> > `inode_set_ctime_current(inode)` by default.
>
> Instead of "This patch initializes", change it to "Initialize ..."
> Do refer to submitting patches document for information on how
> to write change logs.
Will do that and send V2.
> >
> > This issue was reported by Coverity Scan.
>
> Include the the error/report from Coverity.
Will do that and send V2.
> >
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> >   fs/attr.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/fs/attr.c b/fs/attr.c
> > index c614b954bda5..77523af2e62d 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -284,7 +284,7 @@ EXPORT_SYMBOL(inode_newsize_ok);
> >   static void setattr_copy_mgtime(struct inode *inode, const struct iat=
tr *attr)
> >   {
> >       unsigned int ia_valid =3D attr->ia_valid;
> > -     struct timespec64 now;
> > +     struct timespec64 now =3D inode_set_ctime_current(inode);
> >
> >       if (ia_valid & ATTR_CTIME) {
> >               /*
> > @@ -293,8 +293,6 @@ static void setattr_copy_mgtime(struct inode *inode=
, const struct iattr *attr)
> >                */
> >               if (ia_valid & ATTR_DELEG)
> >                       now =3D inode_set_ctime_deleg(inode, attr->ia_cti=
me);
> > -             else
> > -                     now =3D inode_set_ctime_current(inode);
>
> The code is clear and easy to read the way it is since it handles both ca=
ses
> and does appropriate initialization.
Yes, I agree, but if we initialize now to the current time during its
declaration then the else
condition won't be necessary.
>
> >       } else {
> >               /* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be =
either. */
> >               WARN_ON_ONCE(ia_valid & ATTR_MTIME);
>
> I will leave it up to the maintainers to decide whether to take
> this change or not.
>
> thanks,
> -- Shuah

