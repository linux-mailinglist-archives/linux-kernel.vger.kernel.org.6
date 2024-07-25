Return-Path: <linux-kernel+bounces-262064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5528B93C040
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960C51F226FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2281990D2;
	Thu, 25 Jul 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMJiD02u"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AA199247
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904161; cv=none; b=vFoDLziRnD+VAKEBeLXS+Mz7Kzr+wSTE/xitpVkHHIuu6kjhwyuwqeAbifQ+g6zITbwh2sla2WNWCsReaMfYHBfkn5kVQ8il8aIKY0IYpAzoViWiaiQ3czBbxAsACpnCBRN5kgdfXkmo9fsMmc5bdjGnzBm2Rr4MLMzNicC3uoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904161; c=relaxed/simple;
	bh=fwcAuKE2qko+BwM54v3qkXGJhc+Z/oFchqprNt8GBs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6Tyvz6O82boOnWBRZmL31Cj3x5j5mvw2G+6N06dOzPmIoQug0GFKWcd8ETfJs6zU2tiKC2Pn+Oz6oiElYgVb8vTx/6N60nD9UuE7LoUjtGVfta7kh9q9oiBmyuGS3vffFiKs9vS+0k2IeWXUr5JoDbITORArqqxHLu/dKSjxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YMJiD02u; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so1042494a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721904154; x=1722508954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d8Th+twLnOPBvLDyYnk8kw41D3OdOBHwcMTsBomXKeY=;
        b=YMJiD02uzwDkwBuYnrbwL6ck1HkY5qM+PfP5ErP+PjcIM0dkGByu26LTOUVd5I1fOw
         wQK7b7IabdeLjwuRE09J5OrMzhUCdQTkBI+v0Xo2NKfPmzajp+/iJ0eksnn9N3irkVzw
         f2cySr4liQeRoKD+OKWNXBoJIVxpZrCAjn0WkWseeSdiNHztZsgnW60KdjzkbDVu6wWs
         BUXcofcpMApYoUkUjcAZNWEf8UP7pqLY8O2yFxwOEDOX1gL91KkS2J21hFlM6aYsldCK
         4BweSro72aXDhuftNwLxdqsSI6U1D3l3dLDtElHZhgA4VkcfVrKg/4bb9ZFMCNBpUqKp
         XZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721904154; x=1722508954;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8Th+twLnOPBvLDyYnk8kw41D3OdOBHwcMTsBomXKeY=;
        b=vW1/bRa8uJIibinN2LzORbo+7r/vZS7JZUq6Jf/m7p/GPCgp9dsBIS+xqqUmN9GKcU
         iKuDfOCHxUSCfScKdCEQIcQYrZjhj9L9IpttOOcPWJKwNC55JyitNSoahVR2/2BPrSOa
         Snzaef5vyWPUMeTt3KNtYphhAP9DUkP1wtbCeEyTSctW3RO+MWMD9+XQc8qEsNQzFZph
         VdY90uNF29VCicGXA0huG4yZXeNZSxEEZgGyGbaIALAdIxUSO6aAOZeg6xy6kTsfHwXh
         qGNyvij9eqvDNRfm9p8DIkMlLXW/wYiOXhz+I0fUCzM2MTb7sGJo7AcHgFOxpqGdX4/d
         3QnA==
X-Forwarded-Encrypted: i=1; AJvYcCXzJY5IBuEwyruBz3BlvBk36Qfl5HrY25PMKf4lW3Sgm1s9XmhD/Y1uv53zZ/C7+HCFZXzfqBIw3/Ck2gLGnXht6ue4sOMxzG50rMzX
X-Gm-Message-State: AOJu0YzIpRK1dmQK2OLjdV2lns+J+LWh+DcbLjLSzsLDL3pzpZtKHvLz
	aHPjrBMVbL4usWWU5h2E/t24ZNWcEj1khmDOaH61ShKGL6zH8MCyv92JLd+ZW2g=
X-Google-Smtp-Source: AGHT+IEUykozA8GKhHwv8ptnr1fU2vTzstFolz+zF66owW0FpXpGR9LGOnP1uKUoNr2ZXZJVyK17lg==
X-Received: by 2002:a17:907:7ea2:b0:a77:dcda:1fe1 with SMTP id a640c23a62f3a-a7acb49550emr103809266b.25.1721904154397;
        Thu, 25 Jul 2024 03:42:34 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9d3cbsm58072366b.182.2024.07.25.03.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 03:42:34 -0700 (PDT)
Message-ID: <53366441-fe3c-466e-97ef-9af5724c57e5@linaro.org>
Date: Thu, 25 Jul 2024 12:42:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] arm64: dts: qcom: sm6115-pro1x: Enable SD card
 slot
To: Dang Huynh <danct12@riseup.net>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725-qx1050-feature-expansion-v2-0-5fac4bbd946f@riseup.net>
 <20240725-qx1050-feature-expansion-v2-5-5fac4bbd946f@riseup.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240725-qx1050-feature-expansion-v2-5-5fac4bbd946f@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.07.2024 3:42 AM, Dang Huynh wrote:
> Fxtec Pro1X has two card slots and allow either 2xSIM cards or
> 1xSIM, 1xSD Card configuration.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

