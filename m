Return-Path: <linux-kernel+bounces-394758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2EC9BB38B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A67E1F22DF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9FE1B2180;
	Mon,  4 Nov 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHPl7Yko"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B418C930
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720111; cv=none; b=mFAMUu0bX7BUUK9Ihk2/WZS0lDDTjvXOOTmHqbCjGeQowRpb8uJ+6+xZXrlCTtFaDrxCaqg+zqYcrg9PwUnhNz0Wvl8c3o2JAF13KePjX1a1DbkJgUAlfGiOP+fL/kYyMN1Mu0QAZSXW2Dc+6X/8rJussoUsYY7yDW7AFfrezds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720111; c=relaxed/simple;
	bh=v7y3fY03KoFpdy9AC7A0PLBPjDMIEf1ClFKqwm812L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgdO07nDd43chCpTwxnMn0yh2kD89FOCFRJJkv8S4DKpMFCRaT6/kB+SThp6/PHG+J0mSps11SG9MtzBKWaqoaMtXFvAlhX+5+w0mX4txo670fj74gCVQvCQdkodbVc2wUn8tNqfjDyoTwEGo9ltpmpOv1iFA3k+n8d7CU0mohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HHPl7Yko; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e3b7b3e9acso34489057b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730720109; x=1731324909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+q526szksjV4oUTdEUzEItSXwLxa3VoCkmyV8G7Sbw=;
        b=HHPl7YkoOdIFXuSUv5MM75eq7FWRoPgYAlBG7WJs3d/CLM1gLxW4u6i1dbDD46VBWK
         yTzjf+9PXWRwgeIP7gDyxXXF2sou9R3C1RlusxOXonneMM/cgYK+x5mRZQRoG140yFkI
         Fb+vKGRab6SyG0zAUACZeM78t84hSZuInJS45bqANScWhU23W0JofEjoZOEcCucha8dq
         NGO0E4dtazCPRnIPbuR2vjyT2KQrVMffKY4HjHeR+fQC32eIIGdIirHO2u/AW4+dhY7n
         P/dO9qFWPyXvju4KpQm9ijEOE0tqm0rVlqdn/0V7wxFb+tFYXCDoRLJk79OQnnSaMUp7
         ZB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720109; x=1731324909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+q526szksjV4oUTdEUzEItSXwLxa3VoCkmyV8G7Sbw=;
        b=b5xEbnsIpeBpVhu2v/O/pHuztRSYnHuOhy0F8BSvtiP/vM167CWJWvCy1Qy0iHxDEw
         GHArY0Kg4nCVuNuzBs3r3GQNk3EbHy1AOVNyandbmzRMIXPoPclg70eDC8yV4JzufBTM
         N8eiV9zcJCwGYFkcv+xM89ji743KnJFb39ACM1gJhdfEvNwsqIzwsrmHBavbc+gfAmS7
         YtmxyAvkxweimFRf4DJI9S44JYiJSrQzofp+Abcj7h4tPIXVaaLfB+OgOE1a3ZZhaUPT
         KKfLJNQk0BaMFcKraHs2RdcxK10hN+nmNDuiIcgpwPafXKP2epd5jYCKYkuiUzvDWF29
         +NdA==
X-Forwarded-Encrypted: i=1; AJvYcCX8G7bQDbP4OttpvnuJzv8X7DTTUS6dLiVz3PIOKZEjDvLTli4g5lqgRv9WXVW5s6MWiQJ7rgXpsN7PCjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIPsksyR7y3eO1CCAClSgPxPcbdq/4R2T/Dc+FzUnnpe9VQ2Z
	mKieAPITtgsURgZdEKpJfsF1orx+9J6pkAm2gUZJdO8xdm3G7x5Q3KBezFZJ/T2sFslq1jVfLJ9
	4ta9KAniNCB1N6slfEgqNtIMyeVgEr6Zg2d9pzw==
X-Google-Smtp-Source: AGHT+IG/P2mRXyw/LNVggtIlhZam9RfjN+tz6hskDj9CnkjlIOHIK1FW4HU1XswdomDcaoi15YZfNPFVGYESfvaEO6c=
X-Received: by 2002:a05:690c:4d01:b0:6e3:2b5e:918f with SMTP id
 00721157ae682-6ea64c12827mr124473837b3.44.1730720109012; Mon, 04 Nov 2024
 03:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org>
 <20241103-rework-qseecom-v1-2-1d75d4eedc1e@linaro.org> <02171841-acd3-4f26-987d-1376caf11481@oss.qualcomm.com>
In-Reply-To: <02171841-acd3-4f26-987d-1376caf11481@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 4 Nov 2024 11:34:57 +0000
Message-ID: <CAA8EJpqwY+kuOV1xu4vw8pC5AFhpK+J7P9mnyLeHfaf=CJkRMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: qcom: scm: rework QSEECOM allowlist
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 11:24, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 3.11.2024 4:37 PM, Dmitry Baryshkov wrote:
> > Listing individual machines in qcom_scm_qseecom_allowlist doesn't scale.
> > Allow it to function as allow and disallow list at the same time by the
> > means of the match->data and list the SoC families instead of devices.
> >
> > In case a particular device has buggy or incompatible firmware user
> > still can disable QSEECOM by specifying qcom_scm.qseecom=off kernel
> > param and (in the longer term) adding machine-specific entry to the
> > qcom_scm_qseecom_allowlist table.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/firmware/qcom/qcom_scm.c | 37 ++++++++++++++++++++-----------------
> >  1 file changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 9fed03d0a4b7e5709edf2db9a58b5326301008b4..6f70fbb0ddfbf88542ff2b3ed2bc372c2f3ce9eb 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -1743,28 +1743,23 @@ module_param(qseecom, charp, 0);
> >
> >  /*
> >   * We do not yet support re-entrant calls via the qseecom interface. To prevent
> > - * any potential issues with this, only allow validated machines for now. Users
> > + * any potential issues with this, only allow validated platforms for now. Users
> >   * still can manually enable or disable it via the qcom_scm.qseecom modparam.
> > + *
> > + * To disable QSEECOM for a particular machine, add compatible entry and set
>                                                        ^ a
>
> > + * data to (void *)false.
> >   */
> >  static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
> > -     { .compatible = "dell,xps13-9345" },
> > -     { .compatible = "lenovo,flex-5g" },
> > -     { .compatible = "lenovo,thinkpad-t14s" },
> > -     { .compatible = "lenovo,thinkpad-x13s", },
> > -     { .compatible = "lenovo,yoga-slim7x" },
> > -     { .compatible = "microsoft,arcata", },
> > -     { .compatible = "microsoft,romulus13", },
> > -     { .compatible = "microsoft,romulus15", },
> > -     { .compatible = "qcom,sc8180x-primus" },
> > -     { .compatible = "qcom,x1e80100-crd" },
> > -     { .compatible = "qcom,x1e80100-qcp" },
> > +     { .compatible = "qcom,sc8180x", .data = (void *)true },
> > +     { .compatible = "qcom,sc8280xp", .data = (void *)true },
> > +     { .compatible = "qcom,x1e80100", .data = (void *)true },
> >       { }
> >  };
>
> + Steev I think you had some unhappy machine
>
> And maybe 8180 Primus?

I don't think I understand this comment, could you please explain?

-- 
With best wishes
Dmitry

