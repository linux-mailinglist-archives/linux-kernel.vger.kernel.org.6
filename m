Return-Path: <linux-kernel+bounces-321739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF0971EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704DFB23B13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42760139D05;
	Mon,  9 Sep 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="goPPREXd"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F043D38E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898162; cv=none; b=OIiTrE8CxiBjriCB4f//xlwYzZ893zcZzofTjEBN5mijMIv6mpnumqh/jzpHVlAdyRpiOzxytkiw0Z3kKcRJRdM5PygI1zx0iPEVI9hy2dmqfGqaX9MuyH8HPVz2onaMi1/yQIMqk+0IvV4czhPavnf2xkjU+/TRA2kyocL2qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898162; c=relaxed/simple;
	bh=KO216CVLRph9nCQrhGA5ZJFpbAsAr3U67xWLzLBcg8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIMf6hrehdiy1+kAbd45EfwIkLkHT3RlUHnrZzCPd9wo/shj4eUmhmqGabcDDDbMcnWx1oHds1CEvvnnpdKPUuNCuIykOCkTlHMTKSIwztbYGQLoagysQ2bpAC+OOyqJHn+wjbaW+VsmGj+2QkzQorWltVVZuVRc0a+RncnvbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=goPPREXd; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 134093F5B5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725898158;
	bh=cNmpVkq4Fpi+AIwt2yz0c7jLv0EtSIXXBwFhX1ECq/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=goPPREXdhoqpd8NQSS77RnvKDEaR3vpi5jKdscos6BaRUHpHRmBFHVzB/s9OtEd0j
	 YuQe7We+yx1CLtJIFvJhgpg+8lPIVicCjFYi41hMiq8kODN7FXtYnkiwBrnX8HzVd9
	 3OILh8+xNgts8qDdPZTWg/1jgqB1IxU83I+amXCNoPbsQxIPh478aBW1qjHQNlQV6d
	 jKLlC09oN4DMM9wAg+KlBqIhbwRawjMJTMrCldQxu6xAXYzOJPuCJGTNsZJFO6ArVj
	 NvE9GeA3ofXO25G3ounugmVbRWFNx1zSXyFAmMA37kmyYM26TSImSW+zEzG3GgNmbs
	 aNQa27Ea4t/5g==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5e1beceb2cbso2736273eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725898156; x=1726502956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNmpVkq4Fpi+AIwt2yz0c7jLv0EtSIXXBwFhX1ECq/E=;
        b=LuVBrSbLcOhblhjuH21h7YdIYyI9vqk71Rj3SixAHzA/AzWdCTYaHyPqMB5ZrZqZh0
         yBzBwAoStdMPkpu3ajm0+YLrF2QpDcYT6zEkJtQOr3bcwc26ycNT3fWh+D/QNGT3UH55
         D2hUEet85EbrntdXpmQKRDhg3tyjsr0Jsx3eKQvu5ZrMKB5wqnelSI5URBS84hIuvutW
         vkd/89u9sM+xglnfFEP1jb/UP14/1KKE1/U1FaMoxaTWHgiTjOHzYGSL2YF4isSxRId5
         RHwGhPbM5wfTt2IE7/FKq7Y92PrvappqhlVC23MpiYYxjkh6G4u334+yhBx0TQEAuUnB
         V47A==
X-Forwarded-Encrypted: i=1; AJvYcCUcae5OEpo6vSHP5W1WaBCmk9nL6kFucSDJ1Zt2oQwp9xPR9S7pMDELjWT31sVU+U/0EGEskR45NNoMYPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshmC3DdF635nM6RKosRBxTKOp7MGSdvvDQtx6Ei1OEvXkoZA7
	qHfFvHO/isqHdkAUEQPMA7FSedNVEAxhAiR2njwS8q21fc7LuPfltNq3GY0AFhDuCyIgo06Xl9d
	sevjyI342qIfn6a1PIh10/gmzky+Xwc5fgVmb16PGJrgTR7UTcJkkAT71rHxQe6X+qNtAExrgJO
	UpjkO2GtG0kieTnI6pjx/iqmZ5fzAnpvDCq489UMnVRH3KA+HpINQm
X-Received: by 2002:a05:6359:4c09:b0:1af:1b40:5357 with SMTP id e5c5f4694b2df-1b8386efd32mr536499055d.24.1725898155961;
        Mon, 09 Sep 2024 09:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGssdkcz6Do9xmtEwjdhYkf1iEQ/Z1pq4QSQQR4MEbhxzTfTXO+AVt/VjieiPcw5MrNhgqbn4QBYfvcEHdTGZY=
X-Received: by 2002:a05:6359:4c09:b0:1af:1b40:5357 with SMTP id
 e5c5f4694b2df-1b8386efd32mr536496655d.24.1725898155678; Mon, 09 Sep 2024
 09:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
 <20240906143453.179506-2-aleksandr.mikhalitsyn@canonical.com> <20240909-moosbedeckt-landnahme-61cecf06e530@brauner>
In-Reply-To: <20240909-moosbedeckt-landnahme-61cecf06e530@brauner>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 9 Sep 2024 18:09:04 +0200
Message-ID: <CAEivzxdT+Dy7McjfebYLTk8cXNdBJAe9Wze4NSys20Fyd7LOEQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fs/mnt_idmapping: introduce an invalid_mnt_idmap
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Seth Forshee <sforshee@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 2:57=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Sep 06, 2024 at 04:34:52PM GMT, Alexander Mikhalitsyn wrote:
> > Link: https://lore.kernel.org/linux-fsdevel/20240904-baugrube-erhoben-b=
3c1c49a2645@brauner/
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  fs/mnt_idmapping.c            | 22 ++++++++++++++++++++--
> >  include/linux/mnt_idmapping.h |  1 +
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> > index 3c60f1eaca61..cbca6500848e 100644
> > --- a/fs/mnt_idmapping.c
> > +++ b/fs/mnt_idmapping.c
> > @@ -32,6 +32,15 @@ struct mnt_idmap nop_mnt_idmap =3D {
> >  };
> >  EXPORT_SYMBOL_GPL(nop_mnt_idmap);
> >
> > +/*
> > + * Carries the invalid idmapping of a full 0-4294967295 {g,u}id range.
> > + * This means that all {g,u}ids are mapped to INVALID_VFS{G,U}ID.
> > + */
> > +struct mnt_idmap invalid_mnt_idmap =3D {
> > +     .count  =3D REFCOUNT_INIT(1),
> > +};
> > +EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
> > +
> >  /**
> >   * initial_idmapping - check whether this is the initial mapping
> >   * @ns: idmapping to check
> > @@ -75,6 +84,8 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
> >
> >       if (idmap =3D=3D &nop_mnt_idmap)
> >               return VFSUIDT_INIT(kuid);
> > +     if (idmap =3D=3D &invalid_mnt_idmap)
> > +             return INVALID_VFSUID;
>
> Could possibly deserve an:
>
> if (unlikely(idmap =3D=3D &invalid_mnt_idmap))
>         return INVALID_VFSUID;
>
> and technically I guess we could also do:
>
> if (likely(idmap =3D=3D &nop_mnt_idmap))
>         return VFSUIDT_INIT(kuid);
>
> but not that relevant for this patch.

Yeah, I'm happy to submit that change (if you don't mind) a bit later
when this will be merged,
cause in this case we can add this likely()/unlikely() at once for
both nop_mnt_idmap/invalid_mnt_idmap.

Kind regards,
Alex

