Return-Path: <linux-kernel+bounces-200575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC2B8FB1FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7132B1C224AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611D2145FFD;
	Tue,  4 Jun 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTlQw2b7"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A439266A7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503525; cv=none; b=gInw1lb8ZHesvn5Hrwm2U/gZDoT7TBFIegfEplhu0vGfuu1ZZagKIcDIZhHtym5TBC6/cNnXCKu6x8Wt5mHykv9r0v11xQtO5VKLtIhB5V3oYAsrjYouxqYjLAWTrQeeRu7YvZhvK3h0VlG4asKZ6i6BJJLC9OYEsQIjzgoVuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503525; c=relaxed/simple;
	bh=bMG7RvBmDOkqx6HToRknYbCvXlHhwizfl3ox1z2+VLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERX9IgMYWeVirGL9b6cn9nKi40KF6ycMd8qvJHKnA0RrE8mnHsBDudhPuddJIFEnDU16XcipxQAdsbry/RGBtCrXL5mvcpR8Pc/M0y0HujmJG84H4F730arWh54q6zsMvNgSt/VhJ/lc6i6ft6vbBGTlL0u0sYPty4yKxC46/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTlQw2b7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68fc86acfaso354311466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717503522; x=1718108322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/f5gcn/gTUAWBZ3gaiWLhvClesIPejw9W8fPNXojgY=;
        b=jTlQw2b7HMNpIRmKXor4JevFfV6l2cGI8ZKYHt5FOJUY4bKmimzZSXuiUck29vXDUz
         hJo+v8jYIrKRVc7CN3qbbYZRxTzAWo4XFUuRtM4DWua0fL1ooF2EDWk8pt+opjfA2EpZ
         LOEE5YhtjquluLwSI7zHCvXoqGfMI2lwxLIpFW+lJEmjJBgU49uuzeaoA/D7iJi/njkw
         WBtsnPc2TWvpMO5+VCmDCiUHeGYIC8PMjthHwdhKghQXOQOfhuKEn5nfWP+u9zscmvRy
         zttvrMjPDv5Jw8wxVr4SEQALypeHfX0+9gEpyi9AatzlfQT54kkoSxAvEJoSguebSQqE
         GwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717503522; x=1718108322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/f5gcn/gTUAWBZ3gaiWLhvClesIPejw9W8fPNXojgY=;
        b=REcnw0JeTApU2nvblPI/gPd+952rOWr6J49VPearnYWDcgoita739dBT/NaGHXXgNi
         Yp9fK/K+nvTZRqG3WE+wVoL9XSM1P/1PFbd1OJNjtGTx1IhR94QkvWKztwkVMPtcIFIK
         iE99lOL3KkYkKWPfc40v1ivKk1ystK2D1JvtyzAGDd0wUiERi7+EG+xDEWNksDBC9hEs
         045qz2lbFFt1zWfWgtXB/ZN3vo3OiCkhkoshrEppffThUJi+egOt+WltDOC1DaIx8POW
         sYN3F1vRlHy69CPRjYvd7AgGpr1RN5vsIOB79Vx6iHO0ezp93DZBccBKsk2SyJAyj0+Q
         r/sA==
X-Forwarded-Encrypted: i=1; AJvYcCX3HKU+SahfqTqHgWYWfFLoSxu9xDAtE3JKcx92buty3+cVvMCR+Q0vFHGXHwzpCQ+YnUVLoCDaCD4Ix9QDh6X4VxikNnJYVoNUx1m1
X-Gm-Message-State: AOJu0YyymMdtz6PP8y8lsPBajhW5LMnh0rRxl6z+h7tlSo4gdd1asLG9
	sEt0ZKlYK0OHYdA139vrKQlgJoF75nR2tXG0JGeudgQo44Qa/TylBc6zkNa7JU8=
X-Google-Smtp-Source: AGHT+IEXNoxMtI7ICaXqzcQdFet4MgSRtFpxYFqM2yeMMrmzQXZ9URAcl0bri5e4o/dqtHxHzUPSdw==
X-Received: by 2002:a17:907:20ec:b0:a5a:5b1a:e2e4 with SMTP id a640c23a62f3a-a69543d9983mr189395966b.20.1717503522358;
        Tue, 04 Jun 2024 05:18:42 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a2fc6efesm511558066b.161.2024.06.04.05.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:18:42 -0700 (PDT)
Message-ID: <0d0b48c2-c8de-417b-8180-4eb2aa24c9f7@linaro.org>
Date: Tue, 4 Jun 2024 14:18:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: qcom: Add initial support for HTC One (M8)
To: alex@me.ssier.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Luca Weiss <luca@z3ntu.xyz>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20240603-m8-support-v1-0-c7b6a1941ed2@me.ssier.org>
 <20240603-m8-support-v1-2-c7b6a1941ed2@me.ssier.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240603-m8-support-v1-2-c7b6a1941ed2@me.ssier.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/3/24 08:28, Alexandre Messier via B4 Relay wrote:
> From: Alexandre Messier <alex@me.ssier.org>
> 
> Add initial device tree for the HTC One (M8) smartphone.
> 
> Initial support includes:
>   - eMMC
>   - Power button
>   - USB
>   - Vibrator
>   - Volume buttons (GPIO)
>   - Wi-Fi
> 
> Signed-off-by: Alexandre Messier <alex@me.ssier.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

