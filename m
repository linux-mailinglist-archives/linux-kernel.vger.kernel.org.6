Return-Path: <linux-kernel+bounces-321277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38819716D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DB028322A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84BA1B3B0F;
	Mon,  9 Sep 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hj2gR8Gq"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E31B3F32
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881114; cv=none; b=CsXNAxC3omNXuYCCXF3IZWLuQgSkrj/CkKMWeHXh95yVMnCDErnt3gkZfvpmY24dsxXQ9Uw8GYdigm88QTRRBMTrDyCQg0r+2kv5JSFUI5Y+RnEU6B6Zk1VeFM+r4P35GEw7oyxbO+JkrtvGWWAqsPz/qX15D1ytV4q4qgNsFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881114; c=relaxed/simple;
	bh=BFlzT05PQJJDS6WUMpHqs1A1QFrjjs5SQdN2X9/eAcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyBq8KS3uIPfAy0e3Av2InH/qw3CIGm8c1zKOt5c9KCKjNoUdc9EIt0mCuJp09wbEDP12PDM0k5dB0seBVT30tx19mmu9lt8ipB6nqCCRlmhUvQkviH7n+E1JEbjaxIAW3KrfSOJA9jzBKWWyvBQ7Z9TIju77eqC7N0r+YL8grg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hj2gR8Gq; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-68518bc1407so46039527b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725881112; x=1726485912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OpDNkm0dS8Pmjc3q7OtWCuq9xNsSuYsSijjbAHrD43k=;
        b=hj2gR8Gq6+DHmJJQLsaMPkx7vJkWHinonkdgjy8lQfE0dG7MwdKgcTZGoN8lspOlGo
         MVm1jIPegd9BPWuGZU5UeYmJRq5Lbl0ffCwOfYvxEKpUBXVqq1Q8Ijg1h5DiRSkKndTe
         oQpqe3BDT/wvT3Xlh5CpI4S1IkWoC5BkECuTnT0+g7/8CvIAV5SvcWrTAIpsmLmsHe2v
         pAerH+IJvrSkGJYLEwpwxiGN95rfx1bGDQYROOEiR5IQlARUugovN1HP/1VaMdWZieap
         XOfPekt10J+hAMOYoKvmre3Y2tX+LiMCqKbhDRTn6zlmWn2O839beUokBmpNx+OW/ROa
         Ag8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725881112; x=1726485912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpDNkm0dS8Pmjc3q7OtWCuq9xNsSuYsSijjbAHrD43k=;
        b=gOvRF5kUJ8KrCjlChU6HR5KGcgLfYXJWWTTXjukNCqiMEZkngiBx5Gi1pOfW3cbJQP
         8iSBgGdy7L8L05Vr6HgJ+6/SNtuxpjk2wBMTaugeZClo45KsAk3soGYVMWsRnBnz1HtB
         QH0vLXAkVqFpY0DZCX/LFIxMkLePT8s2FdmvD5XkwrUuZw4JlgWrCFlA1dispwKj352m
         hcyLmm5rUyGB4kDYLMvUP9NiuLqa0uvmdLlDUGqG8Iv7OUa43YfPmSfY7dQd9r5IcSGO
         VX9xTlBgGxk2hIoV1VhTEifGUzmgSHnf+nRnWpWn8qhjdvaWqAz5MxobGusFY+yY9ypM
         D0uA==
X-Forwarded-Encrypted: i=1; AJvYcCUR4LknsPaXVrlglfN8q1JhlUhwI7MVmzX4JD8cGYZ1Xfpvzh+aXg0DICy8UUTWLwxs1cQJF0QP8kWvkBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7rMzeoPgl+aAZY+R49CQa4DE6lf+rQVtfFLnufSTvBb5Dxhpy
	24is1PEFweqv7pNgcfxPYyL1xlv32HneamrPtXmpZ43R7S/ei818IqC7eJaveVhQQzytTL6nsO4
	gq4gffUk6xSv9hRvqlVZ3OucmHS66HTgoWs24xQ==
X-Google-Smtp-Source: AGHT+IGVWKFrtsCq0XAJNDTpJCkeUpuZkVj85lqCpCtbm1eC6mA7YuhdlDQM5pTaOZwXdhStu1bIUwPbyKm4Z7k9kso=
X-Received: by 2002:a05:690c:67c1:b0:6d9:90f3:1a79 with SMTP id
 00721157ae682-6db451544f3mr141002197b3.32.1725881111691; Mon, 09 Sep 2024
 04:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908-adreno-fix-cpas-v1-1-57697a0d747f@linaro.org> <c77ab7a8-49aa-447b-b7ac-18dd5c2eeecb@kernel.org>
In-Reply-To: <c77ab7a8-49aa-447b-b7ac-18dd5c2eeecb@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 9 Sep 2024 14:25:00 +0300
Message-ID: <CAA8EJpr4sMEmywD3qO8co1ZN3jG5w=dsfDYYmY90baRne3dHSA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: allow returning NULL from crete_address_space
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bjorn Andersson <andersson@kernel.org>, Jordan Crouse <jordan@cosmicpenguin.net>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 13:34, Konrad Dybcio <konradybcio@kernel.org> wrote:
>
> On 8.09.2024 7:59 PM, Dmitry Baryshkov wrote:
> > Under some circumstance
>
> Under what circumstances?
>
> This branch is only taken if there's a .create_private_address_space
> callback and it only seems to be there on a[67]xx.

Existing code doesn't. I stumbled upon it while debugging private
address space translation. And that's why I wrote 'it might be
required' rather than 'the function returns'.
So yes, there is no issue with the current code. And at the same time
not having this in place makes debugging more difficult.


> a6xx_create_address_space returns:
>
> - an ERR_PTR if msm_iommu_pagetable_create() fails
> - retval of msm_gem_address_space_create() otherwise
>    - retval of msm_iommu_pagetable_create() is nullchecked here
>      again because we apparently we want to be double sure
>    - err_ptr(-enomem) is returned if allocating aspace fails
>    - otherwise aspace is allocated somewhere
>
> Konrad



-- 
With best wishes
Dmitry

