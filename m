Return-Path: <linux-kernel+bounces-249582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88AA92ED8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC02D1C21639
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D5C16DC1F;
	Thu, 11 Jul 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLvOMh8n"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B216D9C4;
	Thu, 11 Jul 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717913; cv=none; b=d/ivtGlnRS8EzeI64D+M3EAYZxVZnVGoknC6WKJKhQtd/U7g6dJVRzbYPLlYfXhfnqaGoNq9V+z/qX6GY7VHFuCLhWFVnLBiFDWMHLe4wyJy3u0AMCj0u+jg+X5npMso3CZbhp9Ui66h/ZdjVSpiXAO/1pEqCvgBbakugUjIsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717913; c=relaxed/simple;
	bh=SB4qpL0ljjDFKe87ww/4LxfqyDSj1myALSPSgu7rtm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFHh8P0FFLGXq03h21Bb6C46K9F2Dtrbm15CPDHXRrmF0EIaFj7XNhUusGeyIv6o/fUGpTtpnIk2nMYo4kYG2htFqTkQ+DVq5GISXWBuydose1+N4iRcnip9NbnCS+UiAsWQxDaoEELW8VVlvmoBh9mmDoso4nbunbebjYkdihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLvOMh8n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb0d88fd25so8930595ad.0;
        Thu, 11 Jul 2024 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720717911; x=1721322711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=m47qfjSsIdeACPwsQ7umtFEk6SMHW9nnMDK6Ss+HmZ4=;
        b=RLvOMh8n/k+F3+t9rOQgCbEzdLmyvEfMaOBp2TTtu//zy/bnCFSBI5ydVEzbhPP/8b
         EYVzZHJCvoRXyx+V5WqZy06Qgj6UEJn7OfsnK2BuzuKqmyO0WOA6ClK8JECvoXyHvIF4
         qnB58OCcYucgdMKAuV1ZpuivhjiSRQHTHjuTsHdgAuQfgb+CpO7fYHBPBlXGlLafA5FL
         WhvXJBhBAb0l50PHkH0Y146R3NUaXRy9b6Bgeu1cNIt/O2ygPkwHMmOEZBJ8/qc8Jxto
         i0r3RtL0JaRWrHqDZ9MUlcgfSZWLsZyZlXXBkYKxIkTWwf1DS81ulxBsz0FDBSmBUUmL
         qXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720717911; x=1721322711;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m47qfjSsIdeACPwsQ7umtFEk6SMHW9nnMDK6Ss+HmZ4=;
        b=StGIa+3B1ugClFcbRpy6zsCaS7Q53SsKu8I3GFtMPb2AuoVBStFCYYL8U9zTrjL/PN
         jFNigCCKwVO7bJ1Q0+fQ9kw8uaMlihqeAOKZYkr5U5LQ4jtx7U+zHGHFGZMqrOgZu3TF
         3Eg7jNStIXmURDSpPLkTWLqS5iexneoNjYsd0hni0PlqSNPQ2tz3jp+XJyII9c3nWjgR
         vzQizsx3tLMO4t4FKqnt6eOhWnzzOtn2q8XMLCV5PVGHq1JC4acUBunFKoBvOJKocQVf
         xpvBR8HCKe7odgyKmqpH9N2uPmVgZVNOnpPeigWWutpTND2paISlSYPuVByzzx7t5fVZ
         LqxA==
X-Forwarded-Encrypted: i=1; AJvYcCVsApoYUA4Drc18NC44ENY8k4TstIVFppdH97SkNzE5JxiZBoRFN4Wgv7Mu2h7aDx8cQl+1QHfCjKzZbaU4EHCvJ5ZnmWnElWn2e+UHjl6ixfYtlKj+TVOHzuotEDSh2m3w3Eg6tbRiEF4=
X-Gm-Message-State: AOJu0YzjITdB8F2HoX+ZA0r//MSbEJtzrXq6h8KF79vTvxmj1+S62vFI
	PjOwDDTY4h+Dlq29x1AglDiV38D8rKe/jtOHhfb0nQU+yB9mptqF
X-Google-Smtp-Source: AGHT+IEyhSgZRxfPq+6W5q2bVgO8+UyCzKDTVGp76qMjFUJ3wv5npzar4nrLFoy14lAyZUxkPOTvSA==
X-Received: by 2002:a17:902:cece:b0:1fb:d378:9e12 with SMTP id d9443c01a7336-1fbefef501amr3434345ad.27.1720717910832;
        Thu, 11 Jul 2024 10:11:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac851fsm52823565ad.240.2024.07.11.10.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 10:11:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <07955cfb-aae7-4a97-8222-b9c235e7c8c2@roeck-us.net>
Date: Thu, 11 Jul 2024 10:11:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM linux-next] drivers/hwmon/aht10.c:224: warning: Function
 parameter or struct member 'data' not described in 'aht10_interval_write'
To: Mirsad Todorovac <mtodorovac69@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 "Johannes Cornelis Draaijer (datdenkikniet)" <jcdra1@gmail.com>
References: <851b86f1-5757-4f4a-960a-2d4ecb840734@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <851b86f1-5757-4f4a-960a-2d4ecb840734@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 09:57, Mirsad Todorovac wrote:
> Hi all,
> 
> On the linux-next vanilla tree next-20240709, there is a lot of complaining about
> code like these, which is not an error, but it seems like documentation lags behind
> the [dynamic] source development.
> 
> If you  are interested in reporting these to the respective maintainers and developers,
> give me a ping.
> 
> drivers/hwmon/aht10.c:224: warning: Function parameter or struct member 'data' not described in 'aht10_interval_write'
> drivers/hwmon/aht10.c:224: warning: Function parameter or struct member 'val' not described in 'aht10_interval_write'
> drivers/hwmon/aht10.c:235: warning: Function parameter or struct member 'data' not described in 'aht10_interval_read'
> drivers/hwmon/aht10.c:235: warning: Function parameter or struct member 'val' not described in 'aht10_interval_read'
> drivers/hwmon/aht10.c:244: warning: Function parameter or struct member 'data' not described in 'aht10_temperature1_read'
> drivers/hwmon/aht10.c:244: warning: Function parameter or struct member 'val' not described in 'aht10_temperature1_read'
> drivers/hwmon/aht10.c:259: warning: Function parameter or struct member 'data' not described in 'aht10_humidity1_read'
> drivers/hwmon/aht10.c:259: warning: Function parameter or struct member 'val' not described in 'aht10_humidity1_read'
> 

I'll be happy to accept patches, but plain reports like this are just noise.

Guenter


