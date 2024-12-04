Return-Path: <linux-kernel+bounces-430903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C499E36FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CE02875E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070261AC427;
	Wed,  4 Dec 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkNNj1kJ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DC1A0B07
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306418; cv=none; b=cFwWF3H0Z6PXjS9GmsGjgCF2bTWIYK/5D0+ikWWuFENwRMrnHDjnvf1WxpJyjyvgoVNeulvyLqLQZS+LAvvddgu3x6/S/gf5xpi1hUUpWpF/HtTQ4IgCas9VQlnvdnLwl0zBj4EkaCfftD23dyWReWU+KhqHhdIathQe98wnakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306418; c=relaxed/simple;
	bh=gmTWp42uVpMYzw60S7pepILZWkU0vYie0Bkl0Evppjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLWOICpM8t8qkga3CIPQw0gjlUDoPKU0+mytW/H/xWFjZ3MhHHBuvz3vQUR6sdUKL2wLGI3rZTRuLvk8oN+nhbjgVEC0SvrBQU1miUAu2f793bpQumH/PQKP9ZyeWoww0rdzgdillueVvY2fsioxVUOucQqisFEM9MUmQ3OTJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bkNNj1kJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e2c52c21so2842546f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733306415; x=1733911215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ct6TiWILSfI4o4NLd8e+Uh155SuDdxolQSAG0h83St8=;
        b=bkNNj1kJ7Hyev2lAS0sGbRDA5mQGkWyDjOOxhoU1rUz7megc5lq3BBO4O5dCcBFjJ/
         C2UlOlJHLh66GU5G46eyX6rP8+DG2ynOfT9ryYlI04a3XLd43rxcmS2fKvD6ki7t/0jX
         ezZqihIDfNf7w7qQdrZxub7o122DqnAzz7fC7IBqV24z2zLH8r3x5OmT1nMnl6VOhkzi
         rUPhSzesB8DZi5mU3rQRiM+RySIUzGi90ohz9SOV8zRnQKUTGQaC/wZtkJvquk3/siFE
         nkcV86SvPdT80moFwuPPQ0BSbIjf/4PkrZVlIQoLaj81PaXDy+ZgraQbkaiLwTDy9R3L
         zVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306415; x=1733911215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ct6TiWILSfI4o4NLd8e+Uh155SuDdxolQSAG0h83St8=;
        b=Bt18kMJeyli/anC4Vnx2KabbiYnKUizoS779wWBeWx+/gThthnws5Ih3TJkoR0VpEc
         dQHXcp5qmnfpzH6ue1N/zZqTI5BaPjIwU4sGKaXxuGZp9JQf55g/CPjdpER1kb78euHk
         rQr+GUlP/uXEBh6FixGQOzBumuP6ZIG60I0AbeeT6YLAKBc5BjFdcbLHN2p3wKm/7MgW
         jb8JtVOd3kbSwSMDur3MHOF4ko6Jn4wYUWqGLvEjqseVhLJ0VlJFk1SZFHE0eDf8ag++
         LkYyQKUsvHDEC9yQh89SRqQ9XfqO4sYvpyFAzGKfTbAsFl/+DuHVGnKsa+vDM9naPBmO
         u/sg==
X-Forwarded-Encrypted: i=1; AJvYcCWlD0DWMTSqLbWNPAdY+OQn3egVGXymlwnAjXm4vTf1KbwunO/JqIP5l2rWJUDVyKWepaXZnnRw2XdYjH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgOcu6nVHTigT+weAsGcMBosJ7HBh55F5wfErUZm/X/RfAR5R
	9R0cArdQrzmz/n9oSuWKggDDYD4pctne1j5KH8m2lsrdxUDoNqHS3wTW3o/yWcI=
X-Gm-Gg: ASbGncutthcDDrGjW4fpzyz6zQUsEGbesGV8ibf72UDRnMK9po5mJ0L2nmP8jVozYbN
	KwyMPrexm7OjDCTxvebV97XXBo+eGJ6e3CBsNYyaCsghr30WogXsTMWhcEqP+NJ+xeQsj5dBX3d
	IohyMDe3gP2uE3XhM4PHZWKVbCvHm+E/GhOl/nQVtBmaSkY2LYLnza7gQp0GnIiP4SMJY6M4mmm
	LBpDFT1TiELDqQ5jsc/0IHDmtmJfO1BLpyUgVmFbrphfCtgq+CZuJVC5c/UNw==
X-Google-Smtp-Source: AGHT+IEcals9cWAl+b1w3YqlYSBEmA1VjlSI88V7L5ie0gT9yHjt9N2Z8yNkC7HYy7dX+eZU577mMA==
X-Received: by 2002:a5d:47cb:0:b0:385:fc32:1ec6 with SMTP id ffacd0b85a97d-385fd54d75emr4238048f8f.50.1733306415065;
        Wed, 04 Dec 2024 02:00:15 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d97ab259sm16081204f8f.95.2024.12.04.02.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 02:00:14 -0800 (PST)
Message-ID: <c470d6a9-8717-44ad-a713-70cf39ff87df@linaro.org>
Date: Wed, 4 Dec 2024 10:00:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 00/11] perf tools: Sync tools and kernel headers for
 v6.13
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20241203035349.1901262-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/12/2024 3:53 am, Namhyung Kim wrote:
> Hello,
> 
> I'll carry these changes on the perf tools tree to update perf tools to
> understand new syscalls and parameters.  You can refer to README file in
> the tools/include/uapi directory why it's needed.
> 
> Thanks,
> Namhyung
> 
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> Namhyung Kim (11):
>    tools headers: Sync uapi/drm/drm.h with the kernel sources
>    tools headers: Sync uapi/linux/perf_event.h with the kernel sources
>    tools headers: Sync uapi/linux/kvm.h with the kernel sources
>    tools headers: Sync x86 kvm and cpufeature headers with the kernel
>    tools headers: Sync arm64 kvm header with the kernel sources
>    tools headers: Sync *xattrat syscall changes with the kernel sources
>    tools headers: Sync uapi/asm-generic/mman.h with the kernel sources
>    tools headers: Sync uapi/linux/fcntl.h with the kernel sources
>    tools headers: Sync uapi/linux/mount.h with the kernel sources
>    tools headers: Sync uapi/linux/prctl.h with the kernel sources
>    perf tools: Fix build error on generated/fs_at_flags_array.c
> 
>   tools/arch/arm64/include/uapi/asm/kvm.h       |  6 +++++
>   tools/arch/x86/include/asm/cpufeatures.h      | 11 ++++++--
>   tools/arch/x86/include/uapi/asm/kvm.h         |  1 +
>   tools/include/uapi/asm-generic/mman.h         |  4 +++
>   tools/include/uapi/asm-generic/unistd.h       | 11 +++++++-
>   tools/include/uapi/drm/drm.h                  | 17 ++++++++++++
>   tools/include/uapi/linux/kvm.h                |  8 ++++++
>   tools/include/uapi/linux/perf_event.h         | 11 +++++++-
>   .../arch/mips/entry/syscalls/syscall_n64.tbl  |  4 +++
>   .../arch/powerpc/entry/syscalls/syscall.tbl   |  4 +++
>   .../perf/arch/s390/entry/syscalls/syscall.tbl |  4 +++
>   .../arch/x86/entry/syscalls/syscall_32.tbl    |  4 +++
>   .../arch/x86/entry/syscalls/syscall_64.tbl    |  4 +++
>   tools/perf/trace/beauty/fs_at_flags.sh        |  3 ++-
>   .../trace/beauty/include/uapi/linux/fcntl.h   |  5 +---
>   .../trace/beauty/include/uapi/linux/mount.h   | 14 ++++++++--
>   .../trace/beauty/include/uapi/linux/prctl.h   | 27 ++++++++++++++++++-
>   17 files changed, 126 insertions(+), 12 deletions(-)
> 


