Return-Path: <linux-kernel+bounces-566353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB268A676BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BCD16BA99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6FD20DD59;
	Tue, 18 Mar 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIvnBrBs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A315AF6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309241; cv=none; b=DwYn1KNnGEjkwBSjNXDE2kBwq5mHN5Eh1ag002+b5YN8Q4kRRm068QkMB52zmEolPOQlPg7BUp6eupQ2vCI+7BsPT39YLwIgiNtdr0bJVOhFOinbZoxQfXExk2hFFfg8QrUwUvGrv7yJSM0LG6wkW80kpJz1fCsrhLneOfcs1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309241; c=relaxed/simple;
	bh=2igutHsuDhyuqY+mS9Se6RVpng7XykRfcC0cv+45kv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNpBPMfTxwHNHF1UNctHhuScO6YClIq43QbVXJGBDnfAUbR7iUgsK+59rEKWUTUbpjZ7oX1OGfle5BQTOPSOzUo+20rIrp4CF6S1vNj5rXF1ED7BY69H4LAMaIIe6apCGDw919MpqBoO9pgdTAE7NP9xsAzwLg1xq3x9f46Zjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIvnBrBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742309238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7O+pdl8v8v7EK7Wkd4nKpzLh6vnro4c8ShYrpyfa7w=;
	b=KIvnBrBsOAbY85vnZzsxPAezI8NCCiBDjU4rxP1OuvbYiuHHnbUHWZ6z/tims3QSQqTYs5
	0ygjLle4BLLS75WhpabkFro5WI31LWgfD/5vw0PRFWSV2wZMJyQMOYwSaLn5dnzci7RZKG
	sRl2a43yfny+nOywFvNv76/n4h/6qeg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-S2dRrSekNlWMmw9gyTmySA-1; Tue, 18 Mar 2025 10:47:16 -0400
X-MC-Unique: S2dRrSekNlWMmw9gyTmySA-1
X-Mimecast-MFC-AGG-ID: S2dRrSekNlWMmw9gyTmySA_1742309236
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912aab7a36so2458075f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309235; x=1742914035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7O+pdl8v8v7EK7Wkd4nKpzLh6vnro4c8ShYrpyfa7w=;
        b=YsCAxkXujTBfHKvjI5wNsQamk+fKDVSizJT1gQd+xcrMDZMZ2ySL97/SbkFW+phcQN
         +7Qi8M9vMPudHQJGHX7uOH3HRqWNmH51eGvcb6o9/HIgni1hkjNj5ayrR1UyIKH9TG26
         Rlosyug20BjJqcnR0zfCAnW7m0yvTVGKZovuEXr5Kza6Wef4Fo9+XIde/pkhSd7GbETz
         NNaK17BFRg5RYdlilX/HElW+f0W1T2GgcFiQ/FyxFcWAyHVlWMmfuSoUOJrdHS0mZ1lc
         8yVE5HYhHSEXSSC5qYlWREnzL50TyJMadGTDDnSUCZRekOHA7W4PUhH03E0GOiYB+mHl
         EBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTvcrEMoTxamj2sls9+iu62fMbQgaJHjsAjMhZRQ/XBOQwicuPAb42o6SkcPRhsvbLUtKF53CkbL6NmGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCltYF5u+/L01F8OOp0hMOQ0D+yfyXn16TqrK48xXKzJlQGTwS
	Sv7r7K+1UdxN0ehN9Zgx0zZJ3w9kM9DTdnrAqFuIAHEbt91q7VLvV/VhsWbzfM9+qYRXQK4GE2l
	dPB6WipBmHAby9Eu4CONoucDWYdERG45dIsh/VKIH06vVqhCaoND/gLJvrE+n+Q==
X-Gm-Gg: ASbGncuZbnay1eEQeaQwSryCmbhaDX3vdwIkBSJ4nPAa1o4xvYyXfgkEp323ckxMGDG
	wU84ZpJaS7MCeiuS/IXsRmYGnJjmgYNFbR2h/eqV+BK/KPKbEDgbCHgOBg1uX3j99hDduLYBLab
	gEKwtxfcIuOb7ADs/gtmbmODHH0Q5H/fktxThGc/G5iLmwWh3vi9EtHvhzMSD4xjBHvx7Iq0YW7
	Xu2SBslT1nG+nknkMgLq6v1vvRyYZE4Dm6G9hQG41gvWEEHWuw/vYdUtY78Hk/mWPIYj1kZF5M2
	Bmzx6fPUOChNjKKD6k+jJ3LP6hjh/24QEWIVq7U7zzBVbg==
X-Received: by 2002:adf:a197:0:b0:390:f6cd:c89f with SMTP id ffacd0b85a97d-39720398c12mr13493656f8f.53.1742309235535;
        Tue, 18 Mar 2025 07:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1+6DV1Pcv1e0dGpotv5cbfi8peLombI/S233B67fHsuG9MRleiVbauAu9kTexCe5GwpJbpg==
X-Received: by 2002:adf:a197:0:b0:390:f6cd:c89f with SMTP id ffacd0b85a97d-39720398c12mr13493607f8f.53.1742309234992;
        Tue, 18 Mar 2025 07:47:14 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40fa30sm18491849f8f.68.2025.03.18.07.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:47:14 -0700 (PDT)
Message-ID: <a360fcbc-19e5-4ee6-9b80-2621fefd9ad6@redhat.com>
Date: Tue, 18 Mar 2025 15:47:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/7] selftests/net: Add mixed select()+polling mode to
 TCP-AO tests
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
 <20250312-tcp-ao-selftests-polling-v1-4-72a642b855d5@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-4-72a642b855d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 10:10 AM, Dmitry Safonov wrote:
> Currently, tcp_ao tests have two timeouts: TEST_RETRANSMIT_SEC and
> TEST_TIMEOUT_SEC [by default 1 and 5 seconds]. The first one,
> TEST_RETRANSMIT_SEC is used for operations that are expected to succeed
> in order for a test to pass. It is usually not consumed and exists only
> to avoid indefinite test run if the operation didn't complete.
> The second one, TEST_RETRANSMIT_SEC exists for the tests that checking
> operations, that are expected to fail/timeout. It is shorter as it is
> fully consumed, with an expectation that if operation didn't succeed
> during that period, it will timeout. And the related test that expects
> the timeout is passing. The actual operation failure is then
> cross-verified by other means like counters checks.
> 
> The issue with TEST_RETRANSMIT_SEC timeout is that 1 second is the exact
> initial TCP timeout. So, in case the initial segment gets lost (quite
> unlikely on local veth interface between two net namespaces, yet happens
> in slow VMs), the retransmission never happens and as a result, the test
> is not actually testing the functionality. Which in the end fails
> counters checks.
> 
> As I want tcp_ao selftests to be fast and finishing in a reasonable
> amount of time on manual run, I didn't consider increasing
> TEST_RETRANSMIT_SEC.
> 
> Rather, initially, BPF_SOCK_OPS_TIMEOUT_INIT looked promising as a lever
> to make the initial TCP timeout shorter. But as it's not a socket bpf
> attached thing, but sock_ops (attaches to cgroups), the selftests would
> have to use libbpf, which I wanted to avoid if not absolutely required.
> 
> Instead, use a mixed select() and counters polling mode with the longer
> TEST_TIMEOUT_SEC timeout to detect running-away failed tests. It
> actually not only allows losing segments and succeeding after
> the previous TEST_RETRANSMIT_SEC timeout was consumed, but makes
> the tests expecting timeout/failure pass faster.
> 
> The only test case taking longer (TEST_TIMEOUT_SEC) now is connect-deny
> "wrong snd id", which checks for no key on SYN-ACK for which there is no
> counter in the kernel (see tcp_make_synack()). Yet it can be speed up
> by poking skpair from the trace event (see trace_tcp_ao_synack_no_key).
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20241205070656.6ef344d7@kernel.org/
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Could you please provide a suitable Fixes tag here?

Also given a good slices of the patches here are refactor, I think the
whole series could land on net-next - so that we avoid putting a bit of
stuff in the last 6.14-net PR - WDYT?

Thanks,

Paolo


