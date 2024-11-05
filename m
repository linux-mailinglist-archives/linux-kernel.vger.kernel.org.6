Return-Path: <linux-kernel+bounces-396291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D09BCAFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144EAB234C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200E61D2B3B;
	Tue,  5 Nov 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5uI83jH"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3F1D0950
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803885; cv=none; b=gpR6EIGdQy5vGamzEgMyTaO3AuEznR/6tduLHjdLIvIsU9/ZKh3h4gpX5xukpAePUfKhDQuMDdeQkVcPZQwM0rTPllBGs+NR3WB7rCMLbjgu85Q3J5bUaqTp6DayT14FxE01jkAS7AATtXofR7pqVlKUu7rWuH2S4dwCMeRNAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803885; c=relaxed/simple;
	bh=8wFnUnciKF2xxhdw0g9UlvzkYqa9uqspkupSHos0NsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUsYhOqlf6wP6PJSub0Zjfbf38MmgwxhtK5o50AWxePUFwpkQEkPjiLxw8SptC3GEllLvuuHDvOm4Oup8nEBe2JwxfE0n2eY1JnmNLnug8iLbp4tx/vDTAgqghRIFN/PEPl54ZfEKcYTUyZ/kkwmRb+RJQ4lO3HUw1uJ/3OcHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z5uI83jH; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e38ebcc0abso59681647b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730803883; x=1731408683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wFnUnciKF2xxhdw0g9UlvzkYqa9uqspkupSHos0NsU=;
        b=Z5uI83jHoDzY4cyhMuZIAMo0A7Xrziy27m7936sk/dn4ZOOzS6srim+/SoA8HM1LQ/
         8T1eYz3bFLpxGJNHPgVdIzUZfozB5gqp/QJlK29/11ikpA5F1PZr4TY5ZhcMtSaz+8lB
         /ngMEYtJ1s5kZ/X5uIEXeMt9UCc3ZOv5uj7l9llr7UjQmMeUE8O/B5dFU6Qc+JnheadJ
         n/UKaYecm41XSDQdCJ37QcgWzPNqLwv+LYA1vivKuUk5WjLgPR61qIeWA9TxW/WHUND7
         skIpt4m8ki9OjlqfMN2PyzWjGUbCqtGM2wRNf6Wyb9QF0uzqV7iSV0M+F+CU9WKnCj28
         DgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803883; x=1731408683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wFnUnciKF2xxhdw0g9UlvzkYqa9uqspkupSHos0NsU=;
        b=kGprq0iR4iQvKJusOIK0HkZsZy70yfga8bk8bfwrPe0Vtno+YvQRCeN0lxByTN9rog
         Q9eLWftDgtY1wDFv+2MC7mfrf5yw9JfoG7LhBQcQhs03cB95EFKy9tmdr/vruzSyGZMd
         NidBx5rQQyCsi/H73PhJqn8bJMXkQRDj34o37kGpaSSbetimRdAhgOjsyrFH79POUgW6
         WOdhK3vdbuZwLObWQfdOgjuID3vhDT75zqpqKO058TvW5cHPgUOZwQ68z4r6uFzE/o49
         8hudnr+Jb3t5ldHvFO0DMx3KnrjMO6nXI/PcM+taVbS/K3OveiZjKBZ1q4urzwX1b60B
         vmSw==
X-Forwarded-Encrypted: i=1; AJvYcCWYjZdWX1rEgVtdb5oCzRcdE4cDiMMlUJskphq/1fBSW6EDR+oT9nmwLYfDraL0WeeVn7eaGBCt0LfHz3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKs1MSMObPP82j2H8DNULIDv4BMxGnROyjE72hIeejXOV+ehUf
	6qvAE+LFzj+sCYUFuUTkElS6Ymx459zJdmBPE9FGefZQMXyvuaiTeV4WvH1x/NrsIECOBK3+AuM
	ur28amdMJCdhapaP3xheuL6u0VIzQgrUAeeSUkw==
X-Google-Smtp-Source: AGHT+IHQFSqhKmwFB8KvMA0OA0g7K5yjBP9Ct2aeaH6/E5BqOA7hhimk5zgheZN6yBg6rUs9bzLqJRTFRGU/Y2suREU=
X-Received: by 2002:a05:690c:dc7:b0:6e7:d974:8d05 with SMTP id
 00721157ae682-6e9d88cf98bmr365969057b3.4.1730803882742; Tue, 05 Nov 2024
 02:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
 <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com> <D5CC3U00B7CG.IGKCIES8PC2J@kode54.net>
 <00a99b3e-3fad-42fb-8dc8-4f45d158c4c1@igalia.com> <D5E5ZXW1K0A7.1VT1XCR1HIEST@kode54.net>
In-Reply-To: <D5E5ZXW1K0A7.1VT1XCR1HIEST@kode54.net>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 5 Nov 2024 10:51:11 +0000
Message-ID: <CAA8EJpoEEo5tB00Yqoi7V2U=pRud1W44W3V8bJnr3N468EhQOw@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 1/2] drm/atomic: Let drivers decide which planes
 to async flip
To: Christopher Snowhill <chris@kode54.net>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel-dev@igalia.com, Simon Ser <contact@emersion.fr>, 
	Thomas Zimmermann <tzimmermann@suse.de>, joshua@froggi.es, ville.syrjala@linux.intel.com, 
	Daniel Stone <daniel@fooishbar.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
	Harry Wentland <harry.wentland@amd.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Nov 2024 at 10:15, Christopher Snowhill <chris@kode54.net> wrote:
>
> On Mon Nov 4, 2024 at 12:52 PM PST, Andr=C3=A9 Almeida wrote:
> > Hi Christopher,
> >
> > Em 03/11/2024 03:36, Christopher Snowhill escreveu:
> > > On Fri Nov 1, 2024 at 11:23 AM PDT, Andr=C3=A9 Almeida wrote:
> > >> Currently, DRM atomic uAPI allows only primary planes to be flipped
> > >> asynchronously. However, each driver might be able to perform async
> > >> flips in other different plane types. To enable drivers to set their=
 own
> > >> restrictions on which type of plane they can or cannot flip, use the
> > >> existing atomic_async_check() from struct drm_plane_helper_funcs to
> > >> enhance this flexibility, thus allowing different plane types to be =
able
> > >> to do async flips as well.
> > >>
> > >> In order to prevent regressions and such, we keep the current policy=
: we
> > >> skip the driver check for the primary plane, because it is always
> > >> allowed to do async flips on it.
> > >>
> > >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > >
> > > Should I do a R-b too?
> >
> > If you can review the code, it's always really appreciated.
>
> I mean, I did review your changes, they looked good to me. I just didn't
> know the protocol for reporting review in addition to testing.

Please respond with the R-B tag. Also ideally the Tested-by should
contain the reference to a platform which was used to test it.

>
> >
> > > The changes looked sound enough for me to feel
> > > like testing it as well. Tested Borderlands Game of the Year Enhanced=
 on
> > > my RX 7700 XT at maximum settings at 1080p165, and the tearing suppor=
t in
> > > labwc allowed it to reach over 700fps. No problems from the hardware
> > > cursor.
> >
> > Thanks for testing and reporting!
> >
> > >
> > > Tested-by: Christopher Snowhill <chris@kode54.net>
> > >
>


--=20
With best wishes
Dmitry

