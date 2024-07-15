Return-Path: <linux-kernel+bounces-253021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7DF931B62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5286C1F21EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF881727;
	Mon, 15 Jul 2024 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfhINMyY"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2933C5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073797; cv=none; b=KWGZQdGS7NbQTd74NqdEeMA35tkEeSjrgjtiPxwPqj8dvqPr232Qy6KdcfFTZZ89K89st28DXVcR9j7r9xLxZL1UFjyxU6/zm+rlpfTAbQ1xxTEI4vPQ9g/fkT0w7m6wOGTMBdbL8bTDboVC8+UrD9Gq82ZLpVlL40uZOZGTqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073797; c=relaxed/simple;
	bh=LuIdkoxmTfRitlVr1Qw1AVF0/G4HTS61UzqwWPujSIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOVIygLrW4aOHPpgluHWe6JV9IHscmmBRozk/+0vli7UTLQqG+/Zqi3czE8fqBjWlvUnLVbxP3IQm5vNGziQkIyz8DVVg9PjRozKGAWOzHL6StCCEXQhtzxpLOi9RHiIaQuK05PId+gixn/3XHud8dVKCJt6fb9smuWQp/rcyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bfhINMyY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so6495847a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721073795; x=1721678595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z5hNjlbyDfPn6VY6NE2rBEAs6qfsoUKB4wcgCFIdG00=;
        b=bfhINMyYeSsDh4F3gtz78c/nXcCl/0KnhbNjIJE08AQ4qtlR5H0AhHk5JL1etPMkYR
         wCeur8rNpaxqFjMC8g92SYPFQT0fZwwnbUVLbb+y9uiXUYBcS0x6LIxoqEnIzX8l9WuA
         VdeKOR9vjKxrfwT3afT23GOT3yMVQ+OyalVmRQNtYeDpKevoZ9ldH7LDSSZThAM9rpYp
         N2/FG9mcpTigI6GWsjxa2Oa77k/fZ8mVKP07cioHpFEATnR4Q1HDBcJxzlzbvfCa5/lK
         E8PMZz4HwsExFsFIcCjsGHjPjujModdkEk+7IsTnOPGvQlgQDtZATuZfhMt0AglrS8ym
         yGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721073795; x=1721678595;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5hNjlbyDfPn6VY6NE2rBEAs6qfsoUKB4wcgCFIdG00=;
        b=tGy9tTu4dtRAYtVpa0FKU9KLGYn5BYzrNvaxMXyu9L9ksdI9UOF1QT9gLOiJ1sIpX8
         40kHhh9O2sZUlWPFEIE8wRJL3KhpkZuVYlHRioCQEvwyFJMHLXNk9CQDbceA3xA+9wGH
         Sp8jI3Vt40eZthvDQpk3pa8RxqrGC0DxhtDyxv4f9HqkYdaLUlbmugdk8AFamo6mxrcm
         pDsnx/aduZAAIpBcEvQi3atDfM+Z8hnSZT6rZ2FrwG4Oxjsc7h4/e8nW3gmFddwQ2SXU
         cSKPYBm6NHpEakNJS9EDpqFlRwr5sr5nFxem9n3WdY3JQOAgWZUDEBD+N7Zcycn0q7SW
         YcNg==
X-Forwarded-Encrypted: i=1; AJvYcCUs+E5nPSuodAV8DQmvrBVvdpPbhdfSmLZI23NQT+l+mLNeEpWcm5hFQGUb7fK+96RfSzSIr7h6fGmn5AUonMp4sSYY0AF599V6nTZd
X-Gm-Message-State: AOJu0YzeDOnlsBs4HHy+1l/WWZGW36+KeYib6nTDIWAe+iGtuuP53qWn
	+B3MH9F+asPTkkYeBfTzoSHq11RL1n8d9vfBS3q3IidPRmXAqmwk/VcN/Z1+tc4=
X-Google-Smtp-Source: AGHT+IFgfYSA6W4vSXp4JpYnaHy86o2g6R9hvIHamRK4mxIKICrzlB04dOs2ge06euGsX7P5f5Suig==
X-Received: by 2002:a05:6402:3490:b0:57d:4ca4:61ba with SMTP id 4fb4d7f45d1cf-59e9705fb64mr640665a12.10.1721073794497;
        Mon, 15 Jul 2024 13:03:14 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a276bsm3748256a12.62.2024.07.15.13.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:03:14 -0700 (PDT)
Message-ID: <16e51c3a-f36e-46ef-b658-decebcb7f428@linaro.org>
Date: Mon, 15 Jul 2024 22:03:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] ARM: dts: qcom: sdx55: Add 'linux,pci-domain' to
 PCIe EP controller node
To: manivannan.sadhasivam@linaro.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-8-5f3765cc873a@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240715-pci-qcom-hotplug-v1-8-5f3765cc873a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2024 7:33 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 'linux,pci-domain' property provides the PCI domain number for the PCI
> endpoint controllers in a SoC. If this property is not present, then an
> unstable (across boots) unique number will be assigned.
> 
> Use this property to specify the domain number based on the actual hardware
> instance of the PCI endpoint controllers in SDX55 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

