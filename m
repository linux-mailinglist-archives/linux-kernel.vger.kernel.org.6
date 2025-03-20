Return-Path: <linux-kernel+bounces-570421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB9A6B028
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C783A530C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1786F22A4E4;
	Thu, 20 Mar 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOIhLCLC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF651E25EB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507257; cv=none; b=LVm5e4JjT6BsgicuBCsJ/hts8BBUbceY5J9IB64nAhpHvCacG18g+ch8QAK7FgFC6xn2QGfmnzlTj5n5PZESxkA8LRn9gpM4ClBEky3Idez3BuakZ2lhebhdq9R59kqg+AyiRCevaWz7JcbUsatOvYNFjKzw6DnwFKdCyCY0t4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507257; c=relaxed/simple;
	bh=6aFeAcQOrE9iX5bnT0IHoBmr8TSEA7XYOZSeAKpYzh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmprzAsP4pJzNnRnW4D7H6ptP41W4ns0DBs7/tFHZJ2jXpBcxp7x0Hp/cmPyEbmpmf+3w9Bx9eMYQlltsCOi3CD9SG4+6rxfO9f1caoBCO2n9CymOYlMfC3MUM5R/bbVs956yAIni4r6UJoN879rsy+jexApO/W7VYCxyUs/NsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOIhLCLC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so11768475e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742507254; x=1743112054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pDs0WVPO2a99lut0kg8geJYSA583A+0xvILgC594aY=;
        b=sOIhLCLC4KdTb/cpTmXDZvW3uho4lVcm69fYU4rW5iyvoV8Y6ux/WSuIjwE1fZCdcD
         VAUtny72w+EdsGYjuOqFulw/uPPQ+rFsgQkOsQTT7sGyFNvqbze5PnRUkL/mcKr4qfIg
         sWPfKwqc+y7sE0EC3unb0RR2Qz+Zs+Kidzj0/TWlLU0o1EA6AltMeLNo7vWiOExR9Aiu
         8syp6JhTW0V5zD/+XZzlfvWfwj8kzIwSZDfV+FDyJYtiWtxd5Ci5oQWZebWSV4QZNzig
         STgOCJae4/84EEZpeUja9eSHuR5bBepwoMhlgDRkb406e9kCOwfFXbg6+1grryniDstr
         oZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742507254; x=1743112054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pDs0WVPO2a99lut0kg8geJYSA583A+0xvILgC594aY=;
        b=f5aW7vNrsM8YNsXnGro1LHqRW5OgTimhy/O2kWnah3Bm0aCH5Qogqy+wQ3q+tCA00u
         l426OLSB8VMZu0/inZcUAG+ANW0BTJlfSDDFbJjDsq4KlmU/1BSNTmJfWMTSwpFcEhBp
         Sttz5C7WU4TuljgBkQSkirx8Q9sB4RCcs11rYJ7tc8vgNMzx2B+NC1joGUAVLKPZ+knS
         fBGOYzY7o199e/RilYhKSCOFCmEbdi57QIzUFyPz1L/NgtXSaJfBq1TzJrybRgYG+vDh
         wcoBs5eGmV6F9orV2AQAqwwlVbQC0/ebNLy1HlhdRA9ZU+Ix+AETbnz7pHx5zIgsWLqw
         PoFA==
X-Forwarded-Encrypted: i=1; AJvYcCV7qU08qwYA9YxqdDMsz3KId46EvvKDfu8oInngHgHxGrUVuN37s4r95QdUlnbkm4DQtnBDLSTkJ9fTsj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqqHEPdm+rEC5J3YYbsMk/AQHsm3NgGwlQbKfO4w80J8R+9nA
	6hdQ/zPF9XHVDD17njDamo/NIptp2P63S4b9bUgTE47Xtoz6ZZNMs8Zre3PNxvM=
X-Gm-Gg: ASbGncuQZKr9lvuDS1JzJ5L+DcVBAB9M2VhCwwzBrJVjr5LbajOhqjbv2J0NY/jrnCR
	t6ZbRBrgkx/HMvaR3Kgv97LAwoBkcpgcnRtvO1htrEEb5WXT5r3tTAMJK9MQe8JA3FQdTSNwPXM
	nKYphLrKKGsQAptRssrKq/O4unJuAbU6fjlkQDR+JkDOBGbGiwbflolmSo3/pG3zhRKZ6Qs+Fd6
	6XTvSB8Z95d9yowA7BbQydyN2Ie9ppmbST3pCUW4f6rGj2pkVbvoV4JFBAEd7QR2yPF3t6IIGgm
	3E6LDxU+U/YmEzMdsi8/5V0nv9D8oRys3d8mq0KqTUcXf1TeHpoAldUMfCat3+jsrPoIT1+NEZV
	lF7tQQSagyA==
X-Google-Smtp-Source: AGHT+IH1QR2lA5j20mnRQxFbbvbhsn3PhLymz9T80NY3pVx9+kYUunZaqACuc30VQqERvPO4097GDQ==
X-Received: by 2002:a05:600c:1e26:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-43d50a4e498mr6521745e9.31.1742507253926;
        Thu, 20 Mar 2025 14:47:33 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3bb2b2ffsm67871675e9.1.2025.03.20.14.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 14:47:33 -0700 (PDT)
Message-ID: <a4134aed-0b6a-463e-828e-326636fbadc3@linaro.org>
Date: Thu, 20 Mar 2025 21:47:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sa8775p-ride: enable video
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sumit.garg@oss.qualcomm.com
References: <20250320-dtbinding-v3-0-2a16fced51d5@quicinc.com>
 <QmxHHC087sYySMBmJH4INHn5KxydFiCpjxuGSwMWq2izyyd5JQByDX7LBzvgK_SccwtrWn2FzazAyF3252YvDg==@protonmail.internalid>
 <20250320-dtbinding-v3-3-2a16fced51d5@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250320-dtbinding-v3-3-2a16fced51d5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 18:06, Vikash Garodia wrote:
> +
> +&iris {
> +	firmware-name = "qcom/vpu/vpu30_p4_s6.mbn";
> +
> +	status = "okay";
> +};

You're out of alphanumeric order here.

Should be:

  };

+
+&iris {
+       firmware-name = "qcom/vpu/vpu30_p4_s6.mbn";
+
+       status = "okay";
+};
+
  &mdss0 {

---
bod

