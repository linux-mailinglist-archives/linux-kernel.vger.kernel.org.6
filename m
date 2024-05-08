Return-Path: <linux-kernel+bounces-173721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D341F8C0491
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3868CB2544D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99E612B148;
	Wed,  8 May 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRBEQ3x9"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7D7B3E1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193918; cv=none; b=bRepj+GaTaVvRQjsnWU2wNbo6FaChoeAgKhtpjjgh5tA35WyFYS7YTIMGbmp71crocuFxD1UwRXU6318bMOyrp0NkrHYc1xDY1wqAnniTcZnhZlJmRVfpq7Ve1eFzAwFQplczcxz4ZrrHjfmvMmY9DA1d9BOIDQzdam7fVg3+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193918; c=relaxed/simple;
	bh=ajK8fwDEWGgksD0g4NneQiANiInlFvagm8QWZ2BtHyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoTi8t/Q0UsB4+ycyInxswlBgBziuB3ZaRxHKCAz0XWwHupWbloGlKTp6eUVybEDE84gvV76Awli+kdPtc6IiHTPNM67YsE9iISHsSKhIvHgDFR/TBJ8Qc0xsg+cAJwgph5SUCqk+bJqAwlg2Wdinv4c9gNjyMQOx+ckvG2gJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eRBEQ3x9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5206a5854adso30777e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715193914; x=1715798714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/sl7CVm2REW89uZuY8Yv8EOqxKrMx/lL2HpHKt7Na8=;
        b=eRBEQ3x9Hrp/xPuFw8ylVD9vOZG79dyN1GitKo3Gw5FoUBLxKZLCKZLXt6+nBUIJti
         M26HlViX1JJitHlIc3t5TbjvPyIokD1BRTrsKOzAZluwO52L5yRExHPwUxum3GLfJXDV
         LNMLwzWqNAnOUhdCuUS/aGtxMeTmcP8iMynAM/fz2Y2fn48ZttBee3BwTuOUpaPPyoJl
         pmDNjVSWGPsgs2Ql+QLQwtPIhZMYPywqkGw8uiENuqQrIXsiMqzKJ1eIFvS1HpF5ht/y
         8Gb9O4itRxpjnSCBmU6fmtiYdPZ7tFFgLWovKAEwro9OU9T8b40HB9L9UUSzK84id2AO
         UzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715193914; x=1715798714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/sl7CVm2REW89uZuY8Yv8EOqxKrMx/lL2HpHKt7Na8=;
        b=c2hrxrkzEzph4YdBWJTtL5vraz+TIlb7/ibX5btJvlaCuwqE2GDon+MSk7WWLVoJv6
         aG4mMJqaqGoeEvdEZay5Fg7Tjj3PytPnGuqksSSew6SGcjh8UrPbus8/sMjdnGY9vQ0e
         /zQpJ4XcqrExXJ3HQeAj+Ac8DpKTsd4R7mhtOLMy/6GNL82tln3VBAFeccHTlm/WhXLo
         cepRAaTOK5CFc8z7E6QuPd74w8pbZeoj0fef5iV5byTTofTlMyvSRj+9H/gfALo+cKnL
         h5cmDJIKYHpq64KfkhJf5LEDdrvU44h1XtN6HzMjP6+Yg1gK6IqgaX5O6fqt76+x8WP6
         SCtA==
X-Forwarded-Encrypted: i=1; AJvYcCXB21DajFZJFgvYl8IicH0+IFXxrBrN9+utCXCJaU/GZG2vSWHNOb0BonXPH3qNtUbgIJDlqcvU3+KOOFoSxA3pHwZPuLFoy3vvXNOY
X-Gm-Message-State: AOJu0YyKTyWkNoi0+NITdOBZMWTxAv5DNn+Nt/vPxo2TFQrIASbbAsjb
	ke1rGSAeDI1JSRaXeBrz+bCQAN1yJ++bSrLCNWfqs75atkNjIyzjd33Rij/XeFY=
X-Google-Smtp-Source: AGHT+IE10Er1A/mCrosxAFnAYPReP2NcUb3AzPgcOh2RiJkJ3CG8BZvnwb4a8smEsiNSsK0a2O5UYQ==
X-Received: by 2002:ac2:522e:0:b0:51b:de39:3826 with SMTP id 2adb3069b0e04-5217ce46c24mr1930208e87.65.1715193903577;
        Wed, 08 May 2024 11:45:03 -0700 (PDT)
Received: from [172.30.204.208] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00516dc765e00sm2605299lfr.7.2024.05.08.11.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 11:45:03 -0700 (PDT)
Message-ID: <1a28f062-89d6-48bc-b74f-2ad480f58ff9@linaro.org>
Date: Wed, 8 May 2024 20:45:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Mark Ethernet devices on sa8775p as DMA-coherent
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Halaney <ahalaney@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240507-mark_ethernet_devices_dma_coherent-v3-0-dbe70d0fa971@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240507-mark_ethernet_devices_dma_coherent-v3-0-dbe70d0fa971@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/24 03:30, Sagar Cheluvegowda wrote:
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> To: Andrew Halaney <ahalaney@redhat.com>
> To: Vinod Koul <vkoul@kernel.org>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: kernel@quicinc.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> 
> Patch 1 :- This patch marks Ethernet devices on Sa8775p as DMA-coherent
> as both the devices are cache coherent.
> 
> Patch 2 :- Update the schema of qcom,ethqos to allow specifying Ethernet
> devices as "dma-coherent".
Per-patch descriptions like this are usually redundant, unless you're
reworking something complex and non-obvious. These things above, we
can infer from the commit titles alone.

Generally, when there's not much to say in the cover letter, you can just
give a very brief summary like "This series fixes X on Y".

Not a huge deal though.

Konrad

