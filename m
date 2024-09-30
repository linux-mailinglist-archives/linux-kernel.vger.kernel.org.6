Return-Path: <linux-kernel+bounces-344654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D8098AC60
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F177F1F2126F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46270198E93;
	Mon, 30 Sep 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IteaKldz"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26D197A87
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722188; cv=none; b=DkHAs7Bd4OOQVs3oU0MyeS2ogfUbMg5I/HYA8PG8Dduyi6s7kKh84p7f0XtZ26fVncm+oWOKwyufL7ppRR1QcRDHRMoeBwQBd446rUTOyD5jEl+9a/1RiX0CYI7b36Yxqus72seCJdUbEapWVXhXJIZq76Cw4Ga0DNLFZ2KcIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722188; c=relaxed/simple;
	bh=058ine7/VNy79CgT425CPqN+8vvJjeOo1Wv0JRTaNDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSZXFLoQap9C0nbapdjoj5wgSvecsCVnIjKr2fKIc/0Y3UuyPWzJBxoKcwUC7d37T0XBr9gspDDtpyRTWtWjnVCyP6Ixng1YWkI5tKHQvg3ZPo+o3wzujnf7Cj7pEdwOtKc97M6tbGUvloRncyJDAtuYY2CYSjE7cx6smX6hFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IteaKldz; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82cdb749598so279250539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727722186; x=1728326986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a60vBEwneKd4X7+bDew6gvsUX4D2oqmSLXGoRIIlbvA=;
        b=IteaKldzVbxHBjsadJskwFYK8Rl76F7MGLvG0MuoBLI1CryM3p/xJruG0NAqCNrYTo
         O5EjLjpWhx1FdrczP71MOTplZKqI/EXD84o43GkbIp1eqMpiw7zHjS53TVpI8xlvtMjS
         JkayN8qpB3AlGY9VGJsR7tfgss911JqdDxI58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722186; x=1728326986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a60vBEwneKd4X7+bDew6gvsUX4D2oqmSLXGoRIIlbvA=;
        b=dyooBZjGeHV3+YtQfEzDqxeXgOrWOr7GeJMhStzSnmgdsL0j+czIWsgSu0BZEKfK/L
         I6OL2TlYvD+mG2VWloMjxkc89jAonfZU67UBdS2eXif/aV28fMMzHGFN2pFTJ1lzC0JA
         UTo9zDTcU7s+rGGenfbprEiktw1Bd7hNJwQ3BNWQrvSUDT6rbJuRvBipEp++Fpe+k7lr
         wuZCt8zO+L67L/doTDykJAKA5F5ajjWBdOutDVhTcp3Uj2UDoUnXhC2BYmGL3eTdQjUs
         Awsn6ibvGk2EuLmDu6y7gzioRjUNiw9IACxYUJ8ddjcBNtzIDbhMCZcQPc46jWhfAiNc
         auRQ==
X-Gm-Message-State: AOJu0YwAVzt2Zr9tVUZxnZ5wYxyt81DCcOGT3YdOg/aH5wf/bC8vUBbn
	+vh3TC5Th9FeV2LPkD6HpM5aRBCW5QQ0/QLKZKe0v9DOqspYRFn+2CwzEsVHg/Q=
X-Google-Smtp-Source: AGHT+IGKQ+dozzTAqgMX8sd4LRbQCtOhrdrHVPEMD0oL12CzQY+1S9hCbuAGwNg1/laxIb9nfe1H6A==
X-Received: by 2002:a05:6602:340d:b0:82a:2a0b:1c7d with SMTP id ca18e2360f4ac-834931c3c44mr1063694439f.5.1727722186133;
        Mon, 30 Sep 2024 11:49:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834937194d6sm237965339f.40.2024.09.30.11.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 11:49:45 -0700 (PDT)
Message-ID: <54d1bcb6-b817-4ab5-be0e-aea34cfe0d5f@linuxfoundation.org>
Date: Mon, 30 Sep 2024 12:49:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: improve timer_create failure message
To: Gianfranco Trad <gianf.trad@gmail.com>, jstultz@google.com,
 tglx@linutronix.de, sboyd@kernel.org, anna-maria@linutronix.de,
 frederic@kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <877cbz9x8t.ffs@tglx> <20240829153725.4437-1-gianf.trad@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240829153725.4437-1-gianf.trad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 09:37, Gianfranco Trad wrote:
> improve timer_create failure message with strerror() function
> to give more information to the user.
> 
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> ---
>   tools/testing/selftests/timers/alarmtimer-suspend.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
> index ad52e608b88e..74acdb87d4f4 100644
> --- a/tools/testing/selftests/timers/alarmtimer-suspend.c
> +++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
> @@ -28,6 +28,7 @@
>   #include <signal.h>
>   #include <stdlib.h>
>   #include <pthread.h>
> +#include <errno.h>
>   #include "../kselftest.h"
>   
>   #define CLOCK_REALTIME			0
> @@ -142,8 +143,8 @@ int main(void)
>   
>   		alarmcount = 0;
>   		if (timer_create(alarm_clock_id, &se, &tm1) == -1) {
> -			printf("timer_create failed, %s unsupported?\n",
> -					clockstring(alarm_clock_id));
> +			printf("timer_create failed, %s unsupported?: %s\n",
> +					clockstring(alarm_clock_id), strerror(errno));
>   			break;
>   		}
>   

Jon, Does this look good to you? I can pick this up if you
okay with this change.

thanks,
-- Shuah



