Return-Path: <linux-kernel+bounces-215659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7CA909598
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548F81C211D5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0A79F6;
	Sat, 15 Jun 2024 02:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VOEDM66y"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7E6AA7
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417553; cv=none; b=aY4G9gyLwVM/MSs3UAFIZ1vjnEfm2RyK2HUpzZ0m4bNKg8Sx3ZGzabsuXwhIrhdXSi+wIttoM5K+VzSETOF0WEySNnc1dfEEt9cxTHyk5N15QKSXtUO7llntLNLGSSBvJORJlxELzoDuna9HEiKr1MEF7gbaioRJDgNoS6VswY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417553; c=relaxed/simple;
	bh=ZTDzit9m2Jocp58+PuCzOgmogp5H9se3hT/QvozYCaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHkR3FIcN+xfWiZLdkKQs/0JbZfQWanlDsUZA15dqBA8Mj+jLcrlJFsuqHwKMf5Mch8SUJGd7VnJtRQMaTRl7DImUYrBhpX6NTIuuppV68oeP10uXYrvj5GLP2YKoNZicD8zSxnqbO81F3Oa5XHnBNaIxqtZPlo3ookCw3TpZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VOEDM66y; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36daacdbf21so1129925ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417551; x=1719022351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzaIS2e21jTfUCx7lF1LxmffBmnXZpD+ytV59MGze3E=;
        b=VOEDM66yqmkxGD0v6SgeC58crP7KljYlsHcI7jabEZOqe3QB06coy+d9f7x7qCXlrk
         hQy56WBJHVv+fov80vj443dmO1MjMerubaDY+/dqp5nWjdTDQdD8qJlNy0oD48CQfxeG
         3gTnvBl6CJwEaSFj4I0QXKrXxuYoFntO+eHVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417551; x=1719022351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzaIS2e21jTfUCx7lF1LxmffBmnXZpD+ytV59MGze3E=;
        b=oQOHu90N5IKcFrzG7qYfpoMCBaDUU75aiiPzgYVDFVsBtvGZCi158LQOHHoVB+CohL
         lHpavg7r/7ACQ9zS2J7cqV2DnC+K9LMZAnAq/bNjjqba5vBzLVXAOVtzXmETYS+ccUUC
         +hgB1Bajn71I1af8+auStuqH5KqrdTXmZu0QKYZj6sOzFcJdqYqIKCS875ROdE4S5GMI
         86vMDHfahZptOy2NVxV7RgoW7xB8Tul+ScfSM37jG6SGIAGmiJ4It0AkEN48yCKIoKmm
         fwOI5KvPAAAC5ld3iboqoDoMvKo2SkXnbVcjbBMxiPlYyWFDL6Kl106lS4L5n3R2Peir
         xIIg==
X-Forwarded-Encrypted: i=1; AJvYcCWE2NiY8n+bigjDfJY8rShhw03uWDhhG89vzuKGR8f0LvW0qBKJ9VGJHzK8a1v5SH1l5iZMh3DgqeoPkuGjBtn6lUiQPnuW+pBhvIFi
X-Gm-Message-State: AOJu0YyakaN/YUGyhwmENeQLTDaCU+Bht8Aw1jA2PTQ9fInbb2Mq3KlL
	XQenTRbv5gmCFY7rTcZCBDiAdR4pkdIRBTGCiuUEA3hbbBWcveNDd7KdufVpfBs=
X-Google-Smtp-Source: AGHT+IFRrImpDWCJ30WC+mrE6R+ULQBANeb0E3WYgnZ3y3tWMl89V06RdOLiPBqmflX1FqRQGWXUYw==
X-Received: by 2002:a92:b703:0:b0:374:ac6b:19fc with SMTP id e9e14a558f8ab-375e0e0b4a3mr38441165ab.1.1718417550872;
        Fri, 14 Jun 2024 19:12:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d86be155sm8824275ab.39.2024.06.14.19.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:12:30 -0700 (PDT)
Message-ID: <9e3c4cb4-1110-4269-b44b-fc5985ef0d1c@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:12:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/213] 4.19.316-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.316 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.316-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

