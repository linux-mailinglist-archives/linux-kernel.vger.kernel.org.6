Return-Path: <linux-kernel+bounces-412828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D5E9D0FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58111F22654
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A8198E99;
	Mon, 18 Nov 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="k4Bo7c+O"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDA19884B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929247; cv=none; b=VFMzpgBdguAqcmkigTpTOZ5GZhb4s8lxqvIGP7VMu1qJ3s9N9inKFw1PvZnQje5TsMq/Rhw6gleZIk7Kw6uyeCNYs7a2zkrKnllgeUmhcj+oR/eJcbMmxSLxbOVfSSDpNxpszWAY0dI1HYRF0mBWqoSrpBH0GU0L0pLHB9WY5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929247; c=relaxed/simple;
	bh=K0mtCJd8nONGgt6SOnX6Hj0t2xm3Jj+RLlpEvfpZcnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwHzpJOgteqFFl2s4j8PYTyA3NWCmA4VdG9W9VSUmVeGnkT6QF8t/y9vAermRZKw8FvrV6uuJO0x7S39Xzyfx4bMXXvQxxxyw9jycIfplTagEO9N2wwVUuu2QSCPnSnpWmmMZkPHVEQyORzFxBGRB0g0Uu8RtDgSxrarvsGG2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=k4Bo7c+O; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4608e389407so57498981cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731929244; x=1732534044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J8PDxhzJH8B4AHfrqhqpoMvxGYTYu5oYrGO/Y3zylAg=;
        b=k4Bo7c+OP6Nj/f4WgD3U8MecnpoNUlBHxRdOZWo6uGI81SPL/oLUDBC1QJeq2INUNQ
         EsaIx8PtbjVY2MNRBmILjBfWvuxnn4JT8Xetc9kyD1Doh8m8+OZzpciqhCgJgMOEDE47
         RypSWu0KhdNhVPPZI7MZvN8FYUuBLNikzSJlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731929244; x=1732534044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8PDxhzJH8B4AHfrqhqpoMvxGYTYu5oYrGO/Y3zylAg=;
        b=WGW4cIRoNxZkcY3Dz7OBnFjeXsDPR0sI2wpjpVb6ANG05nWfJCZYtVv+caLtxpf9k7
         33XVilLVVhm8qce10lVD+8sv9+ocKFka0JkMC8eq/m6KTMHYEiYyMz4n2apSA3mdyq3l
         ZPkUPW4Y8xaccIBOHXl8q22Zr2zoiVJOshypou1FoCITfGgdvX2CKay7puX2cv29wiU4
         iTEPUd/P9n0q9kC/UM+Bn6FC+JkfjLS9dlA0zmEcacQHDkwZrzxnfuQotjpMWWzf9osH
         iNGsWXfPD/kZoYJGYfB9T8yfmlGzyCuPMHBZIBGd13edfDpWgNVR5Pj/HkVPXUav6Rd7
         FyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhbt5VsXxX+nAATTLzARvmNiS7J7+FGfuKRynpIoRKSpW09fQXVx3q+AqG6Et6e3e7ew5KNuVeZpT6JY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4JEyCUjlA8QI0KW9X4RTkISKqopI1ejmB3cpKpPGWj5Zp5c1
	gowm9aeHVPLz5hfr/m6UoIpq3rv/yxuSU8IZXRNk1Jf6S3wb0dpGTm2bP2xv3s45TOnfemkJeUg
	KXy/grLONsJmWXG9clptNxnHrzzAiMmEJ17W5/g==
X-Google-Smtp-Source: AGHT+IFWJDzka4etP4hQkOIhG/8fXDN0XadWOugrJhDu5wOtdftV/COxcRcK9v5OCrALx8GlCCgDNx7GbHQKZLToitE=
X-Received: by 2002:a05:622a:4b12:b0:461:1e88:595d with SMTP id
 d75a77b69052e-46363e11123mr147552981cf.21.1731929244054; Mon, 18 Nov 2024
 03:27:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114070905.48901-1-zhangtianci.1997@bytedance.com>
 <CAJfpegsF9iYG04YkA0AOKvsrg0hua3JGw=Phq=qeOurgqk_OuA@mail.gmail.com> <CAP4dvseQoAohAZniZysw+gR=EGjMrKyyAOQ69-1FD7BOKS4VOQ@mail.gmail.com>
In-Reply-To: <CAP4dvseQoAohAZniZysw+gR=EGjMrKyyAOQ69-1FD7BOKS4VOQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 18 Nov 2024 12:27:13 +0100
Message-ID: <CAJfpegvxU2kd3Ux1PVei+PcRyy3Qum9MOrd_-pqbwL=aWD1e7w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: check attributes staleness on fuse_iget()
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 11:15, Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:

> > +       if (!evict_ctr || fi->attr_version || evict_ctr == fuse_get_evict_ctr(fc))
> > +               set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
>
> This check should be moved to before the initialization of fi->attr_version.

Well spotted.

> >         inode->i_ino     = fuse_squash_ino(attr->ino);
> >         inode->i_mode    = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
>
> And I will send out the v2 patch later.

Thanks, applied and pushed.

Miklos

