Return-Path: <linux-kernel+bounces-339483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80D9865C1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD2B1F22729
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5982488;
	Wed, 25 Sep 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+mRAfdV"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045912E71
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285908; cv=none; b=DJWnXRnVflfsWMhxohSdIJi3Z6taWSIOht8rC6ffHsIGcGGAbzEWO5f4kVBtmAx+J3M7ljQX9QZon+Xeq+55Kadcp3oR29jUDSgJCIrCBlUMJmS5fUG4YFDiWotnOkPZI5Q9wBAgrg/+ytzukNCEhINhV5ha3/Yts2KJ5eMJmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285908; c=relaxed/simple;
	bh=2fB7VvK7p0djAFGCZ76lqlK/kuK8c5cj0cutAXqoIjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ar0X0qO9ewbgEd0Rb0RoCIHW/4lgOPzUeRlnJekYaTBxJndDTkpMV/CYGBhwiO3mcKGKnsHgxiK7wu7tTKhOxKaeGoGYBMCP9batv2WpNUfnMgl+vyiJPchjH579p3qCPKTT4SQ/DJ+0ey5fkw20qRVuWQ5AoczAHy6Nme3BgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+mRAfdV; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82ce1cd202cso4431839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727285906; x=1727890706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNYWYybui2SML08bFfCURSR7y1d30yyf7w7yHJdDw1c=;
        b=E+mRAfdVeYjiTL69hsNwfMe5ajI1sGlsCluxQ4fqySK18aUTCpfnc3qX2auLwRvVYf
         sLXoAuXyMZEdTyyzwXGU7FnQHtnMJlCGc8N1yLx/BbY4JGJyYUUPIf9GybLXKtpcm2hM
         LoEPQpZf0ck5VzE/lsZELQ76dEU7imZLt1Jhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285906; x=1727890706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNYWYybui2SML08bFfCURSR7y1d30yyf7w7yHJdDw1c=;
        b=eYtTWlN/lZ12NgVftU7IZSBxirmrL/tQZk+VqQu5grE/3u5qD4SfD2HyDFV3yyT1lZ
         N6TiyWmTAroqniTqwJERmnR00k5A5OzKcgfzEhyxgQuqOLujVuWFFUK67W8oYVXK7t4D
         1sjfRJjpfHSipK0m10x0FG+oyga+lBrobe+FNgA6NM4l9fDmn+EaSpUtcLpu2fAagBiE
         dtBTEvHZmr1ZP2ws1ldAt5FrCy/qCg9lu7x6DlUPqU0fRXanT6bnsq7twisN6p1v9fsL
         36lye1HNJrr88NtJ20++9dl8CXdJbzcsqii9uk8T2/+85uuUNWcnqf1gzwb0zgi3p4ie
         jXFw==
X-Forwarded-Encrypted: i=1; AJvYcCXlXCotnRKt4C5a2DBkiYjsidHoLp2FhGgVJjpao77hL1GEUtziLOnXT4hcQgULg/ylx8EacStxTs8ky6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7ussG96hI8rJDYdJrDuZPCzoKihtZsVbwe+PQv9QZkKEbVIz
	+wGt86sN5KolA1YzPeLosurQWVTl8zYh+jJsW0ZL2z81CXW/LcTr456JUF3CKH84pcwjXiPaCov
	F
X-Google-Smtp-Source: AGHT+IHZ3ppibItV5anfklTtvBV2C9TosOmUhdY+PswnvNpRUpKDmlGyfnqpFLEIOKom3Ru8FHVDmA==
X-Received: by 2002:a05:6602:1608:b0:82c:ed57:ebd9 with SMTP id ca18e2360f4ac-83247e6017amr433444039f.10.1727285905713;
        Wed, 25 Sep 2024 10:38:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f0e92fesm1210088173.25.2024.09.25.10.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:38:25 -0700 (PDT)
Message-ID: <74d8ff47-60b0-41b2-a22a-1077e9687717@linuxfoundation.org>
Date: Wed, 25 Sep 2024 11:38:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/damon/access_memory_even: remove unused
 variables
To: Ba Jing <bajing@cmss.chinamobile.com>, sj@kernel.org
Cc: shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924021426.1980-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240924021426.1980-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 20:14, Ba Jing wrote:
> By reading the code, I found these variables are never
> referenced in the code. Just remove them.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
> Notes:
> v1: https://lore.kernel.org/all/20240903034300.10443-1-bajing@cmss.chinamobile.com/
> 
> v2: Modify the commit subject and commit log.

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

