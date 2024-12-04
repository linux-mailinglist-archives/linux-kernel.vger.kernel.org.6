Return-Path: <linux-kernel+bounces-432257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 613009E4872
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1680128291C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B41FA251;
	Wed,  4 Dec 2024 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DwDr+qJu"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E104B1917D7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353777; cv=none; b=t/tze09sceaG+T689DVZyf2639Sq+Y2G91Orylsqo4W683qhHRBCtIwKM3PxESWAxrY8ZNjcir8ZY44FUCeon93uYQG7LpXtJAnFy5hO/k4bnZk4B7q5DD/yBOWGPj9T6O2Zs9I/NncW6O/wTLqTLMIPHD1mx9VBm8/2WNJnv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353777; c=relaxed/simple;
	bh=mX5Dpi9lci8fk0roEtn2l+quUiwC4km4vuseSGgZMzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8FQVyMaRL3Sftf4yIcfQbPIy/eMqovvAWkKSihWl523XE9vF4DHzN9a92j0bWheGz/ykilVWUvviV4McKjr6upe4NlYCSIkArZO12A9MyAGbvcPTOiCeDBhuY6Fx1Q8nnqt9So/4hFib4cToDhHz3s78765fMcqjYPv+lfqPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DwDr+qJu; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8418a2f596fso8741439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733353775; x=1733958575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zG9sPFZ3lc53iEuZRNZuzndtXvQfaZ5rgBE1zYogWs0=;
        b=DwDr+qJuYh22yg9i+hDj26JWGjguQsGnjZmEZj1HBXmNqDTvURRl/dny4VF2P5NRrm
         zW7Y3V895NtUlpQ36+jr4CSeV82g2EtgNdMH8YLRySthKkfpGdsqpyH7MNrQJoEJSOR/
         q4i528dmX5qBdR7ykMFq7O5kkNkelc7qFdh84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353775; x=1733958575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zG9sPFZ3lc53iEuZRNZuzndtXvQfaZ5rgBE1zYogWs0=;
        b=N4SeZJd6qbLbGMYRw3KLd/+dUIckPs8izVhTClxeCSzbxffepZZTAP2v/KYn/1Tws/
         saILWcFgb2kXqWYTDNbzQyPv9IL06WFsNxvTZjSx3MLHsPXLhIKfquOFc49ANqZDmqUZ
         GijZoVaoyijwX1z7ieitJs8SVCsoPhJ9vQqtNQJh/XiAxmdAJA10OpLUQNEYBDkZ+XF/
         Ru0X6jeXfYLTgcakFRwBHmxvEeU8FgV9m6UgltYyx5lUQjaZ9wom3SripXs1AMmNoxiG
         wMTs/8vhXsm3bQXKY7hViTEc1A9eIhjFkhsSJ1NH2Xihtuo6l3yPwPfgvjFkzyQRMYIg
         rG0w==
X-Forwarded-Encrypted: i=1; AJvYcCU+JzP6EnHo0G6aG/RscPenzxa0QaB66/9gGO0KqA+R2uxlCCC1DI0a8o4GBEO1ErVRnFXo7KYuYl5Lsd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8vmq3KhRhKR05JHid6NdaVgfrCme/ZA+dih6RmLn66/X5KQ3
	lwys68cPvN8RQRY+98j88xYpdmPtDgjhKY8D3bm5x6tpeRH/e/RtlpNnNV0odmk=
X-Gm-Gg: ASbGncvu9wYNj2RoFhcotyyXAcRtvDwtq4uVr0856o4/uXpQQax3uTDO1Qh1C1F6ArO
	5WL661JKa8mvY15AaLF4hseub3iZ/rz1oYnQB2KxnjPPU1n5buq1Ih+C4a6c2HMN2zmpzZPXo5l
	0GbNMX/dxm5Ex44+lnjRbZyFFIcAllOpQr8gpNDw+lH04txxkg8PeMEyZLTv6hh+Q29IuYC/XkT
	FnG1dwgBXdTt13e1tzYCXYfiKnRj2iS4PkXuBokblAhMlXqxCh4nB29oXCWLA==
X-Google-Smtp-Source: AGHT+IGepD83OM2bcq0bSlzzdW/jDr4a/qekrJmRwydDd1klNStH8Eh76Da2OCqAz2I8Fb3YfBXABw==
X-Received: by 2002:a05:6602:29c8:b0:842:ff2d:c3d2 with SMTP id ca18e2360f4ac-8445b5745fbmr998050039f.9.1733353774975;
        Wed, 04 Dec 2024 15:09:34 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844738d70e1sm2354039f.20.2024.12.04.15.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 15:09:34 -0800 (PST)
Message-ID: <ec142501-1459-4fcb-94d6-b26290ce107c@linuxfoundation.org>
Date: Wed, 4 Dec 2024 16:09:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/timens: Add fclose(proc) to prevent memory
 leaks
To: liujing <liujing@cmss.chinamobile.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241128060512.3948-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241128060512.3948-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 23:05, liujing wrote:
> If fopen succeeds, the fscanf function is called to read the data.
> Regardless of whether fscanf is successful, you need to run
> fclose(proc) to prevent memory leaks.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
> index 1833ca97eb24..e47844a73c31 100644
> --- a/tools/testing/selftests/timens/procfs.c
> +++ b/tools/testing/selftests/timens/procfs.c
> @@ -79,9 +79,11 @@ static int read_proc_uptime(struct timespec *uptime)
>   	if (fscanf(proc, "%lu.%02lu", &up_sec, &up_nsec) != 2) {
>   		if (errno) {
>   			pr_perror("fscanf");
> +			fclose(proc);
>   			return -errno;
>   		}
>   		pr_err("failed to parse /proc/uptime");
> +		fclose(proc);
>   		return -1;
>   	}
>   	fclose(proc);

How did you find this problem? This file will be closed when
test exits? What does strace show you?

thanks,
-- Shuah



