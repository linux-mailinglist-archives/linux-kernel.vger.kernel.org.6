Return-Path: <linux-kernel+bounces-228000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B80D915997
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EE91F22922
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266E1A0B0B;
	Mon, 24 Jun 2024 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FEVYhuYo"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97F13C901
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266875; cv=none; b=iTJrYO5RlEKPNFnj81OjwI6VanYx8r0xjCxkaf3c3bwuyG/MH2xCgd5R0dvc+tT0KuYNBE6CH8yYBtSrnyNikEtrLf/Hb+aQWDExFWcgb3FBL5IPeTxEKKsqFwqT4U73w8smj58FF+9g6YsVHq3WD1Nibpv8HXW9UP717UX4zJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266875; c=relaxed/simple;
	bh=opT9chxOr5SNeIuK8SI/neAZbgaJe17hZ4b9hMCiFJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxZSFlDBbMXvyLnMLhCTmc/KJ12S6S59ZrEG9WOShXC5Qulb3Vd/CTwtUGd5dMw/2Qaqr6t5evLPjuoA3gQ0js1Jx/40taF0PtR21zleLdgDqfHHuhbt1QHVIcgk15ytlT3flMGoyvp+WXgSxgZDKkXUJbmUDR53NEkcBgPCft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FEVYhuYo; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-643f3130ed1so18234277b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719266872; x=1719871672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fszxPVkXOEv4ipvfMeUYMBaHCtHM5VmJKexolLOZC+U=;
        b=FEVYhuYoJJznA45oTekzWcNv7XJDGavcA/3HwyVgrfL4jS6mmMVPiskJvI5RJ6Vy8v
         835pLpHtMZwIG4ctHgGh5977YNimJwPzLU3Q6D9CD96dgHYBQuNpndXkc9C6dOQprfbu
         uLfkbG9J5l4SsJmeLMd0IDwLPY7IUkUn/yZLdX2v0YlP5wZ4R5SEYi0NHV5v7IaP/1hh
         qb21VWUfuXQ7zMBb1ytR9XmGkkj/rGAQwpWV2E/F1XnOkLhYu9684ZosLUNnTi4nYhqD
         N+ngFu0+ZpgoldrlBq1FR3OMWGBb7U1wiGxbcbTGixxf/p49QvEcKbQ+9KsnuZto4bSe
         97IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266872; x=1719871672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fszxPVkXOEv4ipvfMeUYMBaHCtHM5VmJKexolLOZC+U=;
        b=Hc2UvOG+m5tZzvM9AuH+z7bqxuzAwb4TvuPvucZUtU5Ks/7arH/BrMLYhuIemJqNbp
         rTxliDZsvebxJbS2BDiUTNreBjhyxK+Wsf4AaD6xWIORUUT7cU5HhIhcKrVS+gpIFilL
         PmOeacNiAi9klLBSEt3oocuXXsc94jOKK+p0EgebPgn8YDAG1d/5vViNVJ5jJom7UCD5
         Annfjs88uabgzTLde90Ztg3nwwGY+v/wNQhR3Y1V9DAZl5znpt7En5mu3qAXCzkytRqW
         2i/IIF/SRftadKnf6tXY3LtBB+hd6oekaWp/frqOkQtgatEwLBaMnW3v3G3oyIKiJab3
         RgUw==
X-Forwarded-Encrypted: i=1; AJvYcCXc3GaffW/Bm2El+vRV6YVyt3HCrYh/eSS28QUABQ7XRZAcEqeepwH3bSudikYAMvArtEjyt9fB2yhyOs4+wK4YFr2wMHadleNhXWK3
X-Gm-Message-State: AOJu0YxOKvt8MyRGxYqifYolmphgqGt5edaUnHy5yt5qqXjYU9mOmBoH
	+0suywxq6bAiVBjIc16XrE+I01ysHGT6EOWrZcwhaqW7JMsFDc8FA85p/UZWNwmNN1E8+xF2tpJ
	mg76gfT2gbDd/u+ylk3lO97284FqwARvWQkYu
X-Google-Smtp-Source: AGHT+IHOVgf6sPtvz7xkzuxIJIFBk7OeedDuU5iG83zGwr53aHKkAXP3cmaTbi55yIsmL38DOo+j8by+9wv8qdnxftY=
X-Received: by 2002:a05:690c:f93:b0:633:8b49:f97c with SMTP id
 00721157ae682-6429c6db0bcmr54456627b3.37.1719266872555; Mon, 24 Jun 2024
 15:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-3-casey@schaufler-ca.com> <CAHC9VhQnzrHPRWKvWPSuFLWHhcXkwqeAfXsFbEdBBOMcACZorg@mail.gmail.com>
In-Reply-To: <CAHC9VhQnzrHPRWKvWPSuFLWHhcXkwqeAfXsFbEdBBOMcACZorg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 24 Jun 2024 18:07:41 -0400
Message-ID: <CAHC9VhQeWF814h8+ho3uKuz+NvvFApwJo4FkdmoRvYpuTcrk4A@mail.gmail.com>
Subject: Re: [PATCH v39 02/42] SM: Infrastructure management of the sock security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Dec 15, 2023 at 5:18=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > Move management of the sock->sk_security blob out
> > of the individual security modules and into the security
> > infrastructure. Instead of allocating the blobs from within
> > the modules the modules tell the infrastructure how much
> > space is required, and the space is allocated there.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  include/linux/lsm_hooks.h         |  1 +
> >  security/apparmor/include/net.h   |  3 +-
> >  security/apparmor/lsm.c           | 20 +-------
> >  security/apparmor/net.c           |  2 +-
> >  security/security.c               | 36 ++++++++++++++-
> >  security/selinux/hooks.c          | 76 ++++++++++++++-----------------
> >  security/selinux/include/objsec.h |  5 ++
> >  security/selinux/netlabel.c       | 23 +++++-----
> >  security/smack/smack.h            |  5 ++
> >  security/smack/smack_lsm.c        | 70 ++++++++++++++--------------
> >  security/smack/smack_netfilter.c  |  4 +-
> >  11 files changed, 131 insertions(+), 114 deletions(-)
>
> I had to do some minor merge fixups, but I just merged this into the
> lsm/dev-staging branch to do some testing, assuming all goes well I'll
> move this over to the lsm/dev branch; I'll send another note if/when
> that happens.

Everything looked good so I've merged this into lsm/dev.  Thanks all.

--=20
paul-moore.com

