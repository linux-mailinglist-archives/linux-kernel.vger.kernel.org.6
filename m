Return-Path: <linux-kernel+bounces-436017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0AF9E7FF6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 13:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94672166ABB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE0148827;
	Sat,  7 Dec 2024 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZcbW689"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D801DDEA
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733576052; cv=none; b=YUutUpBKXsrHup5KKak3d9EXApbvt3kAVE+IutH+ow+d3JhETTX0DU4Wny7sCFL0tS8Mm5hF1bpleHv2AsII0ZRjfGf2W+YzUJLKZYKcZ0ezr8YSNrwmyIoeqR3RkK2f6b2tN2ALb6uNubZrqoVvZm+VP/LkTwkgXjLuF7fn0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733576052; c=relaxed/simple;
	bh=+xpWbnlKN0xIcwG1gfDbBIpqe9Xe15ljIylCd0kf7zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjtyKUs9fm4RFu0l7BUAkCUDXWUwo0OTI569DW1b4cDa3ijoDjHDA8Fc0Z8E/Cpq/vBAsJf0gemIW0THD2uJXn7btp/sE/iGbT+44NAboTbxxuBSTVv2+dITq9xHYy9N3Vk3e6J8Red2VCKNNs0Gjw6MIEA6ZDvBpl6iTEWbxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vZcbW689; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa650ccbe0eso72838166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 04:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733576049; x=1734180849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xpWbnlKN0xIcwG1gfDbBIpqe9Xe15ljIylCd0kf7zg=;
        b=vZcbW689fo9hzgFT96Kn11WBOtOmQxJIb0z1krKuK/Z4iKbkLRRwB5pv3My+Ec7mO0
         v1Y1DJUC5O0af/NyvYZQ1EteMj1qnoGXF2m549WDFNmrpHtGYvGvOEUs9KBWMnk09LeE
         i1ZK9HohEIofn7JLQP0ZNdkZr6+5YqyDe86AAEm33SpYEz6mzcB0d1GF3wWpkyoE7oKA
         wDJNwXkU2kTfjHS6JRgfbADXToFAy4sSpZY7YPJdIqlXVibmVN2Ds+lTEvR7cOTnFltG
         te6zqD5lZnmHHAk2n/3fwVdFf2vob419E2deYM++vHOBuMTBBxROTCa6xyOSKGd0kbKB
         OlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733576049; x=1734180849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xpWbnlKN0xIcwG1gfDbBIpqe9Xe15ljIylCd0kf7zg=;
        b=XZhoQzhIrM/Kw6pGurHeaffEUukhesfPdI49XjDWJrkqlocyG81vAha9YB5QVFgZST
         8z76zwuj1usCoO5DsenpAbIK/cmOhCPAQ1v+CZXuTolRAZ3S4nzg9gs4O2WylEu5lMRi
         wLeGUOw0OJUN6QIDhbr38lQa4HMLSKrzEsXksWSxOC+rx1ROG3WfFnrv/JZpDS3KZx5V
         pVmXKkzDeKuIS5sbjnuRh/Bj98BUnQ6nqF+2Hzs+cEaiuNtMi/AL/k8jjdOow8+Lwa1m
         mRizVuxCBCYVm2FtSoXMrc5E3XKfTGSollwia+HrZTElVAMoMuGgAZO5AFP6jRcPgwuQ
         WDjw==
X-Forwarded-Encrypted: i=1; AJvYcCXoIiZKsAabAcyJ2yi5uwIBt2v6VJuOjE80IrgXGGz72SbvCWR+hui+w4+DwZl/aPSd2WUdeldvcfrdpnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMSWv7Nkgp8tlUZKZRCuHDPntkUFA0hDWNRWZCJw0kvp7PIFoa
	kaBVORNdDB64laMDItjzQ+QvG4CUeyNWr/aRLRMSg6/ohcG1pXXS9/DglyarAOg=
X-Gm-Gg: ASbGncuwgrqw20H/q0OrT7E/FXlIPJ3Q9ugk3e7OZtsOVUpMDwhgrIGADvp6NFxD3wq
	0kzkx9n3MJyX45ckg0G/Hv/3PX9svW+xda6SgNrHF1ECGpnLaiDQ59glYql18rByxMUAiEvvnYd
	i+1yd5e58LI7MBdnex631KUX1TLlfSGfxxsJSa2bYsfNl18WokFhdbgL3dhH9i19D2h6KA0st/0
	BuqHajwqUtR837Gd1FcESQjvqXaGER45btAYb0YM1BTm4TVNcQOgQA2NBcahUo=
X-Google-Smtp-Source: AGHT+IFc59lrx1M6saKGPjF02Omnnsj0HLfp4v7ByL1sRkcUPHF3WsyaIILgsB+Yi9QNF0Qp9YtwjA==
X-Received: by 2002:a17:907:7814:b0:aa6:19f3:d083 with SMTP id a640c23a62f3a-aa63a07357dmr584148866b.30.1733576048745;
        Sat, 07 Dec 2024 04:54:08 -0800 (PST)
Received: from [192.168.0.27] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66b96a249sm19541366b.159.2024.12.07.04.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 04:54:08 -0800 (PST)
Message-ID: <444a0d03-7518-4f54-a29d-2d3c85d9743d@linaro.org>
Date: Sat, 7 Dec 2024 12:54:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: x1e80100: Add CCI definitions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Jagadeesh Kona <quic_jkona@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org
References: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
 <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-5-54075d75f654@linaro.org>
 <b5400627-6359-4dfc-abb2-2c142217a28b@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <b5400627-6359-4dfc-abb2-2c142217a28b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/12/2024 11:59, Konrad Dybcio wrote:
> Otherwise looks good and I can attest to this working, as the sensor on the
> SL7 happily talks back

:x

---
bod

