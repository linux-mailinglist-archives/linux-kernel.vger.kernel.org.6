Return-Path: <linux-kernel+bounces-226627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72411914143
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9FB1F218EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1FDDD2;
	Mon, 24 Jun 2024 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e/KSLxsT"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFED168A9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719204556; cv=none; b=GQaQJ6F3fpg6m6Xj7BQu5EA/76F3ELFKILEdMNAl1qwOjR4mXNYPhUDvVUjK5Jp+goLkZ9xXQsek1NLhL7jBExymKWHsPj7PJzwrrDOSRNJCLIKeDJGyQShvMAfuqJmfLo7z+peIW07vKwKSXJZMdMJpvN4g+JEDBJZTj/A4Z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719204556; c=relaxed/simple;
	bh=mni7Xjh+W9N8YsIN4sLCAw2EtVVl7YuRtFktOF8G9k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gF4/yCX1VkP1n9la5VOsIa7uwwELvJtPCQdKc9lpX5zT3lV4nIOu12MXquIZzM5TOFJqU6SQRzbVD2TvId9bj+FkkP2M15iN8Lfrt6AfPfYB9SFN9Mx+jv0WqFSlODOxh6lamUQgDAmVvoglU7YIjsyUz2SgVv1rCmdzM1jLoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e/KSLxsT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-706680d3a25so937920b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719204553; x=1719809353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yCT5VxgAao2DKcwL/n1MwIFuYF06UPFj6XxxbzHuqM=;
        b=e/KSLxsTcJSOMYUBonD4vtVQahTG/gVPLWTp5R8CfCGHQ3vDNRY01A1T+EZY63m8as
         XgGUHGQAXPJqyFNoKOgpnrQ7QI2bSXWQIy0sS0e9LYPAPtF15J0sFUidx61egU2cGO+3
         DmLFc7oLEOiZ+y8yQbBryQTIFYh2I3rWzCvoZwdMYDfpRJAADjzu5RU5QSBXWOMIEV3q
         A3PQo+FFmDnBYF4K4QRKpoVjdbDIpmBI1wB2Fc+vRfsXWCPaAO6K80E1JZE6M6+fgqJp
         TdOkBym0TmcoLRsfKBl4L5Tc3Ia0Inv1+equh4XdoIwjzX5u+CA0C7D3Uk4dT/Io0D4e
         /U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719204553; x=1719809353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yCT5VxgAao2DKcwL/n1MwIFuYF06UPFj6XxxbzHuqM=;
        b=E99XC95DUmKYANGpbl7WIVO2LJxG72VJagifmJWzX7gzan4gWpnRQexwG9jcEmry4P
         BzpnCVpWOBRVUKVoy5OSBQIsDQffUMxBr4lTrc5+S0Io7cC4yfhQJNJiguwmUHw+cWeo
         IFpVwO70S4rrdTECeDS5NhHhqkaOObOJXhF8MDNw5R1udL+mk8D+n4IjYs2uLlqRPx9D
         COIEkOqToMmXpES8Jbqc/c9qGGoYbsItWazz2rtNgwjKGY0HNdWa2mAbQuuZUcT+qJQe
         TWpmS079z0VDhg6iF/0Itz57A3EyCOEvRWT/jVkLM8dCMvz+d8ThvBYm+kHORyWxlCdN
         gBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYFU6JqLhtmQpsrqzpCqAO40+1bx/2xgZMKBwryjWdbHPqsH8tpTw1BezjYe7yUlWnVSXa9uTaXz6FrRwOuLIiKoGTDap/aLakK9VP
X-Gm-Message-State: AOJu0YwoU3MHNKf1jEMC8bL58PMeMgs/Sw7aagFjbdGrRyupQoSqddnS
	0kCrxHaau95Wj2quxQDF4tmc5B6BUBTmfnNMd09h+WFOqSNlKUKqVF0rzrxYIc8=
X-Google-Smtp-Source: AGHT+IFMV0C+R+NwkxEg9McBmus0ucAUY3nQfRaA6AfKEyZMnE1mK8ZXtSOnx+hXLXQWZw+NmSap4w==
X-Received: by 2002:a05:6a00:69b7:b0:702:38ff:4a59 with SMTP id d2e1a72fcca58-70670e79d03mr4295625b3a.6.1719204553330;
        Sun, 23 Jun 2024 21:49:13 -0700 (PDT)
Received: from L4CR4519N7.bytedance.net ([2001:c10:ff04:0:1000:0:1:6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651194776sm5254865b3a.67.2024.06.23.21.49.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Jun 2024 21:49:12 -0700 (PDT)
From: Rui Qi <qirui.001@bytedance.com>
X-Google-Original-From: Rui Qi
To: tony.luck@intel.com
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	qirui.001@bytedance.com,
	tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [External] [PATCH] x86/mce: count the number of occurrences of each MCE severity
Date: Mon, 24 Jun 2024 12:48:39 +0800
Message-Id: <20240624044839.87035-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <SJ1PR11MB6083E1173846A5C8B4529D25FCC82@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB6083E1173846A5C8B4529D25FCC82@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

Hi Tony,

> You seem to have problems with the e-mail infrastructure. I got a few extra copies
> of this in HTML format. This one is in plain text, but the From: header says "$(name)"
> 

Sorry， some problem with my thunderbird mail agent. I will use git send-mail instead from now on.
> 
>>> So you either covered a case in the severities table, or you didn't. Does it
>>> help to know that you covered a case multiple times?
>>>
>>
>> In the fault injection test in the laboratory, we inject errors multiple
>> times and need a counter to tell us how many times each case has
>> occurred and compare it with the expected number to determine the test
>> results
> 
> In my testing on Intel/x86 I don't always see a 1:1 mapping between my
> test, and the severities rule. This is because of a h/w race between the
> memory controller reporting the error when it sees an uncorrectable ECC
> issue, and the core trying to consume the poisoned data. If the memory
> controller signal wins the race, Linux takes the page offline and there isn't
> a poison consumption error, just a page fault.
> 
>> In the production environment, the counter can reflect the actual number
>> of times each MCE error type occurs, which can help us detect the MCE
>> error distribution of large-scale Data center infrastructure
> 
> That could be useful.
>
Thank you for your expertise!

>>>> Due to the limitation of char type, the maximum supported statistics are
>>>> currently 255 times
>>>>
>>
>> How about changing char to u64, which is enough for real-world
>> situations and won't waste a lot of memory?
> 
> u64 seems like serious overkill. A change from "unsigned char" to "unsigned int"
> would keep track of 4 billion errors. That seems like plenty :-)
>> -Tony
Yes, unsinged int is far enough.

BTW, if you dont mind, I will send a V2 patch based on our discussion.



