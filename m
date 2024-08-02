Return-Path: <linux-kernel+bounces-273139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB2C9464E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57961F228EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85177F15;
	Fri,  2 Aug 2024 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XupA4vNn"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7536D1B9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633234; cv=none; b=lhUY8hI+zyi2nj+X5xfLE4vhN5Rcy2/yvudJJlDeQcljxHqKCdFIxyTZKX1vbixRdw8P2sefv1C9DakAkC7earLHnSX0eQuauZZ2CtxqsVj4ZKWCyFrLF3+qiofRTzBznMpn65zZ8kE5pr602BCG0LUn7yBWXC0prc00R4znpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633234; c=relaxed/simple;
	bh=snRQi2x1ZuU48N+w4DBV2nHArgWDBtEvImWG9TaEQ3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZClWk2Qhom7fnkMK+MQ2xQB9AL1TmZ9GXm5EXufSmj2MKujQqAvYrnlLqeWFe1jfzW/2EbcilHd/1oWV3IUwz5DQsMmi+95xU6x1l1/4VzExVc6BubG5Fc3WS5p5NXfryPJ05qvTngQfS+AMm//5Llh2H+AAQuWlvjF9Q+MFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XupA4vNn; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f8add99b6so35103739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722633232; x=1723238032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+T5VYsgGPulvzU0QqFuvKYZwjrJFAmfpJ/LDx5iaPtM=;
        b=XupA4vNn4SxUm2Qb92UL4GmPOr1rn7DP37/N6Jqmv0P9rIsvjAOOdIhw0+tpD0LSNV
         LFRSALqs/KvA9Ymy2HqXtJbf93JcrNkPfsM0j7kn0knHi1n93qhBw7hmbx198Vz4EW22
         dliexd/up2KYZ98NVrPFTE2Vice0UMKuhAQag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633232; x=1723238032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+T5VYsgGPulvzU0QqFuvKYZwjrJFAmfpJ/LDx5iaPtM=;
        b=DbEWLOCxrl8m5d+5zmRBmEYJAUh+dwRPGpBhL8sXoCf+SSujqYVax5vtBxkw1XQLsW
         HN19Fc8fHcAGJxp6EAi9gxei25LFuhXea6iaWa97+ebSoZBEpjwLTq3CPNbO0ja90u1p
         j3+FlxBd+QU4zv/S3cvsyTu4w7SxmB9rgS6DrMkuWT6yCbEg/5f4X3wkoItthEMkZx9i
         JQqJVkiCnwre2wXEqHp+sUua+YCzBQzH7z92Asfp8M070pDyF1z4PYqS2Df5tOkkQ5IH
         HTwNvaaBVi9M0gS5N37rvAHhqAMIFfZdgNRxEv+2NLdlIw4Z5rDjynnJam/PPQT2vkYd
         EYFw==
X-Forwarded-Encrypted: i=1; AJvYcCVM52H+EINR9MPW+lbisK/81aQRfZ1z2JdsMy+RM6MB8wnnupRD4OZDl5bawvp1QvlV+sy+uKQIg9wXJ2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xP9okf8uoikbb524/y/9M2NJer22c3F0qEXOFRIkbxydJd0F
	q+GCPF4+i7z3TRMRNjIh3+aKpgnL09s2cxxXNnhBYoUkouOBHIbI7Hcse14F2gY=
X-Google-Smtp-Source: AGHT+IESHBrtl1oYWqwmQgBaFa85v4gKBnuDcWckb4JCuhqj7nfwWnB1A5lVoTSEXsyxcr+zn/vvOg==
X-Received: by 2002:a5e:db0b:0:b0:81f:8295:fec5 with SMTP id ca18e2360f4ac-81fd433fff0mr335253539f.1.1722633232125;
        Fri, 02 Aug 2024 14:13:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a3d2bdsm610031173.124.2024.08.02.14.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:13:51 -0700 (PDT)
Message-ID: <ca0470e3-f3f2-4e39-8170-9287fa8eb043@linuxfoundation.org>
Date: Fri, 2 Aug 2024 15:13:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests/nolibc: run-user improvements
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
 <zvzacp6mqu6xhg4dx56kh67ucl6wmtnydm677tull2bx74i2zz@ebj4juspkjfw>
 <49861e61-72b6-4133-a72a-3dded276d4df@t-8ch.de>
 <pfzkuw4o7752mb2ksowte2cbfa2ogd2bsucbget5nsk76edcin@tueappcjnih4>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <pfzkuw4o7752mb2ksowte2cbfa2ogd2bsucbget5nsk76edcin@tueappcjnih4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/9/23 11:04, Konstantin Ryabitsev wrote:
> On Thu, Nov 09, 2023 at 06:44:44PM +0100, Thomas Weißschuh  wrote:
>>> On Wed, Sep 15, 2077 at 02:13:51AM +0200, Thomas Weißschuh wrote:
>>>          ^^^^^^^^^^^^
>>>
>>> I'm curious how this happened, especially since this was sent with b4.
>>
>> My system time was messed up.
>> I blame systemd-timesyncd.
> 
> Well, at least we know b4 is Y38K compliant. ;)
> 

And my nolibc email folder will show this thread as the latest
forever :)

thanks,
-- Shuah


