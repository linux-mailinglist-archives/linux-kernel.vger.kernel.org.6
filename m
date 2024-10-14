Return-Path: <linux-kernel+bounces-363445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E69D99C292
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66F8283D04
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB5147C98;
	Mon, 14 Oct 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHIC8ZgO"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D7374D1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893311; cv=none; b=G1v9HjZj74YUK9tjLOI1Xe2bEDEo+fS7VRvweCtKz6DsVNeV/hJS+lJ2+kUTcvre33H51fM3iptSytMf9bvPk6G+2nQ2ROxGfK5KgkgF9ehscz2hBB+CigT8vKRfqulKxT3VHfZqDShbzaGFC+LfVtBQiQmUEPnEXrQMuyyMJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893311; c=relaxed/simple;
	bh=WlD0hfDYA25rGbuegu2Iv5ECfpluVwqT0X81/GHom90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjQp8G38NpX4TWnRAnxTpBw80sMmfqHUr5mzXLZXNxfRs9yMmuPV3d02hXZIqBouTb8xINdxCCSg9JcvsiBakauCt4cqWWq2OZfgUgpdCaxirAAyzttYTSWSLjmkeh4ksfBQGdDSDfkFO6tuQmb1l51lA4sXPPRBMKOTA9HxB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nHIC8ZgO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e1543ab8so3479106e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728893308; x=1729498108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ek0HXgVJ4lRKUDparv2Fn/Dq7h99tILCL07wJuqwxgc=;
        b=nHIC8ZgOp5h7QxtCbo0JEDLkgLnqQ1pCxrphJj/dBloHtHGRJfelMZc94F6HC7+Z9C
         YNANr2uOMsyVrDUMYD4koju5JEO9//Gselg6aUDdRil61I/+ff0qyPy4pjZGikDmCHwH
         9sp6mz79dmKrMI6gDi6YXoTz5unl0t4DOsnsQyGpmMgEF//GmcFcjDLtNSR4UVm/8/c2
         cmarNRPUMDT6xJhibzrwjde5TwArC8Dmn9EYphFicW2MI6Yu0WhzJF22SOnRSVPZAPgx
         IXm3qfxrKTp6w80HthzkgyeFjErz5RIPZdxTriFrULAtocmQQrSgV8NtU2eSRuWAsZS9
         d3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893308; x=1729498108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek0HXgVJ4lRKUDparv2Fn/Dq7h99tILCL07wJuqwxgc=;
        b=whSKoxA2QRfs0F6bQHm9mk/KOcASbzcUBU0hbIjG4HDRimRalZIh3VdrI5Kc65ZVW5
         FyG76Njf0rmFBM9C3IG/QeBc5ewll1vx3JJAXOUSYPwmuEmlaTM0B0Hm+8xvplt08e2U
         UhkhDISCChBO2xAiX/VOReLa8Sy/XdPACl46tIyVFDWuc5lzCc9WjqsZuKzEwnSNZ3s3
         Aio6jZiIpiEyQh7//Rk+6XT3vJe+WfdqO69nIk/XCOHrzplDRSzEcyjB/tH1fkHXk3L2
         cfI6c68q7BLfw0UD/gtmL/f0DRzB4OlMSrDE2r6F9dd/1ndkl17bQZP/To2tiLqOmHzA
         9Mjw==
X-Forwarded-Encrypted: i=1; AJvYcCWOajHikcwbbhxmsHpdncXba/rpOY0PJuW9zOUFK07Ming1pcdbiefhlRE50UniOVswJeRstORIeMZDYo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIssSoLiMGalB0iHz2wJa4ivhKJFx2ulTx26evSHbzOqyBeBlw
	L0Wcrjc4ehK/pWTWpcP8Nhw8STHGSmISPoNe4i4LPn7cLwHIAbbl4zRarb7/lcE=
X-Google-Smtp-Source: AGHT+IFpFvXZahYY/UpYBX+J7gf2zLmfnqUfbFEK4OpIA/RZWgJpkF79yAmXBTPYrW3Wtz6MqCpslw==
X-Received: by 2002:a05:6512:3402:b0:533:4505:5b2a with SMTP id 2adb3069b0e04-539e5515238mr3224426e87.28.1728893308189;
        Mon, 14 Oct 2024 01:08:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539f2d2d05dsm453157e87.98.2024.10.14.01.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:08:26 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:08:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raymond Jay Golo <rjgolo@gmail.com>
Cc: dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for Chuwi Hi10x
Message-ID: <xc66pugymub6b2fjal4q7lopq3t3yaporkclaj5fslf57u3v4w@tnxsmybjujg6>
References: <20241007020258.2202786-1-rjgolo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007020258.2202786-1-rjgolo@gmail.com>

On Mon, Oct 07, 2024 at 10:02:23AM +0800, Raymond Jay Golo wrote:
> The Chuwi Hi10x uses a panel which has been mounted
> 90 degrees rotated. Add a quirk for this.
> 
> Signed-off-by: Raymond Jay Golo <rjgolo@gmail.com>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

