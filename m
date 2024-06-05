Return-Path: <linux-kernel+bounces-203088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C08FD647
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6223E1C219AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC813BC26;
	Wed,  5 Jun 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmiTyCVh"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D013A3EF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614632; cv=none; b=oCxSNcp8UOh4/V7aV6V+5uMFS02xOHll7KkmEylIc1DW5lxGbZ0ZFLyRZnyevm6H+kE453mm+kKol3LziwFK6IKWPj1A4juq/I+O0WbkiPcQhJwZD6ndBTYYVVF8Ssh5iQWuy4dYkqu5zLRklW0V3wXCCghy1CbcoqUwwlUBkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614632; c=relaxed/simple;
	bh=X8hGqIy+93JBi4cHbZbL2cXPDafXwdZ4IYRk8LOIQ7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bd7e7niy508X38Kubzp/5laosn4bhU0/BoUqoLB0ti3ND34KSXlTaZYmyqdAio1XWkV8bGL/YGWF9VBvMlPnKuU5+jYNRJf1PSGl3mYt17AsEHHQ5lMu+q7qKdeBA8E/RXbOOqvClN1JocZxgrLOJLW4VoXgXvrxGtRx44dRX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmiTyCVh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6c7ae658d0so11342666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717614629; x=1718219429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mK7jrpMIhdpD4U0ZZC0s4s5iC8b3dd61akLC4S7+c5Y=;
        b=kmiTyCVhi6zdxJBhGX6DVE5GkSmtLmX6oORdLqafmZFZhDjb2r59QgOpNS4YcAI8u0
         fk4IzRjRqAyuX8FgQ9G2l2iio49M/X7vVc4xreKywRyKoNgK0s1ghrBf9F/5vXrfnfMt
         0JBT7QYJyrFHzo08ybFK8GU0/AKJUYhSO77NCasgm+WKHuTq/JT8X0dLQ1ygF/GJYoDL
         MYaQFpLahyhjXBSgKLZD2MXAYWoS4ldmRMxKv8AZjFuwuzODbt2NPs9EDNIE8z1nWs/W
         rrarKYfEZQ/h0bi8L5mb3zQiA9TKoBRHs4CqIVaqQgY6kiZxwIDd0MFEHabvAyuJEUQ1
         QKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717614629; x=1718219429;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK7jrpMIhdpD4U0ZZC0s4s5iC8b3dd61akLC4S7+c5Y=;
        b=h7BK3Kci2D8b6hdwW/hq2SxcQqio4URyFIs2pRSFcYt1F7bzSvKLg2P5YDlpoUXScf
         x8JEko6clnkC1TjEPr9BY2svsryooAw4h0BYujs8y2TXR9PitIixM7m4YnNN75m8fcI2
         y/v+f+E9eu193/QtPJEUOIZ9kS7CO5qBzX/bdPQMC3iI5dKfLmd5SIkfOiFKuw1BHbQQ
         XYs/dGXWlzPd5pIFOaok+0E5006gBoCwrz8O0/UD7KKFz9L23XieY+l7dO5tWjO6X21V
         D0/w/ZxZlWP6FnqRh38F+ey+xjUjLBFbqfh7Gl6xYsQCWwnYOMTXUBVXPIOyN8/HTzJE
         GnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyAiBZ7E7LxuNYfm5uzvtITAQtsxIjTM2DcerqRd9Tir9Tlxx7exZAh94z0u+Cq2mYhzOuhBYcMx4eHxlJAXzCutYYtklGOo3q4fNF
X-Gm-Message-State: AOJu0YyfN70LikREFwGgDjK4he4/fJcC7aJGMlcUIPxmqGWyBNuufYEx
	V8qGRaAXv3vSWgfa83HqwbZT7kIPHCMMTRI6Q1Yv6dkjUkEMx2dyg19la7hY39c=
X-Google-Smtp-Source: AGHT+IG7Yoh0cwlazZslygNHqbtdsNK+mwy8Kw6d+Q8/DfwIa0+9PztFlkd3fHRv81aX9ANBsPbXxg==
X-Received: by 2002:a17:906:cc82:b0:a66:86f:cacb with SMTP id a640c23a62f3a-a69a000eab7mr266720866b.61.1717614628705;
        Wed, 05 Jun 2024 12:10:28 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a681c4f2b6fsm813574566b.144.2024.06.05.12.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 12:10:28 -0700 (PDT)
Message-ID: <c58bbdb6-ea81-4c4f-8e3f-0327d8db7729@linaro.org>
Date: Wed, 5 Jun 2024 21:10:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/adreno: Add support for Adreno 505 GPU
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Daniil Titov <daniilt971@gmail.com>
References: <20240604-a505-v2-1-dfa599a4d3c1@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240604-a505-v2-1-dfa599a4d3c1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4.06.2024 8:10 PM, Barnabás Czémán wrote:
> From: Daniil Titov <daniilt971@gmail.com>
> 
> This GPU is found on SoCs such as MSM8937 (450 MHz), MSM8940 (475 MHz),
> SDM439 (650 MHz).
> 
> Signed-off-by: Daniil Titov <daniilt971@gmail.com>
> Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

