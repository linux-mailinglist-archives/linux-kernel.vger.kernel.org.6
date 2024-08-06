Return-Path: <linux-kernel+bounces-276287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68329491B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C48B283306
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264ED1D2F48;
	Tue,  6 Aug 2024 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzWdXiHL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55A1D2797
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951477; cv=none; b=FGtzDHX1rZ/Cmht5RZIQuU0nS+WftlxNqUvPtVfhbj2/A5oj6GcOuFkCB8XU8pGh/TOaAQbTUMvSo5rynfGq1xO35PRqVUeG35oUiXslyUEQnj2igfxFUhoqb1x3gF3ODmqAhqVMUeRUQWKyt4h3r66Xw3ZqCOy1btaf72AM4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951477; c=relaxed/simple;
	bh=/hUlGB22mjDhClkWGWbAtFZwcWpV5C7a85rIvaKsS68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHNYI5jCddXeZSwQshVmpFmoH12a8c+kRnpTzjpK0KjTU7jnIb9eU2ntDIY2/K8UREmFvRw+Mc47OcACCT6jO3TwY/gn8O+kTmJ+a5AQfArBsn8cO6axBaDXd9MGRp/KTBA1Vmopkrvaf1FFIEleGGYaoZbkS+uutP0YmJ7066M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzWdXiHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C28C4AF0F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722951476;
	bh=/hUlGB22mjDhClkWGWbAtFZwcWpV5C7a85rIvaKsS68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kzWdXiHLcVxIm5WtsYKODb7hjNYWws0rCxWHEbfGJkyorpXIX+/0/qiPQOTmsnMI0
	 Wdz1TGMcpC7p6n6SUnzLcjxQ/zpjlqhw55rVk9X38k3KeByn6IIkClMUiJs3sDBFQ6
	 xQSQw1XaEr2dViqNPgKcgw2e8Fx8GrUKbQiA4Yb2QHqPBAsVisTC3KTPS9eoA9pBep
	 RB0ZfhfdNpDa1ebbNVgl3X/mBGWz8YC1JM4+g7Og3rLJ6Oa/yHOuEOlgH2rtnW5JbN
	 fAUwzi3yig5Oz3VbyN3l16R3046FbTFVj9lDXI58mOxJZbDa8muv2pRpphJU7yGCw2
	 CRRQ10kAq5iNw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so6542321fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:37:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YwPWGEwf5BbU+U9XQjf3OofwykFfMSk0hTkG2Kgo7SN5Xz0pLTc
	pW+2jcLyXEOQ98fxdjdVEmJJPIJRanWar2udFn8MKCvgaLow7nOh/W6nuzUfC1rN08MCfscs+gz
	+BgPxQmcaN1MXXq8fJmBKRgyeIQ==
X-Google-Smtp-Source: AGHT+IG58J+1R80dvwG2D3kt5T7N8cUTIfb2hUJMgXdYBXk4MiGY7er0nLPWVC3ow+Tfm63fZtNZSzd0RoL4qGlfn5U=
X-Received: by 2002:a2e:a409:0:b0:2ef:296d:1dd5 with SMTP id
 38308e7fff4ca-2f15a9fd29cmr108135681fa.0.1722951475159; Tue, 06 Aug 2024
 06:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805231031.1760371-1-song@kernel.org>
In-Reply-To: <20240805231031.1760371-1-song@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Aug 2024 07:37:41 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+dxQxNV-Bm3q5vzCyfWEzO2Qv-jq29eGVaP-sC-jVyww@mail.gmail.com>
Message-ID: <CAL_Jsq+dxQxNV-Bm3q5vzCyfWEzO2Qv-jq29eGVaP-sC-jVyww@mail.gmail.com>
Subject: Re: [PATCH] Revert "perf: Add a counter for number of user access
 events in context"
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:10=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> This reverts commit 82ff0c022d19c2ad69a472692bb7ee01ac07a40b.
>
> perf_event->nr_user is not used any more. Remove it.

What are you talking about? It is used whenever
PERF_EVENT_FLAG_USER_READ_CNT is set on an event:

arch/x86/events/core.c:         event->hw.flags |=3D
PERF_EVENT_FLAG_USER_READ_CNT;
arch/x86/events/core.c: if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_C=
NT))
arch/x86/events/core.c: if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_C=
NT))
arch/x86/events/core.c: if (!(hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
arch/x86/events/core.c:         !!(event->hw.flags &
PERF_EVENT_FLAG_USER_READ_CNT);
drivers/perf/arm_pmuv3.c:       return event->hw.flags &
PERF_EVENT_FLAG_USER_READ_CNT;
drivers/perf/arm_pmuv3.c:               event->hw.flags |=3D
PERF_EVENT_FLAG_USER_READ_CNT;
drivers/perf/riscv_pmu.c:               !!(event->hw.flags &
PERF_EVENT_FLAG_USER_READ_CNT) &&
drivers/perf/riscv_pmu.c:       if (!(event->hw.flags &
PERF_EVENT_FLAG_USER_READ_CNT))
drivers/perf/riscv_pmu_legacy.c:        event->hw.flags |=3D
PERF_EVENT_FLAG_USER_READ_CNT;
drivers/perf/riscv_pmu_legacy.c:        event->hw.flags &=3D
~PERF_EVENT_FLAG_USER_READ_CNT;
drivers/perf/riscv_pmu_sbi.c:       (hwc->flags &
PERF_EVENT_FLAG_USER_READ_CNT))
drivers/perf/riscv_pmu_sbi.c:       (hwc->flags &
PERF_EVENT_FLAG_USER_READ_CNT))
drivers/perf/riscv_pmu_sbi.c:   event->hw.flags |=3D
PERF_EVENT_FLAG_USER_READ_CNT;
drivers/perf/riscv_pmu_sbi.c:   event->hw.flags &=3D
~PERF_EVENT_FLAG_USER_READ_CNT;

Rob

