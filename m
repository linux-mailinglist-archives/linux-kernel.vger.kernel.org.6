Return-Path: <linux-kernel+bounces-267706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A50E941491
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE8328439E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38571A256C;
	Tue, 30 Jul 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sE8Z1CiU"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0D1A2540
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350597; cv=none; b=CO35BOmEW2P+bZuk21ohE2+gTUij9txCJD1SRivYIbJZBfyDcdcHVSsryd+H1zL9pKZSX+CWpIF0xJEDTwygmPRpHGJhx0FM6AtbfFa8/58TcF8+IooxL1e90kL9MkrRkKDtuOzlV3mRAbxcO1ra/CEycKv0F38Knh9CGo81t1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350597; c=relaxed/simple;
	bh=Om4ERC7VqqlNP0k+2cruuobLicBrUelIiNGiFuwCyTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE1NeUSSFZyQXwhE6NfUBAZCGGjzaB8OcCvWvMQ9aJ1BkLQntvcKWv4B4plTRLvNwxFGOgPKdOeBaYPrxD06Efh/yQtC9bamrsK4EGzZ4er5Be1W9DL+bySbiSf9WkSra4SrGhCnH6rPb+jJVYNnZ+8c8yqawdXo/sllbGbte4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sE8Z1CiU; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db14339fb0so3171375b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722350595; x=1722955395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYaUiMVR737+a9vHy0nK52dupPoGOgPRjQey1WHJB1Q=;
        b=sE8Z1CiUHRLgAk7Z7ZsQAm5++lc8vBaUdfHZGTogWiW9031y/c0Awdt4vrI+O4tXul
         dSSamMU5HVUwGplA99IPnfEMotceRj2QfHOS8LwTf2gzW/fwwj5kSY0mXQ8A0qezNDq9
         qaPnoF6546ypFzkEY8eQ7u10pxZR7cUKC+ceZXQy+l4RxyYOC4/jDwZU0j1tLZL/CA/A
         rEuwIKDAvq28pkzjpUmhOpHghMDTADyezOhQgq8w8boz5vzWcegTBOKLBS/0fsaaehBj
         t5xJ3kl+goLGdALsv603wEDVbfwjw7sz1rZ1/OLqXDorPHTVDWvHzCJ6y87/xqq0TI09
         o+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722350595; x=1722955395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYaUiMVR737+a9vHy0nK52dupPoGOgPRjQey1WHJB1Q=;
        b=G73kydGzIk1Nl2xdi1tBS4UTCoMfwtz06ufhngYaoabouO+h7k+jWC5gVXtC4imNYM
         Qk1KOtb1dCffvxI6ZXwqoylPtCamJL5oLwGbfA8Tsr1p373vESptSDKMr8blxeHNoIKJ
         qRd+d6tc5N5gjKmuPkDClC+tAfwUd/zw+jZTMbOAiN0eKs9pqS3R34pBMDvrkm68mRmF
         7IJZvpg9VHUc/7cL9GaPwmYwTwgUGTofbAymyJ0SPqkJVFdNSsoVDMYnnCm5q3djvcqB
         NAmtbTcZEm8+lfVX5frjB3K+WcaLap1Z2o5GwgvAxz10CY63iGno27O/DjzdKqXuPN4h
         JT6w==
X-Forwarded-Encrypted: i=1; AJvYcCXXSHnobAq2bFGfzIwTfVP2+oXDMEEDVOjGjAfzF7Gc8MD0xKj4auG8lwyjnHyf47ZKhfSMdyjCBFYvnRBgPdmsG/98qz1eeqJhR3Db
X-Gm-Message-State: AOJu0Yxr+/ENBYm1TTq4FikpzEYx8Knc76avyu1Q/ycS1Cm/B9BGvQAK
	U00yhzOr5Q8vGJCwXrS9NSuMWMDy3rC3JTBtsoNnunVJITJ/sHjoMuQKDdyQFOM=
X-Google-Smtp-Source: AGHT+IGuXBra4zsWnYNWnRqLnedt26KvTmSvT/pDGfaLXeIuq/5uIHAg5xLd8VXHkdc4QWOhhHUs2Q==
X-Received: by 2002:a05:6808:1289:b0:3d5:4256:26d4 with SMTP id 5614622812f47-3db2389c6ffmr17162599b6e.7.1722350594816;
        Tue, 30 Jul 2024 07:43:14 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db417ed7e2sm303408b6e.8.2024.07.30.07.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 07:43:14 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:43:12 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Whitton <spwhitton@spwhitton.name>
Cc: ~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: atomisp: Add parentheses around macro
 definitions
Message-ID: <f702d0b7-e316-4190-876c-1398f0ddcd6a@suswa.mountain>
References: <20240730062348.46205-2-spwhitton@spwhitton.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730062348.46205-2-spwhitton@spwhitton.name>

On Tue, Jul 30, 2024 at 03:23:45PM +0900, Sean Whitton wrote:
> Fix checkpatch error
> "ERROR: Macros with complex values should be enclosed in parentheses"
> at hive_isp_css_include/sp.h:41, hive_isp_css_include/sp.h:42.
> 
> Signed-off-by: Sean Whitton <spwhitton@spwhitton.name>
> ---
>  drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This is my first Linux kernel patch, from Helen Koike's DebConf24 workshop.
> Thanks!
> 
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h
> index a7d00c7bb8bc..128109afe842 100644
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h
> +++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/sp.h
> @@ -38,8 +38,8 @@
>  #define STORAGE_CLASS_SP_C
>  #include "sp_public.h"
>  #else  /* __INLINE_SP__ */
> -#define STORAGE_CLASS_SP_H static inline
> -#define STORAGE_CLASS_SP_C static inline
> +#define STORAGE_CLASS_SP_H (static inline)
> +#define STORAGE_CLASS_SP_C (static inline)

This must be dead code, otherwise it would break the build.  I'm not
sure what's going on with this header file.  Anyway this patch isn't
correct.

regards,
dan carpenter


