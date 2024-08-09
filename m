Return-Path: <linux-kernel+bounces-281072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426694D2B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6CF3B22421
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22D198E6F;
	Fri,  9 Aug 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzdzhlIN"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527F2198A2F;
	Fri,  9 Aug 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215244; cv=none; b=PoNjKBIPkpGD1PkIsRbt7loCsdixsyzbdHA6htkFub/7XrrEhRm4x+eUbfNmuDOCujpVipFRk7vj/Ll4mAUo4kHx84Ho3uP+AjJtXHQ0WX/3lMXQxa1R2G3+DdYF5i4RA/IiIY+Bdvq6mIv9pydqiZPF9d2OrCXwoi6zsp1Ltbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215244; c=relaxed/simple;
	bh=dfz7Gu0AJZg8x8XBlSIzUNGnlZE09dP5QTbcK9p0RCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lwMaStmuX9Sbq30kKGb1xT0LMJ7lDbhcfbgOSNEn7o9W+DWqUB8BaiW30MWDf395a3f3n1DBK4tHFZmpsB69HxDnnOa9BIdcVHPlqE2MVA4xV6onQYgBWhJEBitwu2B5QgrOZq9yXAHo/EzzqgCjS7mUrmCZgXh94AA9TD3SSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzdzhlIN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ff67158052so16393485ad.0;
        Fri, 09 Aug 2024 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723215241; x=1723820041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v+b94j3kq0TfnZlhwtN292H78EBl3r523BhYnNAMjHM=;
        b=IzdzhlINjH6g4Z1RD/DZQfWCuEcjB7GxYcHL26LgObOW2i/hWQbEAwVP965/BXzEnJ
         fsMGHBq7UObCsLvNpOqkJ/MA3kdUWnF/L4EscXk5CvD93yiZsPguPXPbskHIfioGm8DZ
         iu7Nu6m4UVH0CbhHMKjonlMX99BYIqdC+7b67L8kHTLI5blJ5M6lZWfUB7YNrq0fUCkz
         g69tXVrWb9OrbY58K+vj1w73H+hS9jLA5vM0ptW1GTRLR1EY7UVSberuDfdYxLnIZ8pn
         bi9NciljYCf0i3GklCVTT+XoUgPgFJxZsAZ7AZMgdpboZIfn1eY6OrZ8L52YzejDV7UR
         68AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723215241; x=1723820041;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+b94j3kq0TfnZlhwtN292H78EBl3r523BhYnNAMjHM=;
        b=YZC/5aOoRbzXER/++3vRDuYuLZJoVUIkL5gtsj4DXsFtu6nEQ3Y+K26gmEJNE5eQts
         B0D4sjLNKriI9IhTA62hwEdBuuh76gZj2xtRN3P4jXNmFAeCUPetmjLyYfD+cc7UJ4eE
         BCNKvOXPAvV0QczMlglP6FLfFny0zbwVvzwU8OvQy8BzRessdlfpE4dTEQ/Td8zOSigT
         Hbwo8yVx0oKqEvrYyINMJAjT4UQu1bq30Nm1KrBsj41SbBfUsek9gBXxpldT/MhJADAt
         436Z/hWnx/A1AsCD7bbAZuarDUSkp7A2AZ51hsI+hIzELl1N+vF6HkU2g67brMy9JhLA
         9siw==
X-Forwarded-Encrypted: i=1; AJvYcCWezdkIH3+QC6JktGl91wXjlXWFKTtLsmpgr9fxBK/OCHWXl7roafbrmtAmYkcIKDS7Y4X8p/KY9oO/07Ou/CTKW0+L7aSbdT26gzMSHodI4SeKpHGYeoMRJEeXFMdYTdzYNOP7rhe4VA==
X-Gm-Message-State: AOJu0YyPNXPAEzRH9ReHtcJTujKVQJ5BOWcvrcIxOGUY6Yaz9rlr3Id/
	F1mZpoSqakv+UseTYaYTd3YCRGEtQqfXXZfRipafUiV6TL+aPDpWCNesJw==
X-Google-Smtp-Source: AGHT+IGMB0naLUwvEEGDGNgPU8kh/Co7oZ+hEF2rJJl1e6tstmRHP4+3YJf53U6e/suF0Tkl4j8o8Q==
X-Received: by 2002:a17:902:d50d:b0:200:869c:9602 with SMTP id d9443c01a7336-200ae5a312dmr17668955ad.34.1723215241288;
        Fri, 09 Aug 2024 07:54:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5346csm143863585ad.66.2024.08.09.07.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 07:54:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6fe6061a-6fa7-4799-8b36-93ad5724f07c@roeck-us.net>
Date: Fri, 9 Aug 2024 07:53:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: add isil,isl69260
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Yin <peteryin.openbmc@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Noah Wang <noahwang.wang@outlook.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240809070056.3588694-1-peteryin.openbmc@gmail.com>
 <3f523574-931f-4ce7-a457-a176190fa0db@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <3f523574-931f-4ce7-a457-a176190fa0db@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 00:28, Krzysztof Kozlowski wrote:
> On 09/08/2024 09:00, Peter Yin wrote:
>> Document the "isl,isl69260" compatible, which is already used in the
>> DTS files but was not previously documented in the bindings.
>> The ISL69260 is a digital dual output multiphase controller
>> that supports Intel VR13, VR13.HC, and VR14 specifications.
>>
>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>> ---
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

The hwmon subsystem wasn't copied, so I assume that the patch
will be applied through a devicetree branch.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter


