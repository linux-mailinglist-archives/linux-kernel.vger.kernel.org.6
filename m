Return-Path: <linux-kernel+bounces-219453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EBE90D2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D6C1C23C13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25838142E80;
	Tue, 18 Jun 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzGSzlo0"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA513F441
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717285; cv=none; b=HoWAfo7r3EmFjosE53BLdPSr6D9FEIvctc9v21gU50PCQI3UbF5hgi5Xh5tJpNbBXinq61n8i3kLuTZtGCONn/IyG4ji2XhBDYIKk1WGKKUME0ajjCEfi4wh6PyKXOl3Bh/jMv8Rlgx4H0IGtv+NdYvea8QsM6CzAmbMaF/yI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717285; c=relaxed/simple;
	bh=P2iR+XJO20kjFPFruIuBNlrh7wkDA2ddjm99o7r11VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/aNV47ixWHTbWKfl2dU7Zd6kAEItjrJ2excJgoquerEqmHMelQtX5YEEbtaGmGC1Y8An6m4QESVnewll+lAV6XitpbU+9wduNhuR4o0uNdCx4lyurtPgQ8yDKjm9lRJFtpzONmdjZh7rMkycdOe7ROjApnvHg/L+XUGC5MB3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PzGSzlo0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eadaac1d28so57252031fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718717282; x=1719322082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgj0IrDomaUjzBC0KLU+PFvHZCf8aMEd+R22qNfiYxc=;
        b=PzGSzlo0Z7lcLsYIFQIg1tI22pHyBodDYcKzL62oZy4QhRUf6VKi7jAkbOGs12SHVc
         zqZALJROERTqlP99kIRMpOZE2uRAFj3/y9Kqbz1eOQYyBHZLoWtRgyPt6GhAoVUXp6Sy
         7gDwIgsO0jPuM4ryC+9GbzUHL5kPYUyszMRp9I+9GBrSkyRPuUJj3oC5j0XoyNGnWKwM
         TKQYvFetVHzpS5r0UGqVbluXf+YjRa8ZEQOI7d8h1jrbbS3318r4fhPUqByaZwslkV6T
         JhHlKglb0XEh7dB+9zhdmw8GtvBsj5ReBCnZUToGVsQPrku4FrIdNO85E92cp/Wj+vtY
         u1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717282; x=1719322082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgj0IrDomaUjzBC0KLU+PFvHZCf8aMEd+R22qNfiYxc=;
        b=ve3GBxa84JJg2GvKzhfVpo8elVXJRWX/0hqPzONuzEY08pOLqNCVxkWBo0Ntn9RbCR
         hNZOGFuqJKJHWp/MYyMntNCt/71NNSwRobcN8gJpNAfehx7QRt2P+KLo7w2BP6cSLWCX
         AEF00vverTwBZhtiv/ByaaPQDRzlyB0nBuaZspz7r2vxAleAT+7LCYaMj9AhiIfRGM+U
         BHO9Q8eVwtcDmvJUzhGDTwde7gfafQl8E5kavubvVftw9MhGjSXhuyr9k+iwFwSt7DBa
         HFSOKMBdrJR43T+gixJjZOaBuKLHslIshs2oNxE2YD7i0woIZQhYvsIN3YTlIu/FviD/
         oTww==
X-Forwarded-Encrypted: i=1; AJvYcCWFT18xvbIdBvyTRRsLc+q4Mh/ZyP8UgkaexdmgKvBZF58JMw5/f47QIVZWkoLlVd3TU3s/RiqbEI6Alwy/RMh2jpeay2HZ9x13N0Dr
X-Gm-Message-State: AOJu0Ywkjs+Z/hR8rxWCMUuqEOnTj8UbA65dXsIt5DedOtlRAhOPJkgJ
	4Qmcav+oDPowQHOKRKpL/hUzP03n/Z3nITp8DDsKDlvPpOVcTscqsmFgubqrImE=
X-Google-Smtp-Source: AGHT+IGK2g/5pEGb2O7+YJ6KcJ8OGiwXCrOkIFFOMVK9jdv1m3RTPGFryY0YEY6iI7i+KanST2Vzzw==
X-Received: by 2002:a2e:a306:0:b0:2ec:343d:9677 with SMTP id 38308e7fff4ca-2ec343d975amr15666551fa.39.1718717281835;
        Tue, 18 Jun 2024 06:28:01 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05bf44e8sm17040531fa.14.2024.06.18.06.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:28:01 -0700 (PDT)
Message-ID: <9104638a-fe7b-4503-91de-7bff3c518eb2@linaro.org>
Date: Tue, 18 Jun 2024 15:27:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] clk: qcom: gpucc-sa8775p: Park RCG's clk source at
 XO during disable
To: Taniya Das <quic_tdas@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Shazad Hussain <quic_shazhuss@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_jkona@quicinc.com,
 quic_imrashai@quicinc.com
References: <20240612-sa8775p-v2-gcc-gpucc-fixes-v2-0-adcc756a23df@quicinc.com>
 <20240612-sa8775p-v2-gcc-gpucc-fixes-v2-5-adcc756a23df@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240612-sa8775p-v2-gcc-gpucc-fixes-v2-5-adcc756a23df@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/12/24 13:08, Taniya Das wrote:
> The RCG's clk src has to be parked at XO while disabling as per the
> HW recommendation, hence use clk_rcg2_shared_ops to achieve the same.
> Also gpu_cc_cb_clk is recommended to be kept always ON, hence use
> clk_branch2_aon_ops to keep the clock always ON.
> 
> Fixes: 0afa16afc36d ("clk: qcom: add the GPUCC driver for sa8775p")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

