Return-Path: <linux-kernel+bounces-371964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D957B9A42AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF3C286060
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD42022C2;
	Fri, 18 Oct 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rK9R5lhj"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C41FF60E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266057; cv=none; b=dJMY2uXeCdE1d5OMEKHMuZAKTUrVofFaox7hw0RyFik0e/sfqkXWlJoE9wQcun8Jozp1DpoX5sFqQ2V6bKG2rXybAtjA6eO73HQY5afSMfidx1OfpxuJP882Lfw040Sv8qvq3U28opJLVZJyiYAK7R2wCulb6Q+vaKEDUwHSNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266057; c=relaxed/simple;
	bh=bR96HRMldtQoV/zai4j//thNLoRr9ug5Ij4WLSTW25U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoy2f8g/jlaUNJIUMhjlM0wpvbNcqSdvfATovfdaWwh6HGEwpTgbtDrBQcq6oVCxtlnt6afLZGsQE/yywpaeSbnLRXADZQ1tN/XaSxaXOXafh7/O1NG1l85FFkofpGeUeLRNvHAUrfWaeK0VluOStkCpmzfCPOtA0z5iJr57moI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rK9R5lhj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so25553281fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729266054; x=1729870854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3bvwu3OzUWCf73MooSLxJMXXTcmaKvPuHjhrRvynjw=;
        b=rK9R5lhj3fr70pVo1whGC+9HgvmmKHe7iu7CjqmKPNTuatVQtXMjOj98nfbpniJUFq
         3++Dfvlt9Mj0ZvgGcGdeZjXusqFJfma4gbsJdNhKReeYwV7BoBodf1+Izm+JPQ8eGM9M
         kZFZSzRj5j6Z+EuOVcZW54VdaPleQrlTAhpuuboCQRShzk1DufJVhbeSXzpeEAYv+cfJ
         6rX97/P7t0o5SxUxTfMK0jGnGe6OxPn8++W9YmnELxr+ACax7knGwWFgOpgfa7lS38rL
         IE/crqOlIbFJgFFEed01t4mgBN13pEqkam3KF0+VmhkAbGwI1RkBERtOY59r7ZOYmNGc
         gbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266054; x=1729870854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3bvwu3OzUWCf73MooSLxJMXXTcmaKvPuHjhrRvynjw=;
        b=RRq1z91O0J6rohH6YRHKnNlPWhmy9MaOpexuvBKIwq36/rQrPxtnuz/iYZIb6jowXF
         Mynr1DTH+RHramJIlSh85vdp8R97BsFA0LAwlBt08fsAVCRJgzV4u17Hgt2S7LPu1XJb
         96rSMQX/ZKGrhhPn4If6G8T/zBjTy07bLOK/LUclabhe0yM0Tb0UnLZPWkp5xF+LmHlV
         a6BeDM5nepqBm305DEVj2Grk9ti4hHSZ3296ZwgAaXlQuxKNgjITXpc0jdeP3Q/FO412
         QFENrQSxSoZdPImvmZaShDpjfJ4hhchE8oVJ0f9G0S8s7PiZSA1e87J5JSVZkU3X+pE/
         TYig==
X-Forwarded-Encrypted: i=1; AJvYcCX1bdsOUnGXxeT6X3HRaHsZ+X8RdaYD8/ZoqXNwj3fQQcgOwsr7Qa4MxMdbrVP/K9yDCqV9C0fuNSRtKEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhRAVJpGb2oCDHlmffTKVOjk3cBnzUJK5SLf1nExLNqVCDfGm
	EydGWidZXc9FqWSV3vOIolib/nUhzJLSjRJ8DqyF+RenRR3lHkRMY0tyE4ja1Ds=
X-Google-Smtp-Source: AGHT+IFNy+IiwoNEkyZ2thYD/crdC0LJwLRi3uLBZU4IijiXr13fyi0mObCfVy8zlYe+NMMkBbwE/Q==
X-Received: by 2002:a2e:7c16:0:b0:2fa:d84a:bd8f with SMTP id 38308e7fff4ca-2fb831e6dfemr12851361fa.30.1729266053851;
        Fri, 18 Oct 2024 08:40:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809a69fesm2479441fa.11.2024.10.18.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:40:52 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:40:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/drm_mode_object: fix typo in kerneldoc
Message-ID: <exqgw35skr7mdllf47k7dejcex3lh23kx5jh3vv6ln3m22nlig@zbefnqjlohsr>
References: <20241018-drm-small-improvements-v1-0-cc316e1a98c9@bootlin.com>
 <20241018-drm-small-improvements-v1-1-cc316e1a98c9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-drm-small-improvements-v1-1-cc316e1a98c9@bootlin.com>

On Fri, Oct 18, 2024 at 05:26:51PM +0200, Luca Ceresoli wrote:
> Remove unintended extra word.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  include/drm/drm_mode_object.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

