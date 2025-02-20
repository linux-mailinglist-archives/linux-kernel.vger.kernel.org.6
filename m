Return-Path: <linux-kernel+bounces-524236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C905A3E0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324DD3AAD11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67D8200BA8;
	Thu, 20 Feb 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hf+pMkWq"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF701FECD0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069207; cv=none; b=H82xDo6/z7GgwiE4/a9mA6lb4uGStsXDCXN5O3ju6hq1Tr088HtPetdk0hTPdL9fIGDJGpE4nkFCOm0ecoPzdmXKwsVUs326rGHPy11jbPdvSl1GQqIWksXm3UTVCZzJ3FZFs9pWe+Xby6h8LljdkVhyoeiR58x899hasuAbRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069207; c=relaxed/simple;
	bh=7fiCUVGvnZKBNcDUsUvPuCzPc7G+wMawo3kXVYzlUR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFhoNzmztY0tY0i025bJ5z2FJSE6ymulIUW0CQg5ivdjgcsCgIScNqwCBt/nzgHOe6QiS1daHy3DauzUl9WMxB0vRmObP3WxO57buoJWp4uDVOgpHnpKo10TsYCpbj/BfI99PtoDsEgkGky+SZs9JXv6ENsbUDSnXTBFXlOSrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hf+pMkWq; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8559d67a0ebso78348039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740069204; x=1740674004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKb1BncJOwIWJqWtv7Zjj0T3YozvuQ8tSWJ9NbLs/tk=;
        b=hf+pMkWqvsEspd7OTfPAB9MI7vPn1zeEBWkQyCTbiiQiHvVK9ZyiZmZUs21V9SPNTp
         lsmKWctZPLR6v432ip5yswfjuVe6ZqAMQlwA+YaMPiZESw8cf3bSbvD0aDH3ancDRj/U
         YtcahBnoAeB3etchG6Idc0MykQfCzz42NS13s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069204; x=1740674004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKb1BncJOwIWJqWtv7Zjj0T3YozvuQ8tSWJ9NbLs/tk=;
        b=dCez5jlC4MMC8iLJV6wnUHprD0H677khqblnsglEyZrayq0tmz80edgaBzzKsXmrTC
         3BtBCITGfGiLaydz1t81aCLDf5/cOT+7BAcvB4tjMibx4SpE8J8nbkiJ0Ie4gWFnDzQw
         nq6HfcwCprW0klpKRN6fYTxowHNItZMqLgBYoYKwqPQbfh58YKqetbpP1rEJerqs8jDO
         KDOE/gD/6P4Ibs2xkNaG2UbZYb5mBlCyNUDoJhFd+ws4IvbJRlBId/Jw4WluMwYKKwKa
         6zIs2kdzLrCeaOjtW/xeSPV7LwExKYYmi69rDuH+/CEDTnPtzTw5617mPLFtSRwNeGux
         l8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUQSu5XCr2NAwyuq5MobQNB0NU6Tx499vGLHs3SykNqhJiOG38r6CrtKAGql7DVpSeSCfGHbBhGxnLfJxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWIffoD3v+tmjr6ai3H+arWCme5UKSSfHzfYiDC4z9gUCZjBTb
	BiyMfRSuN3TfuuyvT+ul0Yci48CEbeaXgF4poVs27haqvhNkzT1qfcvwuJhfz9k=
X-Gm-Gg: ASbGncuws2LOPMXvQttzv/X7G1i/P6sQq+V5aPPUcdh4uz+8L1/6gUnyGj2qleQIAV/
	NFaHYRj8YuVemZYy1plH2oW6gXYPbY6y6O3uVK/Lxr6jgd0L7VeCT5sISScG2DAhdokC1LWSRcB
	OH2V7q3PJyE6B6gUt4NYa6APjFzekNa8tom0A144SMpNx/YvvbHLHBCXLXhVzRDuf/mUybe+ueJ
	PV6W+xokZpl7t3x+7n6saIloebt0VYjkzoZv21hlvv1hcb2GS0gnDsV6+PkBA7weIc0JFYne6xf
	f2Yuj2xrQp6pHXhaOx6cXz7vuw==
X-Google-Smtp-Source: AGHT+IF6yVD4wsPjyz8e2h/6OJoszjWF5yxh5mB4Bsk1h0QMP9lLCfi4Ha2lyGFIlqFEjO+w/xSR3g==
X-Received: by 2002:a05:6e02:1689:b0:3d0:21f0:98f3 with SMTP id e9e14a558f8ab-3d2809a9d26mr253833345ab.21.1740069204058;
        Thu, 20 Feb 2025 08:33:24 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee8b1db680sm2541642173.58.2025.02.20.08.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:33:23 -0800 (PST)
Message-ID: <24f77be1-5b91-4b4b-93eb-4be5d8bd32c1@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:33:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: monitor: Exit with error status if execvp()
 fail
To: Yiwei Lin <s921975628@gmail.com>, trenn@suse.com, shuah@kernel.org
Cc: jwyatt@redhat.com, jkacur@redhat.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250220130529.4515-1-s921975628@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250220130529.4515-1-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 06:05, Yiwei Lin wrote:
> In the case that we give a invalid command to idle_monitor for
> monitoring, the execvp() will fail and thus go to the next line.
> As a result, we'll see two differnt monitoring output. For
> example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
> is not executable.
> 
> ---
> V2:
> - fix according to review from Shuah
> ---
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index f746099b5dac..7f8958f68eaa 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -6,6 +6,7 @@
>    */
>   
>   
> +#include <errno.h>
>   #include <stdio.h>
>   #include <unistd.h>
>   #include <stdlib.h>
> @@ -294,7 +295,10 @@ int fork_it(char **argv)
>   
>   	if (!child_pid) {
>   		/* child */
> -		execvp(argv[0], argv);
> +		if (execvp(argv[0], argv) == -1) {
> +			printf("Fail to execute %s\n", argv[0]);

Invalid monitor command will be a better message than
saying "failed to execute"

thanks,
-- Shuahg

