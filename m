Return-Path: <linux-kernel+bounces-515647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C018A3673E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2606016B241
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443CD1D8A12;
	Fri, 14 Feb 2025 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2AyZwLk"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF61940A1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567326; cv=none; b=UDpYAue6Z0KqwP6D4LCCL91Lx8GirBP/PpNr1KAr6wNI9e1DEkjTgl7ZQyZBfksJHWP++J2iZbbKElw5b2D7j5xE94Wj+ATMRFs24OXdt+KI4qSI806jSOKaxZ8R1UO9cub7Bfbm3Z+cxG8w9AE8UQOjXYc0M1zTQP8cgIH4xxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567326; c=relaxed/simple;
	bh=TABwW3ceukCNtXZ6II8q8PhTuJdg9NELJOoW5SvPSxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aUNzrKciWPHafPJSGCco7YKIa+WEX0sXXYP6HRen+hu0WkDuXYgHefVsMTDgzyQ24/djd9WIbpLagFfTZqLlM6yzPI4d4756aFCT6KJnikMGKh3WZUW+aAZN0BdO8u19CfCiWJKrWRkLl0XunDnWPZufmAiTsdlQU2/18KOfOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2AyZwLk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21fb94c7fc6so51203695ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739567324; x=1740172124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDk9Bd6Y/gy2sTN8NncOlmLs9sUGP6oX096KSBQmv2E=;
        b=o2AyZwLkD2ETHCjiegJneBZ50czWafrXH93eGhdfIT4qsM1KrykBi/SK5kjZ8AGMbj
         J/dFV1r2rOTgkgWyPfspmSaRzx0jAcx2avbO6o9Lle5PL1O8BLDmLlzvU3J6rUweZ1SS
         dpql/SdfhF/S+5OgcqEW/tYWTSMwgCiqYAwiMPFESjgnLnN6oSnXdPQh7YvfF71zIuTr
         A6H7RfeW0kaSBYz6fS2QI5hZYnbPRa/zWoqcRiw+8bhRLbjdB6uBXHcr5pV2/3klyjDI
         vUo4NTXJw/yBCCDdj0WXZHrjYS6UHSDQLKt3nFKJkym8zF5GSAOrwkFuXTJPHux0kyhV
         9Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567324; x=1740172124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDk9Bd6Y/gy2sTN8NncOlmLs9sUGP6oX096KSBQmv2E=;
        b=IAOsWuFCxSfdGLXvsUvMYnlV142jHLKujBcf9MsidSqQAtWjHdEGpP5MWJ1HrhWB2E
         BOghFTjudnjT47Y1nRU7j9ocz864T8rWfzbKr+C6JEqAZnaqRXyIAaGl0rOid9K2t/+7
         XhU0dsCjtwUqEKcsdI4VUTipkr9K2swOvcNFtwCqBN8Chkpx5+W7mY9t8gbdSRpy04Zo
         l8hxG9Bgk/P+ICsHex+eTMP3r1kfTm7OK78K2NXlkXczlKuRCjwiuLRZxrjY+0OWQp2Z
         xoDLJ/PUy4bH0U0TGrkqaxcgTEb5m2Ug2NKNKqv2t29rWErVKzIvyVkNV1eGDw6cb0/c
         1r9A==
X-Forwarded-Encrypted: i=1; AJvYcCXJPSDhcKYLYS51nwZ0EFX9E8LrrIr/sslKZbK2ZW0+AL8CJgw1vSAmNT+Hpkg2famLywqWfjusEtwyufI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdHtXAtM5V1rWjlCr1cZxhNsSE0bQFVUMPABuZKZS5S1lfUTj
	dnRjSLO65S26nvTUqdA+4H6VaORNeslOl2X0NUrQX6Oscm2zNj2BjXwBOgsU1ZEGK/PYESHask1
	7/g==
X-Google-Smtp-Source: AGHT+IHGrqSV53zwVxDPFhenez3hyCmOAIu+9D/XKocIxWU0Dw1My/XXweOF81M6LpwkA3MOCD/JQLSXGkQ=
X-Received: from pgf7.prod.google.com ([2002:a05:6a02:4d07:b0:ad7:adb7:8c14])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2341:b0:21f:9107:fca3
 with SMTP id d9443c01a7336-2210405c6ccmr11127175ad.30.1739567324694; Fri, 14
 Feb 2025 13:08:44 -0800 (PST)
Date: Fri, 14 Feb 2025 13:08:43 -0800
In-Reply-To: <20240914101728.33148-14-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240914101728.33148-1-dapeng1.mi@linux.intel.com> <20240914101728.33148-14-dapeng1.mi@linux.intel.com>
Message-ID: <Z6-w24T1iH2S_Fux@google.com>
Subject: Re: [kvm-unit-tests patch v6 13/18] x86: pmu: Improve instruction and
 branches events verification
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Sep 14, 2024, Dapeng Mi wrote:
> If HW supports GLOBAL_CTRL MSR, enabling and disabling PMCs are moved in
> __precise_count_loop(). Thus, instructions and branches events can be
> verified against a precise count instead of a rough range.
> 
> BTW, some intermittent failures on AMD processors using PerfMonV2 is
> seen due to variance in counts. This probably has to do with the way
> instructions leading to a VM-Entry or VM-Exit are accounted when
> counting retired instructions and branches.

AMD counts VMRUN as a branch in guest context.

> +	 * We see some intermittent failures on AMD processors using PerfMonV2
> +	 * due to variance in counts. This probably has to do with the way
> +	 * instructions leading to a VM-Entry or VM-Exit are accounted when
> +	 * counting retired instructions and branches. Thus only enable the
> +	 * precise validation for Intel processors.
> +	 */
> +	if (pmu.is_intel && this_cpu_has_perf_global_ctrl()) {
> +		/* instructions event */

These comments are useless.

> +		gp_events[instruction_idx].min = LOOP_INSTRNS;
> +		gp_events[instruction_idx].max = LOOP_INSTRNS;
> +		/* branches event */
> +		gp_events[branch_idx].min = LOOP_BRANCHES;
> +		gp_events[branch_idx].max = LOOP_BRANCHES;
> +	}
> +}

