Return-Path: <linux-kernel+bounces-198436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB68D782D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD9B1C2091C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C356277F32;
	Sun,  2 Jun 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWjQ9pVN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CD20DF7
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717361258; cv=none; b=EKWRfjbasMZdVszEw5+8Bl4ZiMVMWsJVCQFB1GNTR/uJsbRqWmm8rGP5hQYwxGk6UeO83iA0l7tWaIGbB+m+1fqJ7jKVg7Q5MNnquw3j5tqVfnQPVSIVr/5LTEwvONONpGEee1pQLmDh8pfxYePgQB3JNOdIpIcAfSOAJBlp7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717361258; c=relaxed/simple;
	bh=zGxnj9cPkR7CN59vRwgIWsvFPmeqrcWRYugiGmLy2Fw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X6+h5utgP3s+SVE3ivRDaJwknknu65DsrqBCu+lk+ovOOqMhe8PwZ+DVPhAOzxog8qFhpEkQW3y4zFSmU/SlDQBmNNyIg6+NXT1OqYKle4QfJtwTuWLApnkpYbR86e6nRqQN5V8YVZ6+02uKB8/l2JIwY9wjy6HDabm7xRBiFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWjQ9pVN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f61742a024so192525ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717361256; x=1717966056; darn=vger.kernel.org;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faX60ecICkYxHjtv7PonXRM66RWfo/WBRMB+odShUo8=;
        b=YWjQ9pVN02mN/Zp9lXwTs9wKyQ+MRUlBdtUe/T4NBsyCW2MIt2YC806/nsL0uqzMER
         34S9/F2pO3PHw5ptJ6+ghRdy9wJ1mmUCGI9RLkzoBj2f9vZ9TOLoaY86aVEIwQP/fKK2
         cxt0L9GLWOov8zjyb1ZXY9ZEOkuhoHrggUasv+zcUjotPOzkqHumN1eu5k+6hkVsJaZ1
         P5xrKi48SG53xSafoA+V60P9BIOd1WWBwF1WgwD4YuFCsccXPEu+GWEmftCDKkDxJLv5
         8mcWIXXTfZuL+J/VwQhWbxe+7fdXcBG1qq9r3ieJJs7Bl+WhHcocE9IZ24goqCzoq6Dt
         iOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717361256; x=1717966056;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faX60ecICkYxHjtv7PonXRM66RWfo/WBRMB+odShUo8=;
        b=r8tQ7K0NyBnKgoEAmN+InfoYmDcP7YdwrzIvpHHuYtiMJH/vY5EHFlXvi2LpwlNwU5
         zPbwpz4UHMxIjiPdVyoSwQlT9yqzsqaxAHPpQ8uVOGTn1DF12qpkmtanCGKb4j/+GLQm
         NpsfarRR2/Gzr3f1YNJf8MLxP3gQzOHswhLMwk+yvWHnFRQgFlv63K8g30svNJQmGAaM
         pBmhH4OFWXDp+QAEvt8uyX2M4TOWSn8QVZPv5XdCI4bY/DMcj/tVrVY8NIBH3hJRONem
         0UlQI5GB5x1bFQibGexak66HPvfD6U9qyHlXlDS+kXQ1xNusTDGKfi4stmPtJJ5p0IbT
         /ZLA==
X-Forwarded-Encrypted: i=1; AJvYcCUs7fWUibAAAZ4z8qEmjx0vAWo6qY5uVz+TLNJlxHsg8n8Sx5MjWJqBMe0oGBsTbR8m0ItQH1NrwY0r21ni41xk6+nD/1CrlsYLBhw9
X-Gm-Message-State: AOJu0YxJvyDGuzth7FOoKrpAY1nQ6fUlpSCiKYZr8Wf1NGpCS3G6CmX8
	2kBHz0PmY9tSB18vmkzqkiXT7vn7uji3JaccUpHdRcSMQCTqLd9n5ZDLQMZTLw==
X-Google-Smtp-Source: AGHT+IHAcKXBQFsPDQM4NMHbQr6pqvh0k2z/Yyd2cS2NVZFKE2pPvtyCt3fAEKic6duvJwDcVFm13g==
X-Received: by 2002:a17:902:d2ca:b0:1f6:7fce:5684 with SMTP id d9443c01a7336-1f67fce5889mr178905ad.3.1717361255487;
        Sun, 02 Jun 2024 13:47:35 -0700 (PDT)
Received: from [2620:0:1008:15:abfd:526b:c7dd:75a1] ([2620:0:1008:15:abfd:526b:c7dd:75a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6324032f9sm51317705ad.242.2024.06.02.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:47:34 -0700 (PDT)
Date: Sun, 2 Jun 2024 13:47:34 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>, 
    Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Andrii Nakryiko <andrii@kernel.org>, 
    "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
    Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, 
    Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, bpf@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] static key support for error injection
 functions
In-Reply-To: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
Message-ID: <71ebaa45-dbd0-b39d-4b33-88da3f497297@google.com>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="2003064516-301007669-1717361061=:1421375"
Content-ID: <32fac6fa-e3d4-f025-6ec2-7b80eb8e0bc1@google.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003064516-301007669-1717361061=:1421375
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <985832d3-71c9-2701-ec5d-29c3bfccabf1@google.com>

On Fri, 31 May 2024, Vlastimil Babka wrote:

> Patches 3 and 4 implement the static keys for the two mm fault injection
> sites in slab and page allocators. For a quick demonstration I've run a
> VM and the simple test from [1] that stresses the slab allocator and got
> this time before the series:
> 
> real    0m8.349s
> user    0m0.694s
> sys     0m7.648s
> 
> with perf showing
> 
>    0.61%  nonexistent  [kernel.kallsyms]  [k] should_failslab.constprop.0
>    0.00%  nonexistent  [kernel.kallsyms]  [k] should_fail_alloc_page                                                                                                                                                                                        ▒
> 
> And after the series
> 
> real    0m7.924s
> user    0m0.727s
> sys     0m7.191s
> 
> and the functions gone from perf report.
> 

Impressive results that will no doubt be a win for kernels that enable 
these options.

Both CONFIG_FAILSLAB and CONFIG_FAIL_PAGE_ALLOC go out of their way to 
have no overhead, both in performance and kernel text overhead, when the 
.config options are disabled.

Do we have any insight into the distros or users that enable either of 
these options and are expecting optimal performance?  I would have assumed 
that while CONFIG_FAULT_INJECTION may be enabled that any users who would 
care deeply about this would have disabled both of these debug options.

> There might be other such fault injection callsites in hotpaths of other
> subsystems but I didn't search for them at this point.
> 
> [1] https://lore.kernel.org/all/6d5bb852-8703-4abf-a52b-90816bccbd7f@suse.cz/
> [2] https://lore.kernel.org/all/3j5d3p22ssv7xoaghzraa7crcfih3h2qqjlhmjppbp6f42pg2t@kg7qoicog5ye/
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Vlastimil Babka (4):
>       fault-inject: add support for static keys around fault injection sites
>       error-injection: support static keys around injectable functions
>       mm, slab: add static key for should_failslab()
>       mm, page_alloc: add static key for should_fail_alloc_page()
> 
>  include/asm-generic/error-injection.h | 13 ++++++++++-
>  include/asm-generic/vmlinux.lds.h     |  2 +-
>  include/linux/error-injection.h       |  9 +++++---
>  include/linux/fault-inject.h          |  7 +++++-
>  kernel/fail_function.c                | 22 +++++++++++++++---
>  lib/error-inject.c                    |  6 ++++-
>  lib/fault-inject.c                    | 43 ++++++++++++++++++++++++++++++++++-
>  mm/fail_page_alloc.c                  |  3 ++-
>  mm/failslab.c                         |  2 +-
>  mm/internal.h                         |  2 ++
>  mm/page_alloc.c                       | 11 ++++++---
>  mm/slab.h                             |  3 +++
>  mm/slub.c                             | 10 +++++---
>  13 files changed, 114 insertions(+), 19 deletions(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240530-fault-injection-statickeys-66b7222e91b7
> 
> Best regards,
> -- 
> Vlastimil Babka <vbabka@suse.cz>
> 
> 
--2003064516-301007669-1717361061=:1421375--

