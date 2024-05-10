Return-Path: <linux-kernel+bounces-176005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9368C28A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9E51F2647D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9278172BB2;
	Fri, 10 May 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVIw+3Sd"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92D172798
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358081; cv=none; b=nH8NP+M2uNNr9AzHNqAqcXKNamb4hIPLIe/UajOYnkBjs+e+LZOKP3AjRlT5pm0kUEZ7RxLkbg1Cr0/87u0LLAG3ahKd6JwkRhEdk4weinzk9po2Npnb/hBD+wUkz4WjhRVcV/aBLpBJhUE5gzXQXDPN5GmDsCoQ6k5EjsZF7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358081; c=relaxed/simple;
	bh=8aU0aZOb2y9DUg+lZw8BCNxpFVehcs41OsBX/b+s5tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdvpAe8HKxr2P3Z1llVj6RwAkIejPItWiE2ExsYZhOxyEldV0407XJ42AvjiNa7ThptmkG0cZs1r8doYzZhnb34knOSHvdBR3wghYJvsvl/aBYMhB38di4Mx7+M0AYDgWyiVav9uDcog7o8ma8irtLDZUlngjRYFEFoazlDWMQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JVIw+3Sd; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de46b113a5dso2086059276.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715358078; x=1715962878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFE3n+MZyxeo0bNjBIjsCbl4GDn+4HbpNAkc84Q2m38=;
        b=JVIw+3SdPraslrAkUD+qP1EL8SvbtmlAA6hZ5bM4Hw8/qeRwI5JrXO2iIcpmaMpgZs
         Zun4MxTUSoxsj+OY6wfTpiRVvcFwG/VNn/FwP2F/nNraLxBkp44rQmv3eA2pHkfSKtAL
         7vhxxDi/sAQ1DTbJsLD+xp0e6srravEyfLRnxbzZF2b0VNMivyFLE90e/5HtgUVnpovV
         gFW6bmVp78XTzYRQNGARB/YWcbQ3v4VntRu5mBCVLfKx0Ap+EQPMWQVPJS1amcWJ7RlS
         9Ldf9PhdtDUTp98JzMKzKawmmUSSI7IyeZocfMbQtjH3rro+q/77A40a8w6V3KbBXUSu
         0DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715358078; x=1715962878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFE3n+MZyxeo0bNjBIjsCbl4GDn+4HbpNAkc84Q2m38=;
        b=PvgaphYUVeIqbWWcBuL2VnAJu15HaZlUJ2Czp2DzPbVsQM7tfDXYwSvnfz8rgJQDM/
         Vk0AC5NcUz+FyUtwGYQz54ZYzzQ368Reg7UOq6UJpJ9oDjH5or5iwD7YYVu4Qr+RO35y
         t1MAE3y/PCuMsISArctOh5VkKhKk1/OErIiDpRoLoDBEhJC0wsVXNzxrN6rmOXKKeO7d
         LtBgQ+BZLL7pmGcG4axjv9tnXB4eXkA9E10ydxCO6Wjhc3rysUu8LQJqocltVWDe9MWX
         bxeveCYXBY7D1RyO85DUJxwiA02UprO3mRghnGY0Yr5nYcROlg/j8xUYqThzJju1+3qf
         yPpg==
X-Forwarded-Encrypted: i=1; AJvYcCV8uisqxxKv/HHzjiVDE5fndDCz0nHJTq5Is9ELXcCc4AwZ1wraIyDZjBuNSzbx8WA/4zJbF62CbdIuS9BTux3FE3xnDN3cC+VWEpw9
X-Gm-Message-State: AOJu0YyD3J0cRB4mz4LdvYgirNh6K/DUIad+DEmtuuSAvKu+1Fut7KPN
	5Xj4Jd3Wm9Onzh2FoBtq7gFvyNCZ4omfu7RdtK5HM0pZH7wGqgP5fb3l12ooXKLZB/VrUEW4aTE
	eKnww5QSQjiJxH9hfRqG/KrU47Fi5CfD1N7nU
X-Google-Smtp-Source: AGHT+IG1DyUD3fKZKxA634315t5oE5P95Q7TTzvjl87/l/KT7ajBuikVKoMlofkpK08Ducvn1mCsxmnORAB/OPa4VDU=
X-Received: by 2002:a25:bc8f:0:b0:dee:6346:b856 with SMTP id
 3f1490d57ef6-dee6346bbaemr42235276.34.1715358077724; Fri, 10 May 2024
 09:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-b4-sio-read_write-v1-1-06bec2022697@google.com> <20240510151508.hajqjxsn7rghk3dj@quack3>
In-Reply-To: <20240510151508.hajqjxsn7rghk3dj@quack3>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 10 May 2024 09:21:06 -0700
Message-ID: <CAFhGd8qbUYXmgiFuLGQ7dWXFUtZacvT82wD4jSS-xNTvtzXKGQ@mail.gmail.com>
Subject: Re: [PATCH] fs: fix unintentional arithmetic wraparound in offset calculation
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 8:15=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 09-05-24 21:34:58, Justin Stitt wrote:
> > ---
> >  fs/read_write.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index d4c036e82b6c..10c3eaa5ef55 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -88,7 +88,7 @@ generic_file_llseek_size(struct file *file, loff_t of=
fset, int whence,
> >  {
> >       switch (whence) {
> >       case SEEK_END:
> > -             offset +=3D eof;
> > +             offset =3D min_t(loff_t, offset, maxsize - eof) + eof;
>
> Well, but by this you change the behavior of seek(2) for huge offsets.
> Previously we'd return -EINVAL (from following vfs_setpos()), now we set
> position to maxsize. I don't think that is desirable?

RIght, we shouldn't change the current behavior. This patch needs rethinkin=
g.

>
> Also the addition in SEEK_CUR could overflow in the same way AFAICT so we
> could treat that in one patch so that the whole function is fixed at once=
?

Yep let's include that one as well. However, I'm going to hold off on
sending a new version until the discussion about how to handle
overflow comes to a conclusion; as suggested by Greg [1]. I made too
many assumptions about how folks want overflow to be handled. In the
case of this patch, a simple check_add_overflow() should be okay and
match the behavior, but let's wait and see.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

[1]: https://lore.kernel.org/all/2024051039-bankable-liking-e836@gregkh/

Thanks
Justin

