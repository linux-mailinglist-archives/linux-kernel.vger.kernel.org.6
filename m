Return-Path: <linux-kernel+bounces-257189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E9A93766C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770A9B229A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8E83A14;
	Fri, 19 Jul 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQJNPN6u"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995F8289E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383462; cv=none; b=HDef+SM1XrtFyJOV/ZbewdM/Hc9KtlX6OebCiMtKPiaudWSQxIPLbLLa982UMJCFMW9MiF33T0gdM5cQHy0q8w8t8xTRaznTViDwCBJQt0QrWX2JgqIKS/nTDpmDKRSMjZqYR8sgNsQHY7Ep2WU9+wiGCbv1haryH4o5W0vR3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383462; c=relaxed/simple;
	bh=MagCwnnVPN2/OcKFewMtfZEkar8GKGixE8iE4n7DkHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESWOwyFWsRlx2clBvhfyRpOK8E02Fjg4WcaraFwBmXSO/Fv205m9JgJsOs6TfPCWQ1FbX1hhYvZiANCvjhqKI9cI/6bAShNkO7NEtjum2RYrYyaiHtbX7W3qD0t94Jw136xLuwBVWEqXVPUd3d6pYb2AydJeqi4Fpbouz0hz/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQJNPN6u; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeef45d865so24116781fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721383459; x=1721988259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2R8lwWNbxE3CTlbuNF2fJp+MBVYnCjf/eAucXbCNhZI=;
        b=BQJNPN6uMo5gWSFllcM7LSPR6AY4wfQhfox5+Gb+/6OWvOOvlprGlJxBsl4mfQsXes
         +V2/ya0mlu0p43GHKvzzRDUxAc4CGMhDBegH2FHOxs301fnJ+Y7xFyR97UxCUa0XFUVe
         18HSIrrcV3W1bdSWqRPPZC+pVwitFeeDt+d8edYBQ9DQGLMNR9uBDEObQw67ZTkSk9M7
         u3Kx3QGPX4iqIEmfPBO3xfxMi1h7F2Y2KXBKAZDVJ1zpdvBVYBP3iLTkgPzAAPyrfD+m
         TYVOC4piwJBxdM6sl2E17sm/7w7RY0UToFBI3YOJD9KJNloCiVsVqjLjE6iICNgn5C3R
         WQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383459; x=1721988259;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R8lwWNbxE3CTlbuNF2fJp+MBVYnCjf/eAucXbCNhZI=;
        b=YXjDL1rxbh7S+UGjWwGTDKo3/dBidNf4HZ5/fTXehraGEd7p2tLtnjQnvJ1PuzguU9
         pAQGOsFzVKm3QEtSvF4izVcH5sK/SDFlT/YdJHMLXO4oFTAwlHtVqvJ/40rVRilCevOv
         7ct6N1gNLDtiHpqI+XMyDWNF3hw8seAgk6PWOfxIj8Z7uNRlra8Q6XDEhnUpkT0vzDCO
         +6IT5qVJrknlSUOWHJyYqKe31bnXK2Ff0yPcYEEw9YQm0c0PSW7aEPWwVLS91canpl5g
         G0wmAFZJUqaVr0Hwm09+OJ14ptAH+/qRNlF1Joyirpf77zYPGsC/A+06cFjU9E6mNr1c
         Q36g==
X-Forwarded-Encrypted: i=1; AJvYcCVSzv3H6jRxAYCFcZJfKUmsLj/cjwbxBFYe34L0neRgsOwBquiCXe4LjXZvL+1eo3MbcbV9x1f1ryPkZOuPD1jPUbhmGunJznXxXRXk
X-Gm-Message-State: AOJu0YxLkKcDQF6xiz1Ye36nvPXCvkC4Fp9tUEn+7ga1apr4PvNbCU/D
	MTlQ4EwqcOed1gsgFnQtHoxcs37IYt2AG4t5vxams89HnkF2/zG1P1qQgER1vLs=
X-Google-Smtp-Source: AGHT+IGflvGOVmrt+yyMqPoRwhpvc1AwasBJHTHRxQGOWVAjoxYRmZsQ08Db2bB62CSG0A9Ag7vbYA==
X-Received: by 2002:a2e:9b95:0:b0:2ee:d5c3:3217 with SMTP id 38308e7fff4ca-2ef05d43aeemr35932871fa.47.1721383458735;
        Fri, 19 Jul 2024 03:04:18 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c91db6asm7848266b.148.2024.07.19.03.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 03:04:18 -0700 (PDT)
Message-ID: <a3381f68-35e6-42b2-9628-e0da44374f53@linaro.org>
Date: Fri, 19 Jul 2024 12:04:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: qcom-cpucp: fix 64BIT dependency
To: Arnd Bergmann <arnd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sibi Sankar <quic_sibis@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20240719100247.4012087-1-arnd@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240719100247.4012087-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.07.2024 12:02 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This newly added driver fails compile testing on 32-bit architectures
> because it relies on 64-bit MMIO register access:
> 
> drivers/mailbox/qcom-cpucp-mbox.c: In function 'qcom_cpucp_mbox_irq_fn':
> drivers/mailbox/qcom-cpucp-mbox.c:54:18: error: implicit declaration of function 'readq'; did you mean 'readb'? [-Wimplicit-function-declaration]
>    54 |         status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
>       |                  ^~~~~
>       |                  readb
> drivers/mailbox/qcom-cpucp-mbox.c:65:17: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Wimplicit-function-declaration]
>    65 |                 writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
>       |                 ^~~~~~
>       |                 writeb
> 
> Change the Kconfig dependency to disallow that configuration as well.
> 
> Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

