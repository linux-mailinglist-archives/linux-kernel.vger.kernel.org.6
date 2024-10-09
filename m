Return-Path: <linux-kernel+bounces-357820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA26997680
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F86B22658
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ECA1E132D;
	Wed,  9 Oct 2024 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReJPmWYY"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3717798F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506137; cv=none; b=LKc6MHPxWFYwfaG5SzvqnikeB2ykNM7+PLuXcRmeDHOwmtSNm2ziS8i+TVkWoxlp44A5DPlLin3HaqGuiUY/7EHlsMLd8WMJS9yFboI4Rw4YS6+3J7aGEzm9KsFlf6L6bfvRFEU4GU0fbmBSXW1T3BPrVNP0bPQm9nljzGWWKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506137; c=relaxed/simple;
	bh=Sm9hMLVuTico4hTaLNQJyYU2ZzVB7ziKBVwrcmJ8aKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dba0djs9lF/9YVh5tc45WGEaRb8LU5mXAoW/jlEmXe5EDSrzNX44k8fyqZgRCs3R5FaDV4DUzSESqvydxW/Ka78uMpwzOiq4mF6VaxT60DWsC3R+sXK4iWQxW132Ip9ckKeRIzEV22D2fmU4WnD3wOgoz7EQObWyGrroBEIRhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ReJPmWYY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so103387f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728506133; x=1729110933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjYS14YTYv2OCMWHkLucdNx0+SeUm3LsT48uh8uJaRw=;
        b=ReJPmWYYRi047nSiMcBoaJ1r+z27cIBxf7JkBRMlpPgHDc1uL2xUZkDwg+0FLxeoZx
         BOgn4yKgiUxZoVgGJrMbKJvUZoM13R/rCqUvjuSqVR/G0CcaY9M7iVb8KG7amsCcWCdB
         zMiieJnKY/aQdXS8GmRI6eNctqwANEnGJDBrgir59zZ9q8lzVt3NIHHLTUBXeDL2eJNQ
         XtxtBD7gHe/p9qzYxANkmJhyC9jy/ijo0oS8qL4hCFqx/SNsan5cd4wIZBmlDiSE/GY4
         046gQzD9fFi6OJbWnqEyCoWBuNua07XkhErdemfuwvS1M1nvFKVwul6vs4FEP4TJt2jh
         S+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506133; x=1729110933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjYS14YTYv2OCMWHkLucdNx0+SeUm3LsT48uh8uJaRw=;
        b=c5ZCLWuH33OxS5Ysww6LOYL6nqQtRSFVh8RdB0Q5O7XJsHNuNA1Kgkf0GeDIvGAkfT
         C3Axb2UoU4qgxD1KLABKNse7H1ZxmVQvupeHshbxBaWBZmAWvDgldDU8Dswwi83cA9qC
         7U7a59zX3sRttIq67EFqejMRUY3PBEFpAFfg6/xodvUBdBJpByeoIIgBjOc3Xf639KaN
         vncJ7W+XlXbqocHco38dRnrmBdQvkBn1SMfMPSPz1sPwrD9hAc6pjbSL1lbjp+pdGOk/
         yj9OOTtiNfgV/fstJZfNv92qeQsnK0EOMs7yJl1MCZQBjI4nwWzMI7WzIyI8YYtUXufq
         pYQw==
X-Forwarded-Encrypted: i=1; AJvYcCWC5azOlzjMsi+mgPHcEa3RAcyk73zUKeHl6RS9zEPL6DAk6Y7h6JvqTlEZ2lsDta8oesobG+zRZQzGRtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDwl0lv2qGIqCAfVAEiDA65YfkSgLWUWbxcuOs11OC/T2uzt1
	IB9RbHwAxfHCTd5dBwqGYynxkfBptOqP3ks15Z9p9DcqLqbU4Eo0tX7sbptqkOg=
X-Google-Smtp-Source: AGHT+IFbfMwsabJqo51FxMyaKfk6sJ6eDGqAwAcM1939Wwk+xOhuo14+AUTXfblGExsREK8B+2rfDQ==
X-Received: by 2002:a5d:6d48:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-37d3aabfd1emr2434741f8f.49.1728506132947;
        Wed, 09 Oct 2024 13:35:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d2e65d618sm4572798f8f.23.2024.10.09.13.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:35:31 -0700 (PDT)
Date: Wed, 9 Oct 2024 23:35:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, skhan@linuxfoundation.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/xe/guc: Fix dereference before Null check
Message-ID: <07d9eb6e-87d3-4428-aaa4-8721a6844404@stanley.mountain>
References: <20241009184951.4991-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009184951.4991-1-everestkc@everestkc.com.np>

On Wed, Oct 09, 2024 at 12:49:49PM -0600, Everest K.C. wrote:
> The pointer list->list was derefrenced before the Null check
> resulting in possibility of Null pointer derefrencing.
> This patch moves the Null check outside the for loop, so that
> the check is performed before the derefrencing.
> 
> This issue was reported by Coverity Scan.
> 
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>

You need to add a Fixes tag.

> ---
>  drivers/gpu/drm/xe/xe_guc_capture.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
> index 41262bda20ed..de63c622747d 100644
> --- a/drivers/gpu/drm/xe/xe_guc_capture.c
> +++ b/drivers/gpu/drm/xe/xe_guc_capture.c
> @@ -1537,13 +1537,13 @@ read_reg_to_node(struct xe_hw_engine *hwe, const struct __guc_mmio_reg_descr_gro
>  	if (!regs)
>  		return;
>  
> +	if (!list->list)
> +		return;

Could you merge this with the other sanity checks at the start of the function.

-       if (!list || list->num_regs == 0)
+       if (!list || !list->list || list->num_regs == 0)

The list->list pointer can't actually be NULL.  It comes from
guc_capture_get_one_list(), so if the reglists[i].list pointer is NULL it
returns NULL.  However, obviously checking for NULL after a dereference is not
the correct so it's worth fixing and probably deserves a Fixes tag.  Although it
doesn't affect runtime, adding a Fixes tag helps backporters know they can
automatically ignore this one because the commit it's fixing is very recent.

regards,
dan carpenter


