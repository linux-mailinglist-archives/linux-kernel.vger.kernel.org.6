Return-Path: <linux-kernel+bounces-532132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1832FA4494F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37B43ACF30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6A819B3CB;
	Tue, 25 Feb 2025 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dsV6zM3V"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD341199FB0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506095; cv=none; b=PPKTY7iQ37uixiTUrknaYQh3NlZQqGHrrS+jadlhVlNyX8HMe+nFAQR+6bKhEA6QOVafKjfArCmD86EylLbA+7URnQ5hCj3vUvCpN2f6+P0gAO+yUw33t84Z8RFqVV6X5GhdAZ4vOmAHzzyT8dW1CoYNeF2MTAq/Tvhv8kT+/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506095; c=relaxed/simple;
	bh=slTRWrb0K60rij42llMj6mVKeIRUjLYwsZyy64sDf2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtWUaUIYuK3cyiOhNiF9SYeSL18Jc8SywY4AIg4nRvTHjAucRP5KfEo8boml+3NutHyQIgu1HBjomoZ6v4+YXnGX7tThTj7UW06+0ZPHP4gOiZiUbZENIaJtYnlsgM3q+HReqm+mKCwI4BBrjy9jrrKI3Kgggts0ibbw5soQpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dsV6zM3V; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab78e6edb99so837567566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740506092; x=1741110892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=011mEZq+lEHTVl8zPiUWPXTDh62dk2zOJhBI9PwZoL4=;
        b=dsV6zM3VZxvkpNQBf6/crt/+1J53Zbh/OW0pLF5kSQzH8DD1U6A8M7JvnMFOqfqf4e
         zEGmFdpRk7PE7uVnTC/sDJ37tw+Wdc3Mubb0X/zmZE0Ong7mAppG2FzSYBMvyDIFgHyS
         2n/tqC5igTG4dV2Aici6de3Vex+6GWkLbwvidqnymRAUwZ9DDdzA31l6peKskabN1SlC
         uDtNfPAEfO/9jjvEicQL0ha2tGyUvEoRjRhakO0o8dIpE+XSlfAKhtq7ym2GooPSF7rG
         0HuPXuN+J5W3OEQ8SL+6kPBc7CaDsnF6Ze2e9osMcceFOuuKPQIrsa1Gdr5JsEbDsUvE
         IyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506092; x=1741110892;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=011mEZq+lEHTVl8zPiUWPXTDh62dk2zOJhBI9PwZoL4=;
        b=kQEOauJT6GHgUse6ms4U4EpCNqo5+jqhKYWobbvMVHw4QcIfJ4tb34CvXTOCy7Qd5Q
         KP1rPUCBtrUewTiMnsLlXIy3Y+deQj/DIXT0WcYZihyhL8GD4RHHRD/UG50NGQ1DsNBX
         GZj3hCEm/PiO2yjRCV7HMJ7GZRIUMcbXUkRTyJ88AHcpNvGgoVHEqWS0i2dDPXkeqpDL
         Tzr5DTWHrOb2gHO7COsEIxFCCgmN/t+ipJGvjSiJCt5BW+gnAby7u9rMWyxzjJaEtWAV
         85vPu4I/OAabLfgw2rjTBgeJsUOw97Exk9E96WcwFuyy5GvYizu5dDiVGlvs1sgko48U
         ulCw==
X-Gm-Message-State: AOJu0YyksBOHLks3V0KQARhIP7vOIRTuqOZJInu4JcBtl+p16xlcfSvo
	U5W+z/XZ/+6eUWZ/Q+KyKJ46Wr6/Nu9/US0T5AfKtIXhgCEY1ecUgGj4A0o/uHU=
X-Gm-Gg: ASbGncv9XHCkmXQWOAVesWHJl8T6gTUNa4cDGkG4hLm/aK9H2bTHMfLzENRgiyy8z5c
	elVTILls58cqqwMCyVlgXkF04/ShRYjpVjcnflffOTMi0wkgai7rZIdtonY7jx4PVS4uZ13uaOY
	b25dO8lfc1X+EQJ0qbBK66Tc7jg7/5QniTymSfPZlIQPhf+ZkKY0LY0o+7J68LajDEVqwG5cwgl
	PRw+k7jp7WyTWl5w6wZau/Ovls9hRLti4iU5cxEsg59YUu3ttpjcC9Lp7KEgaEx7+hy+dgiHiyK
	kzxXG7B0HOISmJJn1JU2JZLkOi0wt6z+IL0+YmiC8AJ0SiB61AbU8g==
X-Google-Smtp-Source: AGHT+IGOWzmly6boKtwKSHB9GxdOpBk2xi8IAsBkCHz8v6aKL6B3fyJuVL3+GQUEXLe6PIomZxR9Lg==
X-Received: by 2002:a17:907:9721:b0:ab6:dbe0:d658 with SMTP id a640c23a62f3a-abeeee410b3mr9238566b.31.1740506092123;
        Tue, 25 Feb 2025 09:54:52 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20121adsm178683066b.91.2025.02.25.09.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 09:54:51 -0800 (PST)
Message-ID: <8973bfd4-d8b2-4dd7-ae1a-3f685dff769f@suse.com>
Date: Tue, 25 Feb 2025 19:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] x86/cpufeatures: Automatically generate required
 and disabled feature masks
To: Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, will@kernel.org, peterz@infradead.org,
 yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local>
 <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com>
 <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.02.25 г. 19:49 ч., Borislav Petkov wrote:
> On Tue, Feb 25, 2025 at 09:10:01AM -0800, Xin Li wrote:
>> After looking into the build issue, we think it's better to change to perl;
>> GNU awk has quite a few extended features that standard awk doesn't support,
>> e.g., BEGINFILE/FPAT/...
> 
> ... which will make the kernel build depend on yet another tool. I know,
> I know, perl is everywhere but someone would crawl out of the woodwork
> complaining that building the kernel pulls in even more stuff.
> 


But don't we use perl even now:

$ find . -iname *.pl | wc -l
55


