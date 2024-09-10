Return-Path: <linux-kernel+bounces-322687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F6972C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F75EB246D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB5186618;
	Tue, 10 Sep 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3CjCQZU4"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBA185B4F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957485; cv=none; b=hWpba9Z9NF+X8S4i7zLVxYE4Xu4X7f/pBcKIAxwm1HtfQlR5XAD/DGDZe+C71CrE+M5CYYyX0vxRXF5ZZHCrxhjuIcdobLBHY/GevtabYlLbtVS68NYPb34riT/gUe/S9kqczDCMYnR6pwyqW/+LWOeFe6V7eQcreRnOuZiPZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957485; c=relaxed/simple;
	bh=eZweYYHm++Bqv8c2cCyGe8waWaVC9L/fMVK1rSAYEuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYvkiEQfz62bhHQxcZ07vinnwX09+kVfzEw8DdWPJKPAgIy7tJDpQghgJQ3keKJozbLs/jGkr12NqZ6mOWDjCLh32TDPEnU0T9YmzFoEIHFbe/TfOAwjQQ9dhzh3+sKn47WKgbCGqxv1BLpDU/GWtJZcWWNXxGNtJnAbNEPidfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3CjCQZU4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53659c8d688so2980579e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725957479; x=1726562279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avZmreRSQ5vgu2EEKWcyaA3dEVEZLIFX3VmPTyqgNK0=;
        b=3CjCQZU4H7rPtaGBPSLdgPcCCeNwnuyasIZfL74ap9ntqaE+ygVdGJxburzCXGnOAw
         rBy75UVfLCBWc5xH21+QLkuyoSfu6jognonwLCTgwZrZwRREefJIS0LLbfmjMJbG1YMa
         Hl8tZrQf3yIj1dSubV+WVbUmZqFmmN2uPOVFzCKp5X0Wl+o93FtCdwNTbKXp2AB6vkge
         WcgxGSJup2HYnW14v2FrSypMOiSm+piXvsNKFLdUf3wJ0prbsBQZFiz3+V2UHsG+o3R0
         7w8k9Qmope++BoNdxHcuVJf5F1xkEhlLi6SQ5dScnDXDaXAd8VK/NDuKeErhUwZwXt5D
         Gd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957479; x=1726562279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avZmreRSQ5vgu2EEKWcyaA3dEVEZLIFX3VmPTyqgNK0=;
        b=dZtUx3Slw7zTsUwFemImAKoZNKrw8Jw80RZdqmznpAUN1c5hz1Rq5igyiGxDMigWAs
         N8KayPpnJmQ4/ULXxxuEtN5axdrqqrEg/4wqKBwmt7IEdfOJF70kIvAUIEDlR51E/4YK
         7YoSnACkuv666TYNeLqchIniOCKI58gnfybn190y2Ncnm3cSAtfmn8yLqe4G4cGAbjJy
         8XT3rMNKSx8NG0PvieO1E11b5GzdHar26nmW+DQialLREyK7z/ws9fHDeYQW2eesSOoG
         0LfiUWjH4KQdf45Hj8L0/pZlfdYoPMyWt2/b5T3xScwsunWBsiWl/abgBRyxlGDCqG7F
         ZEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPvakL7epbfle9iPZ6HQszgjzLe3pFmpWQSYPD8VJowX5gNtq4/hHSxDoPLXmk+JgVBYeOuqxQgT/JOQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9QMLume64WTWVckx2NGgZfEoiTdAK4a5lx9KyA4R7B74RfkI
	5iYJ2zwW5v3/vxtkE/cnIrvewqV2oKs2g31T1HSkYLkrj/XCMlKVFAACudTPW6xWspq5m2mvoSl
	gQLaSaoKlqJ9NP8F/3dFN7A5/cT2q4GDftkR9yg==
X-Google-Smtp-Source: AGHT+IGvGeHtcjeoxZgfuU6A2kXjOayadF/beubgiWM477PI1P06goWDhPFUpQgAtkK8pAAAeUdifLwfAbbX+5UYzuU=
X-Received: by 2002:a05:6512:b9f:b0:535:6480:707d with SMTP id
 2adb3069b0e04-5366bb3d443mr830105e87.19.1725957477765; Tue, 10 Sep 2024
 01:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-tzmem-null-ptr-v1-0-96526c421bac@linaro.org>
 <20240909-tzmem-null-ptr-v1-2-96526c421bac@linaro.org> <20240909131842193-0700.eberman@hu-eberman-lv.qualcomm.com>
In-Reply-To: <20240909131842193-0700.eberman@hu-eberman-lv.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Sep 2024 10:37:46 +0200
Message-ID: <CAMRc=MdCHWfmZORx=mjBzOcgub_hSAz9oF6CzovGpKfMkKqgPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: qcom: scm: fall back to kcalloc() for no
 SCM device bound
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Andrew Halaney <ahalaney@redhat.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Rudraksha Gupta <guptarud@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:04=E2=80=AFPM Elliot Berman <quic_eberman@quicinc=
.com> wrote:
>
> On Mon, Sep 09, 2024 at 08:38:45PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Older platforms don't have an actual SCM device tied into the driver
> > model and so there's no struct device which to use with the TZ Mem API.
> > We need to fall-back to kcalloc() when allocating the buffer for
> > additional SMC arguments on such platforms which don't even probe the S=
CM
> > driver and never create the TZMem pool.
> >
> > Fixes: 449d0d84bcd8 ("firmware: qcom: scm: smc: switch to using the SCM=
 allocator")
> > Reported-by: Rudraksha Gupta <guptarud@gmail.com>
> > Closes: https://lore.kernel.org/lkml/692cfe9a-8c05-4ce4-813e-82b3f31001=
9a@gmail.com/<S-Del>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/firmware/qcom/qcom_scm-smc.c | 28 ++++++++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qc=
om/qcom_scm-smc.c
> > index 2b4c2826f572..13f72541033c 100644
> > --- a/drivers/firmware/qcom/qcom_scm-smc.c
> > +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> > @@ -147,6 +147,15 @@ static int __scm_smc_do(struct device *dev, struct=
 arm_smccc_args *smc,
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

I didn't know about this either. And I think this should be fixed.

That being said: qcom-msm8960.dtsi doesn't have any SCM node and
there's no such compatible in the driver so it looks real.

Also: some of the calls seem to be ready for this and they check
whether __scm is set and use a NULL struct device pointer if not.

>
> It's possible that some driver makes SCM call in parallel to SCM device
> probing. Then, it might be possible for qcom_scm_get_tzmem_pool() to
> return NULL at beginning of function and then a valid pointer by the
> time we're freeing the ptr.
>

I thought the SCM module is initialized at subsys_initcall() exactly
for that reason? Because if the above can happen then we have more
problems than just that. What if we enable SHM bridge during probe?
I'm not even sure what would happen to SCM calls in progress that were
passed regular buffers before.

I think the SCM driver should be improved and not allow calls until it's pr=
obed.

Bart

