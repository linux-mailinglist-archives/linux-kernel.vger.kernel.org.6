Return-Path: <linux-kernel+bounces-219656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE4790D69E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6D4B31315
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D31158871;
	Tue, 18 Jun 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvV8/M2X"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CD80624
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721987; cv=none; b=C4nidaP5BmUNJ+1uC5eOgUOL5fCREBgCZ98CFo65QYeOkjZpteWrNPEejE2wKMQxslMoZaCjn+E2v6eBJmGstZR6BzlQfdMCHLzm85kb5v8WhRZLsw4InynSmHkWtR9hvbvczaih7D+Lt9Lj29uht3tFpXgVCUC4TWyk4KvaeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721987; c=relaxed/simple;
	bh=Og14w/kafuTyurc5NrEOw3F6k/R6K57h2C+os0REkxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0QeUzURhkigo5zRUyT6cOBxTqT6QNWK6LF8Kj5b2MKMr7J2Xhdnw3BDYBjnYvFWRjvfPbjrCfu0c7AXiy8NEnIvu8QBeH1W5obrFvW3z/TZJt0MrhbXTEEuJqw9c+jUORC34QXH+SxS16YDhVpiF26B0C+7sPuIWAxjg6Kw3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvV8/M2X; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f06861ae6so4798162f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718721983; x=1719326783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhzA6ITR/mtp+5gOoKdG8vAq1UwKiuZGvALGcvS3hfQ=;
        b=UvV8/M2XfRgJIWwlp/w6myfk3p5VGObsJvfU3F2DH9UJN99ArLctvwtBedyRe6pP93
         Yjk8DzyafR8QqAK+v4f6Hc9TPv8RNBWcNmPP6RN7/MpRHThuIRMCjefaE52B+/QL8FRI
         u54bTeD9nPCvbhqmfh5cTvoWQf246cj623U2m7cwVSwZyi9Vv+0GS/XeBBgGwroW2gmk
         vy30PpEllq4356Deh8b4M2K57ASTV++fGwULv5NKfWfiLTGGw4m8azsBWrtlQDzwvc5z
         eALd6RarOengff4dfC5fVbIM8uXhPBgQxZUnuLlyR6h20PzCkiqO4iagDgnEZwNf+faU
         UX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721983; x=1719326783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhzA6ITR/mtp+5gOoKdG8vAq1UwKiuZGvALGcvS3hfQ=;
        b=KHXkCK+bfRvEtgs0vtRiOUd8oh6M77RR8FNrOPvbp4VFXuhxJpRID79VS3IiPsVIfI
         W+xp2NE3hwOfzFlh99eEhYyoud+RRjUZJS2H4U2UBvQZENotc+0z8J7i0m8kSJuzOSi4
         BowMes/BqYOiHPSLY6ZgQ6G9rmL3YNeghh8ztRetgzGtV3VzsbbFHDwjSJqYbcxuEDcO
         Ti8btoeYWm/ScUvn/Ao9pbim93tUpxBLIqlAH+andYsF4aTXGLxY+3I6reTg9suM8DGt
         C7R4x5M1qjQNkR1AHEv2Dy/Y055fH0fGnupleBcnTeetgWYMqwS/AH98t8XOmUtsiYtB
         gVGg==
X-Forwarded-Encrypted: i=1; AJvYcCUAUdyH00T7hxqhitX5kBrZmIfHbXCT70gK+CF+zJ3+n9M4mQ36smeqhYHNh/9aRFmjrs+L/3CLEnfTnjuHn0V8d+sdDSLu53XeyCrC
X-Gm-Message-State: AOJu0YwucA6vwkFFIBw3IgYz5iFT//V/fNNwECUgDMQr9rGsv/BZErIv
	nnab1TVVI2gGebhBq9uY7Ag8ZeaMeoQdctBVs3pzGB0XBWs6ve76ohytWQSO/Ak=
X-Google-Smtp-Source: AGHT+IEKa0UB/epbhJn0UELns0QzTpX+72cNV+oeKhKhYZdsy/bAJfnvItOp3AeIO5nUZeTo7XkEpw==
X-Received: by 2002:a5d:4f8a:0:b0:360:9519:6102 with SMTP id ffacd0b85a97d-36095196123mr4353123f8f.55.1718721982800;
        Tue, 18 Jun 2024 07:46:22 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509355dsm14246603f8f.13.2024.06.18.07.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:46:22 -0700 (PDT)
Message-ID: <910af90e-affb-45f2-a2f7-875ca8362c0f@linaro.org>
Date: Tue, 18 Jun 2024 16:46:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] interconnect: qcom: sc7280: enable QoS
 configuration
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
 <20240607173927.26321-3-quic_okukatla@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240607173927.26321-3-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/24 19:39, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefined values
> for priority and urgency forawrding.
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---

msm-5.4 also has a qhm_gic node with QoS offset 0x9000, is that of any
importance, or can we forget it exists?

LGTM otherwise:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

