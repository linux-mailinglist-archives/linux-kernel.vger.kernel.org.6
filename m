Return-Path: <linux-kernel+bounces-553446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D11A589D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE66F1692CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38933F9C5;
	Mon, 10 Mar 2025 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHmWb0GL"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B917C91
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741568027; cv=none; b=q31Wv+JyWW/5ArUYaZJBPS7IqyoL3Tdq4Nx2IUEUfbA4ka57Swe2KoRjRBRiouJMnInyF+s6kVV3aV3UzeDFfEidtsHRX9rpbcanmdnsbOlEqS9YvlPOFYpNiLRBgq0pU2uvrG5jkokL/TVnb0virt3fnX4zzEX2OoO9x2yKVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741568027; c=relaxed/simple;
	bh=BIK/8I2pjoGPw5VZt+Y5/DpLbcA23EijycR6oVIPUPs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G3QC4a6Nb0II4q4yw5pR13VGbXyP88p02tmiNT0MLDyoy5l8famr4fF/7K0c2aM9WsaAod1Wkk/B4hasFGg0vNTTm/bFUMy3YFztbBCCi7rswQBr8kXoPmjooUg8ddWvoCY2vVz1Ue2agBhADW8H6OnUhXXSFyGaQeJBiaT+i78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHmWb0GL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242aca53efso161315ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 17:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741568025; x=1742172825; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1Kft0nvE8zLlsCQF0ZS1U16R5/zABLbJTZ1Ux7p5e4=;
        b=rHmWb0GLOFLzT35O5h0pOvea9HyykK5hMaV4FKfU71tL0ZplDCKHw8souQUuWB3I1f
         6585kqT+pdDONDYgzg0kqjQ0neijZ3ZyXN0RMr1QohfZFpQpwOXTLrVHZsgx7bmpQd8+
         pDbUwtQj/k+kilAQ0uo8TGWEgO3KgOSHuBZ/OpqSHUXL6Yp8iKPdclsRVmhsSD0cEV3R
         bbbYYgXnf9z3uGqjJk3g9lAzPI+YBBo8vTi8yA2GDv3ceRyehTPKe7eQVfnJ4J5/JCno
         8HyOTjK/KxhRnKYqXmDiGHl2kAo0Y6+3gLBBA5CXToSPGiZdAhfIMmzfxTu06rQVRU73
         Ec0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741568025; x=1742172825;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1Kft0nvE8zLlsCQF0ZS1U16R5/zABLbJTZ1Ux7p5e4=;
        b=dmi8qL9jpaLFuXZRURUYXVtAIEv8bqnJlTh3+AlYmcbUNv1zFxoaXKwAWgPziDqt4H
         94DjFTFe0n3uU5VCo0S9l894/XGF1Nb7UZ1h/zYliu9vDp78DrnQueRrbNeHHNuzPRY/
         UyHJyq83X7TwtM4YgQMeI6pOQKc1coUsua1W96huBirkGYcoNp+zbjaun96TH1BU7MT+
         xLZGBZA3871wdwGryySYdnxSBlnE8Y6ITynCgRu4H2YJagVXZo+1sUS8nqoyOA2nXuMS
         xbbUqh3B8nIwJmQDp9ZejMJ2HvIaWD6I2cvM8mjouvbo8sHu/3kS1nKL6/XM1isahbDg
         St5g==
X-Forwarded-Encrypted: i=1; AJvYcCWgch0wiYBF9HQM/jJYEI6EHUxB+FWWtAy1AtbVzjdVzvDjcWJRV2ZNU/WC+OmWCwuZ0+3dMCUYFE9/tCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbAAeUrFVaaIjV09aHOJJ6i8deM+jpIyp5X2BrkOTmWwF6eGiq
	xp6Le7q+AenX2JxCp3S6slzmPOQB/XITaKCfcXHUjRjB/wVsu/NPg9d4BotDVw==
X-Gm-Gg: ASbGncuCRIjDR9Ct+bPjTAiB5xkH4zV100SIziQMOu5cBx1bEueeQq/mTl4dPaXGjW3
	HcrHJ7h/xV+lzP515ufLcp5YKVqlnV569kf7yGwIHjMsv51dZ/yoxi7SL+2an+6rILktFz8Bzz2
	fY7zBJu+Lh4DTkIG5DXjT/c+toFqk6BW/nbWZuQEkFT2s92aLmYs8WVSNvNT7n96MCWhtrP4t+8
	dQMbNEtpSQwbbAJCudYrTnFoA8LlJDhp6FIWZIHkTO32c3enN88SyrdnSJc8TYrSpSUsXwuzUNn
	WKy+uumtqjZaP4db9pRxCv6arZjA2v5aAbZbG27cCE9Vr/uC9jE10lbNJArVm4oTznC5e5Z8ChO
	oktgkmXcVGMzgeq2WQ11ozCvby3cFWQp8I7Sf+EJcBG0NaeDlyw==
X-Google-Smtp-Source: AGHT+IFp/vCjMy04XPyaBQoM6EiWwSiT173cXoiRYLIUYkyPcOWLuSFg1lIFXhE6+Lt2OAO3lo179Q==
X-Received: by 2002:a17:903:41ca:b0:21d:dd8f:6e01 with SMTP id d9443c01a7336-225477853e3mr2193915ad.5.1741568024812;
        Sun, 09 Mar 2025 17:53:44 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:ee55:e440:a203:909f] ([2a00:79e0:2eb0:8:ee55:e440:a203:909f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7737a5sm8619525a91.13.2025.03.09.17.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:53:43 -0700 (PDT)
Date: Sun, 9 Mar 2025 17:53:42 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Martin Liu <liumartin@google.com>
cc: Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm/page_alloc: Add trace event for per-zone
 watermark setup
In-Reply-To: <20250308034606.2036033-2-liumartin@google.com>
Message-ID: <31e46f74-c6eb-58d9-bad6-518d96de7d96@google.com>
References: <20250308034606.2036033-1-liumartin@google.com> <20250308034606.2036033-2-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 8 Mar 2025, Martin Liu wrote:

> This commit introduces the `mm_setup_per_zone_wmarks` trace event,
> which provides detailed insights into the kernel's per-zone watermark
> configuration, offering precise timing and the ability to correlate
> watermark changes with specific kernel events.
> 
> While `/proc/zoneinfo` provides some information about zone watermarks,
> this trace event offers:
> 
> 1. The ability to link watermark changes to specific kernel events and
> logic.
> 
> 2. The ability to capture rapid or short-lived changes in watermarks
> that may be missed by user-space polling
> 
> 3.  Diagnosing unexpected kswapd activity or excessive direct reclaim
> triggered by rapidly changing watermarks.
> 
> Signed-off-by: Martin Liu <liumartin@google.com>

Acked-by: David Rientjes <rientjes@google.com>

