Return-Path: <linux-kernel+bounces-534924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDFAA46CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA0718873A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF592528F5;
	Wed, 26 Feb 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cv3MOR7P"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF6222586
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603362; cv=none; b=o7Ilzsd7EnD35JxemjN0WGgWGV1W8nCEWUtybWWJveAq23Vas4uV4kJDUzXEUcW9Kt6LwlzRtKzAw8YPGwUe2IJe/h9+CAJj9FIe9RuZ++AZWC1opJByJA00Vwv/llw8cTiMm9RGjgNC6d2a62AZOH2cCcnTOAMHgYCGK+/LbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603362; c=relaxed/simple;
	bh=mqYzICldJl61KdyHfxq8I6OeV9x311OW0csxdK20FtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAyygVdcNmkrwET05nSaLbtAym9AwwWHEVIoOmxmrS67Q0LJ8DpIi3Q4GRQ4V3QebLdLkeYGNlu/ws0F5Sql2GRPzuq11Ts2JPXnzJdjPjWCk8wDCxUIdhgRf1roYQRExats9vYaPRofci1Dmd0E2uewTC2GHKGtZlZywvH5kW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cv3MOR7P; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-855c122b3e7so16415039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740603359; x=1741208159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACXceot6so0qEECSDnrDchyxYrTH5BMNjPgKlk4vqYE=;
        b=Cv3MOR7PfOlBCHo3kE3GZlSf4noqQpj3XAbOflR+DpQjGZAZrsPbajaNp1sPREKfny
         nUZ2l84GiLiptGORPyxWvYXwF5dNwWBzSYPRkWK6QGrhCVvkNYgylNZCLT87d30Fi+Mm
         Uat7XL9Lmj/mu2/22Ekg4F3oV8EcinwsAt7gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740603359; x=1741208159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACXceot6so0qEECSDnrDchyxYrTH5BMNjPgKlk4vqYE=;
        b=dfty8cZeBFRWEiwp+gMlSWLhq3d2uT9az1GQzsuasFIFsYcgEfeheO1wmxN7pIRShB
         gWEUmRCVDnmL0utOSGEkxcuQUoBoE59IG69w76vcx/K00/BG6hftLYHDTpEUm/+Oj9SZ
         0rbjwUEmLH6cOnURHzHsT0VDniQVYZdwWOZPa3tzZ+HrR3wKAcYPVphplkz/7TXIxGuk
         MN32kvpFG/39E3hu5MUfZaov9gHuSEsAWP2Ry7A3x8LbOjPJUKovN+qmet/burXXRsmX
         crjOTaRM1xBhGntgdV4BLdiFASx0lZrAx6Gb22zeHN82qFBDfh6yK4RkeAfZSKVEKwYW
         bHvg==
X-Forwarded-Encrypted: i=1; AJvYcCVxfLr/5dCrP9SJVyTvbSuFtaFXBoYvGgcCMKqoaijLI08CS6hYbBmLIH0LxnDMOtecZWO2o2MqB1qcckA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJlDr3xO/HgAa1wPT5N3lZg8kcXr9HdGFnxwwYXAFe3qEU7Tb
	jxhNR3M290pi8uh0LAklWsG8JtxWUXL/0YMg4myh6af9Zyf/ht5ff0wiVkPacDW4hYR9BIIGXDJ
	1
X-Gm-Gg: ASbGncv21KkLESSAg9nkPbqOz+YDefN0gZ80jgPHOLAIzZ5ypeGWx5jp9TUln2fZzSa
	ZMxI836BD13f49DPKlzVcsEuscQMgYd97MlUrByprTW2UMPIosC24NccuVqJc1Yiibmw82TfvM6
	mLHVQDNS7urMQQlk7XLZzanrH3K3vIsRM3sqw/Jafu/grgxVfB9SMmYXWGCevyb7O1BzsK6OEcW
	yRSK2RbvFCqEsh2oBH5kigdtuvlcvp88H+fsBLU1TSWBtJMnYxfJMGSQAFwtyjJz05+trncQ9sO
	exatAKtDJCZ8R4+sQkH0fiqOp97+km+DoOCf
X-Google-Smtp-Source: AGHT+IEdrq2nDcrlokLWu5B99Vt7XXGUTSjVaYnvuG/TeLYt4skaR2JoYGjFSX/j14RH9VpA4xleeA==
X-Received: by 2002:a05:6602:3d0:b0:855:c980:6eb4 with SMTP id ca18e2360f4ac-855dabd790cmr2360259239f.1.1740603359298;
        Wed, 26 Feb 2025 12:55:59 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f3905fsm21244173.88.2025.02.26.12.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 12:55:58 -0800 (PST)
Message-ID: <04c7f895-d587-4023-9fdf-60085c329ff3@linuxfoundation.org>
Date: Wed, 26 Feb 2025 13:55:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Use readelf to find entry point in
 uprobe test
To: Steven Rostedt <rostedt@goodmis.org>, Heiko Carstens <hca@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250220130102.2079179-1-hca@linux.ibm.com>
 <20250226121316.7653ae38@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250226121316.7653ae38@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 10:13, Steven Rostedt wrote:
> On Thu, 20 Feb 2025 14:01:02 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
>> The uprobe events test fails on s390, but also on x86 (Fedora 41). The
>> problem appears to be that there is an assumption that adding a uprobe to
>> the beginning of the executable mapping of /bin/sh is sufficient to trigger
>> a uprobe event when /bin/sh is executed.
>>
>> This assumption is not necessarily true. Therefore use "readelf -h" to find
>> the entry point address of /bin/sh and use this address when adding the
>> uprobe event.
>>
>> This adds a dependency to readelf which is not always installed. Therefore
>> add a check and exit with exit_unresolved if it is not installed.
>>
>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Can you take this in your tree?
> 
> -- Steve

Applied to linux_kselftest next for Linux 6.15-rc1.

thanks,
-- Shuah

