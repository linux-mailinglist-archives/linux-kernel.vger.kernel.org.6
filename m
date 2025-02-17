Return-Path: <linux-kernel+bounces-510358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C293AA31BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E133A6D43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1444C149C4D;
	Wed, 12 Feb 2025 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlExsrIx"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89013A3F7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325557; cv=none; b=Y1GXkqL8XCuI/EHe4hgfTeXeZFXoj+jyfoWBG00pnLxcJrEezSGgv3ynGsPXCG0ucImf5R9/Smk1zl2QqSGxMnlxKkl0QduHWhP38/yNvHpaXepVbEUwUXmYyv1CgIesKqMykM4+KixpFgKe8q1ZE70wXbwVZwSxWNYhoCusWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325557; c=relaxed/simple;
	bh=8plav0HWTt+1h9QiCkNdNPq1o+Y+AMAFq2hfN8tZSs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HMY8thVDYeA/DpHo1tdMDBYMpHWqEwqf0R+i9Pd+gzCBfvHeVyvnJSEgf3WemEIUz4GG1n6GdYEhE0G3hyBVc1uuBApH7qPxpKLslgGqrFkmcQsgPfKxI4D19LdoCR85wiKwMlgmByy1h1UTCc+6gdEuz/UYvXB9ZUrLJCk6tFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlExsrIx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so13252077a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739325555; x=1739930355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5TmAA7lrYyzPK7RPMr80QZDXqtaYCD1a8crOBimpM0Y=;
        b=vlExsrIxEZEHfUvcBMDMBuSIUS84rCdt5tgck0XWeP5fT1rJXN6W4aIFWgxaUc0HVV
         3U1c01nUZLMbTp6vhOuN1JirigMQxO/8MO68xZFck6rB3k4GGiMJBSWjZrfB65l3Cn/J
         BkhT0QLKFHLN3/BLjvWvEF3yjs+zVlcMLAPLDD6D4o+6ZroiXI+uofTjewvFZuniZGdd
         wN5W9mNzjvatxLtLDIwYONoDiViIqq/PC7m6YYkc5BD2ND/R8ewTABLzvK1x3V52RGTt
         yiyRpaM8Hv3EFtizbHz0ol0SssVJzdHASqBarhGcfnuqbyJZIFdh3aQb5VfiRuIiUYa1
         ydqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739325555; x=1739930355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TmAA7lrYyzPK7RPMr80QZDXqtaYCD1a8crOBimpM0Y=;
        b=OkOIai5Lbc7UJntG7SVHbAAPy+Jt8yqkeRTntmgegPqW6Yxrn+4LE4coWkzHYkio4i
         YXqQN16BNqOUNZfVuBjStmIyl6TMGNlvuHT4DGU2XIFPxcXK8SD7S9euBWOzoEGFH/IB
         Jqg84+xHamIUCxuJTYzhlo38e5OwroH/l8e36Kl/WN7+tVO+QddKPQLmO4mE+dtzfZgE
         Dgncla/+J/a2TitBLEMLSsbihFSl5iQDdgSBIAPzMLKmlceSHWE4vNYsKSfl9+XwxN+J
         1lpThNme+1myBThwoe9b704Nacm5ICdX9Ifo3llg/DMBwxGPHuKv47+AM3NsO8rYBLt6
         FKKw==
X-Gm-Message-State: AOJu0YwojnvZiEnYHQELU24hWj7p2e5+3mvvxm6fwEBaPK3TKWFuYQKt
	0IfTUDh510vpV0M2+yS/vP1v5tAzQ1uZwn7sOw9u7AtyhzNJXieu+OudCy2JSBjJcK9ZyEkjKtO
	8Rg==
X-Google-Smtp-Source: AGHT+IGNXFHUFBAGO7+23DHP+xbhUNfnPfHgeiFc0IIY5LE7qIIGAVhpnh4dGAbimBx/4hI7qfnSlyKuElk=
X-Received: from pjbpq16.prod.google.com ([2002:a17:90b:3d90:b0:2e9:38ea:ca0f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53cf:b0:2ee:ab29:1a57
 with SMTP id 98e67ed59e1d1-2fbf5bb8fb4mr2372898a91.2.1739325555495; Tue, 11
 Feb 2025 17:59:15 -0800 (PST)
Date: Tue, 11 Feb 2025 17:59:14 -0800
In-Reply-To: <20250203223205.36121-5-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203223205.36121-1-prsampat@amd.com> <20250203223205.36121-5-prsampat@amd.com>
Message-ID: <Z6wAclXklofHtY__@google.com>
Subject: Re: [PATCH v6 4/9] KVM: selftests: Add VMGEXIT helper
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, shuah@kernel.org, 
	pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com, 
	michael.roth@amd.com, sraithal@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
> Abstract rep vmmcall coded into the VMGEXIT helper for the sev
> library.
> 
> No functional change intended.
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> ---
> v5..v6:
> 
> * Collected tags from Pankaj and Srikanth.
> ---
>  tools/testing/selftests/kvm/include/x86/sev.h    | 2 ++
>  tools/testing/selftests/kvm/x86/sev_smoke_test.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
> index 82c11c81a956..e7df5d0987f6 100644
> --- a/tools/testing/selftests/kvm/include/x86/sev.h
> +++ b/tools/testing/selftests/kvm/include/x86/sev.h
> @@ -27,6 +27,8 @@ enum sev_guest_state {
>  
>  #define GHCB_MSR_TERM_REQ	0x100
>  
> +#define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }

Please make this a proper inline function, there's no reason to use a macro.

