Return-Path: <linux-kernel+bounces-226398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C5913DCF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028D8B213F3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73286184133;
	Sun, 23 Jun 2024 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RValyZn4"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21FE3BBE2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719172687; cv=none; b=ZQXxM91gUDeMqvMlDE5qDsoBcF4TFOfNjTQ2wInqCURve/cjDlvKGZfy1aDUDkigsxnjb5Awc0vIWHI4VbTRlgJuv4i+qXxYEHKf8V1JX4jKp/InJMkaoZ4Ymtd+I5IEBjCOtZPZGQTznBxAoZOwY+9mpJDx6lgR/r9OA3qwYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719172687; c=relaxed/simple;
	bh=zDU2UcQI5rojl2mKeivQSF1G2P6Ava3nXMNTFcgcyfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkrhGn6/4IhG4MsHXyWjqM15vpsvDo4iJ5GdebN5G3OQflQqEeDFKFqesZlc/LiNaMk5TOiIY0EnSZHcDlru8H+3cPOLEeKtckS2iYo2IAj7Ng7GOwxzct4Mo0ciH6BMF6hyIjtxAETeOq1wJnZ2At4RxM/94zI+34uTTtKqj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RValyZn4; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso3671836276.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719172685; x=1719777485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L935TfPsSs5fPfvxhR59Cz899DgU7q+IitpDJf5wbbw=;
        b=RValyZn4iVnbWl9hHRLL4pyUeAvXuj1PO+Kxpb9DetuciuRcvDxQzAIkQYfoYIrpPQ
         8PHbOhB5XwZScxys/IONgDItF6wpC1z8iJbrlFSD4LMIwREdQbGD0//LpJRGaYtJziME
         Re03ghb0Q/1+7yVBMHKVDMhDdcusZnTee4Tgi3zMeRc/qsiuDncsmxOX06qV6oIgpZBY
         iMEuh23yDLpuGOpr5Uo6iqf4tsrNH/5wX1l4tiXEDQxkw3oa1EVHolVkpKsoYjx6Fzdw
         JJmqHd+BFhovxVdB5R5SvSKup8K8nH0mCjyH68TR5EgY6RTLnYXdQ96faBlOP60QtGLc
         PC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719172685; x=1719777485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L935TfPsSs5fPfvxhR59Cz899DgU7q+IitpDJf5wbbw=;
        b=Ujtg2YwPajyiC1kmjEWUSEj2m1qH1RoPY47DmG5jxhAer5hRcdIAmfzhv4xFDdqSAi
         z2GhftU8UA3hVOyOSi0Gy2Hnupbr/H+e+jJ0jALZYt/Xsni6bqrRMRYsOt/MYAkbNGur
         0Z/Nk+FBfQ/zARCpuMfT5FCdPiB/eYfE0tcT/Jz93+7E412di7tFJ/qvjQuUGhjZ0thg
         LqWaPhBXx/c13uRm0zaCMZ2rk3+aYINI5eNnY5xAZe/Zp/yegPuStIZsrk+BI1LQzLBU
         ifAn49FZcE44aqiv7kte+ruxjJdY9OqJsVd0TgLyL4DhsDRz/N0GZdvgV/o8Dz2LtgfF
         UD1w==
X-Forwarded-Encrypted: i=1; AJvYcCVjFnqrlhq9vATf6zOycD8cspLyOwjB6vmn+O6z3J46p/eBG9F8FpO18rqe6fCtViakvld6QSSVpYZRmh6NmnifX62+ogqpm+OaLo8m
X-Gm-Message-State: AOJu0YxrvRQEe3nJz8yBtCKfG2xk5sztXFXoaDuzom0vgJzu1zmX48+k
	wcLfg7+pVsmLPbuy3jozjvPE8w0FjfBsZVJGn2+U2+YaiYDdLVKd6ppWqmjbUqAtnFAYjTVh5eO
	I0WtSWvlcthF/2MI7qT1CS33dNLbeas+TfWXX
X-Google-Smtp-Source: AGHT+IGCoHamBCvZArDMlOqMLOKeuW3LhZTZRSKdsazoc6q3eCJaQq1HPmh7IWp4Sz2/keVwTbtL8KnzfMVsliNNFbA=
X-Received: by 2002:a5b:dc8:0:b0:dff:2ef1:e3d5 with SMTP id
 3f1490d57ef6-e0301101c58mr1994522276.63.1719172684789; Sun, 23 Jun 2024
 12:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-3-casey@schaufler-ca.com> <CAHC9VhQnzrHPRWKvWPSuFLWHhcXkwqeAfXsFbEdBBOMcACZorg@mail.gmail.com>
 <aae5d7de-d3ff-4a67-a8f6-fea293bee0f6@schaufler-ca.com>
In-Reply-To: <aae5d7de-d3ff-4a67-a8f6-fea293bee0f6@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 23 Jun 2024 15:57:54 -0400
Message-ID: <CAHC9VhTK0etXQ3X4g4E-v_d3f50waoatbC2ihJ8vOV2RmwMYPQ@mail.gmail.com>
Subject: Re: [PATCH v39 02/42] SM: Infrastructure management of the sock security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 6:24=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 6/21/2024 1:31 PM, Paul Moore wrote:
> > On Fri, Dec 15, 2023 at 5:18=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> Move management of the sock->sk_security blob out
> >> of the individual security modules and into the security
> >> infrastructure. Instead of allocating the blobs from within
> >> the modules the modules tell the infrastructure how much
> >> space is required, and the space is allocated there.
> >>
> >> Acked-by: Paul Moore <paul@paul-moore.com>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/lsm_hooks.h         |  1 +
> >>  security/apparmor/include/net.h   |  3 +-
> >>  security/apparmor/lsm.c           | 20 +-------
> >>  security/apparmor/net.c           |  2 +-
> >>  security/security.c               | 36 ++++++++++++++-
> >>  security/selinux/hooks.c          | 76 ++++++++++++++----------------=
-
> >>  security/selinux/include/objsec.h |  5 ++
> >>  security/selinux/netlabel.c       | 23 +++++-----
> >>  security/smack/smack.h            |  5 ++
> >>  security/smack/smack_lsm.c        | 70 ++++++++++++++--------------
> >>  security/smack/smack_netfilter.c  |  4 +-
> >>  11 files changed, 131 insertions(+), 114 deletions(-)
> > I had to do some minor merge fixups, but I just merged this into the
> > lsm/dev-staging branch to do some testing, assuming all goes well I'll
> > move this over to the lsm/dev branch; I'll send another note if/when
> > that happens.
> >
> > One of the things that has bothered me about the LSM framework is the
> > inconsistency around allocation and management of the LSM security
> > blobs (the `void *security` fields present in many kernel objects).
> > In some cases the framework itself manages these fields, in other
> > cases it is left up to the individual LSMs; while there are reasons
> > for this (move to the framework on an as-needed basis), it is a little
> > odd and with any inconsistency I worry about the potential for bugs.
> > I think moving the allocation and management of all the LSM blobs into
> > the LSM framework, similar to what was done here with the sock's
> > sk_security field, would be a Very Good Thing and help bring some
> > additional consistency to the LSM interfaces.  Looking quickly at only
> > the SELinux code, I see six additional blobs that would need to be
> > converted; it's possible there are others in use by other LSMs, but I
> > haven't checked.
> >
> > Casey, is this something you would be interested in pursuing or would
> > you rather I give it a shot?
>
> I'm happy to do it. Would you like a separate patch set for this, or
> should I add it to the stacking mega-set?

Separate patchset please, in my mind this is more about improving the
consistency of the LSM interface ;)

--=20
paul-moore.com

