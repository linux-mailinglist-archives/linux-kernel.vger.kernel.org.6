Return-Path: <linux-kernel+bounces-273769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90480946DD3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 11:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D78128164C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C6210EC;
	Sun,  4 Aug 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtC3LEO7"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92192374E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722762589; cv=none; b=l5vkasI33NQkjr7vhWqknGkAx+cQI0D48086n2am+mhpdzi/zP2mzfUHmFiuyZ4pQicTM77Rmz0MGeEo2lzl0GIgX5KwgLvxw1iRaBnjLfg/gyH9oIpvJE63IfB09QsLdpTi9VYmsYKtutuvSPXir2xUPq6rD8CbyGWBxzCDYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722762589; c=relaxed/simple;
	bh=msD+Pu+Q6D1xBrZhQ7xYLQP5vBlKSa93nvdA9bCO7Jg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l6USHjd4bS0IbA2SOUrKztob5FhWvy/hS8PUfZXaSalnwhGTOsx+2fKcalQTKn+coizA0A8wEKojB9MRLFIS8n2/fdMxWSgzf0jjyMrh6hrmRZpESNTUaDFUrZs+sDDGAgL+b1j0L7eerwPzgmrzpBRKLLR4qpd5vRM1JJ8lwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qtC3LEO7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367990aaef3so5110574f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722762586; x=1723367386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHLoWshexZhuP2J8+WGpm+0qtk9I2Aug6souXmLzt8E=;
        b=qtC3LEO7hADTBlKAjiicGaI85SYvsNPdTej84ruDwA0XRK/iZMDaJqLqDVa56mOWmw
         WjDxlx+LIZOgeS9WhopbUiBOgPApnoYkzXC2fMNAGmo5n+HvkFcYv4+IzzrV6ePaXSGl
         ED71YXCaVfL70QQ+nJDNqAcj+qPmzciGIG3JnfFbehOGaerUC8fxgaa8QUU5juHa6KHk
         1MBYpU6aA08ENWN/p7qlp2kkxWgERxSKVuAF9IF0Odxjk7ddZcHIlOj9HjBrbNMGqPjX
         3jvKgAO3RXOPZPVj6MVLtfaHG0yG6PHKU3P+IugiWjwh88FBZQiyMYJRL95bIu59GPAE
         nT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722762586; x=1723367386;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHLoWshexZhuP2J8+WGpm+0qtk9I2Aug6souXmLzt8E=;
        b=V6Wxq48d+myiM+IuF+Mh7AWzv2rK7nVBnA2qhbJARRlMEDLdHpv4GYCVJuN5VyTBi4
         DOsEYgz8yvW0Kr0eacfvrKA0NhISvuIU7s3ugcTeHZRjdTkUCHSjF1qpksXmZDbSCK/z
         lo8bXM6wIdNEXjqHEPPcuIQ9qqDgIIgxjtH+NAUGcINCgLbPUCFv/D3Jy400bKl+MeBB
         WB0a33molcdZgyCJ2ZJHyG0vlgOY6jnJ426q9xwUy4ukxpsSicjuaqZyMsjOfl72Za1J
         f3b2fxQA2H0rEERx2DAGoOzHDIY1Gv5By1FdOrGkuDCUl3Qyw3xSSo1uzSLJ9zd15hTJ
         ae1w==
X-Forwarded-Encrypted: i=1; AJvYcCVSMA794isiQF9zxNIRQsH6ldMiYyTQIIQeIWpARXdDyF4CpA2lbvLkn6jP1hcOe9mZHfgdJ4yhs/Olesad+SG4KYZirHKkrArxzRSz
X-Gm-Message-State: AOJu0YwS5axGhKEsRshuZ57rUUmo/TmSdkQtlcGepfB9ZswLZOSfLIFF
	O5wI5BnUo7TfeowJiSjMa4bkNWDbCg6XZGgw8WA2MG8/E/wGGf9Po8MmAyqKvnM=
X-Google-Smtp-Source: AGHT+IHCO1fd/5h1ijS72pP957S/1fryoMWPBggf8fwYHEKJsA9djK2DDYTC7fOb8ySFt7DWWO/kBQ==
X-Received: by 2002:a5d:5c87:0:b0:36b:bd75:ed73 with SMTP id ffacd0b85a97d-36bbd75ef23mr5985987f8f.23.1722762585867;
        Sun, 04 Aug 2024 02:09:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd075100sm6244814f8f.105.2024.08.04.02.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 02:09:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731191312.1710417-16-robh@kernel.org>
References: <20240731191312.1710417-16-robh@kernel.org>
Subject: Re: [PATCH] pinctrl: samsung: Use of_property_present()
Message-Id: <172276258438.8347.5786673357734721862.b4-ty@linaro.org>
Date: Sun, 04 Aug 2024 11:09:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 31 Jul 2024 13:12:54 -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> 
> [...]

Applied, thanks!

[1/1] pinctrl: samsung: Use of_property_present()
      https://git.kernel.org/pinctrl/samsung/c/aa85d45338692e8b29b0c023826c404c3e7113a6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


