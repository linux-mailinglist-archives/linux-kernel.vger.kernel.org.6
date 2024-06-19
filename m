Return-Path: <linux-kernel+bounces-221654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C769290F6D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B141C23B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005B158D8F;
	Wed, 19 Jun 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnPJP2aC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36028475
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824614; cv=none; b=AQdRSQ7BYS8c6V5fEJ0lo3z1hHKAsFbXdGrTjl2p61Vsa5hkRqQTFJE6UNOFgQ8TwuJkUBgp5NAwHGwF6T6I2TOhjcBq8N5eLJAp9Z066tQ0ieeBsIp10Rv4HoK66SWdWn3WUYdlaEjk5klQtto5bQPYdHp2WeQnXEchtfx7QBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824614; c=relaxed/simple;
	bh=bGrAT0XuX6HIRNqdaF1eFEFv7sX4k+pappk3LlTHjpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNYZgtDUKuoJx2VE1izf0HHpv/WZF3RmMPseG/gXyqy7GwOZubHCvle1fvTnQsoXnXZvtpl28wuW5Y9DCVq+RneOLPTHHnFaeXc6pLrwyFmHoFkF32klLCq+CFB13cIE5l2BhcSpiW/s5GshP+NmLFVSR/MQL6rMS5wlxQVPM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnPJP2aC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so75436a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718824611; x=1719429411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xW27As3CyhfzKxmc2us+WS7TrU6cHg0Z4tjRes0sYro=;
        b=xnPJP2aCDh2MMIGK+izEkA5UWO4CLVd5mTLPlKoPTP/34HHjI/IWKpQE+l6qQdUnt2
         XIikaR6voKPDNObpX4hrWAVRBJ2v/FVhsyRDvukg/VZ9p+37qFD+syDdBJAcTu/HuQeD
         y6hnMLLlDO3tF9R3aqFOjq07gNR5B3v3Px61LPimNpdVp1NxPvqfRSHH3dgI3YxxYBJO
         Jr2ujzZQuHAwZfZLGLSLUupNYtqDlNBchgQa3ek5nP6jEen6Ess2kVpkFnNNYbgnWHWt
         yTYZgiZyhJxUHMHaQT1HG9qH11h6PY9+ao9+k61mtrpZ9rPWdqdXKDMvOJv0H2DTM4nz
         wm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718824611; x=1719429411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xW27As3CyhfzKxmc2us+WS7TrU6cHg0Z4tjRes0sYro=;
        b=rgVWCf0rv1+1EqQ1ahEA/y5l8x1oyGuBlXoaLCBpF/wZqj7/IXWme8FUxKTfomjip0
         KISOy8jeOpOS0cvrzsqrCo1DhsAapdO7OAw/3NaZr4R4GEcGqnP56cc2DebCIvp7QymF
         kkG38N2xRYrEYljaFvLJ6z8mEiUjdQF+cvJg7DQaE0/9GWu8ErwAKP9NPJWDwSuaF/uy
         OX6QpSNk/TsQQw3UFzQQEZiNp3P/R/6u67KgXk2B963WIsAExyANopX+Jr9oKS19GDlL
         nrPH2AhhN5Xl9KtfJ9aJmcFInM0smjojIFO7tb8XjNZkfgZfTYW/FbDJDj9Tl/ZbVfEz
         +lSw==
X-Forwarded-Encrypted: i=1; AJvYcCXQY4J0DLcPnaMWw38xoqXNGC8hw6N9y2XDGaLEjOOovW096n7HUlLCrP8npEXqhXztO8XzfLsJu+6ps4zZVX6YYnDR6YODNduo8F6J
X-Gm-Message-State: AOJu0YyqJZBKainO0m3ITdUUJi6vycQmCQQG+zoV0GC2Dzc/oU6icX9+
	O/dFgpP3tF9rEof3Uvh2Ysb/z/RCcXnmMYzBxUTWmpTaImHSUWrjP4F7ulW+NmU=
X-Google-Smtp-Source: AGHT+IFwU14UM0dtxkXha3cXVSm5zW59OPajkJoXmZPv7v7qen57UTQtx+vhLPPHRqijWQnwtuQjeQ==
X-Received: by 2002:a50:ee92:0:b0:57c:6d9a:914e with SMTP id 4fb4d7f45d1cf-57d0bff1a34mr2084327a12.30.1718824610830;
        Wed, 19 Jun 2024 12:16:50 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4dba:9578:7545:6874? ([2a00:f41:9028:9df3:4dba:9578:7545:6874])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbbb5576csm8108656a12.89.2024.06.19.12.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 12:16:50 -0700 (PDT)
Message-ID: <58025447-b916-43e6-ad07-0b11710edc3c@linaro.org>
Date: Wed, 19 Jun 2024 21:16:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-gplus-fl8005a: Add sound and
 modem
To: "Lin, Meng-Bo" <linmengbo06890@proton.me>, linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20240619111523.54301-1-linmengbo06890@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240619111523.54301-1-linmengbo06890@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/19/24 13:15, Lin, Meng-Bo wrote:
> Enable sound and modem for the GPLUS FL8005A.
> The setup is similar to most MSM8916 devices, i.e.:
> 
>   - QDSP6 audio
>   - Earpiece/headphones/microphones via digital/analog codec in
>     MSM8916/PM8916
>   - WWAN Internet via BAM-DMUX
> 
> Signed-off-by: "Lin, Meng-Bo" <linmengbo06890@proton.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

