Return-Path: <linux-kernel+bounces-186281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D04C8CC224
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F001C20C16
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD65140369;
	Wed, 22 May 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKkEl3ce"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6E7442F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384569; cv=none; b=k+AafUcKH3u9+Lu0aNgyGaQY54Bt1ooauZfyKD1wD6XuX7CqpbyJin5e7aqYd0OpbgQdo0+m/oNbdROemRHCJ/i4ZoDYlRoUDH+mR1w9AeDDjaEgsR8Fi8AUaPJJfAACUMAOoxcXNnOHq5mFmWkXP+hfIwDS5QNUstJTJQdk7GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384569; c=relaxed/simple;
	bh=arHIVvnbSRrU4vMozfw5OQz+OVU7DQz+OL8bfqqQtO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGWSPAktqI+Hh7b7u+rgRjDFjYenmTITj4NlDyP4UKxDrwSduuZvrkI22UG4XlhU7P97MH6i5K4fmre95d4PKvh5IEFN21kRwDGHda7XJPjK1MjrKlkyI63Y3C2Hy0HXyBQvZTXtBfmG9UcFBorH51/9KTRDKK3IUvTEQ3LLEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKkEl3ce; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354df3ee1a9so484425f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716384566; x=1716989366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3YEaU2P9V6kAMeHKPOK/rk+673wWJfJ54FeEoR6SSi8=;
        b=iKkEl3cet2V6hs9n19yJ+5c9IEAampuI91D+a6NkK71S2NlAsatZGYd4Oe5THVJ8EE
         sixTs81m3QQLw39xCBZZe62FCnUx8hJf+creO1O5asAs7xPfo0HZFnEPW5XI6pb7TwGi
         oF7mw9CGCPw8HrAfN8O86fdSLBULMkrnXnvAFTm72Sikt9Fej18KMjMHNRairaHQK9nC
         88sFDcXiQ/f1o0JBcD6xruN/rOkHdnSWBSLMLaWGOwg7+/82aJ8oVQvhLoUUy/jg3Oqi
         itlv94B1k6Ans24NboP0t+uCY66jau/tWcS8CFlh9tD3OSZP/aiYKRmmNxDJhT3Y530b
         cqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716384566; x=1716989366;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YEaU2P9V6kAMeHKPOK/rk+673wWJfJ54FeEoR6SSi8=;
        b=Hsb4LZ5vAlfPO6IOBmOQBHbTwM4lBS8wUsF4EFLKOwTqIXTPx2KW5zn5FJiX4WlsBk
         n+5uTC8NkEtG4gjU/3V+VsXoSwpyWsVbqNCmvG2V2f0o82pOLzjtSzqk9ixh0NRI/kJr
         gusNs5/NQVQpZmcZ798bZembRDegqEIUAXwOqWp/WYRfvxXM76FdO/Ex0WpgrBcdT7P1
         xpY3CLF9T5nuzgVpOMZiwIr+1LKD3Sc8VQKrd5aRhYO/oEs0NIR+rdyQjeV4Xlv4J9kO
         wNfQhoAi3ssuCf9VOKV+3AWxYcuXkOIimZuiFugucwVREFTE/Sdd7A3II+82kuOt38dp
         7mrA==
X-Forwarded-Encrypted: i=1; AJvYcCWByN51MVhd9XlUs6dJqnVi8YQirGQtAMbuhI2KAmpOZ/OfgTSwefEER/0ZAEE1rC/FQjOL8etVaIA307UGM2TWCyH1nlx5UDKK9VMg
X-Gm-Message-State: AOJu0YwwU1s1vG71Uw1XEtHn+6RmiqQO3NrECCjI0izRD7U750CU/pCd
	lodL1fuquEdcKCvIr5sKV1VNHGYoX9s1vsQ3SLMroMO+f1Hx7rw/TCOZ1hGc2z0=
X-Google-Smtp-Source: AGHT+IERBVmiYPz0eY8gY7FQeAxdwHFOP34oTC5lvQ7QWK3cucB0a75XWYHifF9EAZ+3fi2fdNykDA==
X-Received: by 2002:a05:6000:c01:b0:346:bc1b:4efa with SMTP id ffacd0b85a97d-354d8d16ef9mr1522819f8f.32.1716384566191;
        Wed, 22 May 2024 06:29:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm34242934f8f.66.2024.05.22.06.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 06:29:25 -0700 (PDT)
Message-ID: <eeaaf991-0441-409f-b8d2-dcd704d21fd3@linaro.org>
Date: Wed, 22 May 2024 15:29:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] regulator: dt-bindings: rtq2208: Add specified fixed
 LDO VOUT property
To: Mark Brown <broonie@kernel.org>
Cc: Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 cy_huang@richtek.com
References: <cover.1715846612.git.alina_yu@richtek.com>
 <9c1bbe4b38a4ee5650d888478f1ce2cec2733669.1715846612.git.alina_yu@richtek.com>
 <5d26b19c-7679-4dba-a9ba-a7368d39b474@linaro.org>
 <20240522090302.GA19548@linuxcarl2.richtek.com>
 <b094ce68-9ce2-411d-99f2-1f143e4c3347@linaro.org>
 <05843386-92f4-4246-a633-315c3178d86f@sirena.org.uk>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <05843386-92f4-4246-a633-315c3178d86f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2024 13:35, Mark Brown wrote:
> On Wed, May 22, 2024 at 11:27:06AM +0200, Krzysztof Kozlowski wrote:
>> On 22/05/2024 11:03, Alina Yu wrote:
> 
>>> Due to the fixed LDO VOUT being outside the range of the adjustable one,
>>> a special-use property has been added to avoid overusing the constraints.
> 
>> Hm, why exactly this is not a bool property? What are the benefits?
> 
> It avoids confusion between invalid constraints specified on the
> variable voltage regulator and allows us to validate any constraints
> that happen to be specified (though it'd be pointless to specify
> constraints).  The fact that the regulator could also be variable
> voltage is asking for confusion if we use boolean.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


