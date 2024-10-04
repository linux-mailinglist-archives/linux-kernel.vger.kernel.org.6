Return-Path: <linux-kernel+bounces-351270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006B990F32
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465602814FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1353F1E32D6;
	Fri,  4 Oct 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0cKWEJT"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67738231CA1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066969; cv=none; b=bD8vIO3Ncs/+Rf6+nbgvb8zCNubPdJOH/eGQ5zVtguDaG4h2vHzmXvEFGF4UQi0rGZ9Ro9LxLNrMJGyhAzNl0Q3+Mrlgk8ShDHrq9jzZrNRa6KJtL+2SfJ0JNuoGaJzyDJ0lM/IR97LoiHpePzO9AsEuFYvI4O+J8nB1mdEXucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066969; c=relaxed/simple;
	bh=wRYcOfSWyuDOGGYocBKqUzSJGsw8893hD6kFhivynCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSL0dNR0IXjKdMJ0cnF4pgR+/WgUaaLEdfPCCd2LlNgz/rrK9KwS0vSwyYIsVMAqwQHlkalhPO4+q2gg1nJ9H6JW9S2uN/75nRPSi8DzWw0RWFbCrXckLvYFXAQr1I3gxnkOMgspJdwPgoRMmfKwnbPwh8c2y/CPcP2ddj/sDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0cKWEJT; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82aab679b7bso98181939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728066966; x=1728671766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJK9cyEzzySVOVcmp8jpRL+G8kVfEdQGwI2HXhkZggw=;
        b=C0cKWEJTEy3FlsSiXec+dYjqXR6LQeNY5KcY/6XGpJud4xhIO3rATQZssM2J6/gCGu
         zJavu9q99Y53Lq60jcNmP0FC44+D1uUUc7pY+lSaY4QNUbvc4SqnmpIRrP8r2lclkW2D
         LVgnGAjCK6eVUsR5YLQfQZ2xiVrHBVhMxVhrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728066966; x=1728671766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJK9cyEzzySVOVcmp8jpRL+G8kVfEdQGwI2HXhkZggw=;
        b=Qw3LF/1w5FsEH1aFkcqDt8Q7J3BXt/xzitGL1iJZbxCpWNYmawWbZ0zAB03dTHdDH0
         6ImLzYRb1ntVIxf1PaC3eKA9S3WgiiPEqPhZZ3F8ic4domwRSw9VvkkLMD2QutmH5Acp
         tYzPm98U+MeI5GRqBgLSwPPsJ9UOG+AiRnDrZXvJjPTfgl18efCJk1Z8QRIHt1ajdtG9
         VnjkGTTEv97zry28FJ7UbPclfh3ma0oME6NAmQZGZ7Tav2J+ptpY7ESDJMOz37NFr3P3
         gejHlMwsxhsYxgEynwU01H1PGiJ6H9PIwcSB1eR+x6DwbE5gFHhMUyRsoZhWv1SeUt4H
         QLjA==
X-Forwarded-Encrypted: i=1; AJvYcCVKz9zw2uf5SMN0UJPVb4ATnc/ogin2+vwU+7QKmXuJwf5Jly4kva+xz9OSbwlv81rxQ6X/p2MJ0sgLGvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMicdTSqw1PwE2hmYCcnFzbWdo9XfUTWddXaAx1Uu4Qf3wj4l3
	hRYm5eli6N+2jIRD85bvs16YQiS1IlU51wHTPyMQA4ToJV2wE8MgzLTxNHz5o+A=
X-Google-Smtp-Source: AGHT+IF5rAjqamenXKna2fHP0i8fcs0IQGvuOhlj1XurR0XwN7g08cKxSha53bfhRD8FaPnfCzOn1w==
X-Received: by 2002:a05:6602:2c13:b0:82a:3552:6b26 with SMTP id ca18e2360f4ac-834f7d9568cmr391811339f.15.1728066966307;
        Fri, 04 Oct 2024 11:36:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ebf0ab6sm80511173.97.2024.10.04.11.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 11:36:05 -0700 (PDT)
Message-ID: <fe9d3f82-0b2f-4f55-ad9f-fb1b8b38ad48@linuxfoundation.org>
Date: Fri, 4 Oct 2024 12:36:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kunit-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Cc: Danilo Pereira <dpereira@lkcamp.dev>, Pedro Orlando
 <porlando@lkcamp.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004141146.3ce262b1@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241004141146.3ce262b1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 22:11, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kunit-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "utf8nlen" [fs/unicode/tests/utf8_kunit.ko] undefined!
> ERROR: modpost: "utf8ncursor" [fs/unicode/tests/utf8_kunit.ko] undefined!
> ERROR: modpost: "utf8byte" [fs/unicode/tests/utf8_kunit.ko] undefined!
> ERROR: modpost: "utf8version_is_supported" [fs/unicode/tests/utf8_kunit.ko] undefined!
> 
> Caused by commit
> 
>    94d8a0976d2d ("unicode: kunit: refactor selftest to kunit tests")
> 
> I have used the kunit-next tree from next-20241003 for today.
> 

Sorry about that. I ran other tests - but missed allmodconfig build.
I will go drop the two patches for now.

Gabriela,
Please send new patch fixing the problems.

thanks,
-- Shuah




