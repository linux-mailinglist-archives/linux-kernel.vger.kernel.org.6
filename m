Return-Path: <linux-kernel+bounces-306596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFDB9640F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F8FB2523B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61F515E5C0;
	Thu, 29 Aug 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWCODiJe"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345518E02F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926170; cv=none; b=d+QnOEDPccN95LG8P7E6pBTWoKPwtUjA8wW0mLGpCt+5UNHRB0bmOMwojRhDrWdykOQxIRA4tTl6ggchAO6jMsT3vSzrUhOY13D2OAN4fSpfcqVOek+FJ8BH+Ak6yJjJR6P7UXgCJaH23nPb28/GWf1b9hRLsK7x7M3SPb/1YNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926170; c=relaxed/simple;
	bh=92ByrN5d8Lg+NWMwH/cCUk3v7BuRdfpvo/q/AI3YNyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPeNrxREx4XKJMqbgvMaA04pZJ1/7PUlWFird6WitI6htnjIF+zxEdjOg/jG7TwNQ0bSudXU6IYb8PiAmBKR7u3IiOpsyWy79yBJB23Nrg3a5P7h36hN54BCCaC/sJdTICsJL1Q1XkLPntvbBD33QUjO7sbbG3vjmjQehOqSCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WWCODiJe; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f4f24263acso7088881fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926167; x=1725530967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7u53BKBtP5gVlCvhU9dT3HNJftitXcbCrItbMCuXjo=;
        b=WWCODiJeUr2A9k7V1Im4ivCTA4Cve50pJxskiKfiQc5kqG7fLaxj1xYfELiqeWjNLF
         45cs6Jr820gA8iDrGQhSbikfKievZKAvbNo2HCDH6+j1Jw/abyZmkNcxQFCWpCUEvFVX
         7JVs78zVn/0UNGNWh9L3qOsO3fptKDFXyCJx/RU/3iP9snXmUNLXpPExRvK9qav7vLwz
         q2xOL9WRTXwAj+sJzeseweM9zBpLfRCEn1rs0nARU/t1W0KIoP+9psdpemaJVuy0o3SZ
         +xzh8lBZKRNCaOOA/z/zChuVLBHxuvuY1dvP+kEb/iWkuoHAkompg2MHYMNqk8eO/VYT
         SjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926167; x=1725530967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7u53BKBtP5gVlCvhU9dT3HNJftitXcbCrItbMCuXjo=;
        b=QGeur0iUm8Xc/R8mTPxafENHpMECBKHgG7/kgswfXfwM3cGdEvc3juQZOn+iO7yZSy
         YIsY5Olm2iOetZqCmSEj30NXSWiR0JeqfLPRzmuzXgWUZ93hLozaOwAUL2X0E6bqbAFJ
         bo+m6gHMQTbg4sAufP2ryp4qLjW3MsPrm/WZE27TZQs7qtwPTznb+ZpaLle8y4n4bYOn
         joUcA737DxBci++OCK7ZHSifh94bZELrg7O3InxZisMGd2tRV4Fp31dVkhcI5Jvo58j0
         ZqUa6LBELHlQG/8jEz9Y/yb7XjcXnvcbzqoH2R9zloSYMgQ2M2zt+DkyRxw8kgt/Q88F
         0htA==
X-Forwarded-Encrypted: i=1; AJvYcCXrbcNQ4B8kdzkzJQsxW1JgFTm2RSrJ+f9LCcRf5foHEJs/4HBUyW+RNAwIehZTeftFPOOi3t53EKk+QhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFL0wH1Xs0Js3oJsSBAmxTt0ARrkZbYkH88IYGoYLMzJG9V+LN
	3HR3q8piWexeuyMQqAU5DieffqSdrT3gHcXbiX7eJJBhAi1BgDURWVURQzE3Wds=
X-Google-Smtp-Source: AGHT+IGWt0QjEbulCmHcESGmd3m1Dusiu+1cC98QtVv2Lvh3qTNPkofKZb5d7J1AVPjx0jBydRHytQ==
X-Received: by 2002:a2e:5119:0:b0:2f3:ee58:eaf with SMTP id 38308e7fff4ca-2f6106de016mr17131721fa.23.1724926165948;
        Thu, 29 Aug 2024 03:09:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615194f2fsm1365101fa.134.2024.08.29.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:09:25 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:09:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: qcom_spmi: Use of_property_read_bool()
Message-ID: <6cqvluvuogkrx77x5q2neobxa4bu5tfxocdbdd6hlydqqqj2j4@opaxs554ehxs>
References: <20240828130056.3481050-1-robh@kernel.org>
 <20240828130056.3481050-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828130056.3481050-2-robh@kernel.org>

On Wed, Aug 28, 2024 at 08:00:55AM GMT, Rob Herring (Arm) wrote:
> Use of_property_read_bool() to read boolean properties rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT property pointer which is a problem for dynamically allocated
> nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/regulator/qcom_spmi-regulator.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

