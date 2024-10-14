Return-Path: <linux-kernel+bounces-364806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D374799D9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D861C21636
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC21D31AF;
	Mon, 14 Oct 2024 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QCdeFQbJ"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C3143722
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943759; cv=none; b=kBQXrqkcGfmJgU3ZA/Q1xNLpzfysrfySh6B0E3nNf7rwwnv7Ztlrlu8PtGl8kwJDdq8JbyrhLN/J27tLiaCQipp5lrkqa0/yLLWDlEg8M620QMBelfgqwGxdrxDHf/jXpgUTGZ00uryfB1B7F+pi52cDV0Rs1+qAEFkKx4IWxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943759; c=relaxed/simple;
	bh=IoN2ym/fezho3R++5iArP0rzFinCh83Zm/Xd9RAA9RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpNslL85aSAyiN3h5PDQWUcxdCGvkUaz4/BLuNrqvUZ8jW/vPAKhlYXFhiLNsGFGSNWSDm86yABHsmrkiqgS1iGSqfvTRdss1lUy5p9g6PvddUtGFnV26yuvLl53WYigGjh3kqKYSV24h19nk6RXpgNnTIbxSDMYMzrGFRPzU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QCdeFQbJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83795fbfe4cso126576839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728943757; x=1729548557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9dwyDNpcI2CKP85q7LmDN5/gxxFMH+zbq0M9yIwSLk=;
        b=QCdeFQbJQ0viZRtqdGth/tNh0M54pM7BSwpVLgi63qwSfQzNKSzI1o+mWJonerKgK8
         g1EqlumXLAjEdhIlCnuS3uMQJkduvxvX5aTUW5V4nhtmeLfxdbC21ejog9d9PvZspfQU
         +so7A95+ajcqLPBSbApeXX/I8gd21naT3Cp04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943757; x=1729548557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9dwyDNpcI2CKP85q7LmDN5/gxxFMH+zbq0M9yIwSLk=;
        b=iEupmyd61uxqJgZ3gvSnDbN9H6f7w77jYw0khmQIUEjukLCwsGl4g0xEAzV/A9aWrw
         JxaE42BojShcsQeeoKSyuPEPWYrOMEIehDzuIb29RypwLiKK2V4sD7yel0374twT55A9
         iPKJQd0zIraLmSzstELTmrM7ubUyJHfUlDBEgoyH+4tPSdbSaEIsLksuYsPpKtYdTQmS
         P2tBBdSY5HW0GZVXSIILGYQUqWsfxBlzo0PYvWds/IeFuxAv0m6NNxaeCcyZj5ScP+TM
         aPdSUMuZtXphNKNoVrEIOpdafTrBD2Y/HELUv0SPChF5ZmSLrHB5MrXdh/I/j7nLDbpS
         HscQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe7aEzgHUzeVuqPpGn+UQK7swfbl4woVfoVfYgxt/nr/oHA7Z1fDAX5DpJRumh1qXLAiUbFtNDSRkg0mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLOEjF+jh9DuyD9sXQPFwVqLJpQrm9fCMsYS68hcMJEwji7hv
	j/uA9OVc70D8rPGZGWt6Phbp993PE+3eFfZhFJDzISVDXvDA4BZYgg2AMI2fAwmKMieS8K11Ssr
	d
X-Google-Smtp-Source: AGHT+IFzjgPeJcnUWunnpkrcZpJhLGLQYeiI9hikhqjsBSfaiTa5/JLqQQ2w6k7ZaTiFxrdW7VGiUg==
X-Received: by 2002:a05:6602:164a:b0:82c:fdc2:e25a with SMTP id ca18e2360f4ac-83a64bfd806mr926954639f.0.1728943757278;
        Mon, 14 Oct 2024 15:09:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec96340csm10151173.18.2024.10.14.15.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 15:09:16 -0700 (PDT)
Message-ID: <0cb46443-1f32-4fb2-90c4-6f9dc834601c@linuxfoundation.org>
Date: Mon, 14 Oct 2024 16:09:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:timers: remove local CLOCKID defines
To: John Stultz <jstultz@google.com>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241011225236.27677-1-skhan@linuxfoundation.org>
 <CANDhNCo5q05xUgdXQaDfxUGbiKaV2mXmfttA-=oVrftBF0PERA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCo5q05xUgdXQaDfxUGbiKaV2mXmfttA-=oVrftBF0PERA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 18:49, John Stultz wrote:
> On Fri, Oct 11, 2024 at 3:52 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> timers tests defines CLOCKIDs locally. Remove all local CLOCKIDs except
>> CLOCK_HWSPECIFIC and use defines from time.h header file.
>>
>> CLOCK_HWSPECIFIC and CLOCK_SGI_CYCLE are the same and CLOCK_SGI_CYCLE
>> is deprecated,
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Thanks for doing this cleanup!
> 
> Acked-by: John Stultz <jstultz@google.com>

Thank you. Applied to linux-kselftest next for Linux 6.13-rc1.

thanks,
-- Shuah

