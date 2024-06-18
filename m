Return-Path: <linux-kernel+bounces-219811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC0F90D7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7E71F236A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181614CE05;
	Tue, 18 Jun 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqgYgMbC"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED846450
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726542; cv=none; b=Vk2n8Xe0wZ1E323kR3xJjNUDGkjZeb51+XdADZTvbS6ZhP2W5nRV9JOMbQRMw3v4rnF2ss7s+xFo/XuD6C2RUIG9nECVePLuYy/rhrg5aCaCliMjmz/ZX8bPnz+THZ827KhHcaj5DtTio2jDSjrt+wUr+ly5rvRhyFJHw0odYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726542; c=relaxed/simple;
	bh=x2PiSU9LX7PP8SgWlE3EbW7kJbvIktv1zVvHYBCMABM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqTUl5UaW4QkuLLrizgDGdWSnbBrGZQqKuOrHBrzbCJ0t1DaC83U5SLtFVEjV3CnKw+ZxTqi9TR/T/QeTIaHXZB+erHzwd4ZR0ZSGzSDUbpqJ8EWQSH+jg2x+/5mrPz6DXn6rXh27fdTh4HVcSxZdffHQmbE31bc9ZjgK+xAz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NqgYgMbC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so6083842e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718726538; x=1719331338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=752RRs86IaRqV5X/Zk2O6e+xuNg1lXOleBt1pgXq+cM=;
        b=NqgYgMbCmtl7nAdAV5xOv+RloRJ8xu0Jv3KAYLTBwD7Ci28rkjj80GIQouhYBp6iQE
         CAt7I6aOC89MIaM9RcHSkOyll+KAnK003xvQjwCza3Fk0lQg6ttJztTH+2Wh5eoBNLDa
         2gS3DzF78vv3xM3hxFRCN7MniXrbC9JEQHKVRxg7Ruc2NWooPtRh5eVW7zkgEP4Rh5oA
         ajOSN6ZVPUlDvTrefivqFn0pWsD/RB0V0QegxGSGT1Km1+cYG7v1/ff7fsQ5fi5Ko4Q+
         ppXEVGS7hbd9P3pxEULF5j5Xm+yEv1ZqKDIr0lRnjA8JeR92UuxuCDmXg/wEITa8QJrF
         3Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718726538; x=1719331338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=752RRs86IaRqV5X/Zk2O6e+xuNg1lXOleBt1pgXq+cM=;
        b=jTS4KS083oLBLhjBaiUdmP42Fgjy7oMBWBJXOGJMMes8ifYFKnJmULqWdQUsiX+dYm
         T+Rc0mzlvmMKuAlB7rroXjJa9eb+cA9XTixbORKhLdS4Mh3qbhoY6BQzUixcNb00W1oq
         /TCU29swd2WKHS2MAxl+xWDjWSKzlMZB22mqzoVYHeIo1oJHw886ViKragtN2Dut7LiY
         DD+zpwm78Dx7DGkbTWCPUAinKbKipFKM5f4u8ew6Gqj6GdY/ouTuD2j2uwoP/x4nCbwR
         4NNItQsLYuSw2sHAmOwKZ5KfNDUfSowgSLOwnAWIFFpCvr8vp11RVslGBrDtu7xnnrnn
         QQpg==
X-Gm-Message-State: AOJu0YwJJK75Im9Iv9zvTNUWsOHUgg8sg7+ojKg9X6DK47EsCU015kb6
	g0M5PZ31/Qu5yzoUmYzDikL0PH6kwMJCutVwP2TI1+2WynHCyZb1wgsmEdbqbSM=
X-Google-Smtp-Source: AGHT+IFI6pzMjgCbLBoQAWrp4XZXRVfgnVptha58SDpLfkJeq9xe2VdrhCoCQ5WsAeY36aPV7rhK5A==
X-Received: by 2002:a05:6512:70:b0:52c:8932:27bd with SMTP id 2adb3069b0e04-52ccaa38052mr32213e87.41.1718726537649;
        Tue, 18 Jun 2024 09:02:17 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:9346:6881:423d:1381? ([2a00:f41:9028:9df3:9346:6881:423d:1381])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2888c2esm1551297e87.300.2024.06.18.09.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 09:02:17 -0700 (PDT)
Message-ID: <d09aa84c-dc75-48c6-b91e-c0dbe3d2e06f@linaro.org>
Date: Tue, 18 Jun 2024 18:02:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 X1E80100 BWMON instances
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 djakov@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org, abel.vesa@linaro.org
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
 <20240618154306.279637-2-quic_sibis@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618154306.279637-2-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 17:43, Sibi Sankar wrote:
> Document X1E80100 BWMONs, which has multiple (one per cluster) BWMONv4
> instances for the CPU->LLCC path and one BWMONv5 instance for LLCC->DDR
> path. Also make the opp-table optional for the X1E cpu-bwmon instances,
> since they use the same opp-table between them.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

I think we can just drop the opp-table child node from required altogether,
bindings shouldn't care about where the OPP table (which is referenced in
the operating-points-v2 property) comes from

Konrad

