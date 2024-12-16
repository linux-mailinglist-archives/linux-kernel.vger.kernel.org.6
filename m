Return-Path: <linux-kernel+bounces-448293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6249F3E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBAE188A2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E481D9346;
	Mon, 16 Dec 2024 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kgb1gymn"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA4C1D5178
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391595; cv=none; b=HP9qfTndgp+KmzlmCJkV1KafzCaQDP4nvBGsYtj/XnFSqJtBIREkTkFD4o3oUfD1FTZYHu1Msy9Qq12PaM8Oyl/CvTCc3Z0ZMqZXc97ObyybEZfTGjYFzWjzyI1Mrm41STZD9RuZRE5XRAz0BE2PIrzZGzEVf+XT5+QoGsET64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391595; c=relaxed/simple;
	bh=Bz72pufGL0tkgJAeN9WvIrOjhkF9kFJ+hIN24aXg7Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9JmomJOgHvJrFRLjGpeqLC0MREhc47JGND+mQ6v+4ZVsy76XUfN1Gmsk5Gt+5UQwYCmTr3b2tlON6b37uPBCMjMz/eSUAC76U1aHv+hhbDr34tyqJ/r1UHQ7Z6CqPMc6vcn5Z1uk9QwqMYYGqpuSmpbGQONcR7sp9vRDKuDuyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kgb1gymn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df6322ea7so6460120e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734391592; x=1734996392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ga5plnRRD21rZgiC5DgyaFqBZPJrKxo5KG3LNUuDhLk=;
        b=Kgb1gymn7TU9HjaHZfD9af7Y921AA8XHrNbPX3+P7QMP4QuQWF0IRb1fTYIHgTCkxS
         2iZyl+fNdyW/A7Yv2bmUwmSneLs0CLHVTFRBUhnd8gNV3PIuZ1Ldr+0BldIGx2FUbp8q
         P/E1kdD25111qJV2GAtYFgu6q+dFdsTxPsQorJhtlOkFjJuWjMwfSG4Ae14EQ01n4c+W
         M18H2Ih4+qKIjnFPlkWWYdN+1lOkcCOMo38BP4ELXadN/0PJ1KwsAGpoISToddjwWbWO
         hFGnbiQkFBZUiLCoUGo06H6mprIMdDrs42NEEemy3gwm+ftrUunw0M95HFWWagF97RVq
         X+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391592; x=1734996392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ga5plnRRD21rZgiC5DgyaFqBZPJrKxo5KG3LNUuDhLk=;
        b=ShRpC0MIPuEE9bKmf4qlOhGRO1/S1szh034WpHCSrQQ4Yp6ZcrFpv7hSLWMY7k/UXz
         jTAll2cN1N9kj1u/ktPHVrJYdQ+3w+AbLPd0agmOG/wJrQruGsfiAhoghAGUIQ3J8UgB
         CSeFQe1/o042d+ef6AC0qmwAqmbTIiU6vSXlPuxPGy+ZzfW5YNixxRhhFSassRgZnwpe
         yHAJ0SrEIf+r6PStY39/dn0yII9baPPaOHHJHC+QI9LoanvWx+rqU19NrFQxpNSrAJcF
         FiY/PGfWkRnsceDrjAlin30bYZvhqxPF2QEvARJNizKAXArpSlE53sS1MlwYDxxQ2oj6
         do/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwFWfc9bn7ykO0hchk823kocqcAXkQrYsPejFdxOvT9AHxp5lbUJ4trUmkWMkSgjF/YEFXh23+ZsrSgq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnmhartO9oa1ud0Z3ovJzhQp04ythoZTcEyBqRB4aQseOHsdp
	sK6GtwFchEFmTjkAnEo8FJSlG+mrHgJiJGyXWmqSdSojTtmaJvO2vp+IuFsrGls=
X-Gm-Gg: ASbGncvmXh50euathOdAqF4GMNMTDk/BEInzy3PjIdGFSdJ768zp0GF9NAvLFOXDNQX
	AnFKSlt/9QqZgsZPlnAski04yMxiTGLAysslk1bekL5natHPCklBDkgiQvJbZPEUITfvHRcm0LS
	A/2nVq511WVItQfrnqAUl2ZZn+C4nH1TXjMNW0IwDslCby8lmeRLr9Hr161K2pufUI24kbu1mCE
	R7kph6zp1yh0gorg7il1IWIcAo8meLhhsTAvg42iPdI/pOqgjxe9zBmZaU/EC0hyCmY7t28ZKHa
	G4/QE5rwaWqmQvkGZuzMfB+4fQIjH2bhGuVK
X-Google-Smtp-Source: AGHT+IGJqsn7bXTR3lEoGpFZPPm/vHrxJicdtdEx5gqHp7xCDLE0cMihc/n6szg+zYkNGeZh6CjlYg==
X-Received: by 2002:a05:6512:3049:b0:540:1b41:c75f with SMTP id 2adb3069b0e04-5409054bf54mr5448476e87.16.1734391591836;
        Mon, 16 Dec 2024 15:26:31 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13c97sm985014e87.215.2024.12.16.15.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:26:30 -0800 (PST)
Date: Tue, 17 Dec 2024 01:26:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/connector: hdmi: Validate supported_formats
 matches ycbcr_420_allowed
Message-ID: <3djtdbyy3ndeb5cg4ndlelsnhxcd3jcve5pydvmvsjqp5yfxnr@6lkglusanztr>
References: <20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com>
 <20241217-bridge-conn-fmt-prio-v3-2-3ecb3c8fc06f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-bridge-conn-fmt-prio-v3-2-3ecb3c8fc06f@collabora.com>

On Tue, Dec 17, 2024 at 12:54:08AM +0200, Cristian Ciocaltea wrote:
> Ensure HDMI connector initialization fails when the presence of
> HDMI_COLORSPACE_YUV420 in the given supported_formats bitmask doesn't
> match the value of drm_connector->ycbcr_420_allowed.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

