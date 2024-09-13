Return-Path: <linux-kernel+bounces-328863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB9978A14
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12841C222C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1314B97E;
	Fri, 13 Sep 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ce1C7qGC"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C86F2E3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259994; cv=none; b=AH2uNV6CFs1GHcDJQkX4qAJC9I5vKeZOkkz1F6zeIJBfycpyId/ok6txW5bVFounSJhQkLQOXci39PYh4sgCOUd6BTkbHVLeiTYmXXuO84+NIqPVUQi6XmgppzdfeBRzrRhy8eF87Qdzn+srS8lYOpeUyDjrtzrAgWN2UA4E/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259994; c=relaxed/simple;
	bh=a8njrOTyZnMxD4gOMQBRN2AsNq9RJbj4q5h2B0eOlN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdHA2Q7arUcniB1rs3tfRHPt3hO0dIQ7FSEJE7GaQ0SVFGjJl+mP0PE7GtY5/1Cdbq9BfLU7KNl883TxybbQeGBRr3g6WtUxJTW0Q8YoPRUTJUauOCSAwrbnV8x0KjIezKYnWhHcwNEOTMSyW6ndr18xXUYBqomNihQ/MSF2190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ce1C7qGC; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82521c46feaso74658039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726259992; x=1726864792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzwULVxBpNCzh/Z3BSecHD8j1E6FKJZ9DzWkvDKTx/g=;
        b=ce1C7qGCCrhX1PCrquablvW1B2i6jKGvf2XUsCQhCvmrh1c/oTOpUvWuqPVjWBIOm4
         8TTJMPQDucyEnCYHveFWqgWYV1+f4AAnEf/ZR/1o9KtHeetZT1GhVMUUaxriXeA9NYBu
         bc1GnFMArzU7PKNAkE95LHK/CGIhGjO1cYuOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726259992; x=1726864792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzwULVxBpNCzh/Z3BSecHD8j1E6FKJZ9DzWkvDKTx/g=;
        b=P+/PG1gBFpXXNOad9SxBE15kA9QI+vcBphvFiABHpLZb4CYC5fwg/5Hh86VUNqXXx4
         PXs5Jj8WeejZufdejBnbiq07EGJsmOHVFiwrISLK1qMO/+jXvBSp8kW8sr1URR63HX/1
         HbEkjCJZk5d2S/qjAzQvMw8mhhoCuie9ihxct8RNLFBJJtakSAYi6V5wgxHee9igIYk+
         r9jNav3CirIY0kn9kceXjOnIElqHb8WvCsh0Wfpy/x9erTPz5Zyx1kF7DWZtJOFegmdH
         joFdr12W/7gR100dmhT0lg5TDAeQZ57ox+Umrby+PaX6ZImdYk4o/ghzZjBdyJ3Zm9VE
         H2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5V0Lx1MhNR40yVn6l1rVEP6dl3rAdKI6mRCOU5Js6b3FVUxnR24KlfSxRjuAHcqwF6zaeFFkw2btc4C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJWw98/pcOxZZjOw0RbL254B13NwkkMb4+2PUkY9eiuBsUBmV
	Jhxan+/kjmZLR5ZWQJEFWXvjhx1Txvq1Mgn1ZPxepide35NXseBVCjvAfQi9fsw=
X-Google-Smtp-Source: AGHT+IFQQbBxapaLVHCmXINHtpFP3T2z47bsvw1jiUlO1syu+QqWGPBVi/d9cR6128ME1x3V00OJCA==
X-Received: by 2002:a05:6602:29aa:b0:82a:31d4:1aab with SMTP id ca18e2360f4ac-82d3783745amr489644839f.14.1726259992002;
        Fri, 13 Sep 2024 13:39:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d492694b0sm1568639f.10.2024.09.13.13.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 13:39:51 -0700 (PDT)
Message-ID: <f9df2197-0a1e-4ecd-b605-ecbf9a839fdb@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:39:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: David Hunter <david.hunter.linux@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org, javier.carrasco.cruz@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240913171205.22126-1-david.hunter.linux@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240913171205.22126-1-david.hunter.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 11:11, David Hunter wrote:

Missing subject line for the cover-letter?
> 	
> Date: Fri, 13 Sep 2024 11:52:16 -0400
> Subject: [PATCH 0/7] linux-kbuild: fix: process configs set to "y"
> 
> An assumption made in this script is that the config options do not need
> to be processed because they will simply be in the new config file. This
> assumption is incorrect.
> 
> Process the config entries set to "y" because those config entries might
> have dependencies set to "m". If a config entry is set to "m" and is not
> loaded directly into the machine, the script will currently turn off
> that config entry; however, if that turned off config entry is a
> dependency for a "y" option. that means the config entry set to "y"
> will also be turned off later when the conf executive file is called.
> 
> Here is a model of the problem (arrows show dependency):
> 
> Original config file
> Config_1 (m) <-- Config_2 (y)
> 
> Config_1 is not loaded in this example, so it is turned off.
> After scripts/kconfig/streamline_config.pl, but before scripts/kconfig/conf
> Config_1 (n) <-- Config_2 (y)
> 
> After  scripts/kconfig/conf
> Config_1 (n) <-- Config_2 (n)
> 
> 
> It should also be noted that any module in the dependency chain will
> also be turned off, even if that module is loaded directly onto the
> computer. Here is an example:
> 
> Original config file
> Config_1 (m) <-- Config_2 (y) <-- Config_3 (m)
> 
> Config_3 will be loaded in this example.
> After scripts/kconfig/streamline_config.pl, but before scripts/kconfig/conf
> Config_1 (n) <-- Config_2 (y) <-- Config_3 (m)
> 
> After scripts/kconfig/conf
> Config_1 (n) <-- Config_2 (n) <-- Config_3 (n)
> 
> 
> I discovered this problem when I ran "make localmodconfig" on a generic
> Ubuntu config file. Many hardware devices were not recognized once the
> kernel was installed and booted. Another way to reproduced the error I
> had is to run "make localmodconfig" twice. The standard error might display
> warnings that certain modules should be selected but no config files are
> turned on that select that module.
> 
> With the changes in this series patch, all modules are loaded properly
> and all of the hardware is loaded when the kernel is installed and
> booted.
> 
> 
> David Hunter (7):
>    linux-kbuild: fix: config option can be bool
>    linux-kbuild: fix: missing variable operator
>    linux-kbuild: fix: ensure all defaults are tracked
>    linux-kbuild: fix: ensure selected configs were turned on in original
>    linux-kbuild: fix: implement choice for kconfigs
>    linux-kbuild: fix: configs with defaults do not need a prompt
>    linux-kbuild: fix: process config options set to "y"
> 
>   scripts/kconfig/streamline_config.pl | 77 ++++++++++++++++++++++++----
>   1 file changed, 66 insertions(+), 11 deletions(-)
> 


