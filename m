Return-Path: <linux-kernel+bounces-537226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC03A48955
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4DC3B273D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6974326F46C;
	Thu, 27 Feb 2025 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRjig69N"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5D26B2C7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686352; cv=none; b=aWyoh5bZSwj3TQAI4PZ7fuZ5ieu0Ab3WeZEd22UXXuwKwZGv5kM7L6j/yyu16cybLgXwYnRSzdltu6mbXkoAABFJLGnAMTYkW87QTjvet/X9bK7A3ypkFbrgcUnQxbH7Q/friTRtSifM5SDQvgC6UX26m5So+pBVEZFK+K7Ykec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686352; c=relaxed/simple;
	bh=/VV1+s8xZRpvzfRQLRPfeZdw7ex/gqiFmPYSVUcpIYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SX596zB7GhdKDTMVC2pAv8I8gb+cSZCxsWjEv7fWV8mXCaU3jHuIwb0nqzkZyWfslVH5t+nJjGaqy7aaqUZWaZvDZRxZ8/FskwbiLgYiUiwPYFp8IFm1JamFy+D47oM7CqlQJfNd8OhHMU8D393xE/2g8Abn548p6UuNhNo/8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRjig69N; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so2918571a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740686351; x=1741291151; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7USea8XaxoNKvSqn3loqpyLdXnwrQ2b2Ao0MsUJT9us=;
        b=fRjig69ND18f0sD6tjs0qjtKfoK4zylV1yalolsH4WQ9gJ5yGIgCyKqNB691Yb/Lhf
         iqLwyqR6aYIDIDyIuC5QNl72Ec2Tbf2S8MVNs+Soq0tkykwj20W1ivQZDPVGhRuGzRyB
         u7mXzQd9vi7HbznB+3J5yTw8UBKKvMCzV5D4cXQzZfhfMKfK87jbS+kpo8/D2emqe+/z
         5FRDGaos34RNPaLdmX63tIl1B9wqIqwBxT9WKRPnenpJDUz2+C4Bs6DMktzHENZ7CGAo
         vW6E3RzzbiLZ546pLjrC9vsX51M/7YgM5/uxVYUmk9IArZU6KkRuDxKvOT8RIHefyKRm
         bMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740686351; x=1741291151;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7USea8XaxoNKvSqn3loqpyLdXnwrQ2b2Ao0MsUJT9us=;
        b=icgbP3eRkIc7MxyYKXv82KfiKzsxHGlnmeQ5mboAVZvILrP7FdkO2Gzp/q5FH68tI6
         wMbB7Uo6kMc36jWU+RJo1xS7xliQ80EUxaQngS3hC3QJTAbuJYlqgiJfHGovsrqQPc3h
         Gxu2tYuw/rldRyB8/eAy/v+R1rRZgeoki8+J/bMQB00R20sZ1S0c7XFkx9nS+2Bzo175
         bOb/6X5ciDPS1ciaLVcr1MDXQvpa+KvY1A3XOo5EJFrFBS3awH6n4a1a/zOC+wrds8U1
         pEnRJc+tLQdo6AiygnvIH9RGTRa+HEqSXn6A9/uFTDucbxdF1b+RGqcfCsiRkyOSVOlz
         QWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuutyx3K/fNnwG5pukhqmWy6aAvWPkGkDIoEVIxB/0kbDzmkb5+ThMUQhw+iQ4l+Xym79h49ZFVOjR5uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/VxxO9huYaCpwldrO14EYe/bxVjjck5HIubPlFeSIdySZesT
	uTvCTK8muBm6K3HbWLLXb8Og2u4lk9CXUWHhrVq8FKAh9cJQzLSkGVnbsdmAB61l5hvoWMsg5cd
	sEQ==
X-Google-Smtp-Source: AGHT+IH5sjjj8akdTxMemVpnenPtHKR1xkFYxPK0klWVvtSn92S5gziRqma+L4+AdqY7Tk5eAbbNSDJYlOs=
X-Received: from pjbov6.prod.google.com ([2002:a17:90b:2586:b0:2fa:a30a:3382])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec4:b0:2ee:d433:7c50
 with SMTP id 98e67ed59e1d1-2febabf19c9mr755977a91.23.1740686350876; Thu, 27
 Feb 2025 11:59:10 -0800 (PST)
Date: Thu, 27 Feb 2025 11:59:09 -0800
In-Reply-To: <20250227014858.3244505-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227014858.3244505-1-seanjc@google.com> <20250227014858.3244505-3-seanjc@google.com>
Message-ID: <Z8DEDSsFbQjcisqr@google.com>
Subject: Re: [PATCH 2/7] x86, lib: Drop the unused return value from wbinvd_on_all_cpus()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zheyun Shen <szy0127@sjtu.edu.cn>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 26, 2025, Sean Christopherson wrote:
> Drop wbinvd_on_all_cpus()'s return value; both the "real" version and the
> stub always return '0', and none of the callers check the return.

Drat.  None of the callers _in my working tree_.  I only checked a sparse working
tree and missed that the DRM code checks the return value.  Luckily, it's uninteresting
code (and dead to boot).  I'll add a patch to drop the checks on the return value.

drivers/gpu/drm/drm_cache.c:    if (wbinvd_on_all_cpus())
drivers/gpu/drm/drm_cache.c-            pr_err("Timed out waiting for cache flush\n");
--
drivers/gpu/drm/drm_cache.c:    if (wbinvd_on_all_cpus())
drivers/gpu/drm/drm_cache.c-            pr_err("Timed out waiting for cache flush\n");
--
drivers/gpu/drm/drm_cache.c:    if (wbinvd_on_all_cpus())
drivers/gpu/drm/drm_cache.c-            pr_err("Timed out waiting for cache flush\n");

