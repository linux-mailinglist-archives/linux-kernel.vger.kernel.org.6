Return-Path: <linux-kernel+bounces-176095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564D8C29D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DFA1C220E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6091A3D97D;
	Fri, 10 May 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZRV8ygJ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9572C683
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365667; cv=none; b=fMf9U6Y3F3E0RQ7DG+VgP/E5CFGZmN36E3BeVBYEbHFSD4+QPouLlT25U2Otn1dM5+6CJdfSHMyFCx+dJ92w2hGm37xtlOCMyllAzsOP+ZOp1yKmHUs4MGz2EZamSk9I/saaGw3GIB7hjd6XD+tRIL3GF+Ufq/T66DkLtABByzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365667; c=relaxed/simple;
	bh=uLqe92/dQ4dMxvG6UINLCSdWA9vxn9F9HhspNog0qfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tp5mhoUXFzNpYLxNmmgXbqpJ+Az7nPLRQOgLMSP6zXWHk6eKNfB6vF9hCYxvuKYNxCaBFI1TtgMwWJwVQ8R5doN7UrPfjX5SJ6GNkCL+8MxeKsKAL+IUdY2iNJ0DI2xJYwIFGwzgQ3NtF9dO46yGVo4yS3V+ORamblHPLLXrAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VZRV8ygJ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so28127071fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715365664; x=1715970464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5gysLK7eBXrdS+RL9/zVN/Yqx4/fP1l7kizHDddPSA=;
        b=VZRV8ygJzcWS1QwM5oX65XYyIca6fJ3O6IIIRltWw26KVUvQaHNj+dSXv9WSoyTnxp
         IjLQ7qW91QFuqZXt/zX87OI30HRJ1DYTojolgq0kM/SUUYUy5wyu4ZP6CaTBuQd6YeC4
         wZ9vKxjn+e+6IwzU2Mrwfr7mJ3I/ih4aou1IWLlL4VWDzFbDi9AodfOy/UYgDUgspJ88
         PjHHX114v1sA4Re2jKt+6M3FQhrmZCBfUVKig7GqAHEGzN1Z+D1UmnNrP2UT1s71H0ly
         Y2DGVC93tthBI/iCjdA7UQinTZxBkvZIBhQ4jLNg4DHX1XnpMrWxxanMSI4TxPlkFXfF
         xGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715365664; x=1715970464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5gysLK7eBXrdS+RL9/zVN/Yqx4/fP1l7kizHDddPSA=;
        b=qdNIlMB5UEy0XyMY7j8npvyfteR35j86cApgGyCharG32twAMkpo75D08TuD7l3Qp8
         5sGotmvsskg3rgt2k0cB7uzOG41d/+6RkaCqlNYzZKcwmtIaT7h0HWc6ojFzKBjwukma
         ksC6PeXbH1v7+eh2+aLcNBQXWm298UK/Gv4CRkbz8afLvlOLkDYN2baeyzPk6EEOzfzF
         zQ01YcaScPSpxKOZPTtEQ55VDsLjrxXMQ7tAy7bkw7Ti1vZqwUL1jtSgldyihy3BQo3P
         PP28goIR8d8OdpuFEDyn27LPn+HHW0mUp7/1QD7HqeX91py5CqFd/TvfeFKOk8h+0BdN
         2vPg==
X-Forwarded-Encrypted: i=1; AJvYcCV9k228k4hEcCMceDIcUc07FzLR9RAFiL9B7Zw/cgmmCgMf+fy0MAQbdOzb6hKPHIzPzSZaJhDuJKHmV1C1oGhPkCUomeFqszFuzWiB
X-Gm-Message-State: AOJu0YyUIwhC/snw7/dhPkz3TXdU+zCJIIIUyqNJJBr3uglw02Cpob7d
	4vrR1gkR0Kn49eO9T1/A56GtGHwrVUzNutIXPZU057bJCT89dcC9CPsyVl1+PEw=
X-Google-Smtp-Source: AGHT+IEMygHGPRkk63RA6oaXPAij4I7QO4Qy+Nr1+oXenXLN8w5lR7lfJFLWFrG4aC3QZc8TmW1q+Q==
X-Received: by 2002:a05:651c:c9:b0:2de:73b5:4280 with SMTP id 38308e7fff4ca-2e51fd2de83mr24891861fa.3.1715365664318;
        Fri, 10 May 2024 11:27:44 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25d5sm72370325e9.14.2024.05.10.11.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 11:27:44 -0700 (PDT)
Message-ID: <a856b074-152f-439c-a054-090e296010c0@linaro.org>
Date: Fri, 10 May 2024 19:27:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] media: qcom: camss: Attach formats to CSID
 resources
To: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240411124543.199-1-quic_grosikop@quicinc.com>
 <20240411124543.199-4-quic_grosikop@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240411124543.199-4-quic_grosikop@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2024 13:45, Gjorgji Rosikopulos wrote:
> From: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
> 
> Following the example of VFE, move all formats of the decoder
> to camss-csid.c and attach them to the subdevices resources.
> 
> Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
> Signed-off-by: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
> ---
>   .../platform/qcom/camss/camss-csid-4-1.c      | 132 +----
>   .../platform/qcom/camss/camss-csid-4-7.c      | 160 +-----
>   .../platform/qcom/camss/camss-csid-gen2.c     | 164 +-----
>   .../media/platform/qcom/camss/camss-csid.c    | 474 +++++++++++++++++-
>   .../media/platform/qcom/camss/camss-csid.h    |  24 +-
>   drivers/media/platform/qcom/camss/camss.c     |  75 ++-
>   6 files changed, 538 insertions(+), 491 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-4-1.c b/drivers/media/platform/qcom/camss/camss-csid-4-1.c
> index dd49a40e6a70..c95861420502 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-4-1.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-4-1.c

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # 
sc8280xp/sm8250/sdm845/apq8016


