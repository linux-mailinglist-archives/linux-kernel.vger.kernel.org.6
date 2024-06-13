Return-Path: <linux-kernel+bounces-213712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D44D3907960
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F77EB21DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C294C6B;
	Thu, 13 Jun 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHs4QNB5"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3D1487D8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298328; cv=none; b=uFgVXJ/xPcyRcY1YXZIyyHZn2YU9ty2fwom77LfX72bsmFxrswu3zvOSLvykCherVtgiW2PGuidkIDOWE3+vvYtDUogjmBikvk7ziMlBwe4loH8jp1Dr0iHmAZlhYtltr7nwGtjXYULjEbv5LWlqQKh2tEjDtRNFDQwmUq1Hy0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298328; c=relaxed/simple;
	bh=p/p2G2Hnjt+abB5vSKz8c1cnMTyRrbY3vlMcptLFV7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsgbvdEXHHAEYEXG3bo6twdIqfhsk3ogOHH22zA+M+ipPuWqDmd2hmHY0+RPHxXyoa6curASF6cmEURC37mh0UOtGYhwDukGkURRJdo2xiVQ0IwuiofAdezYmB6OLsETDF/f5mqfYaOjXyV/MAUWswR612tIgH+X3YxnPgTA21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UHs4QNB5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c32d934c2so1401356e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718298325; x=1718903125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzFTYmEc+fQ3/csX45CT9heivu+VSe2HarKq4DyBsq0=;
        b=UHs4QNB59/TSi/V5oD4vL2euFuZ6U9IWHdSviSHCe5wHNlyyqAEHNIf1HH1+ReYG7I
         4UyIVG1OQnrX5aXlgf2j3A4e/hLI1doUkn5XMecFPRGYtzlBIG5fpdMzxwMcXC0c+3Qu
         +DgmwhNdCLVHNHHBZY3TdKbh2f2jEQe64Vk7yOJdisVmpPtPzuTNZJomQLKswJKTE4KX
         CfScWqdBkbsvzO60zglpeUZYQQmdSBFLfqq9d1jdEkjSypCOrVTMN9PZj6rj+SK3EE4O
         v5rbPl69mL8r5UyPKtqo8P5h6oEHZdJppJOeMPpmJL39fF8ofcTNYGKgWljFWlltyGzZ
         CxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298325; x=1718903125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzFTYmEc+fQ3/csX45CT9heivu+VSe2HarKq4DyBsq0=;
        b=ki6Wmny9oWQvWyhn5sytUGCfXmxto+/3DPc6fOGEL1XOFa0NtdkE14Rg8p8s+nT9qY
         417rAvw97+D54tVo71D75a/UTZAUCPNyAss6hZb92vIX3C6haxVRNOA12f8zKwKFFyb9
         K/aApCDpCvmEP3ytb0MQ4fFK/U8F3ybT8KyqN2DJ7A/jM9nbi/nCAm4sSjteZq4CyZ8o
         tK/BHwZUt49CUVuPI/g395kck+e/Ghgc5yYF6I51R1I/gxLgetE7zTl6yJgYTP8VFntA
         U9QYk8NPdoCYjjWzSAJ1Y4yAohU2FJBzHj0eRofDfvoMPfAP609gSgQ0XQ+l5DmKmDwc
         MNXg==
X-Forwarded-Encrypted: i=1; AJvYcCVKr6V3nm3f1VknKGeacv8o0jYJSYh3Sz4xXRLyiWM8Tuq0/V8i4sZldv4zW9YmWUMceUp52CXa3QMf/UDYPehEAE3Pr0ZdGE1Eq4f5
X-Gm-Message-State: AOJu0Yx6aH8JlV/UEeR3IQlSZrYPwicd1idZWXpUlwX+ySPzj7Vq99Uh
	iA3GdrbRHXuPTc/v/cCRXPSZsEG2bNZ0j693vymUBfkKqcpWMzyNJ0UkcxxotHc=
X-Google-Smtp-Source: AGHT+IFMrJVT6uEGUQp5yGREv3B8DR09nqWG4bCjV8ublGXm51Hn18ceK46I7BCUMOznsI+esuuukQ==
X-Received: by 2002:a19:e01e:0:b0:52c:8932:27bd with SMTP id 2adb3069b0e04-52ca6e6e7eemr215207e87.41.1718298325382;
        Thu, 13 Jun 2024 10:05:25 -0700 (PDT)
Received: from ?IPV6:2a00:f41:900a:a4b1:9ab2:4d92:821a:bb76? ([2a00:f41:900a:a4b1:9ab2:4d92:821a:bb76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28259cbsm289479e87.62.2024.06.13.10.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 10:05:25 -0700 (PDT)
Message-ID: <4fdb62a8-df00-4cd2-9c96-74afcae3ac5c@linaro.org>
Date: Thu, 13 Jun 2024 19:05:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] clk: qcom: gcc-sa8775p: Set FORCE_MEM_CORE_ON for
 gcc_ufs_phy_ice_core_clk
To: Taniya Das <quic_tdas@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Shazad Hussain <quic_shazhuss@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_jkona@quicinc.com,
 quic_imrashai@quicinc.com
References: <20240612-sa8775p-v2-gcc-gpucc-fixes-v2-0-adcc756a23df@quicinc.com>
 <20240612-sa8775p-v2-gcc-gpucc-fixes-v2-3-adcc756a23df@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240612-sa8775p-v2-gcc-gpucc-fixes-v2-3-adcc756a23df@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/12/24 13:08, Taniya Das wrote:
> Update the force mem core bit for UFS ICE clock to force the core on
> signal to remain active during halt state of the clk. If force mem
> core bit of the clock is not set, the memories of the subsystem will
> not retain the logic across power states.
> 
> Fixes: 08c51ceb12f7 ("clk: qcom: add the GCC driver for sa8775p")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

