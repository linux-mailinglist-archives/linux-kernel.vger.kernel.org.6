Return-Path: <linux-kernel+bounces-349668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B50398F9D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F2C1C21FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA581CC881;
	Thu,  3 Oct 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WmixGB2i"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86858824BD
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994382; cv=none; b=FVHqfxf03sJalot7cH/44RA+BJfuijS7ScjcxB/rCPMdCduG6JMbhvw7RPFI78iqnvFQxszgmH5SRq9nN7VAx6TkH0Dinq7pMtzkDY8shXOcLNdQJBsDOrNIl6ViGDaYl+1pcHBu6e1Z2z+gJgorZ6NIyr6C+RX0LMRk7XsxWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994382; c=relaxed/simple;
	bh=xPOeaIqzyy399mWp3j1JLABvwZIVnneJOdO8eGepAoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaBtm9IwvqECB3OA3afEmS0hZ7Ua+QtAkgfr4pz/fJ1kPfclcCWDvEH7TszT9OPdlEtUbdM4JHBcIQDHhCxl9a6nhyLoxTvZpuZVcoGigvIJBNXwd07QHkW5BogAUsrbqrzsNmS/++qBnvhUA2OOaWys0ItyvrKDDblU+zWaMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WmixGB2i; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82ce603d8daso53939339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727994379; x=1728599179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT0L0c+7PU2Ej+uTg2dcOIbX/VnJHQAzBR3GEEYX4uI=;
        b=WmixGB2ibT9Gbe4NJ4Mh056u31JV9uX7lNQdncgmJFtUkngMwmjE51GZUbwoiLvDxM
         fzbC+uuS/2ROZqMTuHI3w4hJiqkqATd4eq5r330JF54VURCCYeqeZwCPF0ohWuwuGR3p
         3ZY9i7Ot9wyLjxuKRTmobYH91Vx/MHY/vntsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994379; x=1728599179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tT0L0c+7PU2Ej+uTg2dcOIbX/VnJHQAzBR3GEEYX4uI=;
        b=vD912S75MSgBUVhXNQlgIrIvwBINIFEY4b6rPY/DT8mZgSenjNaU0aX4Fzq00x7rBz
         dc1eujMZF0D2hOMoKZbNr2Xl6xvzROQa/VHPCZCyFHhkQwzjyyZoaFV7YYNoYuOQhf90
         H93qvYRsSuUwJZYtaTdi2HEp4oRSLRsNaB3IeY0oIPw+g8CNA8YH4MQnXlj5b4nXGZ+K
         3ga62A9Xe02odp1c/1vaujVTsYLcGkJHDihpExRWkwm6e51n1T5A1wCkbcVgG9ksUsRF
         6I1cPFmfhdYPbKdfbbV+DH4696jgcgHN/HMduZV67HqW+2Kl82N5E6/+U5UhTC94Pnmp
         bBig==
X-Forwarded-Encrypted: i=1; AJvYcCXkcing72o+40k6IaUzLxLRGf7xd0EYgq6P2vMlvmVehFJ8dkrYTdS4LvujKTGYlYVfABBSQa1lx0yZV1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cSydIpDU9F0cLUVpwaR03wvuKeAGFU43dc28WmQfhhEIi/4J
	Y2sBLO/F2K88kuLrHBsFWSmzKPNzQ0CdeisODzKqpjgQD6clGNPPG783oit2j4Y=
X-Google-Smtp-Source: AGHT+IHcCX7rPbxDB40pLseyRGGR7wxZ7SBLlcOt78NrgLauwTEpR5XalH0BunvR9FDE1sw+XYladw==
X-Received: by 2002:a05:6e02:1a21:b0:3a0:933a:2a0a with SMTP id e9e14a558f8ab-3a375999a8bmr5235935ab.7.1727994379669;
        Thu, 03 Oct 2024 15:26:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db559b186bsm467837173.81.2024.10.03.15.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:26:19 -0700 (PDT)
Message-ID: <62b01355-9d9e-4f17-85ab-2c7d57978f57@linuxfoundation.org>
Date: Thu, 3 Oct 2024 16:26:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vdso: Add linux/sched.h to fix CLONE_NEWTIME
 build error
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 SurajSonawane2415 <surajsonawane0215@gmail.com>,
 Yu Liao <liaoyu15@huawei.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002152849.111841-1-surajsonawane0215@gmail.com>
 <543d4b19-e530-45e3-876c-522101f9a5e6@linuxfoundation.org>
 <Zv3Oaf4gMFyIFrV6@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Zv3Oaf4gMFyIFrV6@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 16:51, Jason A. Donenfeld wrote:
> Wasn't this already submitted and commented on?
> 
> https://lore.kernel.org/all/20240919111841.20226-1-liaoyu15@huawei.com/

Thank you Jason. Yes we reviewed this - I asked Yu Liao to send
me v2 since the define is coming in from pthread.h indirectly.

Suraj, Thank for finding and fixing the problem. However Yu Liao sent
in patch for this before you did. We will take that patch.

thanks,
-- Shuah

