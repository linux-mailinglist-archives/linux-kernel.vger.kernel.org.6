Return-Path: <linux-kernel+bounces-534749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5133EA46AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB443ADCFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8B4238D2E;
	Wed, 26 Feb 2025 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PrgrgjIB"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1920236A70
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597241; cv=none; b=UybwjdTYgLtnNOgMB4IIC6qzYxrLMENis+ddQEj59y4/lWljcDMAnXLVt9eNtQip6GfLYLe2bzmfV7MXHyq2a6wQje6dSAe1BT+5qrjcCrliYKnEvSf4wFbACdmwE8mzmkVdbcjZPYJupcMsxTaNWjPegiGaO9KiM1xwNOkjsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597241; c=relaxed/simple;
	bh=vHzrEzooH4K8CcIGUei7pRVS17MmHjHrMcmzZoer/Ec=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cSM7w6rX3KKFs8tEEXqTuA1ogIyFplPrcAtyyXjxUcKaoDTJwh4icq92CpM2KTS1Ka5wV0yXqGlkgBhdenebjovwphA9dn3XERGZZXy0cLLGMS2CkGiiG6vK9hy3EWdcVp16p2JBjMKIKJGrZ8bBJrQdbkYvp6IXOx7CYkl5ge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PrgrgjIB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471f4909650so1293041cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740597238; x=1741202038; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=PrgrgjIBDzFyuCW0/BkssmUrWr+ejDo9K2GOMxCGaRhnW6xhcbtTD1JwwVGKLo/83P
         3dM9rKUsAMq62CVpok1RfQHA2wfcnXMzJ18qMcZcYUdGiwaEKk+ikc6U0hO+hXP5eQ2E
         NyqwDG/QmtPKzQkkLdTGYwhvbp9CTaW2CN1tiR+JGk13bm+x5+rLq5IqlamFPgOFO8PM
         HjoHxNDXIv68a/z/4EiqGgLE/s9X5kBDvYWorhxzCCaJ/Ef6jGrbARuL5iiZvdsP0RaR
         Wk+ZOlH0gvpRUqepXN07eMUzObSySHsdNfhHZlo1wCex2FQyD78d2/r2De4OapeVF9iC
         RAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597238; x=1741202038;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=HfaIKtpOSPs9E3BfF7i8IEsBk7NGNGDG7bHzPPv9reO6iCspDC0bdNiuPRKVHjIdvo
         uSbzTNuTz4un/yCQPIUA6QMtJ6PpIIVpPr4SYLjxRz3XN+6LtR0bgrtY06a+WBoa4Wa4
         ss3/RkCYJ+Unu8GzVojPdIlBlliS4/j4NGzZ7Vs41XWjcdxZuRpypA718IPodUCh7Tv8
         uMDVN6sSQmRKUx4s9BsQMX5GgaSNqkWxsOdEdfKVjJgZ2GrMO8vZ98a2162NlWJNyo+z
         lib8wk0KucJikvKd6vTdrSbTUd2/GyWBqpvkQi2qVlV9I9PSIqMODi1OjCgUICJLNMfv
         qRPw==
X-Forwarded-Encrypted: i=1; AJvYcCUibs4NnAE4yI6eQziZjTrGwGEopas+nYNkntFQpwCIwwTuL+6a3XNYNZ4Ag051b4oWd3g+5Qtq02C63s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYV1WGcqYtF/8P/of8Z7KPbUumuuzizzdBE6vO7lBo/HT/kJ3v
	loLo2RMqSvg1xL70ljFw4/wPjlD7MY6aAAAdBzs9Vk4yVNldDvxNBXokfGlZYQ==
X-Gm-Gg: ASbGncsaKhnjOQ2ydYlCyyrxZI/XiMwUHJPTU3P+SkESIPpNFrLgnZM5wbd0e/0ys+D
	JxYZxHGkCjG1pphWUVv5dvTHDNrl2QY/mMdOePk6+3wIhXpQOPyeggkUDi5KJ0V2cB9DcJAbZWq
	Qkb8/auXS9DMo9GGI+ORKb1sRaOnpQqA5WH56HI/XcQ3Xlksz8ZgeV9XsDDA+8svBG+k/30iHfA
	bjuiV0Oc3Dgm/a0oVEDIOdlDgzMqNan0dkCprKPiy5vbomWmtS0k7FFBcGm+dhgjRtLrU0OA0K0
	LcWJqxxTINTQAhy7L3BXDfxlHtlMvX7ctcdLchdsQeefMdZaxzFKigUR/lq37lMgFGWQ4Ic=
X-Google-Smtp-Source: AGHT+IGZKQ763FRka4tXmeqX9uwcpJ0v96pIEchafXYFD2cwhU7ih42tfW2HHRWzr2HQKaEkzBO+qA==
X-Received: by 2002:a05:622a:1a07:b0:472:201c:aa45 with SMTP id d75a77b69052e-47377116ed2mr109013401cf.9.1740597237709;
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47377e1543csm28407591cf.27.2025.02.26.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Date: Wed, 26 Feb 2025 14:13:56 -0500
Message-ID: <41cb98ddf724ade0fc529b8c952f3efc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, jmorris@namei.org, serge@hallyn.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, luogengkun@huaweicloud.com
Subject: Re: [PATCH 1/2] perf: Remove unnecessary parameter of security check
References: <20241223070650.2810747-2-luogengkun@huaweicloud.com>
In-Reply-To: <20241223070650.2810747-2-luogengkun@huaweicloud.com>

On Dec 23, 2024 Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> 
> It seems that the attr parameter was never been used in security
> checks since it was first introduced by:
> 
> commit da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> 
> so remove it.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/events/intel/bts.c     |  2 +-
>  arch/x86/events/intel/core.c    |  2 +-
>  arch/x86/events/intel/p4.c      |  2 +-
>  drivers/perf/arm_spe_pmu.c      |  4 ++--
>  include/linux/lsm_hook_defs.h   |  2 +-
>  include/linux/perf_event.h      | 10 +++++-----
>  include/linux/security.h        |  5 ++---
>  kernel/events/core.c            | 14 +++++++-------
>  kernel/trace/trace_event_perf.c |  4 ++--
>  security/security.c             |  5 ++---
>  security/selinux/hooks.c        |  2 +-
>  11 files changed, 25 insertions(+), 27 deletions(-)

Now that we have Ingo's Reviewed-by, I've gone ahead and merged
patch 1/2 into lsm/dev, thanks everyone!

--
paul-moore.com

