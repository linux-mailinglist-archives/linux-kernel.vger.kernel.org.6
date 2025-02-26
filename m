Return-Path: <linux-kernel+bounces-533271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7ABA457A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883F31891067
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0E139B;
	Wed, 26 Feb 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADxlOOKU"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6B258CCC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557134; cv=none; b=Br7bJb4YIQ3WpuOMiJ8vNMby/6C9+xdRewVBqiRycu59TIKdUP8PrSoioZ4aNH22PqusmqgXP1NCLwjVaeoC4qfDeRcGXEJs6WXizhe9+dIWtlLTZnbtSE2I4yfE/w9rs4az8UQkabkL0vcq4dCWlv6Km3mYElVrMmxRVpp397w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557134; c=relaxed/simple;
	bh=2JL2rCAtqfAnkheH27GOKkLySUI8avARAzdgDmtQlkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAT6avrB1h3dVbpxwUxhAav+VTejkkZBYfasVXTR3aYJwWtwunDAh4TlGTzWv5BsPs1fGsjvHqr5wEbd0E2FEBoXvbxKYQX56otcNhjGH/ca/uztXii9Obxl6d3nWHvSYs03itzXF1ZVVqfO2lzOMgR3mZauzuPGed2O1ckmfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ADxlOOKU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ded500589aso1232752a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740557131; x=1741161931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/fNSVLxNPQugL0ES7waBpDq4dtC/RLAEiprTcVXkijo=;
        b=ADxlOOKUHViDflLv3PYYy7dq16ryBhAqWfG21zE2ArtLj2Ig2bffczdQA7LG1t0HrZ
         SGRognbxB0HBQQDwj2Ob3nGgRbYDTxlNgz2kPfZFUFCWuA/me2AX9GlgjmWu4AMBNEtU
         soJ5041oZs8Ux/c5df/1rmv0P/YMd13O3cpxb7x4X0fOIYIXNn5g/A+WbAQeSgC1xfEW
         CDa/qiHCtGjDy7s0SpsREL0qATTD0kvOUIfzJBKHPEPGExb90TtZYpi95ZVOPRzyi2IZ
         5a2+fv2a7W/QSx9mZJtxhTOx23+NUxz69or+QMW2fFHM6cMIdctkfAIxM2euMN8g9X9/
         bHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740557131; x=1741161931;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fNSVLxNPQugL0ES7waBpDq4dtC/RLAEiprTcVXkijo=;
        b=JtySSrp4+oJHfiCaNw2xdm3wXTyASjIfQRZ7fW79Qc0qamDsq2mNR52oQjG4qOwLJv
         BzkoDo5Gl9nOXOhArTIXbo7P5QDK74Sg8sLQHyZZi3g1jo+UG4z0HaVLkAdGeJkTiTAy
         NN6mz4uEw6TtE8oJcGi+tx/qbQRTiAYNCjlYTuTDKVUz7bwPQXF5AGPI85nSX+4MhSfZ
         Wx7kTxnK5g3dEdVS0LLm4Lknju7bSKFvIIBUvjNxlwQVEkTJXcbXAyoBclP/lejWddLb
         QFMZwGz22ijg48EtlYDIxIN7P8lH43lPoqzKgWB60kPYPLgqcEOJGSSRD/FqVsrp3gz1
         ghAg==
X-Forwarded-Encrypted: i=1; AJvYcCWuPsI89jfcIskjPNDMUIjzdrQE7IKnAZsnzSio8uSr01rLh0rrrJeSfLjieagLUa3NOOvWI6ruD0oxGTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWfeIxA3m4bNWTQYTtbKhanJFlHTLdtB/dkzp7bETSJJYVuYV
	D1zJ7jyMcq8lqSopFoLOZcWWpIpTvTOFgljLUdG9zagUKnqxqhM/WhDSdqw6TDk=
X-Gm-Gg: ASbGnctElcqg1ualQP5Bd0o/FGR48lCEUxLmritthz1kTF2oduEku9donVDfmps5vpP
	EvNIHYoP+8/Sewbxqoak8s0UPCnrPO8ryNLHCMnZ/7YFV5bDm6ta0cfgtR4fmeil69lcbjDIDk+
	OtEm120O6X8PIvLOf1eMn+JvbQ0adyw5bk119Y/5azteieJmbsTLVLS6PU/RXAmia3BQ/BCmM4Y
	i0HNf+62TiH/8J5qmMSRhE2ceSNtxTa4tfQ+6LqDvaTVx0BDya2SnKVdA+BTuSHWYSI/wHLr3PA
	4BLnMqsdcgSCAjf8c5OUklC7RlR0x6Qx6dJafzNUjr2I6yR2h4piwBmUzO1Ev35D25kx9rLptzc
	yqq2S
X-Google-Smtp-Source: AGHT+IG4qnaOheyCv+MJeqWkx95kCVAptbbXw3G1prGoJ72puTltPsXq/tHJz74Jkg/PWIJbFTsKHQ==
X-Received: by 2002:a17:907:7e90:b0:abb:ebfe:d5e9 with SMTP id a640c23a62f3a-abc09becfd6mr702503966b.9.1740557130759;
        Wed, 26 Feb 2025 00:05:30 -0800 (PST)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b6024sm279976866b.181.2025.02.26.00.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 00:05:30 -0800 (PST)
Message-ID: <d4954e5e-e51f-41c0-bca5-6e14b4640022@linaro.org>
Date: Wed, 26 Feb 2025 09:05:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable HSR driver
To: "Malladi, Meghana" <m-malladi@ti.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: quic_bjorande@quicinc.com, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 srk@ti.com, "Anwar, Md Danish" <danishanwar@ti.com>
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
 <686f583d-6bf4-4486-b9e4-20c1e268eda6@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <686f583d-6bf4-4486-b9e4-20c1e268eda6@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2025 07:18, Malladi, Meghana wrote:
> Hi all,
> 
> Apologies in case you are receiving this email for the second time.
> Any reason why this patch hasn't been merged yet. Other than re-basing 
> this to the tip, anything else which needs to be addressed to get this 
> merged?

I don't think you sent it to your platform maintainers, so no one would
apply it. Usually people ignore emails they did not receive, although I
am here an exception tracking missing-DT-patchwork things... :)

Best regards,
Krzysztof

