Return-Path: <linux-kernel+bounces-312369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BB3969598
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230F1284FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0661D54F2;
	Tue,  3 Sep 2024 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vs+13x3W"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AC1D61B1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348774; cv=none; b=dujnnxpFCg3E1X7B2NZC07P1CdNJcadiIMOV6SEvzPs+5qjxEQFg6jp4mavZMO/Czk50XsxedKnMJmmQIF0VB+gBFEcV3AWEr9y/Q6OHTcymGQuDLZn6/EVgfSkBlMzVZYcDoKy247TILfQeOoV2qY963A7C1dlVCSFklsVrqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348774; c=relaxed/simple;
	bh=U7FqpAKPzV4buH+ZI1vofCGLlOfNoJm00tc4Xp0bqlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELQqnZyo05tbCaQv+V29o5A11a9P20sxXfn/jL0Ttdv1RNABbA4U0wl3V9ZpNWRqDEqScTy8CPHWDmAAovsjWIFiBWEhB3KGNqR7uRhwohzMJww5cp78eOjz2BO5vZko2VG4U4mOi6Ie9CoVrW3zncb9d9RbJXsK6qm/9fR3YSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vs+13x3W; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334b0e1a8eso6503509e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725348770; x=1725953570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7FqpAKPzV4buH+ZI1vofCGLlOfNoJm00tc4Xp0bqlQ=;
        b=Vs+13x3WKrzOvshslTGxrV2rs3mzB14w8WyXspdGmAJ0FPqDDtMXD1FIxD4DOuvK33
         qWKA6xAa3Al0oJrO9pVkt32AMSgbusv89lhdyNYjuFolfkSy8872pv5dntM5We6GgPyg
         YCXVx42dnaEZLGqsrrMwLvUyrmdA0lPVvLgfTej5CbeaqZa7nNNErQdSQ+d9DH/9qma3
         1dAtAomK8rp/LDKAs/yh95mF0rnCC7bS55CysBoqRzXKpa5ymw3WBFJJ4gTN+GUPOoKR
         0Lj0NtM89RABWVIbT914UdgpRgLD7o+Q7Q5Z8DSbouxKalILdHFcEkYO2SsQV1NvspYA
         +foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348770; x=1725953570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7FqpAKPzV4buH+ZI1vofCGLlOfNoJm00tc4Xp0bqlQ=;
        b=KzMwHKD4usnWGoi2kL/+Mf2cLYLXjwikEl6vPrSRR0ushGoDGHIp24CZTdCWqTQmUU
         rUh7jcajPGHd3YKQd5eOcDubbGrU/Hhhr1pzBiLgJAqkYlUWmdFWKqcDT/CUP/Dn29vk
         QYOtYLp5yF43b4k4ZfErgu3uQj1xO4ClUGONE85zBCJUmBGwZyDBEunMPXFaDTPNctSD
         b4DQPFTOJN+QrWcvEL9hY59yO1dMk29dPo9N2oUYdBf0Znr3o8xfviNgEPmzzQGUVhEe
         FSqrOCczh1jF0NvIaHnBtmlvI0tm8EL3tBgKC8w6r2Xt79EMn66j3cwbpbUC4rdQ/AYc
         QioQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/7JlY+vuGTNVVsVl8OAREh00Wzhld2A14Q1PLRD01Da0kgfZOteT93dt9FwxdvZRSOoLAEBnc6v1d7PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRuj+sn0NQC4lxlBTvaTkusoDOr/3fl92qpU6l+FKSrWnmoD6+
	FvznLQgtok3vBqd+Ar5tUr/wLj4PmbApFrSjJQnzQjRQQq8rDiKL0zNPIphchH8lrpcQVHNVFH2
	G9eSzAykRy7iXJSI5MyZmTKXLoEycC5Ej7okG5A==
X-Google-Smtp-Source: AGHT+IHrFPfCS/BVC8UCkjCGmyI7i7/wfoGrPytiT60dSKpQkQEML/b4+Lrc3MCNMZfPCyT+5uqmLNbJH1mOjM56rKk=
X-Received: by 2002:a05:6512:3b11:b0:52c:e054:4149 with SMTP id
 2adb3069b0e04-53546b052fdmr9233089e87.15.1725348770143; Tue, 03 Sep 2024
 00:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-2-bdb05b4b5a2e@linaro.org>
 <CAA8EJpp_LWmuN8CFuQEAME-O44_wJXUKsR1QwahuigzSss5Rqw@mail.gmail.com>
In-Reply-To: <CAA8EJpp_LWmuN8CFuQEAME-O44_wJXUKsR1QwahuigzSss5Rqw@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 3 Sep 2024 15:32:38 +0800
Message-ID: <CABymUCPXDTCVeeC0s+1UyuqYF0XNW55qtOBV9--BOoSjAzVjkg@mail.gmail.com>
Subject: Re: [PATCH 02/21] drm/msm/dsi: fix DSC width for the bonded DSI case
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
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 18:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 29 Aug 2024 at 13:19, Jun Nie <jun.nie@linaro.org> wrote:
> >
> > From: Jonathan Marek <jonathan@marek.ca>
> >
> > For the bonded DSI case, DSC pic_width and timing calculations should u=
se
> > the width of a single panel instead of the total combined width.
>
> What is a "single panel"? Please rephrase the commit message so that
> it reads logically.

Yeah, it is a bit confusing without the usage case explanation. "single DSI
interface" shall be much better here. Because bonded-DSI can work with
a single panel with 2 DSI, or with 2 panels with one DSI on each panel.
>
> >
> > Bonded DSI can be used to drive a single panel having two input
> > channels, or to drive two panels with a input channel on every panel th=
at
> > behave like single panel for display controller.
>
> Missing actual action. See Documentation/process/submitting-patches.rst
>
> >
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>
> As pointed out during internal review, missing Fixes tag. Any reason
> for ignoring it?

Sorry, it is missed by mistaken. I am just more familiar with
"Signed-off-by" than
"Fixes:" tag, so not sensitive to Fixed tag and miss it when you
mention it. Will
add it.

