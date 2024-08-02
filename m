Return-Path: <linux-kernel+bounces-272140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC89457B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6141C2407D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30B3399F;
	Fri,  2 Aug 2024 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OiWNjspX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C03D6A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577457; cv=none; b=nVKdam+J1QXJSn9bYpd3xY6JGKD9WSmek9lRPS8Y6ASTt827A62Zp51IQ4DSLF7fCG5HrjqZpfTOU7R+KS40IJLxup2VdMAIhtudJ12KAeIwi+znUR+8VSjNAlQmqPwKL5DFi13jerDd20WX/pjP66+BCz0zrIyYJNY9sgHoLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577457; c=relaxed/simple;
	bh=UFHlq0H3E82gCdWNYrxq9Ao1um3cD+Y2UTdkK+3smhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVyALgjozVTY2xj7zTh6yru+nZB8uQ2m9lmqlKdANRrEBFsF+KjwHS5C9fais2n+0akG9QJ7Ke/gKkrEPhtGE04KFeude7VP/6fl4bQab3laoRYYWESYSjZ6Hug6AeOMsYEo+lDETzwzb4c8mPA2LvJGxHEhTqMppuCBs4hLhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OiWNjspX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281c164408so44344385e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 22:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722577452; x=1723182252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/suS5E/THPwitL/0CNux/d6Wr8slSFy728FjLfghXwk=;
        b=OiWNjspXshSxngOZ2OrWvpBpa5egjyej/6C+ZDVGi3b/+cFyuczSLF3KOOWFUirQuy
         La+zhcoJhJuDvrbTyegNRTFIVGsiXy0lDvWOQebW03YPgQ3dw2LnecsaZxTmPShcSXZF
         6Z/OHZ1XW49QvVzrwuVr+eT+nJ4I07Y3oy/fYh5kUOPKMZjwnf/0tmep9mNdNi4rc84d
         jTL+PcZzrderVgZLGwMjip/aMLHvLLlLrsYR0/Tu+R6nWRVQSkKGX1SWBvaWJaQ7JMZq
         oB5DBcc2FmrM71JcdfBeJHlnyENE+DLP7TbtCtlbtzYkWN96IxJ7JYg+jWqSa7SKwfHZ
         kyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722577452; x=1723182252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/suS5E/THPwitL/0CNux/d6Wr8slSFy728FjLfghXwk=;
        b=craF2QsDH2uGgdlzlvSqwIWZlRz4CVSo6AqxkCA4dduYkos6hYonGxD64qho68UlSS
         pKn8qX3MoDSe7ue7SLrQofmxT0JQcv7qvZh6gyuQ9TbrTAcqjTDNT9kKEAB/TvpWry86
         qoVhH8Rdl4c1Q6S6lnhl+8MyWspxkciISGfsNCHQIPvidF7dn26hLo72LlEE+VLGUWSl
         CfrVIU/9F1aXTAscyko//tnh8znYW0VirIJVf+0ERqQ1lqJ09qTm4l5nU+eXuPx9eql5
         1Rq/20/T7ahck2ndQBHCxtFb8JAGt84JVBH8AWfUko3oVYvV7rT/Jc7H+4Asf0CGPFul
         wIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbsSizAbGEWvjuA8NzZ/qPzxwPhANHZ/VFLjj0bqOeKZ4d43Kv0d2qCXd1OXfHpUn+bSR/5mqBfsrq/YMje2EKr3BwhCOJj+wtpzpp
X-Gm-Message-State: AOJu0YxccBYinSk50ocXj1uRDmxgUKZGh3pjrcAIMVE26KVHrxx8Vc55
	eo1gGvHkkmiBvfLtFrCZzM/rEaVbQXLInrsXO3t0I4TSF5mDr7n+wJmMK0D+BFM=
X-Google-Smtp-Source: AGHT+IEbwsdCFVcpSof1lHH3nO0h4oFeOaJ4dZlzRZY2FFW9Nakdpxej2wm/Gce4TH5H4U+e9jvGag==
X-Received: by 2002:a05:600c:4f92:b0:426:6e8b:3dc5 with SMTP id 5b1f17b1804b1-428e6b92636mr15226395e9.32.1722577452042;
        Thu, 01 Aug 2024 22:44:12 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9cd14sm18773995e9.45.2024.08.01.22.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 22:44:11 -0700 (PDT)
Message-ID: <242b327a-9244-411c-8d3e-7b860464f8f6@suse.com>
Date: Fri, 2 Aug 2024 07:44:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] xen, pvh: fix unbootable VMs (PVH + KASAN)
To: Alexey Dobriyan <adobriyan@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.24 21:16, Alexey Dobriyan wrote:
> Uninstrument arch/x86/platform/pvh/enlighten.c: KASAN is not setup
> _this_ early in the boot process.
> 
> Steps to reproduce:
> 
> 	make allnoconfig
> 	make sure CONFIG_AMD_MEM_ENCRYPT is disabled
> 		AMD_MEM_ENCRYPT independently uninstruments lib/string.o
> 		so PVH boot code calls into uninstrumented memset() and
> 		memcmp() which can make the bug disappear depending on
> 		the compiler.
> 	enable CONFIG_PVH
> 	enable CONFIG_KASAN
> 	enable serial console
> 		this is fun exercise if you never done it from nothing :^)
> 
> 	make
> 
> 	qemu-system-x86_64	\
> 		-enable-kvm	\
> 		-cpu host	\
> 		-smp cpus=1	\
> 		-m 4096		\
> 		-serial stdio	\
> 		-kernel vmlinux \
> 		-append 'console=ttyS0 ignore_loglevel'
> 
> Messages on serial console will easily tell OK kernel from unbootable
> kernel. In bad case qemu hangs in an infinite loop stroboscoping
> "SeaBIOS" message.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen


