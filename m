Return-Path: <linux-kernel+bounces-248914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ECC92E3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1625B1F22FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF65A15748F;
	Thu, 11 Jul 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DANXKutz"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F41553BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691511; cv=none; b=XW5tWg9JLJHYLizdI713HjdqqWpD+6317xqX5uECEPOFjii3kxo59Jw0Z2ls0LcUuqvtPXOcRGopXSAZRVDi4FbHLlPLXchCgoQcgf2ziWOX34qL9PzZFPyFvND/yy9Zb3Yhp8Gm03LTkwgf7xznLRJ2fxFKcAXjLQuDWjlydZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691511; c=relaxed/simple;
	bh=6W/qVczYJkuz3Z8DNHsspunOTZVIxcTUdrjw9u/h48E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMt4zZc3YrG19uxvlmvkqUheZ4nSi3QcOMRQGTOqYN+ocGQv0D/uQ4ZTEvfQXAmkNmtjiqfx3o5e3U0GKHNAAIBpIFwhmYCyIzcuxRX2T/RTqzULQsAWEprmYCP7E6Ov/kgwM63ZP3GiNjSbBvC4gZXY0CvTKhE30+hybrYtYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DANXKutz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367940c57ddso356089f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720691508; x=1721296308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4smDoC8Q8mWiYpTnz73mXw1qS9kVwzA6CajD1cC+rw=;
        b=DANXKutzYjdK7YMIIU2/uRYJQOBKdH9z4XEXz3WWyFgEMmIr5YOHqNToBg+454eo3e
         IzptyStDAd9Z8sHwxecJuLsgtrNYwL+gh8aVy5fDXoDA8AeVAmQDPNTUt6Zp1rwf7wIo
         Ixaug0kgOmnW+AUaPar+u4QKrBPqvJzXf9+WIzfGtUANmILxxqyrOTAv39TyEZIpu5ZI
         SCLysRR7aOz8+8EfCi//XY+RBYYbZFIAY2+V4UjiLhWHZTX198XzD8E2gwxyS9vF/yOr
         QVXNStei7cHeffZbbagp7/L+R6uH5FDIWJskNTcD+1s3S61IWEJPIjvd5CyHtMK7FBfV
         ahDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720691508; x=1721296308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4smDoC8Q8mWiYpTnz73mXw1qS9kVwzA6CajD1cC+rw=;
        b=v/W7F0nA9SO+dIpFR7iT0rUXv4m9Jc/9xQa8lqszpNdcjp8xTjScWTYf0ZqRFn3M76
         +BpQ+keBwYyIG3qdmPkl/7TlOcyVLKws6QtqhwvPi8PpRaXIaeua6/sOihxU46xq0kqw
         BBBaOW0u1unurOl58nIYo9ThiFHuPWVby8yKS3rodKVyHLiq2tP1xHh3af2xoi9buK7H
         qu8PBJRlNgFcwb+tM1ywdZpc/QeQ+Ld14YRD0MMJcse0Hy2Ra+kKhJoCEokSMJr+cH7M
         q2df6qeZMg9d8N6iY1IbQz9sEDWkvyH6sccBSZdK9k+vcdfMgH3g1nu42f3pJh9QvfW4
         UK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqaa3vccpAlaWm9jUSFAtoVJdNMOU3d1HT6W/qC9JXYqoMJ+Yws2Gu3rb3Ug8xTnXSk3d9nkKasNWMvDikh93+pGw9ItN7rDOiGu+6
X-Gm-Message-State: AOJu0YxFEaEHMwKNxYAFObpPmc4r4f7v58m01idKtyc9e7wC6Q0/XLUZ
	iWCtAPLqw5l0jc6NrAvzLZluIrBei6wh79iyor33MNY5utFXWJqQKtR2vmMCx5g=
X-Google-Smtp-Source: AGHT+IFtPH1XXTzpe+ZeiotMiBUKnIw0rtLtXdrEEVTNTDfCBJZjKL4CcUCeuZDut/QwViYvR4OaUg==
X-Received: by 2002:adf:ea8d:0:b0:367:99fd:a9a8 with SMTP id ffacd0b85a97d-367cea73735mr5694718f8f.26.1720691507676;
        Thu, 11 Jul 2024 02:51:47 -0700 (PDT)
Received: from [192.168.0.16] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e19dsm7274556f8f.15.2024.07.11.02.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 02:51:47 -0700 (PDT)
Message-ID: <f4072105-e0e2-46c8-82ed-92105b43a345@linaro.org>
Date: Thu, 11 Jul 2024 10:51:48 +0100
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
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAA8EJpqmJZJfd2famarx-FKFb1_+-nZM3N+FwK_hiOurG8n9=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/07/2024 23:10, Dmitry Baryshkov wrote:
>>> - Why is cam_cc_gdsc_clk not modelled in the clock framework?
>>
>> This clock is kept enabled from probe, hence not required to be modelled
>> explicitly.
> Yes, I'm asking why it's kept up enabled from probe rather than via
> clock framework?

FWIW my preference is to do it as Dmitry is suggesting here.

I'm not a big fan of hitting the register and leaving it as-is, would 
much prefer to move to the model of having the CCF do it - so that for 
example the clock appears in the /sys clock summary.

---
bod

