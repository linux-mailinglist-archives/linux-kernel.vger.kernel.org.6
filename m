Return-Path: <linux-kernel+bounces-346624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD298C6D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87A61C23358
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A5E199E9A;
	Tue,  1 Oct 2024 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue3DjV2E"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5F29A1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814762; cv=none; b=iMCGlsFLreC3tJ63L1K2vF6SarilBFUGJRiQpedKd9jNkwIVGENthZRtY79VBGm/yRKDfWSOo/bQpwvpWVp2gQdmoy+4bw3fWmNv75Yi67CpcZ2ltxxEhHugEWXFJqGBJ1SBgCaCz1+coKwwQ05LeA7S45dxtsXYfMT6K2q6wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814762; c=relaxed/simple;
	bh=igcill1y2axhOcAHBQy1AdzNbKobXKZZgI2FxEKM2TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D463IkzwCf8q+A1s8kCcuAtpfjQ3rfz8hVxGBtOEqOunfJH1mVq4MKtXpyXnvwyJ6i9W3NUTXk4IMKeVV57rV7HGC6cqCnWdGjpekjtxS0Z8wPnq68NUh6pDJGO7CxENZUka7c3okDAG0ZKNJ0eZ4Y8oTR7Ok3dxn9xEgpTuXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue3DjV2E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ba6b39a78so14493305ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814760; x=1728419560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=C0BmjE+D3eW2kpb7x0QwhBBUqShmS1jkKioejXDVzaE=;
        b=Ue3DjV2EhXWRoK02zIp1TlbxP1rmifF1U6EikJSj/6Rpf/BLpS6tYrJWr909E0IglO
         UTvvV/rS8p/QFr5BM+I31v5OHwNnVMD2N/3wolm7g+EBRtcM4iHzokXBLsoS05749tSz
         CnJduSml2wNvuOMLV03jX/xZXgR6JGAuoqgq8WK/YlVAT0SFjkJ3IwB7TH8a3aLDYZli
         L/WmbO+AM5Q9yIpno6s4N/g3AX6oVDooB/XyXvu0Wtzj5o1pOWAnJEnNQV58DcIRhPyZ
         o5vf7Ed03yDGPob5gSUKjvwyGMFCjo2eqa+8CNIOzfy95zeVoWAOVu3DNhLadBF/rpok
         kS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814760; x=1728419560;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0BmjE+D3eW2kpb7x0QwhBBUqShmS1jkKioejXDVzaE=;
        b=Gtlm5C4iz6Uk4SqBnc4H+oDl1RNhkR9Ee0nwVRG+y/Z9uSADx2z5+vLYKgHo9vmthe
         bz+VgZimEKeR6PU0pMW0J1TH56az4J2FeVogAGPJS/jTTrTbBczkOMZ8L88IDuR1y9ns
         t1BAiU0na5VySvqw1V/7MMMl9zxagOqkrtTs74upYWWZxvElJoo6TFLHX0BYBkSMhMVR
         oWD5FhPzgMO49qDR0fL8QuErMJEJmDU+slKI7q7YXQil4NoNRYhunTBp79cd2C19lh6W
         xJRewjiPLKKGFdjICW3OJ20m4LstOW/waESCXG4kAUOMv++B26gJLcDSPqIelHYtlRpH
         SZoA==
X-Forwarded-Encrypted: i=1; AJvYcCXF1+gyXjlPQYZt/f0YikbIJe227mLQpqVRRIM3DdnOrrk7Nd2ywsRg/nDBHB44rr2XRJNSUTKZcVDqKyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFhmLUL0FNdocSYku6ed803gtHiNfuK4P4LIvf7ci72YEUUPi
	dlCWbQlDZtOYYhjh28RvOREzsK8gLFdGx+9aplwssXCpagEfYKMeRevHpg==
X-Google-Smtp-Source: AGHT+IFmTRO3exPf96okGD8OJIyEuN5OSHaWwglQGY5zW7ZOcH0qMF17cuJpO2r5kq5BMpS4vUczhA==
X-Received: by 2002:a17:902:e812:b0:20b:c287:204d with SMTP id d9443c01a7336-20bc5a59035mr9861435ad.40.1727814759997;
        Tue, 01 Oct 2024 13:32:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d60e39sm72981955ad.35.2024.10.01.13.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 13:32:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4a1103b4-e8c3-484f-a52b-29517cdd39ea@roeck-us.net>
Date: Tue, 1 Oct 2024 13:32:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/hwmon/tmp513.c:163:10: error: 'const struct
 regmap_config' has no member named 'reg_bits'
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202410020246.2cTDDx0X-lkp@intel.com>
 <dc59e32d-ed4a-43c8-a6f3-e4263d97c95f@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <dc59e32d-ed4a-43c8-a6f3-e4263d97c95f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 11:53, Javier Carrasco wrote:
[ ... ]
> 
> The bug is not in that commit, the Kconfig entry for this driver is
> missing a 'select REGMAP_I2C'. I just tested it and then it builds
> without any issues.
> 
> I can send a patch to fix that, but I would like to know what commit it
> really fixes: the one that introduced the driver as it already used
> regmap and did not include the required select? Or the one from this
> report because it triggered, even though it is not the real source of
> the issue?
> 

I have no idea why this is reported now, but the problem was introduced with
the driver, and as you have noticed I already submitted a fix.

Thanks a lot for reviewing it!

Guenter


