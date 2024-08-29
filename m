Return-Path: <linux-kernel+bounces-306482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C95963F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97CC3B233DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27E2219E0;
	Thu, 29 Aug 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6XX8EgO"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E257189F41
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922838; cv=none; b=d1bA3uTHkgFl4jX4UlcJAlb59ZPt3HA1rJGi1L2ir6346Xd4lye5ytmL/uOhR24+rC3+mGYZ44rOldsaAAMjJYFQKcVP9Gv3HkMd/KpuawZu3E25ba8/8a38dK0rJr/aS28PSZmTlUEuHcFEgcFF8XuuWsOeHGzaFkMt7yt0F+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922838; c=relaxed/simple;
	bh=9z7glOF5aQ8L7P5cXcuB4MT1+GrbVwchTlGtyPbx4sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PonHTN6MWGvzWafQT1rvNCvVLuz8Y3ZuQerYX/+bC/qOtHlqGp1QYXVhhItDAubRFv4VtBGZr9cLazLs0dqKhRQnFqyZumGDa8HIr+2V8pkd/08XjoDbxeuHPNpfzO7cOfZmvPnBfRipF4FY6I+U7ydBdegSfWVCjx9Lur+zMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s6XX8EgO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so4923981fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724922834; x=1725527634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lE8P44IgEXQgLAuKYiFf8e2mPh9BhaeyiUVSH7zzHfY=;
        b=s6XX8EgO1aWClV0VCCx/AgYjHJrLlAL7X462GWiqpvZcKkMWTfJ+E0JuaM0UN2n9VN
         b1qTX2MvhcLSJ9gaEtUnd0GTt+gSHDi6WnxVE71ONiA1D/vlNrAbJDPUcxFEJFY+hUOJ
         Q4+hVlODb/a10XWs30noRp6cfmVkQLKQVXeTPQJdCgMg+jMTI0b88B+Ev8dU2TIIUkVZ
         S8hK3ClTRb1r0zrTuwovdaiQKtJ2epVSGCY0QBOgPVVtg3v/Pp5tmEKDC31BzYJ4I+/8
         I2YCwX4Z9J0ngQerGWIf0/cdeSOZ7trp8fKKaYKtFfz8D5xbADTx+nrGVEmnTa2Jc/US
         6R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922834; x=1725527634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE8P44IgEXQgLAuKYiFf8e2mPh9BhaeyiUVSH7zzHfY=;
        b=gGwTjGVXzE2ylfu8pysKNCgoQEAhMddsxAagn0TLXO3WSkj6Std0+IBGtzIblQ8ofT
         tGSTcNpg4jzWMmmS1klPCXA/yZxPt2A9daq9zKZTOfXFCh/r9I2UGhFw23dyUkXk9Ati
         lucORNKn1Iipy8N4nWDm7TenO5RLOE4PZLLwuRWrBocWedgQZSWNueZkN8PWhpj3R4wE
         GZHDozUDnXxRt4czO25OoAfOUPRNXs1LFjJH2hc3ZSIWmowom2MpADZen3jUtKIbjj1S
         8Oa9ROVIjWeyi96RHjTT8FEIF3Sf93lsj3nZ8EStik/g39iTObcum/pzNFShLahrduMS
         Dnpg==
X-Forwarded-Encrypted: i=1; AJvYcCWuhJQSrBZdYJOcF0GSM+zrbAtRFwyVayrm76koiwUWUR2TA0M4TVeT5ZhCRCl3e3USYejUMw9YWqt9NGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwiw6W9s6Ql5We++ySRWAk0JE8OVjLNmsXjaczPeE2MRfcCuLn
	BgoOQrYjIYMLUfjMQOlUOugv//H+9vkHKFD6AZKxvYA9yXGRvQJmQikSuBXeKBDZqoJFJTtfyO9
	+
X-Google-Smtp-Source: AGHT+IEDf7R6Hp7cY8yLxdcEzp/MjRBM1Q8yy0a+0DWnkq+fkdeuUHk+jFQ0G9E9ZjsvU/viYUuW1A==
X-Received: by 2002:a2e:be8d:0:b0:2f4:84f3:120d with SMTP id 38308e7fff4ca-2f61038c67emr19018551fa.8.1724922833704;
        Thu, 29 Aug 2024 02:13:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615195484sm1235281fa.137.2024.08.29.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:13:52 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:13:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: quic_dikshita@quicinc.com, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/29] media: iris: add platform driver for iris video
 device
Message-ID: <zfltcl5x4hol2foftyvr4oigxus4hnequd74zi7bdd7tsdv56q@3nphukr4zgmm>
References: <20240827-iris_v3-v3-0-c5fdbbe65e70@quicinc.com>
 <20240827-iris_v3-v3-3-c5fdbbe65e70@quicinc.com>
 <74126160-57f9-4abf-a26c-3491c8f3dd78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74126160-57f9-4abf-a26c-3491c8f3dd78@linaro.org>

On Tue, Aug 27, 2024 at 03:08:03PM GMT, Bryan O'Donoghue wrote:
> On 27/08/2024 11:05, Dikshita Agarwal via B4 Relay wrote:
> > +static const struct of_device_id iris_dt_match[] = {
> > +	{ .compatible = "qcom,sm8550-iris", },
> > +	{ .compatible = "qcom,sm8250-venus", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, iris_dt_match);
> 
> The enabling patch for the compat strings should come last - if its first
> then the time between the compat add and the last patch is a dead zone where
> things are bound to break on a booting board.

But then it's impossible to test the driver in the interim state.
Moreover enabling it at the end only makes it hard to follow platform
data changes. What about adding sm8550 at this point and adding sm8250
at the end? Or enabling qcom,sm8550-iris and the fake qcom,sm8250-iris
now (and clearly documenting it as fake) and as the last patch change it
to qcom,sm8250-venus.

-- 
With best wishes
Dmitry

