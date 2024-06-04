Return-Path: <linux-kernel+bounces-200555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB38FB1A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372581F24374
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D75145B3F;
	Tue,  4 Jun 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yp4j63PX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67110145B11
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502422; cv=none; b=JxryoRltwrsKp6TPbgLRi4t8tpin8byhikAZye6CZlcCEXGMgToC8hhakkMjd7vfkplkU14f5joXd6jO7rdBfAgz3jOfkdW3ld1RiJikst7gWRGqQvOCpc2BhKkRh5/oWRGvIwd3Wnnaln5NZ34/Wy9bDD4KWkV4AbBEI4h2ud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502422; c=relaxed/simple;
	bh=ITmDK/o3vZUBIPrdr54txC310yi36/Wx7TXNE/zjdpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqEHPtc2x7i/IKhj3JzJwU49yXAHLnm3WsipqUCz10YzDSeIC4qVYiDCkZSWPn+2xt0q2yrcG4juUgjJBPeeusJChYCnONEq/R8ma4/kiuI6qoYoMnwr1p6S+2dRaD4d1qJ6PoBQOGlhjftUdKI8LbILGCQZf+n1Q/hmf/CtXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yp4j63PX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a4ce82f30so3599599a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717502420; x=1718107220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxZZBV6os56KANAv7SzQ35RGN2CB4F4JHMvmXBGcdT4=;
        b=Yp4j63PX7bB/5Dfjtq0yJcztgKyDPyPByZJJF4b0ka/nbRCUcLtfnN68YnJfpRze8E
         ljU68VfXs7cXI8uA/dzq182y7OXQzAboxiexFBc8O2b9imQ9kowcrrKZPOpOA4W99JrH
         vP0BF4mJsIbROm7yZ/kdHBpnHiswixeuuVQav8d5qQlMxuhI1G7T9twDEhxu5c1dYN/O
         dQh3foAStCa6rqLq2guN/a8ACmRW9udrHqCWD5OufshRRFl3XxtnFNLh14lFAjqs6UuA
         MQlVRX3GmqdbdLzffrCzmgsWmzhq4UXSNFIcG/Z4BHRanfBj0LagbXzyH2OSdGd6zYz6
         Q22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717502420; x=1718107220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxZZBV6os56KANAv7SzQ35RGN2CB4F4JHMvmXBGcdT4=;
        b=hBiWlxfPy8ULOF2BotKDBFasFrCfSnXLqwWyMABklXrNaoiRiQqJZvhFfeafQxcUod
         rwCROrdWNSVZFaRw66jh1lh/CVgNeolmt1ybG1miqTCa1G3n11LAap+F5q5xasTU5vMM
         /TBU27xOxl4NZ8XbuNi7WPeG1BojqdROSblJiWtBJFHFE4WTHwq+ByjoIpEhNkJxkAQS
         jbHQyslftWC1Cndsp6e3xYFtl3v8HK/joAzM6psXSPa5VXZ3+VQTuqv92vDJWoSMsgwd
         H1eEVH/ecfWlt5Rq0FcvggrKXVfVvZifR6/kHTxAaZ75dAcWXhYlGWwi8YO3gl9Kvc5H
         tvgg==
X-Forwarded-Encrypted: i=1; AJvYcCU6lWnwfpq1z3aIiSXQzyjy3//j+rjGXzdVjQVTTPf9h4iwwHk2P8Qy8UrwpoAjeYtr5/jzRGqrqpwg8gIGF4b9ctisa3X+Q6dq3WqQ
X-Gm-Message-State: AOJu0YyzkvXluZZfs8T6x0WdXoeL6Vxgp/O5zUyyacv0V7TqAUgAsu75
	Jh2IDvzNawyL573eHQxsaQTZbCjef1nekwNi37UpkgZN1zKJhO9G8n4xkKW/he0=
X-Google-Smtp-Source: AGHT+IG7QzWP6TC0xP0LnvsUQdt79OEW+vUjnsDphskiqmixjCLQXCnOn9Q5pGxgijhnHA5ckYPChQ==
X-Received: by 2002:a17:906:a046:b0:a59:d2ac:3856 with SMTP id a640c23a62f3a-a682022f87cmr857478366b.22.1717502419771;
        Tue, 04 Jun 2024 05:00:19 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b71450c1sm471790866b.152.2024.06.04.05.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:00:19 -0700 (PDT)
Message-ID: <d93fe55e-7c65-48cb-bdaf-5e15bc22be30@linaro.org>
Date: Tue, 4 Jun 2024 14:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100: Make the PCIe 6a PHY
 support 4 lanes mode
To: Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531-x1e80100-dts-fixes-pcie6a-v1-0-1573ebcae1e8@linaro.org>
 <20240531-x1e80100-dts-fixes-pcie6a-v1-2-1573ebcae1e8@linaro.org>
 <Zl28nvnpGFRsYpGh@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Zl28nvnpGFRsYpGh@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/3/24 14:52, Johan Hovold wrote:

[...]

> 
> As I just mentioned in my reply on the PHY patch, this does not seem to
> work on the CRD were the link still come up as 2-lane (also with the
> clocks fixed):
> 
> 	qcom-pcie 1bf8000.pci: PCIe Gen.4 x2 link up
> 
> So something appears to be wrong here or in the PHY changes.

Is the device on the other end x4-capable? Or does it not matter in
this log line?

Konrad

