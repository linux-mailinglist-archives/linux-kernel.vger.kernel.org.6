Return-Path: <linux-kernel+bounces-511291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E1A328F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA13E3A3B28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978051CBEAA;
	Wed, 12 Feb 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kREj+AD5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F420CCDF;
	Wed, 12 Feb 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371574; cv=none; b=Rg0qmHGIvMl5F5r+OX91uwNaIig/3GQDBULamQXofDE+dbRjEJ90zS84Y5iFk8aOmgbssISzqAA8N+9XejKXZYzVwNodJxb2GZNNoG63pbzpvCxuIaX3zVVhnH2+Yf3o2q7UASXwhKXYAf5niOk9A0Z3tl87kZ5Oxwxp6X3iSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371574; c=relaxed/simple;
	bh=4fE4RVNTW6kUw2cY0eONSGak4tMO6oDjGZ3AlW8WXus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNdSQTwgWeXwKE1N0KkrWCh/ec5LUVHLkxFaYd91vIZ/CGH2BvwArKNHeV6wVOau/iasF4DQAMx3YL+IwDh45dH8vGn7CIhe4SmzygyyQwEcx9+YpiJ3h7ZpUa5tOcIQkLu65hd9pRsZYYm7Nyx0wkM2xoQuDVj2YKNW/IG7QYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kREj+AD5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f5660c2fdso102892295ad.2;
        Wed, 12 Feb 2025 06:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739371572; x=1739976372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyZ/DkBd6J8eeSModNEBG3bfwAQ2gZsuI+jKbKeTC2o=;
        b=kREj+AD5l0lpWWKm50pB/9xZ66k7HnXo5UvqX3hgOru2aDEoU/OjVNb6fewR4NTdD/
         oAelZ6rjiA0TiMwHBIJjOtnLMD45Yi5P8DMgab90dscPuU3avpyUEaDQ/mxwgLgYgYTw
         B+vvLeIirl1Yq41UXYDOM+Imvad5eKdKeQ9JU+yQrReqysGDv1IMWEQAx/GKXgul+dzy
         2xVvAdlRakrqgIqBQHvINfwV2+ure24GUPqDoHIl6Ng+FXA5wZyLUE5DXxzZ8nVFT6g7
         wkoQZuiQl6JaPGb29hurnLupQsy3NdfKoJiK6yZey1Qmx3MYlD4dvFt3f46wR7oh3yIk
         9PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739371572; x=1739976372;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyZ/DkBd6J8eeSModNEBG3bfwAQ2gZsuI+jKbKeTC2o=;
        b=sinXxT/ysY/LG7JQSWVVcxFn2sMYSPT2BHeLGDIz9SHriP29iCbAPjgjX8hMhJr4ft
         n8ZbobZ3kp0hogKF8LJDzg8xVzwm2pt6jtcNE0mqxbXtKycMNUu6blewMkvCXvcqCoBN
         hvozwGp4f8Ge2XqK4eBH4gUU3IIQqcqOWMuG15jaWSclNztoezfeeYX/2zAp+oaWZ3yE
         kgz2sw2zhm9248dZSQZG6CLE/2e8MGqb8rrJtiBAinJZYlYqa9YK5V+hsI/nw72Y6dZ9
         DsdTpgME18tiAiGhhHTRSCVpCxTEbf0CixtSZ4MzkGKonk8n3nunTn/Y8cmhvLbANlkC
         0iFw==
X-Forwarded-Encrypted: i=1; AJvYcCUE1T1SiTFgw7hIty6cRUJpacmLEBnZXPuy/cjmBRCj+N3iythumQWtGrrnA+GiU1noh6DeasemjmTNJUuE@vger.kernel.org, AJvYcCUU+KDDC/j0fJwKuZqMiRAq1VeUplv3q7pTTts2+lfmlEIJ7VE0ePL/0eWMrJQVvC4vxWl+5f/grkx8@vger.kernel.org, AJvYcCVOLnLWVyObI4XdD0BTyRbALnzV/AxwtuOnCz84G/W8ndm2sVOj/ImZRPfNZAizXRRdAlG1gKaPY/IRn3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoDSY4OQlIdERMNvmvNPoWtzrpagrVO4ta/P/7vKnU7UggvPK
	driJAkBv1HcFJONDcZfLduSZELqoGt6+IBaj57rfoRMFo9h21Z9Y+uDM5A==
X-Gm-Gg: ASbGncsOwP6aMMNx6m4vgPx3G/9Uqhv9ltKrPqntwgVN/y9tP4W/knNjRDFfSMrX5LM
	Lj+3oDr3dSbDaUhIfqOGWKP/SEi25TyStAksstEAZwhteRcXr1Mt6xe5tIfutPKfcch6yAhSF/O
	CCxvCpUrKXrKJUdGOLoJb9Vh7JxoR6SnO1QuhkOIFdNhAipp/LEduwka2BakSOizc3v2mZDRZpq
	kIMy5wgHywv+tCl4IvDpD36q3FN26yv6JyUcGf2ZAwgwyOh9zE4TSqQsbcFVZOk2ygp/T3U1dMx
	9k8u1visCDJ5w0W7So8l6foPNEL8qKeT0ZmzrwsDfXIaKP5YS2/DY8/BGE3XtTAm
X-Google-Smtp-Source: AGHT+IE2JDbsKhi4hWTQbTbi6p0ZWF0mF7AVC7mMvZn6X3gAUvl3PC0cRURdpQQucRTxHmQI2fV4DA==
X-Received: by 2002:a05:6300:6702:b0:1ee:321b:313b with SMTP id adf61e73a8af0-1ee5c822b3cmr7213957637.41.1739371572286;
        Wed, 12 Feb 2025 06:46:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad5434dc097sm7524942a12.7.2025.02.12.06.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 06:46:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c8dc4bdc-5374-4648-8092-55687be85f12@roeck-us.net>
Date: Wed, 12 Feb 2025 06:46:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ir38060: Move & update dt binding
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Conor Dooley <conor@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: broonie@kernel.org, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250204180306.2755444-1-naresh.solanki@9elements.com>
 <20250204-mulled-evaluate-8a690cdfbd4d@spud>
 <CABqG17jHKfwJEfZxto_YA4opS8=QwqTqfNdkku8kcEv2_iW+XA@mail.gmail.com>
 <20250205-purge-debating-21273d3b0f40@spud>
 <CABqG17j4tKXnMZ5=vcjBvfe6JwCLQ6NbkQmJC9ySK_bmGEv=iQ@mail.gmail.com>
 <20250206-camera-mashed-48cf0cf1715f@spud>
 <4619661d7375c71710a22520f6ebbf353a5aff59.camel@codeconstruct.com.au>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <4619661d7375c71710a22520f6ebbf353a5aff59.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2/12/25 02:43, Andrew Jeffery wrote:
[ ... ]
> The history of the problem from what I can see looks like:
> 
>     1. pmbus regulator support exploiting "regulators" as an OF child
>        node was merged for 3.19[1]

I hope you mean "make full use of and derive benefit from (a resource)"
and not "use (a situation or person) in an unfair or selfish way".
If you think it is not appropriate for PMBus devices to register as
regulators, please let me know, and feel free to suggest a better solution.

Thanks,
Guenter


