Return-Path: <linux-kernel+bounces-218020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87990B813
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DFB28102D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0C1849EB;
	Mon, 17 Jun 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmU1QC3G"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648B1849D2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645453; cv=none; b=CypvA+jqXtU7An/40gyUu7DZussf6LyiLMLzK/N/Q0xyaDZdirjvA80VAbTV2LOvZq+fFUiwXdL+FOBEON8YsVOuXeKEQoYQ4VuJz862JOpD3DHB5sbY7BF2HpObmuG66OWcIciSn7xnGsFEZSvV8KrwbcEr6p6XgKV5L8atm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645453; c=relaxed/simple;
	bh=PrulDNgCa6CKc++xmkdcf4hN0tWVwEQV7zqz+fqsd7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAjGZoPEfTSdhIsUoC0VG6jMMFsLHBooMqI2oPJmywcvU2mLdu87V9n27MOr0Rga+tvRMNvPU9fe/fF2DMgzQ1v0uFz0LLqP784efCDl12LB5HttwEEJ88PyiekLuLP5IaybqB9pipxyKN5NPE8bmssyXWVjGQLgV/J7sufHVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmU1QC3G; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaea28868dso63289501fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718645450; x=1719250250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OoBuZAZ+2pfTMn4Ll2JafBA3zVFZwI8Mh8fgrie/hrM=;
        b=VmU1QC3GTihT2yEVnLKLMMkeZOD7IOEeIwm+iUnDzl67U8J6UWB/xKTfxLgaYqKj2I
         8cc+yU1ZNSbV1ltEQYV6p6vs4cZdlAKMyV/LbGpqhnt4v9LQaxgJ0rnwKTWy+ffWxmum
         F3PslqTw7iiAILqjvTzb+Awkk6PXNiI7GLNnIFht4bu4KTWFazIRap7Eo/Jnvj2mNWza
         nIiV7u37q9efJdVmgJYqCtZXpTPjiKB4YT6fWmu1FCVKp/4oV74xQ29tr5VBI1ClBfE7
         PpfdjdQQ76nTV4L1o64F/USfXNqySX3hGOREYAfqisr+L4F37ZCKgHXQ2POqJAimII2s
         GUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718645450; x=1719250250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoBuZAZ+2pfTMn4Ll2JafBA3zVFZwI8Mh8fgrie/hrM=;
        b=ZTrTg3VorUEzzCeTbh1WC+CS/Ow5ejqzyWEicGJPlYTyLv81gX6qHeU4RpV7sSmPc2
         A2jJHkLFP8tYZwCPe8ZnU+NRHczbZ+hHpCoqRnwHguPwr7AC3N+NgM7V+Hk2qjoGqb/C
         529kybiEGntXFXxOuODhg3FkZOEiHZj/uJGjYZtQ3LGbwDZmUhuborMVy/KsLitRt94D
         M9YkQ9Nl8YySwCKgprARwNIdgCJcYVHPhVSqucYI3V/YrN6vt4dRcWkBVpj6d4xPSFgi
         JteBORS4Po69U/6dAiZud6qD2EugGef5hcwqZ9+W80euK1yK1mtN0eDCr0JEEJO9mnyL
         akEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgzu7WLzmw5MNJT67J7cyvjTszaMTeJjRhAb7iBbKtLfo9mVZbTsjYuKBC1T0jYrfevbhID7d5Dw0NM7QYe3rTBYtGktW6Ktr3cNgi
X-Gm-Message-State: AOJu0Yw+P8gwiHST1vYo4m1eu+N0+PL0MT5Tap6DKenMFoZ1oPr628NZ
	/feQGcyeFZQW9OhFS6uG7wXDXDBMYH+BqKbKlHU8neoJH0Q3oPaMlvbEyIA8d5U=
X-Google-Smtp-Source: AGHT+IGl3hd4bc3XW6DzjvhQE1NMXroKSu3kRK6S0j070rGf1oBQVbVimJwJU7/TLJN9JzfF7Tf7Uw==
X-Received: by 2002:a2e:2410:0:b0:2ec:1779:fd5d with SMTP id 38308e7fff4ca-2ec1779fe9fmr76764921fa.19.1718645449812;
        Mon, 17 Jun 2024 10:30:49 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cb2:a9df:20fa:cfbe:9ea6:1fe8? ([2a00:f41:cb2:a9df:20fa:cfbe:9ea6:1fe8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec31c2f742sm2099951fa.85.2024.06.17.10.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 10:30:49 -0700 (PDT)
Message-ID: <4510290f-f279-4b02-baf2-1db508a326ef@linaro.org>
Date: Mon, 17 Jun 2024 19:30:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qdu1000: fix usb interrupts properties
To: Komal Bajaj <quic_kbajaj@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krishna Kurapati <quic_kriskura@quicinc.com>,
 kernel test robot <lkp@intel.com>
References: <20240617115624.29875-1-quic_kbajaj@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617115624.29875-1-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/24 13:56, Komal Bajaj wrote:
> Update the usb interrupts properties to fix the following
> bindings check errors:
> usb@a6f8800: interrupt-names:0: 'pwr_event' was expected
>          from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names:1: 'hs_phy_irq' was expected
> 	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names: ['hs_phy_irq', 'ss_phy_irq', 'dm_hs_phy_irq', 'dp_hs_phy_irq'] is too short
>          from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> 
> Fixes: dd1bd5bf7420 ("arm64: dts: qcom: qdu1000: Add USB3 and PHY support")
> Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406171241.YKuCm3SC-lkp@intel.com/
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

