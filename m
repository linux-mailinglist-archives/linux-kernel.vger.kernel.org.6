Return-Path: <linux-kernel+bounces-440496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764E09EBF15
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311EA2848D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339EF211272;
	Tue, 10 Dec 2024 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LixPXPqC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F21EE7BC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872356; cv=none; b=cZahIPyOcEfaLfOs0cjp33i9VF3Ee9b6db/1SaiKO5YUeMjdGrswdxHIwpx4Mt7kkt3Bq4nR2uCd3uDhfWNAgMqmBFYGOco5piyy6AumqxpoVQo3RPAzaAb4PZeLr/GpyWDw6+h7oFUVJx76aGRrL+JHPM19/czbiYu5SroFqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872356; c=relaxed/simple;
	bh=sN8h4y3sL6hRB/FVyLclbUwDfXQNaStYrJ5PxQJ48QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Su2s1y5hv1RXybddwF+/HuCt7uh8tTL2AfqtYo5C+/jWi0ifMfTLknQIfKeH3Hp2byhZlPXCQHhPyQEAH+NRHPxh/vudhBYik77p+nIRQhCV1bI1qQO62gJB1i5xqbcfAY3nejWwT/UNSyaRL/22OkH0DvrmtDmfrWVea3U1tQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LixPXPqC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3e638e1b4so727a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733872352; x=1734477152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ktWoM2RO50AIk62xE/mUhtdnzdqp6Qodwc9F6o3J3M=;
        b=LixPXPqCb6DRQxvH43iSPndEZ0NC8e22iIaPrSUq1F7CjZS2CJZWrLhdWLEZbvIeWM
         Hm/jWBgzjyJipTB4EA3IRXholGu+frPRJwb3FVilVrj0kxXrOQPnqAlmBkHLUEwTvt1C
         ggdlyX2RlJpgJ4YzXO2jd73Rw8Mxf5FFnI4bUox/SYvSxCkE5Hj1tu4yG+DbPb14vqmX
         tQ8fT+ynX063ghk8PTezJIIGfZu9O58krJsXg6MuV5XnohUFndOl+kgIQRl4+9vnvBM3
         FgJOhghluwTbMwyUtBmqBa4cFq557g2h9AbqP6fb+1UmYQryPXecGwqor6KCwwJUuVXt
         sSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733872352; x=1734477152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ktWoM2RO50AIk62xE/mUhtdnzdqp6Qodwc9F6o3J3M=;
        b=Cs47TVyXngSKFb+Tqpw+tvWdvnP3CTRqKrAeQSG37sKD6HaZu3Nz1/FdfFvLX6ZGHd
         aAcnJYudBHMQL+hXKcFQwftxrZmDmfZU+3Ffov8gYMwDhXeznBfaQ9MR/oo5u2zbgWks
         h4Jcp+GOkt//EA3K4wzprSxQmLPRKPcX8MfhGxwePv2D7nwcPWqhrkFc4B+F0WggPZgX
         ZN1MwhOsSCxx1FOI1HnhKMzDt+/eKUU7NQiyOhgdgSL1w9FBhv0SOSU4bsiIsx6ukmb1
         O4OwnyOwZNGHwSc1AS21UZyoFrv3MrQIigdIAoKve77SDPA0ETqDf90e0aiNexxnz6dP
         vFDw==
X-Forwarded-Encrypted: i=1; AJvYcCW0N1WQzEfkNJ9ZSQyT5fteBgXZIw5xclielJqAMCkPGR2w5ocbbm5RcnAETJt+SPnhYoE6QiEpk0eMjzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsouBjupbZlIReR1QoiK3NM6QDc1pexM3ST3JzuZNEdZoue1du
	8xawfHCgVgKilHAwELgK8lClTIJCzuFab4QUk3a+YNdiqkSmtNDVk2+nVPzqxxuWt7xd7tbnlzx
	FayfPgIcjlJIR8I77GqBVicxbkF0zWqIEKlSp
X-Gm-Gg: ASbGncvegcdh9qa95/ZpD+JRkrxMWkfMQpd7d2iULgK4OJhpwwXb4vWckNN5nGJO3/0
	uK5J7qJLzhCcLgnNH8g0hgcLnxHPJ109iB6HK+gsNVMq0szgezOvAgS9+mYMfV0xs
X-Google-Smtp-Source: AGHT+IFg93uOLvg+U0JqZTijgyGoPZEhO04pg5mVTz8T7IazCzxdGADHif0Wl3o6jYGRQnOjr9uTt6hydMk6lXR7lwc=
X-Received: by 2002:a05:6402:b8f:b0:5d1:10a4:de9 with SMTP id
 4fb4d7f45d1cf-5d43423be00mr11289a12.7.1733872351659; Tue, 10 Dec 2024
 15:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-udmabuf-fixes-v2-0-23887289de1c@google.com>
 <20241204-udmabuf-fixes-v2-1-23887289de1c@google.com> <CAEXW_YRb4PsFgEvHW2QBDY5dxJ+aoMTn3qtj5v9eboxO3SxPLg@mail.gmail.com>
In-Reply-To: <CAEXW_YRb4PsFgEvHW2QBDY5dxJ+aoMTn3qtj5v9eboxO3SxPLg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Dec 2024 00:11:54 +0100
Message-ID: <CAG48ez2cTrD2_4iKo3+zrPH=e29znYOKLBkC4OLA3yhsu5oMNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] udmabuf: fix racy memfd sealing check
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, John Stultz <jstultz@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Julian Orth <ju.orth@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:51=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
> On Wed, Dec 4, 2024 at 11:27=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > The current check_memfd_seals() is racy: Since we first do
> > check_memfd_seals() and then udmabuf_pin_folios() without holding any
> > relevant lock across both, F_SEAL_WRITE can be set in between.
> > This is problematic because we can end up holding pins to pages in a
> > write-sealed memfd.
> >
> > Fix it using the inode lock, that's probably the easiest way.
> > In the future, we might want to consider moving this logic into memfd,
> > especially if anyone else wants to use memfd_pin_folios().
>
> I am curious, why is it not possible to have a reproducer for this
> issue, is it not reproducible and is theoretical?

Sorry, I think I must have forgotten about this part when I wrote the
cover letter: The original bug reporter (Julian) linked to a
reproducer that is linked in the bugzilla bug report, at
<https://github.com/mahkoh/udmabuf-seal>. I haven't tried running it
myself though.


> thanks,
>
>  - Joel
>
> >
> > Reported-by: Julian Orth <ju.orth@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219106
> > Closes: https://lore.kernel.org/r/CAG48ez0w8HrFEZtJkfmkVKFDhE5aP7nz=3Do=
brimeTgpD+StkV9w@mail.gmail.com
> > Fixes: fbb0de795078 ("Add udmabuf misc device")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>

