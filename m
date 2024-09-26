Return-Path: <linux-kernel+bounces-340152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF56986F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D721F27718
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E5C1A4E7A;
	Thu, 26 Sep 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqhwOk1t"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BD1D5ACF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340208; cv=none; b=QdZLmA7LBLY0NfJ8F6RDip6ZdioCiyLS7XQcGwoPlKJf+yJYA0qEX2TuRdYvgvGmtw/tlyz33/etZiXI8i6lf5hjuHOSzpnl21L3uYYSOoX9LJSc58y44XABuUKFUAkHhjm+/gDdXi95meENkM/0X7iGNez1rBeF+wkKTZgav7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340208; c=relaxed/simple;
	bh=byM9o2b/Ff1WcR8aFl7C/znJbBHkZr4CYBJV0jns5Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alDMN4nQdY43eRYXYGM+RNmL8kl/PPuJEWMDwM7B1rW106pK/lGA2sJOYNrGlbOSOsmE0yfDcKwVlTn4l8s1Ejov0W2D2Q+fiWBjk3fG9Op4hXGkoldAkrUh6YtBwWxSz7hyr/431NFXDcUNKJufdaFdFyyAI5GfV+3Dl+BhRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqhwOk1t; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83562f9be9so61877066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727340204; x=1727945004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEdH5hlRdLwsO2yW2HO9zyaS71lP+qJ6pc+TYI3wTRo=;
        b=aqhwOk1tlhWV/7/puvmimWpG+wZxAdh2WEDhoOMmKdWwokKcBQuDIgHCW6OblR2g3k
         U2/HNcuFTEb2GM3hu/ABudZ8Wgh1SdT4i90RIkBox/vAQUGM5NUATuN+RheYsl78bTcp
         KE8YEml7P7kwoHv4ro1vATeQLJRSGwKuNiAmZ+vTJBUUxt7awv9IFuZnTx3owlJV2XqV
         LQGwR1O6Ekguj5VLRmbp66yj22ZZO0ZgqVgO45W+ntkxOevC3YyNj6E7maoepSARSDV8
         YimCjVclZf9WoZSKaxVHgnua7/fks9A1Sn832PBKBa3oIKRVDJOqQ+oMaSXOn8aC1LtN
         FgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340204; x=1727945004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEdH5hlRdLwsO2yW2HO9zyaS71lP+qJ6pc+TYI3wTRo=;
        b=w/GqWFlak1ZR6fgzti/pPQBQmx9LSw/xJLLrAhnyRvdJZcEcIGIAYPLpDiEBjhmqdr
         kec7vkjg91c/Rq+krQNASk212msduc+2K1QmZ31Z/hpnV9QXTKFUzGD3dTNh00EvE1Tm
         SqMoi8h6mL36DXdzSOdvyNVkglTDVKkFZQM8b3v0tZdk/DQ6DCqFkiNkSBrLXpjUaFi/
         f1H2yRKXcmB7UtfVeRcpqKbhH7wK4889NCDeq/diFG3M1eEl7TW6gU7oA9BLrD68/YBB
         TrXJFxqr79hUKXu56KtbbYb5y/AaCRKrDLvJeLvFypN7u7J362w8jh8bJKbkgxb9Jgj5
         8w4w==
X-Forwarded-Encrypted: i=1; AJvYcCXNGxPj6tEXjnKYYHJqMJdUzH5YXuNpKTKUGTiz0wrBLOIO/XRodD3+7HdsZX73FG1XPzHjr7WXEMa+UBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5RQjj7FEn2rr9h+FgjrhjiA+Q0qchLfGwCV7zMYGZBBRgf+R
	lJNZZWTIhRKcf0n2joKbamd+E6y6Cam/xbDt4gf6ytCXKNSLWzHPyL4dEc7+xWo=
X-Google-Smtp-Source: AGHT+IHF2Rx45iVDXBnPn9IcSymlMPMQVVycfKufN9GAR0JgBMbYvTuVa6+2ENEKr5CnI+e7PIFSFg==
X-Received: by 2002:a17:907:6d1b:b0:a86:7b01:7dcc with SMTP id a640c23a62f3a-a93a0383e9fmr471746666b.18.1727340204548;
        Thu, 26 Sep 2024 01:43:24 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f4f8a6sm321213066b.50.2024.09.26.01.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 01:43:24 -0700 (PDT)
Message-ID: <f0289901-7d8a-403c-9ef4-c4927f2ea866@linaro.org>
Date: Thu, 26 Sep 2024 09:43:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: b4 commit in -next breaks b4 on next
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 "Signed-off-by: Stephen Rothwell" <sfr@canb.auug.org.au>,
 lkml <linux-kernel@vger.kernel.org>
References: <e4a03e2b-63e1-4247-a57e-10bcb75cf7ac@linaro.org>
 <20240925-tentacled-porpoise-from-sirius-f442be@lemur>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240925-tentacled-porpoise-from-sirius-f442be@lemur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2024 21:11, Konstantin Ryabitsev wrote:
> On Wed, Sep 25, 2024 at 05:31:14PM GMT, Bryan O'Donoghue wrote:
>> Which means if you run "b4 prep --edit-cover" that is used as the base for
>> your b4 series.
>>
>> You can't revert 3a904d2c771115154380caaae7ffaaf0095fb88f so you basically
>> can't use -next for b4 at the moment.
> 
> This should not be a problem with version 0.14.x. Are you using an older
> version of b4?
> 
> -K

Ah

b4 --version
0.13-dev-26615

cd ~/Development/b4

git pull

b4 --version
0.15-dev-dedf8

Great, fixed thanks.

---
bod

