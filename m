Return-Path: <linux-kernel+bounces-182410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5727B8C8AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE332818C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CDE13DDC7;
	Fri, 17 May 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYjqRHwg"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDACA13DBBF;
	Fri, 17 May 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966800; cv=none; b=NYR+e2uLf4mSCiz6epz65JMlEyQ4PxvbO2jaem/hPLOJars5cthfwANEURFa1F+qr6Tk8wQ88Odoq5EHEutHfWgwja/jKYVglKpsYVstbks+MD31o4E2IUkFfe5lbCxiGRu8oddVmEbNwZKfbviyW3CRawW4ipRE4zRMlVyoKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966800; c=relaxed/simple;
	bh=7QPuQ1ae4LqF5VK5+rLgE8Kby7AcOaJ1ezGm3DimhtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nt6AWDWEWX+wvYqs3YcPUBfmhe7LZZi77APcKOE+4F0qNCg0QpnnpOyqOMndwRQTzh68+rWQmP5tpYIRvBAoEp5HzRvD1khx2NPp325ZnRrBluS/98Uavb7OljqF2JdUq9RmR2B+JOrr03Aw8RhJUHEEAS9jX9x1BAF7yP5cro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYjqRHwg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso15012845ad.0;
        Fri, 17 May 2024 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715966798; x=1716571598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qFhu6scfik9QCLOAnYYvnpGmGBk6WeZUSPsJrtBRZm0=;
        b=iYjqRHwgM4R7absgpuXmNecCCs48s5gt8cYtnXODElvt0OyL282dc5WwbWB7Umx7oS
         XoNSvnvkRlPKryJSIf5PurWF9acr8RzjFSEHZnFhxwU6X+xznGz6bNm4mpomDKJQhWpB
         kXa+Nv6RKXfAkNzzCvN/u2wTihbyrzV2MAqNCJ5heO5I1AZ8vV9sfnFmILbR7EFBbxoB
         i/QHirBNTlQ6QzZUYYOdSLdnFvqlvogoReYcqkZXbOiEMuGXUDPnKAu8qMJsYyfYEzqR
         3226ZxbP74smbYyvHhjRbcjZnHaD+KagoWHSVupkFXLceDn1Q7hRJO5PAwd/AOZfp1Ln
         bGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966798; x=1716571598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFhu6scfik9QCLOAnYYvnpGmGBk6WeZUSPsJrtBRZm0=;
        b=MruXX/vphxCsqQjHbVfmtqYTDzA0ak2aJydkLurmWnZt5uL9vHqfRqWa4PBQPxmklq
         g3tTToigxYUoNbPsTFFK78NoU/0j2ZLnozEo2ZW89QpP+4jhJhc3LBaepYzB/ALS44dq
         ucPTO+Wumnag1cIHg2u5kbSUI5f7Zz9JI/k8V6XmSxlWp8Igo/jgjtUbADHFuPw2LTRb
         1VHidOnoclqwEXVTCXyDwClYDekyBalJMkEAAsRdlY8qc4IYyM3k4hj8TSV3Wp8a3ntL
         t1pflxvH58GCfHa4tHL4eAFu/Rk+cPSHOTXi3j9jO6YqV+xjs1YqG2XrMlupJcEvmShW
         grHA==
X-Forwarded-Encrypted: i=1; AJvYcCUjtP9xSNWm5x9GFWg2K4gIaPunRPrecmdnetWNJ+chOddoVsFrGiRXDdaaoY6NrLR33dnOx3PjOkHB6+zeAPiVx/1gPxBvZIbyVDKXxeV/kgAssZoxFa0gMUgPFJsEnq1rdJ9tHTljqib3LLyEJwivhQoKQxuFukQvdtyv1sLZUXLvP+Wc
X-Gm-Message-State: AOJu0YwP1Y01WdsUFCpNVCbCXGINK2pm8wqSIGxH0EYh9P4vHqSeiO2L
	OfFMrGStN9RSEfO6XdO8A4PeCm5P6kg0u+Nl+QTr1cyivcG4JvkO
X-Google-Smtp-Source: AGHT+IEcYyTD0cQswtT6wj3K+GD4Sxi2OPQGnNjVSj6eyGo9gqCWQsWYEfbaBZ8glkFlAFsV/6tVBg==
X-Received: by 2002:a17:903:40c9:b0:1eb:d70c:e69f with SMTP id d9443c01a7336-1ef44050d93mr280942305ad.63.1715966797987;
        Fri, 17 May 2024 10:26:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d385esm162876035ad.38.2024.05.17.10.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 10:26:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d7252b1-50b6-485c-83f0-f4a8fb766e22@roeck-us.net>
Date: Fri, 17 May 2024 10:26:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
To: Conor Dooley <conor@kernel.org>,
 Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
 <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
 <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
 <d11093bb-230b-4918-a8cd-4f4eb760ccf3@alliedtelesis.co.nz>
 <94c843e2-4415-4786-bfd4-a77fdbbfab07@roeck-us.net>
 <35361786-ef5f-4d81-83e8-e347f47c83ed@alliedtelesis.co.nz>
 <df40a387-37db-4a4d-b43f-ae22905789b5@roeck-us.net>
 <58fb36f5-4d4b-495b-a7cd-6129ab1ed454@alliedtelesis.co.nz>
 <20240517-pointer-cloning-3889f3d6f744@spud>
 <20240517-pellet-visa-a2d469dc5f34@spud>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240517-pellet-visa-a2d469dc5f34@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 10:02, Conor Dooley wrote:
> On Fri, May 17, 2024 at 06:00:06PM +0100, Conor Dooley wrote:
>>> On that point. How would I explain in the bindings that cell 2 is the
>>> duty cycle, cell 3 is the frequency and cell 4 is the flags?
>>
>> In the pwm-cells property in the pwm provider binding . You might want to
>> order it as <index freq flags duty> as usually that's the ordering done
>> in most (all?) pwm provider bindings that I have seen.
>> The pwm bindings I think are really unhelpful though - they all say "see
>> pwm.yaml for info on the cells in #pwm-cells, but then pwm.yaml has no
>> information. The information is actually in pwm.text, but the binding
>> conversion did s/pwm.text/pwm.yaml/ in pwm controller bindings.
>> I'll send a patch that fixes up pwm.yaml.
> 
> Possibly cell 4 should be standardised as the period for all pwm
> providers and then all you'd have to do for your provider is set
> #pwm-cells:
>    minItems: 4


The chip (and other chips using pwm outputs to control fans) have additional
configuration parameters such as the minimum and maximum permitted pwm duty
cycles, or the startup timeout for various pwm outputs. I may be missing
something, but I don't see any such bindings in pwm.txt or pwm.yaml.

That is probably (likely ?) not needed for Chris' application, but it is an
overall concern since presumably similar bindings should be used for other
fan controllers.

In this context, I think we'll need nested bindings, because the controller
also supports temperature and voltage monitoring. Ultimately we'll also need
tach-ch because the controller specifically supports controlling multiple fans
from a single pwm channel and needs to be configured accordingly, at least
for automatic fan control.

Thanks,
Guenter


