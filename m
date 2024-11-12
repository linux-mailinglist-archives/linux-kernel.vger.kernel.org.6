Return-Path: <linux-kernel+bounces-406842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D669C64F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA05B283C29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620921B44A;
	Tue, 12 Nov 2024 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SuiW7125"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452F21A4D0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453182; cv=none; b=cNwK1sIgU/9t112LqcayN9V4oaKJj6bPhdZixJ8ZhXIPIRDe7uUKeGb4hZ1HL2PE7ReBR1aUIQ2JV4bgy0RM00BYhhT5eST4kyOJ4I1f8ZXJpJkPX4V+uj8bd06YpLGVibhMOrzA9h86cRvh5/pn8fPnkUbIBK9Di+mInERVrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453182; c=relaxed/simple;
	bh=M+LlzL6aw+EiSnn0bxaD+l/N8DT+IZRxn9GoEcxMNhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+W+0L51s0WYx8wABbRWCVnq4yl04V6DG2KlpW35Fa9qwy/jfmZpLkIn1UhTG2vvzUzvZo45ik1DlyhsCTJNwuKqMzkRIznoGREXsn3kWxHMac1lAXDzF4Gt/vjsTtSxCnst88VuVV5I/vwcWkwB6RAcfWyP5IXbRbLXRhJeK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SuiW7125; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8323b555a6aso335710739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731453180; x=1732057980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+4WyyZqxm62aiyO+CVKXzQhKbvMWffzEQ8gIImHR1c=;
        b=SuiW7125Poh+PH0xDVFFbM9Ips/REG6mlB9EaF3h0JAboEf9N7eHjZfbgS9UtDLIZ/
         NIpXNFBMiS+H3nQBfd+zxHMdQSK181FJ727T21fRXP+oxEuB75qmZK0WyyftOA62uidJ
         9PGzYXiFARxKzzIAgnJqb9jB25PNWkGae4C4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453180; x=1732057980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+4WyyZqxm62aiyO+CVKXzQhKbvMWffzEQ8gIImHR1c=;
        b=hSf3ZdzLVqscLH6JGdjOdIy8Fh6totfH4hUa57frPB1GPJ0ZrPXxgTUgO81R6Ug1Ca
         W68alWxrIKrXc7evBzPnO+j3G6/ca/FaEGaNWAIylHBJv6x8gJSeaa3DRM56RvZwYzlE
         IIz+9nst6xM7ktP6zcxtzlAhn6zOJawLyv/X0GB6D15/4RTrRSTMKwZfMl2V9a3evmAx
         jA67SCgs0b4rIW8CojNFiXi/SysZPoZiur7CqWalgIc1ZaYeKsn78qyr+ue50ZBn3b2r
         ejBP4vIwuWXcwv1YoyH5yzCGWb4fFC4troMvly7fpGYx9UhfVF/8nRbqWIOT2AJ7HTD2
         MNXg==
X-Forwarded-Encrypted: i=1; AJvYcCWOjkI+xNNfMXTo/TJiGFhhuROQIe/Qaplcj8ytX2f+oxQrUOX0g994P6J4IPqUbBjUKLDIEofZHl4HoBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZRsrn7R1denEU8m8T97PerAqsN1gEONG+EzFNJViWbsBvM2b
	o/n1ilm3hDrrFWznFItijkQFIEbAtduQENrbv+IhrBDF6eqg+VP8OaLtG2d8OtU=
X-Google-Smtp-Source: AGHT+IHS5lg0H/ukiayJoHc0vlP5PuhGydxkV5Y4j5BxvOfzlZpSvx6PeEtPlcigb0LVgLizi6lbfQ==
X-Received: by 2002:a05:6602:6b10:b0:832:13ce:1fa3 with SMTP id ca18e2360f4ac-83e4fad06f4mr118666539f.8.1731453179664;
        Tue, 12 Nov 2024 15:12:59 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787f0addsm2438058173.125.2024.11.12.15.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:12:59 -0800 (PST)
Message-ID: <33462ad2-98b7-42ae-99ff-757180e3eb10@linuxfoundation.org>
Date: Tue, 12 Nov 2024 16:12:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/184] 6.11.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 03:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.8 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

