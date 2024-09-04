Return-Path: <linux-kernel+bounces-315972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E296C951
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B331F287E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6D1487E3;
	Wed,  4 Sep 2024 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UmFLZqP4"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4914A4E0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484194; cv=none; b=GrQK4UcQxbp8DQ3+JfuETTkBf1EbqjQQm0AQR6+3vJ7S+R8XOS5JiJzz0p/v+qvWACSBlA4zDwo+0CO4c50KlZW13NHRzF94ujTiPJDAdbrleCPslkH/V5amZG2BsYq073GCfGazdY7sX/EOFFF2/KyHQM3iczsLi9NLLCtBlbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484194; c=relaxed/simple;
	bh=th5iFwBAi8yOaXFpylDbD6g6XyDctJyukgrxCXOBuvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IldVYvfAb6rNcER7MUir/tt++HPVPf0EItR4dYW5O++Wn4Z4BLcLc15Xz0YOAURcjjlz6AVSky3tm2FK3ARfOo+oq6P8amh+g2M/wt2RZQUbSdOn72g1zF0TP6WnDPg5RjqBzfsNg+/whPvZGTCnlGHyHbRmOJ/WqlD91Ih3onA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UmFLZqP4; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82a1b84e6e1so288549139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725484191; x=1726088991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/OAnRUIec0MB5MMtbqzH58oYlTd06EXN4oDoez5il8=;
        b=UmFLZqP47zG0MMay/+3BjM9alUNHPaW3Az0vcjV2v8rYhKHqhWv0msdtXEt6cTQNwY
         ZpKt9xXv6wZF3mkci4nqHRZvNkoOegFDrknN35NsbRr9C9pFfchV6S1ADslGCSWm9K5d
         C2OH7wtgNFqw6gtTjVxRpcEuODGzq5lf258jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484191; x=1726088991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/OAnRUIec0MB5MMtbqzH58oYlTd06EXN4oDoez5il8=;
        b=oz4CBeYpUg1BgCg2kHbervLx2NemK9wyRh8DTd/VNsFav+Rh+T0JDADXfsiT3w5qHz
         ETZdryuTmDS+SM//epy3B5BOIQqhVyx4KGzSETMQOE1ktIYXn3UhbwreGHCoMUppjbRE
         ZaH64BFzH2Td5K+OkQkXEENCoeRrTg5dIUnYoOUwYMwGfmapV6Op5Aj3+gTCKHR8/Gdc
         XP1fed4Gof7bgYVYZPEjPtsjWKbVv9bE0DJGJJhOxNXoCrkcSlqMbmX8nRcVkGiPqqrI
         g/XY/iZ1HnXbhN22aZI1aftRsT2nXDVMQOmnnpz0PulzjyzY7JECdBlq0zLD1uM+K8UC
         ty8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+zdQ4fw4xsxLAwLCTdMyEdiO8RO3c4RNailrHW+OUtQpj8k1woUkimMDAt/ftBMGD+Nag/mHL6JiUlcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xsFWo0eMCU4lI0X1oVFPrpV4AYNhBIjCtnk3yXKV9L0KWooh
	zXFedacgyVJLKgJ7Mo284UODl7+N6MOrBP9ct5+ZZ9syHW4XPJMaH/1wReGBO78=
X-Google-Smtp-Source: AGHT+IEfDe4u4BqHTyGI1mF/XmQ29mH/QL31meG++atpanxeHeLUEhv5iB4KvLNk1QflEYwaT49BGQ==
X-Received: by 2002:a05:6602:3fc8:b0:82a:4033:1f64 with SMTP id ca18e2360f4ac-82a648a08a1mr852385939f.6.1725484190844;
        Wed, 04 Sep 2024 14:09:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2ee86d1sm3281241173.169.2024.09.04.14.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:09:50 -0700 (PDT)
Message-ID: <4566ee54-63a1-4b9a-94ba-42625c0ed343@linuxfoundation.org>
Date: Wed, 4 Sep 2024 15:09:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Fix eventfs ownership testcase to find
 mount point
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <172546382097.224182.6471842111781551515.stgit@devnote2>
 <20240904122055.71c4f38c@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240904122055.71c4f38c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 10:20, Steven Rostedt wrote:
> On Thu,  5 Sep 2024 00:30:21 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Fix eventfs ownership testcase to find mount point if stat -c "%m" failed.
>> This can happen on the system based on busybox. In this case, this will
>> try to use the current working directory, which should be a tracefs top
>> directory (and eventfs is mounted as a part of tracefs.)
>> If it does not work, the test is skipped as UNRESOLVED because of
>> the environmental problem.
>>
>> Fixes: ee9793be08b1 ("tracing/selftests: Add ownership modification tests for eventfs")
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Thank you. Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah

