Return-Path: <linux-kernel+bounces-515874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA12A36A17
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF617A2F06
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA16C5103F;
	Sat, 15 Feb 2025 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uglToXfE"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309E1373
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580632; cv=none; b=NdlE9FwnS2BLREapzVOmxWHp+MCFk4NS5BCUD01vMk+8SOkeJm5ZWKZ4VzFC5hdSGLfUvmUfoHrFVIe0TSSsHMTzJpT9ZkiPpDeTUhwbR4k43DuJGGqXhWhxfgcZLrRCvZv3wg/RgGrL3H7DQDQC2JEmP7bDAq1pmrfOJjodD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580632; c=relaxed/simple;
	bh=DD1RMHcqHXHtSXjy9qZLFVRyL9tDxgSiiURo9OQ96ok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KhSC7VMlSS2crzMTIZR1y+EE1XTUou2r13qweYDQtxACAFdfPc4/VWOef4Idsct5Xjmv2WfBSLKIcFsaRR8I8b49OSNZ2EtVqsD2Wn5prwvBVbUkR6UtcCFNCTFH9MbDLSICEaCrLbrSaLdKbK4LwIjiiz2gmNX3hKgnnXGoS1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uglToXfE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so8349095a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739580630; x=1740185430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIE47UKxxWcKjCmL21kwJ8j8oO1nS7dRlhB8wJS9w5g=;
        b=uglToXfEvrnoSt2adz/vM+b0sCVPWjsKmd/d4S+IJ6gEsS+sti83ztD1hFF+M8mPOq
         +BgEQI5ly3x2b/2LKrQr02QMGeh6LHXYBnmy0kgzkGWisYl0aekswCxRlS72xujLLGfu
         fCLVNuzT8EqlHn7uUsUqxXM3TmEzI/X2DvlddUKTQRmh72pWjR1mamt7pN9X5gtyNsgF
         +5o6KA82QiS/I8bITQWr1t6uag3joCXj00WUi+9rahUanjj5aEH5QkYUIFG2vRF0oip7
         xfp/cO70Q//ri8wxqsogA+5OLxqgTWXHygq5IY5rhDlYDQN1waHjJCFIsw67JoXpEq2H
         tC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580630; x=1740185430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIE47UKxxWcKjCmL21kwJ8j8oO1nS7dRlhB8wJS9w5g=;
        b=W1a29NgEvvL6BXcKPxHI0pCeu+GfFNUak9Xd9HhRGwVsnjVRI4PlBdk+FU4dEd1SHY
         aBGjA3F6NCfPUfB8ZDsnYkYqagWr9RDNHcgh4I/yzk4v8TmbBCF5U5AMBcGFIXUf/nUP
         +UWzkNbjoKShqXx3LPXXSRDV4JtagBERlhCZamEOKALm6/thiV8o2Nfq8XtQkcCqvZ28
         mG9hguYUuckgjxenDYuLIy9FvA+oIN4jgYRXpiKaRglzsFJxEpkT0jpefu9BgxY9/PA0
         oPJRwMGxypm55lpXZxxuf7jMwOJnRg9t3/ANtK0sDYNKavDJ/0tvc2W85q7vcYY1n/zH
         ZIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD0AhyZ2MxcfXbIHlNi3XjMZbXUM21avMiRDiLuMNWs2APnhMQyOgvGM78UQS/T46MvoYQslsnMq78mgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYoaofUrIerj0Xk2Jgf/TwbXatMJWqxcK2uJjdcUSj/y1WUGM
	TsyFzWTcH5tckI+53iDs+1xK3V0YTJFMCLG21ejrm9AG2JYZpKe83XaFanBBWKnjbIoMpsI0q2h
	Cug==
X-Google-Smtp-Source: AGHT+IGYzFsreJBlV69pBS5DoE2MfEEmhv2kxLxr0Du9uKGuYXL3tqBYxD8gFLEQfCYq0uQKBRZAkppwvXo=
X-Received: from pjvf11.prod.google.com ([2002:a17:90a:da8b:b0:2fc:1158:9fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c8e:b0:2ee:5958:828
 with SMTP id 98e67ed59e1d1-2fc40f0e672mr1782459a91.9.1739580630045; Fri, 14
 Feb 2025 16:50:30 -0800 (PST)
Date: Fri, 14 Feb 2025 16:50:07 -0800
In-Reply-To: <20250130010825.220346-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130010825.220346-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <173958023279.1189000.15717835333610830974.b4-ty@google.com>
Subject: Re: [PATCH] KVM: nSVM: Enter guest mode before initializing nested
 NPT MMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

On Wed, 29 Jan 2025 17:08:25 -0800, Sean Christopherson wrote:
> When preparing vmcb02 for nested VMRUN (or state restore), "enter" guest
> mode prior to initializing the MMU for nested NPT so that guest_mode is
> set in the MMU's role.  KVM's model is that all L2 MMUs are tagged with
> guest_mode, as the behavior of hypervisor MMUs tends to be significantly
> different than kernel MMUs.
> 
> Practically speaking, the bug is relatively benign, as KVM only directly
> queries role.guest_mode in kvm_mmu_free_guest_mode_roots(), which SVM
> doesn't use, and in paths that are optimizations (mmu_page_zap_pte() and
> shadow_mmu_try_split_huge_pages()).
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: nSVM: Enter guest mode before initializing nested NPT MMU
      https://github.com/kvm-x86/linux/commit/46d6c6f3ef0e

--
https://github.com/kvm-x86/linux/tree/next

