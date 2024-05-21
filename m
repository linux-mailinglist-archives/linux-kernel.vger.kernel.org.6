Return-Path: <linux-kernel+bounces-185273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA08CB2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F723B21CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757BD148858;
	Tue, 21 May 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+9hcj+3"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1C148843
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716312950; cv=none; b=LxM2ZgeQlOqNGb55WiJa329q9UOeDxVAGkpwLmh36sLbNO+92p/oTTRMJbgaVUS/5CaPHSP9tWKA8l9m88+zQXzlhKX+9fP+pIodZfr+A7P2UnQPW47CkQ9fHlpLEgx4MYGZSp5yhS2zRjYdlu+B0L4VWpoW8sojYfaTujuavT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716312950; c=relaxed/simple;
	bh=XuD3UMWSTicjIiF7ozXmrSi2myUo59yuazJuOkCVELs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOj77NXfFy2UFRG8ODzM9T1jmb2Csj48hD/5/mJ+fgvIUWcKoaoD+kCJ9pe/VdtMxAF684Kxw5iZtpaQf/+G6nQTDn+8bPl8c2DaKDJDKEXfkyfcrXAJZPrnfA6E2je6+8AWLL9iowI08jOaoArRBS1Jl8DBLL9kD35+Lo3ciOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+9hcj+3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-523b20e2615so6626847e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716312947; x=1716917747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Ctw+pH4MnzojRpfpKhoAI1zwXX4IBqahQuQmnWxFZo=;
        b=O+9hcj+3m2pGAY8J4QCMFjL8lJn0oVlooOB2sgzvqNsroYohaFTgXBYZmAe6k4qvAT
         4DNK/B0I+XrqEvIfeCR6SxbZr0aVEuouDe80BFSopAKqcTQWzWDa4n/+ogsZbosl0Wjd
         BDTo9g92DsBLMWpYTrc0fGzL2zsH+n9CyXvt5svQt6+MVwBlKl+VAuVDv5LYUYaGhfy7
         ik2WK4gwBovZ2E+Hu8R2fRqeMt8hSXG6qDVJpTz6lrf+YdR9VGmgLdi+Knc75/xIU19a
         zSMXeC+pvI7KCfyi8l9eF/seQ0TS5be7eeq9Q6k/NaMAglD/uOUoJ3OQ2IaACqXhKN/c
         +INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716312947; x=1716917747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ctw+pH4MnzojRpfpKhoAI1zwXX4IBqahQuQmnWxFZo=;
        b=BEF2ehcifTCEg5k/4pvauSah8ZrnvHVsp1KF4mpVGJeJWNg9joQWkl4Gzh41ILRMQR
         idDIHLCQYesReKn6AcJoO3M+Id67cWdN2Aet1Ipslj4lRhHNn82NzQPmejOGeOLRoxPZ
         zWJiR9RP5HVsMSOa36z7jRWbcg29jlkQVCpg3BD4SkKijnQ9ASfgSr4wPLXXOy1bJ5YN
         XfTYYJS6bzZl6Xwj+/mWwPOP1dkCuK4DBIat0Ohv06RBVO/z9ijXiSvbnM6qF0HeFuJv
         Ln2h+eDhwG0cjladdU03/Tc8hK35wD7Pe9FFpsc0TwwT6iy7LPxRNOZOVimLvS9ArGO2
         sxxA==
X-Forwarded-Encrypted: i=1; AJvYcCWSfMIqTEhogr0DKQ/bEDiFsPvbL4kiIvJkNzktzBv5b4KzZV6HUc6rzaKG7MFlvgXIVSnz1Ns2h0EyUhIWtORd4YBJjRvAgQQB5AFu
X-Gm-Message-State: AOJu0Yz3BIH6MtoRpeJ93ke8iozYEruhmujtRfz93qB3Yx4f827XHmMc
	kr7DRwId4EoGUkz178XAWrfymVHhmHDKSon5Uc8LQpQN35s8XCRTcJ076lVzydw=
X-Google-Smtp-Source: AGHT+IG3tpTeaNwBk05y415j39FL3r2RzN7r9+FBBuxHR6nbabjWWdvFIWpNFzi37IVlgNTTHwLGOg==
X-Received: by 2002:a05:6512:3e0e:b0:522:2edc:c858 with SMTP id 2adb3069b0e04-5224b73a706mr21157861e87.34.1716312947234;
        Tue, 21 May 2024 10:35:47 -0700 (PDT)
Received: from [172.30.205.5] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba54esm4705961e87.110.2024.05.21.10.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 10:35:46 -0700 (PDT)
Message-ID: <d45ee913-7f6d-447c-8cd8-2bfe2986aaa2@linaro.org>
Date: Tue, 21 May 2024 19:35:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Enable download mode register
 write
To: Mukesh Ojha <quic_mojha@quicinc.com>, andersson@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1715888133-2810-1-git-send-email-quic_mojha@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1715888133-2810-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/16/24 21:35, Mukesh Ojha wrote:
> Enable download mode setting for sm8650 which can help collect
> ramdump for this SoC.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

