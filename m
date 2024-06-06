Return-Path: <linux-kernel+bounces-204141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C78FE4AF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA331F27D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339EE19538E;
	Thu,  6 Jun 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1DYlD5M"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E61862AA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671143; cv=none; b=XOLUbORYZ/bQGhDGs8ybRxCkSNcWCr27SfO00vW1kJwvzssGuE9o/Du+OJa2CuoSWxNQS6KyQGAapX28F1lMWvjPmjAe+2XWaHOkZF9SHbn4bC1omcpFylA2rt1R2+lBM3PTsqBhAjLpAgh6fdm6+dMYLixI92Nn9FkE/J+umEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671143; c=relaxed/simple;
	bh=LXU2+dKwS1pwbyTD1p1AsQBIrWn9NnvKmCQkLvl44v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f87OQItv6ADjpK3bzsLOpm+8WaoBgj6SHJ3Gv5nSp+UyvOAfwM1QYW2PToqtP+4doG9X7r2xGgKMhUqdcVXYbyEUnr8SyyI6PcxqAM/Aj7qpeTyIqu39VS29b2AY3NWVMSkU+HAT/hewoiPHMD4Pf3hGEIlUQBY6QZ4BnQCq2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E1DYlD5M; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57aaaf0eb0dso587173a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717671140; x=1718275940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+UZDs6ghgAxEM4v8VUI5KUViYth8+35ud5T6tlyiAM=;
        b=E1DYlD5MfNTkmwVTQUxQZQFefjquwtVBZSexoTV/YEW25PjqayunInUY+Xp9z0iHS7
         BcLZR7wA5DAmNcTFcaTfimmOGjt4GluotFmwZPx+1N753x9AYQQH6pd+j2GUr4gUjqIr
         BnuYJtpItw/OKUTe8gDpTLbUi8lpukNuRJKBaXcqH6IhwDdjmeUYUYzNiOKzeL+QK8f9
         Z/FxNIl1Vd+/a/3PNGh26aLAFD5Hr+76AVp8V0x45x/1vXDZpZYIu/uuMLxdsGm6AdEG
         1ykX63nC6ZpRpzGqlRKTvkC01YGs8HDmPRrfwj6ObpLtPIJUbv7q4MyvhDKQ4a3Wp/bK
         dNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717671140; x=1718275940;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+UZDs6ghgAxEM4v8VUI5KUViYth8+35ud5T6tlyiAM=;
        b=v3NaPvvxOBg2NHQn09DhBvx9Nn1wCgvxT9IhVRzuDdmIEk5CNRheHOG6obfsvrOELE
         mT/iE3SYja+Bo5/zdcZQxBDZ4Xs5lSk2xPXDRzhJHVyykLSX5fN93tceSJEQFdAcCGc3
         AH+jKXaU5ic21vhsYL9QJVlcq1NEpm/hHpaS9gtm2t19wq7mLRng5ULJ7BqDwRjErcwc
         zR7VMsGx8LFTZpEVRzEnLVbbPKwHMG61rg+ze4T70wum+N+SSsASQVLN6F777rGEpX8k
         /Xn0onTsn/G8MVwpt2ggAUe+B0w1gVfh+cmAChh8x+kxpfxdrSyBEhaaCvSIpa+4T9k6
         eDqg==
X-Forwarded-Encrypted: i=1; AJvYcCV6zPnsU2Z/51/KLYFSePLvuxZ02OXn9H6QQOGVnAFhXPoo00NA6MiBLxu1tSgTtCkn1FHHEN9GaGDz6ePg9FtK6ItO/gQUJ3mfBdWk
X-Gm-Message-State: AOJu0Yz5C69mwsGhWBabw2y/y2OG5mSA0sNNbjOOeQeuuonEhp8I9Lgw
	aUFwX3mFPDAdxNRGxHoP445g4VBhjjXlaNxIrq9CZPnQhBq0mtYQAPNqn7/1kHU=
X-Google-Smtp-Source: AGHT+IH8RVXRwOzGmApVbohoni97YGkzyYjAf1ksawKLmNIKAaVfAaId9sA7Tkvr1Gj0g71SVDj9zg==
X-Received: by 2002:a17:906:35c8:b0:a63:54e:1307 with SMTP id a640c23a62f3a-a69a02669cfmr317835566b.65.1717671140256;
        Thu, 06 Jun 2024 03:52:20 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa1dsm81226766b.107.2024.06.06.03.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 03:52:19 -0700 (PDT)
Message-ID: <9ef430a6-db13-4516-9e4e-5859f5def2fa@linaro.org>
Date: Thu, 6 Jun 2024 12:52:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: x1e80100-crd: Add pmic-glink
 node with all 3 connectors
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-x1e80100-dts-pmic-glink-v2-0-972c902e3e6b@linaro.org>
 <20240606-x1e80100-dts-pmic-glink-v2-2-972c902e3e6b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240606-x1e80100-dts-pmic-glink-v2-2-972c902e3e6b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.06.2024 12:41 PM, Abel Vesa wrote:
> Add the pmic-glink node and describe all 3 USB Type-C connectors. Do this
> for USB only, for now. The DP ports will come at a later stage since
> they use retimers.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

