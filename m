Return-Path: <linux-kernel+bounces-255095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD4933BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A9CB216ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE917F4EA;
	Wed, 17 Jul 2024 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="yj3yPeIy"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8C17E915
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214482; cv=none; b=EylY2j5bo6YXSg2+kWq835a8dB6HmTRLUlDEDTvQEWphXoNaxTWbYoqBQsoeA82tDaaqq7cFiYno1NPpCjwuskiQuZk3CsOxWiCfbW+pe8YwhgBC7WAkWCth4GIgO5c8ckb7MQeECNidpbFPfSvXrBTDJYKpsWa54ximH//+TKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214482; c=relaxed/simple;
	bh=j5oHJ4N4AEEu9W/2D++2KOV4B2U6CZ2ItnsneC4swPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDuJh2/xlyaYheCT3tHpq2/whzddRBByoJMYKxCN5MoP5osbZhYvnmYQQcvZgli3F4C876FsuJtTSvCUysnMor+PaeAin265EjblFZlxT1d3gj4UG5GaWRI4P8iVrNSWLKqQfyi+WStPSDFNxLQO1kEcOQMtGqcK1WTS0qswgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=yj3yPeIy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so10874391e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1721214479; x=1721819279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0MkPJTgEMvQtnUcTdhPwWAgvVYXK9NSydN/rtNiOhc=;
        b=yj3yPeIyJg8FO0WU+tMsaaX9Xhgswihi/S0Xs4SL/wpVC24yr+C7ml2ZIM+7Zt1XUA
         OgRHe3tt7dwuNJgS+PxD6ChzWArmjOjDPk7R1oa/22GeZsXS+lxSTjwrmqXIc9fCylfQ
         eD+PWFaA8JNbnpnrF8ZETsdpMBkN9+36zOgsO8sSz6Js5vAM/mWgX31Sw3pHSA5RXiwZ
         L7zqHYK7iNHFdeDnNfXjsOfjk062nHHqM7/FU8XeEj49Fv0cjMEEXQ9itD/amFCiJWIB
         2cqEf+bdAf7djXyP/Kcs5cdyEga+1GBej/kgsk7QMfrQXM2IqifCn5gxF+Rvlau6ekYb
         X9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214479; x=1721819279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0MkPJTgEMvQtnUcTdhPwWAgvVYXK9NSydN/rtNiOhc=;
        b=kRP+Q8sAeXgEaOn6CNmpOfmCegKnt3mhlKLQC92t5NMJ21SQ49WuRW+zETB10a7KWx
         GqGc2HliSHzaZ+YDiSGAmEtWwlODFgJDyF0TGCOXp4nrZYxBBB/ODh1F0bOQurInYXDT
         JKaCtTXkORi/r756I7tYE+AhQyAD4hQkZLicL2UNBauH/Ic+JwCcG9U3c2gwFKVaK4Bf
         PgNECK/QUPOHjRNE8iyhivNEvmoFWL827ga7HghaYMGPz4Onz2CFi+1pDsH4FuCI+wmO
         LSB+ElWei9SWKwsZ0sUiH1Uh5fdPkvKNLJnO/uw8y5uPcglcAs7c0splnRzKpYohQtik
         Rbzw==
X-Forwarded-Encrypted: i=1; AJvYcCXioyDbn9xsCt0NpWuZH9sJHcc9fR1JyoAq3yA2FBPekUZxd/zrakKOinwgJoSruTYgxS5a/VgJmAMIPvzCfgGoWnmwpkUsIfMeHgEq
X-Gm-Message-State: AOJu0YzaLwBpjD+3QcJK23BWh/nkweiiB9JRdahTOwFkeLK8/BjQtI2u
	FItluxH35xDffuM47XwpAXDqXnlEzNx07DM4+0q2ZOA/lKTyWGeAaxSpTAsMk1M=
X-Google-Smtp-Source: AGHT+IHD4LY4lMSqiD5JjSfArJK6jY0AXCRwIpm4xXnBwTPfSsq31/8OXJCfA+vVp3x6KUA4XxU0fA==
X-Received: by 2002:a05:6512:b9a:b0:52c:cb8d:637d with SMTP id 2adb3069b0e04-52ee53a768bmr1247519e87.5.1721214478693;
        Wed, 17 Jul 2024 04:07:58 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc800022sm440566366b.176.2024.07.17.04.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:07:57 -0700 (PDT)
Message-ID: <c51936a7-bb62-4423-aa6d-598ca9d58b8d@nexus-software.ie>
Date: Wed, 17 Jul 2024 12:07:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] clk: qcom: Add camera clock controller driver for
 SM8150
To: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
 <503c8ba7-585d-4222-8e81-7f4c52f5f513@linaro.org>
 <0b84b689-8ab8-bcdf-f058-da2ead73786c@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <0b84b689-8ab8-bcdf-f058-da2ead73786c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/07/2024 07:24, Satya Priya Kakitapalli (Temp) wrote:
>> Patch sent.
>>
>> https://lore.kernel.org/linux-arm-msm/20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-v1-1-fadb5d9445c1@linaro.org/T/#u
>>
> 
> If the clock is modelled, it can get disabled during the late init call, 
> when the CCF disables the unused clocks. But, it is a PoR ON  clock and 
> expectation from design team is to keep it always-on for GDSC 
> functionality.

Not if it _parks_ - that's what parking does, also what is the upstream 
usecase to sustain the clock as on from PoR to CAMSS probe(); ?

---
bod


