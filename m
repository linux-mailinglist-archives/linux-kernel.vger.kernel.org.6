Return-Path: <linux-kernel+bounces-448959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D339F47B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B5A18824F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408671D2B11;
	Tue, 17 Dec 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRpd96Xp"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC71D5ACD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428297; cv=none; b=hU2UzbbCsjqFUp3Fowd4V41CEwFm7QoWzTZ9gm50RN03FFEDlelB2zGJS4j20DEOMxyQBNBDDvfodAyWzG/XBRONhaNo9LVGU/lNuGvEsB4aroHLt0M9utQAe00nUA8Cjwe6MRLOz8DOZYpeI/rXmVJEJ0o/tUHLV3+Z00df7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428297; c=relaxed/simple;
	bh=kb3kP9tneB+GVEHe2feWWDmh0vqws9+suKVVH1/v88Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I98QaoFo7uC3GBQKMLqC4WNsokLKAPHiud921bse851+xdNa4ulunajeFHaqlOt+134HqSGCE/Bd2SyelZ+pbAR0yfmNQn5tRmuywoNPAoBEXwk0pgz7oqrpDJLgdYVniTVH4CFYvmJY0WD9MNJylcZvOqgzK1V01t0xXCy9uEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JRpd96Xp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434e3953b65so35260415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734428294; x=1735033094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tq5sZ+Fiv/wP7Onp2aVQfa+BtrbtLGAGU7hb6Q0naGI=;
        b=JRpd96XpZnF7KpYTnIWvBqeJK7CX8ZAvpdzi4dhvtffl8WsAcKYtKBsxn0RCPz5L8F
         UmIbquasaXa/5RM4t4rDU1rft2PKLl6t1Uiks4P+Xs5Kth8AxuqJzgxTkDqNzAesCcZw
         gh6fnXDyKA9APPiEEsTrJJpN6ZZUXG4TpP93P+h2e+JDHo70RRqZBoSI3kQlda2X8xk0
         akPYh4Bc3O9fh93gbIJ3Ki3YaOV34cZe38F6NDEKK6GvjJl1NNPJJIJwLfEBxoUp2UTe
         QnghlFKF9uMhj28fg76ijjWEn2zpie6uEByIKXnOVZfktla8GlchsgSzArCjBHzh1L9h
         /eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734428294; x=1735033094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tq5sZ+Fiv/wP7Onp2aVQfa+BtrbtLGAGU7hb6Q0naGI=;
        b=NL+bD9PRhjTYTwXZm1XGBet6MBVPPeIIsYRi+coIvWjCWTwr9JKye2Oj4jGz2IUPR9
         2pAWeWpoMk1e2yDHI4DGSmg4DHvk5K3Wk7c+3yN0fAImu4BYRdu1hA8XyUxcbadaITXy
         udlW0gtYHVc47L87VVb//VvV6sYsWPp1VY17/uDlYcgSaPc1++PreKeW40IeWDbKO05+
         f0KhNl5RcBg0/TinYniGTBEmTyTIwlqDD4YULQ3X0jQtkXj3VDmcLk53m7kGWyg7QUJt
         JzcaOeUg6INbIXfTMwqg7GcC2v10l91j48qINYs0c30iFECDwELx5Pz3lcFmqeQOSnGU
         RVKg==
X-Forwarded-Encrypted: i=1; AJvYcCURmR5uQxQAvtTA5/vbkrASnZxPQN8AdDeKC8MYBLTnFrj+Yhe0ptXY8T8YwoxK/oyBkoK5jby2Wnndjl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXarjWdPewGVUP1xirvWr38+TAiJ4HooSH7KoDe/FspPxMicJF
	A2pF1zwKWoh2ssKRWiI3cBm8qz4XDze5b99m2kbxEzL/9Ykk8JiagVnT0arVFrg=
X-Gm-Gg: ASbGncu8hi1FwiJcsCWgWpJEATzMJImZ6CtuMcwM8DKDOrgTR/ria842qmzxjc4ymuR
	9inYRCzjDY0BiKWyWJEDhKNnV3YoVbBXazZ9GpvnwlFxNIvLPJAVZx1NF04gPl7xDNhz5QS1iE8
	ZDqommH5CQ6HGCxg6v8mzOqoLxkgtzJvA9/L1s2G02QSPtFDQrp2GD51F9Dir8xz4mexAJUyyYl
	6OiZJyZObIkHlSiky2k03EshsNt3yq4MCCCcLkBPrrA8hmFioB3w7aJ4Q9eFnMIH0dWpw==
X-Google-Smtp-Source: AGHT+IGf3odSobzW67Hr2M4E4Qy568hruQO6sy10F4fQguns3CYgMLLwqVah+AMfzIWxgAU66q+a0Q==
X-Received: by 2002:a05:600c:214a:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-4362aa947admr142363025e9.23.1734428294427;
        Tue, 17 Dec 2024 01:38:14 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362b656fsm112454035e9.34.2024.12.17.01.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:38:14 -0800 (PST)
Message-ID: <83fcb683-d610-4e47-bcce-128453a0afef@linaro.org>
Date: Tue, 17 Dec 2024 09:38:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: qcs615: add venus node
To: Renjiang Han <quic_renjiang@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>
References: <20241217-add-venus-for-qcs615-v5-0-747395d9e630@quicinc.com>
 <20241217-add-venus-for-qcs615-v5-3-747395d9e630@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241217-add-venus-for-qcs615-v5-3-747395d9e630@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2024 09:17, Renjiang Han wrote:
> +
> +			video-decoder {
> +				compatible = "venus-decoder";
> +			};
> +
> +			video-encoder {
> +				compatible = "venus-encoder";
> +			};

I gave you feedback on this in v4.

Could you please provide some commentary on why you're persisting with 
this ?

- Driver configuration should not live in dts
- A patchset exists to mitigate this
- If you don't want to use that series, what do you propose
   to resolve this ?

Please don't just ignore feedback, either act on it or add to your 
commit log _why_ you didn't act on it.

---
bod

