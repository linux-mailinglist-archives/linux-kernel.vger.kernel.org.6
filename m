Return-Path: <linux-kernel+bounces-405250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA59C4F13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD21281682
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3E20A5F1;
	Tue, 12 Nov 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReATsknb"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084F1A01D8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731394885; cv=none; b=PdSJkuezgmvYBGA1bP4uT/V1ZYZn1NixEQlDYHYzzDrEJYzztYp09BLSMX9+oGMbrIlvfEo9mvd8DUUGEFLS3384eTDMYQ5o1sOhkDKUBhkRWTqKXyb9jVHXq/5v/bth2YIU+Ex6TwnWpkqFud0Xk1myFFnejcryNS6zce9OtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731394885; c=relaxed/simple;
	bh=1Uzacw4ZWXaBfsEOBKezW2Dbt7/ir/lJdgwfmk4QUAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSS22tilQ//alkDiFrqzLTTXaB8o1iCiYZiicPnI/2vlramHtdrs4B9Ah+uPwuUIjW8H+puMANDNPOMYhXCEGlWGmnzVMoIc/vlP6bCvXbNDse1a0NC9bxPFIcn189aIaEoVQQdVTpi7kB/wVsvLIIzgHC6cpYn72URZMd5Xis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ReATsknb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so3489733f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731394882; x=1731999682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e90Eas/uN+CMCjttr3SXpKE5ydwUVfeG05npd83rlog=;
        b=ReATsknb9BhOXxSf224XsLvqHp+WThHF0nXTIBErpi6tfG5CXjXol7UTCDnK5qsEjL
         uU+2fVciceduT0SC+gUmSmSMwNz6j2CRQynJwBGic2Dk8boeD6mOPIV09SKRtmqYIQvx
         /dM5b5PX5/UJDH1YCPr7Z1dLGKp5vGUMLzzCejLZZn3/nRpmd+dAsJAEvJ51Cr//W7FI
         Yu7jTlLYblRL0PmRgzo6v0vPVv+ET1HHF0ktIXg/X8BQc2X6zkb15MMmmfYGxq9hasql
         Gg2ITKrRxQhKkEeSnuyFO5RhcvuCihHrcyLkLIiU1vPV7ViaCSqcsVJnL8kRLavo6RRN
         1pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731394882; x=1731999682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e90Eas/uN+CMCjttr3SXpKE5ydwUVfeG05npd83rlog=;
        b=S//vLGfAbTX4a9UAo2droB4VUMzE/d5rt3yF5BQATLWlaLcpqpbeTAK7T0oFNrwKDu
         oNHkSm4Q/PB3PTe6htQ9HcjYtCCSNUZkiRZp+FfJpKxEDIlEfEjh/n7HSL/6CCIMJFbV
         4vQqF4KjjaBLYo7fk6t4wiDO7f13XhoEeTagDs4KCXrewF2ovV9RvPG6HMVJKiJKTYrP
         7nHZU9+UG/ZAYhEgFZrwDGSKtBWMmV/GYuEwfbhas93tgWhs+tNmm+353DV+3ofPzaLe
         so0CRXA0GVPY7pRXoPShsRZ7iXHCIIq2zLkVFz0e9B5M0cWW/5+MJMuInmZoSaFJDpjp
         2TYg==
X-Forwarded-Encrypted: i=1; AJvYcCWodTDjVvAXphR4TX7EOre+GxF9RMSFQ4elaMT1hyDwmTaaAJeYiBDVfrZhKsZKUkCUQIIFIciIg5xEQ7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgLncRRKg3nn490R+rpFsJ1eRH+oT+/rfmwfFCjubB4UbAH87
	ghYnxHnbJxaHVzg1vQJXJiy1THUkgzCVl1fXKO2toVRp24yy9qT1ggqH6uohdPs=
X-Google-Smtp-Source: AGHT+IGzjqCewg7v6LJsuluGeAw1t5n9E9T4ICaCzkpdT98/eoBBrmLzKDxDD8P1qsH+agtyBhgBiQ==
X-Received: by 2002:a05:6000:1ace:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-381f172a8d1mr13824302f8f.17.1731394882338;
        Mon, 11 Nov 2024 23:01:22 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9f8dfbsm14807593f8f.73.2024.11.11.23.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 23:01:21 -0800 (PST)
Message-ID: <7d5dcd4e-967c-4627-92d5-86232492c7e3@linaro.org>
Date: Tue, 12 Nov 2024 07:01:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 2/2] mtd: spi-nor: support vcc-supply regulator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: peng.fan@oss.nxp.com, m.felsch@pengutronix.de, mwalle@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20241029102238.44673-1-tudor.ambarus@linaro.org>
 <20241029102238.44673-2-tudor.ambarus@linaro.org>
 <mafs0zfm57tsy.fsf@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <mafs0zfm57tsy.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/24 2:02 PM, Pratyush Yadav wrote:
> On Tue, Oct 29 2024, Tudor Ambarus wrote:
> 
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> SPI NOR flashes needs power supply to work properly. The power supply
>> maybe software controllable per board design. So add the support
>> for an vcc-supply regulator.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
>> [ta: move devm_regulator_get_enable() to spi_nor_probe(). Add local dev
>> variable to avoid dereferences.]
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> 

thanks, Pratyush. I sent a v5 here, where I introduce the temporary
variable to struct device in its dedicated patch. Would you mind adding
the R-b tag there?
https://lore.kernel.org/linux-mtd/20241111111946.9048-1-tudor.ambarus@linaro.org/

btw, I try to keep patchwork in sync, so you can see the status of
patches there as well:

https://patchwork.ozlabs.org/project/linux-mtd/list/?series=&submitter=&state=&q=spi-nor&archive=&delegate=

Thanks!

