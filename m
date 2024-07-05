Return-Path: <linux-kernel+bounces-242341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5A9286E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED7A281C51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7E1474CE;
	Fri,  5 Jul 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivhoeSsd"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4622313
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175840; cv=none; b=EeKBK+K2avcPEn639Cr7HOoStJihpfq8xj94V/2AiK967FEAm6G8hVkpuBkhRyeun1rdpdqfuCAREp9ggEHQEuFfzhXoHHHiz7A7fX4HGhAcf08tikVfIEd3AKVV93c0p4IcYqSdZD7PUGnQezo0dvyZnabIMyJOOOWd7wdCEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175840; c=relaxed/simple;
	bh=vg/o2PwYr7WHT2tkZKyZ/BUI8LCPkKroh6MQ8VuKmUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTQo84zD6aLhiOF1sB1UaRFEV8XblCuSxCgESkj5p2xi1VIrW5EkmlvDFxtJmli4F12MDankUSRafZxBydf5ru0B/vrO1Hi51T2/7OcbWbGrV9+stycvuA1FfQ7Ib25iXBX/zvOlWmneYUUxCNmwFJHTQon1s/DST//hR3u43ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivhoeSsd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64d408a5d01so13812947b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720175838; x=1720780638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m2XtIKUct3GoVpvVT51gcMt9lCIMQVUjJmUxCbtHQWg=;
        b=ivhoeSsdlz4IYi/XU6k4GoKgGTPDVP7dCKBPQzNjgjfSCDPeXlKTtb/TinEcJTU/gk
         lCR2tbxreImB/WU1uWEv6TlW/5TVzNyU28UpKM92jmDCu3YE4fWaprjpjrn1t7aJB8Af
         TQjItoz0nRkwdHvaEwqROg4dM/oIitr7PkDPexHlAdzOHkh43vKuSvaplJjavajSwDC6
         uL6MwienKMreK+XBn4uPYyV+nrMr1/kbGRUGBlOTyv4UMl/xgKL3yCLF+2JQdNU1eRHY
         qmlCI+vJA8WYAXj+u1mmKLljQdTj1pWmC7bR2ANmA3vePQWoQHfxpmPwvE3HkheAYGMy
         gH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175838; x=1720780638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2XtIKUct3GoVpvVT51gcMt9lCIMQVUjJmUxCbtHQWg=;
        b=XCFiMXMsi5GkLjj7EPupeixOmy2rHNMM9RJ38z2e1iQnBfMvuaJ/vkeTLDsZqIFo3k
         7aF27KW3EfwGtd2WUV5IXt/vr6icfkfXka815P06JRzC5Z+UqF1TYyDXee8qyFh/1A/O
         R8w+7GcxsvBcY1mD8yRKoU2GRjtSAVL4IAXNmo7IXzm1wLnO1wWILen1GG+gKQTl5oOP
         VBvhcRqXkK1773ZqiOSTg9z+8YfTYuCMpiKVvJgQHLdKZA9+jefNEXJTP//2C/qQCWL4
         Nw2jBkFGJk721w4/1ysa9m/5YE6gtuBdgMY5hGwC9lMB0AgEEIOB8Jlud+D7iTgofk+1
         cLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqrbcez9/n1aXANVeeNRVkYM+M54gHy45aqe+5TIRhcBuuh2DrxUZ0Zr+KwBfQtJmXZzVC1YukBXI1dtTaLtAwihGsBixSfyRxuovK
X-Gm-Message-State: AOJu0YxN5N2jP+73J63T1E3voSHq1v8HV0cFtFPbpiWeoFlscuSq7E/A
	1O+k5sIdwcEMOw5Fw/v4DCMto76sUj/5/gKEbaXrMO7a4PGffv3BXVf4jGRcqXwI6shQb9TdM5i
	FqmIFwkS/Nr4dd1xSWez8T8rDajdmr/pW6mkLNQ==
X-Google-Smtp-Source: AGHT+IFUuR9ynJphCsPUUswmmP1sTtxf3bEWDrRSxQM5hyzJJMrR4TCQnlrOPzhdeD9bqEPMvuoPyV/zYG97IutZQI4=
X-Received: by 2002:a81:8453:0:b0:63b:eed2:64bf with SMTP id
 00721157ae682-652d8037b15mr42197147b3.32.1720175838157; Fri, 05 Jul 2024
 03:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330205722.93801-1-krzysztof.kozlowski@linaro.org> <20240527144700.GC713992@gnbcxd0016.gnb.st.com>
 <77b4e4ad-2b1e-4b6d-bc3b-0c7b339bc295@linaro.org> <f207b481-f530-4f54-a482-218908869050@linaro.org>
 <78384e57-4139-47c9-ae5a-480c0d6b9daa@linaro.org>
In-Reply-To: <78384e57-4139-47c9-ae5a-480c0d6b9daa@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 5 Jul 2024 13:37:07 +0300
Message-ID: <CAA8EJpqmawrbXyhQ+5SrX+=F5LUuyLNnOb21SPzbg=3vbnDg7g@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/sti: hdmi: drop driver owner assignment
To: neil.armstrong@linaro.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 13:04, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 05/07/2024 11:59, Krzysztof Kozlowski wrote:
> > On 04/06/2024 15:18, Krzysztof Kozlowski wrote:
> >> On 27/05/2024 16:47, Alain Volmat wrote:
> >>> Hi Krzysztof,
> >>>
> >>> thanks for your patch, sorry for the delay.
> >>>
> >>> On Sat, Mar 30, 2024 at 09:57:21PM +0100, Krzysztof Kozlowski wrote:
> >>>> Core in platform_driver_register() already sets the .owner, so driver
> >>>> does not need to.  Whatever is set here will be anyway overwritten by
> >>>> main driver calling platform_driver_register().
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> ---
> >>>>
> >>>> I forgot two drivers.
> >>>>   drivers/gpu/drm/sti/sti_hdmi.c | 1 -
> >>>>   1 file changed, 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> >>>> index 500936d5743c..b0d84440a87b 100644
> >>>> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> >>>> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> >>>> @@ -1485,7 +1485,6 @@ static void sti_hdmi_remove(struct platform_device *pdev)
> >>>>   struct platform_driver sti_hdmi_driver = {
> >>>>    .driver = {
> >>>>            .name = "sti-hdmi",
> >>>> -          .owner = THIS_MODULE,
> >>>>            .of_match_table = hdmi_of_match,
> >>>>    },
> >>>>    .probe = sti_hdmi_probe,
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>
> >>> Acked-by: Alain Volmat <alain.volmat@foss.st.com>
> >>
> >> What does this ack mean? You are the maintainer, so what is supposed to
> >> happen now? If maintainer does not take patches, then the DRM STI looks
> >> orphaned.
> >
> > +Cc Neil, Dmitry,
> >
> > I pinged and pinged and wanted some sort of clarification here but one
> > month passed and nothing was clarified.
> >
> > I could be understanding the DRM process wrong, but if no one picks up
> > trivial cleanups for 1.5 months, then to me subsystem is orphaned. I
> > will send respective MAINTAINERS update.
>
> Let's do that, if Alain doesn't take his own patches that were reviewed
> then it should either be orphaned  or moved to drm-misc.

But it already a part of drm-misc as far as I can see:

DRM DRIVERS FOR STI
M:      Alain Volmat <alain.volmat@foss.st.com>
L:      dri-devel@lists.freedesktop.org
S:      Maintained
T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
F:      Documentation/devicetree/bindings/display/st,stih4xx.txt
F:      drivers/gpu/drm/sti

-- 
With best wishes
Dmitry

