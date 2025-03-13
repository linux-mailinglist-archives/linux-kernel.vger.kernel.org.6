Return-Path: <linux-kernel+bounces-560344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C1A602D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164757AD690
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9781F4606;
	Thu, 13 Mar 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOlMPu7Q"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7E6F2F2;
	Thu, 13 Mar 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898352; cv=none; b=XEIOb59DLjmm5LjO1ZQAPvhT/t2fgQDNscpFvzS/Dav38jQ45fzcnVLk7iB76CRMDNoe9mlY1ptoNCPn96j4Macs6zbVnjEYT3FGjuR0UI7G3arpZpu+phUcxfpGN9xPQMxirTnN4rmY4drB28gsg9VrGTO5ziLjVhYPWGup5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898352; c=relaxed/simple;
	bh=oHVA6a2AKNa2vHiRWvGEv+uMrhVRRyUqCTD1yNo12m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJrL/SQBGVK7x7BCJoajoBiMZeQb9T+/rVuKyfZbsgFQCmalXIJi/M8lx/BTO7bDO7rPqcyjCF4K4mLmb6nsDvXLZ6vPDw/7PaoAW3gw6JEXYJa4kI4VaZ+i1+gsCJS1UopmFYE5NlXAq3JB64x4BSv3s5BHz1/8I6b2GePz10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOlMPu7Q; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2aeada833so270735466b.0;
        Thu, 13 Mar 2025 13:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741898349; x=1742503149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y80nSXH6gqqrmRGM3IsXoDQwjoa1+dDg8jnx+cu1UCA=;
        b=EOlMPu7QGW9gZ4j4cdHb2pU02+X8Uv7Q3WPVOQ5jZq4uHK/t2naEtgma4d/nI0Q0o8
         EtbLbZSpsJoYxqwMhkde+AY5QdKpwwKuseLUzLZzi7yhjKbdviJLIWqllcTbAhrKjhqP
         EZfWhKXiuwMTkj0Sehha65qO54gJKebNt/J3wHFNOiTen+F/7XzVMTfNwMXi+urMfakM
         ncE7CwH1lwnsnZhKLS0s2yEyrOGICAPKHBqt4j6/pyXMQ6223xROtI7XmdTBMFAvXXiA
         2q7KS7/TY5s7AnC5ljp0qfcOv0FNf7O0quwzELsBbjP/DbbgaLDVMd3O1nEp+rGI//JL
         cT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741898349; x=1742503149;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y80nSXH6gqqrmRGM3IsXoDQwjoa1+dDg8jnx+cu1UCA=;
        b=tSOfa+z3bIYoJlI8OEqwpzKJXwfYUP2Y+185TcnLT40qTHjL1JkOZycQCfXilInmUG
         3cT79/afKhasYMcXm14CBUhOXtTdK5Pyxh8MYox9L4n5OlKIumsIfjqi16gUz+U153U1
         okmbs8N8Vi6D9h+sjITaiNz99qQXMSuM1oky4Nt1BshOoukZ1C4BY1GWenU4UWuJzebU
         OhvZWxT4HkDZtQk/7CE9aYCd1hOcexSsaJjuzI4+ePDvJF8PjYi+jBg6oWmruABmxnd1
         QTurzTZxaAMKsNKCcc5DUfTwBjyiRvE1ugIU55pN+n0wcQ28qUhaLehgw2Z4UgAjONsm
         jQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwYMif/Xer0pNiEsL25do4d1yMWSSBGPlByvR+INEkij/rK3JY+RAdTL+d1Eh6DZfFhESkkDGu2D3u@vger.kernel.org, AJvYcCWrNvR2CuhykrdYfeNnHF/EtBuqtRRq2KQSkehjK48xYLPLsSKX0mkcUAaEJ8rzjmthBesw9eE8RUsCx1pp@vger.kernel.org
X-Gm-Message-State: AOJu0YzSD87OS4BDtb1Q3uM4yKeEH11mz1UeP/pGNGo74GhIuJPL4qbD
	b5z6A2eVF1nTKA2HjzhkAAuBbZopDTkXNovgT9M1VcFRWPAn9N+j
X-Gm-Gg: ASbGncvLYteYpQdwZ9l9nODMPmoD2VMfhdXcku2qlHhHLb2Gqu0U3nN7muKkER9KAf9
	ZLwlZR+K2IKwq/H76mKteoA8gOxmO1iPcGjtc+tbr6HLI/aarHSlDthHYWu1cAkIv+CNRbq2pJl
	+sw4AcNsXB0BIwfLG8ibXzZ690loABoE2ZcLH7P4+nlmpyMz5aTW8HltTvCpkmp7r6G7jKnRdea
	rV8X0tGaN538zRctyqauRhU38SGtrZOcxir8mpZqTtdw0pTiCO4MnY5Ld4w4jda8/S8Q3tO+31w
	zsLcTMNsTCTws87IsCZWHvoV6HDNNF7GycEYW/PCqTpdGHaywvF2Og1RGABECreJEHtqJwF1UGb
	Wt2gpBjpvuxATDPJeJpFI9w==
X-Google-Smtp-Source: AGHT+IGgXzCvFKIwuNzp9fqTkDSNxicFmg1nWVCw8cSfyB1nRxtqRIguRpztRQZovtRqtEoojZxR6A==
X-Received: by 2002:a17:906:a297:b0:ac3:14e1:27a5 with SMTP id a640c23a62f3a-ac314e128d6mr343436266b.1.1741898349044;
        Thu, 13 Mar 2025 13:39:09 -0700 (PDT)
Received: from [192.168.50.244] (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a489c9sm122016566b.152.2025.03.13.13.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 13:39:08 -0700 (PDT)
Message-ID: <f363c1ce-8612-476e-a5d5-c3cb358bf50a@gmail.com>
Date: Thu, 13 Mar 2025 21:39:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] mfd: bcm590xx: Add PMU ID/revision parsing
 function
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250304-bcm59054-v6-6-ae8302358443@gmail.com>
 <20250313132036.GB3616286@google.com>
 <ef190ba8-a5c7-4a1a-90e6-2610de00e4ed@sirena.org.uk>
From: Artur Weber <aweber.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <ef190ba8-a5c7-4a1a-90e6-2610de00e4ed@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.03.2025 14:25, Mark Brown wrote:
> On Thu, Mar 13, 2025 at 01:20:36PM +0000, Lee Jones wrote:
>> On Tue, 04 Mar 2025, Artur Weber wrote:
> 
>>> +	if (id != bcm590xx->pmu_id) {
>>> +		dev_err(bcm590xx->dev,
>>> +			"Incorrect ID for %s: expected %x, got %x. Check your DT compatible.\n",
>>
>> Isn't it more likely that the H/W this is being executed on is
>> unsupported?  If so, say that instead.
> 
> Given that the compatibles are device specific the driver shouldn't be
> binding if the device is unsupported.

Yes, the intention here is just to make sure that the DT compatible and
hardware ID match. Unsupported hardware would not have a DT compatible.

Best regards
Artur

