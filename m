Return-Path: <linux-kernel+bounces-182955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B630C8C9233
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EE5281DAF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A877F62171;
	Sat, 18 May 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YOCpMiKG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5E160DCF
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716063719; cv=none; b=cO5b3jeSSZnsquR3G9NIWVgB6WmL6l9wUf+JuRfzQX26UQMa096xXo8mKhmy0AUCwmcf5wd5hklzHdURU7TDv/zfbIdhu+A97XeqiDMmBru7BRlxlCHBGQLn9ZcomGFFBxba0CfPREUvC6vwmF6psgQ+n3z7P+YCtW7YceLFQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716063719; c=relaxed/simple;
	bh=TIqCDYP/WZC+8WCV9T+fsdqDELqSHjVL9UHHO59Pw7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuo4IYVDlZeYaNgiDgKF+T7Iy15fQAyAO3glhxUCVO8ure5uZVfZqSgm+cQnZb6Oh//mef4XPftK8qzj6bYO7/fH1PTrmhzpS4o/N4gbhMPnkRwKWmeouDUVYvwUC4jrxcdT273iryP0GbsyTuSPVnpxxF8H8IwHWaLcQThpXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YOCpMiKG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f2f566a7c7so9630685ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716063718; x=1716668518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YT8k8s66KczJAsNizHEAZ30DCNByiIsnyYkGU9dE27E=;
        b=YOCpMiKGoCagxA9Q/d+T7HVa9JcZI6hSymcYBNgQeJ1hgvDOaKD4ckeCBP9v5krCNZ
         EQ4IIAkZadRIgoKxxIdFsYCFcf5SC2OI0NhoC5SpZsNYgsk6TjeFFFRmmeBNfOLnnNeq
         4GHfKNue0RDwNI8mXRxWNaZ0NxgHxL3pnPID8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716063718; x=1716668518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT8k8s66KczJAsNizHEAZ30DCNByiIsnyYkGU9dE27E=;
        b=W9bXS3+IpZhIkqWvtwmWri9mrDYJAYePlG6H/3QH/sg9OuhvamJZ25y2lHIVf+N0CE
         PLGPdyuV83jj7EhHBEA1w2aFfLcjxMI4rFA1j0r7apOk2MlZKzU7OVuDmBlj+t7CZWEV
         fnZinyEmloRzMZytG13CIXLJEdCtG6h5nSTbsf4ref8DSGRsJy7bzoGxRseYNEQRpOgs
         oBHILwI3Le6Agdd02Yzah6tY9U3u0cs6VyjGA8PtpixtZSIjuONDn3eUE+Q+vTvOxtf3
         5z2OFhi0OdP1O17RWRP0ka+k54VRwSf5YgUxVV8iYm+7VnobORKW0lIvcTBCbJGE8kMD
         6LfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVagmfu08AneEKoXzStP4wPJoZ3ir0i66aplfHF7RFEcYKVhjSvIbIsdPEmbxwqJh0vxTbTsAfELzRYH80cpw4iA0//DzvkyGPm96Uk
X-Gm-Message-State: AOJu0YxADZ4burVnEDm88mXOW5IrHUWgmhlw/4WGXoTyqG+G7awghU+5
	aZ/woDKgDgi/M12J6QI+p6Rni1IBg8Jp/Zz+jE2GTDb12V3BiuNHXeTkS3ZT9g==
X-Google-Smtp-Source: AGHT+IFRGo/TZiGmDwrA4Giz9YhglZ2J52uHVSyaj/8zAhYj57i0W4kcw475tSgmL53i3sy/nIfz7g==
X-Received: by 2002:a17:902:f705:b0:1ee:b47e:7085 with SMTP id d9443c01a7336-1ef43c0c957mr310157785ad.12.1716063717708;
        Sat, 18 May 2024 13:21:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad61c7sm177715425ad.68.2024.05.18.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:21:56 -0700 (PDT)
Date: Sat, 18 May 2024 13:21:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Danilo Krummrich <dakr@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] drm/nouveau/nvif: Avoid build error due to potential
 integer overflows
Message-ID: <202405181321.BE7CB28587@keescook>
References: <20240518182923.1217111-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518182923.1217111-1-linux@roeck-us.net>

On Sat, May 18, 2024 at 11:29:23AM -0700, Guenter Roeck wrote:
> Trying to build parisc:allmodconfig with gcc 12.x or later results
> in the following build error.
> 
> drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_mthd':
> drivers/gpu/drm/nouveau/nvif/object.c:161:9: error:
> 	'memcpy' accessing 4294967264 or more bytes at offsets 0 and 32 overlaps 6442450881 bytes at offset -2147483617 [-Werror=restrict]
>   161 |         memcpy(data, args->mthd.data, size);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_ctor':
> drivers/gpu/drm/nouveau/nvif/object.c:298:17: error:
> 	'memcpy' accessing 4294967240 or more bytes at offsets 0 and 56 overlaps 6442450833 bytes at offset -2147483593 [-Werror=restrict]
>   298 |                 memcpy(data, args->new.data, size);
> 
> gcc assumes that 'sizeof(*args) + size' can overflow, which would result
> in the problem.
> 
> The problem is not new, only it is now no longer a warning but an error
> since W=1 has been enabled for the drm subsystem and since Werror is
> enabled for test builds.
> 
> Rearrange arithmetic and use check_add_overflow() for validating the
> allocation size to avoid the overflow.
> 
> Fixes: a61ddb4393ad ("drm: enable (most) W=1 warnings by default across the subsystem")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Danilo Krummrich <dakr@redhat.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Yeah, looks good to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

