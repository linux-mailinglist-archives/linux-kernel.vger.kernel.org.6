Return-Path: <linux-kernel+bounces-312469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9029969712
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF8284706
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E8F1A2643;
	Tue,  3 Sep 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9ZCm+Hb"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD51D2782
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352223; cv=none; b=Om3N7SSz84yaonoZUUtdSZm7YvjAKyK8c0ZoK1MJCQX3wWzecLJXNllsLvHjF9sx09m/iwHQ6m1MakZZmhRuAYsH5ui60EXCQKjoIakLbhviMrZJpIee2RYpqiPtHPfkOmEp8qBT1kmPlgNF8lCErbA7k0ph4BZ9gG4XdNHHrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352223; c=relaxed/simple;
	bh=7JLA6SwNTAG/M4bSvCUM1V19PPQJ03NHMutZLhv2tcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRdjvkxD+goJkU56CdEt+OdmBXZ8UeFzy1v/yi9KDhGpXafrNe67wC8nAIiG2W1YimYQ/EH3RVaqYZ8wf0zQvvKPqWNwxG98ApNdW/zzpYCrpsDAQpHlmlCUxWeYL8q2i9dko6vG9PXQK5lfPYela909pxyAoM9su/KiXKCpmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9ZCm+Hb; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6bada443ffeso38522057b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725352221; x=1725957021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JLA6SwNTAG/M4bSvCUM1V19PPQJ03NHMutZLhv2tcE=;
        b=b9ZCm+HbXFGhfPtrZmGqjHRJ4qCpoWV4TkDXBkvsz6hat136XKzTiFGVIDCbWqtKuz
         xOLftlwMhPJ/7nlMT/kWrrMzeQm7llJKugQ8sMHnz/HPMz1Zsj6x8Lw+uY7Q/1VfsH0e
         pFfjB10wT0y1Nr87ujNbS0zkiuXoxn/+Fghb/4psgCtr9+mJOF03MhSPxzWJkPl46Uo3
         /JF5NRpqrxlRab5Q2cocKLTzNhernE8FK2T99EXrG/b3SfiyZrpT6RfTLFogWGMlIL/t
         x1tM6pAE4Qb0BJCOnODvT+IwdwelO8kYOIrIOQuQnLnuXxCQPBo95Z4Tr0YWL0xjtKBV
         UChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725352221; x=1725957021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JLA6SwNTAG/M4bSvCUM1V19PPQJ03NHMutZLhv2tcE=;
        b=dpQidelmuoTsgpY+lVFnIJblNKNDZFtcCIKKe15GyKwhl0H3pDHtvaPW3rhkxehVtR
         ACFtCnZsS1GXj1m+isYPywjMoDsK4NiiinH4j5eG8iAzf1qQ/IhOm7zOr/XsXuMkpcn6
         AVHaclXZtN5UTSbI7nKzCIeDmeU5nDmT5BtbfDSIzcmnXHlUe4Co/tsNvRozcLetN0ez
         K5yGuoKVgDzZx+8I7ksZgyeFTShZ1IHx9PMChtHAj8FOfjIniTy76O6xUtDFdNKvVRCr
         KS0o+hiedJnqWm2pqz7cIcplQJPULQcL+hKYzvrmkwovoradpBTenkx7nPD8KHTavQbW
         GrPw==
X-Forwarded-Encrypted: i=1; AJvYcCV9evDDocgCkD/orPGWEtMH6t2EmXypR4fdy+bgnYxUie8ppHyID03+jwAM4Zi0v7vkYBBZ0SeG+IWQXG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEVXi+NEg7eaOKw24jbx9xOXXZfw5lEkzzqREmTYgwxlSc/F4
	21r0IFtwxJtmcsC6ZAy05f5u07EeZzu34USfxA3vyQUFGs1ku9NmH64L+BUpybllRBGA1VGLCUV
	AHAQB3wDFZO/H6QTF4PgaJYKvnNKo7O5t8vyKdQ==
X-Google-Smtp-Source: AGHT+IE6+IuJbo/Qa4C+ke6jr8gGlhel248tosjzF6z+OPZUMgyyXNzVAr6RoXE16AWMpicsRKxNkqNsZU1ZeXemP1I=
X-Received: by 2002:a05:690c:f02:b0:6c7:a120:e104 with SMTP id
 00721157ae682-6d3f7fabc73mr125792017b3.4.1725352221035; Tue, 03 Sep 2024
 01:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-2-bdb05b4b5a2e@linaro.org>
 <CAA8EJpp_LWmuN8CFuQEAME-O44_wJXUKsR1QwahuigzSss5Rqw@mail.gmail.com> <CABymUCPXDTCVeeC0s+1UyuqYF0XNW55qtOBV9--BOoSjAzVjkg@mail.gmail.com>
In-Reply-To: <CABymUCPXDTCVeeC0s+1UyuqYF0XNW55qtOBV9--BOoSjAzVjkg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Sep 2024 11:30:09 +0300
Message-ID: <CAA8EJppMkd4QmQHiFGNQNRyCh6S3BGqcQ7Deoag25AjH9rJwdA@mail.gmail.com>
Subject: Re: [PATCH 02/21] drm/msm/dsi: fix DSC width for the bonded DSI case
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sept 2024 at 10:32, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B48=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 18:54=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, 29 Aug 2024 at 13:19, Jun Nie <jun.nie@linaro.org> wrote:
> > >
> > > From: Jonathan Marek <jonathan@marek.ca>
> > >
> > > For the bonded DSI case, DSC pic_width and timing calculations should=
 use
> > > the width of a single panel instead of the total combined width.
> >
> > What is a "single panel"? Please rephrase the commit message so that
> > it reads logically.
>
> Yeah, it is a bit confusing without the usage case explanation. "single D=
SI
> interface" shall be much better here. Because bonded-DSI can work with
> a single panel with 2 DSI, or with 2 panels with one DSI on each panel.

Yes, it sounds much better.

> >
> > >
> > > Bonded DSI can be used to drive a single panel having two input
> > > channels, or to drive two panels with a input channel on every panel =
that
> > > behave like single panel for display controller.
> >
> > Missing actual action. See Documentation/process/submitting-patches.rst
> >
> > >
> > > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> >
> > As pointed out during internal review, missing Fixes tag. Any reason
> > for ignoring it?
>
> Sorry, it is missed by mistaken. I am just more familiar with
> "Signed-off-by" than
> "Fixes:" tag, so not sensitive to Fixed tag and miss it when you
> mention it. Will
> add it.

Well, the regular rule of reviews applies: if you don't agree or don't
understand, please reply first.

--=20
With best wishes
Dmitry

