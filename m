Return-Path: <linux-kernel+bounces-309210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF47096678C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D20D2871EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2A81B1D7F;
	Fri, 30 Aug 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMGa6pOX"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4381509AE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037332; cv=none; b=plQGY53Vch70ideqfVugTXR8/k0NmfK60o6Xfa3kZ2+WBgAAjh61Fi6rR6ucx847k6amh7u7dgkKFQZ9nJ/UbDGqUsLq9a7bkVFDQGdkj87lYGOzZVaL709pvgqospi9SZHJ//eY4S+LxRiX+BJ0juoAnlIGS1fpGU+W0uLrOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037332; c=relaxed/simple;
	bh=cOPcs/v+mLMBRmxNu9CzpJ+lMs1XQcL+pB+B63ErAyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1eueb1vyHGFEVtwzmkU4qAPFvBtB/BeRzPzKHcMIbvQaiFF0guY5YkD69GyroKQY+ZAryJZfD4hO/N/ugOC7kubCWGOhpLxSvY+9bCTNYrw8mj0axDSseuZbSSHMFmC2ClYXZfuMqgKcKmwOLbwLs4camoWKsXwQsvJtlO7tFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nMGa6pOX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so27541691fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725037327; x=1725642127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iy1KwRpNUGkj+C8RUHgjHvQd7fkZ5xQBFwgIdNo1D+c=;
        b=nMGa6pOXx6mj4VCgMxABIGT9uPQZOPZsYAQnUV1Td/3+PGD5iotu9lPEl4Qem+HhZM
         laar19XxuXGsDj1+ibRqWHw2l3jBlP4+mKip3N5J14bj38tRPM/5S9izklBIebPQ7h/m
         2XGrbTI+bze4DaKBLkZdiDwYgVDlEQyTZ1LzL6Irqo8p+IM8aIj8/Y5zqTZYP4G9VP1l
         RuLojMdciZEiqcJf74SgZHaArMuK54aw9jZXBoBpkBG3J+/dJXluN5ELiK4wVr+8w/l7
         uN8IWIY2/7DrvdNZ9ophT/qGpq1pUznPvexJLuvHglVNp0GVsTgbk27Yc0tkKjpwVLfr
         HeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725037327; x=1725642127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy1KwRpNUGkj+C8RUHgjHvQd7fkZ5xQBFwgIdNo1D+c=;
        b=a90l7mpGc1D9bPKbG0kIHd7l8UMOUjf1NkBdX+g2lZZT9YyB6BDqMqaqf92ejRiJLu
         JWi2RUjQA7nA0kp4dEICO5i4Fw5FQ0DhrD3SXLqsayHIEDHgw/UGVKLYIKLM7lDyo43F
         Ggo0JChtyhlG2z/1BepkynsbORUtX9q/+XMiqMhkxJORoilieRRWXEmf8ne/3vbCVVDx
         YSIESyRuqik7V9mx9LvfTb45+3P4FnkbP0vqKEJadJfxo3d0g3bzTI4yH2lXYJDB3mk7
         Mmsvb+FpW/QX3wM9N6E5cj30dq8jYjb6Bk+ytgbLYy85s3jFqhPvtAki4AWlEAykfvLk
         2fAg==
X-Forwarded-Encrypted: i=1; AJvYcCUhSXg5Yxcm90klCt47GyPghVN0O4H9Yvg8XZKAEvufsuvYNlZW1VlLjne661TY3SspEGHgtvC54At0zfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHvx+TduG6OrMkJJ+OALZGjSX7DIewARa+idhpk+wdBHfjuLe
	I0TWJOJqLkN+Q5IHDLDmkLRCVrMeA33J4vTm/aG9LJ4W6/dpjHBj8aXdtd5sBR8=
X-Google-Smtp-Source: AGHT+IEPQ7h9WzerpnvpweqQa77Ds37RhEPya9x8ww4BvxZHsuGYMg+Xslva2ggdf/iA2e994Xil0Q==
X-Received: by 2002:a2e:4611:0:b0:2ef:22a6:d90d with SMTP id 38308e7fff4ca-2f6108aef13mr51280371fa.47.1725037326455;
        Fri, 30 Aug 2024 10:02:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615171e9esm7432711fa.77.2024.08.30.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:02:06 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:02:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 09/21] drm/msm/dpu: add devcoredumps for cwb registers
Message-ID: <ur3mio35j4pgjuykbh4tyqroherz4oh6qnaw2jm4oq5ecj5yic@bhvdr7xtnelb>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-9-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-9-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:30PM GMT, Jessica Zhang wrote:
> From: Esha Bharadwaj <quic_ebharadw@quicinc.com>
> 
> Implement instance of snapshot function to dump new registers used
> for cwb
> 
> Signed-off-by: Esha Bharadwaj <quic_ebharadw@quicinc.com>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

