Return-Path: <linux-kernel+bounces-228046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389749159FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C47282125
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B11369AE;
	Mon, 24 Jun 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Leux423t"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203247A64
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269194; cv=none; b=aDj+tsIOmF4rQ/9N85fqwc0J+6UJhBXDViCfX3l6eRyOToQRrc4wYOL6xr5dLWD63yb/n9MabtHlG630XQSxl6TwQiORQiDCpI2elkKbigcTwVHQpwPlBPu263HesE26xjYY1TDKYCmI/ivY5wEzLAplD7EchaRnDmh88UfqUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269194; c=relaxed/simple;
	bh=a9BjekUwMlFuwQl22+Ay1e0uJovQZQb8mhyMziOFm7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDzqhRHH8oEOTyeTC0aRne6IIDXB2+nkCheWfy+XVEGY7y/Z8HWkvpUjH1iN3qJmyDuDCR7vqgZeHb0XixgXeyVvzK52Y4BcC7gsXFw0fysQUI21zSAgTr/spJm59O6eU7Ab9X48AD3M1vaGhST28fryzc8e2OpKahy3KGpmmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Leux423t; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-643efaf0786so16812677b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719269191; x=1719873991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P3iBsbrlnas2q2TyHLGB/sfld3ZD6H8nDpiPUd64c3E=;
        b=Leux423tVLy/Zr47DGEvWfsI5cNvZhL31DzB6LkrNsQA6eXAOKPOUfGY5I6UmvVVWQ
         VYAj74g9151KqSPbsdFMSKz4E6zMtsLo7ZEgcdaEKnEzm5CK4b1+G8CRR11BTuwrx0+a
         /rZs6NT9voOPLAkizJMwjopwmVW9zDu7Sn8djdLwcpXTuDLJ/mjASc7EoKJALbSDsGZJ
         31PXT/8cj/BANdUccmhOOCmjcS+AggV53utGV8nCcSMhN/HhQX0zfmsODjvj9rlTBCKF
         BDKIkR7Y7M+jE07bgcNN7XoG19/vFoawWLSNEc1J4xyV52oOaaQ/17lNFbgv23+q+YmY
         3zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719269191; x=1719873991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3iBsbrlnas2q2TyHLGB/sfld3ZD6H8nDpiPUd64c3E=;
        b=czrtEmj2djW/lDmFTC5y49PDDlEWFpjYLhfLz0u5U5jVtP9lM7lh1PphRLyACkDN1b
         idEf4MmSNEwYMPlGPsRPswGOm/7y/aTfqsf16lbnf/x9VWbJIA9ROMJdyeiCOR8KgRdl
         twuCJgM9BjorV08nFcceZoi++HCMayIlB1gxszqURfeebKXIWTK1V217j/1pgrwzxAE5
         kWR68qJgU2/jf161dalb4t9v/WVlsW8n3i1vyrXa/dyogNJGTZfF36uvL4H71ex1sjZY
         L7GUQ9sHFcUtFPVCk9VG6dMkVYMlf5eKg/BBcac0adjJs6ga0L3Cmz4IdcF0kTfFhki3
         eRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQUzOCEUipRKtjmpurv6zG7QYpXw9nkFAhGVdebvnecoKUQ1tv6kxJNxhTJNiDMbejCwYkYKGJYLR94HN9T3s2O/SzxixjoEML0iTU
X-Gm-Message-State: AOJu0Ywcxmmh7xHxK0i/XyzgxibvGOuk9G4Iku70/MnxmBcrSpERpdt2
	JKmRydxd+bKY0E5kR9SVCO4+uizwxg5Rma3bZJ8X4395N2xaw0lOLbVX/2smMi104JDaQHqyLNN
	8GPUvXl8FUzSMNx6H//It1gWKzhO3Svb0jV7Oig==
X-Google-Smtp-Source: AGHT+IGVgskHg3Fgbb1vY5Iscqeb2BV+TYDIsO4ODyG6Xxfx+hkkFs5OeqExEjmUtkaDltt6W14EpykC4/QEwhiSl1w=
X-Received: by 2002:a81:9c10:0:b0:62f:67b4:790c with SMTP id
 00721157ae682-6433f0e4b43mr50802097b3.14.1719269191259; Mon, 24 Jun 2024
 15:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org> <99ff549c-f5c4-dc9c-42f3-396dc3d29d6b@quicinc.com>
In-Reply-To: <99ff549c-f5c4-dc9c-42f3-396dc3d29d6b@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 01:46:20 +0300
Message-ID: <CAA8EJppcH-z275m6xDQaigsxmVhnfJkLVsq68GHLFoAq_p_2GA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/connector: automatically set immutable flag
 for max_bpc property
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	"igt-dev@lists.freedesktop.org" <igt-dev@lists.freedesktop.org>, Petri Latvala <adrinael@adrinael.net>, 
	Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 01:39, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> + IGT dev
>
> On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
> > With the introduction of the HDMI Connector framework the driver might
> > end up creating the max_bpc property with min = max = 8. IGT insists
> > that such properties carry the 'immutable' flag. Automatically set the
> > flag if the driver asks for the max_bpc property with min == max.
> >
>
> This change does not look right to me.
>
> I wonder why we need this check because DRM_MODE_PROP_IMMUTABLE means
> that as per the doc, userspace cannot change the property.
>
>           * DRM_MODE_PROP_IMMUTABLE
>           *     Set for properties whose values cannot be changed by
>           *     userspace. The kernel is allowed to update the value of
> these
>           *     properties. This is generally used to expose probe state to
>           *     userspace, e.g. the EDID, or the connector path property
> on DP
>           *     MST sinks. Kernel can update the value of an immutable
> property
>           *     by calling drm_object_property_set_value().
>           */
>
> Here we are allowing userspace to change max_bpc
>
>
> drm_atomic_connector_set_property()
> {
>         **********
>
>          } else if (property == connector->max_bpc_property) {
>                  state->max_requested_bpc = val;
>
>         **********
> }
>
> I believe you are referring to this IGT check right?
>
> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_properties.c#L428

Yes

>
> I think we should fix IGT in this case unless there is some reason we
> are missing. Because just because it has the same min and max does not
> mean its immutable by the doc of the IMMUTABLE flag.

Well, having the same min and max means that it is impossible to
change the property. So the property is immutable, but doesn't have
the flag.

>
>
> > Fixes: aadb3e16b8f3 ("drm/connector: hdmi: Add output BPC to the connector state")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/drm_connector.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)

With best wishes
Dmitry

