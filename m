Return-Path: <linux-kernel+bounces-368661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D0A9A1317
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12ADB22F48
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CF6216A1A;
	Wed, 16 Oct 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bH9msgWp"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FAB2141B4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108831; cv=none; b=Rynz7ZZV7TTkjnKcgSTdhXavVdsMYM61V7tlbDrE0FDi6ieTaYGnDGXhKUWM4IM/ZPpAUZhgtwU+aVFW3KS09Mf4zuYgYvfr90jDm5pK/8pT2IbQFvNsYiTzF4Qhbmp4OxKoOpku2x2ZwcLHZ/SHRaOvGyVfp5JESWGkr/t1U/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108831; c=relaxed/simple;
	bh=GXWa88oli4PWmA5+fzUJhszGi/k7b0FRJFJ5Zof4XW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvIdAy5b3jjtRSMiPkbU0e/WxXhP9noeNWly0uUIULp1m/CzkxE8z2cqcR2AkQTh/y0mmB4L7ETmo2CIcLfF7HzdEwE5CQrmkI+0AmWtOiwsBZOsbLX3auDf8yuZi3CsvmW24MDLz1rRNmSWzOz7IQOe5rcv46dV9zxbnmfNK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bH9msgWp; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8323b555a6aso9026439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729108829; x=1729713629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PVXpXafwswvIYBcxSLxNIvr3U2zHo65AX9f3Pm1fo0=;
        b=bH9msgWpZgjmM5tcDOFe5xlK6iQ5HoiF8Elbmk3nLjD9EoLb1Sv++CRN/jByRQEgx8
         18gAemz9xd6Bh/9Nbr/8gH2vRskgxmrwInye065u39Ff3PRtnK5ItCwBRR1AnLlxFqoA
         EEeGLL8/cZy2otxIcm0E2EU91WADcx/iTtkzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729108829; x=1729713629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PVXpXafwswvIYBcxSLxNIvr3U2zHo65AX9f3Pm1fo0=;
        b=FdhddZPN0pCztpT+Bf1zhJgSPBz/a1bNbpyQny1VNQm6xonM9ee1NPt8C1lUvvBvrA
         QW7y8PjLYcTh4EqIkcdnPbqKbcBLc4BIa54LqRT8eieo2swgHS/In7yAk2qr+9cnXsJM
         nm1y1CpWKBWFnVZEg9HPOtNQHej8awy78IpKHMJ4zGZIQwAU9Dfz0MQlGBztsvkhVYDl
         9E+mvQKFqI3puSLQyoTrqjVwvZrHc6ZCe8lWldhGlaLdnVHvnm9ERdUCNV8V5C7v6fBl
         rYULsXwqM3PcC8jPA/t6VcrdNkSWF0rQ/ZVsSK8oWnLUadO7ZDkkriq5PuljfttqNN0d
         Xwrg==
X-Forwarded-Encrypted: i=1; AJvYcCXiig3ERQQcpQ2XoOnwp/jzyOePce9/1EEVN3ivEEw+YjsH7CzPyCC/Nv4smCpSG15dqnVQCs5KfcuiDQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64uy9nPnXSaHsh3sc4mNzfWTRnknkfYoK1Z+eBGPbk+hFW/gn
	iQubnpCFAgBtFBo743UXx6G8A/MdFJJzfzTF17zHy60AU5yoHkhgUtN4wxkvASI=
X-Google-Smtp-Source: AGHT+IFhemGMrTXm0sMyQyLUJ9gqBzqux5ju24bsXrdrLEcJKKlddo3PTMuUfwbHsZl+/lq10WstqQ==
X-Received: by 2002:a05:6602:6403:b0:837:7f69:eac2 with SMTP id ca18e2360f4ac-8379241ac0emr1848647239f.1.1729108829163;
        Wed, 16 Oct 2024 13:00:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc44a2asm981213173.154.2024.10.16.13.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 13:00:28 -0700 (PDT)
Message-ID: <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
Date: Wed, 16 Oct 2024 14:00:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/24 04:20, Lorenzo Stoakes wrote:
> Add tests to assert that PIDFD_SELF_* correctly refers to the current
> thread and process.
> 
> This is only practically meaningful to pidfd_send_signal() and
> pidfd_getfd(), but also explicitly test that we disallow this feature for
> setns() where it would make no sense.
> 
> We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
> theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.
> 
> We defer testing of mm-specific functionality which uses pidfd, namely
> process_madvise() and process_mrelease() to mm testing (though note the
> latter can not be sensibly tested as it would require the testing process
> to be dying).
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   tools/testing/selftests/pidfd/pidfd.h         |   8 +
>   .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
>   .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
>   tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
>   4 files changed, 224 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index 88d6830ee004..1640b711889b 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -50,6 +50,14 @@
>   #define PIDFD_NONBLOCK O_NONBLOCK
>   #endif
>   
> +/* System header file may not have this available. */
> +#ifndef PIDFD_SELF_THREAD
> +#define PIDFD_SELF_THREAD -100
> +#endif
> +#ifndef PIDFD_SELF_THREAD_GROUP
> +#define PIDFD_SELF_THREAD_GROUP -200
> +#endif
> +

As mentioned in my response to v1 patch:

kselftest has dependency on "make headers" and tests include
headers from linux/ directory

These local make it difficult to maintain these tests in the
longer term. Somebody has to go clean these up later.

The import will be fine and you can control that with -I flag in
the makefile. Remove these and try to get including linux/pidfd.h
working.

Please revise this patch to include the header file and remove
these local defines.

thanks,
-- Shuah

