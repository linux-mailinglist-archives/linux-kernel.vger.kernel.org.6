Return-Path: <linux-kernel+bounces-217092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20690AA70
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C143C28D86C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C7194094;
	Mon, 17 Jun 2024 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0Zwaq66"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AA188CD0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618246; cv=none; b=D0S1D7vyZx5VFWXAGR9C7/q5RxCXb+ky1KaTfzgGUasuwn3sq/BVmDKAcuAruO+oA9W08i3Lj6JaMGyqDlsz6V5gv+3ZQIq4gbVrot7Okdc+6EENuVv6V+Bthk+zOm0B6zf8SOk0n446DALm1PLVNkkTudeg6ugFWClq+3lIsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618246; c=relaxed/simple;
	bh=NaMgEtEXjnyBoZGtC0yFboDbzlMwOw8XnvW1azukAsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyZTVMIVChfLQDE2IO2oi+uRkbu0146iQre56BsV718pwCQ3JI2Lm1seQEibnHIIv8kMQxA4wdCKyB0HIjXgW1KPO1s1E6m0z5PbdHzVW4ccxjUYEmF02B2XIzp/JqjygJD0V63GCdSec0BVanh/NHAYIaZsA0GeuSuBsnODg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x0Zwaq66; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c819f6146so5764588e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718618243; x=1719223043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAu3yut6C33w0f3QgUUkKHsVifCYw6coodnkymy99jw=;
        b=x0Zwaq66Nto5FusLFCPMi7VnGybz9WPc5uoJ0MWlsSLiXXpUGdfBbsJgmqo7VHd3dt
         LOxYnhACnSs3iTcAZfTJ40Tmd2WyOWHZyqGkbRBAkZBHAiuo33sC1UdHSkkj01i+18d7
         s1CWU/gf+A/q3Vsp4L1IBz5QpgqSr3q3cvT82owmBvTMmchMln3AYCpFirWB0e8J7psy
         8OUkF1ZAOQ9FmyzsY0hR/EHEdpLQ0Fm/W/zs/2yo85DQgLyM22g2PhNq9STMuoopihIv
         bf4KeIzKWZye05pQ475EarLUlgukCromltRenbri+RlFLonOkhJNPytdMzKBRFgsFhYk
         hNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718618243; x=1719223043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAu3yut6C33w0f3QgUUkKHsVifCYw6coodnkymy99jw=;
        b=c4K898t+ZOBRfT55AfCh2Qf2fC+ElDOAXOhFK2lDhhdSrxpSuF7i4f4TyGzuVo45XS
         MhCOjuQQY+gcjfabk3qAA2eqQ6qvDet+XLZ882VtqykF3dOeOCr/jgvooMjHzC5yEgnu
         rSzZAQpt1TWyILGtatXnFDjQtuHZgT5e/YW68ZcnyrC6GGCT+8Ioxyxz5kNqRE3HEqa+
         JnFRjpei+iWe+NT/N2w2Sj16jLRmlWomvJrzOjUDTX24ceLG4NDRWSeNIBKrnUkFXSNa
         rKU69YSKMqWVIrTDT65QJJ75EWPvNUah83+5K56AfWuGHGXHIHRHrwGBB0p52Lk1hBI8
         BpqA==
X-Forwarded-Encrypted: i=1; AJvYcCWM7rL61UJY97cMeil6v0hHVJ1NjoKKHYphENqYyJq+V8v29XUIgcHHFvQ+dEmgS6291FKWGG9y9A4jYiAY/UIfJC8t/1b1Esuzr0Nh
X-Gm-Message-State: AOJu0Ywils+IqlsqZL0ff7AMtEWAhsxPQ1SjFQhC57F+bjp71bRi9kBv
	fo2DFLsssfViu+aDy/XJjTO8DdtZjiAcJ2CiN9/u9VYxSxLUEk83cfwh2YnLRtg=
X-Google-Smtp-Source: AGHT+IGd0lubX4e/KngoOZFs4XUo7XaV0srvqIlzUax7XiFNyo+YBY3jricMn+yHE/eYu10R++2NAQ==
X-Received: by 2002:a05:6512:2350:b0:52c:a1ad:18bd with SMTP id 2adb3069b0e04-52ca6e54ceamr8567114e87.6.1718618241899;
        Mon, 17 Jun 2024 02:57:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2887effsm1197140e87.257.2024.06.17.02.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:57:21 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:57:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] drm/display: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <xd2yybtxvzte7gwqwg2vudzvhoekqao2dle6zsuduzjzi3rsay@xhahwof2prph>
References: <20240617103018.515f0bf1@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617103018.515f0bf1@endymion.delvare>

On Mon, Jun 17, 2024 at 10:30:30AM GMT, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.

The goal of this clause is to allow build-testing the driver with OF
being disabled (meaning that some of OF functions are stubbed and some
might disappear). I don't see how user-selectable OF provides the same
result.

> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
> Already sent on: 2022-11-21, 2023-01-27, 2023-12-02
> 
> This is one of the only 3 remaining occurrences of this deprecated
> construct.
> 
> Who can pick this patch and get it upstream?
> 
>  drivers/gpu/drm/display/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-6.6.orig/drivers/gpu/drm/display/Kconfig
> +++ linux-6.6/drivers/gpu/drm/display/Kconfig
> @@ -3,7 +3,7 @@
>  config DRM_DP_AUX_BUS
>  	tristate
>  	depends on DRM
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  
>  config DRM_DISPLAY_HELPER
>  	tristate
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support

-- 
With best wishes
Dmitry

