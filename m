Return-Path: <linux-kernel+bounces-192317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8488D1B78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A831F22504
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D95169392;
	Tue, 28 May 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1r17Z99"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20416D4E6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899978; cv=none; b=YvLUjLKiyNo77oU9HUPlKEwy5pK19LOIATl3S7kJY+zspLwV6E90hhjW/P/UfknmvYxCgli3KSaZTvr8JbnZYtmR8u1v7O6AalCu2zgC7M4TVFaad+VSNKmBEeWBvbTBEq8yoLsltGZ2l6FHomhKejOpvhfRpUTbMXwm0WrAZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899978; c=relaxed/simple;
	bh=3QD4cHZEvBkjeUTn2VP7Mro8lis+DUXvuC0yPXY2hVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmTl6wxdWLg8BSFSDcHDwBzyRh6E9J+Putc3qVXAaliMPlNfG5yOfFsIDAsyVsgPHjLlsyW3KGDinlZPOw35BOIWVc0ckeNH0OwJKMa/v5qdd+vEOAaim4yOn+/v7eS75uWqKPvayQ8ViSAjJozWAVOHTfdQd3HhtLaWkT+ZkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s1r17Z99; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e73359b900so7917021fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716899974; x=1717504774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MyyZ1avD99OZmFrk135FGzfKRiqqWoc5X9qTav7HvZ0=;
        b=s1r17Z99h2ngAtEyxx7p7I4dcguGQ4x4HEUC2U2mTFqgfZWoXI5T6+Fh9B/zk0UviU
         iNrRGGzBcs/2MfFiuurQ9fsNIUlVCq9Huw9j/rB/OCGQx7kE2hTjN+cMK48ZVX7k4gQ7
         EgaRLj0ACU9cCjJexiKZgTXeyE9uRa3A0Knnza3ngfNS72ZYgsyvvxvrhhUqxMb2rRw2
         obLN1bXliyeLOPgI36+b9cx+6ngSPxnh9GVHe3MmsnloV1e8RheIRVob8JoAEdaTgPwc
         asqWsh5h6/eRNOqVyeKoBzXhpIWP/SMoshAfrP5/ZZxxeDqlxvYpa9ejgHGOveQ/mS8s
         tRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899974; x=1717504774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyyZ1avD99OZmFrk135FGzfKRiqqWoc5X9qTav7HvZ0=;
        b=ExKkKSdM7NzW7JqrKR16Xf1MiLPtNlr/b0W42nL1v+zVlmAIgf+G779cwSJhmAPzCX
         KYFEEC3JQshBlrujAXOB+uoawh34mgVCFj0pfvFaNVC3qdJNDBNvpj4CAj6cbQFNx7Aj
         Vv8+dwRMAbGI5G1Nl81ooOZmtTo56LRTxpcDzYRjyKCyk6uyH6RAocHV3dIHAKqWjvhE
         0Ga4Lmzg81s8pmt5xPwkGqR3S99e9yIyXmvwKCZJEzMLkp/lUqrAli15029hgzRX6VhK
         yt8qkLOc2Ic60Jl1l8f/JdhvTU828AuREKvUnK4/ZJX+khZ75hleJmDYVoQTrzoBj0sm
         N9MA==
X-Forwarded-Encrypted: i=1; AJvYcCWQnH2gsWUg0PgxWOLyRFRBQDl4LoCz+/Dv5BpxfDnbsZgY69LfFKtmhIMx7ucr1I1WOMvhdcDk4IqXwqEDjsbU7PL298dZXg4dlUBu
X-Gm-Message-State: AOJu0Yw2gbI5OsCUPyyuCVAU7Z8Omci5IdHBp73Zh+VnauYeiG7jQiln
	na94CnBTKcx70V3BJU10ttNLOP93fP/y75FEUcUh04BLlDG+hUQyGWOVbY6StaA=
X-Google-Smtp-Source: AGHT+IEuLhZJv7qeXezlx8kfsTgFOdfKulgrE/pHZmC8bjKegp4bpVB1CU8ydw/L2kKkl+X6jB3iKQ==
X-Received: by 2002:a2e:2c16:0:b0:2e5:8720:50d2 with SMTP id 38308e7fff4ca-2e95af3493dmr78535451fa.0.1716899974195;
        Tue, 28 May 2024 05:39:34 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c97:23a9:35bc:df2e:d894:2c76? ([2a00:f41:c97:23a9:35bc:df2e:d894:2c76])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e98817eab1sm1386381fa.55.2024.05.28.05.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 05:39:33 -0700 (PDT)
Message-ID: <a205c018-2181-405a-a4f4-4211b1113c7a@linaro.org>
Date: Tue, 28 May 2024 14:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] clk: qcom: gcc-sc8180x: Add missing USB MP resets
To: Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240525-sc8180x-usb-mp-v1-0-60a904392438@quicinc.com>
 <20240525-sc8180x-usb-mp-v1-4-60a904392438@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240525-sc8180x-usb-mp-v1-4-60a904392438@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/25/24 20:03, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The USB multiport controller needs a few additional resets, add these to
> the driver.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

The numbers look good

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

