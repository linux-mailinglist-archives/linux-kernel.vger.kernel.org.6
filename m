Return-Path: <linux-kernel+bounces-385021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BEE9B3179
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FAE1F22872
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9F41D7999;
	Mon, 28 Oct 2024 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAcWvNIH"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8593D3B8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121413; cv=none; b=trC1ScZaeHZM4kcw+dxHhiMELUtmcT32JB1OEl8HIApoJHoc8bNxx7ULP87DdEkmphzD2KErXqZvc7/wTUKk5rt4MS1VpwImrORcZY18ltl6bDnvdn05bzV0EqB0mvqf0sVOF2n8jyofzLEdDQ+AzO91bonnKJ3g41AlpSrZ7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121413; c=relaxed/simple;
	bh=0C0Wo5ct399XFUjr122NbaqpXxnWFOgWsl1P9YmGMXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAbScHrFPx0Wn41VSTfzd2cTMHz/3EKjZExX6y5T/BswOeipB6n0X8SKEMzABtCZ6dh3lbDEo3ELhuoQUwUPmtQ8WiWTro/Vzat063mkpCI7lO5xvC1jhnhyG5qU7Z3HKF8DqK15Npo67hlgYNYubFxXP2WPdNr6mfjomPbC8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iAcWvNIH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539d9fffea1so4024684e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730121409; x=1730726209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtobrLJI21CIw0CQaIBjUtswNFQMA8ivfTR8OvOha2E=;
        b=iAcWvNIHGur9S2BhFGn2Hgqxbmj5VLUrz+abwJdtyB3M6E2EM8pXnnNymoPw1FlYel
         xzGR4qPN/vLlCM1JKwGS8359vww1uNpGL0e3Ye5RWSU7M/0tc3lz8of2lX+cwoDrSIGH
         vhNwkEY9GNtc+Y4ybVusNDAgK4L9w4FfWw9XueUHVnVSJKqcQiN40W//xmeDryPusAoB
         1sXvCMevSlwY7zphYC1tzW2mLWbcW5YHr61X7syZbchhDzoXq2LtJTW0JAFaj2bilOt/
         83FQut+SvzI+lmkETCUWrjSRGbS6dvAL0RklnzipuELjMzmeIbbGZgx5cc1KI8VNoaBy
         8y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730121409; x=1730726209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtobrLJI21CIw0CQaIBjUtswNFQMA8ivfTR8OvOha2E=;
        b=Hf4Ggmnrma68oGDXM8hdnvxnoGTbOpjs0Ak/uz/7BfE1gThXRUu4Kj9/s3T2ydi1TX
         lTB8GqEhfpX/RY9K8aRte/nqZAiaQEvChDbw0ozyMLo63RgQM9TtJzczeHkRO94ofqaH
         aYTR3AtS7DBgGjBprp0kQpTGsftsUIaQAb8NbAUh0h8qOgTGs2SABocJTvLFT1O7n5xo
         6YO8mBIEwt0wKfo8CrfsKKvH9Y7i6q2PIAzBr/2hjlrdZC3pJcTLaHcpjwOw8pDGC5Xp
         konvft5NGgEPmu1qRjtZgymxJB6Ohfk9FKm8xk3iTjwWYZJgn4Wi3jwuPkxn2ORmiXSg
         egRA==
X-Forwarded-Encrypted: i=1; AJvYcCWQa6COmbkf+25I6+NzRFY/e8SrBd3npY76/mxLYAZRjU+YyJmA0VrTsYsZgFpqiNyDh48rl4h7lnO6Pz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUR/G6yjkGqPaVylo33QZltjXO0Ehw6kYZeKLsUb2W1YzHQ17J
	0x/8No4EaohkYzx+gwW4moisc8tgm9JCY0QusOdf3MkITDNLoXXOpeS+MJQesik/dDSLWw1UiyM
	L
X-Google-Smtp-Source: AGHT+IHUNBHxjqIdM2evfdxWlB6K7EhIuKApdX43cL7f8/EvgbXJUln26Is5MhMAv5uHt75hRoTpwg==
X-Received: by 2002:a05:6512:1304:b0:53b:1f77:e95e with SMTP id 2adb3069b0e04-53b34c5f595mr3085572e87.44.1730121408720;
        Mon, 28 Oct 2024 06:16:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1fc7cesm1082258e87.309.2024.10.28.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:16:47 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:16:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux@treblig.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/sysfs: Remove unused
 drm_class_device_(un)register
Message-ID: <7monlmdi5ftqudna6kxjgejdejo22ttnontexv6ijpuqecemcr@3t7pbhxcyzrx>
References: <20241022232934.238124-1-linux@treblig.org>
 <20241022232934.238124-3-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022232934.238124-3-linux@treblig.org>

On Wed, Oct 23, 2024 at 12:29:31AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> drm_class_device_register() and drm_class_device_unregister() have been
> unused since
> commit ed89fff97382 ("drm/ttm: drop sysfs directory")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/drm_sysfs.c | 32 --------------------------------
>  include/drm/drm_sysfs.h     |  4 ----
>  2 files changed, 36 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

