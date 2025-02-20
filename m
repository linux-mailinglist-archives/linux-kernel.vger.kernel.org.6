Return-Path: <linux-kernel+bounces-524147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70246A3DFC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD63BF13A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28121204844;
	Thu, 20 Feb 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rt8FWzdd"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650301FECB7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067285; cv=none; b=FCDGr7QvIB7EaA09c05VckwuJKwgqRHYdjAcgeKG6U59wpeNqgWczymhXQsFf2D13IPwDeot0CRJqetRoIdxQq3LnA6o68XatvZv8TgzQwAcCXS0xTGWV/M1XX5bErA7SPliZcY32zg8/jAq1I0BvNsXmbYMTx8uWIPRvcnMOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067285; c=relaxed/simple;
	bh=D7fGLcNCTlWkEIMA6yhosu92ytPx4ifoWAm+9FUUpC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIzCM4Moo3cXbmxq20leWvL7PKgBcoSuFjxXHJ1xJzV2YYyPjMzzb38B44A1yy7aB8TKO1OmrToCRZhbUYetGKLbos9EVg7iMMPdPtsSrpZWkJVhs2pCOz2sss5cSfTPD51XQkoZDGAfCgVY+OAf3AJHqI4m0ptuYOpWEIPTliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rt8FWzdd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54529eeb38aso907534e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740067281; x=1740672081; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D7uMaJ+RwChO01hxZjoaxGW4+xIyMJhwhgQfBtPgKqQ=;
        b=rt8FWzddRmlpJ69Jn5cJooqowHcD+Jh9SOkjf/RJJ7LcSyaSPm2GdWPqfMO9DCYxEa
         xBrrhcB+0alvGa0/cxRE+AtK7zSVq+ipC6BzoKpPVb9xkHILpvjVNIGZ3l8ORgvFAW8x
         kqJXhtnrFrk6/RmjPaGZ7FTHxKW+FhYv7RlNnAKBX4wUGjN+iDXyIDnziVLBUMWRlc3u
         Dyw2/HnYucDYajbO40MqfD8Z5mS8GLqqZH728xHBM51GqplFg0MuFTj+BTdiU+iAyhZu
         734uzBFtI8WYcJoYYha2B35BZuS0Nd5VS+3o3YdFJOuXvbKPBiJOzwXyNImd6dqishPs
         kb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067281; x=1740672081;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7uMaJ+RwChO01hxZjoaxGW4+xIyMJhwhgQfBtPgKqQ=;
        b=mg+XJLeabvjwRfoQrt3jtbvecENzD9ZUpRJ/CzVdwBHMCWDTyzNV+BX7GYdsnGouaD
         EIUxbbwVKmn3BxiBi6XHABPkMljrmegZ5V9UYCAu7AoKiH++pjRohiJTCPb4v2Ef5No9
         JtbLYhFiGteIXGCuPzWtLryxGneF4UCrh3Qt1upiaR1baugm6I1BOg3JY+oh91LKOacN
         SLULVlZVvNAEUV8cGZh9fJsaQ56d99AhC3tRPdK+Px2ZoJopwmMq+Evz0HxEPtV3kc33
         zcCMV1969tWlwqC+a0G1n2cLyYAgtqByEqkXVTNFXGpfH2CutWUcEwN6jXUJPMsn1nXv
         pTHw==
X-Forwarded-Encrypted: i=1; AJvYcCWgUDn2BiJyQmomSYYHqAc7g0u41odliHB37qo4nypBD2QZOx6iLxu2JwcxSgvHB2+sAkB8g0m7tokLS+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxet23i7c1SnalzAC6nFj8Si+wToZSDoQbWSbCUGLQlrrYq1Cmw
	WYPZdWsoWHV7b4qiy3KTIEPpX3WfhtDoWKPnbuDDuM2gz18uBgZwvZDPgiGBE4g=
X-Gm-Gg: ASbGnctmtVigJRGirPMtavqCcQ6YyoPnDsCk8vw/ruOXZNz1ZZO04Z/zUjQZvmhB9lC
	AQjXzaZxG9IBXxdp2rBjikDS886fIW/UfeORYGPWECwXFjq3ijpOr6aJzyqmpHUEiMW69IRzzQi
	Hl085Tqi28OYMWlclD3gRGwlXEiEgRuZPr/Q+HMx+OHBVhN0QsBegKahK16xG9uDAj61t0xBY/l
	ln0JVmRizHJBJeLk8q7jLRGNCSkIlDzpLRhJYx9CHXGbqFRrOzP+L5+m8uH1+YhafFRr5V6IIwJ
	8JfKA1BuLdnt3jnEuMrlzz+UvS+myoif91eYL6EqFxhK9uB3M+fzoXkwGdvG3FL/K/74G8Q=
X-Google-Smtp-Source: AGHT+IHqMDlC+H8RZoqVWnhQETDl2ri4FVZvFzP/vWvYk8fuNuwIU7s64KnfHdGE7ogyzQwh4s67sQ==
X-Received: by 2002:a05:6512:b0a:b0:545:1bd:a0e7 with SMTP id 2adb3069b0e04-5462eef45c3mr3472174e87.23.1740067279884;
        Thu, 20 Feb 2025 08:01:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54531db6e08sm1733027e87.217.2025.02.20.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:01:18 -0800 (PST)
Date: Thu, 20 Feb 2025 18:01:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: display/msm: dsi-controller-main:
 Document dual panel property
Message-ID: <dqbosrbwgbeii26wwj3tfsqnjgvq7har7nvs2ifato6nmxqbie@2cexn4xyyh3p>
References: <20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org>
 <20250220-dual-dsi-v2-4-6c0038d5a2ef@linaro.org>
 <grdadzunaabzg5jxpsiasgzbioy24tctlhhyxg6zwdkpv5vjwe@7k2di2myu4k6>
 <CABymUCMn+USbm21agBZbe=JmV-FzLdVD4s0xgg0CPU=M9jvC9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCMn+USbm21agBZbe=JmV-FzLdVD4s0xgg0CPU=M9jvC9w@mail.gmail.com>

On Thu, Feb 20, 2025 at 11:40:03PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> 于2025年2月20日周四 18:33写道：
> >
> > On Thu, Feb 20, 2025 at 06:07:55PM +0800, Jun Nie wrote:
> > > The DSI interface can be connected to a panel that has a dual DSI channel,
> > > or to two separate panels, each equipped with a single DSI channel. To
> > > prevent the DSC configuration for the dual panel setup from disrupting the
> > > current configuration of a single panel with a dual DSI channel, add a dual
> > > panel property to support the use of two panels.
> >
> > Please use the terms from the standard. The "channel" is mostly used for
> > the "Virtual Channel" or the "logical channel".
> 
> OK, will use DSI link for all later description.
> >
> > Also I don't follow how DSC configuration for a dual panel setup can
> > disrupt current (?) configuration of a single panel.
> 
> For the disruption, Marijn mentioned it in the last post.
> https://gitlab.freedesktop.org/drm/msm/-/issues/41#note_2411541

So, why is it happening?

> 
> >
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> > > index ffbd1dc9470e2091b477b0c88392d81802119f48..e3f2eabde27609a66d6d81fafcb14e1bc014613c 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> > > @@ -88,9 +88,15 @@ properties:
> > >    qcom,dual-dsi-mode:
> > >      type: boolean
> > >      description: |
> > > -      Indicates if the DSI controller is driving a panel which needs
> > > +      Indicates if the DSI controller is driving display device which needs
> >
> > Unrelated change
> >
> > >        2 DSI links.
> > >
> > > +  qcom,dual-panel:
> > > +    type: boolean
> > > +    description: |
> > > +      Indicates if the DSI controller is driving display device that composed
> > > +      with 2 independent panels and needs 2 DSI links.
> >
> > How is tht different from qcom,dual-dsi-mode?
> 
> Your questioning is right. The dual panel case is a subset of
> dual-dsi-mode, not parallel with
> dual-dsi-mode. It is single panel with 2 DSI link by default, and 2
> panel with 1 DSI link in
> each panel if property dual-panel is present.

And what if it is one panel having two 'logical' panels inside?
I'm trying to point out that this should be a property of the
struct mipi_dsi_device (or an option in the struct drm_dsc_config).
There is no need to describe this in DT.

> >
> > > +
> > >    qcom,master-dsi:
> > >      type: boolean
> > >      description: |
> > >
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

