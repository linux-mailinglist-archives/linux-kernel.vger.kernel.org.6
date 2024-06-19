Return-Path: <linux-kernel+bounces-220723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED56A90E641
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002D41C2179E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDED47C6DF;
	Wed, 19 Jun 2024 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+ELKBCs"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C02139B1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787036; cv=none; b=DqJc39iuNsWYBqZs3C2WE5E1KLJwrW9BqdnjdT83a2WLORCLzIh0zhfJBsDZgQw89Kd0kVbwmkGY6tZ1+kRX5ViI8VWUpOeMR3GeHZZANqqQCT6bGKtTN2HbZ7npVkS3q449kyY7T8ELd8YMaoeYR7xOGB9jifsv8WIdUureFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787036; c=relaxed/simple;
	bh=6q1ZTtnzYg//bgAhA42Awnaa22+bcG/nj+xOuAg+m54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZE8SH6B2FTQ3L2JPcWeVjyJFXnCqRx53pTzU6Cchgl54/D39wldkdMmGvGdE1WkALUNj4sqQR9NGQ7LpDJFUNupoVclJxxTRLj2AkJRzSKCE2+daYuDKs68EgPLEaVRQ3fCW9dvc7oIXQiplOG2HXu5oSrSqq20bASN92c/lgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+ELKBCs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-363826fbcdeso296139f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718787033; x=1719391833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngW8Gz5Cpl+0cBREyYz+8mH5KwITQlYSWHUF7QS7aAo=;
        b=O+ELKBCsPDXCedH6SnPSX0R2DlReKZbblL/N2QFZj2bRmRlNAyGbiIRoX8+f9zQuEh
         0DAYHTdFAItVj8PbeJba8X/Oyi4TQM8LP6QJZMguLHDbtLJdCXRgcBmrYKMJk97xRg4v
         805KLPq8GoVuwvKyifBjFrcwCEpBbjt1TW2TI4TTLKfkwMLdTIffjByV/J8cCZwRfXi5
         qz5/1JGXUAhHRp8jMjCapMJ0p6kYnLzra5n7+7ZpcnpNeeMdN3cpWRHhnPE6JgURyCkk
         6qfNG0shmMbrOdLOH89GdJtMh2HXi0e1oZzg5e5XP9dqSYBy7bThpN9YVApQ4kjR5nlw
         5FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718787033; x=1719391833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngW8Gz5Cpl+0cBREyYz+8mH5KwITQlYSWHUF7QS7aAo=;
        b=FeYHhs6EFY+bciU5TCE/n6g6+NJjLfoZ6PG/pWsz6uv/UAl4qCQtwTu+WhrjdMo+OO
         A8v3LJXLDG0gFsm1hNyql5uaMYexARWa4QWX/NKh1m45Rh1jjSniaoI3Wswz6QvcZI/m
         9JsVRo1DFtXvJKHTPMZ+zVosR4f4aJhTPtycUap84C3OFsEL4rJZaRO/P+bg0gR0OMQJ
         90LSzqFoxU9W+3DxlFJwvBFUZcgYWzLfgn3lh2LFNJYX/2BjijCphXtmugQcJ1XwEq1N
         MX2VWSjAy/VULFmR8JumUTn90kcJYN93HGjOu0nkYm7T+YBugAdHnWo21RCT/Ls3K/cC
         4zRw==
X-Forwarded-Encrypted: i=1; AJvYcCV/m8dfjrEvO+94dFDMQ6PyS6RY0PN77lBs4KbyCrVbQjFiYGcU7KcxA0tzUDsL2qT/Z0wI7/3T7NisXmRlrX10UIQG1OTU9SlZdUg+
X-Gm-Message-State: AOJu0YzzDT4heOIuAGeq97Fbs0ICOseLxo0gzGlBh1GZyJfsTJT2OHnz
	MbP30XBDL7PgwYMCF3+Y7PEcKu49GOxmpZNxWwT+fewhcYYElHxaNBfFJUIT+ZY=
X-Google-Smtp-Source: AGHT+IHahTvGL4fXPSvvP/+8qIZ6XuBPDuQY5McrWerDtkQ7poz6Oe4u9spv229aajpWrvHKw6bZdA==
X-Received: by 2002:a5d:4351:0:b0:35f:20eb:cae3 with SMTP id ffacd0b85a97d-3631998ef04mr1344014f8f.67.1718787032663;
        Wed, 19 Jun 2024 01:50:32 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:ea6c:d102:5e8f:d5a9? ([2a00:f41:9028:9df3:ea6c:d102:5e8f:d5a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-363f7e62e6csm308966f8f.27.2024.06.19.01.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 01:50:32 -0700 (PDT)
Message-ID: <699a3bec-bb43-4572-83bc-6efe514a6b13@linaro.org>
Date: Wed, 19 Jun 2024 10:50:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Revert "dt-bindings: cache: qcom,llcc: correct
 QDU1000 reg entries"
To: Komal Bajaj <quic_kbajaj@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
References: <20240619061641.5261-1-quic_kbajaj@quicinc.com>
 <20240619061641.5261-3-quic_kbajaj@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240619061641.5261-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/19/24 08:16, Komal Bajaj wrote:
> This reverts commit f0f99f371822c48847e02e56d6e7de507e18f186.
> 
> QDU1000 has 7 register regions. The earlier commit 8e2506d01231
> ("dt-bindings: cache: qcom,llcc: Add LLCC compatible for QDU1000/QRU1000")
> to add llcc compatible was reflecting the same, but dtsi change for
> QDU1000 was not aligning with its binding. Later, commit f0f99f371822
> ("dt-bindings: cache: qcom,llcc: correct QDU1000 reg entries") was merged
> intended to fix this misalignment.
> 
> After the LLCC driver refactor, each LLCC bank/channel need to be
> represented as one register space to avoid mapping to the region where
> access is not there. Hence, revert the commit f0f99f371822 ("dt-bindings:
> cache: qcom,llcc: correct QDU1000 reg entries") to align QDU1000 llcc
> binding with its dtsi node.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---

For future reference, it would be good to have this as patch 1,
to prevent the previous one introducing (fake) schema warnings

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

