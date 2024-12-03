Return-Path: <linux-kernel+bounces-429606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733429E202D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560FBB654AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F871F4274;
	Tue,  3 Dec 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yd3c9dvO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABD1F1316
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234294; cv=none; b=bSqikhJgcNn1WPhWPpFuNx5MuYSzCygLi8YraoaBE5HxXXmVchPGv1smOc20/WMLlpHLRpCTBrPQyUYv13DlolUpLq1TlwOsqH2fNVpHlZyVsNGWBtOgez/1HkLQ8wfPIDuvxKVHhOOGOFdrVm0FO03ofeYC2ADQ/VFqI6RJdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234294; c=relaxed/simple;
	bh=O3P0k+IkQDySNqJBtFm3kB0ueDZfee1HLHlqX0k6w24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B990tsXp26qPcVkuANY52vqIPzjvc8Pg2QkHQN1+eIbMm8osup07ZAhX1EAtWIrrFFuiI4uEkMMBtRhl81xf5AQ2m0QsEyHgFjykLPtStJSHEldAIn7BhqCRQMki2OQUIx9//Y60yYfR359y1XGzgiYThpeAtPvwewytpqD6wPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yd3c9dvO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53df1e063d8so7222912e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733234291; x=1733839091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj5SaA33rGzeah/pbmVRQIoqaIyNVExU4n/MvIb6OOM=;
        b=yd3c9dvOw4JwpdiX/pBgCFEDx2tp6WLWQsA1fs/Ag4aKpFl9WWhPqjPBEuFU9CCTn6
         S+VcO2bzVPzp5uD/li81Jc7EzuE7yRJY8aAsJ+ChWOb7vhkKB8xHeGvUX3AXck2Ku6bb
         IhgoR+kt21ieZ+QaOTWNeuzGjc/1yROmruGr22qeDiIFtgO4L1MtP9Ggqj88xBiacgUh
         qZePsKT11slajZ/NG0mmMpSPy+b/URtdv1s9XqDGpsFUeKmDfYLkHlEu+2/hKnwLBGrL
         Emwrxbv00tgwkDO/WS9TkTEmruu8xghcMo0yrbDrW6K7IoMur2rNc2SD1hgmO3B/pPrE
         RjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234291; x=1733839091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj5SaA33rGzeah/pbmVRQIoqaIyNVExU4n/MvIb6OOM=;
        b=YVFKL4ssg6FoYUlA7YOclzoktoD5YLIrqnLQGo2G9siKG0WdpHqq0gdInS8TZHk/NX
         zAfCVCRFgxZzEeivaQhX3Y+EDutjhQUJJF9sbKoxW0DxnjMWPbq1PPLznAidPCURLCDA
         rsjrAhynoZ1eSc8gx+mQIJvo84pnqpOFdjGC7pEA0lj7gKNZLqy03wkb082luERoD97L
         x3ceb1iSTWJsqgApkLwxulFTDCKeghhJ4znbQ4b0lUx6votpqpluGIuhjUFTY9Kxl2ua
         YbgP7SfyNS4gGwmFhOdLq+YDMvYCdqN8+I5YS0rtEG1ngGsom4da2tIabJ+7G2Zkg/ek
         8DIA==
X-Forwarded-Encrypted: i=1; AJvYcCVfr6G0q/WT9vYyOoUO6Z89XVHM7pduKXgG1Lq6HZmQwk+0xikVYujfBEO8/YvMEBbjn+WGZhhb4S9UQSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/QlFaOgDdYR+dd2QLcN65aJlMlzjlSjTfh6MwaWvi5eF05KI
	9FLYbq4Kz0BQHNNSz584YdZWGwxpPfig69NksGVghEWAEFN++3Z7ZTyqQ2q81N4=
X-Gm-Gg: ASbGncvuEf9zmQoRjOe3Nl/Az4Wn9K2v7dg5fR35BqoNgXAtxJF3ngJNw+RV9apClIO
	l2EObw8qKPaDDop0I3RC5nlo5XUBu8V04jp9btFNETrqMaKPKkE6AFhQTu4jodUuVbMzneOmC7Y
	tA/igYqnUOZJarTCLqdipr9A6Do6AP4dPWyi6IuyOKO/uTXiRy/FJMCdLMX74jLsQUK9EyHhwNd
	9CMXDkfCXmCZogzBHQ1FC4nHVN5qv1U0bfIV6SPCj27K8abSTjWtf8iotNk5B7iUFjehbQZQ5nB
	qvuwRzEEWFmNxOjBSyz8fl/5av6ulQ==
X-Google-Smtp-Source: AGHT+IHfqup3wRu/YlQwHjftG9hZZW4Odf6KSlTWBL24IqkfpJKbOUgrh1DX0z2m6JH7KpitaUiUxw==
X-Received: by 2002:a05:6512:2810:b0:53d:cf78:f240 with SMTP id 2adb3069b0e04-53e12a2e9bcmr1842991e87.35.1733234290592;
        Tue, 03 Dec 2024 05:58:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496a43sm1829234e87.213.2024.12.03.05.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:58:09 -0800 (PST)
Date: Tue, 3 Dec 2024 15:58:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Alain Volmat <alain.volmat@foss.st.com>, 
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH 07/10] drm/msm/dp: use eld_mutex to protect access to
 connector->eld
Message-ID: <n2zmw4wquxzht6gvlx6yjurpobgwlsryh75n5gw65j5vjclhgr@jqubqjispqsr>
References: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
 <20241201-drm-connector-eld-mutex-v1-7-ba56a6545c03@linaro.org>
 <ca906dc4-ac72-4a76-a670-36c011c853c9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca906dc4-ac72-4a76-a670-36c011c853c9@quicinc.com>

On Mon, Dec 02, 2024 at 07:27:45PM -0800, Abhinav Kumar wrote:
> 
> 
> On 11/30/2024 3:55 PM, Dmitry Baryshkov wrote:
> > Reading access to connector->eld can happen at the same time the
> > drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
> > order to protect connector->eld from concurrent access.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_audio.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Ack to merge through drm-misc?

-- 
With best wishes
Dmitry

