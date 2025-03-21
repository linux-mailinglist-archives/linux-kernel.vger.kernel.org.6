Return-Path: <linux-kernel+bounces-571766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7FFA6C1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB687A5E01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B422E415;
	Fri, 21 Mar 2025 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ap9j5758"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F922F38C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579640; cv=none; b=sxzl0+8YQ2w5ORXJo433WFp6VUSQM1jUx7UKWH8UJ1LQ/U2K+JVoKQhkqfj0Pu5BPNjP4m4RqhMFdhOp6a6MKlS8Hs/gP0QfSphbxaXUSZFADRkWXCTuZueuqxgXyGI63ryoDniAQn1mBCjOFnVuJUDmMfDKsKXb+m7OS/eUtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579640; c=relaxed/simple;
	bh=U6fktsyMuyMuZdm15c/lbWLdkSmOMUNXc8kCcIrjy5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUdrUuHV45NdP2g167wmcthkhpETEf5a6dOFkq8rWL91HHxghXUYh9hfmVNF50/kaDLx6gkL0FYCH8NMNf/8NArjPEH8X9vvcVCicF/fKoVChEofYf5B9Od3S49KGUJdEsJ1KnMAFQ0Mg4DFv6fyd6pW0hqgFumMQaZfBYYNXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ap9j5758; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742579636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3nRKMratk622C9divVml2hIzMFZgLrlffCOuR6FHAA=;
	b=ap9j5758KELZ4iWcVIeBWOgyDEkE3Kmc9F2iLmk4W01PxYY49AMG8X1SExB5PNA/jGnBJ0
	Hb19lZ7VGC+H3/gzJCezgm+8DzrDDgxzSmeCL04kRuN81noSUTPGX3dXEimzPPs8CA2GJo
	Yjs5egNl/m+CxnyQJMvvsYxpOecBpRU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-N-PnQE04M-WsRDoUdgSZZA-1; Fri, 21 Mar 2025 13:53:55 -0400
X-MC-Unique: N-PnQE04M-WsRDoUdgSZZA-1
X-Mimecast-MFC-AGG-ID: N-PnQE04M-WsRDoUdgSZZA_1742579634
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so16560445e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742579634; x=1743184434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3nRKMratk622C9divVml2hIzMFZgLrlffCOuR6FHAA=;
        b=LGpUr7yrVnYRcIoQY/z4eOpACV5ZcoWlXXuiLZxPmlV+T/6HwNZhvpJDNcbINM7PfU
         nGNVLqsa+nuMa0n/4Czkg+2XmgDzJRPZhkpYjPD9gSq3xNkyLnCKCJ7Oni0nKAFN/g5/
         GOd1sSPUCyaYlrWwskdGW3PBTpZFSudKstTMoJfEnWz+Hl85DyIeLdLc8oyePoO4Pyls
         gybCBm2OmliwoT2I2wABQYqmbM9Y5agle9kyxnl09NjHqHAEe6FDh/swLi5VizPkdnJA
         mjeSAhCF8LhIrpXIZY/5oqSWxMLNuO19O26jCScvhTggzNsMiIRJICo7dnpM1MKLcWT+
         ZG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL50Sfrv0CtNd93BqkJeocIsdo52PG3ZyYIDlqAN/dws4HoH9pNjVHGFdJEtVzHpBywrqtQMlpO6nfkzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjpO8bJZ+6Hu883xKJ2fBBGLjEevRKOyGrz+GM10Y5T/FVac/d
	ZOnRpMfvW38elRxT0D6/YAPv8HR3NMcgCKni6i0UOVH7TYDIul4+TbTnj7sjT6NNZmXbgL/zgd6
	ZOraAiI10XGFlStGRan6lFhDvQeXBpi5HDVEq6sMoeNWg/DacbwcS1PuABePgqg==
X-Gm-Gg: ASbGncvmpKxmUS93vVkuF/6xZsQgxuebNAdxGf4YL7V3MdofDZih8dtAQufIagzFH5P
	RlzrNdiMfsFotYem4b0T2MX0C1zXC7Z6zvjpmOk7XLFEAcwjTobAMKM49gnATeshp+G45wZH+Ex
	ot2Ex2A42O0iTu+0jyDhgdPVbBlM+3ICZyoNDXexatNi9Ms2Rhk5gZS8KQg6WhDEQ6PrbZw4nHy
	mE13E6gSH5XHjcshNPs5eOP0T2FTcZOnPv8abyeCAqpmtX1VEwn0AlzN4arz+jsHlrHhJJLAS9y
	0qc2ZOKpD9Ihmj6Ug/AvAcQiS2nyypLN8Q5aGFx3dObvTg==
X-Received: by 2002:a05:600c:c07:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-43d509e4640mr40035195e9.4.1742579633824;
        Fri, 21 Mar 2025 10:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi86ywD1M/RbAWOzMYKUQu56wBK07oi3Jw+JWYD17hgaWYXOejGMZOs7EmeoFI2yzpzEZPFA==
X-Received: by 2002:a05:600c:c07:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-43d509e4640mr40034835e9.4.1742579633387;
        Fri, 21 Mar 2025 10:53:53 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed786sm83196635e9.38.2025.03.21.10.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 10:53:52 -0700 (PDT)
Message-ID: <d86dd4a4-a56a-4d48-ad7d-182f6fed8781@redhat.com>
Date: Fri, 21 Mar 2025 18:53:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: mdio: mdio-i2c: Add support for
 single-byte SMBus operations
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
 <20250314162319.516163-3-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314162319.516163-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 5:23 PM, Maxime Chevallier wrote:
> diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
> index da2001ea1f99..202f486e71f1 100644
> --- a/drivers/net/mdio/mdio-i2c.c
> +++ b/drivers/net/mdio/mdio-i2c.c
> @@ -106,6 +106,62 @@ static int i2c_mii_write_default_c22(struct mii_bus *bus, int phy_id, int reg,
>  	return i2c_mii_write_default_c45(bus, phy_id, -1, reg, val);
>  }
>  
> +static int smbus_byte_mii_read_default_c22(struct mii_bus *bus, int phy_id,
> +					   int reg)
> +{
> +	struct i2c_adapter *i2c = bus->priv;
> +	union i2c_smbus_data smbus_data;
> +	int val = 0, ret;
> +
> +	if (!i2c_mii_valid_phy_id(phy_id))
> +		return 0;
> +
> +	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
> +			     I2C_SMBUS_READ, reg,
> +			     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = ((smbus_data.byte & 0xff) << 8);

External brackets not needed.

> +
> +	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
> +			     I2C_SMBUS_READ, reg,
> +			     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	val |= (smbus_data.byte & 0xff);

same here.

> +
> +	return val;
> +}
> +
> +static int smbus_byte_mii_write_default_c22(struct mii_bus *bus, int phy_id,
> +					    int reg, u16 val)
> +{
> +	struct i2c_adapter *i2c = bus->priv;
> +	union i2c_smbus_data smbus_data;
> +	int ret;
> +
> +	if (!i2c_mii_valid_phy_id(phy_id))
> +		return 0;
> +
> +	smbus_data.byte = ((val & 0xff00) >> 8);

and here.

> +
> +	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
> +			     I2C_SMBUS_WRITE, reg,
> +			     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	smbus_data.byte = val & 0xff;

I would not have noted the above if even this one carried additional
brackets...

Cheers,

Paolo


