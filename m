Return-Path: <linux-kernel+bounces-284841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2779505BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283FB1F261CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDCD19B5BB;
	Tue, 13 Aug 2024 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLPXPxtq"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56319ADA8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553827; cv=none; b=IQnUga1tcpUU/HRoIbjPRJa5UX5zQAQNqEBsM45t/aYjIxRTDKGGSNbbEpg+YgVjdCL872O6vmWves6FKe4ejx6Gkq9Co6+JT+Ho605JpjLlMBuP8cv+iHH9g4Um8GccWxcjCU7R70NpxLw3ZTLm4mz7utNdVW79N6Qvyr5ekMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553827; c=relaxed/simple;
	bh=/IucKzJr1pjGm8UzlqVDbC6DYKSJ1VXL16illXAKyr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPUOarynrYJ05KecPDUVOmbrWxVfKqRZoAnWhLN5Dc66DHitnteTytNEEiwN8/sCLhjxj/F9SdYHCWVmkRbITHSrG2CXzj/grKNXrWAlz653UHdZm1QfzZ4Rj6b+Du9U9aaStl19ho7Y6sxj/hRH+W6yDlf5kcZcHgPdWF32Bdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fLPXPxtq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f025b94e07so64404671fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723553824; x=1724158624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfkyu+ccADY0k0FfxuRa1b4o2Bw2fvhvcVBZ4pCO39I=;
        b=fLPXPxtqnUU3Dudw0K3vp8Kfht6m2bvl6vGRbd+T7Yq4Gq2HNvKK/qnD+KUFMKLkyj
         1G4sS4uv1TO0Xm41aQctmBPWMDd7LAwzs56qTg6Jam1jVpdrHT1hIB7pKrh7SS270mR8
         Du6jw5Ukdk5K2kadfUD4fdDIjSucACHAZBMxSFPlyANYwY+9f9C0wNOs8+FMBG4JxICa
         uH/kucUPE/KtnIiLkE13BzzhL9qF2HF3lcz1WVLMUPKoZlXHl9XZbP0wo22jpuqVAurR
         vCRVPmIDfwRjhZ2wU5N8ddW0mivWNA46hwywsjA6y2teQCUecdlHJvw3MyuplAhfjqB0
         4XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723553824; x=1724158624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfkyu+ccADY0k0FfxuRa1b4o2Bw2fvhvcVBZ4pCO39I=;
        b=xF8fprHHnTE2NactFdqGZdH3PRsyNK2o3iEnHIwgeN2A3qgo3PZOE+oh2Rnp38ScMi
         34gjmvkscFtb/wZtOQtJorBir9NMx6/MBtrVxrqHP33fyKwH18kUenfInV3UJIyh1Pj8
         fUnc0qPh2ucTH6stElmnGAe7WJjkwm/B0nP6Q8z8KK2+zASuF9oc2JCjLSrwGUvfiuOj
         6sXIQlVYp+RIveEF/rrwAHFGudqq764isJPcvstdYjv0/8Eo4mfn7DC9p+XIqSIRqTMg
         TwURz9a3rHczRtdsTBf2bAO6rOxaPx8E10vrGjFuM2RM2hmQDFPAR9fu3aIjA5zakXFg
         f0ww==
X-Forwarded-Encrypted: i=1; AJvYcCVXPSD8mRcYhM/PSNAxynsWG5B/yz5PGfKi5Uy1QjUWd4YquiUUphVRBBT5rlCTAeQ0rrMvAGUa8TqT9Qh47gku0YHGudwYSG9JM9CY
X-Gm-Message-State: AOJu0YwlNb1Uslft80A44jRzeRPi54NrTxtAhhLKF7h4/SpbNKGJxdGs
	GWchxRcNeacJIjEWkN3TFE1ePviDryXaTMzfZo5XgFCev6LIItZcZpLmZoZrMBQ=
X-Google-Smtp-Source: AGHT+IF8eG+A/qDyy+QvlE7p4WfVNrboSKHMAxVYe01bthgvvA+JzP9CUdv9MtoWOah02cUOZUIUwQ==
X-Received: by 2002:a05:651c:b29:b0:2ef:2281:2158 with SMTP id 38308e7fff4ca-2f2b7132d7dmr27774751fa.1.1723553824007;
        Tue, 13 Aug 2024 05:57:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f47b26sm68417366b.41.2024.08.13.05.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:57:03 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:56:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] media: i2c: s5c73m3: Move clk_prepare to its own
 function
Message-ID: <5282172f-f8b4-4706-af30-f5bf9a2a3f8a@stanley.mountain>
References: <20240813-smatch-clock-v1-0-664c84295b1c@chromium.org>
 <20240813-smatch-clock-v1-3-664c84295b1c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-smatch-clock-v1-3-664c84295b1c@chromium.org>

On Tue, Aug 13, 2024 at 12:13:50PM +0000, Ricardo Ribalda wrote:
> Smatch is very confused by a clk_prepare_enable() being called in an
> error-path. Fix this warning by moving the clk_prepare_enable() to its
> own function.
> 
> drivers/media/i2c/s5c73m3/s5c73m3-core.c:1425 __s5c73m3_power_off() warn: 'state->clock' from clk_prepare_enable() not released on lines: 1425.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---

To be honest, maybe I should remove the clk_prepare_enable/disable() from the
check_unwind.c.  Or at least move them into their own check so that I can
tweak this kind of thing more easily.

regards,
dan carpenter


