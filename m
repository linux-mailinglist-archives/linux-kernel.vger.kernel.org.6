Return-Path: <linux-kernel+bounces-183062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183798C93FD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494531C20B23
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016ED18EB8;
	Sun, 19 May 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLJpqiAM"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F016182BB
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716107548; cv=none; b=s8srNRd4QOqwLw1iviLVsc5caq/lZO0XH4yr+LgG2KthyUntgY+DONVqlQAZjhLdP9u1hC0KW165GQ/XIw+6lS7VzM0Trbqp/iHm9AMN5FfeaHAnvYREkyzvTy7WXpzxvWfkRUXVoOwSqWzZx6q+T8H1bRHql+XPvasa9aWXAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716107548; c=relaxed/simple;
	bh=7o4z5Hzuh+ixeSbNecKz9Jy3CviJ1QmeQIu1pkshTm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDdUn24QZ8Son41QMk+wflfIB1CvVPBJUlfW89btOtNobN2mMepbZr6C1JOjdXwWbijFc7RAuY6VGRYTAC9SU5fg3DnIAWMOJQcZFMZkncfBYC2OF2M3rf3BDI5VL+OboQct1w/NRwjxyDNsFiuZ6TpNzu1OJJt7QCGaLXjTLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wLJpqiAM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e34e85ebf4so25378871fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716107545; x=1716712345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Le8VTSm8L2eQLV/FvTpqReYtFhrZrNh0lNICrrBekA=;
        b=wLJpqiAMv6D3hnrQrQkuRr7xrBW+Pls7B6rws+tlHKCBdcgiPHc4nnBJYfURcUPtm5
         TqHmYoIqVrzK0e1cGEE4fVHp6T5z39B4tcXOtufHHE6tkPvD+GnSnkFXc7DQ1lL/KGST
         aHtSgWCC2tV+6nL6ZyaJU4EZ1P6Q3zSXdgeHFKFHrDOJtN0QTOquApKoEGc1Y3YDjDJe
         1icZWlBQpxzSWn0avkFdohNljpQxHRQGc9sU8EqtojeqdA9vmwuGSYgalWg12+h6/Asv
         CwnCDGRJMa+Cykg9vMRN0zunzf2jYLUXP0S1Tt9EaP7wkcseJ5CogTmlYoZtrLDKk++K
         GSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716107545; x=1716712345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Le8VTSm8L2eQLV/FvTpqReYtFhrZrNh0lNICrrBekA=;
        b=r88FJ/8dSWhuBYv9TgD73qU+dwOwVr0is+f1LbwHzSv3CLk9GbhWC9f+8DW0OeNtMQ
         H3qxS1OqmJ9j2l5bvh4Ft/bQN1alblXmQnOX7E1K+rvdWDoKJYQhv8Hq7o745l9MPM6E
         rlow4w4qQyG/1iuzrJWu6KgUqP0EqbyHdQEF7DIrd+MRc641joJI2UT0I0ZjqFOEF5FG
         2ux6ZheaxThqj2VWdp2H5w8zGAJOKNblByiv3d1jNAV2cVLOkAxR/e/aAraQxkqmzaKs
         SWfRcRphnjN6X+UutwxYfixPYCAzB/0Tu5WUO6oiLzDrUlVdOqTqwwL1l3ohgVeoZspa
         JDVA==
X-Forwarded-Encrypted: i=1; AJvYcCWh89Zh13bEp1a/HACf2C+uJtmKDwdqtefJfu1+TWps43nVXOgpbYXBN8/F/woFUfX4SQIBWO5xhy1n2hByRM33fqcUJR9u3kL6VwUx
X-Gm-Message-State: AOJu0YwiuFHTpr9ozodcXivH8F4H7y706GjsHGiWWkpXUcM0Y5qk2eQF
	PU2Kswn4B1BIL8YD4U0uZtz9C+gEdl58C+M+0CNYvuWhDAL8UJl9RFkXmfgdogY=
X-Google-Smtp-Source: AGHT+IHRQAJTuuhuKf5V1fqci/B7pNsDW3WCJuXKkN6dOU9qUhabV6ERXOSUH7pVZKKxAmR7LqidOQ==
X-Received: by 2002:a2e:3c1a:0:b0:2e5:62e4:33ec with SMTP id 38308e7fff4ca-2e562e434acmr147040561fa.33.1716107544823;
        Sun, 19 May 2024 01:32:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e52ed429ffsm27370571fa.54.2024.05.19.01.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 01:32:24 -0700 (PDT)
Date: Sun, 19 May 2024 11:32:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	seanpaul@chromium.org, swboyd@chromium.org, dianders@chromium.org, 
	quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] drm/msm/iommu: rename msm_fault_handler to
 msm_gpu_fault_handler
Message-ID: <ekfam4rolj5ouctytp4srq2iofh2ih4spdic2r4ffvjjawenhh@si37t7k3lmkk>
References: <20240517233801.4071868-1-quic_abhinavk@quicinc.com>
 <20240517233801.4071868-3-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517233801.4071868-3-quic_abhinavk@quicinc.com>

On Fri, May 17, 2024 at 04:37:57PM -0700, Abhinav Kumar wrote:
> In preparation of registering a separate fault handler for
> display, lets rename the existing msm_fault_handler to
> msm_gpu_fault_handler.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

