Return-Path: <linux-kernel+bounces-259483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1BC9396EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC211C21875
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FF4D584;
	Mon, 22 Jul 2024 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YC4hF86Z"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5A4655D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690616; cv=none; b=hnrvc3Yh6LwX4zPJ+sgGyad6e/jCyt8XkR5pWmkaqImndf0rvbdlpePVHpRadqt+4RaM4+ntu/byTYexLaMwgy3r5+Z+uXLfnvnXAgjtkuJwoYTm0Tp63QQ0P2iyLQU6PF7sbWnKiJE50dnDOrmSUATT5Q6d8bHa6CRVk0nIiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690616; c=relaxed/simple;
	bh=Jjsz9RBjVlRcwVZ7PsvOL7PnM+7Qvpn4fvgBGNXVd64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IslCbAP7mgY5B4HdeiRmjVKiF3AbNM72tPFOTyNM9IzgyJJUzdhgn40D74/IU53jYtmebmLxk7Z0LWV7Kh7byU2haFWABdtCLtE6HRowVHACcFwDSxDj/zj9SRL/pcz930f7yDpFwVB6QObsWeXJ339aYbfz/TQ6u/MO4QJt8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YC4hF86Z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso3679072a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721690613; x=1722295413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F/bPmpnlWDTIeoP8kPc97DtwrLgwZcEyORC4hxHeHHM=;
        b=YC4hF86ZOsoyItPZcOZaISV854vwL6U/V5f5nX4FObnlvaadnOt5Mg/OcVVX91u/Hy
         xYkp/4hJethT06Fk3fPsicgSW1SxFzHVH7aQAwwQ86ncFEKqyxp/sr+zz/xV4Z/m+i5X
         1lKjqGcv1P1EsdQYAQ0IzCrmkIZ7ygHCY+BQWHoYBxWgew7WEK+abjBrexjcYZ3icby8
         jmJWH1UD+BenSaMGHy3ROBnVj13C/x1L1Hz/heDHsf1ESYXcgpjKt8wzNz911UedwuEM
         OY/4FV7eGXf2d/3EhiCVvHH7s9CEEchLNgxy/PIcqGzj7PHtSBv7RAgOWssOJca4zuUA
         iGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721690613; x=1722295413;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/bPmpnlWDTIeoP8kPc97DtwrLgwZcEyORC4hxHeHHM=;
        b=H+/1py5+cUWriluzodl1FIP2Mi0d0nt4LSB9MeYm0p+nrVJYSo465DwcoOvykBMS5n
         +en+E/WdVfjmm96Xrx+A3IoOtM1rV7FzyXM6Z6rqla6MsyeBzvLCTwgkZGIpelZAMde1
         C8eePhbtNZHqnDMJtlQ7INmRwRz7d6mQHsVWyNVPaxSwAAhCmMDrQZUY8FrOP2HruK9q
         spzaBUyhb6yEf/x9kQkUNk4VLlchV5FA/I5d6o3EZ5VUQKkq2xaQFmd8MpLf48CuYD0/
         hUOhxYbinJFJv/4EI+J2AXotmkYMwNWGuGlGXchTfkXyay2xCBR+N71mB/EwIsIrQKO4
         U8GA==
X-Forwarded-Encrypted: i=1; AJvYcCWoM0Gb7gDNaRXvBhzXK90mQ0ZOERd6ghFti6cfZNtJNzcp1gELqG+DEISNW0f8DIGdkel5RrIAOh5X86jOWJoZqe6EbesuMc3zSAe3
X-Gm-Message-State: AOJu0YxEOhzU0m2FCPm65rW6vNjl/bzEhKX1Dyqn4mKGuTZob3PqhFEi
	yl3k440NGlfSaPhnWHlwpJij12VMSUmnaIzAueIqRgWnBjQPQK9ZMDV7kgPnvK0=
X-Google-Smtp-Source: AGHT+IEfkUnFLmhrN0VVcmXVbsGneDXQVhNgIvNZnYtj7Aqr5nLVm1GpgsW4kTW+ESM8KpkR3sbZSw==
X-Received: by 2002:a05:6402:510d:b0:5a2:c1b1:4c3 with SMTP id 4fb4d7f45d1cf-5a941f17a9fmr906886a12.9.1721690612989;
        Mon, 22 Jul 2024 16:23:32 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a7f0bf7489sm2118693a12.57.2024.07.22.16.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 16:23:32 -0700 (PDT)
Message-ID: <4fdca4c5-eef0-4679-9828-4f69d5dae90d@linaro.org>
Date: Tue, 23 Jul 2024 01:23:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: msm8998-lenovo-miix-630: enable
 aDSP and SLPI
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
 <20240722-miix630-support-v1-2-a6483cfe8674@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722-miix630-support-v1-2-a6483cfe8674@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 1:57 PM, Dmitry Baryshkov wrote:
> Enable two other DSP instances on this platofm, aDSP and SLPI.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

newline before status please

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

