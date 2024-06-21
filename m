Return-Path: <linux-kernel+bounces-224942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD959128EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7DF1C26553
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCF5C614;
	Fri, 21 Jun 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkRVuqFI"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED0D47F6B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982374; cv=none; b=ZOrCvzhN6Bh3PqBip6XGudzg7KdVeehTvHD6ptGwybPv2krb2FMlk6aiDJgeIy+c+ZQVIeSCCOhih9J4Au1SvVkTENJvLoQW0f7IyhKSrbXkxstR8o0t5yVJWoXb6dUrf2BV3e1KI/ltv+umnkSc9NuOMb3+IM0tJvPp0f6Rvlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982374; c=relaxed/simple;
	bh=KIq2vtY9qM91UnJhde07LqckDFTuSKg/5Ph8JpMdh2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y305zA6auFchxHJoB1688qFkDMo+rpcE5vglyN2iFkaxYraQUqt52CF3a6WIK48ef+M0GrRDoGm9SXqIlTh8uLtT+GsqX4vkto7l92CEI1DuB2Rbz1IREiuQ85o+X8Ztm3eqa7gi1Fv3yLcX1VVnK2tRBGmjh653rhRWClHOZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GkRVuqFI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42121d27861so19543645e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718982371; x=1719587171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BP5DlVBjipSk1p4cQPpHRbKc5ISqz6jYjFtQC0DyCyc=;
        b=GkRVuqFIkp38NR84SU8L+PdAVHDGgRfMTe4ygIVViVbqJw/Gjzmmn+AOC+6Xbavn3N
         /6YOd7ZLa8dZ5rfv2qBdTlhIUaEIAy8ynC7++RLd9m9ymhbz8M+JjOIwGEUQfX1zVIAw
         xn15sab8VrdTuG8ycN455bU9MnTjda9ot/YVe0/KVS6Dv/0dCifR+drcKz+K/K/Ais8N
         k4XLtj0gGYVsoGZvvvXO/fFflcGQz/smKxFPgtXa7cIOj+HUK2XRohiTMgjq8Fuz99gT
         yfVdX4BFoBTodKe8N/ngMJfjUrnkHvtgWD2zk6pSQPqB/OF25g/T6auJeplgzpBsxFz4
         1RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982371; x=1719587171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP5DlVBjipSk1p4cQPpHRbKc5ISqz6jYjFtQC0DyCyc=;
        b=i/IrF+h3gd+ejONUn7Qmv1foYkLffG3EAE0xl5FGEFVWzd2rKVyBYYeIjs+kWZ/oDF
         xUoTFvC5ruhE2FRWjVdkFNO2y5sPmwGGLkKPh3Y2B3CCp0y60a4HBy+PRFw25Pkk9/G4
         GSiJm+qcloGjBnOeaNkUlu8kW8FkfS7fgGA2lSO0tSRM45EB6JKNqM4ghjI2Juhm3RzE
         AM/YDdOcjt3OE1hHI6Wzu1jsmRZSfTlAXwuhlZmWRI4HsnhOMZG9hYqKlysO9dplF3xs
         OeOc669hNGsSzHb+ZgzZ7EBDJNYHdrR6YBFi0WpeLbkqlzGXAntVCi5K5SZXLa1pIt4F
         3YmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzpwukn6LfUXqNjHrBYzu2YimG7Q18MWdag5R3VNZB8KWEOsZwHjtoUWy8Kq85QXErVUoX1cDLXnPv+xdyilXhcsJOcxeFoxuJ6T7n
X-Gm-Message-State: AOJu0Yzkp9qeCczh1ZSwQlXObI6KjBJU3h5xq0DmhSrVQjOlauH19G2g
	KbDcYn/4sOHG6bfWD7v4FDMDQRY9XykEuLqerNcyNrLKXbgqqOltx6eKHI76fyM=
X-Google-Smtp-Source: AGHT+IHHBo2mNBPPzrQ61HU71s2NqdGBN/GsYGlKnm+7ZW7VdfZfbNbVUtky0Nd/hnsz+mF+OJOPHg==
X-Received: by 2002:a05:600c:63d6:b0:423:b672:9d64 with SMTP id 5b1f17b1804b1-4247517dde6mr63390095e9.18.1718982371436;
        Fri, 21 Jun 2024 08:06:11 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54c9sm68710035e9.27.2024.06.21.08.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 08:06:10 -0700 (PDT)
Message-ID: <ae88c6fa-a55c-42f9-bdf4-6850405e9ccd@linaro.org>
Date: Fri, 21 Jun 2024 16:06:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] media: qcom: camss: Decouple VFE from CSID
To: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240522154659.510-1-quic_grosikop@quicinc.com>
 <20240522154659.510-9-quic_grosikop@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240522154659.510-9-quic_grosikop@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2024 16:46, Gjorgji Rosikopulos wrote:
> From: Milen Mitkov <quic_mmitkov@quicinc.com>
> 
> Decouple the direct calls to VFE's vfe_get/put in the CSID subdev
> in order to prepare for the introduction of IFE subdev.
> 
> Also decouple CSID base address from VFE since on the Titan platform
> CSID register base address resides within VFE's base address.
> 
> Signed-off-by: Milen Mitkov <quic_mmitkov@quicinc.com>
> Signed-off-by: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # sc8280xp/sm8250/sdm845/apq8016
> ---

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


