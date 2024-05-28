Return-Path: <linux-kernel+bounces-191955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98AE8D168F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3441F216FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB9A13C90A;
	Tue, 28 May 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sa/sbfRd"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D813D255
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885783; cv=none; b=aPOSoHAuoPwIG8/k6uJPP6n/NZrkJYF0S85t3IoQlHD7ztWeOPcTzDaw40tcLLK/43LFofko+feWPdYnXyRSUT+XIp0zFVTbpJYFAcxBaXNUWqu8a39/quZ95Yj22ku9nRaH4EVCYTB+GAyZWoTtYwHVsRlZVhW62rQMQvi20Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885783; c=relaxed/simple;
	bh=Y6f9O1rB7bAdaik8Ya5stBAwGWAwYs7mHE+WNyPAEOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLh5mLsTGXJQgfSWIU42nzpGaSzBwilJtVbKkEwYKeI/d7zucb/tAh5GOCBqZuCyIUVZSRjvbvHxHpZnXURqkqCHzUssrAfZdSaapa336oKJuOboV8CKJ+Y9jpmiGHwfEid9UccBNTMxxKgCVEy2PSTox2VDEcfWYr9jZov63I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sa/sbfRd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-578972defb3so645144a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716885780; x=1717490580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDOzOVJxnG+3KEM1LGz7y97uf9duOTHpiqETF8V1CyI=;
        b=Sa/sbfRdKnz8/QMS+xeYM3nSHA4bJisg2W0l25IlBxTxty4NiXGvKntownbMHodJzp
         tITa4FnuRTwj/iW57gW2YpY1FtzaZsh2cZBy3u7j9+1DoH0do0vzwd5zeh28ty/BYNd1
         wq7I7CvDy/HpeR5LSdeCPZF1OIwueGV55tCuYXt76fGjPc5a3kVlIr7C48gVI67C3K+W
         oVsUUdRPpTdKUw1u9NXqw5pPv3JoMavC98Sr0y8XLJpcaNUDcB5XhJeDBu0b1aCHl5Pc
         7smTUTEtiJbRY9fdWSEjbWUT2ob75jgy8fKva8xkFqI7/zUnZ+S/SJV3q/jTt3CVKkuX
         F+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716885780; x=1717490580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDOzOVJxnG+3KEM1LGz7y97uf9duOTHpiqETF8V1CyI=;
        b=YjTwvWAJ6xjsy1OOXBcWihvz5qt7x4NB7OW75C7s04C7N36smN8mTBsD8edXlkezxL
         5phlKWO6sVKlwbqiLSpyhP1HCEON+WWahQH/oSwLzOZ8WSVLVSuhoWuklDAoSl5NOnkH
         YOGXUAmztfieBzPMGXMuzmNHXtt57OoZcRlMtRniByuTffH9+6881efpSazg7L/9rwuY
         7Wj23tN7LdqtJhbjvDNzJRTFTOz1oI9PlnYke1sQxCKgAp67woqHoppPIvXCgWr3rgQL
         iyJE7JU1zuXYxCQEkxdWgaWEu5oSNOkJQdHZPsrEsJHjUBpsM096VuV2mY+kw5T6Mjac
         cU4w==
X-Forwarded-Encrypted: i=1; AJvYcCV/TBmvsrzAC9zlV3cYpftwZlnv0EJXrU6ivbopB3MAQpAdv7oeQKP8674jvJpC+AECAxHNMut3p5vdiI8Jn31ET4RFizz6EVj54xV5
X-Gm-Message-State: AOJu0Yy1RUMP5+mZmgWg1w+rDu24Q44P36bbazSyb1B6VNRKftnTKptO
	a6a3zzvcoGmwl0/xW3d2n1NGkTl49wHDzcWqcRespi/sGM71NHk0TbfHR2/KycM=
X-Google-Smtp-Source: AGHT+IFnwFpVgBPbSYYelUXVLbDbkXbUh2jkTNCogIsjRLaryTZNhcVpgseQGExAcVHtIzwZZr7icw==
X-Received: by 2002:a17:906:69d0:b0:a59:9c4d:da3c with SMTP id a640c23a62f3a-a62643ec91cmr716821266b.40.1716885780045;
        Tue, 28 May 2024 01:43:00 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c8170cbsm585860666b.20.2024.05.28.01.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 01:42:59 -0700 (PDT)
Message-ID: <9a0073a0-d598-4c1a-bb32-328d0a279152@suse.com>
Date: Tue, 28 May 2024 10:42:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Oliver Neukum <oneukum@suse.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
References: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
 <20240527-yoga-ec-driver-v3-4-327a9851dad5@linaro.org>
 <ceb1f7b3-2787-4166-846f-2427b44b3e62@suse.com>
 <vc5nd5dl4czkuxzikazn7ndy6wghlchqsrcgxf7n5w53w3o3m2@spyfgp5pwy4y>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <vc5nd5dl4czkuxzikazn7ndy6wghlchqsrcgxf7n5w53w3o3m2@spyfgp5pwy4y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.24 01:15, Dmitry Baryshkov wrote:
> On Mon, May 27, 2024 at 02:26:36PM +0200, Oliver Neukum wrote:
>> On 27.05.24 12:03, Dmitry Baryshkov wrote:

Hi,

>>> +struct yoga_c630_psy {
>>> +	struct yoga_c630_ec *ec;
>>> +	struct device *dev;
>>> +	struct device_node *of_node;
>>> +	struct notifier_block nb;
>>> +	struct mutex lock;
>>> +
>>> +	struct power_supply *adp_psy;
>>> +	struct power_supply *bat_psy;
>>> +
>>> +	unsigned long last_status_update;
>>> +
>>> +	bool adapter_online;
>>> +
>>> +	bool unit_mA;
>>> +
>>> +	unsigned int scale;
>>
>> why do you store unit_mA and scale? This looks redundant and like a source
>> of confusion to me.
> 
> Here we just followed the AML code in ACPI tables. The unit_mA is a
> returned from the_BIX method, the 'scale' is used internally in the DSDT.
> If you think that it's better, I can change all '* scale * 1000' to
> 'if unit_mA then foo = bar * 10000 else foo = bar * 1000'.

I think that would indeed be better. Implementation details of the DSDT
should not dictate data structures in a kernel driver.

	Regards
		Oliver


