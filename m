Return-Path: <linux-kernel+bounces-271152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B827C944A2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73107283079
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20384189525;
	Thu,  1 Aug 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUUCegfa"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED313D24D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510850; cv=none; b=szLiqEjoJZkVdYFk5yurt9YriSYBSHsqMOg8uz/k7Ol3rm32lIPdybBG9lACRwDLp8wipqNZb/HPrRRERtJTEanygezcGAhqEEyLmGdNykNAGHEouFxdL9IYNDoauX9Cn/0xalxFtJVjXbHt+t8AuKiQVOaW/7SHt8idEK0euP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510850; c=relaxed/simple;
	bh=6DYUWyLVmKcg1VgyRdUByoU1wdW8WA65O99hCIRsLbA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NsagNNPeXdjeP/5mqaNjuDX5HVp3zTZNR4ehiDa7/HbR77IWT4WDmxTTaFTcVm3sYo+zVAzKrHkMOCHdF7ojdDCAQGEwCmQSMFQLbO37uu4/HvBJ2dmZcK8crneGZXiuQQQtCWxkyI2hk156HYO4rp6hsMgIltgI2VbukbLDxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FUUCegfa; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f040733086so79127161fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510847; x=1723115647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/AImUD+QPcEp27+UY62mj5/c2+FU0r6hvbsaspRuyks=;
        b=FUUCegfazF00olHxmYckRNPDkkXo8e7MYfsTq8oKy7OWyl0r1jSDITf4q7C3dAq5Cb
         w2p8pumNeMXgHUnj75njZCn7YInaRDuyk+JF4YrmCH8nHBOcwRjfOgONK5+G9Z8Igzid
         ZMnMeOVYbCcOVBvIfxIgVQoM84GZTER0DIZRQ4G1T2gLy9L4BRwlUTWgTipQX1lTdyw+
         clUriWdGhAsBN1bk7PACAN4Zh43aO1bHlLdqjWGvn13HXbDDCEjs9Eta8xjlEnKUabJf
         xUdZj/WatoaKnI6vv9kdf+YyuTyb9n7/gCl8SRk543+Wt94hw/PIioXz3r9ACWWOy2ll
         c8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510847; x=1723115647;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AImUD+QPcEp27+UY62mj5/c2+FU0r6hvbsaspRuyks=;
        b=hbiVhLJYVNWzJ9omPyqksB/d+ubALO4oEXlGgDowsxyNQN5Bm7/aggESjL1fVuKgKG
         xma703tbNI/9T0Ri4ounRkHnXza47eEYvqAuLmiOesz3x2OLIeRi+O6T/GxKoV0/I9Cp
         HfwEagM8izgBepD9HbYUHGLYkB9xVTxDY1o7Zres2NZaHXePEf+z6QUgppBHMF7TNHXr
         e5yOI2NzZru06ebgTB/qfh8he6lPk1z4nTrn3EznMoOhgd0B4aOxju/3kjA/5WL9/g4F
         H6cguCFDUuxFdoBTKg/0vIKOWu7MLaKs+K3SsFjjAgEfuOdgMvwfnk5eXeNSA+kBerFh
         kw/A==
X-Forwarded-Encrypted: i=1; AJvYcCWQImm0z933gyiew5ZhmLAuN5MJrrDmScR48UgU41YTHw+py6Q9OXdC3z7iN4HyUF8vQJ0J/bKHzg75q81Oe9erARS64yvaMj4Ro7VW
X-Gm-Message-State: AOJu0YylCo8+tcnFKLJlKV8NMA0KlmVUR0L1pRCs0l9oahN1irswG4kO
	/WBPmZRH5n2dkrR7npAVGbQ45Qb6opVd74Hho4cw2hg/vdsRVRD1KtT7LRp8Fag=
X-Google-Smtp-Source: AGHT+IHoqN9siHGzx2PErZ6ySMd5YwTj/nGbNmvJYtXIDVhQLKxwiGn0mDVq+yG3K1PkplijNm0gvQ==
X-Received: by 2002:a05:651c:1988:b0:2ef:2617:8952 with SMTP id 38308e7fff4ca-2f1530ec05amr18159041fa.18.1722510846510;
        Thu, 01 Aug 2024 04:14:06 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baa9071sm53607045e9.13.2024.08.01.04.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 04:14:06 -0700 (PDT)
Message-ID: <4cd4ff3a-5d90-4a5d-aae1-6017199e00c3@linaro.org>
Date: Thu, 1 Aug 2024 12:14:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] media: qcom: camss: Add CSID Gen3 support for
 SM8550
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Depeng Shao <quic_depengs@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Yongsheng Li <quic_yon@quicinc.com>
References: <20240709160656.31146-1-quic_depengs@quicinc.com>
 <20240709160656.31146-10-quic_depengs@quicinc.com>
 <1da50dd1-b170-4775-94fc-19a10b7f9c47@kernel.org>
 <4c8095dd-4f96-4b0e-9282-8bdfb5badbc3@quicinc.com>
 <9255b3e4-874c-4919-b50a-919cf0f42f75@kernel.org>
 <3011c561-d39e-4ce5-a544-33f24ca7a67c@quicinc.com>
 <bd6f3613-5a96-438a-a2df-cb2728e30c29@linaro.org>
 <30d56910-df7b-4459-b557-effc21ffa132@quicinc.com>
 <ff128062-5c1f-4abe-8582-543063d5e526@linaro.org>
Content-Language: en-US
In-Reply-To: <ff128062-5c1f-4abe-8582-543063d5e526@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2024 11:59, Bryan O'Donoghue wrote:
> for preference every single patch applies and builds warning free.

Oops mistyped

- Every patch must apply cleanly
- You could make an argument for some specific cases that
   a patch can generate a warning provided
- By the end of your set everything must be warning free

In this case though, I don't believe you need to make that case since, 
the problem you describe about probe() isn't a problem at all as you 
have no upstream dts that can drive the probe() at this point.

Just do the dts at the end and no problem.

---
bod

