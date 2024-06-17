Return-Path: <linux-kernel+bounces-218420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0390BF84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E70283A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704C1993B5;
	Mon, 17 Jun 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCgRUOUM"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05126176AB9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665731; cv=none; b=ng8GuBd4wcWIE7krmt9g20IB9g+KyyMCPApVTP0aIAix5Bh+1OVV1PqpPH6ZIILuvaSVY1HoHeIPcSk08QfNtDVtBkot7dwq5lIcwvM0tvir4cGfo3OFXWYLVhpzxEQZ78MGQbHPtm5erUQgkq7eHMXIceFjPxbZmCYs2oPCo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665731; c=relaxed/simple;
	bh=wybSM7WHHqkQ2R6SwCskoD9FdRyanI9Oi0y7lQt5Vek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al55tYka9zjk457Fuc3E6zHQYudGtLilJX+o1FN8Le62SDbkWhr6ZIyk39u3d4ST+XIk89KlXpWvPrpuki3qUVAvGA6yUN/3KkV37OvqcQzppfN/6A8XHmjW4xz2La2UTHjB0Ybfz1TM+O9RTcN+gVyF8dBf6HEtVwI1yUma1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCgRUOUM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so5519886e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718665726; x=1719270526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aItYv47n04oe+ak8w/3qYRjP0+9VimLnrV46ub/7RBA=;
        b=mCgRUOUMP+UZ4316EYyvoCaCmXNtg8DkFLulvl7VVczfj8YEnm3jn2zVJUABVSnbjz
         I2tH9dGQFZJ6U9Zwb0axp9xnB66Fi3T1wvmiPWmrBfuu9pdGZudf5xaYNkZt6Z08UIjp
         E0ZsZ0F+qr8nDpJoobGbYjoGqJcOvsaZmKu7rHsvHvGUHTxNclLQrkf/dHxQtX6J0S7y
         2seoREbzWdFfhkJSt7JLJ0anPzRIG0FiVpSsCknii/GwxOdd2+YNtZL+3MvX2EAFrn6X
         PGZkX3MCkSEU41eNEwoEr9W/85j0nl/W31kRLE/ifPv3bSKesvGQuTNjPlje0s4Vf9Vz
         3SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665726; x=1719270526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aItYv47n04oe+ak8w/3qYRjP0+9VimLnrV46ub/7RBA=;
        b=Vyd5CZLlpGUpJ2qcX1vHnFMqC0cbE7O9n7OddNW07/4SVcNnt/S+zcHqjG7aEhpsyw
         HPhBUxr03EdpEcCwM9t6J+EVVvnlmtPa7C/6glm0ZwasoflPePrYpDOxIb/5NfWlbiGP
         oBvwIlxCoj8BRrDbfmVbds2Zk7qZBvkmrjvsfq46fRmBureZGVMzS+GgtvwXche51INd
         iiYC4bPaCAU5W1+IBUsh2j5RzfDbSRPBiS5Hsn2l8v9lAt6/qyk5xWEVUktcELgioBxl
         S3T1XkIbvG22sc5oPkivOXctEJspcdpa+Kf2iqsz3IHFyfUFKBp4c+hkgAFcegfTRTGk
         64tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhA2XUY+5b1PXzV0LD89Q66LfezlvxuVssupklkDkzeIbVGAN3WiFAiWSeW29t8FJTqC+W06On9Tejn+QC0TTx79AMxKCUdaBnDWDe
X-Gm-Message-State: AOJu0YwyhafKwCoiJQ3dEPbb93hzm7C4Kr7SdtT9xSam/Ob2d4KSCUBK
	gMWlJ3Z8+ZHTK45EdOkI+ni6yYU45+71Ot7iiTLJ2lg0iNsoihD/UgtiFFUrAMM=
X-Google-Smtp-Source: AGHT+IFqRbG4SXGP7E0yHY9eOqloQKarrRolhd8SgBkpIWf9H6iu6gUa8HngxjYwH/kPq1z5Av3dng==
X-Received: by 2002:ac2:4daf:0:b0:52b:c33a:3959 with SMTP id 2adb3069b0e04-52ca6e65845mr7172003e87.28.1718665726064;
        Mon, 17 Jun 2024 16:08:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282ed7dsm1379069e87.92.2024.06.17.16.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:08:45 -0700 (PDT)
Date: Tue, 18 Jun 2024 02:08:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] drm/msm/adreno: Split up giant device table
Message-ID: <k4gtnlli7ocmyizfsr25nuef5hqjq5a4pi4hjqej7nj2xtak2i@jjhfryck2fyl>
References: <20240617222916.5980-1-robdclark@gmail.com>
 <20240617222916.5980-2-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617222916.5980-2-robdclark@gmail.com>

On Mon, Jun 17, 2024 at 03:28:59PM GMT, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Split into a separate table per generation, in preparation to move each
> gen's device table to it's own file.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 67 +++++++++++++++++-----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 10 ++++
>  2 files changed, 63 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

