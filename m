Return-Path: <linux-kernel+bounces-252833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264629318A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF271F22599
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726781D531;
	Mon, 15 Jul 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKsSoO+r"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941846B91
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061619; cv=none; b=I/lhyIOVwVO52vvJG4w73+YQGA22ecFUA6+sljz3D7BDjS/2XdyOeqrJOzcwe+S9oEAu4+4NATL/9tuq3V/hxTdnrk86M99BK5m3pAufG9MAshHMn/kdW0B+WZ3XMS7kwl48rH1Sxhm3Nz3MG8tdc9UJW/+U2gEBRvS+vWgIPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061619; c=relaxed/simple;
	bh=CXk2rSofaLy3wFWeH6LS2pGzkCI/2qG+hB0DdE/YtPw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FAu89nBatLojo1ZGDGhCidTa3oeRJfeCTk9WTWEs8b7+WpcsY7cLMR4v2cIU0hDr5F2oIGSTWS6JyOMjmFm+8/itTIKkSkN9ooFms1s9Certc8FjG8BMRROyimRNM97zF8fEHJv4WsKPZFgc6fEyY7YDjxWc4qjZm0JNFqbhdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eKsSoO+r; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so83421521fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721061616; x=1721666416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CkSiDi539inz2HbUEC736T7JdYcmpz5s2RCdx8qYb+U=;
        b=eKsSoO+rWZhQFN3P8kIGWdBD1b2w51j0BieqDoQVTYaLN6/YHknwnFhZZKAYGgsz0X
         9js2bnTMa36WElVi/MyGY3hwtKd7VqhDtNBPDMm8DX8ymNn896k9zzCughJXWCCx/Xkn
         u/nMEa/Wlg5fSBxjKYwyetUXnVReOIncC3LNGz1szF4U+v4ECTXmAqsh9fTJZFuNZTA+
         1bMVz23fGci84+CyH0QBf94OiThxoBFUR7V9zdtW9w+ClphY8Uc4cnknIDC/2MRtdf7h
         6ZlHhSp6Y/7LHiRox4VbtgpNhHtXOc7l8qfeOo883LUg37p0LNID9XKdmjklYgJu9ROp
         G6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721061616; x=1721666416;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkSiDi539inz2HbUEC736T7JdYcmpz5s2RCdx8qYb+U=;
        b=NrrI8Nk7FShh1eTmD6Pfk54YOd7cVZECzzV3w/8i+mnYhSoRVAGHXFOIKmMM+Sd4q1
         NRtfTIMKoOG7r8new/HGxEVhj56gwvM3G/5g3N01jwuSylsAnHJ+jhrRjFCBwgJ5WL2X
         S3G3TqOg8uS28OVwK79Ifm6Kdla2egAmMJMOArTGP0yTy2KTSuGBQGg5FLvevvs3TZoO
         Tyu8sLI0+nPeKBeRdeclQ84u4ho8IbUV0x0wferd+t34PZ/8QIgvqyaEdvWN6qJBrpN4
         DrGnshx+thbHzmIDryW8ilr+3IqS7u/2E7gLY36YCVqWSl61w/zz00KxR7qe4v/fU053
         gGgg==
X-Forwarded-Encrypted: i=1; AJvYcCVYvZe3Bc1G2ranBfXoA8nOXxQhDqD+7XnNySDwTghTYAtyyaAVaIw6QiBP5pQDvL1BFKfWYNkjnPNxTUcLNilPi9sIP0Sps5Gx2ZW5
X-Gm-Message-State: AOJu0YyhywSAWSGRXWGtdfmg2nzWh/8CTfX/q818VPv39lRLvdGZA/Z9
	F5jm5FBpnd+gJhz0+YS4I9ERWYYYXwfJPj/dUvC6suaeqou4Y8j+x9SlLc2W8jo=
X-Google-Smtp-Source: AGHT+IFrfUlV8/N6JTGpeVlDFFeY2ag5zEWsmfP7uRfT/JYORuY0cg71/ZroBmaQ2YcZGJ33DCJvbw==
X-Received: by 2002:a2e:8612:0:b0:2ee:974c:598b with SMTP id 38308e7fff4ca-2eef2d7b38cmr4347151fa.23.1721061616035;
        Mon, 15 Jul 2024 09:40:16 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1d45sm224011166b.133.2024.07.15.09.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 09:40:15 -0700 (PDT)
Message-ID: <9e6b58cf-46a6-4f6f-81e3-3eba6ff4787e@linaro.org>
Date: Mon, 15 Jul 2024 18:40:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: Mark APPS and PCIE SMMUs as
 DMA coherent
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Qingqing Zhou <quic_qqzhou@quicinc.com>, andersson@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715071649.25738-1-quic_qqzhou@quicinc.com>
 <0b7fa651-3355-4548-90a9-cb6d87fa6494@linaro.org>
Content-Language: en-US
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <0b7fa651-3355-4548-90a9-cb6d87fa6494@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2024 6:39 PM, Konrad Dybcio wrote:
> On 15.07.2024 9:16 AM, Qingqing Zhou wrote:
>> The SMMUs on sa8775p are cache-coherent. GPU SMMU is marked as such,
>> mark the APPS and PCIE ones as well.
> 
> Please double-check what you copy-paste, there's no PCIe SMMU in this
> patch
> 
> Looks good otherwise

Konrad, please double check what you say to people on lkml.. sorry bout that..


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

