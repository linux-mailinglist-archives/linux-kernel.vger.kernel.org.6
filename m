Return-Path: <linux-kernel+bounces-312376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF769695C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5FF1F2483D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D068D1D6DBE;
	Tue,  3 Sep 2024 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YX1J3pE+"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF01D6DDB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349001; cv=none; b=qLKjbaAHrHOn0MKBPSbhRav5w/EwvcVIENJa4wkHSodhtyFuWgIxgFjkY4zPCCo2mXeUdOgKpuiiyc2b+z6z1DrG+sITxm8xTwcJxvGDTSwN6oZOX+zWIOYgwOjC4Gho0RlrysSbIKZdNCzsYQJcaGVfey04k/WAzS+D0xdj3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349001; c=relaxed/simple;
	bh=kqcEYObkrC0jQZ4XALAJ1vO1P6Mi2ZZhNfK7jC8/8yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzUGi3Jh6PLwDQCtFdH1gzFA4lubGkFbRfsL0nz5J8Oq4uuw7gJueFw18P7AihjBv2yQ4ZiV+Z5DMNo4XZac6BRoWHYjPH2OsKPolq+10P9br0HC159mUtlmUNgBJsJ6fiTNj0RmboAVVgIoVktbzyg3FXgLl+OgKNBBfx+jdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YX1J3pE+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f50966c469so57013791fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725348998; x=1725953798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqcEYObkrC0jQZ4XALAJ1vO1P6Mi2ZZhNfK7jC8/8yY=;
        b=YX1J3pE+e8VJomiUThfOYrvSt2q4FemBbru45Xr+FZNT3ExMvm/hzFrlTOE5DDQoOJ
         XKYtG0Peb0YNfp6KzUSOneC9O+Qk7udPnhTf3fatJg4VKOwzxYk42Gx2uaQUaKdwLNu7
         mFRod0aJ4atrECNRtFR05NUeRQYurDbCDDrF7HmTNKsbaeJYmAGVN4+b9uOfcgTgMcNw
         KxB9SqzDFX5oh9Axqmn/0oRbFBrCNUlCIWJxkFj6UWeVgwIzgd7rptVuxWXUwU5L4nD8
         5Zvz/AKTOR16utPQJDVhDXBgzDNyV8qP4IqKW728rsvMpVZDIafC19MPIzuuU7GDRPj/
         W+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348998; x=1725953798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqcEYObkrC0jQZ4XALAJ1vO1P6Mi2ZZhNfK7jC8/8yY=;
        b=PpIo0buuOOsm4lyAJoA9eiI0/bRWg/3g5FlezWbEToVbjEb01QkXdcWZyl+0QsMdAu
         YVQAz38NcS5xQXkbYJaB4eHJ2+zK9dwkMg4kdZreCT5CiPpt5zJDu+dKseU7sEgiuQlb
         BFQnKC9OapoLB0unHW3Ww5mULnA5DZtgSUzAsXY74vtHNgBqDMhOl5UiOSO3duxyNlz3
         uC2ruXALLqxqFWZLn3Pvf4k26hjQU+wPmsYEAkWzp+VwEw0xNlb3+PbB4F6/0ueOW1ZH
         vuftfGiHXxOzGlClhPMZe1uxGkufwleh21BUa8ntN/4fxkH0qoeWcj9qCuDR3evwjH4S
         EQww==
X-Forwarded-Encrypted: i=1; AJvYcCXMOqgaP7PYXr209PL7x5UiieklR8c6uYWV+RbMqgG+AJ23YhqH4dSgfaXYyD93ZVcXp4q6Me7+NHaMHgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNp/KK4MLgIcNp2hcLTYk0T0BdoNE1ryGYTCFGZ+DIeQNtJFdN
	nTR4nu8WR+wfKdxsxhJVJgzsaZB1kj3MO62IypcNAF5h06Kd4s55p0RdgosNJJnOQIS5ukZgcLm
	zdRPkmNWMVX2fwa9efs2U9pulZwBzxSQao64x8Q==
X-Google-Smtp-Source: AGHT+IGteQhWMzNbnFN2+qKmtjU62TM1lL3m0+11wewZW7P3uvaelhDjpcxaWwlb8wZ9QV901P1BCZNJ2yN7NdhKUJc=
X-Received: by 2002:a05:651c:199f:b0:2f4:f8c1:2e91 with SMTP id
 38308e7fff4ca-2f6290ea8a5mr60244041fa.45.1725348997477; Tue, 03 Sep 2024
 00:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-4-bdb05b4b5a2e@linaro.org>
 <CAA8EJprKnd269S_KMVUDk7UfT-c4ighPq4VkX-nEkwGg8ys1cQ@mail.gmail.com>
In-Reply-To: <CAA8EJprKnd269S_KMVUDk7UfT-c4ighPq4VkX-nEkwGg8ys1cQ@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 3 Sep 2024 15:36:26 +0800
Message-ID: <CABymUCNCZFx3kMtxXt-U2L+_ks5oCCWMF0k-NyFkp99-aTqf-A@mail.gmail.com>
Subject: Re: [PATCH 04/21] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B48=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 19:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 29 Aug 2024 at 13:19, Jun Nie <jun.nie@linaro.org> wrote:
> >
> > From: Jonathan Marek <jonathan@marek.ca>
> >
> > MSM display controller support multiple slice to be sent in a single DS=
C
> > packet.
>
> This is not MSM-specific. It is allowed per the standard.

I do not find it in VESA standard 1.1 and 1.2a. Could you help point
me the standard
link?
>
> > Add a dsc_slice_per_pkt field to mipi_dsi_device struct and
> > support this field in msm mdss driver.
>
> This doesn't describe why this is necessary at all. Is it a fix or a feat=
ure?

It is a feature per the name. But I do not know more than the code from QCO=
M.
And different value other than 1 is needed for some panel with QCOM
SoC per test.
 So I suppose it is a key parameter. Any more idea?

>

