Return-Path: <linux-kernel+bounces-204146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3338FE4C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B62283CA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BCE195395;
	Thu,  6 Jun 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUhB4JcE"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F0194C9E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671281; cv=none; b=QL+xWCo1dHe2zQWvL3KUEiCuRfsYxYrGGQEiaAtu+BAK7aocN5mgu8ahZHQNOKpgbT3x2eVcq7V/jFUdpz6+x8aa0kbcnw2yimp2b63UVjviWFgJFyVjbtlbV1HfDD58QYdiSJGSgmtLk4smxzbdXxfzypn3yGkOjCDx952G2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671281; c=relaxed/simple;
	bh=7/ZZ38Rb26ub/kIALSetc7KRMBprrnMzDx5mrHnoHaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRc3WxvPMf8r8K89e/uuBMGXXHPVqNpzRNgkorzLDPjt2gFCY2PMJlLWg/v39HwXHQfnvc25HKlHtySG43jbsymQMnuOYBab/9W6stMPqV/zO3WcC4CmdGVBtfQjHobsjoACbi0Lj3P6+ym+ZEk024mk5fYcPSCd0GzBfhHLt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VUhB4JcE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68c2915d99so83890966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717671278; x=1718276078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p7m0HFXR7eNVPMltTA6kpbAgTtzBIYcg5LJqNvqxwUs=;
        b=VUhB4JcExL3JIV2L+yVuzahtBluwt9R6SmIziFUoGj8GxbcSfpWleo6fRHTkSut2r4
         h+hxrt18uCuwjHPLqzbslcrb6F2X29vHqRr85bLSk3tlO5JVC2RT/Bvl7AN+Geef1EKy
         00UcdH4FiJ9b3R/6iibbpIwIjLnIbxUpoBwVRrFyE67TJv9vsMoOrpnlvz0GUmaHXhHK
         drSlArTilNgfZR3ynhoyjXYyyuTJduMJIiLvcfbV9sXsXr29f6f9NtV8hnRmM1yQCJkw
         CyTiHkNElj6W8qEY5srq2wCPfNYTnB6CZeVErP0JYb22PD3FZ0ztuImZzdkih4c7/c8Y
         Rkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717671278; x=1718276078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7m0HFXR7eNVPMltTA6kpbAgTtzBIYcg5LJqNvqxwUs=;
        b=om7ssbXQLBnotK8hWMM8v4X2XWpy6S6Ne4+NWeS32nPlHYT+abRQhTP36jitkvzKDU
         e/DD2dfeFZiMbGuHuV0Om4yyARKuBP9rvtrblSA61n6zhrGQmri1Jnzvg2FODBvq4cnf
         WjOnmgVkbtOq0bUttrz2ca3A6M10tjnax9xzdrKZzrM/WYN8jduaha+ucQS5GmjmIFi8
         uVO9i/VKLRnFNUyIMrcuZw9rLhb0FykOpWwFtwpWhyAUjR/eow1qFerCDcVv3RSJHv/9
         D0JH3yCCDTaM1a9YFmtcg2nBibcFJLQd90wbSSpcbjFdtCHgAEX/BS3/LdAOuphka5/0
         MXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUWRdkeOpdb/uRG7chHecYWZHNPnUGS9sLXf6HSeQw+hxsEx3IYlJtNfqUW5HLVf7/Gd/HWwI4I7EHKQyp8GnK6RmmUl9TARU8bktT
X-Gm-Message-State: AOJu0Yx7/SXbgZ+YQnP/7gvCzq2VEz7msCVb39czZ0V3nLySiCsiwFau
	EYgSmE071xXkFLCHlqYPp3QxYY63UeObJzwWmeBJd1oUGlswLoGsdhkL18KcMzbXXDsOiBAQ6x+
	2RKQ=
X-Google-Smtp-Source: AGHT+IESDazk1xveuAROaThWXISDv68DTcJ4bCs9Y+pwKnlpV3FOHbu4FcTE83KVEVYPbQajB3l3Tw==
X-Received: by 2002:a17:906:234f:b0:a6c:72c2:6a6 with SMTP id a640c23a62f3a-a6c72c2126dmr186854966b.14.1717671278244;
        Thu, 06 Jun 2024 03:54:38 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80728bf5sm79290366b.204.2024.06.06.03.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 03:54:37 -0700 (PDT)
Message-ID: <53314bfc-2c6f-4cb5-ae6e-adfea38f14ee@linaro.org>
Date: Thu, 6 Jun 2024 12:54:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: x1e80100: Add remote endpoints
 between PHYs and DPs
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-x1e80100-dts-pmic-glink-v2-0-972c902e3e6b@linaro.org>
 <20240606-x1e80100-dts-pmic-glink-v2-1-972c902e3e6b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240606-x1e80100-dts-pmic-glink-v2-1-972c902e3e6b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.06.2024 12:41 PM, Abel Vesa wrote:
> Describe the port/endpoints graph between the USB/DP combo PHYs and their
> corresponding DP controllers.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

