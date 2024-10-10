Return-Path: <linux-kernel+bounces-359140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423C69987F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3B82876C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9D71CB513;
	Thu, 10 Oct 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGyc/K9P"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9DE1CB508;
	Thu, 10 Oct 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567570; cv=none; b=dIppc0oJzb5BxOf9bAeaV62eMsULXTyHyviaDbrMEmrehA+wB8BsPndQNCLhjnY31z0kFJ1NCSn2e/OfDjWGYmM04peb+qRTACG6zkbFynl34YTupbx2kvyGcD0JVkID3owwaDOvfmVGnEOdxm4Cgz6+xDnbRHp1Z3HLtpMZce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567570; c=relaxed/simple;
	bh=VGVAmav2Q9zZmXF+lsm8ha3CzAco0EQTqWKNiSqMfBQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C4/I2Q8wA8l+qxVVspjt6dHP5UK6dgq8/kO8V/cfA9c2U1/PYz3lSInJza958tn8k60GqShX3vpB/+EH2IdSWesZ7ypE7wCQQAxWghRggvTXF+RLd+N/GxVvZZ5DMMbWL8PqbItr42bcX+ChiJdeWkQ/vjhCNUOyeXw7OMBbeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGyc/K9P; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-715716974baso571008a34.1;
        Thu, 10 Oct 2024 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728567567; x=1729172367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F/5oD19F2CvSUf5KMDAPz1qSOxfdRn1SXsIt77wo3N0=;
        b=fGyc/K9PFMKTM68cn/nczzhp5xiQ5D9ESXfy0nl9yIO6JWGPWBqBMUHUViqcWd1JvW
         twiZ4T3TpzMMtSNR5+SfYx7E5Six29mC3Haj/n6S/MXHvriVxBj7rus3KeJFA7PUy3Vh
         c8142WSIm5AgB/rUoApSXaHENphw6+hXLoG0O1aohxWv9BJsJXc4dVkAZUybur4z+MDs
         YAzmgxix+LKOuvWZZLhD/CvIJ0u9gXEqTWHcr83jWDey5DT5k0KwRsGZvY50fF6y16X8
         6wKvOffjEo9ue9WBNIiOoYUeR9kXrBps334Dlfr3TUJ3duN1YngfOzE4edXv568CVS93
         K+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567567; x=1729172367;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/5oD19F2CvSUf5KMDAPz1qSOxfdRn1SXsIt77wo3N0=;
        b=gliDFDJH0tUg5BB7BaJJEhm1ZdOoxC9FOwsLOiUHQGNGieshBgDUNVxCkU4Cf474On
         p+wayXg1FqAQxPGpMzFUbPwQ1QGf5uqPWu3Az+Grqf3ajm5t1+u5aQBGg56GwIQlIrcC
         lu4dG+kaVKeSrwKmel+2AnQIdIo7Zrpm/5mb9cQ7EWGIJfhbLQ3u64BYWIKiUGkYQ7ZG
         mPEkc1wVDx/rd4bthc1qHBbT9ipOLxBgPP4FxkRgwR+cth9wDWKPAfhMBue96X7HfLoK
         anNIgrN6lztQJymeLSBmdgDgS8EzkAD9zsgmNJVoAI61aNROSlZeLddbTkbWu/+LrmfC
         MaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNMstjnaIa7xlsKYAAw6BXEGU3W8OUdiiw38CJ+3vUFoGTRYWo6upH9LyrqSligUb8uyIrjQLJ6q+lYOU=@vger.kernel.org, AJvYcCVvRawTTPcGymTIDsrqrs7P2VisFwFdK7wDFCKYGU3zMWfG4drDhofU1TPJdgaYt28jNZ2acbe79VqxXm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkF9w1OkDdT15BsRC1ZVjOMLUTE701U91be/SZLAnMb+EMNCBN
	sohgowH7UIB2+u3MFg0xb3q5ili4ph7wZgP9TWFChZXalhbiBrJXzaRRMWtJWnA=
X-Google-Smtp-Source: AGHT+IGD8q+GYamlrGgrfMA8nr9LmsSuLmSVt4AQiyupapE+xnBHx/01M0Gq3hS661Az0OLKlde/tw==
X-Received: by 2002:a05:6830:668e:b0:710:f879:a15a with SMTP id 46e09a7af769-716a4318443mr5550008a34.27.1728567567498;
        Thu, 10 Oct 2024 06:39:27 -0700 (PDT)
Received: from ?IPV6:2603:8080:1400:9f00:1ac8:ba3e:b226:eb6a? ([2603:8080:1400:9f00:1ac8:ba3e:b226:eb6a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717cfed76besm184600a34.11.2024.10.10.06.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:39:26 -0700 (PDT)
Message-ID: <50daaa7a-d590-4ae5-b33f-8f51d0c2f457@gmail.com>
Date: Thu, 10 Oct 2024 08:39:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v1] Upload dsp firmware for ASUS laptop
 1EB30 & 1EB31 and Update WHENCE for both
From: Mario Limonciello <superm1@gmail.com>
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
 <3ef8a82f-5e71-4386-90e1-f34222a60bdf@gmail.com>
Content-Language: en-US
In-Reply-To: <3ef8a82f-5e71-4386-90e1-f34222a60bdf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/24 08:30, Mario Limonciello wrote:
>> Although TAS2XXX1EB30.bin and TAS2XXX1EB31.bin are both in ti/tas2781, 
>> yet it reported "does not exist".
>> I have no idea why the file is there while report "does not exist". 
>> After I removed the newly-merged, no such report.
> 
> I think you forgot to git add them to the commit?
> 
>>
>> Following is the log.
>>
>> root@LAPTOP-70RJ5B8Q:/usr/local/src/fw_new# make check
>> Check that executables have 
>> shebangs.....................................Passed
>> Forbid new 
>> submodules....................................................Passed
>> Check 
>> Yaml...............................................................Passed
>> Check for broken symlinks............................(no files to 
>> check)Skipped
>> Detect Destroyed 
>> Symlinks................................................Passed
>> shellcheck...............................................................Passed
>> black....................................................................Passed
>> markdownlint.............................................................Failed
>> - hook id: markdownlint
>> - exit code: 1
>>
>> internal/modules/cjs/loader.js:818
>>    throw err;
>>    ^
>>
>> Error: Cannot find module 'node:fs'
>> Require stack:
>> - /root/.cache/pre-commit/repoxl59c0uz/node_env-system/lib/ 
>> node_modules/markdownlint-cli/markdownlint.js
>>      at Function.Module._resolveFilename (internal/modules/cjs/ 
>> loader.js:815:15)
>>      at Function.Module._load (internal/modules/cjs/loader.js:667:27)
>>      at Module.require (internal/modules/cjs/loader.js:887:19)
>>      at require (internal/modules/cjs/helpers.js:85:18)
>>      at Object.<anonymous> (/root/.cache/pre-commit/repoxl59c0uz/ 
>> node_env-system/lib/node_modules/markdownlint-cli/markdownlint.js:5:12)
>>      at Module._compile (internal/modules/cjs/loader.js:999:30)
>>      at Object.Module._extensions..js (internal/modules/cjs/ 
>> loader.js:1027:10)
>>      at Module.load (internal/modules/cjs/loader.js:863:32)
>>      at Function.Module._load (internal/modules/cjs/loader.js:708:14)
>>      at Function.executeUserEntryPoint [as runMain] (internal/modules/ 
>> run_main.js:60:12) {
>>    code: 'MODULE_NOT_FOUND',
>>    requireStack: [
>>      '/root/.cache/pre-commit/repoxl59c0uz/node_env-system/lib/ 
>> node_modules/markdownlint-cli/markdownlint.js'
>>    ]
>> }
>>
> 
> This looks like you're missing some dependencie on you system for 
> markdownlint. You need nodejs v18.
> 
> If you can't install this you can skip this check when you commit by 
> adding "SKIP=markdownlint" to your environment while running 'git commit'.
> 
>> Check 
>> whence.............................................................Failed
>> - hook id: check-whence
>> - exit code: 1
>>
>> E: ti/tas2781/TAS2XXX1EB30.bin listed in WHENCE does not exist
>> E: ti/tas2781/TAS2XXX1EB31.bin listed in WHENCE does not exist
>> E: target ti/tas2781/TAS2XXX1EB30.bin of link TAS2XXX1EB30.bin in 
>> WHENCE does not exist
>> E: target ti/tas2781/TAS2XXX1EB31.bin of link TAS2XXX1EB31.bin in 
>> WHENCE does not exist
>>
> 
> These files are missing in your commit or they have broken links. Double 
> check them.
> 
>> make: *** [Makefile:10: check] Error 1
>> root@LAPTOP-70RJ5B8Q:/usr/local/src/fw_new# ls ti/tas2781/TAS2XXX1* -al
>> -rw-r--r-- 1 root root 35220 Sep 28 21:54 ti/tas2781/TAS2XXX1EB30.bin
>> -rw-r--r-- 1 root root 35220 Sep 28 21:55 ti/tas2781/TAS2XXX1EB31.bin
>> root@LAPTOP-70RJ5B8Q:/usr/local/src/fw_new#
>>>
>>> Thanks,
> 

You know - as you've been having problems with git and at least I've got 
the intent and your S-o-b for the firmware I've taken your MR and 
rebased/squashed it for you here:

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/317

I'll merge this and if you have any follow ups you can do them on top as 
future MR (preferred!) or patches to M/L.

Thanks!


