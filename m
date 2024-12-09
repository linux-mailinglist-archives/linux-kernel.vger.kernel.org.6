Return-Path: <linux-kernel+bounces-436964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B139E8D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00727164D14
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866CA214A9D;
	Mon,  9 Dec 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpn8o856"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D799189B85
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732380; cv=none; b=AItSuayDuel1OAAN1nai8c6auLcVOINwm/TuKFNkGSwvX6J6va21j7jl4ErdYQ37e2EbIU/i1HJBPhiJr4K6fD7N+VnjCbH71qRl+1cevWfH9rL6vLoFFuimFfBeBlT6CusBewElBiUJkoyhDfzvKb7YrUBTgIRc0ym6dJeCO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732380; c=relaxed/simple;
	bh=Ugyo68y+AEY8u7i/30di80rPWhNRRQDEi6tQUQwpdh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL9XykypxtzBsitDt3NzYHYxp4z7E7zYECFZJneniufcfQR7ah3BQlUwL1CgfZAQ61x7fvxaq4/CDHraxwYfI9R+O/KSAZ7U1Ia8LsGdtdI5yDkEgV9ZmHpvTU1i4DZgTcy76utJ8T/j3Fo3u6vCov5ZS7QaF5J4f7NjXbRNoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpn8o856; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-386329da1d9so1035154f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733732377; x=1734337177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQiaE+JvK4g7UWmvAk+qy7K9dS4ykwXQnbxiADZaYvI=;
        b=dpn8o856fSc3sXmA+VG7hVtQTQPGOBbNzj+rObF+P+QQpPk5SXCxvmyuOuJviEg2uk
         hrtzFVYEva+7L9zyLwFQvwNHH5JSIjy65MWwtTSN5mBQkw6NbYB3/8VEykY6TwhMmLWb
         PK95Ak430d3OuBqLaPj2RAVjwewEqpmz/lZ94914T4IZq7xzyxQvroa0BtXATy/iV/Ln
         PS81jJjIy9Ds8WDPe/MmfArM7FiOKOSNFr9vQ7FZ/ORsBxu0/oZSmS9S04VdCBZSA7+1
         4bvcPVL5rygGPHEoDedGl0tewaKMO/6YGBmBstc7/J5QEikxFq477h1YxxOvxf6THstk
         na3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733732377; x=1734337177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQiaE+JvK4g7UWmvAk+qy7K9dS4ykwXQnbxiADZaYvI=;
        b=ttXjlMJE6gPaQcswSdK2KHqGd/uNaqn08WuctM2I8Kq5xgmxCLHlWmftAcP2ewFORr
         FsuIrntlmNftwYwt93mHmXME37+Yh8N3pqtFhN5RBCeNzLDc9vdH8QQO0syCzouXlVaX
         QtlVf1O5zJ3Ms5gYwsDqaSTkEMzVENSX+M//u99064f7iV7f3U/ngfXvwK6TvE65DUD2
         zFZB6ZZIbJbIiPiD4FxG3Gt0aoUo4J9Qb7qShG2hP1y7sl80cB23wPskmRvYEI8XPWvY
         lh45yzkySQrbjgHMjNDxVwKYVfKRonVG3DucdERbXzUeje18LTENAEg9/EWVQ0AYm1tj
         bpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgnYK/VrWEvZnBfvTbq2nXnj9iGJLX2sEMS35+Ph68KghnJG8KW48f+u/SFDz3BayVgntqO0o5LMocwa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lZdOSRpKYAW/Lfl5SlE0vmcF4NUVZN9HFBXUGQWnchz2+1La
	JdvrnYGZA/zTp//IOli6CynwCRwlD0pVHZ0P0qlQjWonlNXLcoBlodrVjtw+YE4=
X-Gm-Gg: ASbGncttzcdfASL18GQcaJucLMXNJBHuPdaRyYO02EYLjg2rKdEKc8u95dmUmK2GMt+
	QOktwy0A/X13ZvWTzzYY718kS0Ug7AQ+JsKIL6iGNn219GuBX4Gb17k7zdvt0qbCOP+VocV6UvU
	4QEaPjvS3UPwl6RqqWt5ivx/nCHKUvmvbnLyYPlgF+NS+nydLbHyHnq3P87VGJ58DbkpxRSO6wU
	ccgVbyzlgTz9OGBYne7PNujyeY6bQMt8b0Mw32XkZ7hiTD4mjrNPChw+w==
X-Google-Smtp-Source: AGHT+IHbzDErJOZQABXZyJP5tU7I2SyjaZPz5Bn/mEn+KluRKuUJnEKdIGQOObo2GOY0FS81Gw2PTQ==
X-Received: by 2002:a05:6000:1846:b0:385:e8b0:df13 with SMTP id ffacd0b85a97d-3862b3d5c9amr8412126f8f.40.1733732377593;
        Mon, 09 Dec 2024 00:19:37 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434ea1ae415sm76326735e9.33.2024.12.09.00.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 00:19:37 -0800 (PST)
Message-ID: <e36da496-04f3-4f00-aab1-f52aa0c1450f@linaro.org>
Date: Mon, 9 Dec 2024 08:19:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: firmware: add samsung,exynos-acpm-ipc
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, andre.draszik@linaro.org,
 kernel-team@android.com, willmcvicker@google.com, peter.griffin@linaro.org,
 javierm@redhat.com, tzimmermann@suse.de, daniel.lezcano@linaro.org,
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de
References: <20241205175345.201595-1-tudor.ambarus@linaro.org>
 <20241205175345.201595-2-tudor.ambarus@linaro.org>
 <k2pnpu3ef2rgy6wre2qrearwmetzb4v4meiyqpy7oyg45hohlp@kmnzulhbmdk6>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <k2pnpu3ef2rgy6wre2qrearwmetzb4v4meiyqpy7oyg45hohlp@kmnzulhbmdk6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/9/24 8:03 AM, Krzysztof Kozlowski wrote:
>> +  initdata-base:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Base address of the configuration data in the shared memory.
> If you really need this, then it should be rather encoded as part of
> shemm phandle (phandle-array with describing items, just like syscon
> phandles are done).
> 
> But OTOH, I don't see why this is needed at all so far - compatible
> defines it.

Indeed, I shall move it to compatible. If firmware ever changes, and
uses a different offset to the configuration data, then I can introduce
a new compatible.

I agree with all the other comments as well, will address them in v4.

Thanks!
ta

