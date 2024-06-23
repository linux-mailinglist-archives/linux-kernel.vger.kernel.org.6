Return-Path: <linux-kernel+bounces-226120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC7913A82
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E661F20FDA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F918181BBA;
	Sun, 23 Jun 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMtpx7HJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A32181325
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719145359; cv=none; b=FOJSRFmdmRDU31GjPZ/uVN2iONSJoytUZk9Z/G/XdfE9SaIuQcCY7ovhIQyTLE4lYTnV+zRAl9nQ/D2q7qL2YpL2sJYePqwTURAD3pCpO5y5DZHYyGSgc/60ayP96mzXSh7QQI1cQz+rb9rl1CZ8YRYeP19fYFoxh0V6+yA4pVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719145359; c=relaxed/simple;
	bh=NOjUsR7RIcA8rG4eq4ot+rZaEmVPYNRTiT3ZrTnRGI8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sFCsbG7E5/CKlazX/rah+Cx6RLaKxUP3+57HybroUofx7u1oWTaxLDtneqV4ja+gpnhkGh5tmgXNl5ID571dBrwlpmegg41xstDBWZotF6dt7vZAN/R4vMC1twdkD63F2PP0NOVHv/Av61r8RhdjDhiM6L74+nPR1dTHt8CriO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zMtpx7HJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421b9068274so30692205e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719145355; x=1719750155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOMrIEL0MhxUAR/0v8yW1hxKjvgmHLLdsBRgChDfOiE=;
        b=zMtpx7HJDomEq/k0RdekpPUMtXoMd4EA5HgXEzxOgojMplC0xTUqDyRCLo63Q3vBky
         LE7OvO3EQ3f7pY88bVBqyuaXNWy7Aeh4NgrDZ8phKmmic2IfTcOx+5uwMdAc9/RjTe3m
         2ZzoooHdqp9TnZy3ugjX12UhZbM16XiFT5ZyCamaKarvAeCc9qFAPsELy0yAvAt+X0gA
         rJ97eAH5ZVvus3XqHzSaNhfsHUheV14rBLOBWnaQzxQsvGw300lriwQe5ESL7BS53ZwY
         1T3NnD1Di1DqPrfygyGP9spO8mQZ800CPdD9TnqTlXB9r+QkHFilldxai6Z+RPRJzhDc
         hoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719145355; x=1719750155;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOMrIEL0MhxUAR/0v8yW1hxKjvgmHLLdsBRgChDfOiE=;
        b=k6qmPAOQemvCbNH+9iXQLF0asQnSvKPClAjtgRF7FdZzClPhy5VXzNiq+SrneHE54t
         ogFjR8jjV0xke8sqZy868trI4BRlWFoglSN4eZSg/q2F1JBYNtM7IGeACFH/l4LiGdt0
         2Z0H/dcJDBkIG5+mLg4jW4qc4bVZDfwG7RQHSqrl10xtqOBALr+mC1+mEMGSQlNM4naL
         5VysxjLMISkrW+JtgDfG7D4zv6JvDywQTV68qiWe0pjJotOAHwJYyNIRluy+oTYb2KOY
         Nh+BIE+7MZ0VO+yF4ZZS5BkIbbR9UGhwYKqXdtwWT0+wPwwnptVE9tmaYcNSnIri7PQs
         fDTg==
X-Forwarded-Encrypted: i=1; AJvYcCV/3n+ySclvZGD6kUWky+LPwCvRxBx41lZXNho+EsOTUWJRA+RiSUACKylHrNls+VO8kGi5/+azDH53Sym1eQMgQmVGRBBS3hFRD8Sd
X-Gm-Message-State: AOJu0YweUKdoPACKeYvZUaF4C5lbWveEg6aEI8xvu5Rzn6ddk/13kFIk
	5yIhbfpRg86c7ynkOzv8imRi/UunsCOIencQ7DI/RPYjOfpi3Tz8I+1y1jtFE1E=
X-Google-Smtp-Source: AGHT+IEvE94OtsFZofxgbIqys2D0deVC/6lNHjtWLqKY/YBn8di6oHuMsYKyljgRWyW0hjDE/F8OwA==
X-Received: by 2002:a05:600c:4853:b0:422:6765:2726 with SMTP id 5b1f17b1804b1-4248b9cb18dmr16494685e9.30.1719145355013;
        Sun, 23 Jun 2024 05:22:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be841sm136955455e9.20.2024.06.23.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:22:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, arm@kernel.org, 
 soc@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Olof Johansson <olof@lixom.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240613064612.8589-1-krzysztof.kozlowski@linaro.org>
References: <20240613064612.8589-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] MAINTAINERS: ARM: vt8500: add Alexey and Krzysztof
 as maintainers
Message-Id: <171914535352.46985.112856994022791159.b4-ty@linaro.org>
Date: Sun, 23 Jun 2024 14:22:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 13 Jun 2024 08:46:12 +0200, Krzysztof Kozlowski wrote:
> The ARM VIA/WonderMedia VT8500 platform became orphaned in
> commit 8f1b7ba55c61 ("MAINTAINERS: ARM/VT8500, remove defunct e-mail")
> and clearly it is on the way out of the kernel.  However few folks send
> patches to it and it is nice to actually take them, till the platform is
> in the kernel.
> 
> Alexey Charkov still has VT8500 hardware and plans to work on upstream,
> so add Alexey as the maintainer.  Krzysztof will collect patches.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: ARM: vt8500: add Alexey and Krzysztof as maintainers
      https://git.kernel.org/krzk/linux-dt/c/084e77a12c3a1c255ea0e944e9d77d21c9d2247d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


