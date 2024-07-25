Return-Path: <linux-kernel+bounces-261860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E431A93BD18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228431C215DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1304416FF4B;
	Thu, 25 Jul 2024 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/Mpx76N"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B031CA8A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892411; cv=none; b=g666TPkSNS8qlUT64SDtRbj3HaQBdV214HoLc/DoJdD+QtNGNncxZhnXsQ73KI0thvFvQ1kbFYPJxrQRWjUEK2JbvEcccqvCgQMfgUa9BSJZuxIi7qlfYUdrw5CqW8cN9V5x/L2SLRRklV7dxmFPGCF9Edtcfdpp8UYaj+sdoDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892411; c=relaxed/simple;
	bh=tKPefqgTDnup3MvvY9fJp6KP28+Qto27xhG7wD/859Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQLLdV8oucncJ7akykLZyCU/MD8p8vzyV7dFlmMvTFWPXNCTA2F8jKTs0+lpjGF6iGIYjHP7DWo2inTgDOmguQS+BVMF2eB19L9bSVJ8dVK4IEQrXGTmVkPwr3EMN4yjxmufcnK0Di90W65VmcQe4/kVC/54el6o3DU4vCgYQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d/Mpx76N; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7515437ff16so472995a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721892408; x=1722497208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3q5HcmtrWAnPNTpXMegj65YWsUrKJvUrcP825ZJd0RU=;
        b=d/Mpx76NEjTiON77vp/vwVlkjwcgjkBZZeHpaM+nroEHsR+SNODOXvnJFinmqx1/85
         coQ4J32JnxKml01Yux1hs9e9LysV01LfFUXrf7SWjfDN3dvkkh6TvyymtFQ3zADr5PVF
         BhdeGpCCBj+gymKXdCyjECmbzOt0YBJtRJP01YdaQq3IcXFTR42K5iXRDpClNzg97ON5
         zSsI1guFPOEScDvo9I17n+YdtApe362YVL5YJHnc3AkaLTcpfcgxU5VmiZgejbXsb18X
         r/kAAcn9GFa23uTHl/z0cuBMLEtCAnJQIXpRDv3Rd+fE+eqzQIA0fXrCjqCVJBgqKoSD
         3pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721892408; x=1722497208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q5HcmtrWAnPNTpXMegj65YWsUrKJvUrcP825ZJd0RU=;
        b=p2/z/lek55EDSWefCEQHFSpnf2hQ9A7xlV8e1eJnSOEc4kX3Tw2JvdguNK2LnmG81l
         0av5szhnE0WS8aNeLj8VMpwTNgWgwvcnAn2rfdqjmqMJaWG+yJk5Oqp4DkNC+HK24hzp
         W+HjlBoKsrTXr5hH9oidkjrkqg5PjQcyXxC2ew/lPMOI0eV/Fgdse/eCl2cALOtJoqcY
         yRcUpscnxy1ohmielsn66hE2rBhLhz1JaFEHyTtIn/mFGjqKqd6e/tpXCg/E5cJ8QjrM
         qZxikpHAy/E5wpHpS43h7/JfFVCMh4bX07qD4N7MbUC5Zh33lPH+MbuGhz0xYWKRuYk8
         VxIA==
X-Forwarded-Encrypted: i=1; AJvYcCV+FlHKBn/SIxcb0rDcgbFW6Vn9B+5gx4YM/wfbBYUBVqdziUCmeu3DuIRPQI8Vh6Bbf0ilRE1K4qNAQx9+X7C5whAJWi9REcA9tB5Y
X-Gm-Message-State: AOJu0Yw47138tNc1LJDVAKt/KkeqJTzw25G6JCR6byEammpkro6JSgG+
	a3mDRvBAFV8qJuzZwqFDCqFw9bjJEXwJJ8I467LKYUNmA2nwRpF0eSXFx7bqOok=
X-Google-Smtp-Source: AGHT+IFf8IuRqTdvt+rSkeNwKKCpAbrFn5dG1AnuJJx6iUv0Giio0LguW6Fgk1lAv6cI7r6gAcfloQ==
X-Received: by 2002:a05:6a21:2d08:b0:1c2:8dcf:1b8f with SMTP id adf61e73a8af0-1c47b16661emr1239292637.7.1721892408486;
        Thu, 25 Jul 2024 00:26:48 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cc4912sm7592335ad.69.2024.07.25.00.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:26:47 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:56:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] OPP: Drop redundant _opp_attach|detach_genpd()
Message-ID: <20240725072645.chmy2wp7khdymm6j@vireshk-i7>
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-5-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723144610.564273-5-ulf.hansson@linaro.org>

On 23-07-24, 16:46, Ulf Hansson wrote:
> There no longer any users of _opp_attach|detach_genpd(), hence let's drop
> it along with the corresponding exported functions.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/opp/core.c     | 96 +-----------------------------------------
>  drivers/opp/opp.h      |  3 +-
>  include/linux/pm_opp.h | 38 +----------------
>  3 files changed, 3 insertions(+), 134 deletions(-)

Nice !

-- 
viresh

