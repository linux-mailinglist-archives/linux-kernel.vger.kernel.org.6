Return-Path: <linux-kernel+bounces-513277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62996A34844
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8564416BA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D91FF1DF;
	Thu, 13 Feb 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljt/AJ5u"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328419E975
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460972; cv=none; b=Fmlg0O30JbFU4fafSOZSCuLZ7JEGTbZBE2g5lqmFBqWqQ3GP2xtEVF+dUu9FTJ7shiARdbTtfPe1E762T9nH416Eg3LVeOals11Tez8hYUnrm9L5TYQH3bTUAWoasrj+K71/sG387hOTHv2vWsDLoWBC4AqCk6r3Ui2rWvHpsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460972; c=relaxed/simple;
	bh=nhl36UTqE0LW4DCJcT4lmamCR8RcofmmaoyPku3b5fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5Cr1qditFYeEFnZHpY55f4mjOlSjdu3MTgsnqstsm9y2aEyHxvpubqfN3UikMYz4VniYO1D8D3t9gqBtw514A1T3ebcgWscmuuiiGQ9MXEoVsnG8cpwax4gsfFwD4GwBQCPrK7F9g2StwtDGyKb1OAAhoDtRGHKZmoFewA1ymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljt/AJ5u; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dd935a267so807329f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739460968; x=1740065768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4IcXbcGrIKkvklFTibYCnGdgsV2fdSKmU8Z5nD/hPYI=;
        b=ljt/AJ5uf3m+RJ693VCCy7MHLQD9iyBL8cS1QAewVZ/jc1upo9ALybW28kLBQ6K2bb
         tkPXSnUmwGlxW27p4eK47oq6FrAz1ttOZWT/eXxCEEXroFqT31o/YhJJJC6kiakXn+tv
         /EtQDIBsB4BQT1UQnNICCS5M9oWoAHpW3r2yZSruC4kIJ5b6rDXpb4ODwj/cwu9USFMz
         GXS/hgeKxGeU4pu7UVc/5SY61ACIDaohCPOZjp956HAMRpmJ+ws+G3CEZBOUNPr4cx+p
         neglNEmMF24GQjdahQnLX4oj8BOCIorlHI3naLarUdZhbH5Z1RgyKPiZPXCDztEAzhwO
         rFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460968; x=1740065768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IcXbcGrIKkvklFTibYCnGdgsV2fdSKmU8Z5nD/hPYI=;
        b=tPEawZFl4pcIQG88HAm0GVtEcgbTVXn8l4ryaUHnRh6vzrhzxwDEsxdW7kMOeUDNUl
         74awgdI76hL4Tjo9Lbfg6wpCKVltFafRnan9pKKfSj7yDVgG3X/7RnVnozup35jo2c3c
         zSKL+fbVdhdkxXNOquXpKx/hNPLPI+9POZNuvqr4cbcye4ps50BYhxhct8OX39hiNRnG
         PVLVPF48vedJBjV5yprYDK2YyK2HwkANC3C3ICIyHjau7KNIeSJ6yI93HD5pwQx1JjYW
         7K1gznhGTBTIq7YTRRfO9dFvOC7brAbTtML7X7DvSqmi5QOKJdOuxgc6E0O+rB0Ea5hQ
         znXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdxq9FcOzagMjFElDlpOSUyAFtWmMPdUNupHrnt97TyIqslG/arTVwa75Dc88BjKYYQkK8kCvSD7u+JcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yype6MyFj+3BiTH3L/3ile6KW/X2Ag5pKaQyp+UW8i/3BpO6NO/
	nrEW28of/8Ob684KgtXFOrGD7qVaI1NdCEm/gw046Y/HQ2sUVfmB
X-Gm-Gg: ASbGncv+7oeCNeSfOi5P7HwU4Wy9clLNnz2UypEHA2SltEW+fI0ivPYSXZwA2uR7blM
	1tKYsRMZay8OwRngZqRoqUNa6QV3/hVKnk3qfZdNXd3gQ5NrLRmSTT59aFPxvq7ZJ6upYvJxYK6
	xsu0dFBlyy1jLyhSkbfGioNNwZaOqzD640wGOd/XpqDFu99ErA83xsGkV5Lug9bFtEhCjaIANrH
	bgyIMgyz6rldaSbdtl9b2D80eO37OyASkNxxk8ngchx/7lKCDz639qCbnMTHOBkEg9I54JHq4KF
	Q8w+T+rYt6U6ouw=
X-Google-Smtp-Source: AGHT+IGSGpgSdvmbWbgThw8kS11u5smsNhtdHae1iKQRr9jaVX3eewQTbXi+1AvJUCh2KKRudVkMkw==
X-Received: by 2002:a05:6000:2a5:b0:385:fa3d:1988 with SMTP id ffacd0b85a97d-38dea259847mr7583799f8f.8.1739460968248;
        Thu, 13 Feb 2025 07:36:08 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fa1esm2154028f8f.100.2025.02.13.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:36:07 -0800 (PST)
Date: Thu, 13 Feb 2025 16:36:06 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] drm/vkms: Extract vkms_config header
Message-ID: <Z64RZu4HdoBOzroM@fedora>
References: <20250211110912.15409-1-jose.exposito89@gmail.com>
 <20250211110912.15409-6-jose.exposito89@gmail.com>
 <Z636vaJLmJ9RGI6L@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z636vaJLmJ9RGI6L@louis-chauvet-laptop>

On Thu, Feb 13, 2025 at 02:59:25PM +0100, Louis Chauvet wrote:
> On 11/02/25 - 12:09, José Expósito wrote:
> > Creating a new vkms_config structure will be more complex once we
> > start adding more options.
> > 
> > Extract the vkms_config structure to its own header and source files
> > and add functions to create and delete a vkms_config and to initialize
> > debugfs.
> > 
> > Refactor, no functional changes.
> > 
> > Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> This does not build in module, can you add this in the next version?

Interesting. I have "CONFIG_DRM_VKMS=m" in my config and it compiles here.

What do you have as module? CONFIG_DRM_VKMS_KUNIT_TESTS=m?

I'll rebuild every patch to make sure there are no errors.

Thanks for the heads up!
Jose
 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 152b2ecd6aef..42caa421876e 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -4,6 +4,7 @@
> 
>  #include <drm/drm_print.h>
>  #include <drm/drm_debugfs.h>
> +#include <kunit/visibility.h>
> 
>  #include "vkms_config.h"
> 
> @@ -17,11 +18,13 @@ struct vkms_config *vkms_config_create(void)
> 
>         return config;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(vkms_config_create);
> 
>  void vkms_config_destroy(struct vkms_config *config)
>  {
>         kfree(config);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy);
> 
>  static int vkms_config_show(struct seq_file *m, void *data)
>  {
> 
> With this:
> 
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

