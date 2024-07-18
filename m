Return-Path: <linux-kernel+bounces-256109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2124934910
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690C61F250E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC12677114;
	Thu, 18 Jul 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZuH3d+J7"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E9770E1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288553; cv=none; b=AJhY5ZJWbyvtwKs66WesinNPIp6uy0/tn1dq0KOTow5ilT6wWyd6LowVoY3g06t+KuX4nKdtwhWcc2MPeBvK9iZg4X/2VqWrxxqMo2ccBxOMpJ7okodLpWgrJRM6Mb9pGoGSNo4NmPJQnB/6a9vPEFJ7nnAfhIplL5OVXIZX4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288553; c=relaxed/simple;
	bh=crZJmCqK87jwljEupGaNu7UvUqSuBB8l1HzWelVei2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy4dxLxeoHj0/XCCc5Q3E8J/Ipu7uOBzQIfQGvkg2P/hrHbpGdmImfVFKsAbl6v1PkXHsyjuUnjKmhD3d3xORI8dtm5ynwrjACtzz4j2qZ2G5dLxEh37/gP4L2DYuFZA0qMY25d5bWATTNAbWMw0YeVCzdOg8hMV1/U23+JN8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZuH3d+J7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77e392f59fso47054066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721288549; x=1721893349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZX287HaqyP7vcUJ0qc5XZL5lWkyJafdbelVz1ASHFps=;
        b=ZuH3d+J71ypVm9H3vUvAZmuqdbwzkhBoNmVfnf8te1EuU6oJog8Zy2aNbi9S7QOUe+
         uXXDXEDNIwbPLPA+plv1MNiNWXO5IiOICBiOsCZLaHsWoTWSupHvX4A0N4Y/KHwnG/kf
         k6EHsXyuHWmk8ur/gEqVfpXMqFAuiUnSpPCfPNK8aWxW1jBIZ7+wII9B9PB+yV90R7a4
         x8wqkYHGUqUA3+UP8dlXSHcxFdcNvs+RxrPlwf+6A3q0Ggccec3jCUSXf8dXlG+ALgbu
         k29lh3C3evrEhfD5Yd7Mb6onXIi69JlAUOO/wCVkXfp9yzWNnPAb9AIvCZprvEXwo75g
         rt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721288549; x=1721893349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX287HaqyP7vcUJ0qc5XZL5lWkyJafdbelVz1ASHFps=;
        b=xUQNS5vb+k9hyuBOray+zTEffE5Z3Tm4FryeA12GUhrHDHkLUsoF69JFnCe7Bjt3Iu
         l2qlj+dDHQEUt7Wehmul1OaWOVkcslzkw47WP47/VM5zdPq5n2rHHmHR0RlfzJ62Zbqd
         PtsmP3qoWWlr9ezYoyNr8e6kzj5wLRehcN6YMS8Tu2qayOusOCuhkeejlC0ELZy/G8M8
         8MPt+0+KN+pRQzRws/cIcFUcP6Qs/J0ELGrFCKFnt7nLovd2z0CN66XOQ8WiIT88laH3
         zwRODFWg6tMzGPU+vbHWzuPMPDGJiAIujLUKifGws3y5FxnzDgEJKvnfNossuxFaJOi6
         slNA==
X-Forwarded-Encrypted: i=1; AJvYcCVkykM71cRe84GajkWekOYp3iUHm22uTVui+wm5C+t4HRqSNiN+I68f1antMUCZKJBzSOVsdjO9IekFMPpqF8/oqKXf8DNZpNlyDrWd
X-Gm-Message-State: AOJu0Ywj0wayr+TjsNdj23+VrZ/Qca+E0hzW0IRXyy9KwmzhkbM+LR+c
	y8FITJO2p+T5erWdRXO54wKNExl/eRa6eFMnlBPlcaRXvR2rc8rq+nW0CY6TL88=
X-Google-Smtp-Source: AGHT+IEWjQawmcXV1ywfjT5eUOoTbnv2DLE4PcXWO7RcnvTtWMyUSEg1A/4wLFF5qysl0PAozkvpcg==
X-Received: by 2002:a17:906:408b:b0:a72:4b31:13b5 with SMTP id a640c23a62f3a-a7a0130ce00mr266533066b.54.1721288549115;
        Thu, 18 Jul 2024 00:42:29 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b8366sm521156466b.61.2024.07.18.00.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:42:28 -0700 (PDT)
Message-ID: <1c5b3f7f-95b6-4efb-aa16-11571b87c6c6@linaro.org>
Date: Thu, 18 Jul 2024 09:42:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: cmd-db: Map shared memory as WC, not WB
To: Pavan Kondeti <quic_pkondeti@quicinc.com>,
 Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, stephan@gerhold.net,
 swboyd@chromium.org, dianders@chromium.org, robdclark@gmail.com,
 nikita@trvn.ru, quic_eberman@quicinc.com, quic_lsrao@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, stable@vger.kernel.org
References: <20240718-cmd_db_uncached-v2-1-f6cf53164c90@quicinc.com>
 <a49113a2-d7f8-4b77-81c7-22855809cee8@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <a49113a2-d7f8-4b77-81c7-22855809cee8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pavan,

> 
> Thanks Maulik for sharing the patch. It works as expected. Feel free to
> use

Can I ask how you're testing this?

Kind regards,
> 
> Tested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> 
> Thanks,
> Pavan

-- 
// Caleb (they/them)

