Return-Path: <linux-kernel+bounces-388351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9B09B5E42
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1FD1C2100F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3051E1A32;
	Wed, 30 Oct 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gx1MNhvD"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF541D278D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278353; cv=none; b=SQW/i3gDw+oth9W7SsnTr283sqx5R/2jqUqxSalY8Qh2adPkpFHEFcYBGb7I/CWNLOP5AwDRnMokkLQh7lHJkCuhbUQ6QkaVy4tF+zNJKhA5nXJR5aOxBYicr7a5olOkjmfo2xvbZ92GOulSKFacSy2abVb+U2Dxhxj1QOjjTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278353; c=relaxed/simple;
	bh=OZnoNZrdZV2/crQbUH4IG8um4cL2sl75Grz7lZVdnH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKn+6BRmei84+IfPnaRrwrkR0EXwl1UCieCBlJTCjqfZdXBVCXPcs/2Z6GTz8E4ixLNZMJbjCh2ZkeTu4oDkIFIZHBwFu+6T6Sb79yjsVMIk3z+8nmk1f744/JM2re5/DITiCqaheO4ut0icPQEQJNuuu4mRRM6yt57O0iDmKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gx1MNhvD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e7e73740so5391760e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730278349; x=1730883149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZnoNZrdZV2/crQbUH4IG8um4cL2sl75Grz7lZVdnH8=;
        b=Gx1MNhvDYMRXzGOXv/QeXFSrhVJagkKZgJtdMYNg7w9i9ycJnuHDj0EsyvwkUsTQLB
         ujyu8L78mBKZ3bedds1bppq3Cwr/GjudIkBD+2pHI85KOSGXR+OOvv95FFT9VMJ3V+qA
         6XqoDmDlj8y78cQ28ZBKbh5QUbtVenA7+EYD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730278349; x=1730883149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZnoNZrdZV2/crQbUH4IG8um4cL2sl75Grz7lZVdnH8=;
        b=tzRVQnJY6r72Zil5wMVs6o2mVjwo/AirTYEQoIvuRLuS5rA3oQkWxb83OO4sEtkOJp
         aCLLpVyP1RmSItL9/eCyKIZEm/77y6H18SDj0l29TYoWydrGRLJTtwpGCvXl4n6GSKfl
         Q1zvohqalEeKd6NpPB5aZe2tfPaHSXvNoVaO9lhTcPfVC75RPeV5Lw5sWdnCbINtSptL
         238FIp3hcgtiVM9nN7DxB4jrbYUXR1xAlW3n+Mx+ENf9qJ9zaE90qPFtF3uRfEH5NRNT
         1hjQDj3MhXq0G8EN9fZi2+fTFmgkxfValFsPLyHc1E6kEBqMoCfUooQdjIluUEl3BieC
         wnmA==
X-Forwarded-Encrypted: i=1; AJvYcCU7s7cD+4da8LAxmqd8tupTJttjod0Akvq+jnX73mtnJwTXN+kM2e3MQeVaEObNC/e2awUKZLyLONn+yEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qrwiJ2HzM+VideTRf6PqwsbX4P+aEOg0/iOvD0Ha1Y/RLsuT
	mSmfwbhQddiLN34wjBWxE+D3bBivN+bKKLGMsuNAe695iedGQTVQDoY+i6JRELLrNprUMfzaWF4
	LLc0nvmAwzbjn/ntRcXeVAvQOXPJS+gv/7UVS
X-Google-Smtp-Source: AGHT+IFN+5L8Zy7+Hnrc96LK5WeSb49IZ59brkNk4NXUJ6HqftStgtUU7GRQnbHmisIT1dsrtBDF17VQ5Tz/yjajEuE=
X-Received: by 2002:a05:6512:350e:b0:53c:74dc:2252 with SMTP id
 2adb3069b0e04-53c74dc2378mr320758e87.49.1730278349113; Wed, 30 Oct 2024
 01:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029111309.737263-1-wenst@chromium.org> <d9177ba80fc78b1f74dc54260c0c43440ec5a804.camel@mediatek.com>
 <20241030-hot-peridot-falcon-57bdbb@houat> <0cfba5bdc9443fb4b9719c47ee93c2a467cc66bd.camel@mediatek.com>
In-Reply-To: <0cfba5bdc9443fb4b9719c47ee93c2a467cc66bd.camel@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 30 Oct 2024 16:52:17 +0800
Message-ID: <CAGXv+5EWyGGKYo+NNQ3Ykd3QUUO2cOManSnhZQaVhhCnupNx=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Drop dependency on ARM
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "mripard@kernel.org" <mripard@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, 
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:48=E2=80=AFPM CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89)=
 <ck.hu@mediatek.com> wrote:
>
> On Wed, 2024-10-30 at 09:25 +0100, mripard@kernel.org wrote:
> > On Wed, Oct 30, 2024 at 03:30:34AM +0000, CK Hu (=E8=83=A1=E4=BF=8A=E5=
=85=89) wrote:
> > > Hi, Chen-yu:
> > >
> > > On Tue, 2024-10-29 at 19:13 +0800, Chen-Yu Tsai wrote:
> > > > External email : Please do not click links or open attachments unti=
l you have verified the sender or the content.
> > > >
> > > >
> > > > The recent attempt to make the MediaTek DRM driver build for non-AR=
M
> > > > compile tests made the driver unbuildable for arm64 platforms. Sinc=
e
> > > > this is used on both ARM and arm64 platforms, just drop the depende=
ncy
> > > > on ARM.
> > >
> > > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > >
> > > I find this days ago, but I don't know there is someone who apply it.
> > > Let this patch go through drm-misc tree which already has the bug pat=
ch.
> >
> > If you are ok with this patch, why didn't you apply it yourself?
> >
> > I think that's very much the expectation, so it's probably took a while=
 to merge.
>
> That's ok for me to apply it if drm-misc has no plan to apply it.

I'm confused. The culprit patch is already in drm-misc. So this one has
to go in drm-misc as well.

I can try to apply it to drm-misc myself, or have a colleague assist with
that. I'll let it sit for another day in case anyone has something to say
about it.


ChenYu

