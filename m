Return-Path: <linux-kernel+bounces-249252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E2392E8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E3AB29BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7630415E5CD;
	Thu, 11 Jul 2024 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h78k90H6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF315E5DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703000; cv=none; b=lW2hQB+RL0sy9pzF2rAGJ1LeLwLUxy8a2G/RsERGKczIlTW1UAh7q2M2Y5j3cxQfNJyJHeRR79C54GSGlw0zNsmmkAMhKI3TIwdzfQ2pVdQgnQdfEaIjgCd4tT1tYyuVZQVuiUdS8k0S/HSwwDUPSaQFBUFX4kXUShgfU1YXbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703000; c=relaxed/simple;
	bh=SBDpIrGkZi9GohGzDpxipP4345aWgfJ+YlCcPQWVD2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRlOPkLLD7Rmhgzo7nlgPzRlIDiaIGfXhTX4aVTos10yRCgE1Sb7gsDImXKl/E6/be87j/mZxibtrSo0Kffr6Ahx8bQTTe039Fc2o59LhtPpZSMI95juHapUfCEOfDMTAS+hIXAJXIktmTr6wZX8YoqpEj0KXjaXleFcmKeTWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h78k90H6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b6003c3d2so545053b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720702999; x=1721307799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1SxUF24cDENdKat6hTnnuDpRbvWXonwGbP4sPkAVso=;
        b=h78k90H6Brzz7ai/Fv5fEl/LByCyDYIBvdgJaxOdzeGXJH4u6cA1GnViVodufPemRU
         yGSFhw6qrFGn2wun/T/CjS27fLv8ydb5VBLb2crYh4XzM1qWDqUuyWOUpGsKngICSarg
         +vFqHAHd6VweQxNWlSsHNwsMMrpa7AZd553W1IeB9R70xpdlFSrU8gVhwOhQ0m/+McXV
         mNGrz3tA5d4q6f/8J9u6WceQr2ooyUDvaQjq/9XrY/kfythH+B0z6OIbhUgUQUL6vKoF
         Iuh6qIAXlRai4X+bxpBf4k7HrXVhpznqQ67v4qM2srUs6UCQctKslegVgsxM77bg/qkl
         fQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720702999; x=1721307799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1SxUF24cDENdKat6hTnnuDpRbvWXonwGbP4sPkAVso=;
        b=Yf2y1sGcAO9zSLR6gmfDfIqZp2c9yj5T/t5f+7FkWCeHmzsSwKp35X1B5wYGJEzRpi
         ml4PrukSbgio7zNNh0q+Un7SydeB72507Ng8jyVkLuekf4r3xvs3wAWNc5GFm2E4PATq
         BOYo1jM+VhN57zrB5qCjSzKxJYwj/bnEaDdv1DPCkb/Sr/9hETSMTBjYnkbqa350GJYb
         mqfRwJavwVZHjp0bmUCGqhx5FeVA/xV66y5Q5D/KfsYUqEkq13rqLGNKwjlyDa5kQ1EX
         K7lZvEe+8fL6pYgkKMM9MxOc55fiGwaPw76btHUGvMjyHryma9uzA/opp2ImlSOJQLf4
         DwCg==
X-Forwarded-Encrypted: i=1; AJvYcCV3u/iZY7BEfLI6WY+eeJmAWE2DpmJPIamwUvklkArUUamBypYelTCrJcuwoImYtIXBB2mJDC5DSk/1yZ9OUNOCXjuXys0fvpI+zXYx
X-Gm-Message-State: AOJu0Yx7rAzMhNr1YZdKVfJdhex+iT/Ers82+w7oswbTKI5srEisP/yZ
	R+JOASzs7PvFoRmDXwQiHHXd080bbJcD77+B752fwql8Jz/ezzZ+Ka4V5vj8gRI=
X-Google-Smtp-Source: AGHT+IE+Rg45KLtzV1rOkgfVccRuVcNyr5UkUNEO3KxLYDkqocrAhzDcexwNdPD8SjaKk66mW7pEfA==
X-Received: by 2002:a05:6a00:845:b0:705:a7a6:6d11 with SMTP id d2e1a72fcca58-70b435ed145mr9569333b3a.24.1720702998413;
        Thu, 11 Jul 2024 06:03:18 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4397ee71sm5792853b3a.141.2024.07.11.06.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:03:17 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:33:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] OPP: Rework _set_required_devs() to manage a single
 device per call
Message-ID: <20240711130315.6xxlb53l5sd2cxwx@vireshk-i7>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-4-ulf.hansson@linaro.org>
 <20240626063321.3x4cvyj7yiks5f3p@vireshk-i7>
 <CAPDyKFqY_mNnaT8j4vCXxYtARkGb_bkvcwKkyXcLPwW+gutO8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqY_mNnaT8j4vCXxYtARkGb_bkvcwKkyXcLPwW+gutO8Q@mail.gmail.com>

On 11-07-24, 12:19, Ulf Hansson wrote:
> Unless I am mistaken, I don't think that is a scenario we should care
> about here.
> 
> _opp_set_required_dev() is being called for a device that is about to
> be attached to its corresponding genpd.
> 
> Yes, in some cases, we attach a genpd provider's device to its
> genpd-parent, but that is not to control the required-opps.

I understand and I am okay with what you are suggesting, we can fix it later on
if required anyway.

But just to give my reasoning behind that is that we want to avoid a very
specific case here and allow everything else. The special case being genpd
propagation, so I would normally not do a blanket ban but just that case.

But as I said, its okay :)

-- 
viresh

