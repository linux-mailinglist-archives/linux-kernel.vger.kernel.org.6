Return-Path: <linux-kernel+bounces-357982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B777B9978BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D60828500C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0DA1E282E;
	Wed,  9 Oct 2024 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="mrX8tqnn"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4418E345
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514555; cv=none; b=mujJ506GUPNG4eJQ2N+rSZFfkjB6ntkc1+S0MXIRbIGGCkfm/rtF1OzkHfWW+oiPDnFM5SHCNrHuU/6XmBObalzwKZcqRJFbsZISauQ8lY0RchnPFTyh3UWn+RszfTRxD6XZYtaoH8Zw9O7CymhPNaayD5Q2+8YrIcdG6e9sxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514555; c=relaxed/simple;
	bh=AUJNhG7KnF+SDM956MpOWKoMCV2LSGWUVaFR34G207g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7Vdq67SZEuqRPhCF2p8coxLmiNsqi/9bSKl/h0CxZtkehgLOB9A/rP7JEobxk2Q3X+XS3n6AUwOw2VGF5QdUMPKSkyKJTRsV8mtBLgLI7AIW3c8RUcJpwoSSq9XfQ33H+QinDi84xyeftrRl66IrySVjiHBDk3X7wqrMSDl5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=mrX8tqnn reason="signature verification failed"; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9982f90e92so60449266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728514551; x=1729119351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZxtWindWdmYZkbk16VKmv4bmuYeMmGKg/IHKj1/uO4=;
        b=mrX8tqnn2HRwzSiIYGNAocje1qx67sEGqTOxh9+A6w3xui5n5aIXmBz7civzoO17za
         XxsFt0ZFqBIvcFk4dLhOprYAkD4kXYpYctBmBlzdX3ie92Pin4vcluyCNjLluwzzojx1
         Kpwzc8Ijz6iYIAAj4hwxPgUB7QhkFlm+Ift/bqSa8tBoXHvr8ln6aFC5SMIGN2SZ7Tpk
         W89RXXP2ms0yHpG60igWZomxpOXUlXpICZ92do2MRA7gYfFJ3lG2SBE5NL0whBV/DmFa
         8/LUitZMdQ6rLf2tdVxwe3i4s9L6KHSB0FOEUuuA+O9jCh0f60sjhtGDRjISsJPYy+jt
         FTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728514551; x=1729119351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZxtWindWdmYZkbk16VKmv4bmuYeMmGKg/IHKj1/uO4=;
        b=A72Lz9XXKifPWAIh0GI/bPW8AV8/vnXgmsy9ao57hmxan4J4eLQfdFJaVVkN7m3e5b
         3o15qliuUGo94FnPrDgSHyYmzSh5QOgMzR0cpEyNEWGP9tqA74TsIKjSeiTOIKJjBlUT
         bOxAdQW8IEXHKb4z1DnR5oMDtyHnka1o0qjhXL6FbWSclRcJgY7+Uc3mlbTY9LkDbLyb
         FYqaOQv2a9RK004Xjq251q40h6EkHLvr4CeONZ5LnoUDSVLLH3RwD3f5PrRO8YGB5quw
         grWXIkXfsUKLPhbwaiqfpPGVyBaz3BEOyNddOcT6ZIryo2cbroqKOeuOsQ7FnimXmzzt
         J0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXDObd5y1STGlb9iub6/gnKHDWyzD+122qJEivawtKZCz2GluUqoUeUD3JiX0NSFstbxwMG37zLrDFm9XM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3somvfzlpnO2V6NuMFqO+6bmmb6kjPTv15zH4kyqS1Jxhe2G
	TnxGaX7ynYUzZPKefUes+/jTkSAeeR8xtRqeTWjuWYHIaIERzvBsh3ff998MZBzST0lZ+uB1g0+
	vGS3d6ILszb/ktJq7viFRcM5lbHwiWM4QhgHcXA==
X-Google-Smtp-Source: AGHT+IErK5BiUbQpFUrai1ZKMne4uA9ddnkg7UDa8SOTq5SCOiRsU8zf6aXwvU1D4dqAuvZdY/C/itsiX9lTSsAgLNY=
X-Received: by 2002:a17:907:1c08:b0:a8a:cc5a:7f30 with SMTP id
 a640c23a62f3a-a99a1119ad5mr101276766b.25.1728514551223; Wed, 09 Oct 2024
 15:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009200528.36343-1-everestkc@everestkc.com.np>
 <263ceb04-f909-45d8-b9b2-5de86617ea25@stanley.mountain> <439cb2078a8eefa782bc8da4a77bb8ac43725ba4.camel@kernel.org>
In-Reply-To: <439cb2078a8eefa782bc8da4a77bb8ac43725ba4.camel@kernel.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 9 Oct 2024 16:55:39 -0600
Message-ID: <CAEO-vhECze1oN89+Pj0A8bMDZbCzHzLkRb+2F2aw+tcxAevuAg@mail.gmail.com>
Subject: Re: [PATCH][next] fs: Fix uninitialized scalar variable now
To: Jeff Layton <jlayton@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:40=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Wed, 2024-10-09 at 23:45 +0300, Dan Carpenter wrote:
> > On Wed, Oct 09, 2024 at 02:05:25PM -0600, Everest K.C. wrote:
> > > Variable `now` is declared without initialization. The variable
> > > could be accessed inside the if-else statements following the
> > > variable declaration, before it has been initialized.
> > >
> > > This patch initializes the variable to
> > > `inode_set_ctime_current(inode)` by default.
> > >
> > > This issue was reported by Coverity Scan.
> > >
> > > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> >
> > Fixes: d8d11298e8a1 ("fs: handle delegated timestamps in setattr_copy_m=
gtime")
> >
> > Maybe the WARN_ON_ONCE() should be updated to check ATTR_ATIME as well?
> >
> > regards,
> > dan carpenter
> >
> > > ---
> > >  fs/attr.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/fs/attr.c b/fs/attr.c
> > > index c614b954bda5..77523af2e62d 100644
> > > --- a/fs/attr.c
> > > +++ b/fs/attr.c
> > > @@ -284,7 +284,7 @@ EXPORT_SYMBOL(inode_newsize_ok);
> > >  static void setattr_copy_mgtime(struct inode *inode, const struct ia=
ttr *attr)
> > >  {
> > >     unsigned int ia_valid =3D attr->ia_valid;
> > > -   struct timespec64 now;
> > > +   struct timespec64 now =3D inode_set_ctime_current(inode);
> > >
> > >     if (ia_valid & ATTR_CTIME) {
> > >             /*
> > > @@ -293,8 +293,6 @@ static void setattr_copy_mgtime(struct inode *ino=
de, const struct iattr *attr)
> > >              */
> > >             if (ia_valid & ATTR_DELEG)
> > >                     now =3D inode_set_ctime_deleg(inode, attr->ia_cti=
me);
> > > -           else
> > > -                   now =3D inode_set_ctime_current(inode);
> > >     } else {
> > >             /* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be =
either. */
> > >             WARN_ON_ONCE(ia_valid & ATTR_MTIME);
> > > --
> > > 2.43.0
> > >
>
> This doesn't look correct. inode_set_ctime_current will update the time
> to the current time and then inode_set_ctime_deleg() won't work
> properly if the time being set is earlier than that.
Yes. I get it now.
> I proposed a different fix earlier today which should be correct:
>
> https://lore.kernel.org/linux-fsdevel/20241009-mgtime-v1-1-383b9e0481b5@k=
ernel.org/
> Thanks,
> --
> Jeff Layton <jlayton@kernel.org>
Thanks,
Everest K.C.

