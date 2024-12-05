Return-Path: <linux-kernel+bounces-433113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9D79E5402
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86C11882B80
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBA1E282D;
	Thu,  5 Dec 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPdiy+Zh"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CF80BF8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398347; cv=none; b=PSedU/Akc1ws82cY6fRAAaUYuUTYGtFVs8xD2Ome/WwZ0aLy0HsW5RKkHWqaVH3BndTmXinSOwgG/lDmbTut/7ky+WQ5ci37fKYRENra8fBJUVNgu3YQQm+z+O3Mt8eXWzxJUAb2G1xIX0ZO5DRARNi14cpUJORTrl8nHGWEL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398347; c=relaxed/simple;
	bh=pHj+AOu/b8zqHHui/l3LSsQltahbnfgSfiK/KVltjz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IygMF14w5R5qkqiEmdRCGTnQxNnZn5/OoNqNQJgeqPhZGCpk0arHEkp50Z53NEYz3SO6wOhlz1dVWgfwsm46Sdqh1qsAKEQ23tyUa1QcRJttgUus8oCLsmyvQbPQmRV6zqqP/Ny5Yz1xN5HjwJtzo2g3PuGihmoiF2KNHmWMy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bPdiy+Zh; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3997835700so774427276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733398345; x=1734003145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G5K+z1ONa1RR9Z9IC6HhDI8iNZ342Y9IqNJaDLuBurM=;
        b=bPdiy+ZhQPzO7nHntoYSM3SJoFS+tqUTGwNHek4bxkKdeKB/x6wJvjrA9pOhY5bWwF
         X+1KR+v+z3FngO8oPhWD+nk/luXHkfPj0Hykl6hfzaIz7GTEHF8aw7s+TyP4rntLs28h
         F9efJFW/2h0QsaP0rHO7DPDffmajQhbFD4rruWw10+mo1OPU5q97LwY6TbSen+yuVTyG
         yGzahM637hSzgJFw1yaF2bFyD5V53cV+h+jyB4QMkCf0TxsZWW0nqTgLW9DUXXJbEoWW
         HZVZP7081hNZ0Gb9CXezfljIotV4QUtQjZbP+mnF71otQt4540Hun5gBBc+Nwe7a+w+u
         Gksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398345; x=1734003145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5K+z1ONa1RR9Z9IC6HhDI8iNZ342Y9IqNJaDLuBurM=;
        b=thll+Y9QeqCMi4w3v2nBX/tJ9jgnQ7RfzhPGig5MSy+2SHCUUxgu/RuJxQ9aEPpDS2
         DT/eBWo/7KfUtXz2apTQMk/ysF/9TNBnoZQzqi4ACKq+JmdqqTslWtvEangJKrlcKnIt
         rzZLDD2/xbEQWeInFj3295q9HcZFvZMmhDxJ4CKS4cANCcjmcbydLL7S1mLK93y6/4XF
         Y1MlCozbn0qzvmF52WoixwcvXf8KVitqM9wWcRyPhK32XFG8G2wq79/u4xzwjznPMRpR
         djJ1Wntd6vEsUOubEwTx0ERpQkUtnZepmXXZRek9SAgfeHWQIF27niz+mOvOH6OTUGH9
         pglA==
X-Forwarded-Encrypted: i=1; AJvYcCUMa+jLg8JcaR06/RJNYOJ6F4RhnG9vnYy8oet+QskWwHewUcuHItLviGM3UhiA24ocaj6T0rAS8rXj3/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytgbgte4yinC9KouXTc5AjxG6eRUBBo728RCKeSJY2s8XYzN6/
	0zxh1LUBSxuDII6S3MhSHI1L4Ri7xzz7UOnsI+GR/54UeZNeGf/2qwVKoYk3t8s+dLzfj8/sKu8
	s2j8DU2L6+ohb39Bj3pDomFAtADnQo87LgS4WXw==
X-Gm-Gg: ASbGncsi7da8xOC3H1sGAh0w8Et6k/x4l9qwqV9i5Po8uvI41HmFDP/h/plnBG41sXZ
	8MEGK3Wu+uHfGJx5HusdW6CsCxspItg9YYr5JJtk3b+rrFA==
X-Google-Smtp-Source: AGHT+IHjmMNzBozE1BA+ZpJB22O/URDVrP1u0WuP4Fn3l0waUtFl3sNfAQKJTRUadOC35vLb1W/MstA1KNP3iqlfMnA=
X-Received: by 2002:a05:6902:2688:b0:e39:b357:cb15 with SMTP id
 3f1490d57ef6-e39d3a279demr10425188276.16.1733398345153; Thu, 05 Dec 2024
 03:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com>
 <20241202-dp_mst_bindings-v1-2-9a9a43b0624a@quicinc.com> <bfa857c2-cd74-4fe2-a88c-3b35a58710b0@kernel.org>
 <gpqrugcsyhz32bvip5mgjtcservhral2o5b6c5nz4ocwbjw5uo@eypv4x6jyrdr>
 <hqe2pipkcnxftoq5mvdk36xmkj3ybr3oto6eghimq75rqlncsm@v45smglhedy7>
 <pxi2nf4h34xtkickkkuwh4svvhbtsutuz5u3ukzgfgd5rzzcps@g4gct5zuc6kj> <2ef59c6d-bef2-4763-9463-06116a2e7d04@kernel.org>
In-Reply-To: <2ef59c6d-bef2-4763-9463-06116a2e7d04@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 5 Dec 2024 13:32:13 +0200
Message-ID: <CAA8EJpotUkPWU4VTmtaH=XkhwPZVXfdU8ZyHqROYpZRWDdYPSQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: display: msm: dp-controller: document
 clock parents better
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Mahadevan <quic_mahap@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 09:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 04/12/2024 11:09, Dmitry Baryshkov wrote:
> > On Wed, Dec 04, 2024 at 09:02:18AM +0100, Krzysztof Kozlowski wrote:
> >> On Tue, Dec 03, 2024 at 03:41:48PM +0200, Dmitry Baryshkov wrote:
> >>> On Tue, Dec 03, 2024 at 09:01:31AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 03/12/2024 04:31, Abhinav Kumar wrote:
> >>>>> Document the assigned-clock-parents better for the DP controller node
> >>>>> to indicate its functionality better.
> >>>>
> >>>>
> >>>> You change the clocks entirely, not "document". I would say that's an
> >>>> ABI break if it really is a Linux requirement. You could avoid any
> >>>> problems by just dropping the property from binding.
> >>>
> >>> But if you take a look at the existing usage, the proposed change
> >>> matches the behaviour. So, I'd say, it's really a change that makes
> >>> documentation follow the actual hardware.
> >>
> >> First, this should be in the commit msg, instead of "document better to
> >> indicate functionality better".
> >>
> >> Second, what is the point of documenting it in the first place if you
> >> can change it and changing has no impact? So maybe just drop?
> >
> > So, do you suggest setting both of the property descriptions to true? Or
> > dropping them completely and using unevaluatedProperties instead of
> > additionalProperties?
> >
>
> Dropping them entirely, without any changes of additionalProperties.
> Unless this property was added due to limitation of dtschema?

I  don't remember at this point. I think it's worth trying to drop them.

-- 
With best wishes
Dmitry

