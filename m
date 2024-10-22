Return-Path: <linux-kernel+bounces-376452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38749AB1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EF61C22488
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B851A2C11;
	Tue, 22 Oct 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPdHjBtl"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BE1A0BFE;
	Tue, 22 Oct 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610061; cv=none; b=J/aYU4u2YuR1B27wDJYPppd4+qOHQQHX/gNROr0gugNR056BjVpo8VuhGywVhungWsMz53TQSeE7I6ki2vdR1NCO24kRvvPmaeEBaWgN1HIbNp0YTRZiU4WVMvTuHLtWc382d5et6fRfuKdLgxqeWEHDcoMRDuZ+u7mcWZmLSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610061; c=relaxed/simple;
	bh=GO9vmWxSWOv2/g83ik6OUO02XbMUtx8PCovxiIgB4kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsCG1o5GawSkaD7+FkkR2HeSqWQG4+M9VxC0oLXBCzhvb+cihiMpZxZKBg7VY4rM/m/n1NZkEuawWUxSXtupClF6+DHVU3e0gBnp3tD+iRR3y/ok1j4QE6irNHNFvyw2Q6KBHChM1klIgG5bsfqGIwo06HDgnlrAcrxVIhhXZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPdHjBtl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4299303a12.3;
        Tue, 22 Oct 2024 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729610059; x=1730214859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NW/rEIqVYk20Bagh13hOd3nJbOnRwuYybRFg+LGZWqs=;
        b=mPdHjBtlO8cDDToQNjFq7klQfYaP4xq3aqTRxpspIvIi9JpBrAUGn3NnhK9IooMmuq
         0xi6C+jYHLrmahG+l95a7fYOWHBNvq3sWtaEUD2tug41nr+pOU5ievU2CRmmazTi7n2Y
         3UrXPKBhD5sfEJs5AbRxTVHjNuV7mbAnGlN+U952nxXW8/H/94qNezs2jLdfqL5I1RIi
         8+tXTC5c8hDfFGeJNd/MDMRRkXOcQ2I88rQZu2I5yFDpCGzKdyT8Ik3UAwzoSgrXb1MQ
         CmfkASuRPHMZmyvalleCyRlhtjpOvnUIIaVNr1D8goXQC44BWjC7qu55MhAMsiyDiD2e
         iPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610059; x=1730214859;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW/rEIqVYk20Bagh13hOd3nJbOnRwuYybRFg+LGZWqs=;
        b=kW5M0T7+j8XA+oIAy7SfvCSrKehcOuFnNfJ/ekop0/D8NBpalz7K6Z7iEVl7gtsDFt
         jtRP2KKJAOfkFC9tnGyDNq6fiNme2rQMLEpp/9dQ86ZXPNiC/4j/G2GOOKR50wvOx162
         Y9KvmcTZtf261gM3Gpz9SUuLARU4pPA2qGtUb9fkEEAZ5F56osBbY56t0M03WHyp/fkx
         LB7iWgvHGnePdE2I1fzpJFNFcTHo/swOCB+w/ubKiFWcgKKjR0ZOo7VeFXlX1kaiE/17
         MipT/XR5fTKM8ZNzI+GT7YZGSm94faBrkk7oqdfTr4CiNhfkqim3YCV9uu4mwAYdVxIu
         hKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhLySQyaTmYe1hcS/TQxxLaayQX0ofirzXbZu0y+GV4NpssOcHj0RR9gIxtoVe23fM8sZg9nPq+5KD+2yL@vger.kernel.org, AJvYcCXIFsiq1VKrMLMJP/h7dcRKnnv6wow2+TodNlO69Bca1cixcMIrg9DiFyxTs8acSdLjhxCgoUZlIejZ@vger.kernel.org, AJvYcCXqT0miyiyAfmU3CgxKbqs3y8afsZ1HmHWcrqubVwPt/g+ORFiWjhdZRXbByF6Nm5VeHYwviRZToSHW@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZg9b8NE0aqnv/U9OgLHtYgC/SXj4/GbeO/dHCwlBxghcekRp
	7LpqOab042INdrdc8p4XIk9v6UIvDYoxJMocM8QAAXkTmpFrf93GYmu3fg==
X-Google-Smtp-Source: AGHT+IEyly+eku+lEevkwvNw0Dq8/4qrGbtFxG7XfkvLcDDrgen1PINyCP0GLvsiXBtPJMqUnrWhSw==
X-Received: by 2002:a17:90b:4c12:b0:2e2:ffb0:89f6 with SMTP id 98e67ed59e1d1-2e5ddb7018amr3032961a91.15.1729610058716;
        Tue, 22 Oct 2024 08:14:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad25cb0asm6329691a91.10.2024.10.22.08.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:14:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f6846ac5-55ee-405c-939b-1199ea362fb5@roeck-us.net>
Date: Tue, 22 Oct 2024 08:14:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] hwmon: Add driver for I2C chip Nuvoton NCT7363Y
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, baneric926@gmail.com,
 jdelvare@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com,
 DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com
References: <20241022052905.4062682-1-kcfeng0@nuvoton.com>
 <20241022052905.4062682-3-kcfeng0@nuvoton.com>
 <2339841b-034b-440f-83ac-139d95059727@wanadoo.fr>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2339841b-034b-440f-83ac-139d95059727@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/24 00:20, Christophe JAILLET wrote:
[ ... ]
>> +    hwmon_dev =
>> +        devm_hwmon_device_register_with_info(dev, client->name, data,
>> +                             &nct7363_chip_info, NULL);
> 
> return devm_hwmon_device_register_with_info()?
> 

No, because the function needs to return an integer, not a pointer.
And
	return PTR_ERR_OR_ZERO(devm_hwmon_device_register_with_info(...));
would look a bit awkward.

Guenter


