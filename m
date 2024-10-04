Return-Path: <linux-kernel+bounces-351318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCC3990FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106601C230A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8EA1D9581;
	Fri,  4 Oct 2024 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0M8f0LV"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1551ADFF8
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069489; cv=none; b=f2P9GAjOoH77ZmxnyAaBEMVeDfHsMFgH6VkWc3lYM16LJujsG93BSq93zqwUi3c1PWsyPn/1aJArGVN8xclMACt7TeALt1B6cW1BLEJirwqzYifw4U/3vwEAJsyjeCewSSev20cvy1ByY9oVchagjfUjPV3L1sOPKnNwQ8j2s0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069489; c=relaxed/simple;
	bh=KyeEmrzQylBVZDfxDKUZnWK3LBCkCw2ZY620hGxptlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ra/6EJKbKFQq98KwL64M7N913FJpEwGEKIZ+pnfoiuVenw9iGmSnSyKZrElRosDmm56oacR6T9IAJj5phcU4VPB+QZUD1Lqq5mVlHl73f2r7zfmqxnloASiy2o2TgCgcUNcn6mDy7UhGe79bMungiAWL61mvprOYRuu5JwGuGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0M8f0LV; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a34460a45eso10753565ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728069486; x=1728674286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LJD76lhD707G4f26nY61nNlzEda+AqjbskhX+VJBtc=;
        b=N0M8f0LVhzTojCAjEOqnHkJAvZznCCZr+BZS5vBZiXHLFoygTl60eleKqLtENKpQxw
         FOz/SPCx1EKzzveEGAgAyMwXHExwUJEy0enigoVErC8hdn1I666ntUWwZWWAQhH43/X/
         Ye6Ays0BHKwORyAEZZWinb0nxRCay3Tiguszw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069486; x=1728674286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LJD76lhD707G4f26nY61nNlzEda+AqjbskhX+VJBtc=;
        b=amkgRQB5UDeUVqmrTNR/qecyz1or/ljp50pvxuphrnO8ysZR/NdOel2mAnIpPjaGiD
         DT03us6ekfh2mFC33Mw73ydEqpmLMNp/CoN5UBfJ3o/zdxAlYcbJR5nJn9OueD/WxJuM
         w7oDaSzVdz4AWtQ4r1fcabU0r+964fNJJkgglLOIkNx10RnAOJBN4MtlwXsSQlkKY9cu
         K4u/pY1GeCeDS7d9y+lJFd0+OyQuREGv8H+fIwp3xiXl4T3j4M0nRzC58h4oFEco81ul
         d2HH6L+YAJzYr8cbs51bS2hOie74+ThTuzQsfr0KrUX38wLD4ERPt20EZXdGvFQFGhTL
         DEGw==
X-Gm-Message-State: AOJu0Yyp7EofFJh7lHv/TRr3A1fRCTxqDxpNS7oo0SQrAI6wX9942wgl
	JJqDoHEdn1ynew7cAkz2xQb2JImhqBN42daIZ04ZoBl/kheJBHjl99Txvx/tps0=
X-Google-Smtp-Source: AGHT+IEabOnywouz+afhl7zDZ60qyWjzIhnCh8thJ1n2TeQQs2Cqj71Wh+0oF5hD5AzJMXTHY24ITg==
X-Received: by 2002:a05:6e02:1aa7:b0:3a0:b631:76d4 with SMTP id e9e14a558f8ab-3a375978be3mr38858165ab.1.1728069485722;
        Fri, 04 Oct 2024 12:18:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a868923sm950375ab.70.2024.10.04.12.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 12:18:05 -0700 (PDT)
Message-ID: <01153485-ea70-47f7-ab6b-2c17496ab8ff@linuxfoundation.org>
Date: Fri, 4 Oct 2024 13:18:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] selftests/rseq: Fix mm_cid test failure
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004004439.1673801-1-mathieu.desnoyers@efficios.com>
 <20241004004439.1673801-3-mathieu.desnoyers@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241004004439.1673801-3-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 18:44, Mathieu Desnoyers wrote:
> Adapt the rseq.c/rseq.h code to follow GNU C library changes introduced by:
> 
> commit 2e456ccf0c34 ("Linux: Make __rseq_size useful for feature detection (bug 31965)")
> 
> Without this fix, rseq selftests for mm_cid fail:
> 
> ./run_param_test.sh
> Default parameters
> Running test spinlock
> Running compare-twice test spinlock
> Running mm_cid test spinlock
> Error: cpu id getter unavailable
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> CC: Carlos O'Donell <carlos@redhat.com>
> CC: Florian Weimer <fweimer@redhat.com>
> ---
>   tools/testing/selftests/rseq/rseq.c | 109 +++++++++++++++++++---------
>   tools/testing/selftests/rseq/rseq.h |  10 +--
>   2 files changed, 76 insertions(+), 43 deletions(-)
> 

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Peter, Ingo - let me know if you plan to take this through
one of your trees. Otherwise I will pick it up.

thanks,
-- Shuah


