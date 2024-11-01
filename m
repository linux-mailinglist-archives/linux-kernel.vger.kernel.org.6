Return-Path: <linux-kernel+bounces-392611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5009B9633
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F2E28408E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AAA1CACF2;
	Fri,  1 Nov 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Tqy/poq9"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9213777F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480593; cv=none; b=m/LaXEtdIuOke76BTLX9u9VvfnvKODec5GsAFQ8Aq08XUZynWP+xPAzSCW2H5aMWN/XLa0EQMxzwAB9O5p75Nhx2adDUB2CiAtWG23KYO73GY8wfM7Q3GGDLFo5TdVthDwOeWPP2q8idG8LPvXX4et6rPNv7CNSnP+LB/mAw//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480593; c=relaxed/simple;
	bh=F1UjkDS8cPDIM5v+JgBc51HxVQC+LyV9d08o7bvS4DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9r5yNvJ3ld9cX8teo/VT6YhFPArH9aSJuS1saSAFRAHKlSoTcoDDcRBj5dMB71HAgBlU4UeOfkZb8iIW3lu0eXvdIjLEvPHYbjcqHZjI+WRd2taHHdHhGu/SsG1Ld6ilG1IwEfeSLL5/nuihnC09P2W1PF4MkfN4XsVhXe9aEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Tqy/poq9; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d525be53eso634061e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730480590; x=1731085390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gzkEAtRLERKJA/Tw0nk+QI1E4oIoMTkMUA7GP+Au+o=;
        b=Tqy/poq90wjcydWwoNtWiv83X5XX+VG+V+dd03jGixQMTtEtnYVb+0Eyug0D7P1TKr
         O99z9hCTxlPTX9OJGTpjNJxIyAlu6T1KLU9FRyuTFTdptkacW6u5KPg/qPCldnM68DAR
         Bk5mrCXQAwJKmU6iQncvwsGf0QpiW/AkD5q+55Ni6WxG0PK2qm3rmYilHTSln4SYZxP0
         EAslw2h2ZaS+31gL5VWRZpIvH9IurR/UrfMNTiklCzGH22ZA5/sQ++epD5gH/M7Jz7Uu
         caIndQ4TXdYH22DCABsUGJ2eCW9sLFtC9w6XF6i8CmbMIaNS20IilrT43mQlQcn7L+fG
         LwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480590; x=1731085390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gzkEAtRLERKJA/Tw0nk+QI1E4oIoMTkMUA7GP+Au+o=;
        b=Of2JQ6N/X6q++Ac3Oyhu5pzN4ix3Ld8EL79MvlSTzHcId4aIi93zSQZWVLt6vUFsao
         4RxCq170IzATCOPksyEMu6oGRLXHii0U0roWixwnrV+e+IybAzGIQcsRsbkdSJix3k4C
         kw6u+NpJ5Maaqj0WVdkhCiNJaa9XsPGGc2VWaY0C0Gffi0ZZssdeTmvarkIk+vGkWdXs
         nrpFDWulKS2E8hUyGTELeDM11UAbHyON/wA8o+LYFjfHuq1obc6xRGaVAAnDDXWl6gSZ
         YE+/sOoWg0UdC4GKbN62WWS8IyEo/NR5mv949Ro41HJwV0vAmnyETnufW+YUj1SHcxqi
         8mWA==
X-Forwarded-Encrypted: i=1; AJvYcCXzsZmbKVZWduHy6R+lB+avXwJFUDmFNFjfkefAVQoTmv6zFXqsHvR7PDb6ATro7y5fIkEYCZM6DrYzD4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYHL1RV/1F0nV7pU3kpJAQXINH7g9RTMFrLzAJ5OumG4NcS0T
	cVR3YHO4hy58yUvOsAPppi1tJkWJVW3Smov8lGeR4FHoh6tx94ZmBLK5rvZrfgkbLD2dSBYt8ro
	sGL773gT1JVVEs6gbhVDSv2Mnl3Tpg595lap+
X-Google-Smtp-Source: AGHT+IHkpPN4aN6KLUER6T2zoHuJl3oBHnwC2V6UG/2nPgr2gh6oNQdtyJXnQHM7hBzNjZ+Jm27G0JaaA/bWSq07fVw=
X-Received: by 2002:a05:6122:90d:b0:50d:5f75:f7d9 with SMTP id
 71dfb90a1353d-5106b19b8f7mr8848634e0c.9.1730480590520; Fri, 01 Nov 2024
 10:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
 <20241101095620.2526421-1-aliceryhl@google.com> <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
In-Reply-To: <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 13:02:59 -0400
Message-ID: <CAHC9VhTKzXPja5mLHmqOoTiDm1K8k=vtK+x9Hfa6t-7hpMmwag@mail.gmail.com>
Subject: Re: [PATCH] rust: lsm: replace context+len with lsm_context
To: Alice Ryhl <aliceryhl@google.com>
Cc: naresh.kamboju@linaro.org, casey@schaufler-ca.com, 
	anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	dan.carpenter@linaro.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, ojeda@kernel.org, regressions@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	lkft@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Nov 1, 2024 at 5:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > This brings the Rust SecurityCtx abstraction [1] up to date with the ne=
w
> > API where context+len is replaced with an lsm_context [2] struct.
> >
> > Link: https://lore.kernel.org/r/20240915-alice-file-v10-5-88484f7a3dcf@=
google.com [1]
> > Link: https://lore.kernel.org/r/20241023212158.18718-3-casey@schaufler-=
ca.com [2]
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/r/CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyK=
EzJazDsdk9o5zw@mail.gmail.com
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/helpers/security.c |  8 ++++----
> >  rust/kernel/security.rs | 38 +++++++++++++++++---------------------
> >  2 files changed, 21 insertions(+), 25 deletions(-)
>
> Thanks Alice.  Would you like me to pull this in via the LSM tree with
> the associated LSM changes, or would you prefer to do this some other
> way?
>
> I'm going to merge this into lsm/dev for now so that we fix the issue
> in linux-next, but I'm happy to drop it or do something else, let me
> know.

Nevermind, no I'm not, as I don't have the LSM/security rust helpers
in the LSM tree as it looks like those aren't in Linus' tree yet.

--=20
paul-moore.com

