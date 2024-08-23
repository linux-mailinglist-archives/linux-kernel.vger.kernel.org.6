Return-Path: <linux-kernel+bounces-298206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C37195C3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBF01F23CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD438DCF;
	Fri, 23 Aug 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="K8z+O3fG"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B126AF6
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384434; cv=none; b=FiGZcomIskt1S4zjEErzCpkNU5V9uCeUtZWtJfhu7mgfitBhk1Kk624e/enAhLNSdtgbKH7Hu6Uwq/fZpjL53DgQqJvaANlZzSoK2yjDIEzxA/AxixpO5q8g/ZkU7Eh9mOfp5einM7u9RdH7VOLTRShLucll8SaGvcSMxoJ6KFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384434; c=relaxed/simple;
	bh=f3kOJ7lX0zMgyOxuQVffa8ST2KFfoJT1Ak3wu0VddrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amzGBslmPuAfWR91DB8HETZ6NKKmmQH8H4h8Tr0s+ilMNv95sNeFiT8yRv+56T1CieWU4OGcX6w5O5lhKOB+Om8JWmWpsuayVphJt6Nt24BacUHkwYCQhjlzdkQOXxzMNq0bANgCig+oS1FgFziMAvdbBY5EeKVSUH6zzoTp96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=K8z+O3fG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd835872ceso1086365a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724384431; x=1724989231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vh9WXGVq8zlfvYzemN2H3DzqlKQwLkBmAliql80JqrM=;
        b=K8z+O3fGpuWdepstCK7UtcRN3iQr0pqE2gcEYpwsz6nSV4fmDyLe+v5aOeVlfB2SkR
         15FSC/YKcjVyHb419I/cEeQkM4tvBe2OLT99GDmlWAIhnaCcJqx56Hybjap3pIa0T/A1
         0APub2Pl0RKDPkbLzHFw7TLP23pakS4DgEkAEWnQIgiXPQAdx6gvrR0lOlDS8c+F9Jhm
         FGQQKWg45jN3Mw64m5qX4CWG2f8KnouPgmtnjJRSviMaJpTaJ5ACo04L6pPQT/tn8lND
         hDBsgfIxDcLUGeUxkQBXdbPKxMoGAUauN8DlTkySny5rR3vn095B4lXrkIG6ald5+E8H
         m1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724384431; x=1724989231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh9WXGVq8zlfvYzemN2H3DzqlKQwLkBmAliql80JqrM=;
        b=u0IeTOLFL6ldb1DvwB1gQeM0Z4ZGmLSB2OyaScV9BZsaBR6nVibZxpMkTgEy26+lrM
         ccmrmzu2VtelFgW73IvNc2ytDPOS02/Zba9uqf0i/dFqHcdQZt9brc8uHsg0QZ2kSvsY
         JEPVDdXde9dD0dLMBDM43WWqfNpLCSq46ilPCXVs9kYnsFFSBuMTCwn5WfENGIYp8WMo
         mUzrs0qocPMjkthpKojw1ucll+q5CbbrQokCTN86tUAnU9r72MiB0k8PtVY0XOiowq7s
         vfB5rNVsQaDJjX4yM2rs0pxrJimJmyWIqSoA4QqtfKK2yPIZq0sbnXpre6tj9xFu0k9B
         zErQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCO5Ut6Ngco7t6pHih7kRARCLkyNhOS2UfBvcFagv4D2BuE4uT4C7Du/OdfcXgXyu2eRvSgVa731xDm88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZkE02Yeip6pB8xhs0IRNALJXdyk4WjnE4U60JtIWZSE5Avvn
	ZbYqRH5WdhUYQ4Pyi0xJVFUy6UljjyxO88Xk892N9ibWaNgcVnjyteTuSA6M5os=
X-Google-Smtp-Source: AGHT+IFO/e2H5YxMGRq3iiamQd7NKDJuJJs9D5MHqCgujXtrCkez2v9MHX2Pty/S5mCn6CugibIbNQ==
X-Received: by 2002:a17:902:da81:b0:1fc:4f9b:6055 with SMTP id d9443c01a7336-2039e4a9686mr7815365ad.1.1724384431264;
        Thu, 22 Aug 2024 20:40:31 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:32df:35ec:8dbd:978c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dd2d7sm19756945ad.169.2024.08.22.20.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 20:40:29 -0700 (PDT)
Date: Thu, 22 Aug 2024 20:40:26 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: Re: [PATCH v2 0/3] perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
Message-ID: <ZsgEqrR6eux9kFcx@ghost>
References: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>

On Wed, Aug 07, 2024 at 05:02:39PM -0700, Charlie Jenkins wrote:
> Introduce a new perf ioctl key PERF_EVENT_IOC_INC_EVENT_LIMIT that
> functions the same as PERF_EVENT_IOC_REFRESH, except it does not
> immediately enable counters.
> 
> Also create a libperf API perf_evsel__refresh() to allow libperf users
> access to this ioctl key.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v2:
> - Drop discussion about signal race condition
> - Add new patch "libperf: Add perf_evsel__refresh() function"
> - This newly added patch was pulled from a different series with
>   modifications to fit the new ioctl key
> -
> https://lore.kernel.org/lkml/20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com/
> will be updated
> - Link to v1: https://lore.kernel.org/r/20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com
> 
> ---
> Charlie Jenkins (3):
>       perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
>       perf: Document PERF_EVENT_IOC_INC_EVENT_LIMIT
>       libperf: Add perf_evsel__refresh() function
> 
>  include/linux/perf_event.h               |  4 +--
>  include/uapi/linux/perf_event.h          |  1 +
>  kernel/events/core.c                     | 17 +++++++----
>  tools/include/uapi/linux/perf_event.h    |  1 +
>  tools/lib/perf/Documentation/libperf.txt |  2 ++
>  tools/lib/perf/evsel.c                   | 49 ++++++++++++++++++++++++++------
>  tools/lib/perf/include/perf/evsel.h      |  2 ++
>  tools/lib/perf/libperf.map               |  2 ++
>  tools/perf/design.txt                    |  5 ++++
>  9 files changed, 67 insertions(+), 16 deletions(-)
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240724-perf_set_event_limit-079f1b996376
> -- 
> - Charlie
> 

I am interested in people's opinion of this. Let me know if there are
any concerns.

- Charlie


