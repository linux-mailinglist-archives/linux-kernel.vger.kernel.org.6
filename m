Return-Path: <linux-kernel+bounces-226476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E31913EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F61F2224B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A646185E6A;
	Sun, 23 Jun 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHK61IzI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB3A1850AF
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180890; cv=none; b=a98AjjkgQIOt1Y9p4FvjoQP+9DiRpOkP1Bw8cIS0ub7VVeE0vnikVQhLNhQ00FV+/qDmRO3MMcpoJ8H2DeP13XfbRgwwHtpgMipa+oQWzzhKzIirU0m22E71kdu/jkJjaI7UNHNgkzRIwaJUWiM8MK8b5GZq6hoqpE3Gwirznp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180890; c=relaxed/simple;
	bh=KhdNskchLeDApnWkGDxU5Sq24O6CEaqHoy7IJJBE4oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieA/5Elmt3Ux9gnyveno+FgjKFp5EtIxdTd6S3K6HfIa93A2WdXyQBLeGMQUJQx5QwzEojT3ad40qz2E8YuqRgAEiv9mix3bCoH4W+ZnCvDDRNE4BP1U/ocvKtwnRIdMkdBLNdkdbO2BuXuQmACZamQV10Q65FY6P3J8rsrqY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fHK61IzI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-424798859dfso31063475e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719180887; x=1719785687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PcyCWI/SyZb+hCdFNulsc2XJgQPFELvZuwY2XlhkJkg=;
        b=fHK61IzIIg/fezu7tmYHd84bXr53jRkGyk75m1tsha/nXr0ADiDanZ+74KmSkbK0t/
         CYwV2y+X6KkOW5L9eSM+TWBTE2cl1GfpHH4IWbhM7YFtDRfW5ENAT5Mu7ytsobjqPcF+
         thwj49i+VT79CrxpiQkg1oKvAFQmygUnnYs5vQI4Dp7lNk8rSTqeY/I8nLTksLp6S9Bt
         2cX2B3vYuwjiOhi7JTC9HOwDbmWN/ni6VUX8ENokVQSE24cQ+wkNgHiZ3G98LYIoBv6O
         kc85yxRHxFouenMm3mjIGSM9XhMBW7SwtSAS1AGMC3xnI1pT5O2eE4+SpBdz4uZWC1RC
         /YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719180887; x=1719785687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcyCWI/SyZb+hCdFNulsc2XJgQPFELvZuwY2XlhkJkg=;
        b=guAlBuXniaM/B9eBnvfpG+9zlp7sGh6zNJzPDyC1L8uhYyEqVsnQt4fIcFfBJasqq2
         1AxHRr4A9e6FYWCRrvMbIXlArNReeGbSBQMx9e7iAHHIg4xCD2/7GbWKkUDEVIF5b9En
         KgDIpNJzGYaFm+Hxmzf6Sr1f61DHIoFEsFpsem68Zvv5NImZQswDzpp/labasHrCCt1K
         W349j+OIEgpF12+WtTtQzmWwqsdV/1Jc73hZTkJZrwnHnxDO6662kMnm2Ed3o2UPrIjk
         MSrZJTjplo9JwzfgZGUdVQ7Bi7oCZSe4MEFMEj6cjiKTNpE6b+uM8yFdAzfNqFsf+nLp
         4X4A==
X-Forwarded-Encrypted: i=1; AJvYcCX4c1f4jrHvnNKF9RNbk0zkjZcazXNAHoBR7bHPwmNGpdciCHAgTlUfpDgjQ2qu7SiGdgcvMqT8V+TQX6w9eDpNitIUbWbFeDDLv+67
X-Gm-Message-State: AOJu0YyKgtw2QGc7Lfl9lb1KVQRSq83ARnKrMhyVOi3b3cq6bcB0hzm3
	f4rKeUUdocKuH6/UkdCxMF4mP3wokzTyu+1Q949mpK26w5JK0ndoLQurVKF+unw=
X-Google-Smtp-Source: AGHT+IFAglmH2G7XopkfkT24UuJJex/2o4e+J9z1bRPsQmuB+V8LfY2Wg7IcUlCFQg92UWR9gf/1uw==
X-Received: by 2002:a05:600c:4186:b0:421:7c6b:4003 with SMTP id 5b1f17b1804b1-4248cc66c43mr22649025e9.38.1719180887288;
        Sun, 23 Jun 2024 15:14:47 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d211881sm151103635e9.46.2024.06.23.15.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 15:14:46 -0700 (PDT)
Message-ID: <51e95bad-1caa-4dd4-b319-7bde11a13f58@linaro.org>
Date: Sun, 23 Jun 2024 23:14:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] media: qcom: camss: Add sc7180 resources
To: george chan <gchan9527@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Bjorn Andersson <andersson@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240621-b4-sc7180-camss-v1-0-14937929f30e@gmail.com>
 <20240621-b4-sc7180-camss-v1-5-14937929f30e@gmail.com>
 <3660e37e-2716-4d9f-a9cf-b69568d4e77c@linaro.org>
 <CADgMGSva0_DjYX0QVFL+i3YXmrPAuVa4gQVa-DNHCwg-UA3VNw@mail.gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CADgMGSva0_DjYX0QVFL+i3YXmrPAuVa4gQVa-DNHCwg-UA3VNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/06/2024 22:48, george chan wrote:
> On Sat, Jun 22, 2024 at 7:18 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> although I wasn't able to find
>> the matching clock rates
> The clk rate is in the camcc clk driver, isn't it? ;-)
> 

Yes but what we are saying here is you should have two patches. One 
patch to add the resources and a separate patch to add extended error 
messaging.

---
bod

