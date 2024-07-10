Return-Path: <linux-kernel+bounces-247549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0644992D10F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8255A284205
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CB191477;
	Wed, 10 Jul 2024 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oc8SSteq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826318F2FB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612448; cv=none; b=A3KrJXMqG25ByBrw9WPKDiFuITbhdiH3uOJH0LcOAk7c2TjYJboi/4cKxuju5LHsecL5e3+uT42KusBhlfdNmvigurQ83a9UIQzJpZAdjghSbnMA01IbO1SYUkdFev0rRMiydOgOdEhdlIOzJMEjDAI3jZ+EF4Br3LUhJPk7QcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612448; c=relaxed/simple;
	bh=Z/1v+ajFwgk68ZoOdTML/bJUtuJ0rVxj6ycaaeGv+70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEwIDocs9KFQrd9D1iJ4Hs5bf3m4StDz+HGh4je8/oWPKihv5R4ylrebCOooIMRDJ8KZtNmKfLCS8w7TK2ClALVos6Ipl66bZeRqvk98XM7xl0FHjms4jaeuuoXjPUzwnxWB4B0gNOp6b7WO86N2x65VwsEG8U1GfZOsmUQczf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oc8SSteq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e7a6cfa7so401201266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720612445; x=1721217245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vOYBQQHhZ0i9pMGgOvADs2RB7vvBi7I1faqvtDEOg4E=;
        b=oc8SSteqLEeJOEgF7C/uGaDDhUMq63WqSG3fOql5k57uWp1LXDYs3ScR59HNvYdfBN
         qBgj18yKcYu5aakmCqUKKY7nii1I0qDpLYR9FLNTvjTqc9HKha9V2tUeFr8KiFzIdr+5
         MDRTDhp0g9dwTlcQ1aUqfFdQ6ahy8ubsa055C5+3jecqmQJUb2cTv0OWNBsL5FGekMwP
         jPyU9CPugwYj+IUACkeasJ0cw6NzLWw50zNPt4mmSzHH9IwS4F8OlErBocBLr3aaZS4B
         JpmgD9unZ4xrmeWC5wy4lFI2XYSKoROLtaawDhXF0vKwdV9ExOovYwkZ3YH5MqcKTmbV
         QXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612445; x=1721217245;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOYBQQHhZ0i9pMGgOvADs2RB7vvBi7I1faqvtDEOg4E=;
        b=OE+GXqu8RHp4fmx9LMfSPayucVigvSw5ds0gXKV8RxhhbJrDxyz1ce5B3us3wsDYTH
         eeYDCmrRHOzGHZ4RnqIScUjyLfzSBWw6TeX4Wjd8ka2dUpYgL8DHqQVYmhOTXNqd/Mil
         jUK4+Vmnv3+Mj8Tsp7YyvgziHsdCkLeyjMBNKSTiBuVP13xXrxaCcN6my0hYjem3Ae3f
         1r2c5JIizKpsTbegkujy8vd1sunFrgEhfpC9wOMYiU2jzIkQ22XB0kCkQYz7jBsVXi4Y
         GLr7p6mrEC/YRjX1jnedXriqFb10WF8ccbKT+hIMs34xA9xCRu/1a6BIq+dSOS2r72DC
         U2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS/M3bTvUIBDQC4YzAk4sfqhMPqiXDFtTDqvJQQkHgSPyqIxmhd3uqWLXTUAXO9SJywZSLier72l7JVtrDaJisTDHJFxmsROkWQiIS
X-Gm-Message-State: AOJu0YwmoI2F7y84U68mskPQeFtzFjhvV8AtAzHvTYvXlOo0jJna6BoK
	Nq3/xHWnNnl0TqSW6XrVMnQCxTbL8KcZzuU41BHiXFNCO17zkOwi8xIGuxB2OnU6eCGpg5VWG+s
	v
X-Google-Smtp-Source: AGHT+IHCqy5FcBAlGp2S+L/aTjQnjagbwGchyL/xCIl3cUfPe6NoMgCG+lMOUJXaCTA7LWIHDLae9g==
X-Received: by 2002:a17:906:c305:b0:a72:b471:143b with SMTP id a640c23a62f3a-a780b6fef6fmr322542866b.33.1720612444551;
        Wed, 10 Jul 2024 04:54:04 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a854592sm153867466b.146.2024.07.10.04.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 04:54:03 -0700 (PDT)
Message-ID: <2a3561cc-c6b3-4823-b488-fc8ebc53e1a6@linaro.org>
Date: Wed, 10 Jul 2024 13:54:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/clocksource/qcom: Add missing iounmap() on error
 when reading clock frequency.
To: Ankit Agrawal <agrawal.ag.ankit@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240710110813.GA15351@bnew-VirtualBox>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240710110813.GA15351@bnew-VirtualBox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.07.2024 1:08 PM, Ankit Agrawal wrote:
> Add the missing iounmap() when clock frequency fails to get read by the
> of_property_read_u32() call.
> 
> Signed-off-by: Ankit Agrawal <agrawal.ag.ankit@gmail.com>
> ---

Or even better, you can extract:

drivers/platform/x86/intel/pmc/core_ssram.c
32:DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));

into a common header, call it something less intel-specific and use
it with __free() here

Konrad


