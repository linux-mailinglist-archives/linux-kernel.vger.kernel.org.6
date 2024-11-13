Return-Path: <linux-kernel+bounces-407376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D699C6CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F27B2DF41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF401FB8A3;
	Wed, 13 Nov 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EancCuFm"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D371FB897
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492827; cv=none; b=Mi3T2kgJofLBJBcxJJjRr1NhtiQ6OEWEBoHQycZti+OI0CPnI8RobbXgS1/b/7lXo182GTlpU58OTKGqt+fEEOVBTSfuU+53mFvzGjHfRJ/zX5MM8PEr+cMPcXqbEIMMiKnG4uLwdgcOJ8bEtQCs0q/Kb3pnACNqvQjvLVa3lIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492827; c=relaxed/simple;
	bh=KplYF0ansujd5YsyZtJDw7TTRhQgR20w6+Fb+RK4+lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv56dUI4BK4zyesDITg28cifYKDS1SxXXLMEPTlKhS5VW9UXy0UyoUYyHWUV2WZS/LI5y03Y/eCmXYOlqlLA0qG2i/InbkQwGnndW1Z0D8v1hTNLXbCxveeg7ytp+sR4Z2RqYZApkEgr1lpDN9L6+84djdLqrhygy11FqF98teM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EancCuFm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so4086252f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731492824; x=1732097624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=29r3GUvbzZw8w4aPc5tnOj0HcCOWENCLL4KD5K0a91E=;
        b=EancCuFmqoKMiubw7Gin3PgNH1lJCfm3GJV1nFrzzulAdHw7G0oF8NyPiSAR+KARo9
         Hp0iHNp90PiD8t717ASpp04T7h/yni5725kqDUwIDkPTUrAGie/afmDOHYBITcBzBixv
         APZX/mrCg4UCudjJ6/B6L8WNdTMhKBTHlE1LIDsnS5NfVQnQOtEl0h3dz0K5aEp0SntO
         uoSEJ8XZ8obPaH8Scq3H0tmUMgFpdNk97+BoU4Zf80DEgshflIylOYo9oe84e5UYgF4X
         rpKamnuwAICog4sQpjqxDujgI9WsUkw79Ex3TAhXqAjnXjQ1hVdxCJha73Jsas+xZrTa
         rkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492824; x=1732097624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29r3GUvbzZw8w4aPc5tnOj0HcCOWENCLL4KD5K0a91E=;
        b=g6dRVjHuQDrFzOl4zu0dHpfOsj2rQeWvGR16E5jMelW2mI16WnxPOIYsQi/Z/APYxz
         JTyE6xgsyK3FDFzruZ5nBEbPP79wf6aPUPTtEf3qrRL1nZWLZ8622Si/epu+8A3Xb8fz
         FFZpKWDwoZcq6RShoNYZO6pD8WqlpUdVStABJEKYmA44f4V41YAgpS308KNUGkhPqQUI
         H+/JSxGRK8Ev8cu2KnEj7BxGdC/yNf47CNoKNsKZm/dztRZGGf9tT7yJScv3QsyBBDx0
         AVZR77KPuMngi5UGQ8EO7dC0s6oyIOmzkRejP2ubDocg3OqgfbGgMsbGfhEz8yPEdnTz
         4tzg==
X-Forwarded-Encrypted: i=1; AJvYcCVTI4UFAukOt8hUYhdHc78lZfRJFGBRen1wWxXl7oSzZX+20v1Z7lvAvALzHigyjKs241+voSJTvShULzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsmlDUikmKmvPPne/lAS0E2db8IC+aN6lEsGQT8Fn+7wFkDNvA
	OBUFXSjD2YLkyj6Z1v4Xwx6EvtqWMFRpMTKgX/9DL+/zClGwJsZagaS/oszAr0c=
X-Google-Smtp-Source: AGHT+IH2BH3MALMB+E+XITlkb+0lyVpVuMJIDJUUSnd3RYPMU6chFRG2glEc9VGrAjVDTMO03oJKpw==
X-Received: by 2002:a05:6000:210e:b0:382:424:9520 with SMTP id ffacd0b85a97d-382042496a7mr6550276f8f.49.1731492823996;
        Wed, 13 Nov 2024 02:13:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970d10sm17689789f8f.20.2024.11.13.02.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:13:43 -0800 (PST)
Date: Wed, 13 Nov 2024 13:13:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/amdgpu: Fix spelling mistake "versoin" ->
 "version"
Message-ID: <dceebb5d-9cc6-40ec-b1b4-6ae40cba45fe@stanley.mountain>
References: <20241113095349.1161044-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113095349.1161044-1-colin.i.king@gmail.com>

On Wed, Nov 13, 2024 at 09:53:49AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 9c905b9e9376..feecd099cf86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -646,7 +646,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>  		break;
>  	case MES_MISC_OP_CHANGE_CONFIG:
>  		if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x63) {
> -			dev_err(mes->adev->dev, "MES FW versoin must be larger than 0x63 to support limit single process feature.\n");
> +			dev_err(mes->adev->dev, "MES FW version must be larger than 0x63 to support limit single process feature.\n");

What does "to support limit single process feature" mean?

regards,
dan carpenter


