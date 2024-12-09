Return-Path: <linux-kernel+bounces-438523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F269EA235
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE3828299F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F6119E96A;
	Mon,  9 Dec 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCo6WJfz"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495EB19E966
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784999; cv=none; b=UmpPYH6hAtOkIrJB2LbxwzBxnKW6lJj4D9o0yIGTwdKhGQwTZhmD/PRRwk7JPf3FSr7r0j2M4uglmIqVYC65xVJKZPLLmKO0X3de+pIxH0uNJObGVijxTfO/7PW5RdkJZQBqG7wdI+45eTquIUEsm9BcJhus1kV0RieLJTWBHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784999; c=relaxed/simple;
	bh=5L90UKWKJXXDkcZ7/MXmDxJO4Cp7aHrP5iZaxK7W07Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5BS4UAHQvxyS+7KM3whQbDl80ZWEQ7HwBMiSbJ2BGtrUgMJoi9UCzgavpsGBQWgkYsFJhmYZA+XjDz82VLgw1ZtPF/d7J688fyNHUQRQppGtKyic5wQpjwt2yalOTkQGiwo7Ls6QhlC6c3PM6A5E0Mho5fAonqKb8JAQr2d01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCo6WJfz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54025432becso290868e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733784995; x=1734389795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3A1k+Apjq9O2ocS5a9hIgUNttSFxzpyEaBV4mfnunw=;
        b=mCo6WJfzMT7+dzaDGmjgT9pK8E3dbqapIM+/hP5ifaChbYq4R1nA+PfenlRayf7eKv
         XUNDNq2YwHRkxIgoExt95rU9M44e32Xbh8750oKD/ks0TLHvAjN/U3BDk0GEUeeNn5qF
         BWm8wwUGXFOcoqzWTjWw4hi0hWjXJhOMZiV9RjrHrJMLFw3efpEKEAkQa7/fnqlqCUEu
         ys2yHViedFatBknF2F+Eko4RRHF46j6k2gwHBzc3X8fTGpN+iLS93+i7TDzwUPNmeWxW
         jdYqphnIZn4BrCc/ZST1S60oYUJCuWKjPVbUF0u7OSPZ+lEtflF2UbNAbHsPWLMc73Iy
         RF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733784995; x=1734389795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3A1k+Apjq9O2ocS5a9hIgUNttSFxzpyEaBV4mfnunw=;
        b=QJW0T2xUyE/Oc9uchR0hVeg0P91nmouh2VF/qME6zupFqZt04Pt3BmwDQMbUD572ia
         zG5iVhOhcko8Bumy847dYFR9SM4vYlCKOgyLbjRzgFiACwdIBGoEFj5EDQgauz5RK+0d
         8oWfL7BojbSWOKvA9QOHHqHteRooYjkPaf4SqzNQmK7D37oRYowlwsbU2BxHo63ooA4U
         JI+QxAAOi4Os7MmovhE4gXKqGGfbZTKbW6A0pgjziDWuAu65gNDC0hdx5d9PwdHIOfzz
         k9vep8fzy/1IVcZY71mRz+NvSmAEHKO6ZYE7FsGzNNUYSBt7cHfSGfNyuG81Hsk+kdm2
         VutQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAE65AC2vnlBqlrqj0Fo+RECve0QISadTV4C5OopXiMoVbF9gAkPRNsIup7ms03p+r4ZT0ER1i5g+nuvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmsfpbD2IX2+/Qc1JVkMpMFKc8fEk6H7OKPk8bqLOzcgfP28C
	80rwoJUqmU5N1qjW+KU7GdKDkBXkfNAgWW8y9AFTznpxpQ0ibpZlJ7wwAAMUKlY=
X-Gm-Gg: ASbGncuq2B82TuKTNaIqrykqEeDWIH+tQ5FqXH4fjh1KcOJLU3qBuyJiKQVygqk29kM
	jcpdVy5aUwSMfe1mxFpO2FBaeS5YMuSSoqrU/LO6Sdm8vgwZpKgZavVqG4edLr/W17+PDHYK4sT
	nc+nG3lyeZwyBB3p4CxR1le/JqRPRPuxPr9swkYEPE7vlrjjlSqKqL+LxmcClyqxKv7CvE18jCm
	mXafAFbBj6wDtHllY7v3goFKCcJJEnRM8g1NfNQH+mJipBiiLLdkMkx67kRL0A7nu9f6LhS4FgT
	kkB8ar0BHuul6StYA9o2EbOrv6oBc0bT6A==
X-Google-Smtp-Source: AGHT+IHiXsoJOwZjiLBWplafOKbA1GHw3HlIwWuqcon2AqQvv21BwklgIEqY4mWvDfuXx6g/4hQk/g==
X-Received: by 2002:a05:6512:3a8a:b0:540:1b07:e031 with SMTP id 2adb3069b0e04-540240d9a8bmr1013012e87.24.1733784995434;
        Mon, 09 Dec 2024 14:56:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3115cb25sm1144888e87.56.2024.12.09.14.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 14:56:34 -0800 (PST)
Date: Tue, 10 Dec 2024 00:56:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dpu: filter out too wide modes if no 3dmux is
 present
Message-ID: <ouufiq72x46hxmatao6xyjbb4qk527pktowqpsutlu63sftwyu@uupkodk5ty4b>
References: <20241209-no_3dmux-v3-1-48aaa555b0d3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-no_3dmux-v3-1-48aaa555b0d3@quicinc.com>

On Mon, Dec 09, 2024 at 01:18:36PM -0800, Abhinav Kumar wrote:
> On chipsets such as QCS615, there is no 3dmux present. In such
> a case, a layer exceeding the max_mixer_width cannot be split,
> hence cannot be supported.
> 
> Filter out the modes which exceed the max_mixer_width when there
> is no 3dmux present. Also, add a check in the dpu_crtc_atomic_check()
> to return failure for such modes.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> Note: this was only compile tested, so its pending validation on QCS615
> ---
> Changes in v3:
> - Move && to previous line
> - Link to v2: https://lore.kernel.org/r/20241209-no_3dmux-v2-1-fcad057eb92e@quicinc.com
> 
> Changes in v2:
> - replace MODE_BAD with MODE_BAD_HVALUE to indicate the failure better
> - Link to v1: https://lore.kernel.org/r/20241206-no_3dmux-v1-1-72ad2677a323@quicinc.com
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

