Return-Path: <linux-kernel+bounces-532494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD28DA44E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9B91898A66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F4520F068;
	Tue, 25 Feb 2025 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="EIlwq+CF"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759001922DD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518092; cv=none; b=ma5EVqa7CJsNPtPpoRXhYM/h+1R7sPpJCAppYu0Fz8F24rxB//MJ7XCzbxwTXvXNXuPAWNqEGM37ySHbBfUYRYI3Cp8x7DHYNHZplLtOfyDiZJ/mZlTcwo8f0ZEViSqTe8kmT9KTGpDstzfhICstnRt0bLbMmh3Rm6GJXv22Z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518092; c=relaxed/simple;
	bh=z/htcAKy8BejW6BaJDus/dUUa71EVLTzM8XjVA5Dt6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtjbpUCNIHOwhTIVEOwlPsGhm/b1ypX8fHJ3VGlcG38KTo0tvozme99xxvubLnHOXS3lmYMHqcgo3ZdjBEo7Bhmw1Jz/iaYMnfrhiTFPk3VgJbFaVkFXlWR6bfr14p6FfIDUCJKbXuOk/t4UtIuK37eRaRIc5gmePxk/Lc4Co4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=EIlwq+CF; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d1a428471fso46016595ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1740518089; x=1741122889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xh2s6sLjIXbWIAOmjMi7Yyx9NKVsC0mal+LFgBmzJUY=;
        b=EIlwq+CFdz4mG+Xrh0uEGEZ54MGQdEFFbeVFENLfhrkpm6ZwY/nlaE0VtqAioJlvUa
         21/pO1bYfmgkwAnyyEDn9bGhNLVf2qrdL0IxZnfIFNQffzXiml1XymG37H2RP3j2Z5bE
         7xx8+sQcYCBP6C7YT/p/LvaUJMFU6KPeQu2JoGYNWZAoGOnCUFewtzlGUYDE6C5//tyo
         ToImm8uFeOmwsdOJwGvD4J17L7g69K1ROU3mbNqJiFhoeFZHUun9bX5mRkGOPT5pq80h
         UzAeZ2Uss1XrjNKymjEPRSQdxIp6AQ2cHgBCAJpuVR/e/uSU7uina2lb4AUff5RnWvNF
         owBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518089; x=1741122889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh2s6sLjIXbWIAOmjMi7Yyx9NKVsC0mal+LFgBmzJUY=;
        b=OgjR5Dek9Sy5C+8OsMIKXlekV4QO3sYuXpOgfyE2bcSawj+ifWh3oLYaKBjS0vWFOc
         Q9tEf3GNeUkqaKlGJGf2pAfTJGRIsMc+U7Xu0y3eKFrPxqyptOrFnwMioNbrUViNrFM4
         OE0TcAgaD9U3pqWA7sZrVS+I91/g5nW+fzyxxQaZDMjSZdaplA3TJrpgNbMoS8b1oyLS
         h7gsomZlJyZij/3/vBwWQfKqabL8McJw6GV6k7U+4qsSFjHFUoaW5qcgHpHaqW7BcyAA
         11YaQY06kbQCv9/EuXTxC4R1UW2UWFy9WPK0UYfbQ4ewiWsDrPREgZQ2+2NhzOWueRtJ
         V4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlTeSKcSA1bGbChThP7B30ZJ41nkT77QjSe6WesUL0WaiRlYmYU6u+Z23i93AQX3o1P1m+YJzzIBEJzWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxbpJZuwjGW+731jJoq1aubG/X0n9Ujt3s21El8XG2o2EwZIS
	FbfjHPouqT8M8cb9N9YicAh+MhJM4tVfiHCqxaBAUGQstUoJubjueUaRZkEoOCA=
X-Gm-Gg: ASbGncsMUPo5HU0jeQVwzkHmQ4l2A9hk2+7QR7l8ZHKXW4wu9rPjRg9c82j2JyboxLJ
	W3PMv3KnOfO0R+o62z+lXz8cI4elePmyUyQeSbFJVgNRbn4yxau9AasYu4+Q6xmpS1jkIMEpp0X
	V1hiZYqaEG7BLn/s9BQfmwhz3K5c8RYkFvjpG/yxRjIq/H/4RSVXfGr4V/dBKKfd1/Zb8oNcTnl
	xpBOaxPp92yUb1lZdcy8WC/GLvbSEk28IkydwcvYCrU4npMKsKXYlFrV2/juVyvMLeBMH4Q2Jpm
	hc8OU5jx/MMvgiLy2tYYm1iI/UQi44sliQ6CIIO8ZAxOmPnGXFTws/CKJr1ZFepQHw==
X-Google-Smtp-Source: AGHT+IFYiGdbqXZivMiTUNph/SuErSNuziRQ4+AzafOTADCcFATdduAQ55CPRDAy/XVPlsW8jn+L5Q==
X-Received: by 2002:a92:ca0f:0:b0:3d0:1fc4:edf0 with SMTP id e9e14a558f8ab-3d3048802e7mr47557345ab.15.1740518089508;
        Tue, 25 Feb 2025 13:14:49 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d361ca210bsm4894255ab.55.2025.02.25.13.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 13:14:48 -0800 (PST)
Message-ID: <34666c12-d10d-49a1-8316-bdd18cf1319b@riscstar.com>
Date: Tue, 25 Feb 2025 15:14:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
To: Krzysztof Kozlowski <krzk@kernel.org>, Haylen Chu <heylenay@4d2.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Haylen Chu <heylenay@outlook.com>,
 Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
 Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Guodong Xu <guodong@riscstar.com>
References: <aw2vqnz5vcccqqvrrhz5tgawj7fnzzg3tds7nnepuorit37a7r@jcj3wrs7d73h>
 <Z6rdBhQ7s2ReOgBL@ketchup> <19e5129b-8423-4660-8e4f-8b898214d275@kernel.org>
 <Z63T_EDvXiuRQbvb@ketchup> <2ab715bd-e26c-41bb-ac64-baa864d90414@kernel.org>
 <Z7BTVu10EKHMqOnJ@ketchup>
 <7c697e9a-d6d9-4672-9738-93ce3a71beb6@riscstar.com>
 <4f7bf109-bf18-42be-971c-5d5edd9595b5@kernel.org> <Z7mrdrACFp3m-7sy@ketchup>
 <6ea8ac17-42c8-46fa-b970-77ba89de66c4@kernel.org> <Z7xHRAFE4-QEA6PO@ketchup>
 <976a2029-c0c0-4093-a3cd-71e1524db032@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <976a2029-c0c0-4093-a3cd-71e1524db032@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 2:12 AM, Krzysztof Kozlowski wrote:
>>> They were brought here to discuss for some reason. Long discussions,
>>> long emails, unrelated topics like hardware or different devices - all
>>> this is not making it easier for me to understand.
>>>
>>> Best regards,
>>> Krzysztof
>> By the way, I made a summary on the hardware covered by this series in
>> one of my earlier reply[1]. Could you please comment further on my
>> proposal[2] according it, or pointing out anything that's unclear or
>> missing? It will be helpful for things to improve.
> Thanks, it looks good.

Sorry about my earlier message; I hadn't reviewed the discussion
carefully enough, and what I said didn't help.  It seems like
Haylen is on the right track now, and I'll wait for the next
version of the series to comment again.

					-Alex

