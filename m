Return-Path: <linux-kernel+bounces-259469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE479396B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC160282577
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207B49633;
	Mon, 22 Jul 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/rwUInr"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDE3C099
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721688292; cv=none; b=iQn8pSP1iGx0bJiP2mEdRrp/qgxqsd3bziGEq12xFQtK3HhVX0FQkuwX8BZMlky/BZSKERsQzQKMj+zp/nKVbWe0bk0e+dsLds7GDPUKk9a1P8UCZG9rlM/ZlHnrziQAoK2qkYY0QmH5BZIgndjkssufCkGNB7BkuMukytLrS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721688292; c=relaxed/simple;
	bh=2yWxV4vaPXxV/vjd9j88CDtq7FYZofdrxz/oDRxO10c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bhrwm/cQkADWmedTimfj0meTQxBI+Uhtdwb6JqcT9SWyRR/tGiOFsWfTCkiDqx2LPxc+RhPXWD2/0+Lm1H1spITdfHHnPb5VaH5ppWFvwF5ytlrfJxUQbaidGMczHBOmQqWz8s0CLMqJ23SQa3PM6mHkQQdQRYwDBb83b9Im2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m/rwUInr; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eefeab807dso58416381fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721688288; x=1722293088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iDx/Z8OqBQ+14bAhUqZ669gjEDo71IzyBR5INplIbv4=;
        b=m/rwUInrKvToNLR7lqsbpcfV/ikWxxciSCeFT9FIzLUCX4YMQyFUCfzofEKGC3NvmX
         fm+C0qvvyvD80p6MGQ33LSzNEY3yXLoE5zl3uunAKcsuMjH2t6Yl3u/N4T3v0ro6GpPU
         KgkGmd8M9OiUkmOVOpRiCf3wr7GvCElpHhv9XgHdV9CEov9jD2gHRDwzuDviD3EvROJE
         MI+V6zT4eo4rfUmo6Nslx3c8lBrr87+C6imF9Sisn+KIcAQnk/W3zghEBfUaMFRAVMQP
         OkuCQpsTQNm/YjkjFwFJLd+GYppRi/tfKnfleNdMkbuZlCZfQ0mm0roSoOD35rKaFbTK
         7FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721688288; x=1722293088;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDx/Z8OqBQ+14bAhUqZ669gjEDo71IzyBR5INplIbv4=;
        b=ZL+DzzSvb9XzQbQXb1A161LLIwnnL6kOTwKdoDIhFGTF3ryfTmfeemNspm5fqC+MOu
         sBLqEBlpYlxf7rsh2b9808dVhKRxMLMggHD3uBHZ5SSFZ3dZJelUH+o2cDMutWeTPmLo
         k9bUMtBRd2hHlvkXYsmCIucDgTv9msk9TsLvqxGKob649plNA6ZNUk07Dx2SmXovaVv6
         G8mI47Cz4vG3LN0qk7eR7Vd/uEKOiiLcxiLww1jO3PP1DAGrSM2kTeMqoCcWuVcBX/Vn
         9T11mRFgDfhpVBPTWljJPAziUzkPecDCn9FhCHRT4syBTNTXAvYmFuaG1zA+h1bZBFYO
         BrKg==
X-Forwarded-Encrypted: i=1; AJvYcCW3MFtoTlroeB8t2sPnw1nut7XAmPBDza8Uw2cwIZDzPSX2kT+Ptek6A/Jh2exT7y+EBCWsU5/6wAookJMEvQGXXXAH7k1CHw5nou2b
X-Gm-Message-State: AOJu0YzapYQlUZ9l1ATepq6/NOBMw3uw0Z1mF7kGaw0huBqArdhd+vQc
	PRgPESftyjGPaVbvwB5lH3kRVXr7HdcVAVZjg0YG9pTeuqR60nh43h/DzSSW9kHBeoH+ZGJAJVI
	o
X-Google-Smtp-Source: AGHT+IG4D2aSP7x41dgvgPCshR2m/ZwkygTeLAVdj4W8gnTRCuzN+cR8ieKjmWd/iZ/dzwHTnq1Qig==
X-Received: by 2002:a2e:880c:0:b0:2ef:2dfe:f058 with SMTP id 38308e7fff4ca-2f01ead9011mr6910271fa.42.1721688286579;
        Mon, 22 Jul 2024 15:44:46 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30af8384fsm6738012a12.44.2024.07.22.15.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 15:44:46 -0700 (PDT)
Message-ID: <22a9c550-4521-4750-9937-868ccafc654b@linaro.org>
Date: Tue, 23 Jul 2024 00:44:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: pmi8994: Add label to wled node
To: Rayyan Ansari <rayyan.ansari@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org>
 <20240722-pmic-bindings-v1-1-555942b3c4e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722-pmic-bindings-v1-1-555942b3c4e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 1:47 PM, Rayyan Ansari wrote:
> Add a label, which is a required property, to the wled node.
> 
> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
> ---

The driver can still handle it lacking, but let's respect the
bindings

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

