Return-Path: <linux-kernel+bounces-184193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ABA8CA3C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48F1282373
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04791386D5;
	Mon, 20 May 2024 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtupTbvn"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B967134DE
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716240021; cv=none; b=q1oOG+e0mTnLfLTUDVq3JW9RAaoTTbUOwwHllNWn2XE0+8sL/j2+8t/ugfd6pZFAQBK9QUZlCKd0rilhsm7XJokU95vg4s2VgBhi/X5h0r+aK66vfAiCG3EnLpQVgMiGH9+LKuZtrTh8DHyHlBk5y1FpIV5UTEnJbmt70S4+sKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716240021; c=relaxed/simple;
	bh=jhxUnGL3QU1SZuJg8Xn4Pn1yP1t2jyCGzNetH2sp5t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSKiIMwaHIBYC5OiiR47JQ+UVquUVhdqgbYEvgI+Dx/CzB/Rp8n7EmWs0nA2oFve3mSoF3ezV5T9HyJgk2adRYFnOxs28ziKc5AtN5FveQc6Oa4Jah3wcf5cAUyejjeke6L1xgKJUHMhYnz5UB03G03pW13z5xP1jC1bJgreFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtupTbvn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f0b6b682fso5105897e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716240018; x=1716844818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OnVUqe8WIOEFDqCc+0DCZdCPjLUoGnkXveHx6yIHnM=;
        b=DtupTbvncf8moDU1bbJm6HRwdQNMDMsOsJaemkVjRnSAtMY+pUPKIN8WqVn7iV2UnY
         Q8S9o3TqclvgplkN/8PodbNUfuqMnUqntL+bkt0MVTYQ1e37KpDULuw450nV93AHlMjE
         1p86kL6Np6s/RXwGNcHkHriUkm2oPbR+Zh9ElJdNeQZLKcC2O9G6bdG0eFFfrGWbFh22
         X4KNYSCZ4GWpmxjthvkpOBf+KfUyi52LOI8nhT2H1/vZg3+4RYgmg7C2+ec0oHPuQH41
         mrJflRAOV7T19l93LtcaOtUzZZDKc0LHr7kQph97jTTmSBE3u64eU9i3pQB83GeKfCJs
         i60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716240018; x=1716844818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OnVUqe8WIOEFDqCc+0DCZdCPjLUoGnkXveHx6yIHnM=;
        b=qYgK/5cYMtYD4POM5VFhApjo9JyVeUYszJFFWqv4EBADw2+gppTvzxOdoCIgZyGfvj
         vxFNmBOcIxwbaHZl/pZm2xBNZ314PYzSa9cTAIfOKBaJjVJaLHCpMv+DLDInYeBmiV9Z
         K+6QqG4Kaf9OTl7mJJFz63/FB06/nRO+tTqpOxL4IdNrorEOhNE7HTgxIwLSxhr/OUJX
         1Ihzmp/NNAH821fXuIOY4RjW7FQHse2YFN1yAn0nXpW+nucxEtg2VZSqyW22nQhOwPX+
         QMOxPH1aljT56T178Ed+uz/ydLiQPUGFbYApj0qisIqCHZ0t4sEcEDUXvr+fGnMqC/Vh
         RV8w==
X-Forwarded-Encrypted: i=1; AJvYcCXy4Wkcltd4uEzr0xIeTjGTxBJbjpCoIVUy4dx/jIkXMrRPEsXOEOIseGFCvPDI0bedQ+YmUOda/QxlNqN5LInvkC4+Zfu5VuJpgiz6
X-Gm-Message-State: AOJu0Yy8VGrIEalhDeHg2KpstBeS4P+nanKinvJRUdxjXl2vIw0d1Cvu
	n6TnPGGUTiW6XNHLxqVkfEOTass5jBBIWIGY84gzy1YE8MkvaGbijMgGsHgLs8A=
X-Google-Smtp-Source: AGHT+IH8++U4qMlcx4n1na7YaGa/qdPYn/zbKCk2mmxyuC1CZNaV7VzAUp8FuYGfDxIdDohPt4CTqw==
X-Received: by 2002:a05:6512:3e01:b0:515:d1a6:1b07 with SMTP id 2adb3069b0e04-5220fc7bdc8mr36914963e87.15.1716240017912;
        Mon, 20 May 2024 14:20:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-523765da43dsm2473464e87.121.2024.05.20.14.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 14:20:17 -0700 (PDT)
Date: Tue, 21 May 2024 00:20:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux@treblig.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <g4nwb5cgcg2wff4qogzayhdrj3omneeusfjqmdupghy6zlji5m@kp55dmkbj6k3>
References: <20240520125551.11534-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520125551.11534-1-linux@treblig.org>

On Mon, May 20, 2024 at 01:55:51PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
> has dropped all the users of the struct bridge_init from the
> exynos_dp_core, while retaining unused structure definition.
> Later on the driver was reworked and the definition migrated
> to the analogix_dp driver. Remove unused struct bridge_init definition.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

