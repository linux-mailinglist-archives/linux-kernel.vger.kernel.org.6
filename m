Return-Path: <linux-kernel+bounces-177918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D18C4631
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AB21C2246C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF623768;
	Mon, 13 May 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSftEmFq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA48249F5
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621783; cv=none; b=EJkGmX05RXsG+Q6smMssf64R+ylfuCCf/wkzg3FxPY3EZa/QFpJVz1NapqY6CAqS3Wqr5a8/rS8MCI79aiPC1WCxdHHTD4J6HeFrNvoXf/7NZKFFZ7nNDB4AAaGN1Wvdqliz8qCDIfqW2w7h4ZReUsc3WPtD8uK3xu2S5feKI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621783; c=relaxed/simple;
	bh=oH3eGcg4uKDc8mJeYWQzOH+FxQ/v/Qtu4+nq1oVpYYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJTxn5LXu5Rq22OkcJVzafTXMvrOlZNNMNrU1jsyyPKXEZ1NDYefe1A8WfpvIIpRSNgutq5UPDzhABWRu9m/G14vG1/EmVruHZfks/WVr3bLdEyR0Uq7VkuWHwWk+A8NKgRB/F2CwApBQj8KIFcvzmf1CTM7tpQC9r+aaHDbc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eSftEmFq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cdd185b9so975900366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715621780; x=1716226580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGKgSqj8FhjNUqw99/xj+RkQSPtYlnoIACWc6isu8ZY=;
        b=eSftEmFqW1YChOo6/qPPW3uAfbbtzDNBC4yYrZUJrvxSKIZBdG9Z9NV7Z2zSj92oOK
         0ZKZIxYypZyafV9L4h+4IDx7ne7mfiGKdN6dA/uMKwnUb1GIpoQYRd47L+a8MxE4VL+P
         5dgkY7x7JWBT4vDArGWwBFwfUuIQcaO8sqO6XoMYI4xXzH4VQNSB4eCTnZ1CMWvzUZYH
         Otbo79R3LWQbHPpG+PE4bso5db+UD+MQM608imPTn1SAAjM3ux1rVTOI7UlfMiSFTE9F
         L9zWyO6/EH5f/kwO2WljmJSNWh4EJF3hQsbx51N9xnrZ14rUBJ03SsKzp0dasOE95kTa
         eVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621780; x=1716226580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGKgSqj8FhjNUqw99/xj+RkQSPtYlnoIACWc6isu8ZY=;
        b=mToiu72gBCHM0Ge3qT3YQQQ+CSY9IX6dRRH/GLrsfwqJuYZf397RezCXXBKjEGpXKd
         CGbw/HI0hglSsfr9MrDElN7DyfHHHAk9JwgF9jBP27Ry1YYbqgaFEOnq2oHQnlq+2tqR
         iHgeetUQNsXNhDGOO+yCUGW14JsnXQ5iUwmoOiDKUYYQMuQhQc1z3zkkMheSa7qL+Z7S
         YEjMp0yeGh4EPMbMzS4cO5+j68gtKoA2Fc42XosvqDlqBHOHkZ46gFUg3e7e43Ajr3Xc
         k2yeZEA1UkOS60J7UW5T437vz7m5rv1i03Tw6RVIRtp77ymHikwUUaMQKCCoQ6n5WcKB
         rNjg==
X-Forwarded-Encrypted: i=1; AJvYcCU0xi5XDpBaRvzkuSM5KPk2qO+Jtr6wFmlWxsA1BtoWZGSRPZO6niO9Ur2SE/Szhqyyt3NIf2lr2hHScPrLJTt2UAaF+FjpV+HcBv7Z
X-Gm-Message-State: AOJu0Yy2KU6HIgfhshnAtfJDyrGjoVpvIqtalEPLbVfAn2DIhNO9R6/i
	UHFX6DxHfpr21pwjU34QHUsscPe2zNEnIxnEvIUA+465YJ2h1FFeljaHF+EM4N4=
X-Google-Smtp-Source: AGHT+IFfJi77FO6AqB1W4z2DUhEJYPEilmrR9M0O/v09dQbgexMw/nftetnPR7hcLknwBCiCyqqT/A==
X-Received: by 2002:a17:907:2d09:b0:a55:5520:f43f with SMTP id a640c23a62f3a-a5a115ef93dmr1376985466b.10.1715621778926;
        Mon, 13 May 2024 10:36:18 -0700 (PDT)
Received: from [10.1.3.28] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01932sm618072366b.168.2024.05.13.10.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 10:36:18 -0700 (PDT)
Message-ID: <55ce4e31-4134-40fe-8e94-28392863886a@linaro.org>
Date: Mon, 13 May 2024 18:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] media: qcom: camss: Attach formats to VFE
 resources
To: "Gjorgji Rosikopulos (Consultant)" <quic_grosikop@quicinc.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240411124543.199-1-quic_grosikop@quicinc.com>
 <20240411124543.199-3-quic_grosikop@quicinc.com>
 <c76957b9-d57d-469d-87c8-c9f59b4462b0@linaro.org>
 <9ac41841-9281-4867-a607-e3883f32db83@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <9ac41841-9281-4867-a607-e3883f32db83@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2024 16:35, Gjorgji Rosikopulos (Consultant) wrote:
> I agree but i would propose to have next series for cleanup up patches,
> Otherwise we will have to many changes across the files.

So, I missed these plats in the code, thanks for spotting.

I'd like to get the header SPDX and style stuff Vlad highlighted fixed 
in a V4 of this series.

However given the amount of effort required to verify these changes, I'd 
rather avoid data-structure and/or logic changes at this stage.

---
bod

