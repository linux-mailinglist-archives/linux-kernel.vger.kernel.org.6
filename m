Return-Path: <linux-kernel+bounces-248552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B94492DED3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B201F219EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED1015E8C;
	Thu, 11 Jul 2024 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igh+Qulw"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C83171C1;
	Thu, 11 Jul 2024 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720668827; cv=none; b=ScC+EDtNFrLHXGP5Cx7M9u8jGIWPpF5QC0XHsPORD6cdNbxMDtMKOd09O+lmyvktPZ5ntbksN8eO2/UCBwez63FvWi03ZsIKWmCPmQmlKHyVAoHVtFf+meM61UDP+tbfl0r2YGuvRJepU2UPH3Uki/A0iqdpY6IF6Ww1j0AoSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720668827; c=relaxed/simple;
	bh=4hlYR62Hg+U/Y1kFs0Ifw4O8vrwVZnqQNa0SmlCLrlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwp+7Hb1O6fG4ZB6vhVryxlmET34LbRPrbYPeGnYNj+qG15ZYfgi1bHXQvJE40tIr+q5Og8I7sKD+4XLP1fkcj5qXHiYYTmdY4GGeRjSbhLhX/Mjh6mYdqc/QYRMdm2vWZXwUb437ivGcFlhkzjWqLOuy0U1Cs16TPuFC61iSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Igh+Qulw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c9a1ea8cc3so345456a91.0;
        Wed, 10 Jul 2024 20:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720668825; x=1721273625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt3QLy2Sw58+UdLWM0CN81s3FpNswdEnQpHKCTNZxGQ=;
        b=Igh+QulwbOMO39saUbD86koE8kh3ZEpy4TnU5RnXo6+wZZXbQCiQ8zanchz/W4P6GP
         0H3qzZPOLoOJ2kPZMRqXNWF2xQjucfUQaukKGYXkKhbg4U4zM/NFH5dqDDkpafK5B3eX
         OUts4ceyT0t3xtgD5IoUre7SBlsmm8GYxXMcRpWV++56/uq1Yq4YxwM7FQdPXwDKx1na
         KHTTitZmWXPlynbLKbnEoFcZi+VaMD9fzrNq8MPqcw+8DKpEO6uK+P3TWcjI9y529utk
         XoQsj8nyN5O+yinJfsnhvDEK8XmxXIGI9ZjFHNwv6MkzXDrc07AzpRcSnKlcMltTMSfT
         ePgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720668825; x=1721273625;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt3QLy2Sw58+UdLWM0CN81s3FpNswdEnQpHKCTNZxGQ=;
        b=MR7ILMZ+OLnrInbwX5oHC1CuQzPJ4vbJfJ0kqBhSZRXDXaMsrBYWkOx7qynpTHIZUj
         YETAhSu2xsErZHU7KHR4V2Rqc2d12n7/upS5YpUtC3N3vctIVumXjdSpqQKqkRDYwjSS
         if+X6StFDamtRHOuW2/jKSn6Ng+H8p8IXPhhda82QFS51+93rQAyMYy/Y8/fpIrkjXHK
         mqfFNDWXeEsTj1clvu0xB+zHgqKtnaEhBpZP/4Jkw6GSFigIwBdrcP0XiHjLPYQvjEMc
         rRwsM+YZmTVyK77qMHxMlsaWEHzbIuekIunBvK5a+dYEB4euI1LnXUI03AIM8SEcjnud
         4kTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2kqkvcxV9LnQ+MnE1VJHn4ZGTJhClXTWneY+JL204Q7O0HbtbyOGfXugCCqxrd4m9HVyje+5ytQiq/YIixJurTiUZompUh9FrvENrHOU3t+2+BLzmr6z2+ugvQQuaNr0Ss37b4TCm5as=
X-Gm-Message-State: AOJu0Yyvi/ondpkvC9XyEKdSibbaAcnTccHvbezZdxWAtXvqW+su96KK
	q26yHm/NUrmeMZQbmsHVnHr72H+vlGW6wb0l4CjRnw+lcP0AlhXS
X-Google-Smtp-Source: AGHT+IFQOFIlozp52Pu30R4uQDnndw0Jf0+KidnafwhJyD+e2M9KkS/A/OAlv8KbGmqJAe+9sVwM6A==
X-Received: by 2002:a17:90a:d70a:b0:2c9:6a0e:6e66 with SMTP id 98e67ed59e1d1-2ca9d74756cmr2106536a91.5.1720668824961;
        Wed, 10 Jul 2024 20:33:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9977cfsm12598020a91.34.2024.07.10.20.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 20:33:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ddb24ce3-a8a7-4535-9d8f-9368440d502e@roeck-us.net>
Date: Wed, 10 Jul 2024 20:33:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] regmap: Implement regmap_multi_reg_read()
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240710015622.1960522-1-linux@roeck-us.net>
 <Zo8yECqjvhw6dNGy@finisterre.sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zo8yECqjvhw6dNGy@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 18:14, Mark Brown wrote:
> On Tue, Jul 09, 2024 at 06:56:19PM -0700, Guenter Roeck wrote:
>> regmap_multi_reg_read() is similar to regmap_bilk_read() but reads from
>> an array of non-sequential registers. It is helpful if multiple non-
>> sequential registers need to be read in a single operation which would
>> otherwise have to be mutex protected.
> 
> It would be nice to have KUnit coverage for the new function too.
> 

Agreed, makes sense. I'll have a look and see what I can come up with.
I assume you'd also like to have a unit test for regmap_multi_reg_write() ?

Thanks,
Guenter


