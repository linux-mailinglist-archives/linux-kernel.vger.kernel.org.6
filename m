Return-Path: <linux-kernel+bounces-219118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7890CA11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02811C233DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3AE158DAF;
	Tue, 18 Jun 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p15VSk12"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54835158DAC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709039; cv=none; b=k+2WtmwIk/R1i4/ydF8+myZaMLazFQUn+M3MyZJYjm9Mb0IDk82ONhq4Qf0+RpMT6MXsv1ZR/nMpBj8UEykJVuqz7NHyRuV+GPzJV51NZ28tPbVfzS8RsNGjB+F4XR0cfmRqtoGX4zqYrY2/uFGQHUWqYA0in51lHMFOdNSI1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709039; c=relaxed/simple;
	bh=QovKZmLzlBkSjshSMJzZuED3bDOaMvfHW45fNRxScUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTe/TPge7Q/HDPF5fjGNo2vKf4pi3hH3mIEl+e98EcPQR7LHtluMjvCC41FTFyck33/k94LPSe0EIWGJA0t3CwyzpP+SuLZ+R/NUyp3pg2TEeHXgMKLpp9jmArAPCABCN2liGCp11otACo/deepuy3jScYN0eHI3xTFBp/CWqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p15VSk12; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c525257feso6858117e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718709035; x=1719313835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CamK4h0tVkXA5tm1M1BFkFYkjXyPGLjdWaiQdzsO90=;
        b=p15VSk12ygPt7WFXlYjeb74m9VINP1JaosdBc9x6qJKZuLmw2up1Zp7yN8J/DiX9Ek
         0XWBqUjqyU6xMI8YxTRbkL81MGNGWWWnKVOJUAi/RyzPQLoRkHFkSG6SoouTceIs9k15
         gFXXeGaBTI37xs2sXEJXZfH8VTXfftohVAWKBuZ0SPGr8I4BMgI1LazcDl+4m4zKxEGL
         y27V1ue6MkgnlBbIBTWGKEZSWTp/O5E041GRmlh7Ek31Oxyue5XmT3kNV4S9wMaHtF9P
         Yf0aduZcwsLl1Pi8wHLDN0YQig6u8pC4qoIVfQeafbPQJ1fUS38HrG8FKPXthTZf9cq6
         N0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718709035; x=1719313835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CamK4h0tVkXA5tm1M1BFkFYkjXyPGLjdWaiQdzsO90=;
        b=NCuziPmL22ORRY5MXQwnC5G7V938c5gfX9836xEGWpo0KYCLxHOQG696d2Yc/JEC1i
         QVTSf7KyBL5yYJkkYcIw+zMTShPAOxb0MnWAOHZigVq/hVa6Uj8DAFZ7LB0HoQ93vE4r
         6Eh7uNe9AU2Gu2jufN1KeQhfWS+HTwIG2sClGsJ2ExqkwAJhbYboUKV/VTMMxyhsR3ij
         tWJWbCo6B2CXKh7MAUEh6cNPipzaAaVn3ARteQvnhdEyfCyuv6b6x/rIdF1Vrk1f9WG3
         fw7EPL1q8AnowhtHnLpzeTw9P/xi3DZm0exdFwokNkBwJiR3XX6Y3RRRRzrKzUjBACh7
         gK1g==
X-Forwarded-Encrypted: i=1; AJvYcCUQS2AqCoontQLt6AXLRBzA4s+Ukjqbwc9jxx9Kns5jNzAnGDq7OErmlnuL99/SffRlagtaeU73Z1C1BrOcct1EGuxz4pi6kAcX9r1v
X-Gm-Message-State: AOJu0Yyz7RTGCnAPDUqwGIupc1kUIk3CX3aD55EoeIx5PGTxGDdAsj00
	oYkhf6N0A80x0YB13aYGnY3NU7MarfryNHPakND12DSoMjN2W8oBUP2ysMzUe0NRz/1i2lc1brH
	g
X-Google-Smtp-Source: AGHT+IGXPsTBfIq7KgoZ+FjqKnXfQE7o5TjJhqwbSz0mtaVsqH0uGjATHX6jD/wxyZ6VImIIA0MtLg==
X-Received: by 2002:ac2:43ae:0:b0:52c:8a16:b085 with SMTP id 2adb3069b0e04-52ca6e65542mr7104199e87.19.1718709035526;
        Tue, 18 Jun 2024 04:10:35 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282569esm1480851e87.41.2024.06.18.04.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:10:35 -0700 (PDT)
Message-ID: <9d9cb645-b3dc-4081-859f-d2be981a696f@linaro.org>
Date: Tue, 18 Jun 2024 13:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/msm/adreno: Split catalog into separate files
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robdclark@chromium.org>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-3-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617225127.23476-3-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 00:51, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Split each gen's gpu table into it's own file.  Only code-motion, no
> functional change.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

