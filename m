Return-Path: <linux-kernel+bounces-322960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E112C9735E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4841C242B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A479714D431;
	Tue, 10 Sep 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWb9Z+kK"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4D188A28
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966410; cv=none; b=ftAcHJoiFJ5DSwqHpWdB8TT7UB68vCA/UNENoLFstWSVoeAMDfW8cfWstT/JZO9kJomSgoFuxHcFp2Thx5VZM8YAg+QIrX+56mOLKHOIIR9BWK2Fqc+e8iEObmB7xc2Rblu7gVMye+92yIs0oiVeCYR6uKzxC3c6Zwcq4cRVITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966410; c=relaxed/simple;
	bh=1maY1cX453DMHlJm2agu5A1XDvFqpwWseCzYI4mcRfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4I7yqOiv/hh7xX4nxi/9eVgYD0SOurcDFsataz78TBfBIzUjmcimNRUXpA7PcQuCXU/JvMnXLKisj3Yq7ZGu5ySzWX+14cx2ohchjGf8DgnxF9BCmknLOXNJL2Um/G6EcExOZLz2B0DMFqr/mJtflBJR7NmUonH4kIHDd5TIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nWb9Z+kK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6daf46ee332so50284417b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725966407; x=1726571207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UCCbavyEihwNVBphJesiHire7f9BtBrqKcNAqBxfKK8=;
        b=nWb9Z+kKgldO/yQSZDo2F7iYYb5oRS7ZOCx5hkTJGmzHRZi7xUm+QAB6zCIUOsvLDz
         4LW5MfKES1mfP+Qznbgrprvy03WNIcaPPbdhcNe9p/l9mUeErWGtgJLWFAibQ3vopTwy
         fzydIdFCA0YxwNeDcSlEM0Ub5FCxv1hJUwdZiL1Wkgmh0KKXwIwf2PLlbE+JMAVPgvle
         k9yCvn43oAXsFr2/vQqz4MiHdt9OwlrBy88kf2HZVtEvTDaQ2O63zn5Se8JShMHvh9RC
         xBAILkCjHVeBZPGQncaHrcAczNy0aK5mHdlEgYNcfxGmeV1IPePJJGq1cl3k2ewpNjhO
         ykNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725966407; x=1726571207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCCbavyEihwNVBphJesiHire7f9BtBrqKcNAqBxfKK8=;
        b=JpOq64NXs0dEzVSL7yV4PbwaboHVGfCvgC5TqBLlrs38nArcTQYjh+xT62XM64f4OM
         pu9ZxAbvoO6lHJgf+CEgdohBHmEJqBshDoV19Fr5KFExGEr5hLxO9cd8tToHWIbKg8cA
         5S0M8DXP08JDtiA2NnEUs24T/qCDlCduMSMV40l7xDe/xP6AmsOJ0E19Tp460wCZbhLc
         8dX46qg81qPPsNg7wyxz3obWdD52BQV5QBMJIdy0ScsmLjbu970ZFo7RBW/5hV4PIZz7
         eELE1oVZjVLlnSveQjqioZTQf1YaJneBJcZAmG9TjFV2itiWHdQtgId6e6yf4YBl4TqS
         1vKA==
X-Forwarded-Encrypted: i=1; AJvYcCWEtXeu7GKtxYzQEmOzRmi5PMYMERA0oOTkVSABqm+QR7K4zx2T0atPlk79UY1vUZ7EMNrju50TUFNSxJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSx4OvScWJiToMHK/zXNTKyOe7KhvXbF8oJ/ilb4CcwB0AHpqf
	LROvPYaBsXcRQutSj1ow1FgoKSlgqFoWWjQGgNk0xwveDMm/I17iDTqgDcMDHX4XDDwsJI+Lfjg
	qO+G5NJx6woEHB9O1PTfnc4L+hYjKs6Fb+bWpog==
X-Google-Smtp-Source: AGHT+IGaUD3Kl9sgFWBanJ/jqdGQUVaWn5REmu+dNclgfsVVSH0XeaP/G9sv4hdqxWANQMRS7ZxrjRu0+pPPXkl0zsA=
X-Received: by 2002:a05:690c:6e0a:b0:630:f7c9:80d6 with SMTP id
 00721157ae682-6db44f4228emr153561027b3.27.1725966407251; Tue, 10 Sep 2024
 04:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-tzmem-null-ptr-v1-0-96526c421bac@linaro.org>
 <20240909-tzmem-null-ptr-v1-2-96526c421bac@linaro.org> <20240909131842193-0700.eberman@hu-eberman-lv.qualcomm.com>
In-Reply-To: <20240909131842193-0700.eberman@hu-eberman-lv.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 10 Sep 2024 14:06:36 +0300
Message-ID: <CAA8EJpqSKbKJ=y0LAigGdj7_uk+5mezDgnzV5XEzwbxRJgpN1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: qcom: scm: fall back to kcalloc() for no
 SCM device bound
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Andrew Halaney <ahalaney@redhat.com>, 
	Rudraksha Gupta <guptarud@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 00:04, Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> On Mon, Sep 09, 2024 at 08:38:45PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Older platforms don't have an actual SCM device tied into the driver
> > model and so there's no struct device which to use with the TZ Mem API.
> > We need to fall-back to kcalloc() when allocating the buffer for
> > additional SMC arguments on such platforms which don't even probe the SCM
> > driver and never create the TZMem pool.
> >
> > Fixes: 449d0d84bcd8 ("firmware: qcom: scm: smc: switch to using the SCM allocator")
> > Reported-by: Rudraksha Gupta <guptarud@gmail.com>
> > Closes: https://lore.kernel.org/lkml/692cfe9a-8c05-4ce4-813e-82b3f310019a@gmail.com/<S-Del>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/firmware/qcom/qcom_scm-smc.c | 28 ++++++++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> > index 2b4c2826f572..13f72541033c 100644
> > --- a/drivers/firmware/qcom/qcom_scm-smc.c
> > +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> > @@ -147,6 +147,15 @@ static int __scm_smc_do(struct device *dev, struct arm_smccc_args *smc,
> >       return 0;
> >  }
> >
> > +static void smc_args_free(void *ptr)
> > +{
> > +     if (qcom_scm_get_tzmem_pool())
>
> I'm a little concerned about this check. I didn't think making SCM calls
> without the SCM device probed was possible until this report. We do
> worry about that in the downstream kernel. So, I'm not sure if this
> scenario is currently possible in the upstream kernel.

MSM8960 and MSM8660 don't have SCM devices. For MSM8960 it should be
trivial to get it, c&p from apq8064 should. For MSM8660 it might be a
bit harder. But even if we add such nodes, we shouldn't break existing
DT files.

> It's possible that some driver makes SCM call in parallel to SCM device
> probing. Then, it might be possible for qcom_scm_get_tzmem_pool() to
> return NULL at beginning of function and then a valid pointer by the
> time we're freeing the ptr.


-- 
With best wishes
Dmitry

