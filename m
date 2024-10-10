Return-Path: <linux-kernel+bounces-359121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134299987BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBD7288611
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3D1C9DE6;
	Thu, 10 Oct 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltm7gU8U"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F52AF1D;
	Thu, 10 Oct 2024 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567050; cv=none; b=UouKG/tTXJDVoV1ZT0KZWW8v8GSBcimIzpsfBqbvC86GC+pFF+wb0goRpFp0/xPY9cW/nuesYJ4rJZJr3kORQ3mOgQmZHQhX+p7ZhBcJxKZt+iKdNBG2eS20gQ3l2a6tlEfnqLvJsv0e+WQYdhAeaKvsBK9ixrmZFmBafcW1m24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567050; c=relaxed/simple;
	bh=NKKWad7Govv4BAEPX4u9VEwU2jck9P8QCIU+Aqgxdy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auvWd5oiMXdLeoYsDpC6dWNotI9H8C68+4WXQoY1W4rOqbN9gqZ8r2nliHT0rPD7gS5buPSicuF7h8zUpisJaCDMu140z80en33Jr0t6RJKFKgXI7f7/Cr/ROvn99NoDdUsU9MBxbOHea5RHyo45R87RZV5ENmyC8V3ZsjaNKeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltm7gU8U; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-716a7fabf31so348324a34.3;
        Thu, 10 Oct 2024 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728567048; x=1729171848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SK4LT2nNm84AhZpXABE570v9PceMVgU3Fb2pHfApgw=;
        b=ltm7gU8UDa+MXN0nLRnpeEFC44e1BRlYrwqzWhBBYmY39kboI/kD+XGbyWDvmsV1yM
         1+heZVvXIKy/3ZrmZ9iXMxhqja0W4TVXBSt0n8AlLTfNN9KBRxJ3VY+l/iFaThsyPWxq
         y6xNw55JgH7wUlEU9hQzt4uo2U6vEFhNVzJjgq3T9LskI6Hs2JObH7+f6YIamReveQsK
         5DQ6DoHDtPCarBONcL3lw6bhuyfDUpHbLs2vaty3h7HADeU5qmVWkpkHuedzUsOnkGqy
         DjeqakV0TDPM+Ox3NOMYK51AbbwCY2cQAz9Y1uyBD9YeqOVaruSXzI34pbUWs44yGo2g
         mYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567048; x=1729171848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SK4LT2nNm84AhZpXABE570v9PceMVgU3Fb2pHfApgw=;
        b=oUW3R/yKDvpaEXIWBEhb7GYv9JrVIe3rj7rE08Lf7xfKiDCQkrZoJtmrcnlzkOfOD+
         9kRtE4j17UKAvKqRQ+TBy1WWMe5JiXhivaC2iUdnwjgL8FWPSihUcQlpfrHNDwEgCnKy
         vlx4i6lt4kn5zcb5X4IsYbLq/OziQJkRt5P3YppoZRGDFe3XUTlW8qL/3SdMQWz8Rj+r
         84Xz4BT3x8dPiCVc7+I9o4dgbZjbqiTIYNAWif9/8tS7lD8HCnuyD+X7PtJ4UMQ6WmtP
         rMHhVgbMtx2zGvke922nBuGqhbZXkJTrFr9fl06jEX0SKIKj8sUFU+FOAUPNYzOsz7R/
         BXHA==
X-Forwarded-Encrypted: i=1; AJvYcCUKiFjBDh89vgesqDxcLf+9415+s+KqxmWdiNnw416/58AF4J6i1eBsmv/X5MYfPp4MSyfzk+eGEtVRGmM=@vger.kernel.org, AJvYcCWlwM+rqm9NEAIeAUrDZNQ4eMGbWypmaSRUklWaaZZqwJejNc6f4MNi4JwT2XMmciEb9h4hseV/WRIj1qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCm0wbBb0VBFugj+yFrshUqXjluT8zMAI3jQKLXCUjT7r+InbF
	Ji6654j5VioucmxgJuZpyG8xrf46heNZtNWguzL8/s7IdOU7GCIS
X-Google-Smtp-Source: AGHT+IEkCCEyay3cKAq4bSPwIgeCPS8DRUBLuKqweN2kQt/3ee+FraBEJFL65l9+hg56tgRFbAH9Fg==
X-Received: by 2002:a05:6870:d93:b0:25e:940:e934 with SMTP id 586e51a60fabf-2883454e9damr3677014fac.47.1728567047426;
        Thu, 10 Oct 2024 06:30:47 -0700 (PDT)
Received: from ?IPV6:2603:8080:1400:9f00:1ac8:ba3e:b226:eb6a? ([2603:8080:1400:9f00:1ac8:ba3e:b226:eb6a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-28858360ebfsm274657fac.35.2024.10.10.06.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:30:47 -0700 (PDT)
Message-ID: <3ef8a82f-5e71-4386-90e1-f34222a60bdf@gmail.com>
Date: Thu, 10 Oct 2024 08:30:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v1] Upload dsp firmware for ASUS laptop
 1EB30 & 1EB31 and Update WHENCE for both
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "Xu, Baojun" <baojun.xu@ti.com>,
 "derekjohn.clark@gmail.com" <derekjohn.clark@gmail.com>,
 "13916275206@139.com" <13916275206@139.com>,
 "romangg@manjaro.org" <romangg@manjaro.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "Chen, Robin" <robinchen@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Yi, Ken" <k-yi@ti.com>, "philm@manjaro.org" <philm@manjaro.org>,
 "jlobue10@gmail.com" <jlobue10@gmail.com>, "luke@ljones.dev"
 <luke@ljones.dev>, "antheas.dk@gmail.com" <antheas.dk@gmail.com>
References: <20241009101807.1473-1-shenghao-ding@ti.com>
 <d1941b10-0549-4a0e-a3fe-a8d7c50c175b@gmail.com>
 <7e138a1c8b6d4ace8c759bb2266216da@ti.com>
Content-Language: en-US
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <7e138a1c8b6d4ace8c759bb2266216da@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Although TAS2XXX1EB30.bin and TAS2XXX1EB31.bin are both in ti/tas2781, yet it reported "does not exist".
> I have no idea why the file is there while report "does not exist". After I removed the newly-merged, no such report.

I think you forgot to git add them to the commit?

> 
> Following is the log.
> 
> root@LAPTOP-70RJ5B8Q:/usr/local/src/fw_new# make check
> Check that executables have shebangs.....................................Passed
> Forbid new submodules....................................................Passed
> Check Yaml...............................................................Passed
> Check for broken symlinks............................(no files to check)Skipped
> Detect Destroyed Symlinks................................................Passed
> shellcheck...............................................................Passed
> black....................................................................Passed
> markdownlint.............................................................Failed
> - hook id: markdownlint
> - exit code: 1
> 
> internal/modules/cjs/loader.js:818
>    throw err;
>    ^
> 
> Error: Cannot find module 'node:fs'
> Require stack:
> - /root/.cache/pre-commit/repoxl59c0uz/node_env-system/lib/node_modules/markdownlint-cli/markdownlint.js
>      at Function.Module._resolveFilename (internal/modules/cjs/loader.js:815:15)
>      at Function.Module._load (internal/modules/cjs/loader.js:667:27)
>      at Module.require (internal/modules/cjs/loader.js:887:19)
>      at require (internal/modules/cjs/helpers.js:85:18)
>      at Object.<anonymous> (/root/.cache/pre-commit/repoxl59c0uz/node_env-system/lib/node_modules/markdownlint-cli/markdownlint.js:5:12)
>      at Module._compile (internal/modules/cjs/loader.js:999:30)
>      at Object.Module._extensions..js (internal/modules/cjs/loader.js:1027:10)
>      at Module.load (internal/modules/cjs/loader.js:863:32)
>      at Function.Module._load (internal/modules/cjs/loader.js:708:14)
>      at Function.executeUserEntryPoint [as runMain] (internal/modules/run_main.js:60:12) {
>    code: 'MODULE_NOT_FOUND',
>    requireStack: [
>      '/root/.cache/pre-commit/repoxl59c0uz/node_env-system/lib/node_modules/markdownlint-cli/markdownlint.js'
>    ]
> }
> 

This looks like you're missing some dependencie on you system for 
markdownlint. You need nodejs v18.

If you can't install this you can skip this check when you commit by 
adding "SKIP=markdownlint" to your environment while running 'git commit'.

> Check whence.............................................................Failed
> - hook id: check-whence
> - exit code: 1
> 
> E: ti/tas2781/TAS2XXX1EB30.bin listed in WHENCE does not exist
> E: ti/tas2781/TAS2XXX1EB31.bin listed in WHENCE does not exist
> E: target ti/tas2781/TAS2XXX1EB30.bin of link TAS2XXX1EB30.bin in WHENCE does not exist
> E: target ti/tas2781/TAS2XXX1EB31.bin of link TAS2XXX1EB31.bin in WHENCE does not exist
> 

These files are missing in your commit or they have broken links. 
Double check them.

> make: *** [Makefile:10: check] Error 1
> root@LAPTOP-70RJ5B8Q:/usr/local/src/fw_new# ls ti/tas2781/TAS2XXX1* -al
> -rw-r--r-- 1 root root 35220 Sep 28 21:54 ti/tas2781/TAS2XXX1EB30.bin
> -rw-r--r-- 1 root root 35220 Sep 28 21:55 ti/tas2781/TAS2XXX1EB31.bin
> root@LAPTOP-70RJ5B8Q:/usr/local/src/fw_new#
>>
>> Thanks,


