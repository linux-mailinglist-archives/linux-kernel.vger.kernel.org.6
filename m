Return-Path: <linux-kernel+bounces-234639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFEF91C8E7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19C91C2281B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E380046;
	Fri, 28 Jun 2024 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NOYIM9kH"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424456444
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612341; cv=none; b=E4eQg48/S2lzzWwfwf+31LbtPJ81zbzoGBz3HcrJmXeygKRGWp7SsiIv8BpozqtTd61mKy+oeTj32T8dHDIbcsV1lzL5BUK4tOHnnNrLqpJBdDydoz7lJ78r7pbNOnROEpnZkiMonOIF4pxOVNHIUFhWVfVjSEndwkuy2NwIwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612341; c=relaxed/simple;
	bh=3aGEUvIOf/bidCVYqF7K+ZG+H0niWJmyzjVQCHJgyDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF0jxYURHVFUUTM2wO5ev79iQP/WSnd9etDpvT2J0fzpSmvQk/osVLWTbWyuF7JZP2Zy+euiCj/GW2NcWxQAHOdg7qJ6p4lNY8veoBpAgwTopaOAS4FJfMZHcJYL8qmexdRrFsW+a5uxDt00M6nkChXx8PNb5KH9AWEYLsB05rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NOYIM9kH; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3734052ffd9so636295ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719612339; x=1720217139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zlra1gL7XkIhl5N+DR/hN71YFNtByPQ/FFGNneM+Yw=;
        b=NOYIM9kHcvXxaGbifJSO7dRypGIHhiJV2SotzEC12EUh2kppj9dzx2y8T/DtkT0m6z
         hNewHC3nYgdhsdRT/xuDM2KXdi97mBS4d40785+GLrAjWwNkudPBsd5rwXMm9ee8DOL0
         sUE5JU9T6fJ+EDDSWQuZ+a1OYJcgrFC2hkJYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719612339; x=1720217139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zlra1gL7XkIhl5N+DR/hN71YFNtByPQ/FFGNneM+Yw=;
        b=FuMfpiX5glUc9TPybc9+Avt4BgOsWogjHNkQ+EZtpvXguS0FwIudO8vwpZFAn9F31g
         5MsZlZta2Qv+Ayl77tSV4z2Z+G4h82oRnQWXy2zGPYSpJs204A2kET2EZv/eHp9ZSrn2
         gL4nrrA4S8BiCAvapFZRfFhjaaSnLYL/fJnnMyJrLsi7QukhVVvA7m58yP0RbfvF3oux
         KiL//Ijlo72pNlWc0yCIdgRU/s3uzSACrmcf9bw/u+tciAs/AnRD73nNjXJy7Mc/a+fG
         c91Ps5LJZrnVq7i2Gbje8tJ3H7I02fH9dC/9pYcBa8hgNmTwPm/lFsTDDQ400U4w+PwC
         efrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKxFIYDyLSj5RTTqrH1ctwSNCo5Q4264oQLJYBjjS3AyRwhwSImWCtdKMOr5qj6M5EXQ/mhB5+HB2MG+T/3oUMOp/2lC2+Zqf5W9Qx
X-Gm-Message-State: AOJu0YwuDsv8Yplu8lEpa+IuEPNhRE09IzQN9l2nsekmcc7u0DETGmE3
	yEiIuOOh4QGya+CIyWY8JFN3sTCKB8eO/7CWETfi9CrWwkocftAjjV3ZdUrByEs=
X-Google-Smtp-Source: AGHT+IF5OaIaROSuGC1uEW7EZhHMkRrJMyqFF1GvL+sDpctUstwwNAvMlMZLGaJx48j+sKTVWG2yKQ==
X-Received: by 2002:a05:6e02:b21:b0:378:cf86:357b with SMTP id e9e14a558f8ab-378cf8636b9mr98406635ab.3.1719612338752;
        Fri, 28 Jun 2024 15:05:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370c90sm6147595ab.69.2024.06.28.15.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 15:05:37 -0700 (PDT)
Message-ID: <c1bcd796-033e-4ff1-b610-c7c2f64e0b44@linuxfoundation.org>
Date: Fri, 28 Jun 2024 16:05:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Disable direct build of the 'bench' subproject
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240626-fix_bench_compilation-v1-1-d039bd5fa551@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240626-fix_bench_compilation-v1-1-d039bd5fa551@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/24 10:45, Roman Storozhenko wrote:
> Execution of the 'make' command in the 'bench' subfolder causes the
> following error:
> 
> $ make O=cpupower/build/ DESTDIR=cpupower/install/ -j8
> "  CC      " cpupower/build//main.o
> "  CC      " cpupower/build//parse.o
> /bin/sh: 1: "  CC      "cpupower/build//system.o
>    CC      : not found
>    make: *** [Makefile:21: cpupower/build//main.o] Error 127
>    make: *** Waiting for unfinished jobs....
>    /bin/sh: 1:   CC      : not found
>    /bin/sh: 1:   CC      : not found
>    make: *** [Makefile:21: cpupower/build//parse.o] Error 127
>    make: *** [Makefile:21: cpupower/build//system.o] Error 127
> 
> The makefile uses variables defined in the main project makefile and it
> is not intended to run standalone. The reason is that 'bench' subproject
> depends on the 'libcpupower' library, see the 'compile-bench' target in
> the main makefile.
> Add a check that prevents standalone execution of the 'bench' makefile.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
for Linux 6.11-rc1

thanks,
-- Shuah


