Return-Path: <linux-kernel+bounces-554669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E1A59B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E0718887D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBAD2309A8;
	Mon, 10 Mar 2025 16:37:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D61C5D5C;
	Mon, 10 Mar 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624669; cv=none; b=MV7CL0dFKQ7BDHLldIuXE1/WVnTTq6nobV4bOzWxLAeBIFGqGpErawfsCVpovb1i9Nx2l27jASZtl4TJytENJSDPHlM5uiI5utyZtd2kh8IKRev46l6lXiQYoSYGoWYYvJo14tfp6wdXxfCnTgeqqVyb5qiSpViajlQ4skSt2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624669; c=relaxed/simple;
	bh=HEEmq9NpxnkYzQ46heoGLFXsrVON0GkI+r4j7PEdE0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roR8ZeNEjnIhP5jyNgvS9sq+X5lyhFpdfLzG2uHSFWmDgsQHgYMQQfxg4HlcmHKb2K3J+BeQiJ0fLSl6C+r+R4QjDe6YngtcedV6t55BSws9MxM3LhTgrrr+sxDonMmegyYX/fzH8fnks0MBVNQasv21QSg8H+QuFqrxbSXT3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2CCB1692;
	Mon, 10 Mar 2025 09:37:58 -0700 (PDT)
Received: from [10.57.39.43] (unknown [10.57.39.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99ADE3F5A1;
	Mon, 10 Mar 2025 09:37:45 -0700 (PDT)
Message-ID: <3f4354e7-e74b-4ce9-b0c7-4be103cbc94d@arm.com>
Date: Mon, 10 Mar 2025 16:37:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] coresight: etm: Add an attribute for updating
 buffer
Content-Language: en-GB
To: Leo Yan <leo.yan@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310104919.58816-1-leo.yan@arm.com>
 <20250310104919.58816-6-leo.yan@arm.com>
 <d8b1cf1f-1996-4d9c-9f1a-fad556f91577@arm.com>
 <20250310155015.GG9682@e132581.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250310155015.GG9682@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2025 15:50, Leo Yan wrote:
> On Mon, Mar 10, 2025 at 01:29:26PM +0000, Suzuki Kuruppassery Poulose wrote:
>> Hi Leo
>>
>> On 10/03/2025 10:49, Leo Yan wrote:
>>> Add an attribute for updating buffer when the AUX trace is paused.  And
>>> populate the value to the 'update_buf_on_pause' flag during the AUX
>>> setting up.
>>
>> Do we need this attribute in the uAPI ?
> 
> This uAPI allows users to perform AUX pause and resume without the long
> latency caused by copying hardware trace data.
> 
> E.g., a user can specify a large AUX buffer size using option "-m,128M".
> If the buffer is considered large enough to accommodate hardware trace
> data for a small program, the 'update_buf_on_pause' flag can be set to
> false, the copying will be deferred until the end of the perf session.
> 
> I am bias to keep this uAPI.  If you prefer to remove it, I am also
> fine with that.
> 
>> Could we do this by default for
>> sinks without interrupt ? This definitely improves the quality of trace
>> collected for such sinks and the driver can transparently do this.
> 
> How about we dynamically set the default flag in the Perf tool?
> 
> - If users set explictly the 'update_buf_on_pause' flag, then the
>    setting will be respected.
> - If users don't set the flag, perf tool detects it is TRBE sinks,
>    then it can set 'update_buf_on_pause' flag as false.

Not really possible. There could be systems with mixed sinks. e.g.  TRBE
for some CPU and ETR for others (say due to a non-functioning TRBE).

> - If users don't set the flag, perf tool detects it is ETF/ETB/ETR
>    sinks, it sets the flag as true.

And in the cases above, perf event cannot run on all the CPUs, because
some sinks don't support it.

Why do we need a flag, when the effect is not user (read, perf decoder)
  visible and at the same time improves some scenarios (read non-TRBE 
cases) ?

I would say, let the driver always update on pause, depending on the
sink.

Suzuki


> 
> Thanks,
> Leo


