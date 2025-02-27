Return-Path: <linux-kernel+bounces-536898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7FBA48581
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1655C3A74CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745AF1D5AB7;
	Thu, 27 Feb 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fbhShm+I"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059E1A9B5B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674723; cv=none; b=I1K1+znUT3c8XDWSHoYrl/Pr+ihGxXKcdXx0HmrGjK2HIhSjMlKw8HXlVmecSAzW1DUpWUSK7pNk7IMySeRLZ7QPXgFUeNQesRjs1H+5msO47Z6N5uD9x4CKK47PgZLo+SiLLe0M5jh3rzJf8XacGfNnDKmm1ye65KeI88h3MrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674723; c=relaxed/simple;
	bh=DABk5HGlcnVPtrWTwBOC3Bxja7Ae6t+CZeMoYMJ8cco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxGuxtabJgVRSBHfxVGQO25NkCsPWY22SSyDriGUsKytBL0ZCTqZip4bqiQfmGn5rtLxfohxmMp4c2dj26oYeP59MW7PdBq0HcuuUakBJ/5Xc73obUeYDQbNgpThFk/nemLIUGDeTAuRsFl8b+yk9bbpVu7yK0jrlmGr5S+Ey1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fbhShm+I; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fb2a0e4125so7700667b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740674721; x=1741279521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y2OhTDfbYUPSi0n+YD3zUk4WKi/mnjXGnIuCw7tFnM=;
        b=fbhShm+Iwr3hZAUE7me8u4Z3uS2OFwI6zCOTmpxtz9/K3qDYbqXIws+dxvKLXbtOA4
         yjTAWdA4Uabbb9EnnRi3oNrzLELgBJjTmLMBQsH2tLZm8ecw+BdRIMYzpvWCcN5aQHhO
         iwZgPRx5h3WNjSI3aL1cz2Y8qEL/JZwz+eODkbJPHm0/Er2zuMK9cln6QvcsBz68l10N
         WZv22CcxK5tGIzLxLp/HtyTTy4eqSDGAXjUfRdmwgfch8P+1Po8MBVsLHzeSmAYm6YMe
         sgznogmM8jhKJEgknAPGJ8L2YOrsjnG5prdJ+j/U+jvy8r7HI+kieWPFuFVD8mHCupcp
         Hx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674721; x=1741279521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Y2OhTDfbYUPSi0n+YD3zUk4WKi/mnjXGnIuCw7tFnM=;
        b=pjPcDGShBAPXxPrF3ok+tzbH9lCcwEICm34JV9e/fwyH8z95YLN30eS65QVRR3hUd3
         SrcxPOAJohIuklPpXTyG78azx46kRjPbN2FXFpzIRJc1phzM2veje9RK/4m4V/hyzubw
         6CnvBecQrKLOn014RHGFRH43i0pODgf1v2PkkfJutL+5dL8mOxdOlAYplq5exhpDUxwG
         tptk/kFOOeMnNUx34POtzKZD4OQ0G7ZTe+9TJ1WLv4WO9h3EkMCjo+a/QeT5gxe2IlRi
         pGgM1pF1Ah92CWXqbgUyn09l+QHZNUArCV1oJG37VStEwvs3Rlw/XdJf+xSzlpKevSxY
         5Cwg==
X-Forwarded-Encrypted: i=1; AJvYcCV01lqrPTDWvhYkyCqtPi1672lG83nm+84Qa34kJC6G3/wwSPvd8Xrvj9cDlNjWfrKYWm+FmzK77gJ1py8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1COlMMl6+SWc9hCqdNo2YrnqVf6LFCKD7SsljmT19bXxiwXMp
	UA5Gc0YFRTSz2qRjp83BWg54i9MALeApEa26gqysq01woEVKP/bSRTVhrFrKcfYk9ZFmCnQt0A0
	A940Hdtc38bDr3Ld5GOyRHeE8LnfqJN57W7J4
X-Gm-Gg: ASbGncvyfWCcPZJOU3POmgkzPb1PldpBDK8wnKn+xFl5mgxJiN9WL6BLgj5RLyb18Uk
	RKkDp0DYaVKVVh7FmMyIBlhkam7wnzwFP/UEPGMDXEIySZIkoU1QMl2kA6fpurKj0QBheqPXZ+m
	GAsyyqgDQ=
X-Google-Smtp-Source: AGHT+IFstoV34sDpQuH0KrhKiFYaxdU0llmPTWK3akgTdx0dj5ICycOhcMBiHKd218R+yYYVWSp1yVZs1fdJpBpbIKU=
X-Received: by 2002:a05:690c:a8d:b0:6fd:4441:3daf with SMTP id
 00721157ae682-6fd4a14d07dmr1458727b3.30.1740674720751; Thu, 27 Feb 2025
 08:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-sysctl_const-pcmoore-v1-1-d9f918dbb0be@suse.com>
 <CAHC9VhQpkyqaJsxj9_d4d6Vpc+FVbSnH_HeAFAVEdj0trGCh1g@mail.gmail.com> <D8362ZV7Y4YI.PJTF4OC88RQK@suse.com>
In-Reply-To: <D8362ZV7Y4YI.PJTF4OC88RQK@suse.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Feb 2025 11:45:09 -0500
X-Gm-Features: AQ5f1Joe4xg5_zcs96-PQy9e8tNorgl6hzcdkI4Dodr8p0sDbqo9j3WaMuiILYo
Message-ID: <CAHC9VhQfC3kXt39qBS3NEHtGNqNhD1SpJ103_kUtOCi0HTMDHg@mail.gmail.com>
Subject: Re: [PATCH] security: keys: Make sysctl table const
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:47=E2=80=AFAM Ricardo B. Marli=C3=A8re <rbm@suse.=
com> wrote:
> On Wed Feb 26, 2025 at 9:21 PM -03, Paul Moore wrote:
> > On Thu, Jan 23, 2025 at 2:50=E2=80=AFPM Ricardo B. Marliere
> > <ricardo@marliere.net> wrote:
> >>
> >> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
> >> ctl_table"), the sysctl registration API allows for struct ctl_table t=
o be
> >> in read-only memory. Move key_sysctls to be declared at build time, in=
stead
> >> of having to be dynamically allocated at boot time.
> >>
> >> Cc: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >> Suggested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> >> ---
> >>  security/keys/sysctl.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Looks fine to me.  David or Jarkko, this looks like something for the
> > keys tree, yes?
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Thank you for the review, but I believe this has been done here:
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D1751f872cc97f992ed5c4c72c55588db1f0021e1

Even better :)  Thanks for the update Ricardo.

--=20
paul-moore.com

