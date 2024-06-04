Return-Path: <linux-kernel+bounces-200551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2708FB193
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A3F1F23773
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2546145B3A;
	Tue,  4 Jun 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltt3rWqP"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2D145B0C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502282; cv=none; b=txS48+4M3n81MlM1JRzTowmIOesUu1RxVgfsCnw4vQ4haRgho4TlqAIrKb4AfXpGeiEsqXn1e6MKN+GEBL3Er8B1BuwEnvCFjA56W6GcbJhM3dE7l2xYt9r178ANVPxBIO+ewHSNROCtMEyTRC3ck6BNWyDHS7Sn1i/9IFxDGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502282; c=relaxed/simple;
	bh=LuwgEB5a3kXQNdLEh/pE8qVHaYw/nNGMKFNOSKLHroc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsAjo2sJkgew2THrhilelSpWR0beiTO7RGaZLmP3DFByYX5rGpiJiK4FyEqjCKG5fGR3iA3lzQYmpPbt7Y/Ko/QS2C65RfBVKitGQbfb3TynaymHKfSnobhESySQczFz6PPCgEwNDJlSv82/QEyek2LNIFM07HgcPMzmDqWqBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ltt3rWqP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a4ea8058bso3470625a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717502278; x=1718107078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQkcalWFB/tO1n36hfQeFTDEbW22ReDZ8opgR36JZAk=;
        b=ltt3rWqPxJsl7EQ9qPMphtffZpvZDCX6py/oCC+FnOjDXZYffrbxvfXfLA1iZ/Mh/V
         rCIk+gYDVY2s9GoGwnIRJXGRaKfFtA2VL1DTNLAkqXKR69ONxpGTqN1s6rCKQdaLZCXN
         ga6NDHXKTlzN1S99gopp7jV5/+cyYdv9wSCwqOY2U1D/W9KiOoUm71xRsA8mRXksh3zC
         TABDGtfSviq0XauItLXtEgO2/81P0QRyBSa1BwrXM2wE30rFBsL4ygxRDnLqIJpXmbhp
         QzZPstRcx25xeIQ1CtcFJlw9QfNQYNebbyb/jdeto+fmP2oaDVVxH7EIdlyWcr8hYmfH
         m1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717502278; x=1718107078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQkcalWFB/tO1n36hfQeFTDEbW22ReDZ8opgR36JZAk=;
        b=YkpzvosnkG6qlhE9ckhntZnRyYhQksKo22PgOrqBJp3qIJBYAW4ebhSNeuLKqUxTCC
         IFfR+26S6/MkAOVCYw7R2Z2ooIiEu55RCXB9wIikY4SuuSt8JJP89Ubg9mrTJ4fmJmI3
         c1vJo5rVP5tD7RwvdCfkZpjfniFcnaWnaVqojqOhVRkqeUv1D9YtawEAGhpjoG1ThUI2
         fr7yGFHW6jRuvqzsP8IS0JLfNScxBFlSW+8yZrwlFWFX5o2A2nlquaMJGg/AsFYO4cYt
         sIX6XxP1KZMPxgf3z1+US1226E+Q40EiKTdY2WpYa9pMMKKJvkSCYALPJNojvb/3pMQ4
         DvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeGVpDMeEk6pPz9HTM6BA/gByZMzVjj9wPHy7VsiXozOjD43QojF1Uf3zpU6uiv4ZeId4GMi9Y7vvv4QppU0yFJJDEdAodTFOLadmq
X-Gm-Message-State: AOJu0YxNT8DF48colJxuSqlH8mCe+Qge9zwx1TKc6Ht1xdP8ueZMG0Jl
	O7Kqm0ciXpWxFWibktdXOgwlDZArm5XoXbAJB6G7lzjjgHxZg+PCGBGODo1mZbA=
X-Google-Smtp-Source: AGHT+IFAVJky5swX6mJN/qK/exrK+BQ+9UDGMdrBsNovaqAZWpEAU+TBu0YcDuQGHG37JOyW5PVX6g==
X-Received: by 2002:a50:cd59:0:b0:578:5e09:98f5 with SMTP id 4fb4d7f45d1cf-57a364abc46mr8067367a12.41.1717502278225;
        Tue, 04 Jun 2024 04:57:58 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a7f1a4d7esm1384634a12.68.2024.06.04.04.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 04:57:57 -0700 (PDT)
Message-ID: <4064c207-bf98-4bb9-b3bb-e291f2e95f8d@linaro.org>
Date: Tue, 4 Jun 2024 13:57:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: Correct IRQ number of EL2
 non-secure physical timer
To: Cong Zhang <quic_congzhan@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240604085929.49227-1-quic_congzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240604085929.49227-1-quic_congzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/24 10:59, Cong Zhang wrote:
> The INTID of EL2 non-secure physical timer is 26. In linux, the IRQ
> number has a fixed 16 offset for PPIs. Therefore, the linux IRQ number
> of EL2 non-secure physical timer should be 10 (26 - 16).
> 
> Fixes: 603f96d4c9d0 ("arm64: dts: qcom: add initial support for qcom sa8775p-ride")
> Signed-off-by: Cong Zhang <quic_congzhan@quicinc.com>
> ---

Seems to match other qcom platforms of the timeframe too..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

