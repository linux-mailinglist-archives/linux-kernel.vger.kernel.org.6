Return-Path: <linux-kernel+bounces-255045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6E933AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08281F220CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AF217E90F;
	Wed, 17 Jul 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvLs/If5"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A6315BA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211139; cv=none; b=A/U9P2sJ++m3h+i63sqEjvEqsBbXiv50oQ2Sm3/AuLyfyJxsfSb0QTVUhLEFkBkHXnOq41VWh5jdnWrlN6Zt4nJ8sM/UqbMOiGIvbHe4ClZxUn7mnEqPyrbMntj+53nLNRiDEnBx1o0O8CbgOlfGwty99WWMtwi2zF6BToxz5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211139; c=relaxed/simple;
	bh=+zhFi1Don8ii4Gugp268OJkuD4CFngXRF46lzJVIwV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWCokXup00Hs1A+3tEYMGEaWCJ2dHQFn3gMUCLb+IiPt2+RxtnoqqBd9X9i8/lVb9I4/tt3jKbTx86iySJWYCN14rcmgMIFxYRx0vpweretaWbRbfvAiyiL00tuf25jsXp1Z21OLQuFHUeTXax48cahE45rzHdqKC9CekZ5vf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uvLs/If5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so1932044a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721211135; x=1721815935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eGm3FeokUWIOIUtopwWGWZKooK3DZEJFATyKucI6ucU=;
        b=uvLs/If5S6yxzFZdWKHHZ5dpFr0LoYgJru9K8c5dRNcfCCcFBrHyHflURAyBFwZEEs
         xe2hciZS4MJkTF4Fuhb4dyeLrcvFanUAxxlSBtXS/DR/WyZ/d+Q7yJTE/WoH/5iMV1mA
         BGhT4W4qlqJZiQrHSUhge4XPKtKlHm6P9sYCLHhYAVv4+IoyrjSNrC8rQXd4bdMfanWR
         CVgmyaITlSrDaQJXlMqF5o5shacSD0i5z4cfjRrZjIcwHxR6ye+7UDg8ak26BR8CAda1
         H0aOfcmwBimOIM6MArpvyptz1TJoJZZkLe0i+u6UoH5bAKrfD4vSr3ULgu2nT0hHF0OQ
         YNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721211135; x=1721815935;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGm3FeokUWIOIUtopwWGWZKooK3DZEJFATyKucI6ucU=;
        b=hYDzi2S87vK3kfWopGwy7ApMbYMoqoEXYsncXpaVOkQwgZFp3TZm5YCO8o2cnSEZZh
         1mpCPyILRNx6OvyNGcUM78susxZfj0jsTa0ghd1VnhJtixYFHSKQ8ZB+BmFH+ilIZs6/
         jAJjteKvU5g1KBov49uZto2fZgw/lY2AsZo+o+XZlvW46YWwMsEnQe28QvqxgLzYFIu3
         P2QXbgn7CpqnhGuJYprjELFL9GNiaBMGHKLSX2YkAe+2pjh2HESEFXc9CKPK8g+HAZUi
         DwtXuiS+Kc1ZBq/wQXP058IjuAbtHytnbZ2vQuN8ycfY1HsC/7s0uxAnDlFjeaZ4nths
         hYbg==
X-Forwarded-Encrypted: i=1; AJvYcCXzPUeKX0FKND9FVuG1J7qSEWJkkcszqaVEZldRC0i7McHTOJsxIk0rLoolLj2xVf3pN0MAuu11xxEGnDSlVcWwz8O9gAvzrtjHXgCJ
X-Gm-Message-State: AOJu0YzPnNOaC+krbkdBbxXgzEFmPp/SiORsh42JgA9t9otppvQtUTqm
	8XSN/TK5qxEq3kvNmh38XB2yY44C2uZNdP1IVGp/QGjcdnzu2x66d6EJEUtJg/Y=
X-Google-Smtp-Source: AGHT+IHsryZu9IU2sHmq+IUn6qeZc6VMYpoTOyefskGIYKTHzTAYOg3LrD0Gk7D+bbzPb6EYf7v/WQ==
X-Received: by 2002:a05:6402:5205:b0:58c:ea9e:2194 with SMTP id 4fb4d7f45d1cf-5a05d0f02c8mr1126575a12.32.1721211135170;
        Wed, 17 Jul 2024 03:12:15 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f61fbfsm6622510a12.81.2024.07.17.03.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 03:12:14 -0700 (PDT)
Message-ID: <e47883df-7464-4194-bc6c-7399dcea7466@linaro.org>
Date: Wed, 17 Jul 2024 12:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] clk: qcom: fold dispcc-sm8650 info dispcc-sm8550
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
 <20240717-dispcc-sm8550-fixes-v2-6-5c4a3128c40b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240717-dispcc-sm8550-fixes-v2-6-5c4a3128c40b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.07.2024 12:04 PM, Dmitry Baryshkov wrote:
> There is a very minor difference between display clock controller
> drivers for SM8550 and SM8650 platforms. Fold the second one into the
> first one to reduce kernel footprint. The bindings for these two
> hardware blocks are fully compatible.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

