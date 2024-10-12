Return-Path: <linux-kernel+bounces-362421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E699B4C6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D1A28245F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041D16F826;
	Sat, 12 Oct 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5Oc+hVG"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D236145A19;
	Sat, 12 Oct 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728735152; cv=none; b=VsPve8QRPO37FhjHKKfasAnOikzG8xJACNoF0YFeMCItTTRmiDzcpWmZZPtd+DWIaKL12h2n7tyD9KVuoUyQwplpUJC2Hyx6yWb1vj/vHJfPJS2mKeINUhOjBLKuUGaS40XeE9NGck0BWRVCxrTz9zLLAU85U3LOASWxol8MKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728735152; c=relaxed/simple;
	bh=hmj6UhdB5lhPLzukksSaSSQvujpIaLecwEaCA+7PzRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDBPpMPsXAz/tIkDXx1/pMwQtS9CyZpUHqTNy87g0CPHnQQTVlgAxgj81vd67l1Kl44OaXnolQyXqe4PLdxu3KQlUZtx0Z2rtWAiQa0RXA4vc/HeJ0rSKRD1vS43guJlkMuIBBnFqOJWaNjRExU+C8dnZLngjIIUug51tRosPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5Oc+hVG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c6f492d2dso30528485ad.0;
        Sat, 12 Oct 2024 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728735150; x=1729339950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jG9lrE9DmMpJN9A+2kqJ/BJcBfUwU0x80O3iC8t6XpQ=;
        b=Q5Oc+hVG4jOFcillmqYpz14IE4n9c7BgaY4utAdC3JsqPT3F2TLugKhKOqClNRLbcU
         Jx0xFIfIB+5JHmBQHpAdUxVWCCC705q1fUpuiJy3QsTdGRDUSpT/8zVZQ0HmBW22UHZ5
         v8UobgSWxsgsFb+FrUdNnFURsHDHiQgf3LyLl3MvQKqs1l1Z/DMvWGnEieq+rJic7mDL
         3J4c80fNFMYCFwYNjqISbiwQ9qUtRgUPauoMaYveT+RB1hjtd36BvHed7c5RvRE0Am2P
         Vh8BsDuLou3MWC2SA3NqjxzxAV1gZlKpbmXhxmMzLXqiBnJc3THP66Ry3Q85RtEy/jjh
         Lgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728735150; x=1729339950;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG9lrE9DmMpJN9A+2kqJ/BJcBfUwU0x80O3iC8t6XpQ=;
        b=BVQbaYXPjpCkbFxbV6q75AHXvQdwoVte+2nY3V4Ik6UE3k8idLVzZ2Img7E+fBU1dN
         kDIXvokzTpPWGS9TY/KobZtlf9YpKGqdXu4b9M0SwE6CAvzLRHWc4K5O5DA1YtSjDJ7c
         DXMb9Q8HPCvFhl++DJgJZGpkQq36clzZ2kMEIVzc2qaIFTDtI3vNvjRp8gMQf0Itgv/T
         cbb6XbkJVIurTSdaAhnt4t0tWj2DOz5KmhsHxLyxvzCpBqPh2SAx2qiLTeFzeMP7Np35
         HzPyFopEGql9Hz11WnKi1KaF3j/qlZ/zY9Tncna+hbz2be3wM1yXFpCy4ruZDo9Mc8Cc
         JLTw==
X-Forwarded-Encrypted: i=1; AJvYcCVTf9X5StUhI8H9CulPIQ/datjyo0BwHhBU6im9szuRt3s7UwCtHQ5v23NfQ0mhTLU48n8KjzUnLLPF@vger.kernel.org, AJvYcCVhXs6YSDFH0BmPc3e5MxKaJ77tbnx4dL3kMqrwLVcuHkPjlkuFQei9jlJS1+fsLoh0zkplSIbLcBSYH2lc@vger.kernel.org, AJvYcCWdpj3LdoB3JNzG3FMq3L6+IR1Av7qfbaEQzrFRWBqfRk0MwhIbneqLJbrtWz/0K0Z7VXXaI/t++9kFwPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37eT7Ov/KwVuEuWKCI6KOmQkPEXigN4kk3iu+QjN9flGZ4/wR
	JX13sc3cZ3m6FIWAppIkoGkR8CZLMvWUjh5VleWuX/1pSupxGNVm0JaaOw==
X-Google-Smtp-Source: AGHT+IEvY+hLEP1JqjgYJrqkXN4vG3PbxKjZlDjPLUw2MQjrJyUay4rMY2Tute7w7RTKAD0mT+Vr5g==
X-Received: by 2002:a17:902:d489:b0:20b:a25e:16c5 with SMTP id d9443c01a7336-20cbb2a0c4emr41026865ad.53.1728735150251;
        Sat, 12 Oct 2024 05:12:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0f5b90sm36048655ad.128.2024.10.12.05.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 05:12:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <80bfd968-8f12-46b1-9b72-837502ccdb2a@roeck-us.net>
Date: Sat, 12 Oct 2024 05:12:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux dev-6.11 2/2] v3: dt-bindings: modified ina2xx to
 match SY24655
To: Krzysztof Kozlowski <krzk@kernel.org>, Wenliang <wenliang202407@163.com>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f7653d58-9cee-4496-91b8-55dda44289bc@roeck-us.net>
 <20241012070627.20788-1-wenliang202407@163.com>
 <20241012070627.20788-2-wenliang202407@163.com>
 <40b01554-44ab-4a67-b9ff-d8b821eb74a8@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <40b01554-44ab-4a67-b9ff-d8b821eb74a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 03:06, Krzysztof Kozlowski wrote:
> On 12/10/2024 09:06, Wenliang wrote:
>> Modified the binding of ina2xx to make it compatible with SY24655.
>>
> 
> Your subject is odd. We do not develop v6.11, that's something already
> old. The cc-list suggest you just want it for next release, so rebase on
> mainline or next and avoid any unusual patch prefixes.
> 

The submitter also still refuses to use imperative mood. I don't know
how often this has to be repeated. I take this as "does not address feedback"
and will not even look at the patches anymore until the reported problems
have been fixed.

Oh, and I just noticed that this version has been sent as response to the
previous version, which is also discouraged. On top of that, there is
no change log.

Guenter


