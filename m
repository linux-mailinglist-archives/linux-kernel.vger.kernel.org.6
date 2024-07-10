Return-Path: <linux-kernel+bounces-248401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6292DCAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21B9283DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE5A158861;
	Wed, 10 Jul 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzTmjHKZ"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8ED14A4F7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654352; cv=none; b=BuOrm6F+DvZN4gadkQb5FOHHNvcgmoMQh3P5LveiufT7rwQCOUZdy79SHZ50byBJlucbSepP26LLMwUA2S52IuXNRzIFDnW2AvKsVWUzpiJWKmapU7AGjw4RYlRDEPkCvrKiU5G/OoL6kqL9DXAQlTBToCuaKyLtOHlc5ATbC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654352; c=relaxed/simple;
	bh=4FdwsEGiRMoCwhHU6QcTg2CuECXzaFgQHhZDwC24/Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxbaY5YmwY2+41huisyV3SozyGfhqI1azp1DK46PKMahdmG00m2ITB9342Vlr16FxnHeCtlRc/SKAi/JeoGBQU4fOKs9bVnP90aDGdi97snV8P4EzZt+4cYLmJlmneWIKsCsfjj5zNXhCELkMGPMR2LUqrgVPtmWI7zGZTF1Emk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TzTmjHKZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-64b9f11b92aso2811947b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720654350; x=1721259150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=thSpgyoIxZwTvukwE7k4RFixN4nw/X9gAyNNLGSzrDE=;
        b=TzTmjHKZPrzD87yB9EefxCCkm8JJYCE1dBj5rT2a9i2kyg9aKGK4y6omqTXXfPMkdr
         CMOOR3bxpZK1d1JXvzshI52huB+nZYn2G02QEII31K6T5RnGvFD0zJXChnb8uJckEu7y
         t9Yv09o8acvIPbdEDV2H5SDfTLm9XAShsAiijyzNVpAP1lyBaR/CSn6ECi6J7+m/rJiW
         j+MmkxP21hfhLGcPlrimZPYImRSAtk4M/3GqMIpmECmVE6nRZ7YDRY/55ildr6XGvsH6
         ybGINoHLH/ikmXiWzHC4JlmpliKoNqhkQbV6yWp0wh/zvn0ih4m+j2gfYo0k2yQVnJhb
         kJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654350; x=1721259150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thSpgyoIxZwTvukwE7k4RFixN4nw/X9gAyNNLGSzrDE=;
        b=i2U+8zyrUjC8ZGrRd/BfTBihHWSgRne9cCAxaWfzrCZTwkhZmqsrR6+Ji1wnljDleJ
         a2Nfe4irZS70/8pDYEdJY/rlL1WKOTraitB7lrVYgPhjhVLcEg8BXikvctn5ahza0hJh
         +Q5RQVe1rrG3GYrGWdDcQGjmdoROK7gJxXEcbv/nbp8oEFD3L78FxFNVgp7rCMVjxB1q
         tnir5vffOiwfdzfmMZvo4BJqwlHxPhgpkQpCLBivSGBgnqZk3TMgz6bHog7VNBGiXk5S
         eJy6sgnQOPFMasRMd1KIKjyM4b82paJEmdOplpFhfw3trV5p1prZfBj70ZRdQbevtf5t
         Zp+A==
X-Forwarded-Encrypted: i=1; AJvYcCVedlu8ChdGXAuyLscv8IwjmB2hCxfpWhEyqS40eILmAI6TNzf6te4v0I6UkNMfPMC4/l1C/wyYPoK9vN7lHD6r2Kuk370k4iXCm+an
X-Gm-Message-State: AOJu0YzantL96kRtLCCC3GXIcB+rvHy6OoAYsPtGHEe1cNvO75EVPfei
	yfbRO0kAsoH4Qn6ko8ndUD6gPUgz+C9SgTmQJAYxAKxHSbR6oYNM4AGy79/WNyuK61/SVbU177E
	fr15M/dJUpFxR91slYWL9tM2lBvVGGvtRKalbBg==
X-Google-Smtp-Source: AGHT+IGgHYRsDbF+YAR3hcp295QaCBJP6niufixwn280tob0vpK4rOgKG8oJ2up/aO2xesPEbAh0L2iUITeWWszFyjE=
X-Received: by 2002:a05:690c:6383:b0:60f:ad5f:f889 with SMTP id
 00721157ae682-658f0fb3403mr100251097b3.48.1720654350073; Wed, 10 Jul 2024
 16:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-gpucc-no-request-v1-0-b680c2f90817@linaro.org>
 <20240628-gpucc-no-request-v1-1-b680c2f90817@linaro.org> <5153b8f8a6c6ffdc1254e00c47a888ed.sboyd@kernel.org>
In-Reply-To: <5153b8f8a6c6ffdc1254e00c47a888ed.sboyd@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Jul 2024 02:32:18 +0300
Message-ID: <CAA8EJpqOD-JKGCJiC7yAkiG3oAOEbHQ-_aCmDiP5HdeEVZm8fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qocm: add qcom_cc_map_norequest
To: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 01:30, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Dmitry Baryshkov (2024-06-27 22:20:22)
> > The GPU clock controllers use memory region that is a part of the GMU's
> > memory region. Add qcom_cc_map_norequest() to be used by GPUCC, so that
> > GPU driver can use devm_ioremap_resource for GMU resources.
>
> Why does GMU map the gpu clk controller? Does it use those registers? We
> don't want to allow two different drivers to map the same region because
> then they don't coordinate and write over things.

It's not that GMU maps gpu CC separately. It looks more like gpucc is
a part of the GMU address space. I think GMU manages some of the
clocks or GDSCs directly.

-- 
With best wishes
Dmitry

