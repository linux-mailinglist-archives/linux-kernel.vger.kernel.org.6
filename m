Return-Path: <linux-kernel+bounces-425505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5679DC2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14F9281DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76032199FDC;
	Fri, 29 Nov 2024 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjpHBu4u"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BC17ADF7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880396; cv=none; b=GwFTEKmYnV1Y29uVvT+zOK2QlJ9hZJk1ZjZScWXfz3CjzpVfv4bHQUIZCr7v67QT18953YpIIcui5Ung5CTi0mi5nrfVrDCv0Ib8sgVVlFtRY5o+w9425KgzSDyyFnhW09suGOUggt2BbF4gK2XPVHxUJXTpTworr+qur2Q0EtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880396; c=relaxed/simple;
	bh=cr38zkBaIT5J6Z54vSx7eJQHbefLFUPKhgXZ94YH81s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPL1ezw0EumYkjihSiF0JRas/zuTl/icngq+8ZizXeueSIhyJXD8C6IvkLXuhQadRryvfIX5dS+P2VDz+5Ys0TR/orNAl+OaPhfJQoJCyMtzYThYr3es9WjAon4I7+E57B60oTuSGCjp6egn+LgrnnqYYJUQ4zU9KnEe7U5AcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjpHBu4u; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38248b810ffso1436794f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732880393; x=1733485193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDfyMtdSo8AvHdVzO4O1MlF8b1Ss9UAULJbg4XvzTh8=;
        b=AjpHBu4u9rhAE00FlDaNAH/5Mwxo2iIQoDe5z5kUSGEazgJNZrYunsY7y0bKqqW0Sn
         NHSBMkkrX2oNYh37p+zjjKb0WA+g4e4tO5qvHKeXrzMgk9BjdkbTNYBB3UVTeUncS2EM
         N3PjaoNbb4rnU6vjoUTgaALfX1h1WBIR8v0IPCyP2UIKWm/95Vy92E19gvIGpLFi9Abb
         sDr5yk6tAnPKwsSwK/Oe3OeP2TU0TMYLLhdzictdYtbqXsC7SVPtwdoYuU29wTaoQ2JQ
         /zKP/zc+iSl2eI8Vt6arObBzJDUxYGQIXKBxdeG+f6lfeo93yeyDvgN9dJEE7lnuzQQI
         dMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732880393; x=1733485193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDfyMtdSo8AvHdVzO4O1MlF8b1Ss9UAULJbg4XvzTh8=;
        b=KKllRP7i0/3pKqVcMnSuodKbmj1FeXvk+bNvvLELT2iV9kS7kLo841dqmf1e3wNy2P
         9vQwRrnvJC4QLHxEfZqAGyZt/qQEsUJC7YReuE1Yl6zVIePVNW2TGP8tY9ZaW0A9aSpA
         cb4AFxoaxTWEPxf4OmTOyvuPW9zRlEs6IQM4rzCFzh5EfVihLHhAMVPqWCmLmJJ1YQGR
         u29WGfnr/OJ9IIb3eZqttbCkE/UJ0uSebZ0mXhqCir+okVjuX5UGdjztWCs5+E1B1aPq
         eORTtk3QsE1u1nuxcZH9YmNTEqeBmH2pdXox5RYJrRSQ6ALvq5fSuvvzhKmRlLwdODFX
         BhWg==
X-Forwarded-Encrypted: i=1; AJvYcCWDabrLwHM1++0zkHhIy1vk6owsuzBX4w607ZwYM7s8ne5RjAzv0brjBwKKxlHnpIt15g2WNJhwyOH0QZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDZCm2J01x3mvBImszzQUJtJbgSOodfv++uV1Hp/dORG+u+Wl
	JD20YfKYVJVJ6Q7W83ZRjkSQ8fgpWiIyGJEwgDDS5hXun7Jkxmh0m2FZnHTnNwA=
X-Gm-Gg: ASbGncuc2jMzJMepGJAEHznAD4rd37mMogruinnqNHE/wuqi7wACnXVq3mrwEOri829
	wZsTwhZ0dF5BiO5jMjLga+Wfn7fBKYRR9x7rPAN3yczqq74gymOwd5VPd1sV0dSGSnK1gcw9kjz
	T+gpfJbql4UODQdLFFViayJwIpX+MEqqWFEcD6C2fsd/ndgh9cy9+mxgCVDXw814nNbDfPpzhMn
	FTXlue099HSPLCRuw0mSscDZMSDbsde+rvppfcXA/IpQaraimJqWs+5Sht8fao=
X-Google-Smtp-Source: AGHT+IEyCt4PbCuXKWOIZUqCNhrD2aNU8Qj8+H6sBZhSb8I+snk1v4CY846kHV0DiDgBD5wLzt7EvA==
X-Received: by 2002:a05:6000:4013:b0:385:cb5f:d79b with SMTP id ffacd0b85a97d-385cb5fd7b4mr4566727f8f.18.1732880393665;
        Fri, 29 Nov 2024 03:39:53 -0800 (PST)
Received: from [192.168.0.31] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b9a9679bsm14842385e9.13.2024.11.29.03.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:39:53 -0800 (PST)
Message-ID: <7cf4ce25-742c-48ff-99e0-bbbaea370e89@linaro.org>
Date: Fri, 29 Nov 2024 11:39:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] clk: qcom: common: Add support for power-domain
 attachment
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org>
 <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-2-ca2826c46814@linaro.org>
 <9b9bf718-b5a5-4fef-810a-1206743495f6@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <9b9bf718-b5a5-4fef-810a-1206743495f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/11/2024 11:30, Vladimir Zapolskiy wrote:
>> +    ret = devm_pm_domain_attach_list(dev, &pd_data, &cc->pd_list);
> 
> Please make a call to the function like this:
> 
>      ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);

Passing &pd_data will cause devm_pd_domain_attach_list() to cycle 
through the power-domains listed and do dev_pm_domain_attach_by_id(); 
instead of dv_pm_domain_attach_by_name();

That's what &pd_data is passed here. You want to have that simple 
attachment of the power-domain list.

---
bod

