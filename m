Return-Path: <linux-kernel+bounces-421694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DB9D8E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1551416AF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643C1CD21E;
	Mon, 25 Nov 2024 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbAwBt6A"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E2156F3A;
	Mon, 25 Nov 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574346; cv=none; b=r+OXJx7SlZn6fCA46Nvy1Qn9Xb4Iu+/vJIhV5iQEYNA/5IwrtfMFr8uTl/PvmTG+BNrZjYs/CpaPfev4BUrgyVYK7Aq8pa5uyE6LHSV1jZ7xlidRa04WG6bJMJCSwjM03D19+t/JCASrDJ2bBSYH7YrgyZjuqAtPcPLdhfe6jtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574346; c=relaxed/simple;
	bh=kyRwT1f2wjJ+ILBDVO720Taplj0yDfWp9avnyIJg494=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dh89C2SuEdRgyPeruVbvia+6UWbzpEE0HvYiK41x/o5U/4+stjle/t1bPp7KrUa4Lez6bi0yYEvc3Kk15rmhr6pqO/3e7XVMDNwOdZDEQFUbgLoTrtWLtfnyJr76yhZs+KVE44u8H9nVADeWNzvMNU18Fy9sj65WpIB6T2PtPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbAwBt6A; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a10588f3so9802595e9.1;
        Mon, 25 Nov 2024 14:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732574343; x=1733179143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I17qavJeLnyCkfWrHhRgxNWu5JS+wQ3cKJ8VAZNGgk=;
        b=GbAwBt6AvnW3t35o12FwINA4ZnhVdKyfLTLziQrhvpS05kZn815/6GBEs/3rkqB9qo
         SzfN+PeBkEvlz/P5GbMr94Ui9CqmWk0YqsrQTenh/OykEAgczLJTb4Cz8yxSn+N11lwQ
         1eyb3rI7LcJqSp4jqC/xvpamSdgmgoxiKndMSgQuxBmEI8G49bN7XvI3Gp40vqIEW9mp
         kXYk54H6aqGBNfIVYNPlFqpUzCEXCKZm9bfSgVCZdyNrN6+P1mhHY7NGsuoCXSkXljPq
         7VxqxgPycv656/o0m2/SaaouITLbyLz+KHsZrs9Hzaa+fc6Io/bTMWjzSUSKqdCBn3Xk
         XYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732574343; x=1733179143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I17qavJeLnyCkfWrHhRgxNWu5JS+wQ3cKJ8VAZNGgk=;
        b=BrwFTgV16KgBzlTHQqEW+8vPE1RWsiPy6dHTRUMAbOsZqTcybXbt5a+UTeDCh+LPT0
         halhT8n9r2iZnrDavnf3Z8f4lOWpt+EcR8MNIyGLLmqvtgsYhp2jvmp4MzaP4zMHI72Q
         BKmlyLw2wArx1Tylb0yIizQYzJ7JsXy40nuQh+/SoKYVjfFlaFRe4c0JbitHWPe3jKQJ
         t1M0UXHVZQeqcqcKfIEnes6Skp1Ou1OtziLiNyvN4H63q6e8hvYtaZHDzWgFJ50AQyrF
         0eKaZWIx+j0WxAUYIJoKK7EgiTEMNopwikBqpBHdAKadeGXQeWn6rXSfshGzxAMjRt0N
         osfw==
X-Forwarded-Encrypted: i=1; AJvYcCV0cBPnNYRHivzFJh2dKm0+zAYCiNx5VZ96eKCV96aoq9tQikmZ8ZgGeMCTb5iOaSoXVBkpOFyperxDEPpy@vger.kernel.org, AJvYcCWti3++nurGvC2H/4n+a3kZN51kQ09XvNd3ifH/LX+2KKWn9+Ka5IxBZXqIBeAO8MHONCVReqW5R/4E@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZ+wqtihiAO6aMLonRAmhwJWrmqLGPuB1PeazgY50Wb9wN9ZR
	s8SgSWtrcHl/AG9edTaj8T06/XQDi3jIxIyR8JWRs8UOeOeAaCr0
X-Gm-Gg: ASbGncuIA/XjQTvZ9m4lBJEqzAksiE0IE8jc73+1jBduH4iNIYDFmMAjwPbTN5rNDmH
	a7Ek6TS6l9J2zMCka5wB/5FznaDWHNEIX51rKBEOc/28+1rcOs0qooClGitRNxe9+ZkIC4/lEAc
	+rVCGYHtLcmHRFccQFfM+bwhNJ2cV0RTdbVYM1M3Sdtx0qjfXbT2vsLZLD6RKkC9bZxGo8R7/Lj
	Jz7foLgyOOkaEukANNv7yeUFYUO2w00GEuq0ttg7t2zipvRqx4mnzXnxQYH71yYqnvq46Oqqw4U
	ozynDsCDvxd8W2td
X-Google-Smtp-Source: AGHT+IE+gQZjIBWE5QB3b1gRdcctyYqs/C9wrMylTHlNTQVbR1Ss+PPwx/fH2Mubnu5qS2y9RJNWVw==
X-Received: by 2002:a7b:c04f:0:b0:434:882c:f740 with SMTP id 5b1f17b1804b1-434882cf895mr102664335e9.32.1732574343278;
        Mon, 25 Nov 2024 14:39:03 -0800 (PST)
Received: from [192.168.0.100] (85-193-33-166.rib.o2.cz. [85.193.33.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a15d86a4sm31873105e9.36.2024.11.25.14.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 14:39:02 -0800 (PST)
Message-ID: <1fe3c052-d44c-4e74-9050-4b6683e69ac3@gmail.com>
Date: Mon, 25 Nov 2024 23:39:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ben Gardner <bgardner@wabtec.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
References: <29371514-caf7-4f1f-981e-bb52c40f7bdb@gmx.net>
Content-Language: cs, en-US
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <29371514-caf7-4f1f-981e-bb52c40f7bdb@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Stefan,

> Hi Kryštof,
> 
> [fix messageid]
> 
>> From: Kryštof Černý <cleverline1mc@gmail.com>
>>
>> ds2482 has a VCC pin, accepting 2.9-5.5 V.
>>
>> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
> 
> Sorry, I'm not able to reply from my chargebyte address.
> 
> I'm fine with the content of this patch, but in case you need to send a
> v4 please make this the first patch of the series.

I will do it, could you point me to the documentation, where this is 
specified, so I can avoid similar mistakes in the future?

> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thank you for your reviews,
Kryštof Černý

