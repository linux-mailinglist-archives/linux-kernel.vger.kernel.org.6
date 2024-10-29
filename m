Return-Path: <linux-kernel+bounces-386367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0819B427B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8751F2348A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D2201264;
	Tue, 29 Oct 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="faX/GEw1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7747201253
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730184002; cv=none; b=OkCn43i0gklIhlkO0VaV18oxRfEjrO7Oqc1PMy7Aq0JD/1UaJpFpwzSU7SZG74RoKthsz7YDEZjDa3nNLa9VyKSWiprNsHzTyOGYYq7K6PPl0YuXarMKjeAtlTcs8kYo9T5z60Y3s41LVz9ular0Txy9SotF7spshc2wUP+p+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730184002; c=relaxed/simple;
	bh=H58uJcpRDNvTax+VL+0+fCFLwZ31eZ9H75SsdG6oUmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pax7w6qa/FEsMvLDNX4MzP3wdbmmgO9wza0p8tBJSCIhduzyE6rH9XW/i44ANy5zfes6SoCvE4DD/J1t8BE0V6b7MLBXoJ/2Xzv27B2RgA0wdkdcDT28RHleU59K3p9V4DeYdZ80WJ9llZ6udQ5egHtYk0V1sFu7dBIJ2jsN12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=faX/GEw1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-210e5369b7dso12714155ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730184000; x=1730788800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmrD8WpF/OdMMrOZMzCUFVQhEI48ibTQY3atQcEu4nM=;
        b=faX/GEw1CkTrGuA1atfeUO4bC2e6YNdTUbeYFgX5adAKHofUoHzocz0HGqw1UvrPfB
         v3jz42lb2BJ2BUHyLVCHJI/I/zIDNzkyJ9SGPHwbDijTKwFhhTlpnYwh6e+5djHQzcmg
         9LAM+Rx82aEOFenuFe6MGKcJDuC59d9WH31O4GspuXz1RtnFijXmtQ8hqYsdzxa3rCW/
         CTPzozQk2Fp/GyZPq6ixLlvs4DgJ5brMadrNBjtmcaQCmSOiyl+0Hi7FvnBi2b2VwlrY
         xVeeiH6whM8dDOq+xu9IBwBQ9h8ojwW0YmN+kkvx3iujLVEODrq/kNpFXSZdCliBrniI
         qfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730184000; x=1730788800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmrD8WpF/OdMMrOZMzCUFVQhEI48ibTQY3atQcEu4nM=;
        b=MokP7tLTtR5sEtY4uE5cClGnW0YOjzFv99gw0ROxb4kfGR3IzWivT5IcyPAv5Vf/Yx
         +x3p54Ego3sJacSuUZw4sh+Dj1BJsoewUVAfI1EQct8RdBxRxbsmW99x5azyuiSxeWBM
         GvK8MKCwKEVha0JFJLEVVKW8StbpJUHDM/YvcPUzJJZx7YVrh5ked2Bdw/gdn1Zk9tHQ
         zGwGbLxknPOWVoD03HgyasWX/ZKSVYDxFS7B9AwjFjvISDhnxacHlJtcdrjwCtQfWow0
         7j+6yBnMjkRJ8832ZLq4DZJRMgbsvfr1Gt+O/5dx33OhQuS6RWCSI1Z62H/MnqNZ7IR6
         lwgA==
X-Forwarded-Encrypted: i=1; AJvYcCVVyQg/8/OzKa8pU0sXvcISMIuHMHwjpyXj8Cpt/JyrS3k3g9HGD2jYTzlun8UqnG//+CC/NbLnoVSi6WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRntQ8GDSHEMT0zC1tZCDZGnqXAihZ6UporCVvwu/79lELjRfg
	RcG3g4xlSP/4huOInah9zX2EQanFXyGKiDug30b4meOEiNNq0hFRMGUd4DFWLRI=
X-Google-Smtp-Source: AGHT+IHvk9izIj+ZzjpdpqRGra6iF3H8KqUafcsWoWKS9IkQRHB1fwTjnsmShJ064C6yw8jOpQQVmA==
X-Received: by 2002:a17:903:244d:b0:20c:5d05:69b4 with SMTP id d9443c01a7336-210c6c06351mr149504975ad.26.1730184000220;
        Mon, 28 Oct 2024 23:40:00 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc066488sm59857175ad.277.2024.10.28.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:39:59 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:09:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SAR2130P
 compatible
Message-ID: <20241029063957.dszyl27kh52te73f@vireshk-i7>
References: <20241018-sar2130p-cpufreq-v1-1-822e00b9a663@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-sar2130p-cpufreq-v1-1-822e00b9a663@linaro.org>

On 18-10-24, 19:41, Dmitry Baryshkov wrote:
> Document compatible for cpufreq hardware on Qualcomm SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

-- 
viresh

