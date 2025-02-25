Return-Path: <linux-kernel+bounces-530524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C037A434CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177F916FEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791C3254856;
	Tue, 25 Feb 2025 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gkw2BujI"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0436124
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740462470; cv=none; b=kFiwmiDornlIWZfO0EfpeHuBgJC5kdnwqvQq1IQP5aB0ZIW6th8i6Apiews29XT5ZLWjp0/qUambqW3WBNcbFEnzXhRB/nocceOEfvEfHcNbGGxN08KqhsipME68VfYkiCcvovjzilbZqVz+J271390+oznJx0a+L8+0oXzPeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740462470; c=relaxed/simple;
	bh=NvoYsgUp5d6NpDXCb8qxI57ENMzFAXlczNdVparJ6oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N29qjHEiFYlgxwGXpox/iKq0D1u8pb7hrw/r+LWDLftqCnzUMFRh/JI+KYoM5zSSTyTqR4/Yexi4nnZ6qNGxAi/v8SWclet8fgzzfeHscj6uju40wS3dA7r8yxN0+yh5W5Hh1/hVZaGYwJ65JReUrZNRTpwDfLFkSoRS4c1tIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gkw2BujI; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <edec731d-3370-46b8-baad-b8bf181bcce3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740462467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lewt0tJpzsq7kpEV1YECazH5tYD1TWvuXI8bOOxWE9g=;
	b=gkw2BujIsqajSKWK+ZB5Y3erHPkTIBnUpNFmJ1dv7pYI5U62rTeCNfZuXkzASsFtc1U1DN
	Fv9n4RnVwil36lV/vpEviv2J61rQFGnuDm++rZuxCT0pafO9thYP/2gw/Y6FQdSi+Z2Rvt
	3U5w9bMWFC2or8LlQdleRl3r7u4fN7Q=
Date: Tue, 25 Feb 2025 13:47:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 3/5] libbpf: Add libbpf_probe_bpf_kfunc API
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, chen.dylane@gmail.com,
 Tao Chen <dylane.chen@didiglobal.com>
References: <20250224165912.599068-1-chen.dylane@linux.dev>
 <20250224165912.599068-4-chen.dylane@linux.dev>
 <CAEf4BzYr9WzYbmyq8=nVETDqYvmYmObhD6x+_TQYpSUWxxGLLg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzYr9WzYbmyq8=nVETDqYvmYmObhD6x+_TQYpSUWxxGLLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/25 09:15, Andrii Nakryiko 写道:
> On Mon, Feb 24, 2025 at 9:02 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
>> used to test the availability of the different eBPF kfuncs on the
>> current system.
>>
>> Cc: Tao Chen <dylane.chen@didiglobal.com>
>> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
>> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.h        | 19 ++++++++++++-
>>   tools/lib/bpf/libbpf.map      |  1 +
>>   tools/lib/bpf/libbpf_probes.c | 51 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 70 insertions(+), 1 deletion(-)
>>
> 
> [...]
> 
>> +       buf[0] = '\0';
>> +       ret = probe_prog_load(prog_type, insns, insn_cnt, btf_fd >= 0 ? fd_array : NULL,
>> +                             buf, sizeof(buf));
>> +       if (ret < 0)
>> +               return libbpf_err(ret);
>> +
>> +       if (ret > 0)
>> +               return 1; /* assume supported */
>> +
>> +       /* If BPF verifier recognizes BPF kfunc but it's not supported for
>> +        * given BPF program type, it will emit "calling kernel function
>> +        * <name> is not allowed". If the kfunc id is invalid,
>> +        * it will emit "kernel btf_id <id> is not a function". If BTF fd
>> +        * invalid in module BTF, it will emit "invalid module BTF fd specified" or
>> +        * "negative offset disallowed for kernel module function call". If
>> +        * kfunc prog not dev buound, it will emit "metadata kfuncs require
>> +        * device-bound program".
>> +        */
>> +       if (strstr(buf, "not allowed") || strstr(buf, "not a function") ||
>> +          strstr(buf, "invalid module BTF fd") ||
> 
> why is invalid module BTF FD not an error (negative return)?
> 
>> +          strstr(buf, "negative offset disallowed") ||
>> +          strstr(buf, "device-bound program"))
>> +               return 0;
>> +
>> +       return 1;
>> +}
>> +
>>   int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>>                              const void *opts)
>>   {
>> --
>> 2.43.0
>>

In probe_prog_load, err will be checked and converted into either 0 or 1.

-- 
Best Regards
Tao Chen

