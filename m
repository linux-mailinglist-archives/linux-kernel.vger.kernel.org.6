Return-Path: <linux-kernel+bounces-410931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C349E9CF08E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8389B29095E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1E01DDC0D;
	Fri, 15 Nov 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TC9LE44L"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF901DA23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685259; cv=none; b=GYQUFQIL7roOjyKSO3VzvBpQGJI7x4/ozF79/3sQzZFIL8ZmF8pphC5tliDjQZ4s9abUwQLQv2cG1vpyuRjexwirWo48h4wirumnX2as//IdgTaRsw0JFAiUQX9AhoDTvELJBBHjZisu6klPbZEpzV5k/OkgUQrdiBGX196YA80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685259; c=relaxed/simple;
	bh=jdr8qNxy+Jo1gsIHbtkxZqlHxWm+kUlA4DWc5Z9WKtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqJ8hXyqL5eXJr6pqFMcH37/N6OUyN93FNAe14fLqpEgY5/ywLUk/6sedhagT2Lulb2aJ6RHrso/T8mH/mF6TTopkCwmHH2m2PVTLROkWaLSUr19blutTC8TDMyhAgDoP3FNCoAvhwfKxCv9huk98W2/6zHTUOXgMc+pLDvks68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TC9LE44L; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2689e7a941fso490598fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731685256; x=1732290056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoZnHCDbvEhSS1c5SRWBNLiOwRUEY61DZ2aXp4JDEYc=;
        b=TC9LE44LpmuaBUF2ni7msJ+oK51W1D83PnHgzYUlflAY+cERqgR0vE3LBLWk9TxC7a
         p1jISsurUq6S59DUx37zcfpMiJCv0awylLruPYU+YwApwtBUxVxZlHm1bI/POjy+BFtn
         lqh86KHsj+bVsS2fy/299PTkWQB9HX+9Ha/fgfEhvLbFblmNostVlEjJU99Lbx3adXJ/
         rznhtFl0LPcslGWEQYTRdzLVPEzO2z0r3kxqHWvZUO87CGUO8Jp5zg4tjqakkUGRNgu2
         avNFass9dSjg0z0AhbOJfrmY5zTcAI8aw8srkccowzVXjare5LgxZaCh3lNhUyep4inO
         JgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685256; x=1732290056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoZnHCDbvEhSS1c5SRWBNLiOwRUEY61DZ2aXp4JDEYc=;
        b=OavksFTp09as8eK/LzEGKu1+lNtUDj8wFVPAnklJmhT2b25r0CEgFC59ODhtwoB+IS
         e1ngiNbzLk5gCSqOqpUZ3bf7epFLcoeWIsyJrpHx3M9q8j6AAkbF+3HDM89KaKTknsMA
         KGkL/u5oLe9Jm8jPLdHRDtGZF079gdPaFDO4bkvana1ZldmVLo+ldN2zfrcqSD9V0wH9
         a6Vw7rWvcAyKaWFZrqk7oAoV9Tfu9T1nVVfHmonvk7IQ3/dYR0srld1u7RM7bTfOqmHE
         QLYUoyL64jLQiEafqUHPXqUoCJBxbYU8MU2acY3kHe9Ea4V6r+8TxEuHd9rvnxeM2AY5
         jJ1g==
X-Forwarded-Encrypted: i=1; AJvYcCV7U9iu+ejdsBDxbAngci6AfRyiHLwjvZvaQC9Bk7V6S6cTMaYFs7h8FXQ6g4dbRfPu0TkcMZt5O23QDIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynf5yvJdbqifkjpSrsdG1iDw17pVR1YYinxDzHu7xUdsnZ1QLA
	Fsw5S5zPdBNXJdoW9sRt5iU34+mqWziF28kKuBAeqNNVLjytbZAm1ZkQPmAkxX4=
X-Google-Smtp-Source: AGHT+IFdUS8uN49tDNf746ur2SPDst9sm3KOAJaU1AK84+5cj7rnDzwIuOtF3souY+5wecSwvnATWA==
X-Received: by 2002:a05:6870:e38a:b0:288:a00e:92dc with SMTP id 586e51a60fabf-2962deeacdamr3161996fac.2.1731685256497;
        Fri, 15 Nov 2024 07:40:56 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29610949b12sm1516348fac.26.2024.11.15.07.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:40:55 -0800 (PST)
Message-ID: <7b1ed2bb-dc06-41ea-ba48-85c25d085dd8@kernel.dk>
Date: Fri, 15 Nov 2024 08:40:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH liburing] test: add test cases for hybrid iopoll
To: hexue <xue01.he@samsung.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3aada5a2-074a-45e8-882c-0302cae4c41b@kernel.dk>
 <CGME20241115033450epcas5p10bdbbfa584b483d8822535d43da868d2@epcas5p1.samsung.com>
 <20241115033445.742464-1-xue01.he@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241115033445.742464-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 8:34 PM, hexue wrote:
>> The kernel should already do this, no point duplicating it in liburing.
>>
>> The test bits look much better now, way simpler. I'll just need to
>> double check that they handle EINVAL on setup properly, and EOPNOTSUPP
>> at completion time will turn off further testing of it. Did you run it
>> on configurations where hybrid io polling will both fail at setup time,
>> and at runtime (eg the latter where the kernel supports it, but the
>> device/fs does not)?
> 
> Yes, I have run both of these error configurations. The running cases are: 
> hybrid poll without IORING_SETUP_IOPOLL and device with incorrect queue
> configuration, EINVAL and EOPNOTSUPP are both identified.

I figured that was the case, as the existing test case should already
cover both of those cases. I'll get this applied once you send the
updated version.

-- 
Jens Axboe

