Return-Path: <linux-kernel+bounces-252721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0793174E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB07B21699
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249DB18F2D8;
	Mon, 15 Jul 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCk3ovhE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8D3A1A0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055714; cv=none; b=iN032/6A8DoRQKJjmuOd4PsCWVguVq+kZSNO9M8jgsX0ygEkBGDYw8QV2ofPMW5m3t5SF3rKs2+Gb8CCYBODv7O4+qcAfFjPZ35T2JswwbnTV/dfDEtXuQhov3ahHmkyb8knGikxRVX7NG2gWjC8Fxnmbz5UOGf4bgOYFRr0aJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055714; c=relaxed/simple;
	bh=u6KlE4HVa6FasczsbBxFgb/lVCSAg4kHaT9LO+V1mNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqNrdcKU9gKkvUtWmByt97icc4DYGRWzepf2n1mYOBemqxehgFDYup8lk0oSf5d3gA7EYFBcAbi8ITSHF3UMAOtKcJSvE3LdLYHnn943vXVI0p8rp8V7p31dQ7etmwx6uHMFGrVGbpuh6fSs7TThrUl/UkW9WT5usO6hakSPe0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qCk3ovhE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e9f863c46so4838408e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721055711; x=1721660511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQV1Q+yibtGP3NmgXG7HhtFloGMHLEY6YaLwPlWGoDA=;
        b=qCk3ovhEs4a2pvZ+UJzDghOMCVIjEPCG0+sMPImj3gJeZjnCWI9upH+OfYHeI6QZJG
         BpEjZiVgx0at7aJo9KOoKnvuCyIkF47AUS2lxtLkW+ZZ/OgUk2ao+ViV6y8IFtwleAD+
         87DpZegBpSQ9BU3aAvbAIbLRVcPBPRM1pDkLoXnK5vZAeZSTMaOPkkvNzZWoBTsp52Xk
         U0ERieVRZWQdmo7kPnqc2Ef03PnlD/U7P+w5gDTRA282eLJa3DcFwiBIKPG24R82cJxh
         AYMgiNypDOF6mzbiDwVzstn/gl8VVUCbK+IVJKqEFESKKJjwUNsagKTF7dd/nj4SEBHG
         WYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721055711; x=1721660511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQV1Q+yibtGP3NmgXG7HhtFloGMHLEY6YaLwPlWGoDA=;
        b=INjCcmv4UAiRXtlMgFi6BShddxMlydJwvG9Pm3i+1KfRKV4a6xS+HKS0iYnx06IcwJ
         6Cq5HeScgfBbiaiwpKl4lsv3EJPc/Vi9qM2kQo9y9Hdcs0VpNoZmDRrPAnP/P4JHH54/
         nkrVInuo5NQTOC3J5jGwVG2nwiX0XpNDvhizW43qTRSC494kWRFLND9AwTtprCyKb1QF
         7rpitqiRlxi1cFhGjBkfDXocM7WzUhT0P0xviHCDOHZluRWNxwwnx7z9tQ5nNTjdbTNO
         CacRCemHkEKeKr8ZBdwLMpV2pjkcHRSEWTpJQY8lnlu9XwIGaZl9G6MT3AEz9m8Cf2X3
         sbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKiE3Dlng55+H/K3DFOV6UmmqC/Y+a7xJp3nIh49Yr7lfsaIsms62cKnSH1UJJHUyLtsLMO3DYBxflg6FZY4ffxTm3x/9bm5tn8SDE
X-Gm-Message-State: AOJu0Yy5SVR7NIcP83TBfamJk2pEcPy2V0nL0Il3t3EoYkBtwVdb0gA6
	ElyZS2eIoxifQivY/CVNT4NsC05SzfSd3dDyI8l/Nyxdb/byEtW/RpmWmJrWg9o=
X-Google-Smtp-Source: AGHT+IEb0I8rR73ywWMIF9sJz1hrFFx6gcrJiETp+BiwqMDi4EiqcyEa5GzbPige/39DaAKdZj/4Rg==
X-Received: by 2002:ac2:5f67:0:b0:52c:8944:2427 with SMTP id 2adb3069b0e04-52eb99a1440mr9801049e87.31.1721055711034;
        Mon, 15 Jul 2024 08:01:51 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a8799e7esm80376715e9.18.2024.07.15.08.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 08:01:50 -0700 (PDT)
Message-ID: <503c8ba7-585d-4222-8e81-7f4c52f5f513@linaro.org>
Date: Mon, 15 Jul 2024 16:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] clk: qcom: Add camera clock controller driver for
 SM8150
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240702-camcc-support-sm8150-v2-0-4baf54ec7333@quicinc.com>
 <20240702-camcc-support-sm8150-v2-5-4baf54ec7333@quicinc.com>
 <xbe7kmaxhfwy26qzxrmwgiijaaiap4kdkruaxjs6ymihaw5taf@hvj57wyncfea>
 <cc1957af-17bc-cd71-e6da-013e3a740014@quicinc.com>
 <CAA8EJpqmJZJfd2famarx-FKFb1_+-nZM3N+FwK_hiOurG8n9=A@mail.gmail.com>
 <e235f19f-26b5-2cf7-ebb7-36e4dabe9b9b@quicinc.com>
 <CAA8EJpob5Qov78JfNN5BE+c1WyvnuBcQLYENHL0c1GTS+PPfSQ@mail.gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAA8EJpob5Qov78JfNN5BE+c1WyvnuBcQLYENHL0c1GTS+PPfSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2024 11:38, Dmitry Baryshkov wrote:
>>> Does it apply to SM8150? For example, on SM8250 RCG2s are not parked.
>>
>> Yes, it applies to SM8150.
> Should the same logic be applied to other chipsets supported upstream?
> If this is the case, which chipsets?

If you are representing the "top" GDSC inside of the CCF instead of 
doing this

+	/* Keep the critical clock always-on */
+	qcom_branch_set_clk_en(regmap, 0xc1e4); /* cam_cc_gdsc_clk */

then the clock should be parked else you'll find the GDSC doesn't come 
out of reset.

and... as I look at it now we have a logical conflict in 
drivers/clk/qcom/camcc-sc8280xp.c

static struct clk_branch camcc_gdsc_clk = {
         .halt_reg = 0xc1e4,
         .halt_check = BRANCH_HALT,
         .clkr = {
                 .enable_reg = 0xc1e4,
                 .enable_mask = BIT(0),
                 .hw.init = &(struct clk_init_data){
                         .name = "camcc_gdsc_clk",
                         .parent_hws = (const struct clk_hw*[]){
                                 &camcc_xo_clk_src.clkr.hw,
                         },
                         .num_parents = 1,
                         .flags = CLK_SET_RATE_PARENT,
                         .ops = &clk_branch2_ops,
                 },
         },
};

Patch sent.

https://lore.kernel.org/linux-arm-msm/20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-v1-1-fadb5d9445c1@linaro.org/T/#u

In the round I think we should avoid these horrific hard-coded always-on 
writes where possible.

Personally I think parking is better than always-on specifically because 
you define the clock and "see" it in the clock tree.

---
bod

