Return-Path: <linux-kernel+bounces-564459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B91A65586
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF47A189722E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ECB248887;
	Mon, 17 Mar 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lb5wqgWl"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C0241685
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225207; cv=none; b=EpZfCOZh+aJxJWv3nQYSpXGJK2hh2Orzw2toHMR+d5H7hcf3b2MLVlu7m4C7821UEQ0dr+zAoeqzTYpfi5EP2v/WHBAp8H2SfW9Nf8uSBYI2Nlsd+FR6MZil4Xf4Z8QCmUrmilVt69PpGpqDf7hMm4BE7JV4pN67sIAe1yDAR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225207; c=relaxed/simple;
	bh=1h/inLTNZqZjDQUPPuVg6t4ZGL2HFIPBes7HYKyHzYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrLXaq6XoHb7XifFf8+ClDOkyWyT05QlPjzdL0b1q1VnsLpUQCivExxmomblnSExuZqyvogUbyWmZgclCBhbNMIe85KXfr/pEN9FY7v50doxGwgaX5vo3OmXLJqpprz7/4OsxVVL2Aw9l6ZVSCEVCT6PC/VYTVoGtsKYX5qHZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lb5wqgWl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390cf7458f5so4003694f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742225204; x=1742830004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dLQN2rYfbUfknOcr+3k7Zu0rC5DV/UYvyp9DPPr78Rw=;
        b=lb5wqgWl2rKNiKl5K52gsvEtW10THJEKiWTsgZVb4KTATAc8STO6gwfIYbVwOIapZ9
         2ps2REIE5xFrisz22r4XAgnWPsU2FwC9V5EJVL+FXN6J4KPzuUGLuuh45qKgwj3CNLds
         3F/ge+GuLHKK2jLqk9WlWEQc45UAW/jXEKcQjPnv5k1oWV6OGQkSzetIF1I+Rkd4QThN
         vuZO1Z1c/232bKQ44YMRw/GK2/8SyO2bPGJBJXB09Gqacmr/rb3BnBXvY6AA4llgdJei
         VL5aJIwFMC2pAhkrrEj89FO1HF9J+rjaigFyXJl/nS/ANZ/LwBKukcdKnd67GEuKBPf5
         0Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225204; x=1742830004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLQN2rYfbUfknOcr+3k7Zu0rC5DV/UYvyp9DPPr78Rw=;
        b=wumDOzlio4qfZXgsYD2KuBUey1A+LleZhqgxrnv32Yxo9UXyOlWlZAgWxT1iimvPzC
         PsrNfg4IIVI8N1pMfnqRq/7bcry8tX9W5UHDGuqQl/4Y+pMYgB02uOSWOViyE/MwR0Vt
         CJAbIhThmXBmMhSqv6UZHsnYfi1eOXV9qZiBrXUaWhLZdglfSrXaEMEGZwNqZYh3wDcB
         KQD2D229DY3Bi+DAICH5pkLuvY5/P6L1lfNSCyNJfVPgHhMBRx2EZvqFvs3qsOpCvN59
         47tHP8RpQ6Rues6x4R4ZRzoQSBtMkrPot5l6o5QNteYLaolBC/2cfQTHTU9eE4coX3l5
         sYhg==
X-Forwarded-Encrypted: i=1; AJvYcCUH4qgs1PwAU9/Nd/mt7YrB7auYNiK+Cj/1R3JZGhEiRMVPyud4rA0bCKlcCcjmGJiJp56qECQYOU1t1go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0+sAhi6ilH7/QPa7caEFMUskpYbSrG91XkjQCBBAw33YBuCUc
	eSbKxmvAeD6pBjbosuAR8CO9MMUUsN3QItX2miM9jfBv6Lp7nroqjdIBRhCm5Pw=
X-Gm-Gg: ASbGnctGWfV9sPkgKthE5sVhBNt1lvP6TvUN0aK8JkjYyOsWCSClVLe7IgX1fa8fkkD
	ES8Bauq2UiN0NcuhS45IGfpRdEWRxjhfGNhS2bgPvR3Dm74xHgljs9gyaE5mTRUu0xyrBXbS3A6
	bblYr/MF81KXRKFiWmXS5xOpyybScBPtliO3SZGsFbAFlqohJJT6UMVokgYbvYkwnwPEVIrQqOV
	iqUQQubPyhKmL8Z53Wgn+07fcioetcIHUebCtYLNEISlkYHyYkMPsZj0rKlqoXlK8oB5qLX0xYN
	pt4ibe3Om/MmfP0kzwrIVltQwZret3XlwRa0Qc+z31bV+/w7rEqeI9Gwcnb9hFgN
X-Google-Smtp-Source: AGHT+IHmlXtTubn1PZxH2CkcujoV8qVJCpVv92ZgYDL+4RbLAnl09dxmfdM8qSfdWo4ezczy/3C0TQ==
X-Received: by 2002:a5d:64c9:0:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-39720779405mr16263191f8f.48.1742225203800;
        Mon, 17 Mar 2025 08:26:43 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c258bsm14961910f8f.24.2025.03.17.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 08:26:43 -0700 (PDT)
Message-ID: <9d06b27a-c2ce-41b8-9657-151000c0b244@linaro.org>
Date: Mon, 17 Mar 2025 15:26:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] coresight: Remove inlines from static function
 definitions
To: Leo Yan <leo.yan@arm.com>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-7-james.clark@linaro.org>
 <20250314095025.GW9682@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250314095025.GW9682@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/03/2025 9:50 am, Leo Yan wrote:
> On Tue, Feb 11, 2025 at 10:39:42AM +0000, James Clark wrote:
>>
>> These are all static and in one compilation unit so the inline has no
>> effect on the binary.
> 
> I read the doc coding-style.rst, the section "15) The inline disease",
> my understanding is though the inline is not encouraged, I prefer we can
> follow up the rule:
> 
>    A reasonable rule of thumb is to not put inline at functions that have more
>    than 3 lines of code in them. An exception to this rule are the cases where
>    a parameter is known to be a compile time constant, and as a result of this
>    constantness you *know* the compiler will be able to optimize most of your
>    function away at compile time. For a good example of this later case, see
>    the kmalloc() inline function.
> 

Isn't this advice about whether to make an inline function in a header 
file or do definition + declaration? I only removed static ones local to 
.c files where 'inline' has no effect at all. We build with optimisation 
enabled so the compiler already auto inlines small functions and ignores 
the inline keyword for large re-used ones anyway.

>> Except if FTRACE is enabled, then some functions
>> which were already not inlined now get the nops added which allows them
>> to be traced.
> 
> I understand it is a side effect that we cannot use function tracer for
> inline functions.  This is not a big issue for me, as we still can use
> "perf probe" and trace_printk() for debugging.
> 
> Thanks,
> Leo
> 

I think it can be useful, I've used it a little bit. Might as well make 
it easier to use for someone if it exists.


