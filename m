Return-Path: <linux-kernel+bounces-305523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F86962FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239271C2531B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699181AAE06;
	Wed, 28 Aug 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="wl0HObTn"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E31A76D0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869496; cv=none; b=DiIlYgGLqIwpf+U9+MOc9x8A1tsRnqDX7+bzfl/AkdNOehKT8JV3FLxSoVPg+YikZNN1c6p9PrborCzdhQnjZIrCc4XUst/vqUO9A8zPLTzc3+v4MvswsOYt7vQjrwY8XQdmhZVqs90AFZy+IMlbYwrsY2gb50ys08donq5kbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869496; c=relaxed/simple;
	bh=2gAWEQbIiEQPDIMOzh5aqeZrPDne+KYoVNSi3V1bmcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChtwxfamFk9yMYGzLrRmBNyH+/zsqFEK+Ch61I0UIbxI4Mx3+lwdKSMb/6Ckfg/fuZy2KAO13Lc7GZ3PMkAAB0Y39vgMnJxR4CXW4ViRn5ImFgqApqBue2Lg49R/asC/Zr63X/6YS4lllQvPNaWuI6SMtta3Vz8Rl4TO8tOYWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=wl0HObTn; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724869492;
	bh=2gAWEQbIiEQPDIMOzh5aqeZrPDne+KYoVNSi3V1bmcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wl0HObTn6L9pUR5Wpvpsgm2H0PM9xB4V8nmb7hIoU/zivW5vr04aVCM5n+D6zXJp3
	 omUcJ+vK0ioOdNJNJcLl5x4TqCC+MSt+OLyTN61Hc2ugPVc/7qh1jtWtT7AUdrc84S
	 JAiREnQA4rjnE2IvIdA3fI2kRHTpF2sMnU0bpamqnpSpC0a30x8DSkX6NjsY6/B5Rj
	 Xhc3XUt85DRpcNZb11E4mW3ZV27MYNhXj/l0m0vygvj3UxtjoJyXFj6asBSakoJ48R
	 J2V0QAtJQjsg5hL+YpeNx/rYR4W+mx/1e3faSVYgYIUxJtKJY2/e+acJFf2gBYeipk
	 phLNdAL3cwXfg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WvCW800fxz1JFX;
	Wed, 28 Aug 2024 14:24:51 -0400 (EDT)
Message-ID: <48d61e8d-7a69-44ae-9c8a-846d76c5a4b4@efficios.com>
Date: Wed, 28 Aug 2024 14:24:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/6] lib: Implement find_{first,next,nth}_nor_bit,
 find_first_andnot_bit
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
 <20240823185946.418340-3-mathieu.desnoyers@efficios.com>
 <Zsjg1H_V8eq3-grK@yury-ThinkPad>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Zsjg1H_V8eq3-grK@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-23 21:19, Yury Norov wrote:

[...]
> 
> If it comes to v2, can you also add some sanity tests for the new API?

I don't mind extending existing tests to cover my new APIs, but
I could not find any selftests for the linux/find.h API within the
kernel tree. Am I missing something ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


