Return-Path: <linux-kernel+bounces-410799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEBC9CEADB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86465B3847C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A11CF2A0;
	Fri, 15 Nov 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nR05r7Nv"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C41B218E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680339; cv=none; b=hxWgu0iLjUsGDLZHfHVZQxqaKgVJI9oznBd8akeNiZy0yvQueunRvzkPCjQpJAbhLOAuvP8OSD+i4GEPUzXY8LYA4HCY1qsqk3P3zlFfZqCCvwd21BcZ2haTrw0pj+yAwRhXMATo5Xa6Ncb889hOqc8SH4fhc9iHRQ6TIXYJU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680339; c=relaxed/simple;
	bh=ZIPyT8dx+eHreBugSxOn3Ptl0BOPxKH7//P+XwhpvVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwMAtbqKAcyXb5DIjIfuOYFP0LvbabcA4eyLavlew/l5Sb3UHQqRJce+OGOIoAqkuB8sDZhk4Sj/QtfE1VgE5rDJdrQxMe3G44l1nrsJN+Jycaqh/+h42aW/YrunsOQXk+LI9auO/rZgL7oKbetK4SHeH/jwPK6g66Zx0r++WtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nR05r7Nv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ee676b4e20so3203427b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731680337; x=1732285137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rhxBFTVLr9CXs7yVyXnjqOaOGkDhEtwnjzGXMrCkuoY=;
        b=nR05r7NvBkkADilYRK6uzNCYjpnUGZtXbIkOVJsZT2VzuneOW/jJcogANkkNvUkN+v
         FMm7JwgAeQg6tIVVqBLfSa7QhJp3iSk7de0l8/Hg9zlrVi6UQjdK78W0rgLMM3Xja9le
         FWYp4n10nzWu1DHldcMiN5jcUKsrqbej5hAuPJ8DinZl99LHZBwjTzOlP7DSer85eCfi
         Aorc4daP4kvr1+tyqXn9gOGbYDauDaXhG37D2KmcQhQa4YuCrnBtPm3VFiRJB7E98eZv
         uBNcpodd0ill9fUDH/fbLmVZkF0gcaAyyxf4ITVmVmJkfaebtBibnwDhJB2gCYHxDicj
         6oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680337; x=1732285137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhxBFTVLr9CXs7yVyXnjqOaOGkDhEtwnjzGXMrCkuoY=;
        b=QGk/Ug3SKRqN/wBKUGW4wfJ5F8cffV4H6BO79UzfQAiccrrZK2Ho/b/ttymLtEHRG5
         5FyBHQARMVzw4efDxwHdg7tbkZjqZhTqnJmQlJ4GZNLHfSZJOko/sZ2iQre/jk01UzGD
         S4G848uKFI3C4zP0mOnWKwfH/s1/k0zUx8ybJUH8f9M1QqbryVLrusr07uVsV81Teo0z
         DNpNJG6baqRK/RlQ+/V8y27SJJaZf8d766ILODH9ewckopAoxBnETuaZGgxWRzvP5FoL
         U+2dY9O2kxSSRtRVgeWZCx56cQpZHpjyR4OgePup4wN2dAjyUKyv96p8Yt54KgF3XDwJ
         or3w==
X-Forwarded-Encrypted: i=1; AJvYcCU4jgS3aFNAE8iKK4NkrsUYBoLvFD1PlgKUxQnCGOeK1zHEDfDbjMgJIVGwDbfQ2kBm2mg30CJCm8n7wFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHibbcjrUI7LWKNcpUTzB3dJoPy7YUJWcKpJ0rIMtUSJ5W9tso
	BoYJDcXFKCL7RFdrmtn3u4CcE/AzxBTnB/qGUGAtul4P6oQzjtUfUkxVQDHbvfck0Hr0G+o8Mx5
	bcnA7Cx97N2K3py4R2F1nxktDZshZT046sIUQQQ==
X-Google-Smtp-Source: AGHT+IHAutNFbQIYrWEa7iEgXdJ0MlhAPiCQSjQjzOFudXA+GpwEclomXP7Hjrwzw+jQnjMyfUPPdwlemfoRMd5mMNo=
X-Received: by 2002:a05:690c:7309:b0:6ee:36be:64b0 with SMTP id
 00721157ae682-6ee55bf0725mr36374547b3.16.1731680337418; Fri, 15 Nov 2024
 06:18:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-2-3b8d39737a9b@linaro.org>
 <sgz4h6rlmekiwypaisjbnej326wv4vaqt3mgspp4fs4tg3mdfx@cwmdqcu6gwbf> <63a2b391-8b71-41cb-bed2-3bc7fd2154ab@linaro.org>
In-Reply-To: <63a2b391-8b71-41cb-bed2-3bc7fd2154ab@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Nov 2024 16:18:45 +0200
Message-ID: <CAA8EJpoFm8EjfBq70RTPtwR7Y7Rm24kHO20NukGiLGRYD0p9Tg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] drm/msm: adreno: add GMU_BW_VOTE quirk
To: neil.armstrong@linaro.org
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 11:21, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 15/11/2024 08:07, Dmitry Baryshkov wrote:
> > On Wed, Nov 13, 2024 at 04:48:28PM +0100, Neil Armstrong wrote:
> >> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
> >> along the Frequency and Power Domain level, but by default we leave the
> >> OPP core vote for the interconnect ddr path.
> >>
> >> While scaling via the interconnect path was sufficient, newer GPUs
> >> like the A750 requires specific vote paremeters and bandwidth to
> >> achieve full functionality.
> >>
> >> Add a new Quirk enabling DDR Bandwidth vote via GMU.
> >
> > Please describe, why this is defined as a quirk rather than a proper
> > platform-level property. From my experience with 6xx and 7xx, all the
> > platforms need to send some kind of BW data to the GMU.
>
> Well APRIV, CACHED_COHERENT & PREEMPTION are HW features, why this can't be part of this ?
>
> Perhaps the "quirks" bitfield should be features instead ?

Sounds like that.


-- 
With best wishes
Dmitry

