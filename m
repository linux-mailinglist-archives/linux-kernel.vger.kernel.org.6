Return-Path: <linux-kernel+bounces-301338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5D595EF39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE2B1C21653
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43A2149018;
	Mon, 26 Aug 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CK4rT2NN"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808014A62F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669893; cv=none; b=UeWlljVhZ0ROCeNKIiXUkmkyRlJUoTZOj2BWS/N4L7axNT4pKigXw1CzKqjVKnKRazQtf07P6kIxx561+c0LCSv1dc7MO8SrvUR83EmkmE6IZAHZJsXLc9FN36BDbc/WqroFMY84mMI+7nQB/DaKncuPqzk4u4jQBZixJs9eyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669893; c=relaxed/simple;
	bh=QC7VwQuJB/5l0CU6BD48w6gCoD7W0PbSBPqplj4TQWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPwPbey06wG7n+1eL7yXTonQr+G3pJDtTR89bGw1Sm9jjtyvaAk2emseDCtjOgKpilDgk8L01KE39kCxgMyNviIkuKgT3hdYwx9w3LBMw+SAonpASNzysSnWn76r1ZIIfZHUscrYdmlXirAPoJIlOqmDjVyupA+dE0imcFiVs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CK4rT2NN; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e116b591e15so4319293276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724669890; x=1725274690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZZKCO21at5/MyqKMMDZApnx5/eMSgR7MnutvBDvLdo=;
        b=CK4rT2NN8R0IqB0s/dIC2CIcmCguOm8j55tpsluSbXYnf7pXMPcywLC1lztD0cWUxs
         p9TssGpwvOSrVtdzl1++vk7pbI/biJfk09y8ZQG3SHnWeMvi5uophoZF+iFPbF6ru5xV
         U/Tz69BSTs4b+d0aYOgthX6eHKmTX+oMby3jxiEgx18cFE5tIf4KzJlfi/9ygafuTm1B
         mlTHJz8nFfOIAVzVcExbLL77D/133vnbvl4ziWsa4CWAlSUeOJXiD8UM8HGrpRNSdhYR
         DKaEz4bv3zMilmVf9DMES5COFzw0L4zlK3ETPhAfJDBm5z/CCv/8Hj+bSFkIhVS8q6Ot
         ileQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724669890; x=1725274690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZZKCO21at5/MyqKMMDZApnx5/eMSgR7MnutvBDvLdo=;
        b=t4MTd5gHvLXtIFV1yMc6tvKz/evOOXQyumR2UoCOmy2lvcZuWwoX7x+PsBGdcz+y6S
         zUqQtt7NpMJyBWDgJdMmp6EHcL4fWW3toUVIwOZ/yjhZRx7y3Ixx61fyBIoYLIbV7JLH
         huOo+9d4AgWHVDZg/zu/wzmTxz7Sayb/VJyI7M01hIi+Mb/Zc4qwrNxEqGzWgzD1lLGK
         6UogGuVJyFjOyepXiwQIOrFT1TjGttp4jXxSs+dTOab61K6rckQje+csClKiPZ6KigBI
         yjdxJqvNbpbIalpf5a2tkguPOUnMxU1N9sUFNg076YigXSujqmHr6qSDdCtFY6VWtwox
         GA7A==
X-Forwarded-Encrypted: i=1; AJvYcCVXHQAyj8aoBpV0k37YfP+h0ZXW3OSxd97IvBKbq0Ekp0BMFjRUnqmWAnCbNrrEzRkxw0Q89qPcf80b544=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZBR4gOk4xq/hyq7+u6QOFz44NN7RFuUCV31cLyeFKvO3o/xIU
	iAgy5+guBBGSfoob2eQ3/nBdisaSwB/Ey3HsdBmQebxsAzvefcLi5hVMr7iuW9MiUlv8yTYsoFi
	ytgvos3622DFMJsxmENLoFejp7lkJ3wSbLFV3hg==
X-Google-Smtp-Source: AGHT+IF3U+OFtU37FMAav4du6kr3FKMf6WtkQ2PxskoPtPB7hhdtoR6+l20HZetYnYGy2JfwFY9nMJrD7s1BlWFutpU=
X-Received: by 2002:a05:6902:1617:b0:e11:7246:9632 with SMTP id
 3f1490d57ef6-e17a88bdcf2mr11272219276.4.1724669890377; Mon, 26 Aug 2024
 03:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822224547.385095-1-ulf.hansson@linaro.org>
 <20240822224547.385095-8-ulf.hansson@linaro.org> <kg3gfmh4vd5lgnglk7wzzullu7s3b7lpnh3czinmvpds2it7cm@bowytsfbzzvi>
In-Reply-To: <kg3gfmh4vd5lgnglk7wzzullu7s3b7lpnh3czinmvpds2it7cm@bowytsfbzzvi>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 26 Aug 2024 12:57:33 +0200
Message-ID: <CAPDyKFqZ9XXi5_-essaGbdWBDLX8uR5nO9vDJCExBGV+10KqZA@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] drm/tegra: gr3d: Convert into devm_pm_domain_attach_list()
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <quic_kdybcio@quicinc.com>, 
	Nikunj Kela <nkela@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ilia Lin <ilia.lin@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 13:53, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Fri, Aug 23, 2024 at 12:45:44AM GMT, Ulf Hansson wrote:
> > Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
> > and manage the device-link, let's avoid the boilerplate-code by converting
> > into devm_pm_domain_attach_list().
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v3:
> >       - Updated commitmsg.
> >       - Converted to devm mangaged version of dev_pm_domain_attach_list()
> >
> > ---
> >  drivers/gpu/drm/tegra/gr3d.c | 38 +++++++-----------------------------
> >  1 file changed, 7 insertions(+), 31 deletions(-)
>
> I'm not very familiar with most of the OPP bits in this driver, but it
> looks like the corresponding code is now in the core, so this seems
> fine:
>
> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks!

>
> On a related note: we have two other case on Tegra where we attach to
> multiple PM domains (drivers/usb/host/xhci-tegra.c and
> drivers/usb/gadget/udc/tegra-xudc.c). Both of those don't use OPP, but
> I wonder if they could also be simplified using the new
> devm_pm_domain_attach_list() function?

Yes, they certainly can!

I was planning to send a couple of patches simplifying a couple of
more drivers here and there (including those on Tegra), but I haven't
yet made it to it. If you do it before me, feel free to keep me on cc.

Kind regards
Uffe

