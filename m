Return-Path: <linux-kernel+bounces-188956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDC58CE8F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E9DB2195C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503DF12EBEF;
	Fri, 24 May 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LHDlbWT3"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3E12EBD4
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569832; cv=none; b=g9DEN7Zxhpsfy8VIuXOd219QGVk/qOaiWBYUpeBDgooSKrpYcz2qIgW6VNS3oA1J5tj6ZoiGdKJJbyUsVak8ndQuXMdQxglzDGVzPgVFlDiWPPJoNQPrF3U2+nh8IFZ0cYS7r8U64rNHYxCXuCJ/l4Y4U5LCP/PBWSrMPz0xFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569832; c=relaxed/simple;
	bh=l1qij3H88ywYXunqBc7zXwXBfDbaEoUXbfNvl2pvmO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVS/eePV9HP8m9W9YNb+iFxMjLu2jjc1lq1wcxksZ3dQDzumL+Pl3JfRNrHpeMoExJ0cL8IDA5nJ4HlkW67yEKNq/6fXJkWd3T6iw45u9+M+HNbVU/VAOxYd7RKj/MHNa6v5afJsF3JyBENZVNEPY+OulKiP4P5gxQEry7UIM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LHDlbWT3; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36d92f4e553so3824025ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716569829; x=1717174629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yb7g4vjrRVkO5Lz+Zwi9wOYOWL08Ot70nen2ebWd6tQ=;
        b=LHDlbWT3ldp+/vm4p8TKb6XhPYl/O5SBEJWvoVLMx4rNy7HtFKjjkLZtZH/LMxGv0v
         3XPoYNwP59e75dz4lO0kL5GxOuCAPIDTAiNzgFzFdMK/Xna1uoCnUrvZ2Fv9oXflA0DC
         6cE2I7pGT7gxckRJZhrZ3QzBRyLrXJWVa4iruwish1QZ+BL5ek+xUsPfJpu3/uM4f+4E
         pCP5Vl5LtTao8ENGnnOHktPZl8lI0jPM6dPB1omvjslcx4/PpUqmBDDwlPWjoVi8IcHW
         LFMnd5/y4F/GwVZ94HzbmtZaD2jUcvGbt7OLxx84gXqh3PABuJSGHBhR7eG414E2jEYw
         6rPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716569829; x=1717174629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb7g4vjrRVkO5Lz+Zwi9wOYOWL08Ot70nen2ebWd6tQ=;
        b=hm3P+6DmF6/waf/z9kZ44ufitpcwTTDRYV1/y/RPJfREjBT7Oa8KyfekNomekDi4Ft
         Il37spDbul0GV5Gi3dDvIdXkHJqeQHhdcP5qvkC7jT5EMq7XSRxJJLsweDZ/1NAXL37q
         BxPT1EjMZawsqQTgkmazajSCj8nfC8IMcftGICZk00JGqeAzKBQ/vSbLL85nDvxXCPo9
         xhaTM4JVI9HLvQmNn99AtyQjes9zcJnmMddS+cT13mCJFJLnBsdHcXROoPdj8YdHzXyc
         /SULYMhxk82vMir8H6vzzsmOQZUAz6TTmwYqZoGE3pFNODcBxpqwOUicBMMudlybVo4Y
         CoHA==
X-Forwarded-Encrypted: i=1; AJvYcCUmC5Yc9V9eDEjZ42H8uZcLDtm4k0kpuM9qvegBBR4i0eV/6dbRKgz4RKHvEc7xZmjTaemK6Nayof9SHuQNX7EEeBtaRAGkTTGJhfF+
X-Gm-Message-State: AOJu0YwuYI7k5uaTZKLFbcNlJ42NqTsyGFWa9Ce6VgTr8P6sN4PSHUb9
	gDGsFojW/uuK45Cy8upwQuGd4dzwpsw/EGlak1LoBE87riHpxrBLCqbV/p5oyU0=
X-Google-Smtp-Source: AGHT+IE2SfIZ4OIRZz8qyRAJqq5Zl8JbWj2ZECK2bYvomifLTEOhrzU8APo5+4+pTERqf1qDAF3IKg==
X-Received: by 2002:a05:6e02:1c29:b0:36d:cb9d:cc9e with SMTP id e9e14a558f8ab-3737b36577emr33766115ab.2.1716569829377;
        Fri, 24 May 2024 09:57:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737c32ee65sm4258045ab.67.2024.05.24.09.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 09:57:08 -0700 (PDT)
Message-ID: <d1cb0cd3-0826-48fc-8713-8648d6eb9fd7@kernel.dk>
Date: Fri, 24 May 2024 10:57:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52656: io_uring: drop any code related to SCM_RIGHTS
To: Gabriel Krisman Bertazi <krisman@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-cve-announce@vger.kernel.org, cve@kernel.org,
 linux-kernel@vger.kernel.org
References: <2024051338-CVE-2023-52656-6545@gregkh>
 <871q5rqhuc.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <871q5rqhuc.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/24/24 10:45 AM, Gabriel Krisman Bertazi wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
>> Description
>> ===========
>>
>> In the Linux kernel, the following vulnerability has been resolved:
>>
>> io_uring: drop any code related to SCM_RIGHTS
>>
>> This is dead code after we dropped support for passing io_uring fds
>> over SCM_RIGHTS, get rid of it.
>>
>> The Linux kernel CVE team has assigned CVE-2023-52656 to this issue.
> 
> Hello Greg,
> 
> [+Jens in Cc]
> 
> This is stable material, but doesn't deserve CVE status.  There is
> nothing exploitable that is fixed here. Instead, this commit is dropping
> unreachable code after the removal of a feature, following another CVE
> report.  Doing the clean up in the original patch would have made the
> real security fix harder to review.
> 
> The real issue was reported as CVE-2023-52654 and handled by a different
> commit.

FWIW, the same is true for a number of other commits recently. They are
nowhere near CVE material, it's just generic bug fixes.

-- 
Jens Axboe


