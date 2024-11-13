Return-Path: <linux-kernel+bounces-407757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8369E9C7346
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB94283E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7FA200B9B;
	Wed, 13 Nov 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TePBcNgm"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7297E282ED
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507343; cv=none; b=McIttZBk7oyg0OCP/EAXApGAxfN4UYKonD27OdT+GsLs6hEVe7kfpHYLwPbCel8kNKRaEgSC5B3BO40ncykHGa3RopvKCFH8EgkMP6bLJYDefc6eCqOhsxn7DVDjeos7HcdMZO8HeH3ciYTCNrh0lV62SJCJPV40aQ2uzZ+qNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507343; c=relaxed/simple;
	bh=Vpxgs3fsOrKkKltl05+mAKCEFgbkA5xatFHPZwNLaD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2L3RYemucKM1WrzHxqQa73ULygUdOB2xdAFqPYVAvmtowsNS+Y/Z1KXKyzQMNm0C26Qtsa/6fncCmPjVOVVwXCG2tUF9QGrsNEloC/pCcruDnN1vnjBnP1Nvhi9HCL/aIJOd+lSfzYsjUKaOl+M3uhVc6p5H0tNPx8hAiMiUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TePBcNgm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cdda5cfb6so68643075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731507341; x=1732112141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=n+On9Gnszuz/Po31d3jB1A7RSWr5BH4gfYSLMT0c0GY=;
        b=TePBcNgmdSgQ6YOzwccvDdDl8OiPxBxbzz5Ft5UcHSaHo/qNlBN2dtS/zyKyCyb4c3
         8FqlacscMkQiotIUH0KxmSe1oDtcxJl8RO6GoXotvPLdURxxI9d6EtnA4mY+bdVpysh5
         1HZOV6TuekcZDnpyBUuLwsy5cfzBNQphrMsveRRo0Fflh1ZDRiUXPL9gCmlfSjX5+pyS
         w9yD2xJxEemlirSs1SADymIRVs6VheQgnltuXuCRQQRNJN+74OOp/nvB+v+beYpP4DDz
         IZHf1tnGvIQTRLiwt/jZ4uy0pJb6K+nAzpwzUfAPt+XtdTD0GSikGSai5xtyOyvBLYJr
         TGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507341; x=1732112141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+On9Gnszuz/Po31d3jB1A7RSWr5BH4gfYSLMT0c0GY=;
        b=rZKMJlgzFRn8cvQNLkZwhjlABNxoWK3fMvsJm1XjhzmCBADLhzgWJWqAaWycSiM1+N
         YW+iv2WHEghNm2WTw4mReqI77thd4C91HckX+ECpoaPjqG7PaFGcewkvSkc3UpPHnAQ0
         rWWX6TdR7qjNAyef5tNfv4hvESiX7En1Vwyx8436xXzSS5wXE6fioplfdq4tQWIb2n6V
         7dXe4Am8wEXyXE9ksIVcySMrXdMn/abfqmolxZQC/OGMCP1VFLNo5u44PIRNvA0qqIlw
         B2qsp4BG2MkTOQrmw5puPFjsOTzJcO5HFQ2eWjWhybtbC9bZloAYzyJyOgwguNdT2W7b
         AUSw==
X-Gm-Message-State: AOJu0Yy2fzY+yeBPWDhnglKCi/EiO4VbknbOXk77Fl15fUmlJHpou3QC
	Ply+cl/7tkIkJdv8skT03iaxkJSih/0v+pcYLOIaynKIpnpCQD4o
X-Google-Smtp-Source: AGHT+IFkEKPjPeNxwRnTJG+q6YilTsc0NVddYCxOeK3MHf6sMLG4HO51wC6LoKrGar/QR6f8zt98aA==
X-Received: by 2002:a17:902:d4c3:b0:20c:80d9:9982 with SMTP id d9443c01a7336-211b66ad6bamr33875115ad.47.1731507340489;
        Wed, 13 Nov 2024 06:15:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5af99sm111992855ad.171.2024.11.13.06.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 06:15:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
Date: Wed, 13 Nov 2024 06:15:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regmap I3C support
To: Mark Brown <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Li <Frank.Li@nxp.com>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/24 06:01, Mark Brown wrote:
> On Mon, Nov 11, 2024 at 11:07:40AM -0800, Guenter Roeck wrote:
> 
>> For simpler I2C / I3C devices, there is module_i3c_i2c_driver() which is
>> supposed to register both the I2C and the I3C drivers and handle the situation
>> where I3C is not enabled.
> 
>> That works fine unless the driver uses regmap, but I3C and with it REGMAP_I3C
>> is not enabled. There is no dummy function for devm_regmap_init_i3c(), so
>> a probe function for an I2C/I3C driver utilizing regmap can not be built
>> unless REGMAP_I3C and with it I3C is enabled. Ultimately that means that
>> I2C/I3C drivers using regmap can not use module_i3c_i2c_driver() to register
>> the driver.
> 
>> Am I missing something ? Otherwise, would it be possible to consider
>> a dummy devm_regmap_init_i3c() function if REGMAP_I3C=n ?
> 
> Don't these drivers end up with the same miserable problems with
> dependencies on variations of things being configured built in and
> modules anyway that mean we build separate SPI and I2C bus wrappers for
> the same case with devices that do both I2C and SPI?

Not really. There is no equivalent to module_i3c_i2c_driver() to handle both
I2C and SPI variants of a chip. Also, SPI and I2C/I3C are not interdependent,
while I3C automatically selects I2C. That means it does make sense to handle
I2C and I3C in the same driver, but not I2C and SPI.

Sure, separate wrappers can be used, but that makes module_i3c_i2c_driver()
pointless.

Guenter


