Return-Path: <linux-kernel+bounces-213781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DCF907A59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D638283E67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A314AD3A;
	Thu, 13 Jun 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qxc0cYl3"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69814A4F5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301324; cv=none; b=M37p/O1jsVvDFiZu5xeOilJWo2UFwICuTzaKN15qdN9d/Z8uCWF/CQSbYYHnP80i7iuBKt6SVfHp01nGT2iT16iTZZLpwOIFm7AKSfhAGHRAxq79XGB/XBzsQVweU8ZaI6JD0+3Ts+i/H9bJflC8i887mM+S3JsWa/fDF4VOu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301324; c=relaxed/simple;
	bh=MUCMdGKQ6KpvuwZkpqZcJz3thesROSDBWWwwZ9I5diA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEI5fUubJTgD0LTxZCSp3ZmSiLRb2I2atEJ+UrDwhHSClSTFhyIVUsV0oLo6WV38YXTA4h/Nz1Pkj8mKfQVZlQxx0F7cY4vjLFcuPTvZVtGg+xml031GEDTvzws+Nbo0JNlJlCMACtqRZbvSYYaVKfXFbjKUX/t9NeKjuSZyKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qxc0cYl3; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfa71ded97bso1086408276.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718301320; x=1718906120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Egm3XUTXXMactRvvK1SHa1gZTWtD5TN12FoLc8NaGlk=;
        b=Qxc0cYl3fjWjAk6vNt+VDp+jNJqZgujhyiGRl7NJ5uuvsUV9p/REUWutEM3hJVCDQM
         4wD+K1xsJiFMU9oFV77I0bCI6bjp33/RbUhANTAa14QhyslRBNYueXBu9UDsw37ZvZd6
         E/tuU87PYYhHtLdn+bsZq0EZJy6rjSemICdmBe3FLvwG2YZK/o8tqMpwpQSkE4l6Su7f
         F0i4xqU52ez6jvj+CVioF9prqifNtbdj19fzvnnjx77HagEtSGPsvx+93dwYJTZsnWy2
         2YkJejw5/ZcR37ujweu6odxKmGjqTQmlXtI4oKbg4n5DE9cysvBXHqI4AJpBkdaBOUmu
         5Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718301320; x=1718906120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Egm3XUTXXMactRvvK1SHa1gZTWtD5TN12FoLc8NaGlk=;
        b=MCUOKE1C61Ug9pMxUm137wCgk3iLs2ddHnKEZYEhs9ILR+jYRkcN2LW5uoMwGr/xf6
         WospGc4PsvXHWZkwVKgkG15m9n3L/+hIA039qbxse+5Pm4vKWDKQ3NOTTVpc1XZWW4fr
         2TN4kyBmvf/ZDjxJmUHlpH8EeWdyzIULp5ggitNXKlcdjk/LJIw1PeyDZEw0DYLcmGeq
         Le4XVBuhoLIxcm5CzezPmFG+mUR1t3uVsWGzCBpqy0NLsZzhgBhDoxghg6PF6T49lgP0
         w37yy5h9EfLHbnDApBlQCNwPMFL4f2zZ818SJS3DMTw+Q1MkQIJH4YKAv0Z8cEeaZMD5
         pxUg==
X-Forwarded-Encrypted: i=1; AJvYcCUhsAejKEFn4OWJEj38HjxtbgDqeLB9bOAyQMR6Vyw05hV7kYkIK1M94Os5pvtUk8eepwtvM75NqTWiQXZGEf5O4EILk+HhdZI8UdwC
X-Gm-Message-State: AOJu0YwhUwtfpb+yweJ0vevHqQKc+LXXx7E2U8dg6Mh0rQ0Jly9kvWz7
	9KA6tS5afFAnZ4YQgDlGK+SrKtomtqfwF9x4n/Ku2KEXzpOUe7h7eLvPn5keZYV8ERFZrrj4ejI
	mRFYLImztP+/ok/VdNLwrA96w05xNuc4Zk0mQ/Q==
X-Google-Smtp-Source: AGHT+IF76nlQfftP79Eh69ExQvNjCEbwUkZM8145hBHocV2VPUCI+0i3mln+vSFpa/yE2GkSIhSsluLedfBw764rtXM=
X-Received: by 2002:a25:9384:0:b0:dfe:6bc4:9eda with SMTP id
 3f1490d57ef6-dfefec06946mr2090425276.13.1718301320427; Thu, 13 Jun 2024
 10:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-msm-pass-addfb25-bad-modifier-v1-1-23c556e96c8a@linaro.org>
 <8aa99c1d-ca6a-a26b-96b5-82fc35cea0fa@quicinc.com>
In-Reply-To: <8aa99c1d-ca6a-a26b-96b5-82fc35cea0fa@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 13 Jun 2024 20:55:08 +0300
Message-ID: <CAA8EJpr5r=5MP8DqGPV7Ndz0zKy4Ar3u+RiqocLyt6eZWuifnw@mail.gmail.com>
Subject: Re: [PATCH] drm/ci: mark kms_addfb_basic@addfb25-bad-modifier as
 passing on msm
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Helen Koike <helen.koike@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 20:49, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 6/13/2024 9:33 AM, Dmitry Baryshkov wrote:
> > The commit b228501ff183 ("drm/msm: merge dpu format database to MDP
> > formats") made get_format take modifiers into account. This makes
> > kms_addfb_basic@addfb25-bad-modifier pass on MDP4 and MDP5 platforms.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt | 1 -
> >   drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt | 1 -
> >   2 files changed, 2 deletions(-)
> >
>
> Would be good to also give a link to the CI for the CI maintainers.
>
> But otherwise, LGTM
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Yes, good idea: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/119

>
>
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> > index 3dfbabdf905e..6e7fd1ccd1e3 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> > @@ -4,7 +4,6 @@ device_reset@unbind-cold-reset-rebind,Fail
> >   device_reset@unbind-reset-rebind,Fail
> >   dumb_buffer@invalid-bpp,Fail
> >   kms_3d,Fail
> > -kms_addfb_basic@addfb25-bad-modifier,Fail
> >   kms_cursor_legacy@forked-move,Fail
> >   kms_cursor_legacy@single-bo,Fail
> >   kms_cursor_legacy@torture-bo,Fail
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt
> > index 23a5f6f9097f..46ca69ce2ffe 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt
> > @@ -4,6 +4,5 @@ device_reset@unbind-cold-reset-rebind,Fail
> >   device_reset@unbind-reset-rebind,Fail
> >   dumb_buffer@invalid-bpp,Fail
> >   kms_3d,Fail
> > -kms_addfb_basic@addfb25-bad-modifier,Fail
> >   kms_lease@lease-uevent,Fail
> >   tools_test@tools_test,Fail
> >
> > ---
> > base-commit: 6b4468b0c6ba37a16795da567b58dc80bc7fb439
> > change-id: 20240613-msm-pass-addfb25-bad-modifier-c461fd9c02bb
> >
> > Best regards,



-- 
With best wishes
Dmitry

