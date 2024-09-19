Return-Path: <linux-kernel+bounces-333641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F897CBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39BD1C20F88
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5019F49C;
	Thu, 19 Sep 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTOt8Ofj"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BD1EB39
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761113; cv=none; b=OJME94mlLGyNa2XefqB6azYO0SNlKJXUa7fsjAdIhCYwpQ1Uy28LxnFaZYYgjWRxV530iHioxN0MJklFGGwbjA8+ZvtDtKZHZTq09R/ZpMmf7+6Di1hJwkNN972WrlcQk80tHDxZpM2guKOsi1D1tTrLoBOLzF7vS0IfXSfyLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761113; c=relaxed/simple;
	bh=Ct5jyYO6I0zb8EVMBPSaFmiYFy8ag9DKLrK/3JY+Low=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzp+XbsHJ1MmNcXvHPQ+0UQkz+Ztly/sw6QlTzM7e3P1H/YdXhtif+CEhsP/wL5wTilZpAkic615AyHIjDXEWE7Q4b4sQbg9V7Alv6Ft/Ic5flWWTunUvSrdEMxSss3YvhZTOWcbYqxb/c5K7DJwIETL9/3RVkBrScSlkoZk+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTOt8Ofj; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82cd872755dso48546439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726761109; x=1727365909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Yc9dnUfjYifVW32xxny3iJHEwr/JhiKmFnbSuEtTG0=;
        b=JTOt8Ofjd1LFuK1HZYgiW9d3AIwoGfOuzZlXX9En9PEmJ9WMawqIPX1V9lgGUZPos2
         nE/8MqY3nrmwTCYUYaThuiLtqgO4DMvqamjx8+B7/xqNoH+Q5qZRwgAwFDUuOtUUylDk
         OVehpqES+wIg1kKkACIGFLwDSYOYwq5aPeXio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726761109; x=1727365909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yc9dnUfjYifVW32xxny3iJHEwr/JhiKmFnbSuEtTG0=;
        b=o3FlF0Xnb2+U8jqqu1feZpNNouEYSLaAfirt0pm4oZEDuR8PaE/h26BKgL9zW0Wlut
         o1kflPcY8KnAl8iyWzQDDVXjOcMz9lj/tCufJdi4MNL1P2OXIXOyc8zxFJQJJxy9FgJF
         rb5N6rFGmI/r94sy4xhrCHYS7RNC12K6TPHkdDyNOhkEquoCRXCWsfiJQgflLmd6yymG
         XmtPeWPSLHFvccvqzvG9q0cEI1RR5OQHy/Qyy9Rb453Z1yf8UJPtTXwE9k12+JUXZ0zp
         TXr+2dm4H9gugFldh4/4aAkSn62+J1v0BbQdZYcm0ue/XETxYdXFRu7upPkgFSabJRdc
         YO1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcCYqOC63ewPOpOYAUVfc6hAKBSwBUOM4cnPb6wiHUAJkM7C5y45y40YlteFeErt02jVjq6UEHKJK55p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KLT9/5GE0KrWfZmTrVZo/sTyEqtANBLmgBOeQ3ZoTh1DYr9q
	asQQoCp2R9XhlfYuitk+y2l6EQ8cBHy4A1yW3frMgETukCK7Ivn0lfIeBnzOrsY=
X-Google-Smtp-Source: AGHT+IGQwY3ygyGvp1gAcwAAV6Vc1M8ufZmJxQScJ8GGG++Zos7hrQNdc61tPSGTGHlldv3sha2dyg==
X-Received: by 2002:a05:6602:608b:b0:82d:6a:4cae with SMTP id ca18e2360f4ac-831830edbd1mr1019079939f.3.1726761109480;
        Thu, 19 Sep 2024 08:51:49 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed19ebesm3034416173.112.2024.09.19.08.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 08:51:48 -0700 (PDT)
Message-ID: <952aeec9-c21f-46ce-bf68-e6ffce51630c@linuxfoundation.org>
Date: Thu, 19 Sep 2024 09:51:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Makefile: create OUTPUT dir
To: Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc: willemb@google.com, kuba@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240916075655.4117151-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240916075655.4117151-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/24 01:56, Anders Roxell wrote:
> When cross building kselftest out-of-tree the following issue can be
> seen:
> 
> [...]
> make[4]: Entering directory
> '/src/kernel/linux/tools/testing/selftests/net/lib'
>    CC       csum
> /usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/ld:
> cannot open output file /tmp/build/kselftest/net/lib/csum: No such
> file or directory
> collect2: error: ld returned 1 exit status
> [...]
> 
> Create the output build directory before building the targets, solves
> this issue with building 'net/lib/csum'.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   tools/testing/selftests/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index b38199965f99..05c143bcff6a 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -261,6 +261,7 @@ ifdef INSTALL_PATH
>   	@ret=1;	\
>   	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> +		mkdir -p $$BUILD_TARGET;	\
>   		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
>   				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
>   				SRC_PATH=$(shell readlink -e $$(pwd)) \


Doesn't the "all" target mkdir work for this case? Why do we need another mkdir here?

thanks,
-- Shuah




