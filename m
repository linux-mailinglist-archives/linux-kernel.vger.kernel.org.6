Return-Path: <linux-kernel+bounces-213663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17690787E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCBD282A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B8149E08;
	Thu, 13 Jun 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3Pr1YCE"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437D149C69
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296937; cv=none; b=sqVjUutS6NqILp5Q/lwxBlIlkSo7yj8emS+c1FtlwEbCDwKRdvFIDgyULjrHgHaoIrkrqkZTHDdUXl223SfDgX6iJsOvE/SierR+ua9B5oaoLDUrJf2sU6aMTTgZe0d7xFBgRFS77N2qUHLRSnnKSSZMB5g+jS/pPUkYlYx2qXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296937; c=relaxed/simple;
	bh=d4Zivpa+Kr91lXBluwGJv6NkuP5Fp/Zrezb2fbHpfBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIUn2D2MYqP7v4F3D6Y8UjKf8YSrnWA47G/La/3gqGZ2bnbHdHCMa4gnBWBvhMubMqQ8ht6Of8IfuzOGoDsdz9oLlSbopDBHD6ON5oAUML6xVwcq7yb6NfPrUNitSZ+JRQ43e4D1srFg0lqU8A45Oxnpo0lpE+XQskQSeqqSluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z3Pr1YCE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c82101407so2428253e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718296933; x=1718901733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxumJDVbsP4QVPvesFB523q6d4QgJEn6x6IfBmiyMhg=;
        b=z3Pr1YCEhkXBwJrTn7gf9IZ2MzkV5tT+9bpEIjRhcz1ALhzp6dnKrXQvys9HQRX+Hl
         GN3V9Ozdz7xvT/o1XqnMwsYJK/yXGuJlZTlsByCjAdfbhwlrV75cVKzEMcs8H/nz8cG5
         H+ttvmSW0AP7FB7IQ/1CQ/6cwTl/Ury2zsOi4+KE9hzEVbjjYHW4B1C8q0/vCUj0hdfw
         WurKyAElCEWu6s+RiUUMWJWGft4ILwiH+GmQl9yo1SDszcYXEdScQTGuLKNBUy9RkgBg
         d/kU+CLg0KmNIe3Ny0Va5CYo0jKqCcdgrYGpw2VABqZ7mQStiJX9YTCL+1iQ5tgy/3ia
         OvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296933; x=1718901733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxumJDVbsP4QVPvesFB523q6d4QgJEn6x6IfBmiyMhg=;
        b=pLcZY1SNWoZWMd2SekhuKlPyUaMlDJSzfe3QqzM1pygFz2zki/SlxAssePoFveLMH3
         6QxqqwTATZuNMMdzYjYUeNcBtidOnCtxjzRFQy0uC3O5/5gUVPkIcWDwQbi2A/noG/bN
         uAyJs92JUIhs+2Zrnctkh0+j7hnvTxqnKWtcvXmw5XiCrDoqMKJGTyVv/TVY/GRP9KQc
         Qy8xzNliQYwYq3BsLgdezt5dEE7qSk8Xi3ekVCxZzmP7JdwXOLDulLG5FV79O+UTDHQL
         OMg8YwgQXlmbgwnMR/hkieKHZ91RILJdxHMH18Pei2cLvDUnemssmudyKXufa7oji1zB
         qTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcXRTBtWSWSDymhcx0704olyG3yDBa43XvuGHaicTNQnHj0r6HCRboYXI8iGoQbFB+6RhnZ0PlmHuzaC8ZeDBgDT3/wtbdtfTf/pH0
X-Gm-Message-State: AOJu0Ywj8Kr63HROMXN8lRTsO8KO33rAne9J1IKnyjU8mmrhR1AmQvgn
	p+zU27qa+e4glHDtiSHiLz15BkeiRT6zC8tNvkGUcA/IqA5o7UH1mNbdYhstd/k=
X-Google-Smtp-Source: AGHT+IGSM9D0UjKqMRrpwUBDckCv+L+W8oy5sZf9E5Weqo0lZ3R41sisP7y2M9mjYoz1A9XbBfJtww==
X-Received: by 2002:ac2:57c3:0:b0:52b:bfa7:66a1 with SMTP id 2adb3069b0e04-52ca6e56ed4mr226505e87.5.1718296933016;
        Thu, 13 Jun 2024 09:42:13 -0700 (PDT)
Received: from ?IPV6:2a00:f41:900a:a4b1:9ab2:4d92:821a:bb76? ([2a00:f41:900a:a4b1:9ab2:4d92:821a:bb76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282564dsm282363e87.9.2024.06.13.09.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 09:42:12 -0700 (PDT)
Message-ID: <1cfd671b-a4d1-4edb-a2f6-b91b6edd7b22@linaro.org>
Date: Thu, 13 Jun 2024 18:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: Update sleep_clk frequency to 32000
 on SA8775P
To: Taniya Das <quic_tdas@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_jkona@quicinc.com, quic_imrashai@quicinc.com
References: <20240612-sa8775p-mm-clock-controllers-v1-0-db295a846ee7@quicinc.com>
 <20240612-sa8775p-mm-clock-controllers-v1-8-db295a846ee7@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240612-sa8775p-mm-clock-controllers-v1-8-db295a846ee7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/12/24 12:47, Taniya Das wrote:
> The HW supported sleep_clk frequency on SA8775P is 32000, hence
> update the sleep_clk frequency with the correct value on SA8775P.
> 
> Fixes: 603f96d4c9d0 ("arm64: dts: qcom: add initial support for qcom sa8775p-ride")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

