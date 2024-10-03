Return-Path: <linux-kernel+bounces-348722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12E98EB0A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EC81F22F31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8413342F;
	Thu,  3 Oct 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ermykQxv"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F412EBDB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942761; cv=none; b=BsUrdyKpOW12rOPSQAbjiQv8/gp3IG6vI8ZNmCds5Ejy8uvHQYT2LqWPxXdvcaGzA9SAxJAq1heK/0LDXbGSJWvf7tnGxt6JCJZaerEGcrIr98rNiyaHX/5OD0l+h0XZ2fkuNNPvp2RHUkjMXt1fst2noMXAH4bRpAt99oO+z/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942761; c=relaxed/simple;
	bh=gg/chES/KjfvBsxNlmPolEQpvr/+ChzwpTOgMTdzMrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pv8iGIzF9271gPazPdQWMVRy4iHN4TMu1a6XxPSe1PjTZVh0TSeVGtL83lvcgZKPo391xo3J/MkG2Qb6q7zkmgfEQUddQKVn2q6wRuNQ49wl2MQ3fEfqDdRHB0vTaWGjexpQ0wDGl2AW4oITTlUf3tA5yFZvpo0hPDD2g3SPvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ermykQxv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fabe9fbe20so589031fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727942757; x=1728547557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSbNP2LSzdURuBvtjjNXE7kOTcPFhv0be643iEbepKU=;
        b=ermykQxvAVxnUAkP6kwFoi1EeRlq2bVjCedW9l+N71ioA4IoK8nnCgcjj221noYmay
         R1i79LZF+tALNI70wZrpNEeMX0bNRiJ390gXshxA6Y09MW7nSUDL9AMDiwFpQcGzOj4f
         BtxqaKbE8a4sm3ITwtrLgrmk72CAhiOYXOIEdXCYhwTawAOrcgCgbibWmq+uCixDZzSA
         S+5JYuZ912g4PrsHFtBRcXlS6wX6MdCN2/AXjzsbHCw1//sovJ4CLxF895OznryQZ5xp
         HJvCnXYZ0i/bPkUF79EtBL0Aeq0ltGyn0bPBkCqis2BAHrzGSJc34oLppZd5qg3omVNE
         POGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727942757; x=1728547557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSbNP2LSzdURuBvtjjNXE7kOTcPFhv0be643iEbepKU=;
        b=lf+j9fRa5xFhfWpuGnA7V5sGGhdtjwF9658jxeHoE/bKsyVulP+CeoxzcjygtfEwGO
         jvPz9xcVV/H3YwKqOEtqD1pKQ6XogS7VsqQy7LSTsCtDF8JV0cxeEs35iO9kUPO8btpG
         1/uTzSCnPNZU8Di9G1dx+jlcAWn0W3YooRfqscGC/iuo6WTyR0guNytcgfkDJkpdl/RQ
         LFxtgFVYyNAsc4EWCleUK3xqJUKXD0K4ixEqwo3ZCp66O9RRrmYUWeavFyo97UmH1e4j
         q3M/IiCUZuLoQVCryR8rJQ9rdYzP4YrR6AMvFf8Qa9yWg8kifAdfVAyhYttA7EYyuxGF
         8fsg==
X-Forwarded-Encrypted: i=1; AJvYcCV+M3sDOAXPCpUT0Og4iKpMo/wW4C+bLO+gOVC5rQgbaJDf3GoKh/GW/MgDpYy827GD9k67+K+kOvMA8/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9a6uw+gIz+vcsFO0Trs1kUhUDVfAVyXVilsmmfhXJyAOQqVCq
	h3vf7YTNgGrImgYGYge5egwlShCC7dTSIwjIM8EHx8H9ANb8x63ZvhBx/DqwwqI=
X-Google-Smtp-Source: AGHT+IGMyQbMxH01BzNBJrn15VPbDfiUtVf0JbE2MOOeoBTQaQxkYK7qqyWEScuedJ61d8IqRS5Igg==
X-Received: by 2002:a05:651c:a0b:b0:2f0:29e7:4dc2 with SMTP id 38308e7fff4ca-2fae1013912mr10690501fa.5.1727942756819;
        Thu, 03 Oct 2024 01:05:56 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a82979b4sm113489e87.141.2024.10.03.01.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 01:05:55 -0700 (PDT)
Message-ID: <ab85f2ae-6c97-4fbb-a15b-31cc9e1f77fc@linaro.org>
Date: Thu, 3 Oct 2024 11:05:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: Make GCC_6125 depend on QCOM_GDSC
Content-Language: en-US
To: Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <quic_kdybcio@quicinc.com>,
 =?UTF-8?Q?Kamil_Go=C5=82da?= <kamil.golda@protonmail.com>
References: <20241003-topic-6125kconfig-v1-1-f5e1efbff07c@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241003-topic-6125kconfig-v1-1-f5e1efbff07c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Konrad,

On 10/3/24 02:16, Konrad Dybcio wrote:
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> Like all other non-ancient Qualcomm clock drivers, QCOM_GDSC is
> required, as the GCC driver defines and instantiates a bunch of GDSCs.
> 
> Add the missing dependency.
> 
> Reported-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

An identical change but for SM8150 GCC is also welcome.

--
Best wishes,
Vladimir

