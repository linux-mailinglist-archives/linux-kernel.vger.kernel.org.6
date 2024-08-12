Return-Path: <linux-kernel+bounces-283731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B56E94F856
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FCC1F22A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFE2195390;
	Mon, 12 Aug 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sm5pV4OL"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FC1946C7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495240; cv=none; b=qBxW+6vproHRJTP2i2yXi0W9iv8ikaJw704yEF3RF/DwOGzJo8CWuOQuO/xrOh03fJyOeDfe0TqG4Re5H3R10NY0qqCojliR1Jk2CEUl35I6BA5W09+o3lrEDCWP3BA3cE6EYVzjv792pMZyy0Uu6YLM5VsoYaHrG+Aoy71IyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495240; c=relaxed/simple;
	bh=NZAvXAR1bYBwYWxJuFfSjAliHSEQ1/ECvzqzNyw/0sw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcEHUbjK38JD93ler5a2LVToXAesbj4BlRZHRpQEM3l9giMEBbXHViMd18Mqo2lHH0QS5m1eSbZ11sFXcNFnHH67ZgJtPtHIx6cY3td7Y6XLSSiw5DxiggXVIqiInLGJACS4NZXgHz0SRkIvicHP1vSzo95gKq8fA7zq4uiEeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sm5pV4OL; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-83172682ab3so1415904241.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723495238; x=1724100038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZAvXAR1bYBwYWxJuFfSjAliHSEQ1/ECvzqzNyw/0sw=;
        b=Sm5pV4OL00VW3wu/0nQlqrvj5a9JBuVBXNwCD4j+ecYKap+Y1RWRE5D/wuZX+0blF+
         urFZinSJnEKEYT6MTbYaBWbxx5J+qw1fbv8nlEOg2mxJH3hVgH6JG7WDy75v5CZ5TZBh
         ZPq2iSMoUz0JbIdCRebdi9nP8ul9zj5SAun48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495238; x=1724100038;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZAvXAR1bYBwYWxJuFfSjAliHSEQ1/ECvzqzNyw/0sw=;
        b=RdbEZdsHuUQEhOSemfB1Z3CqRP0jl9KtH0reDr66qQHRZZNp8XAO49zCdbN27La9pp
         MrnI4c2cDJFYGl9M7Up1QAXH2TapFleL9fsEDmRJnQXsLym0W6i37Nu+AQIMWmNPux8j
         X7m6iP+Dk/vfnx7Lb4aUk7QVaUJ9WWUN9wF8g1j1NmDASkuGiEI128n/0xi/Za+EXEON
         6h32QjJT2MrmgVh+m8l9ZVul6aPsiyWFkO/pXk9woSVJD2b6FmLOLCfXqgRd0+ebi+94
         5d678REARgR+0/QZP5/r5ZKBHd61zkNpnQkVeeZs8H/0SCv900amc+9QPZRg7Hw7cT3b
         NQPA==
X-Forwarded-Encrypted: i=1; AJvYcCXDDZCTjzR2KHqrn9ue+S+PRyl6y7ikg3EfQtI10WRGSyQZAFgslv6uco5EIuS3jISK63UId1jfZEbzl6TE6nBL1bjSXlYeaKw9xeN+
X-Gm-Message-State: AOJu0Yw0m4bSC3u20Dl5lLC4Qu5qiQCt2J1tvJtx/xfe7wjBxiZF/mNS
	dj7ongsBK1/pkMR3TNjUhLgcgyjF+VRVOWLsxUISm+bf1tZYlUhYdhy+7TmARbvS55cSY5zS+wt
	bTF+gaATj7l9uDK9cC8G5TlP5hEqIXDFC0/zU
X-Google-Smtp-Source: AGHT+IE2xPIqgDYMDkVhZ+0wWF3tCQ3Y1t5YGgN/I9e2VhXStjX52f82U/5la54x4iTVj8B/dfc51TU63Md/eZ4s4WA=
X-Received: by 2002:a05:6102:38d1:b0:48f:95cd:e601 with SMTP id
 ada2fe7eead31-49743b36d8emr1687799137.25.1723495238239; Mon, 12 Aug 2024
 13:40:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Aug 2024 13:40:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c2218911-650a-4f43-9119-bd2cfc46f3aa@quicinc.com>
References: <20240808235227.2701479-1-quic_abhinavk@quicinc.com>
 <CAE-0n53qMJVbfb9oXbDexqhOj6qTBq9k5kMj1e6CXadObhBmLg@mail.gmail.com> <c2218911-650a-4f43-9119-bd2cfc46f3aa@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 12 Aug 2024 13:40:37 -0700
Message-ID: <CAE-0n53WwLK_Zdf_-1ftUV7pBOj0Vw_uM3LhHdOpVhwY1ZJ0kw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix the highest_bank_bit for sc7180
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com, 
	dianders@chromium.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-08-12 12:41:40)
>
> I just retained the same convention that was used earlier. It seems like
> a mix and match right now. sc7180, sm6115 and qcm2290 were using 0x.
>
> I can post a separate change to change all of them.

Sounds good.

