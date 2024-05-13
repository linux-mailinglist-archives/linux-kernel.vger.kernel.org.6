Return-Path: <linux-kernel+bounces-177719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7A8C439C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D5F1F2244D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26855221;
	Mon, 13 May 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MlxoQiCX"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D54C79
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612291; cv=none; b=ov6Qe0Nsg5qMKlla73Xl3WIcJIAtYLOFmSTAaZJlNgJfNUo/iNo4W7ebVyz+0f9rXAAmJZfHeKQTXEcBGh73CCL7QGtKRGBKdFWFN4Qu3tib9uxsgDdDpXO3W28NFPQzYoaIEaUfqx3ZR6DSeHx6p37rAuIcbey+L6Bv9HMLyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612291; c=relaxed/simple;
	bh=j9bZZti+9FQ+7r5shz9bNfaDhSYxfYzTp3+5PA+YT2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+xDitj8BMgm6t53WNeWjGchS3XQ8L/XYjS4nH5SU40PQs4rFS2MYYDMt3CtsB9cTUJnitTiYlwPeMFXclmE+a30rC7jYrIhv/o8Wpj+GGN580pw0qeeZvRqlT2qauIuPAvBCF8NaiLKT9YQsfPN5qYKZwPh895E5ZZftCSOUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MlxoQiCX; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de462979e00so4774511276.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715612288; x=1716217088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M0SyizaRAHUtRPojEicOMbmKA68tXqqO+2+to/w/2k=;
        b=MlxoQiCXSbrfMPXkGp2CySc5KaQkGq4Lb35ptU6hanGbEN0eefxIMEFmO8kqSY/z31
         1hZSAoZtQLSjl+3E4S3icY0v9aT++r/mSboTlo537FdpEFrEXAuCkI7fYDMwptNvwT8m
         XcI7BmZHgPJAdZQWN0xpyRG6Yae44SqlOS1OhzXaO/vZ/XYjQ83q7fmCfowOP4TwC2EN
         38aCZX2r1aAwtdqGpUWpqu3fPBUWxku4JHE2zoIyCb4Mrn04fVauh8/OOoflfoOEkrwS
         VO+KKuN+QhvyJgAb5E5e1ki7klFsPz3CE2rs6b+i3hvQCZ8McPk1UgJtWIrniTkBicDv
         7J1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612288; x=1716217088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M0SyizaRAHUtRPojEicOMbmKA68tXqqO+2+to/w/2k=;
        b=jXeHl8mA+3194A8ZlxC9JH3M/YeOmbz435CEwu9hWsIG2pVJCrhaPRCMKJw35hbClg
         dsPCvFwLlDxESEDVb2PTpEztnFboJnNwtV9WTTEM4dZnCD644JLsAJuY8a0acBQjucYu
         FyvBFgjTvsiB4RrjUpkLkeBqqAh0oHAARr860kvEDDfmAhw387TBTkryJzDoLjovQRR6
         /uqs3eyTKvdJT0ZtSUes3oLfhA9V7eWSeeuH93MZa0X0dhd1W0tgqla092DteyCTEnWa
         PGw58mKSz5p4AeDQbhe2aZ5YdvmWimS0mK8rt/4FiTbcQ2FDkmkvZDOs1mlWXBodu9Vt
         xqIw==
X-Forwarded-Encrypted: i=1; AJvYcCUFrElIUBgdlnxJdBqXBLl7Mlzv33TlmYxCW728kAe+I1BCUuGoeL2xO5axYoC9JSYfHE8zQ39NldlybZ10NDwv/Fd9IOVGk1t0VND9
X-Gm-Message-State: AOJu0YwEPHYf49/TPlZ8ms/rCIkBAd5qYrlEDvTae/THvJcWMhoaSKmw
	ioAUK4VF7XmHm5MJv2FM4N1WGoPOtV1m7gN7ewz0dMooM/aRTcxBYqUVLcM34pAd2ey19TUihWx
	6hCSxWOFiMWFc+6Ii07cOWtSnMXthrR8cyYL0
X-Google-Smtp-Source: AGHT+IHDwN+8pFFHqgzAJfSHa/ND4FCnNNX1ClwsHGCc0PzWIetjNmGPFOImdjRGWe9tJ4iyY/v+WvT8iIXTHbiGQJ4=
X-Received: by 2002:a25:53c7:0:b0:de5:5b9c:4452 with SMTP id
 3f1490d57ef6-dee4f319277mr8718086276.21.1715612288420; Mon, 13 May 2024
 07:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
 <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
 <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com> <147b0637-7423-4abc-b7fe-3d8da2c1e57c@canonical.com>
In-Reply-To: <147b0637-7423-4abc-b7fe-3d8da2c1e57c@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 May 2024 10:57:57 -0400
Message-ID: <CAHC9VhRbHKkdtAC4JWFbWpj=T3MG7wPhH1EHhJomKu+pU6oCQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: John Johansen <john.johansen@canonical.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:10=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 2/27/24 08:01, Paul Moore wrote:
> > On Mon, Feb 26, 2024 at 2:59=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>> On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> >>>>
> >>>> aa_getprocattr() may not initialize the value's pointer in some case=
.
> >>>> As for proc_pid_attr_read(), initialize this pointer to NULL in
> >>>> apparmor_getselfattr() to avoid an UAF in the kfree() call.
> >>>>
> >>>> Cc: Casey Schaufler <casey@schaufler-ca.com>
> >>>> Cc: John Johansen <john.johansen@canonical.com>
> >>>> Cc: Paul Moore <paul@paul-moore.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> >>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> >>>> ---
> >>>>   security/apparmor/lsm.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> If you like John, I can send this up to Linus with the related SELinu=
x
> >>> fix, I would just need an ACK from you.
> >>
> >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> >>
> >> This patch looks good to me, and while we've still got at least two
> >> (maybe three?) more weeks before v6.8 is tagged, I think it would be
> >> good to get this up to Linus ASAP.  I'll hold off for another day, but
> >> if we don't see any comment from John I'll go ahead and merge this and
> >> send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> >> happy if v6.8 went out the door without this fix.
> >
> > I just merged this into lsm/stable-6.8 and once the automated
> > build/test has done it's thing and come back clean I'll send this,
> > along with the associated SELinux fix, up to Linus.  Thanks all.
> >
> > John, if this commit is problematic please let me know and I'll send a
> > fix or a revert.
>
> sorry, I am still trying to dig out of my backlog. This is good, you can
> certainly have my ACK, I know its already in tree so no point in adding
> it there but wanted to just make sure its on list

No worries, reviews are still appreciated; just because a patch has
made its way up to Linus is no guarantee there isn't something wrong
with it ;)

--=20
paul-moore.com

