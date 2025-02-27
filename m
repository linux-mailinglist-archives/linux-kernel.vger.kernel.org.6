Return-Path: <linux-kernel+bounces-535356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4C9A47187
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952167B047B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF454764;
	Thu, 27 Feb 2025 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMm6AGJs"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770628BEC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620532; cv=none; b=gqM5C9+lPzth9+V5DYB22kHtNj9Xzy69Qac9xF/NCVwoW/cZNUHkLn67fFTz7Tt3rVshh+tQ9aceIPShICCVoCMpJAXIK9l7FP69W2oPAmNe43UfUsZ5H5NGfThwUa1tOBRDSHlhwRcjEgPc1Q6uZARvn1w0wMlIA3ejG7fTjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620532; c=relaxed/simple;
	bh=6Y1fKqH+6JPcDrh0JlFIpBAbRJiv1ORPxrfvpLz98uw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JqeGMPobBA73eC4shL2XCGt8lNJaNF3nPBrspW5No418/jv38ikBfjp0o2vr2+lWAbY3m2aY4qnS+ijuYvTgD8oFfYXWUz4fXsxl/an7W2awyp9uBygF+O4dhf9tHVHUw2dtCPZy7I2w0+zYLKRC1G6ob2mTtZUTqzHMUVGb5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMm6AGJs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe86c01f5cso973351a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740620531; x=1741225331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsSDTyHa3wJQTd5KpRfuVX+Sw+AQni0muDXXYuxjXcw=;
        b=PMm6AGJsz6jUNXYgPY7dMTDhpaJEXYpwO9+Y+LSoML2CdQEeotgbxOGEtIOZjm5Zqa
         Ugi6o1HeFMpOMeTpuqkN80F+HBaS+cD/urkCWcIbCkHBWv2SyWk42748C6C2AOf8aNJg
         WT0WqyT/I2V+I5Q1LZaPFMsh4Sfqx84OoReh094BqvZfg3WznmpB5NSLyCPcvyDEROyl
         NhDdTD80KKenoKNzo8q/KnuIXZwpeyJc8OEaizcemBEzagJliivSqXoOYKowCD4s5lsc
         IrRExxiCrMOu9R0ImbjH9/Qz6ywpwgVqe4GpqP0j9bqN/UGHJyuO8wKNXuA0U+h/qPhv
         c7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740620531; x=1741225331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsSDTyHa3wJQTd5KpRfuVX+Sw+AQni0muDXXYuxjXcw=;
        b=NnebBGqo91zVW7s7LSrUKGzWmCi4mC7SC71RXIHAlAmDrBtCiV49FJ+QojTgQd0+jg
         Xjgaj8brzh15fGxw1O0rAyPeEIOcrzaYLPsvxFG2JvUIA0jJ0mJEnrDup09CP1hrZdS6
         xKprN+O4fFdG+TLc9aZ79L5Kze0D2WTKEDza0JnyoLBDoHWuyNyyNl6soKoDfuYQzbJJ
         WIAx0JidT/dk7NVlR1m23XwVL9ywhmQIqmgCa1OyDrBl5sNoam0iD+L6jKhD9oTnKWzm
         fUgMl3jQo/Tr8m2o4F1JaUe4QYiNXtZlCdJroj5htqwE625ZtyMnGoNzcK+Z2qDDeas4
         FZDg==
X-Forwarded-Encrypted: i=1; AJvYcCWuw0t4CBW25fSJjVY9j3Vr6em6IDHcaAvI63hFUsEgLDmzHtZaWcqMI6ahTlo+fim59d0zdvG0BQAL2YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9M0/Icx9sIoxIN4+XS5dBJLHUnY4sphtUDCMujMQlcOk34PCJ
	woHtFY8fbMl6gFSGVtzPyY9e6KZfWEVMuwmMtjhAagP+J4eSo+mEoJUoQ1nIm+4HzK0JaGHt9YY
	Q8A==
X-Google-Smtp-Source: AGHT+IGaR/WADR7NyRUtLbbvvT1skIofaTwf//BO6VemKseXz4ZLA1iMK5Z2mHNbAY5y2BJMEsCHkZwv4vk=
X-Received: from pjvb12.prod.google.com ([2002:a17:90a:d88c:b0:2ea:aa56:49c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bc4:b0:2ee:f80c:6884
 with SMTP id 98e67ed59e1d1-2fe68d066a5mr16239747a91.33.1740620530819; Wed, 26
 Feb 2025 17:42:10 -0800 (PST)
Date: Wed, 26 Feb 2025 17:42:09 -0800
In-Reply-To: <20250227012712.3193063-5-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227012712.3193063-1-yosry.ahmed@linux.dev> <20250227012712.3193063-5-yosry.ahmed@linux.dev>
Message-ID: <Z7_C8a9oGp8lskhh@google.com>
Subject: Re: [PATCH v2 4/6] x86/bugs: Use a static branch to guard IBPB on
 vCPU switch
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 27, 2025, Yosry Ahmed wrote:
> Instead of using X86_FEATURE_USE_IBPB to guard the IBPB execution in KVM
> when a new vCPU is loaded, introduce a static branch, similar to
> switch_mm_*_ibpb.
> 
> This makes it obvious in spectre_v2_user_select_mitigation() what
> exactly is being toggled, instead of the unclear X86_FEATURE_USE_IBPB
> (which will be shortly removed). It also provides more fine-grained
> control, making it simpler to change/add paths that control the IBPB in
> the vCPU switch path without affecting other IBPBs.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

