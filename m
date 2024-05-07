Return-Path: <linux-kernel+bounces-171558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FC88BE5B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533AA1C20BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2B1607A7;
	Tue,  7 May 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJnI0WgV"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C015F41E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091532; cv=none; b=rgZ4il8Nhs6OmcTb+y/cKNOpn9MWt2c8MbhFXjZw16X5eQvmjGFFM/w0HnJ9Zj4RVfXtgkJPkUjk4QWUkO8O67XcQ7LsuuJcJtvxY7lLn8RMR9PlnMZjSDv3wq/VhQjKYe6Du2swwN6K0pov+JAO7RxqEght5cTMej4bCEpAtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091532; c=relaxed/simple;
	bh=E9jPUsIV1FFv9HwtRXaXD20Lt/JQPRSXI3gSnwpUUkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZqUaitp9OWWe53p+yhwWamtUWBH3BVUeu25Efh07o9e9kD5AgLaY2M6Y1YnxFzwe/V5VOloTeOGu4IvkLpdYsf5FB+cw2sn/aUZq7e98O1VObJHkvGSoa0qqNakP6H+a4qpASalXEFBpPN14ghNk2LinrOCQddJ+zmBHIL1omE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJnI0WgV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f300b318cso3846006e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715091529; x=1715696329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6B9/opbNGy2dF5CZyiOc2E1LTO1EkA3zCx/KbLDUB4=;
        b=MJnI0WgVZ5azaNfgzoT6XCYsR3mQzU/ZJl/yMEQuRT56bY1NWPxQDAbJh6HFKj/bjY
         G+vnF6FIBIOq1J7Lu/ZUSuoIqkoqahbs/M8qNP9NlBiFmKW6ocsuEcu2ySC2mjdnfbrR
         IxH/rKx76VRzG5bsZ/964SO7Hm8SkKlvBdRTsPL+wXXYrAkrNo+p61k/bAluk/oODi+m
         DEg30/wHFcftOeUstrS1gWNJGw5BwkHQtnbDwE3c+7CiXpCdtqCtq6dnXJWEavS8tVMt
         lo6NqVD55ehzbDPU1SB8utFdDSWJNxeAsqcw8MkB5GXwP78Ozkg7IQRmoCU19JuS1/Jr
         27CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091529; x=1715696329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6B9/opbNGy2dF5CZyiOc2E1LTO1EkA3zCx/KbLDUB4=;
        b=tz0uyV2QABQn4CRjPNtjLQWOl388TZC7moM7vy+LpqBAwXxj00a0G+tFjEUHvYSeBD
         Zrex1bdbOIO8XAA9jDahjWlCY86hOu1fBAZgf7PmKQJXntbh9hZr3b6K6dY7EjSZFKiJ
         woZIfXTkppMi/ZfdnzmFXrWqBr40a1IT9uv7+nYjFxS0+75ZMfmP6L8c+og5HVeULmk3
         ZDzxaf3zNU0uZNXS8luqjmzIzdDiBOgqzjIRbEPOtA3Ryq7nIyJKC4KsLcD0GyKhj+0h
         WooBC8rQU/fQxivam1JgfVD1t9FFaCP88lJLrzxBbP5MLsAEaDeMCRpHnCX8hjh9ZePw
         HrzA==
X-Forwarded-Encrypted: i=1; AJvYcCWspMnIROltCe6oM9DN886OV5pAU4IiSKKL9ZSClIJxmjLSpo6M/rY0v68YfYvQkLALHKw2EnaWwUL81DB80nTqYTS9K0cAXpOBLT3N
X-Gm-Message-State: AOJu0YzarhOMy5KCvPFoccHqhdXc7MKQa4iuP/wP/+80MdUsjwhg/KjH
	vbUdUHnosBhA4MaouFR86PZSC2yKyw87Ug2f+L2ZfFBFhv9FDhLPDD73LQYnRjU=
X-Google-Smtp-Source: AGHT+IGvfA2LnxMsAtbgMLtJQdOK715lWo1rdpwj0+KQ282HVHdI8dUi4imvbg6NqFVVZUmIGJifiw==
X-Received: by 2002:ac2:5603:0:b0:51f:3fea:cbcf with SMTP id v3-20020ac25603000000b0051f3feacbcfmr7210675lfd.52.1715091529529;
        Tue, 07 May 2024 07:18:49 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c0d:408:fa88:abdb:17c2:cf24? ([2a00:f41:c0d:408:fa88:abdb:17c2:cf24])
        by smtp.gmail.com with ESMTPSA id br39-20020a056512402700b0051da1d9c47esm2124202lfb.64.2024.05.07.07.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 07:18:49 -0700 (PDT)
Message-ID: <6d9879aa-ae84-4ed0-8b5f-5609fd0c37b9@linaro.org>
Date: Tue, 7 May 2024 16:18:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arch: arm64: dts: sm8650-hdk: add support for the
 Display Card overlay
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <20240422-topic-sm8650-upstream-hdk-v4-0-b33993eaa2e8@linaro.org>
 <20240422-topic-sm8650-upstream-hdk-v4-3-b33993eaa2e8@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240422-topic-sm8650-upstream-hdk-v4-3-b33993eaa2e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/22/24 10:48, Neil Armstrong wrote:
> With the SM8650-HDK, a Display Card kit can be connected to provide
> a VTDR6130 display with Goodix Berlin Touch controller.
> 
> In order to route the DSI lanes to the connector for the Display
> Card kit, a switch must be changed on the board.
> 
> The HDMI nodes are disabled since the DSI lanes are shared with
> the DSI to HDMI transceiver.
> 
> Add support for this card as an overlay and apply it it at
> build-time to the sm8650-hdk dtb.
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

After testing this on real hardware and getting some word, it turns out
there's an issue with what seems like the SMMU ACL settings, preventing
the display bridge I2C controller from being accessed and ending up in
the board being unbootable, even without directly addressing the bridge.

Not mergable as-is.

Konrad

