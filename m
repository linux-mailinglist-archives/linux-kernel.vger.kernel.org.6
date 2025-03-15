Return-Path: <linux-kernel+bounces-562346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FDBA62413
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837EB88364D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A54E158520;
	Sat, 15 Mar 2025 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsipS0Dv"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B04B666
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742002477; cv=none; b=IDYT3zpaxb6bqV0pjglHLa+VDA/tyKbNgkyo/mZX6SoTVZYOsT9LsrXdOSvh2hvfbD8DQcjh08ygueXde+39ihfqafuipsZLgjQjt2g6x5sGvaRMrhyl/ssxK/SCUM0n2POYw8aCua/AVxp48mHazE4sKX8H4jnL8tNG/SM86U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742002477; c=relaxed/simple;
	bh=rqMz50M9H3yFzreuyediMHQhfMZFiLl0qZcUoOUte4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0+1+ebHlvDDGPCVlo3oVNTrgtINGQo0ldMSoQegOzbVygsKRfiPROB6C6bDlJubrksaJ/TcOe0yLMiWxQoCcNTK6QkO/pa6vneZzTW0A9DqKz2LZ634ggYq1g1H2DQnsF5Zz/gqRAIBhxTRVa8jO0/FlEaMHXliI97TKpWnVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qsipS0Dv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240aad70f2so100745ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742002475; x=1742607275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvIL3fKVMU4+5xbZi0gtfEp1oSKzKEUDT0T+fM5EEa8=;
        b=qsipS0DvEm8/HNQ/WmePhcZd1gLMZLCDiKyJU6hYFnteiTpYLo0n1g92EKoZrZ02av
         1+cUOQHCLuBeBWyjBaJBlqaVDKKHrHoX0Mk3luKVeHOBRODiEVKN/Xt5tYwesj35/C4q
         7STmAizNI8gck4VafbavnVhfoow2dkglIR04WWX32ppwGXxfIK0RzsqrzmdRVCHxn+et
         Mvua5F1XodGvyXrrf61Y+IYM2aj31PHUkPuLg95mxddSUcA95zmYNsM0TCP+7cjIQ481
         zu3oh9sCKN8NQDP1WEaFPte4FXIXXk4r59iU+4hcFjnLQj/+ofOkAjNMeApHEr+9w4lM
         zw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742002475; x=1742607275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvIL3fKVMU4+5xbZi0gtfEp1oSKzKEUDT0T+fM5EEa8=;
        b=cATA3FYjqO55IQYgn2iZ0rZhPV/kZmczolcGgvnO00Rzp5iHR4CM5kl9bDueOPvKok
         vt1ZjEQTuxdu4oBGYhhZPYtQ5lR772ANfwZNzdQLSkCb11BHSB4vvLV0VY+PbihlWUGE
         v/ZVVXumfpWDP0ozwa5kMvr4buxLRPi6JRG+7V2ShaepUI12qHotjDDyY95KT/M6A9lw
         4oJO7/XLPyiz5b5Rcr4QLPSueYOWAs9Swnhr2yBY116C9iqwqURSxzwbvXvV3a8435qn
         fnZZ/C4g9zEzKTcDC1/AhPg3Ro9l1IkwMutAa0DmIp3kFtEQDpJ8UbwePjOkyvUT5WKj
         wFeg==
X-Forwarded-Encrypted: i=1; AJvYcCWrQesb9B4+dJ6+0UpE7Gx0BRw0+sWbE4bQYSzY3NkTo8vd0XhrOJND1fBXkBedKm25Aza7VG+LNI3t+zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBf6JqjugdF3V8EGbbLnW4LO/K9cS8kDggiWyxMC6CuSN7FgSw
	0gKcg8ce72XgxHablq7xtReDbOjcGCf4y0s3yJFGYDUmKg8qR7ZPuxApVfjpSg==
X-Gm-Gg: ASbGnctS1qntdb9taUI0Fqwn+3JbbuRqbw72lme5cHxfsRlOoVVD0MbamupfwS/YcHo
	0xSVSBIrKno1pNpA4n6yhq8xHfB+KEdkInlNfLhxUa09pf57FHhXRelEm0rAdl9c+bH2/ADmQBX
	TiDLJziMz03DG6rbvMXwYTaUCnhm9MckbQHFU9NSVBeNbmgeWp2AqIsA474bGl3XlqZHOADwiBO
	iuWKjQ9uYjFCF8Imo9UnKLwIYP9Tim3HzUI3yyGob9KqZmiYCDUNwhNMK/x97fikZxSSErrBino
	pKh7AWfH4rbin3w5MZqiSZA8kCPGNkP6dvX2KG3QY3N7agfypJpSisjQwDP/TZJAXO5NkvJbfw7
	+PSYTkpxPXKXKhQZlkQ==
X-Google-Smtp-Source: AGHT+IGtQWEpjfINSgs1H4vMHK6YoCgbTmxFs82ZqbvJLldcI2qhAcTUK9ygq9RBHTYJszRC0D1L4A==
X-Received: by 2002:a17:903:2441:b0:20c:f40e:6ec3 with SMTP id d9443c01a7336-225f3eb1adbmr1168425ad.22.1742002474719;
        Fri, 14 Mar 2025 18:34:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:38d4:55d0:5a27:ba32:f0cd:cc20? ([2600:1700:38d4:55d0:5a27:ba32:f0cd:cc20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b1ed7sm3638401b3a.176.2025.03.14.18.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 18:34:33 -0700 (PDT)
Message-ID: <5aa114f7-3efb-4dab-8579-cb9af4abd3c0@google.com>
Date: Fri, 14 Mar 2025 18:34:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 03/29] mm: asi: Introduce ASI core API
To: Borislav Petkov <bp@alien8.de>, Brendan Jackman <jackmanb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
 yosryahmed@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, peterz@infradead.org, seanjc@google.com,
 tglx@linutronix.de, x86@kernel.org
References: <20250227120607.GPZ8BVL2762we1j3uE@fat_crate.local>
 <20250228084355.2061899-1-jackmanb@google.com>
 <20250314131419.GJZ9Qrq8scAtDyBUcg@fat_crate.local>
Content-Language: en-US
From: Junaid Shahid <junaids@google.com>
In-Reply-To: <20250314131419.GJZ9Qrq8scAtDyBUcg@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/25 6:14 AM, Borislav Petkov wrote:
> On Fri, Feb 28, 2025 at 08:43:55AM +0000, Brendan Jackman wrote:
>> (otherwise if we get an NMI between asi_enter() and
>> asi_start_critical(), and that causes a #PF, we will start the
>> critical section in the wrong address space and ASI won't do its job).
>> So, we are somewhat forced to mix up a. and b. from above.
> 
> I don't understand: asi_enter() can be interrupted by an NMI at any random
> point. How is the current, imbalanced interface not vulnerable to this
> scenario?
> 

The reason this isn't a problem with the current asi_enter() is because there 
the equivalent of asi_start_critical() happens _before_ the address space 
switch. That ensures that even if an NMI arrives in the middle of asi_enter(), 
the NMI epilog will switch to the restricted address space and there is no 
window where an NMI (or any other interrupt/exception for that matter) would 
result in going into vmenter with an unrestricted address space.

So
	asi_enter();
	asi_start_critical();
	vmenter();
	asi_end_critical();

is broken as there is a problematic window between asi_enter() and 
asi_start_critical() as Brendan pointed out.

However,
	asi_start_critical();
	asi_enter();
	vmenter();
	asi_end_critical();

would work perfectly fine.

Perhaps that might be the way to refactor the API?

Thanks,
Junaid


