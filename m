Return-Path: <linux-kernel+bounces-176102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E938C29EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA47280D04
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DEA29CF4;
	Fri, 10 May 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exrv/JPa"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384703E48C
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365779; cv=none; b=nWv7ehzCjcqynyjWUieHliAvuycrg/4M2ogZNNLNzALrJ46QKw7D/C+dNMHPV8HUadGGunfb/iP7XBKr2yPjJZF3tRX8faoSHwmy3CnPtG2+pkuePzI5VKJMp4VyHazOnMW/A/jayhGHghUiScLvLJI7XFwjaXwPV38i30ABHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365779; c=relaxed/simple;
	bh=EgK6fR9aZKsoYGeYx2mAvEsnIF6BMRocn8hw7CrzdSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddGbP8rZHpvVNWszi2URMcpGkk7Nm9iFTSEvfiiCgL8OsFCv4oPN43EAdBzaV0Vz+xHzKV6upsoWcr/lPyBXpTDlRYkGYNgVy4n8WJ1SDPjkfA4q2bYGipSXAKpwXkbvm3Q6M7pXM3IKu1Hq7ABuAhesdGtQLxJTNSbRKJIbR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=exrv/JPa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34e663aa217so1510079f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715365774; x=1715970574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zt3EkIKwnjg38v0bTK+4D69dHc2YvVLV2wDfHrRVqgw=;
        b=exrv/JPasyUrrgLGmIiAsPRARZ5E4SHGxa0kVfzNjE/FNXHymr33dmc4JqRo11v5lY
         pGGrPZQidfR9Dhi7S8g9lMgxx6kas+kkJmfpQuSje5zi015C/FVKQNW7VOwXPNoaL6J8
         gg4Z2G0WrKRExuc7hnZKA2ElVRS5ri6nTLUOEw2M/UJbFF0lZ2civ2+QM1Qb8DrCkluS
         YZE0OHRQgIBPzM9H44uJ3SA7zSmLA5M9psMtOpBR52ht0gk6+TTyFz3N9rp+fjqwhEZ8
         vS91jdhI304A/oVMGqHCHXwyckIC+dOFq8qlrWCTk2OlJnwudtclpmtr6fJ5qMUfNCxW
         /qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715365774; x=1715970574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt3EkIKwnjg38v0bTK+4D69dHc2YvVLV2wDfHrRVqgw=;
        b=bqEE6Sg10m5tlJrFrddG0dk8j2Go8YyTZO1muLYVJTutdCQRLp4oTuBnuX77J8x8CC
         drh/DGawvRDg0Y1o60cnm//8NAjR0FT7MNgEheQ+TaRWP9uSrj9BwXUSlEqb/IYIMCyw
         CwavldMbsWga/6iVrbNJtRtyfU2OgHWUFBBWdS6QMWZbTo08mqBOqEvSoOPEdB3L+SYB
         z0yF7NcJd37O9DkBBQ/bdaaAK/6NrBKt+9eSHPYz0ZTKNOQUXK2wF2rifljJUurKr4y8
         +/Lj3RdkmEXSR10u2HiKRdHOe6M3uxvErlLGSqQGLPDgPlrgYs7foxxaHOMPCXZgJCGz
         MIuw==
X-Forwarded-Encrypted: i=1; AJvYcCWKCcQ90MTFtCNihr9WyEfevOM/toLJFvMOaSFSEkHqwhLmm3D+ufPf5EbuGRrz8wZrynSTQeUeiRiEmocAC68Om+jFNP3v3btLi8G3
X-Gm-Message-State: AOJu0Yx1WT1X1kWDw4TPpi3lmtqsoMQvHRxKhIlxW264T4jzgv4ijdP7
	mpgwhq9yo8xAvwaL+SKUfJH/gA6zQPaHvUJRXVflci9cq4Zz2Mjh/QY3NxfqVmI=
X-Google-Smtp-Source: AGHT+IH7mAoXaXavj8mRmL7l6DfAUlfhF7EyxxACp4n/W9aIfft0HitTTk+c0fC32xST4ImnnFrsng==
X-Received: by 2002:a5d:4e8d:0:b0:343:65a8:406d with SMTP id ffacd0b85a97d-3504aa62d37mr2871590f8f.64.1715365774680;
        Fri, 10 May 2024 11:29:34 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc887sm5150649f8f.98.2024.05.10.11.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 11:29:34 -0700 (PDT)
Message-ID: <cf7e023a-3d8f-4c49-a167-01cdea634daf@linaro.org>
Date: Fri, 10 May 2024 19:29:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] media: qcom: camss: Decouple VFE from CSID
To: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240411124543.199-1-quic_grosikop@quicinc.com>
 <20240411124543.199-9-quic_grosikop@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240411124543.199-9-quic_grosikop@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2024 13:45, Gjorgji Rosikopulos wrote:
> From: Milen Mitkov <quic_mmitkov@quicinc.com>
> 
> Decouple the direct calls to VFE's vfe_get/put in the CSID subdev
> in order to prepare for the introduction of IFE subdev.
> 
> Also decouple CSID base address from VFE since on the Titan platform
> CSID register base address resides within VFE's base address.
> 
> Signed-off-by: Milen Mitkov <quic_mmitkov@quicinc.com>
> Signed-off-by: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # 
sc8280xp/sm8250/sdm845/apq8016


