Return-Path: <linux-kernel+bounces-248034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09E92D790
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6DD283FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64F195FEC;
	Wed, 10 Jul 2024 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eAzM5bMV"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6C195B12
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632963; cv=none; b=PkhEDEQg9CVJJ6XVUwNkOZT7H0XnE6GSK9Ztpj8Ve5QpwreUIkW/RBgy5qAcyr8wtNLAa8qSErXSzmuArob0bsKl22OKO359cpKT0xk2LO1zozs3qs3tMc+DJEMTNiNHCxkbN6I6dWawW25k6zY32k/w6m3GrZL9BwYhDLs5lPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632963; c=relaxed/simple;
	bh=JvlYBD4fzcDp97Xg4Q6bsG021KVmSIAGfMUuM50hu78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQnOp4/4+3tQN0XUrzGt5pZF7BHdDP8b7GBPtg+Q+6m7fTMkoogElBz81UFyPHUNwSASbwST6UEsWMBCsAWszaL3E1LCGR9667yQWAbHVDCIpv+lAddIeevARTL21yQSBch6NT5gMOFHTo/fuk8iPWwFOu1J1hOzNwvRSFxwbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eAzM5bMV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79ef7ecc7d4so2545085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720632956; x=1721237756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crXHuoCnWWxv6iDdm0t07OpWrmAQmRLaORcG897D/1M=;
        b=eAzM5bMVO/87V7HBwP3Zx1ONnvaTTdrmVJYB3xwIxYm7acKnl9pyGEx8FPYQj4QMED
         hhTPWseu7NFzTf+x9RIdhRGKb4yQYxaqfw/AjYQwdMTqCaaqii7bRlQyvxMs94gmuDA6
         UVD50VkfzUw8UMvYKOQlrfmpTTYItkv5IZ1E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720632956; x=1721237756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crXHuoCnWWxv6iDdm0t07OpWrmAQmRLaORcG897D/1M=;
        b=jS1pHekdwKI6L/Azg5/oOB+cA4amP8gPmGZtTYQ6KZfg3Qd69RQpCqc20HXdb7RRzL
         pvZF+kt7Mo5oxl0RiSW3BfVp1Xc7Cffc5SN4jU2UOS8ls2/AmxNHesIOCEBvuL9MdVBr
         V3ntXlXGjCIU7wsz6TiYmNlxHfnmBhC9DibSNqGYyxWaAt36q+AlfK0aZ/jfGj7/YPlc
         cAw+xpWNzO8dFtQlDpFC6ycI8wW4wYRobWr9Y2XWAdncipJVa55gFV9I+lAtfLAu3tY9
         JU1VUlP9gySHayxCDkcAKnLSGxbJ/Iuuczrq1BdbrgkPxp6qsSjW6j7+6Zp4agnep8SP
         WMLw==
X-Forwarded-Encrypted: i=1; AJvYcCUO4eZiUwpVnLoMi87d4iTfGyRMLopEHhGkbMZdXi1ENiNS/z1at3iHVR5d316Cc+z9W6ZDM+7z66mvRNwGzCd5N6gRyEyLtVdpRnaB
X-Gm-Message-State: AOJu0YzI/Ryc5DmWFVjHtPTLXxDxaDPvMNQDJRPpkgBfFcFbmLNUMalp
	4CVJmSPzyKe/tmwKGhQ+ggu+SBJ2EUYzsWNIY7pxIwOEnFV8DgXUKYwAzxysgpx9ya1vzjQWJ5u
	hsw==
X-Google-Smtp-Source: AGHT+IFyNnRhYQHA/HmhEG0NZIMT91SsSi4/LP8pNbwAioc7d8O75H/g/46MFZ5+a7w9HyVI+8LFwQ==
X-Received: by 2002:a05:6214:19c5:b0:6b5:e3f2:11c9 with SMTP id 6a1803df08f44-6b61c1c2790mr83427396d6.49.1720632956449;
        Wed, 10 Jul 2024 10:35:56 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9d5d6fsm18787996d6.35.2024.07.10.10.35.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 10:35:53 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-447f8aa87bfso29961cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:35:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDzRNmbiAR1axNgbhnRcfp/U43QcjG7a+mVSaOWfJ8pgfyu/latfDP+7UE377tuvgHU+FAGV05HWNf6pNhEzbLaYCOZu0WQtucUGBO
X-Received: by 2002:a05:622a:7604:b0:447:f5de:bd18 with SMTP id
 d75a77b69052e-44b191f6ac5mr3688571cf.9.1720632951079; Wed, 10 Jul 2024
 10:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org> <20240710-x1e80100-crd-backlight-v1-2-eb242311a23e@linaro.org>
In-Reply-To: <20240710-x1e80100-crd-backlight-v1-2-eb242311a23e@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 10:35:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X5rJUNq_QUBf7WMrof+9rh9Jhb5zoqK=Y6jqUUi2Nt3g@mail.gmail.com>
Message-ID: <CAD=FV=X5rJUNq_QUBf7WMrof+9rh9Jhb5zoqK=Y6jqUUi2Nt3g@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/panel: samsung-atna33xc20: Add compatible for ATNA45AF01
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 10:05=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> The Samsung ATNA45AF01 panel needs exactly the same non-standard power
> sequence as the Samsung ATNA33XC20 panel for backlight to work properly.
> Add the new "samsung,atna45af01" compatible to the driver to make it hand=
le
> these panels as well.
>
> While ATNA45AF01 would also work with "samsung,atna33xc20" as a fallback
> compatible, the original submission of the compatible in commit
> 4bfe6c8f7c23 ("drm/panel-simple: Add Samsung ATNA33XC20") had the timings
> and resolution hardcoded. These would not work for ATNA45AF01.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/g=
pu/drm/panel/panel-samsung-atna33xc20.c
> index 9a482a744b8c..fd56fd02df87 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> @@ -333,6 +333,7 @@ static void atana33xc20_remove(struct dp_aux_ep_devic=
e *aux_ep)
>
>  static const struct of_device_id atana33xc20_dt_match[] =3D {
>         { .compatible =3D "samsung,atna33xc20", },
> +       { .compatible =3D "samsung,atna45af01", },

As per my response to patch #1, you don't need this change at all if
you just add a fallback compatible. Later if there is anything special
we need to do for this panel we can match against it, but right now
there is no need.


-Doug

