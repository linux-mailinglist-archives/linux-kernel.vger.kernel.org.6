Return-Path: <linux-kernel+bounces-267314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3DA940FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD58A1F225DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3564198E81;
	Tue, 30 Jul 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COjzhndK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976C40BF2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336709; cv=none; b=m0kxxt7skeypTN+bMaG4cc4rceNgC0o3kmoe422UqG0wtaJqYZCG12dAvr0Ulj0MW/JVNUy2760vCsEwluwjFkttZADqZ8u06MavRTXGbjqzy0sqaFPacWfjCv2k2LnSJJM4uFWSw0DcEjEyVfLjZE5Og5Ahpbb3xiMBaf1GrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336709; c=relaxed/simple;
	bh=NVy6RN9UJ7x5SUNJVs+jH2G33Zl5cTJuJ6ZUmdQRBlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtXvcyzyjTKmy1/UDVmrDArkH/mTkfH9PfbXm+MekI+jKKNnoo9SU0cijnB/fo62tAplyCpvceO+k5qIyngkzu7aaHlCg+wvcEJ9phSUxp82KpAFlFQhslY/gbJ5M+HXKiZRAkgSb4IpB0HmJZh03O228s5nRTSN0yabwm+YYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COjzhndK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722336706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hB8Q6mu68koU2jQoQEu66GSXIlhsKY8wiFrY5lywKE=;
	b=COjzhndKyzwuE9kkx8Wm4eS8taIz4ac1TytKTcBsLhsErBQzAp9t94YCvUF0bfCxJdFtRc
	7Lpmc4eEd4hotMFkZHtf5ybh7+rZbWOVJC2xo/pTP45o8KkWY1wkESSAKLSyBaRjEmK8tX
	XVjnE/9OaOkHTG6gS0MPKGfRu1V/0iM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-s2SppXz8OhGkhg-K5teWvQ-1; Tue, 30 Jul 2024 06:51:44 -0400
X-MC-Unique: s2SppXz8OhGkhg-K5teWvQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3684636eb06so111200f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722336703; x=1722941503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hB8Q6mu68koU2jQoQEu66GSXIlhsKY8wiFrY5lywKE=;
        b=g9EpnZu68kUPi0ezuPST2m7U2E3GbE9VozkE1qBiq/LAntjyyk6wqTbjZhjqPgjXqv
         OTDXxrbfDvNoPU3fxE/Hetz0QukbaVSIDsm1RUX4YJgTPjq4PjtNw9Hb3l2C/QWAOvvT
         TXLPFWE5iZ2EpfyNvmMtK+HvKSO9nTCpNlRXH1+VR0/ePE+I0cK3ZfCMtLnJ0JdVy9rK
         86gzn9s5Sn6rwML378K8I5MdZrrm2AJIwodyE9wltQlce/YBXgNjLqJu3gIpIFs0itOi
         HlLVKe4vOmLO0mHMrBfSX46ORXYaSZi24t11kLAklg3mX9b0KDy4Pvaq4IMG1GF9ADw7
         tnhA==
X-Forwarded-Encrypted: i=1; AJvYcCU4IgiM1+TLzgtfPstDPvSPxmPO2G2eqZZsTNQh0eSl0VNdmSdP91/7FAAl55NiBfX4XpQom1kKof/sQKWnjEZAsGU9UdSGw7sbePmb
X-Gm-Message-State: AOJu0YyloER8wNiWRpHS+9X11n6jFW+b65U+8ZnijmX2usRw6oNA2EIp
	d9ZJuaJYdKnaD3wt9YewBAgBgRPbu2XkT1XgZwVv9p3DB/Vk95emnSWy4Qq0wJ2NQGI9WblM9dL
	ZrwaMhNeZUuBSAn/vci7rTENaY/57HnZtxzoDujjzcnc1QaV84W4uQILPdHUTMBhHKc1mtvNN
X-Received: by 2002:a05:600c:1c2a:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-4280542e12bmr73159275e9.1.1722336702744;
        Tue, 30 Jul 2024 03:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZaoR6bpS2N4mm+HmZ4X2wXHynNhoxBj3SH6BYXqnLt+gsQ3kywAuClBogEKuCnft44Z7HAg==
X-Received: by 2002:a05:600c:1c2a:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-4280542e12bmr73159135e9.1.1722336702196;
        Tue, 30 Jul 2024 03:51:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281fd617desm49917915e9.35.2024.07.30.03.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 03:51:41 -0700 (PDT)
Message-ID: <8c2835ed-9066-4adb-8f8b-f38416d97849@redhat.com>
Date: Tue, 30 Jul 2024 12:51:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net/selftests: TCP-AO selftests updates
To: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 04:12, Dmitry Safonov wrote:
> First 4 patches are more-or-less cleanups/preparations.
> 
> Patch 5 was sent to me/contributed off-list by Mohammad, who wants 32-bit
> kernels to run TCP-AO.
> 
> Patch 6 is a workaround/fix for slow VMs. Albeit, I can't reproduce
> the issue, but I hope it will fix netdev flakes for connect-deny-*
> tests.
> 
> And the biggest change is adding TCP-AO tracepoints to selftests.
> I think it's a good addition by the following reasons:
> - The related tracepoints are now tested;
> - It allows tcp-ao selftests to raise expectations on the kernel
>    behavior - up from the syscalls exit statuses + net counters.
> - Provides tracepoints usage samples.
> 
> As tracepoints are not a stable ABI, any kernel changes done to them
> will be reflected to the selftests, which also will allow users
> to see how to change their code. It's quite better than parsing dmesg
> (what BGP was doing pre-tracepoints, ugh).
> 
> Somewhat arguably, the code parses trace_pipe, rather than uses
> libtraceevent (which any sane user should do). The reason behind that is
> the same as for rt-netlink macros instead of libmnl: I'm trying
> to minimize the library dependencies of the selftests. And the
> performance of formatting text in kernel and parsing it again in a test
> is not critical.
> 
> Current output sample:
>> ok 73 Trace events matched expectations: 13 tcp_hash_md5_required[2] tcp_hash_md5_unexpected[4] tcp_hash_ao_required[3] tcp_ao_key_not_found[4]
> 
> Previously, tracepoints selftests were part of kernel tcp tracepoints
> submission [1], but since then the code was quite changed:
> - Now generic tracing setup is in lib/ftrace.c, separate from
>    lib/ftrace-tcp.c which utilizes TCP trace points. This separation
>    allows future selftests to trace non-TCP events, i.e. to find out
>    an skb's drop reason, which was useful in the creation of TCP-CLOSE
>    stress-test (not in this patch set, but used in attempt to reproduce
>    the issue from [2]).
> - Another change is that in the previous submission the trace events
>    where used only to detect unexpected TCP-AO/TCP-MD5 events. In this
>    version the selftests will fail if an expected trace event didn't
>    appear.
>    Let's see how reliable this is on the netdev bot - it obviously passes
>    on my testing, but potentially may require a temporary XFAIL patch
>    if it misbehaves on a slow VM.

It looks like this is not well digested by the CI, e.g.:

https://netdev.bots.linux.dev/flakes.html?tn-needle=tcp-ao

https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/705502/8-restore-ipv4/stdout

BTW wearing for a moment Cato the censor's shoes, I note that patch 1 && 
2 commit messages are quite more informal and less informative than the 
average;)

Thanks,

Paolo


