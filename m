Return-Path: <linux-kernel+bounces-531002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4950CA43AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102903AB3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12D267B0E;
	Tue, 25 Feb 2025 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQegHoU7"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752B267AFA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477894; cv=none; b=g9hhTQ99VY9CPcFsj2bVMfSEY+m1LEZzQV9MLvU90X7ZmVMd1B+8Vs8jdWmzqrWbpdJxE9MvZAyT3/NTLJBTXGZVi0SkJutDz0vOdhZoOTCI3WL6NPISoxBVE3T39S9PiWP68OIdNKX0d4F8jlPGXuKPENXx0sVdz+6qZ5y9zu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477894; c=relaxed/simple;
	bh=DuA0E92AFzqVAQkY9I4a+gZlF79J+R3+j7twI3wDzXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGu5b3oWoYiGqiz5asu3LsCxuf/AuonluuC2P5/HzH7iKCv1tlakGt2peIPN8TJSpZlPQfSwldGZbQFSiVC25rGiyiBlBk42dECUeyxlcGJA4bDucTJ1KO0SL/pP7yIfFqQ1D2zE3xyhSA1YjXIJ5PBV6JulJpnxjUvPndsGrTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GQegHoU7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5484fa1401cso1195796e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477891; x=1741082691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUfGZOLBpPXz98roGZug6GzOuxZ57fwrWBTaMGnGD5k=;
        b=GQegHoU7zMaoX0CCcDUstVZHEP9+1/KQNkt1EpS+vIIFy5FvWSl5vF7BK1Zg5h18dI
         Yb0r+yajDFy4HpSc34S8mwSN+9kaZ4NfThLl935v9VAzzIk6huLOT9fNeurTlW5kKDvP
         H8rw5tK5PV/sFqO3CFk0nYzXcFm/fVxEC4iib4gr5KfudokWG5A4RcN5dGEanCIuwsX5
         SzXIqprGvO+Kz7u5GVRBE3VQhhyY7NCramgDStv1WpMyBgfFkVw4hZByP9DgslbmGNO0
         oQ2jDwCTPs+to8k0Z/j7xOtKBaGZ36/R86qO6ae65QZIaLni6LFqdKJpWaBB6aQsQg0N
         RPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477891; x=1741082691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUfGZOLBpPXz98roGZug6GzOuxZ57fwrWBTaMGnGD5k=;
        b=KCnYBYj2vH6jxPD5ylFTHNqvlnJiGNcR3oFRzlQbnigwdqmYd6DKeg9lpaEt+Xl6NR
         /ORZNzisp0BJE65eDSjLM+DxIX0KVV0aeFDcpkqdLhfhs/dNpumYIpxHDQ8teag09VIE
         x352vI2XLEQjwKVuoDkapE9/SesDyrGnStTrK8jN7cDpHevEeL4M8KRg9ynQICfzMa7y
         p2rZORfGeSk9A46S9+EcsRH7/2BKakG/UKAa8p91ZyXkSMX8oLv5y2J3cjyFiIblkbbv
         vh1EkL0G6u+SfLLk4ISMHDGQE4tG6anKgHxWOMijlrJwKGjf3yAeAqsK/rs41UJ3OJpV
         gJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNdIzXXXCc1XQN6XbCzqauCyycZR3ioE6CASkbSqp5c+FDGJlXE4CA+pTdEzN1AGGtxyrP3Ek1aeTgGHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAkNpS8JZ29dDL8b5fdDLd47Ro6j1m8Zct84IYI/pHVSkdJUQ
	D+eL5mOSwglFxU+fPEYeuwtTFjGWP4zvKlaQFHFfrgLVToGy/ebOqO1JwMG25gY=
X-Gm-Gg: ASbGncuOpGmrNgGtabx055jWHaC0vNinZ0s8ULrRMUW9EURvxSeu+3AtTANkvoUVlWi
	lNpQe0VxlA9pyaesrYvsk1ejCnDfU2wvtsewZi5DYuPB64lK+6Y+/kOktt6008WyOTjc8Hl+izi
	sjpi/p5+499X6t3njFM+jH2JdLCTfvoZex5+h+1o1hBfJi6u+f8U+XrV5nS6e85MNDQ1Tfs9a87
	o0u7G3YordM2Ni0BcvafYQbUyXqOnMfeTZsKWzywnNibFnmRwidz6Jbn5azncaf0Is3FG+wp5Qt
	5cq8CFvP51RPY4l1fyJ3shbscL6AW0D+K1Y6KDl2JOb4ff0sM+jIPYaPFqpGyjLQ0hYvAW8Y0CW
	iNwsj/g==
X-Google-Smtp-Source: AGHT+IFe8roSMzt3VVv7TZk036TpcSGcoxSHvfVATn8ZrfpARrpjkEuvUDMxx89xTrZ/KzUJppvbMQ==
X-Received: by 2002:a05:6512:104e:b0:546:2ea9:6666 with SMTP id 2adb3069b0e04-54838f4e48emr8396425e87.34.1740477890594;
        Tue, 25 Feb 2025 02:04:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b9e11sm136744e87.92.2025.02.25.02.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:04:49 -0800 (PST)
Date: Tue, 25 Feb 2025 12:04:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/msm/dpu: fix error pointer dereference in
 msm_kms_init_aspace()
Message-ID: <uzrw5szojucylvminnxghqld34jez7lfzljtdxtkmkxtm5xodt@ruihfzdhkx7p>
References: <3221e88c-3351-42e6-aeb1-69f4f014b509@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3221e88c-3351-42e6-aeb1-69f4f014b509@stanley.mountain>

On Tue, Feb 25, 2025 at 10:30:26AM +0300, Dan Carpenter wrote:
> If msm_gem_address_space_create() fails, then return right away.
> Otherwise it leads to a Oops when we dereference "aspace" on the next
> line.
> 
> Fixes: 2d215d440faa ("drm/msm: register a fault handler for display mmu faults")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/msm/msm_kms.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

