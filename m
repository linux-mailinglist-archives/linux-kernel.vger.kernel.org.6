Return-Path: <linux-kernel+bounces-408265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8949C7CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DA41F21A59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4FC189F45;
	Wed, 13 Nov 2024 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UArbWzPT"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625F1442F3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529004; cv=none; b=aYHNx2xZIgAo9xXnXyYqNblnv8pRaCgqoZD7Awo/7cu8xqIwqKt2epbFsw/uAYBiS0Y/dqYNk+9xckPfmZnGUi8mToXsH4RzOqyumQfhpr8JlXHWXl2ahzEYyFF+vyTgtP9NTaJB67zD9HOOCYK2H5BKRYiRPODrUoLsT7bVd/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529004; c=relaxed/simple;
	bh=1rs2jXSXklM+spTKBG/1IxvOayaqTQ95zuiw48lfUKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRD36lcChwI7pxcqQMbnw9DTlu4yk8cL9lHHZ5GlGuZtBd78TAvdn7KzFhbfMsqSQrxpIS0mdvtAIQEw5I+9azkY5aFom/SCtCyIElEfhv5mKXMvtobKN8bxHleeBA6NZ+S3ynstKf6aZk5MXWdHzKIgrBN5CKJh83BrmFwa7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UArbWzPT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72061bfec2dso6671802b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731529000; x=1732133800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=aZw4KOjjuhRwfOVANcWWEKD83Ql22o6lr+/eqMH3dIQ=;
        b=UArbWzPTC2DAnmWRH0LIPjFLf1bWTnBwI9xXzxJ/405UVcd5U6luU6mcwoO/3dwzib
         x6DCDpGwEe8/CwNoEnLt66kgOu/qzzXrdjQks1lHLm/Bfk/3cqs0/XaPnsUCBIqXzx/k
         oXp4RK4dDK8dJqsRNsK9wXDpmE0MUEmkus4gmYDxo0+xOLHHAEs+JlaRnrrE5Lab/+Sz
         5jLCzhXTQvTbb010Vv4Dv2RKkccjaidWpj64oyqdwenABZpqtjrdEQooQjL0FwppApZO
         b3meD5aTgBSnVwaG85ktooY4nv59OSJL4IKVWH7XkKXeEyAGYhHAst3HpOpAIZ0LBeqp
         NfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731529000; x=1732133800;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZw4KOjjuhRwfOVANcWWEKD83Ql22o6lr+/eqMH3dIQ=;
        b=aQ+oAQFXl//2+Wda8rqtUlBG+yxpt9nUduiCT1ceik4kC5lUsoIKY/dDvsHmzD/pJQ
         NEtzTcqqmUGiAU++jnFkETYUpWbonQsReucHm/hKsRUuL1m3Tn3PIps+SEKZjPkPFmG3
         az4RK5pfShl+sekbVWUbmmURgaY9w3+0UNr/uSgNsQ3USCT57KY6ke5T8Xr3dHsgCs3Y
         1biCth+HvpzvedLDlekv5+pjEx8gtW+WWF2ingyS/bkevpesU968xePeyr0CWlPQMndv
         rt1qOY454wSpBe3dYBx1uC620hugPq9MWNjrucvOQzu/hjguyM37fSfYj7CaiQd8Unfz
         LUCA==
X-Gm-Message-State: AOJu0Ywm9UPk87sMY3aIjQtrkcObcgyKDYs4C/IXqf6e81Q11z3eeU/J
	cnHy/tVTWSGL5AdQWVnZieWx8BvDqFFebo4Y/lU33x2F0UT6hmeAn1P0BA==
X-Google-Smtp-Source: AGHT+IFxVOGC1sptUWbWChWoET/43gRbHzw12oy6JOzufPs92oaAp70WrgjuzznMFTX/GTe0FEWAMw==
X-Received: by 2002:a17:90b:17cb:b0:2e3:191e:7ef7 with SMTP id 98e67ed59e1d1-2e9b170a89fmr27217531a91.12.1731528999812;
        Wed, 13 Nov 2024 12:16:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3dc9a17sm1892620a91.0.2024.11.13.12.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 12:16:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
Date: Wed, 13 Nov 2024 12:16:37 -0800
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
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/24 06:41, Mark Brown wrote:
> On Wed, Nov 13, 2024 at 06:15:38AM -0800, Guenter Roeck wrote:
>> On 11/13/24 06:01, Mark Brown wrote:
> 
>>> Don't these drivers end up with the same miserable problems with
>>> dependencies on variations of things being configured built in and
>>> modules anyway that mean we build separate SPI and I2C bus wrappers for
>>> the same case with devices that do both I2C and SPI?
> 
>> Not really. There is no equivalent to module_i3c_i2c_driver() to handle both
>> I2C and SPI variants of a chip. Also, SPI and I2C/I3C are not interdependent,
> 
> Sure, but lots of drivers were open coding an equivalent of that
> (possibly some still do).
> 
>> while I3C automatically selects I2C. That means it does make sense to handle
>> I2C and I3C in the same driver, but not I2C and SPI.
> 
> In terms of the devices they're very much the same and interdependent -
> it's generally one IP block and one set of pins that's doing both I2C
> and SPI, with nothing software visible different.  If I3C selects I2C
> then that does eliminate some of the problem space, I can't remember the
> speciifcs of how people (I think mainly randconfig people?) were
> breaking things.  You at least have I2C=y I3C=m which means that
> dependencies have to force the users modular.
> 
>> Sure, separate wrappers can be used, but that makes module_i3c_i2c_driver()
>> pointless.
> 
> That's kind of my question.  If we are going to have this sort of stuff
> we should also have it for I2C and SPI since it's such a common pattern.

I'll take that as "we are not going to provide a dummy regmap i3c registration
function". Thanks, that is all I needed to know.

Guenter


