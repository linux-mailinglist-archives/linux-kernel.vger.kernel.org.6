Return-Path: <linux-kernel+bounces-340212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9AB986FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47D71F21954
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004B1AB6E8;
	Thu, 26 Sep 2024 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szum4kl2"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592011AC89C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342581; cv=none; b=eJExgXw28AwXakrdJRbmUX7yJXbUAJABPG29gOfzikwbBf9Wovprc3hfZL674Z+TLllaVyBXdb5Gmi4UMIIZ8S5r7DGpsXv7Gki64hbobkSpJf71wog/AQ80djNuQhV/Mz6sPZrtGY+1/8oddaOlrtFT6RexyGe+Mx9yNzrnlcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342581; c=relaxed/simple;
	bh=gUoEtIkV9cH1qFhqIUs8Q3i4kxbKsbsjONdXcxA4tqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ef0WgehWw/mzGJCE1ZhGw3OzuymaLba58h1kOYudj8Dy4qHcDfgRmqpS9qsaBk4rhgV9oKA+RvT/yE4kClrnm1GmEUpB6IuxcDBYaZNfceJxZYXK2U1lqLWCUg5gj8V+5HKssWgot8adl4zY0kIPrnrsaMBAFstM8GyiPua6cvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=szum4kl2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6db9f7969fdso6952647b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727342578; x=1727947378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZGtXs4SnucH/2vV0KGS1J8bE5d3j0Fh63iPQCBAM80=;
        b=szum4kl2zyZnrhLuepmm0C/+HyOY4rXsPtj4ThSS8MU1lgGt7GO7ZmScEp9BWsKF5e
         5j6nf4WfYv51DcmWke12MCoqj0pU/fwQA22LklFcm9FeB8igibVsLCgfvLxaPSNs7b6j
         nKWbLnyUMUSGFlb9jCP+DmRgf0mGBnbdtK5UWCjd6WSOOXKMeggX7CKEJGqqOuFkruIL
         v/N0JMItpYYhMVI0IF3ZKionqO5ebk3dLPvNFDu/GiNtTOlPC29YsLA+3S2UtzurggMF
         76J9hOt2BanuLqLn4FWwxQw9B07QoUNlHL8N/xs9SmpUzoN8bmKk+03lVsWb0mzyZPQa
         SrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342578; x=1727947378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZGtXs4SnucH/2vV0KGS1J8bE5d3j0Fh63iPQCBAM80=;
        b=OzrLLHn9xUz1meiySmwiLFM2VXILGlChyAcBsvIHII/GkZximNw/F97Wb4YZOwt8Ui
         2ATgX0lU43+8+r7iNTYPvFPvwW52cmlnnB3FBF+AIJ8bALwOceISjSTFHrGrIkwpmsL5
         zjvuxqk23gRA2hlF8lCMsxUTovtv3lRIFytG8fCq5plgyFbjXTLadKfG9+RRbpVEz+or
         wo6z6KECzfo3YH9bl1oTbDrXTakpKYs1hObDttiN+SaVkHqkEUFp4214UWiH0cJnMr/Q
         W3JoJFk2bseFEBslT06aeqaUZJxu/J/fDVrvx3mTAcfrg88sBwPntIycALJg/NaWpZzu
         YeeA==
X-Forwarded-Encrypted: i=1; AJvYcCUx6ZVdIOBLlqhZCqSU6+5air/fMKWjKP5ORvaGHtEAUfyrQzYfOnGusml7+XvVjlPAPXRB45b8LEguE3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyT21kqtl9DEDsofQYflgl4W0OJTtd7kRb9CEdjDcaF5womZf
	Qw11od/MsBxk/iUcU/QTi2SlCH0T1zqDU9enSVmMoQXvspJ3BmD77vMztU+2CJWw7/cxM2uGoaW
	aioAC6In6DJvP4mhku14o2uDqHJOZWX/W73DX3w==
X-Google-Smtp-Source: AGHT+IFt9+XUc/nU9CnjzfY8rchFZ60R0ODamPwBCn1bvMLBUHAlkIVUGyZ+P/73Bxs2FGRrF7jjbcdhBdl3LCi67FQ=
X-Received: by 2002:a05:690c:660b:b0:6e2:611:7abd with SMTP id
 00721157ae682-6e22f004833mr18307427b3.20.1727342578171; Thu, 26 Sep 2024
 02:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926075134.22394-1-Hermes.Wu@ite.com.tw> <7pazkukfrskc6o2zd23h6o4wyt7ougjjgnmogy2effr2lof7di@7opphoswhebf>
 <7ac7de7a5c7e417484bc2a4a1ad59ac3@ite.com.tw>
In-Reply-To: <7ac7de7a5c7e417484bc2a4a1ad59ac3@ite.com.tw>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 26 Sep 2024 11:22:46 +0200
Message-ID: <CAA8EJpq2rZu5ciSc4Zg6cO66B9b7QLszgZjhhqX6Mk2Q0sHpdQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] drm/bridge: it6505: fix HDCP CTS ksv wait timer
To: Hermes.Wu@ite.com.tw
Cc: Kenneth.Hung@ite.com.tw, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, angelogioacchino.delregno@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 10:39, <Hermes.Wu@ite.com.tw> wrote:
>
> >On Thu, Sep 26, 2024 at 03:51:33PM GMT, Hermes Wu wrote:
> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >>
> >> When running the HDCP CTS test on UNIGRAF DPR-100.
> >> HDCP must disabled after waiting KSV for 5s.
> >> Consider system ksv work schedules. The original timer has a chance to expire.
> >
> >I can't understand two last sentences, excuse me.
> >
> >Nit: KSV, not ksv
>
> Form HDCP CTS, DUT should wait downstream KSV list at least 5s.
> And driver use a while loop with a 20ms sleep to reach the scope.
> The true wait timer will reach 10s which is much longer then it supposed to.
>
> It should better use other APIs to implement this waiting, rather than just reduce the counter.

See all the macros in <linux/iopoll.h>, maybe that helps. Consider
adding a version of read_poll_timeout with the in-loop break
condition.

>
>         timeout /= 20;
>         while (timeout > 0) {
>                 if (!it6505_get_sink_hpd_status(it6505))
>                         return;
>
>                 bstatus = it6505_dpcd_read(it6505, DP_AUX_HDCP_BSTATUS);
>
>                 if (bstatus & DP_BSTATUS_READY)
>                         break;
>
>                 msleep(20);
>                 timeout--;
>         }
>
> >>
> >> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> ---
> >>  drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> >> index e75bc1575aa8..22d9bec3faea 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> >> @@ -2093,7 +2093,8 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
> >>      struct it6505 *it6505 = container_of(work, struct it6505,
> >>                                           hdcp_wait_ksv_list);
> >>      struct device *dev = it6505->dev;
> >> -    unsigned int timeout = 5000;
> >> +    /* 1B-04 fail, wait to long to Stop encription(5s->3s). */
> >
> >encryption, most likely it's also "too long".
> >
> >> +    unsigned int timeout = 3000;
> >
> >What is the timeout per the standard?
> >
> >>      u8 bstatus = 0;
> >>      bool ksv_list_check;
> >>
> >> --
> >> 2.34.1
> >>
> >
> >--
> >With best wishes
> >Dmitry
> >



-- 
With best wishes
Dmitry

