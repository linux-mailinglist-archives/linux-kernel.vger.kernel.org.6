Return-Path: <linux-kernel+bounces-294237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCD958B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157181F23B69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65C1922E0;
	Tue, 20 Aug 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSttJnse"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21AFC11
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167464; cv=none; b=TzHCJ5Fv2RdvIDxF1BqMk18pBL4hDuM8Lt2ewe0crZCei5OEsecGMPSsBUlxGvIafBxhJIDt2LBN8GuwJUevDrjPCk1wDbiVqm9NVwKOo6eNmA2kfXaPvsvy6gblRkMWJZcwDDwXW/jZEcc1SJjsz43ASoApNBKEKoNz7acaCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167464; c=relaxed/simple;
	bh=KBwkXHr1kJX2AFSwCKMT9bd12o4fYWsvvmBqlSEcSak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG2Jo/KmhgjiFpajW9O3VOqG4Om5qBW1bz9uD4LFNujRZpeSOoWY6EzyT4ysg0AwtDKGGUdt+8mkbjsTFWWqZYZY2i1P1MS2KmEoTMmmGgbLWUyTzAD8Raf0GhG/64UH4h659weP+xqRYiJgQomFJDD1KDU+8ZBU3NxmZMPzdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSttJnse; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so616531066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724167461; x=1724772261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7HgkFnanwKFW3OeS9V22GioDpAb7VOo4wn4Ejej/EyY=;
        b=fSttJnse2vtvR8T8ll9WxbF+/0L+p1B7V88R72IPx6jicF5ir6rTOjHQesS0dwE95E
         YEWQH14kQheB+hKFvfrPOJEodGljlhotNWHmRrWX5qQ+sOpwx4ngfHCXuqhsyX8Uz4Qn
         IXQwYFmlCque+QyYHLwOcs0zpQzYE/J+v4w92i554Orc50jXuovoeyWTGy6bB/qMeu1w
         coDFzznSE8uNNPFkPqkspxglSrGvOxHVV/T2sUWEZft8PXqhPa6AKNJDBfGjoBmJYK1c
         9Gxy8dVX1KJQmJydt3fY5sYhBl2nAKXAadegS/uqvvJTQBCfHuAjdPyvvL97aXx1QSfs
         Um6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167461; x=1724772261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HgkFnanwKFW3OeS9V22GioDpAb7VOo4wn4Ejej/EyY=;
        b=TBDBjxLL30WslMbWbnyRc83RM6btGll030gG1hFoyCDWBHc6M614z8KdHdYBPdY/Er
         wIMYsIPRjXY1cUFivZqHOn2ms0FmTJnRE+MAxMF1gr5aYFLnSdIP2WuYmb1yTefNPZoU
         rOK1rEe2HKekoVEhU+MOLUg0FfpB5Ghi3tuQ7Omb9PoIcqPPFVSUKl/yuto3qWh9+YvD
         FIhye+WxMfh8nGX3ulwvU2yUqcMekjdaMoT7clJ27X0yZ4kJDK2HEjJYAmuhpe6u45Q9
         9HMgrZSUvqAntHmgE4vl4fayqxXSZ0ELQb0ugLQamcM8W9XSgFbxAvUvjOZZMw+EzIls
         ykkQ==
X-Forwarded-Encrypted: i=1; AJvYcCURgcvME82bOXlgsTXwqvRUF6WdJFImt3JNEuiq3OSWIxA7X+mcIcSc/XeUpx0msEPIpWU3XZKBSkT7FJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZep8/eBbXtcVMMtHsJGR/aHtDTmrkk9EVEjRVmFCGdFnu2LJ
	3A4HvSPbl13NhypzWqjlc9sxXf2qHyJoqZyyYYbVR7pZ7NC6X8Ye
X-Google-Smtp-Source: AGHT+IGVQpm6g8LeL+zPHkc8MDsfrg3TzpmPt8GcughF4DDLLEoJQNjUJ2rPbuer01fOs1OZBv4OJw==
X-Received: by 2002:a17:907:f719:b0:a72:8762:1f5d with SMTP id a640c23a62f3a-a8392a11c1bmr1017872766b.55.1724167460624;
        Tue, 20 Aug 2024 08:24:20 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bcd4:8c00:ac0b:6ca5:85ba:bd5b? (dynamic-2a01-0c23-bcd4-8c00-ac0b-6ca5-85ba-bd5b.c23.pool.telefonica.de. [2a01:c23:bcd4:8c00:ac0b:6ca5:85ba:bd5b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a838396d375sm772475466b.221.2024.08.20.08.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:24:20 -0700 (PDT)
Message-ID: <3519beb9-0826-44e7-baef-759e9a63a493@gmail.com>
Date: Tue, 20 Aug 2024 17:24:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: drop __must_check from
 driver_for_each_device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd5221cf-2071-4be0-97b1-00a681482a5b@gmail.com>
 <2024082021-service-handsaw-407b@gregkh>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <2024082021-service-handsaw-407b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.08.2024 15:31, Greg Kroah-Hartman wrote:
> On Tue, Aug 20, 2024 at 11:00:29AM +0200, Heiner Kallweit wrote:
>> There are several users of driver_for_each_device where the worker
>> function doesn't actually have a return value. One example is
>> __igb_notify_dca(). This results in dead code just to make __must_check
>> happy. So drop this annotation.
> 
> No, that code looks correct, the only "odd" thing is that it's a
> notifier callback and so it requires a different translation of an error
> message.
> 
> Personally, attempting for a driver to iterate over all devices assigned
> to it just to print out a kernel log message seems like the big abuse
> here, why is any of that needed at all?  Ah, that's a side affect of the
> dca api there.  Ok, still looks correct, I don't see a problem.
> 
__igb_notify_dca() always returns 0, for other worker functions of
driver_for_each_device it's the same. So we have several cases where
driver_for_each_device always returns 0. Then I think it doesn't make
sense to urge the caller to check the return value.

> Ignoring error values is not a good idea, let's not make it simple to do
> so.
> 
> thanks,
> 
> greg k-h

Heiner


