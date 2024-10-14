Return-Path: <linux-kernel+bounces-363380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7895999C18C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D200282A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A10F14B075;
	Mon, 14 Oct 2024 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BP3EQp+L"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ABE14C59C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891536; cv=none; b=pCyuK+1kvLTWnydyiLY149omRsjXAAYv27qtBtVIAtIzEUmNvyYcuXwlzKAeG3j8mfrwXvt78VewvW4x/u6VcqyngAoz0oalfyI1hWCgQWoAjf8auvXcHJ4fLsjIAtDdm4hTKuxmYuz8zrnmYi/VaqZlEXfSL08hUye2fxirYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891536; c=relaxed/simple;
	bh=YcicH1ItN6kLVKM7/Tm3x62viWefn0sozbyVtQZ2cJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWwx4zJDvIMF+jAwGOMp26LGX/Q/+gginqIdum7JiACpyGKVQDQJU7oyX+7YXYJyYdOGlJK3n0thaKESzklyl2rhZrLkWcciDNnK34l7aVsbvbypTmHakUqRRiSkOy9m7ZFtISWhHYTkm7AlihuMEwN/QYYU46h7mUP+BSn6IR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BP3EQp+L; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f84907caso555595e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728891533; x=1729496333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk4QxLNEwsyzZXP0YPS09TQSucKgCrUhh8MMP3HebVA=;
        b=BP3EQp+L3kPJUWKHUZFQnFYkz36qVVVDYd6vxFEi08+HKakMOsm+SVTpPx/nMKknb7
         XYG4nuOQ0s1r5TDTHyxpZjqZ1Rs+EM7x9wBvol8GYf6j2uo74VhoXordqyUAHUCiCtQa
         YCQVqJz0iWzfTXtZD+0Z29rex14dKHQlS75fgtF1OzRLjopoldO7BMWPTqDhFiJXxboi
         khJxZmQaRXbygezOkVV0jxCyg1AcslGtd5zl7X0ajXj/FAob+N693b+iFnRBNjrNCcqH
         YCMDZ2yLfrDz0h+mXQPahMgqIyWLQb3Pl5zHjvPLRB8W35WrSBcqZZM4pj9eriN1sMWj
         lDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891533; x=1729496333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk4QxLNEwsyzZXP0YPS09TQSucKgCrUhh8MMP3HebVA=;
        b=WVugA6S303Hxxv2xEQ1DogNK9Whl9FqTWZXl9xq8UmWiuw1tAe5GZ8ShHHP6wjgvyn
         iEgL7+r+gM5HeYU0K5l2cwy87WONcKaUtfjph/FN50RlrL6FT9C5TmB+/olYmy+xSS2u
         ihSIGdYxy41MhNXnN3kAuxCcvqmiSCbudlSzF3AKMKpMR7HqJxfoJtkjAOeZe0OxVxIP
         0fkmcZydM5Xh8DKXnoPwAPD3amuewsKOGXuOwEsxmbkErp9h9gkhhWxcDXTQOHtX6Nis
         yE2urvzzvROX/UxsB+w9UZqAnQyQeOgPbiq1CpMTWIOSdhdW+gaCV1ITo5DkEyfzQhw5
         4vxg==
X-Forwarded-Encrypted: i=1; AJvYcCWgn2Br29ffVe5lA2NJUt0bwUqiHP/gQ9SXN1CGPWcGfFcDkR4A3L3h70ZK+LFNHEiUWvTp5lYemtHdQbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3jCMEbgm+ND399AqU7VNajaYNeCFYyHkZLFf60aXQZCBxxdD
	zscynmhBAERnZY8XMErMiRNsN0ncUqPZLfTXxjTspPSYiuwfK+K/VTXZ2jwNdyk=
X-Google-Smtp-Source: AGHT+IGNuE7vrBBXDi1MiauEpNLyh+kIr9HGY+e68HLWEmc/QK6X0iLQvyhPZqFQLW8amaU8CG2fyg==
X-Received: by 2002:a05:6512:baa:b0:539:e94d:b490 with SMTP id 2adb3069b0e04-539e94dbcd1mr1984693e87.43.1728891532559;
        Mon, 14 Oct 2024 00:38:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539eb3416a4sm667052e87.278.2024.10.14.00.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:38:52 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:38:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, 
	Boris Brezillon <bbrezillon@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, kernel test robot <lkp@intel.com>, 
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] drm/atmel_hlcdc: Fix uninitialized variable
Message-ID: <rr7pp6a77tmur62vu2xdpasokokta7g6kcgjcd4iydmzyqpd5e@z45genf4gsv3>
References: <20241007150904.9840-1-advaitdhamorikar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007150904.9840-1-advaitdhamorikar@gmail.com>

On Mon, Oct 07, 2024 at 08:39:04PM +0530, Advait Dhamorikar wrote:
> atmel_hlcdc_plane_update_buffers: may use an uninitialized
> sr variable when the if condition remains unsatisfied.
> The variable may contain an arbitrary value left from earlier computations.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202409240320.MZPgi3Up-lkp@intel.com/
> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>

Fixes: d498771b0b83 ("drm: atmel_hlcdc: Add support for XLCDC using IP specific driver ops")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

