Return-Path: <linux-kernel+bounces-190438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20F8CFE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873EDB21BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A913B597;
	Mon, 27 May 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3dAV3UR"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DED13B28F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806342; cv=none; b=RS+HH5jvHQ8fYmWqkXZYuijnblzXJ4jKO8/2Dq+NQNA6E2lMCAEnXiFkFT6sQaEwxS9rHuJMvce5RM9ofz5HXV34LsM2udkZ9Zwq28kWh/mnyIIyDpPF+ED5qpzomHvSNBI8GdbtC5Bya7/DM3JmzYJg1G5qsRgxwmn9ip/w9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806342; c=relaxed/simple;
	bh=IkwzgdfTNU+klIMnbkfTrq2KFgzEpaYiBSPhQKWeC18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PphcP5LmsjiCD8JyIL6ox6Al6yz8cyZzu2efTHIl+cosucz95whtfXajPyWHu0NltdRuxdFhBycIpilPJrPZRl38efPvpyIN9Q82x3yzJr+tHhvgRN6XmCg7+BrCiya5MFPcMWFYHSYL8RIyIyYj2nbuob5XpMOF+/77H1WeB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S3dAV3UR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso8182313a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716806338; x=1717411138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcLzu4LJ9QZeVn/MsZTmbDQWrB/tBNmh+KmvIiHdD0g=;
        b=S3dAV3URpEeeh+kAK28/WStp5EO2XRakJ4DD2Jo+s4fm+ABsEjVsiga7+hSK36DSCh
         Ve+e9r/doqHufS73QoGmQ1+uEWF/RKXV2J9rDS8z3Rx5Zm8X151ibFgbiLOGMFLYc52J
         TU8TZkN3sMWKOFFURfOtX2ZnOr6Hqa9soRjl8SWxGUhnJfzLS8Zb0GM2CX3afXic0OXm
         /bun8zvVcfBEjO9CHkF6L0Dg6I1t/cYWVheVfYDaLeMR1d9T0LZCSDEkxlmDdzq5BnFE
         503SwuH3DeC4MY/v+FgIWVfjLSOGtAX/K6KHvjP8dD93cBx4ODiJVnxB65YC70DOgnAI
         LkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716806338; x=1717411138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcLzu4LJ9QZeVn/MsZTmbDQWrB/tBNmh+KmvIiHdD0g=;
        b=unWL2lCiLo0Uqea0qrA5yUIWSmnHW7iA/lLviAw4awEeh+dfvPwKVn7VD4iqfW+ZhL
         pPjjvuN3KziT8BP0ExzjEUExHNOMRhRTJe6HzoKij81DrjzpxnE+fMkcIjYJ8pr7YQ4X
         OkaAbn6hmtI4zMf3QkX/QrdQvG7L7QlrfRChgpaJYb95ebOwndCZcThOQ/auRFfoqW4E
         uPHsTnO/uUwFzbLLO+ESWh9xZDDxojsopSOvev7O8QaV5BDCGDyB9R6+RvfKCMxe//PP
         Pd5TLYOaJc15SCTsAdbcKfg/NdbbBJJixm0GT4e05h7C6pvzqFA1JM8ldJ6yrJFgsCXq
         wahg==
X-Forwarded-Encrypted: i=1; AJvYcCUQlaC9QXedbKwl0HlxrOOP1aOZqxYbOiF+4LPnfwc03CLjndbOwCcrfS2jFl8b7Q8y9hmUFdmxjMGojN1w2eq+AfiyqdaW/kDwKY9C
X-Gm-Message-State: AOJu0Yxi06ul4F+pimHR8MmXctdjOpvy4P045DCLSJD03tyRRomcjxf+
	cZZZEciIXflvKuoD/XBEb4ZxyxPjVOGu+o36KLfOd0Y8yLJx2sh4ZerPjemQo294+TtBnRmu7KG
	q
X-Google-Smtp-Source: AGHT+IFvBQngBXOPW4ETq9VVybyALDmbeyIBaNOM9Vy8P40JUkXq/WTpcP2GigRERW9VwEVl6tOalg==
X-Received: by 2002:a50:bb41:0:b0:578:3336:92b with SMTP id 4fb4d7f45d1cf-57851796edbmr5061953a12.0.1716806338089;
        Mon, 27 May 2024 03:38:58 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785238d355sm5635915a12.31.2024.05.27.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:38:57 -0700 (PDT)
Date: Mon, 27 May 2024 13:38:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: markus.elfring@web.de, Shyam-sundar.S-k@amd.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/amd/pmf: Use memdup_user()
Message-ID: <4c2c8a76-17c7-4dbb-96ff-8488c8e953ff@moroto.mountain>
References: <50d10f0b-d108-4057-be9c-a90e2398e810@web.de>
 <20240527083628.210491-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527083628.210491-2-thorsten.blum@toblux.com>

On Mon, May 27, 2024 at 10:36:29AM +0200, Thorsten Blum wrote:
> Switch to memdup_user() to overwrite the allocated memory only once
> instead of initializing the allocated memory to zero with kzalloc() and
> then immediately overwriting it with copy_from_user().
> 
> Fix the following Coccinelle/coccicheck warning reported by
> memdup_user.cocci:
> 
> 	WARNING opportunity for memdup_user
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Update patch description after feedback from Markus Elfring

Markus always CC's kernel-janitors even though I have asked him not to.
:(

> ---
>  drivers/platform/x86/amd/pmf/tee-if.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index b438de4d6bfc..1b53cabc9aa2 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -301,14 +301,9 @@ static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
>  		return -EINVAL;

This -EINVAL check could be made stricter.  Instead of checking for
zero it could check for the limit from amd_pmf_start_policy_engine():

	if (dev->policy_sz < POLICY_COOKIE_OFFSET + sizeof(*header))
		return -EINVAL;

Also this check isn't great:

	if (dev->policy_sz < header->length + 512)

header->length is a u32 that comes from the user, so the addition can
overflow.  I can't immediately see how to exploit this though since we
don't seem to use header->length after this (by itself).

regards,
dan carpenter


