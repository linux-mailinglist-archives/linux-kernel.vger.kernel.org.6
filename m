Return-Path: <linux-kernel+bounces-448269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C69F3DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178A9164583
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A831D90A9;
	Mon, 16 Dec 2024 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KQsV/XqD"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB71D63D1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389994; cv=none; b=K/NUobFOKH7blPB3BA05XvqyI/NkbfYKZYyweXT2uTctMbquVePWO+701YCfrKfEQfpfjzgCkk1t5EgtFIeNNJXiEkb6uGypTrpcYeRWtV8e2qicB5BxIevBsgRKrv4nFTdwy9qo3+8CQV0qOWYpXsB+stnnqplAoIore2N0igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389994; c=relaxed/simple;
	bh=6CzZjhZCFL0Ybneq0eBqdaZBEzuWpGJse2bKpcrxqa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMWXjnJnV+gZsNb0HyLY4qTG7enzMEmxv+M8YhU3o2LLZyFuA5p2AvxQ3oeBlaiPkJFYIjFYT/+zsD5mj4kChqgBIxWLIveLZ6G31ysyc0i1JIl0/GlwyntYFkdefZLiymiwEqYysTkR+PAW0Ri9eKg6Ky8PcgukmC+eZq7AhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KQsV/XqD; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3989d27ba3so3410892276.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734389992; x=1734994792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Lfh5UPu/j3h78rAA5gO/RJboYcPhcbanZwSgKE8DBw=;
        b=KQsV/XqDdIcSoWC0jtN8CqEdBKzOJlxalmyuyT1KpFpXxNcHFKXV7JyukNCzBmBnjO
         MuN++EEGRrffkyaxHHidZrVfZIItV2DcQZQIeklcHU9caK3X1IxT4vJKzr2SRX40bRgS
         0e9f9mQnQ6QGm3aL6E16p6+jEvqvYr6e1tLDOsQ+PEFawqkDN+ETMCh2EhtBtKaeamMk
         8zbpV/sQmpNHZu1bZgiYAggXduDhRmlgQytvzSQf8bs9bpaV4kcrtqBMcVdDPL8iItBA
         c0e3g0kT5R0wV89d1wNkaUUNUDPfh5NF42M8vYzPEcoo77RtT8xTF4SJfwfe8K9qgA4t
         Vqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734389992; x=1734994792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Lfh5UPu/j3h78rAA5gO/RJboYcPhcbanZwSgKE8DBw=;
        b=dIUJdpTKI/qcQAkRIHm22ruQYcw8rCiuwbzpvSneCXCFLo/wta7DcmwCsRI5fJQBSt
         PgRDyBFLgSNI4Ub3ebVE3nXrV0X4HwTag5WIkIcdpFAU2dVHRwbaf3nB6ZRLdOg8U9i2
         g/l4g83FkIZxWmCoybQIWeSb1io1CfVpAicScoDVwcg6/NQZ0leI4BUQERnhjJLtdyQW
         mi5De9pVHU3M6DK3cILKDhVWA6uW/UYoh737kHAlzIuYAmSvVs0oW4skgX3GsQ1Af2Vp
         qxj6BMnuLQqobhsWDDANbpbk4nYtriWdg8MT3l1pOIS44snnOsVj9wFUAp9P0uEFPqaz
         hAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlCJ3zXD5GnUSJ8vX/iyiT7/NJABah3xWx4N1niA5/Ulr9SCp9yUYCuuL+AuoCzLHLh9MfYDfB6VF7njc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQ7BkJTJHbHusOOlLadCRz7VzaLVwRjlGr3Lr1HNOv/YAgN7j
	YCbN20AxHq/00SI84Tq1obQ6VfRrQT9DnEikbRRTXMWfkpXJE0172g3XsOvOmBnP+QMq+gFKtDG
	Kq8CtShxC3GTIKqbYWW+mPVE53CkrPeqfve4C
X-Gm-Gg: ASbGncu3fIkLKSn2zc+gFJqRmxAwaiFkWkl2cE/lmtH+OPt8WjF0Rqb08xxCYBG4C2J
	7APoa5wHjsO96H+LuZ5bKA+z8t8MRx9XU6Awx
X-Google-Smtp-Source: AGHT+IH7eibkUq2e5Dc3R+veB818DrzM9GHb597Rjdip4BACdsyaPWU/84UKp8Q4zq5Sq5eeEXCS+lMeszEgozCdizo=
X-Received: by 2002:a05:6902:2487:b0:e4d:89e9:6a97 with SMTP id
 3f1490d57ef6-e52f963078dmr1437392276.3.1734389991958; Mon, 16 Dec 2024
 14:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241216030213.246804-2-leocstone@gmail.com>
 <86023b72-1a45-4115-b800-93297a3e2405@I-love.SAKURA.ne.jp>
In-Reply-To: <86023b72-1a45-4115-b800-93297a3e2405@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Dec 2024 17:59:40 -0500
Message-ID: <CAHC9VhRDrmNBF7ta_AHNbztDZ90zCJ81+m+4inGu_Jv2m2dChA@mail.gmail.com>
Subject: Re: [PATCH] lsm: check size of writes
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mortonm@chromium.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 4:59=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/12/16 12:02, Leo Stone wrote:
> > syzbot attempts to write a buffer with a large size to a sysfs entry
> > with writes handled by safesetid_gid_file_write(), triggering a warning
> > in kmalloc.
> >
> > Check the size specified for write buffers before allocating.
> >
> > Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D4eb7a741b3216020043a
> > Signed-off-by: Leo Stone <leocstone@gmail.com>
>
> Since handle_policy_update() has two callers, you should check
> inside handle_policy_update().
>
> By the way, since syzbot found this pattern in multiple LSM modules,
> do we want to ask Andrew Morton to send all patches in one pull request
> (instead of sending trivial patch from multiple LSM modules) ?

I think you mean Micah Morton (mortonm) and not Andrew Morton (akpm),
yes?  Micah is the SafeSetID maintainer while Andrew maintains the
memory subsystem, and likely a few others.

In order to help prevent merge conflicts across the different LSM
trees I think it would be best for each LSM maintainer to merge their
respective patches.  If one of the maintainers is not responding after
a period of time, I can pick up the patch via the LSM tree.  We have
had some issues with SafeSetID in the past, but I'm hopeful we
resolved that with Micah and we just need to give him some time to
review and pickup this patch.

> > ---
> >  security/safesetid/securityfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/safesetid/securityfs.c b/security/safesetid/secur=
ityfs.c
> > index 25310468bcdd..5eba4c7f8d9e 100644
> > --- a/security/safesetid/securityfs.c
> > +++ b/security/safesetid/securityfs.c
> > @@ -254,7 +254,7 @@ static ssize_t safesetid_gid_file_write(struct file=
 *file,
> >       if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
> >               return -EPERM;
> >
> > -     if (*ppos !=3D 0)
> > +     if (*ppos !=3D 0 || len >=3D KMALLOC_MAX_SIZE)
> >               return -EINVAL;
> >
> >       return handle_policy_update(file, buf, len, GID);

--=20
paul-moore.com

