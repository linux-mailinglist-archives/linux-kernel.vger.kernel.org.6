Return-Path: <linux-kernel+bounces-292626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DF19571FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C5F1C22CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31924186E56;
	Mon, 19 Aug 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtJzVT5V"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB917C98D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088032; cv=none; b=fJH2Fwi1Clvv6i5BnnD4j43TaFwHxwbrI+L4ubP9AKXEKmzmFk8V6e3JH9RmeQJXD4+ZNT6lSn88nI2B07g8wOd2ourzdres2qn9hrOOb9BoGm4x6vJGgieRafWNsvVa35HGQmTuDnZ9LgSNw53mimIkvfUkyBp3XRLeTx26mu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088032; c=relaxed/simple;
	bh=Fz7RTpNNAkygD/A9lFyA3Zpql12yI9+L0oMJ/FFal1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2H4o0Jbv+G7G7g5SiEWhVKz+IysWtFStNPWp3WPGPDksc4jn1LpaDd71rDUuZa6I3/t20BDhtlGFxqnecllA22tkNB9Veu9N6dy9aeS02Sqlx0tPEJlNVurzIbM4OhR93b4YImsv5fSAMhUyHnImGarNGQPlGqnpG6Uzv7IiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtJzVT5V; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1c655141so2872351b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724088030; x=1724692830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44Ddv6twXoWtXHXqa94jX8MItnSbPFQyPRlP6d3WoMc=;
        b=XtJzVT5V42VeWVsfPy+nYw9EH//FYpjyX0x63hbYNFKj11U/N8aoRUBuFe0rrqgYN3
         ZN+/vq33Lm3y+KucwQFRSeZcXLh0oUoQ6Bt/R1kgTJ/aLGlk7coyLV2Jkx+7k947lD4X
         OUJ9LY9yvQkAzKFeYIneGCjW+mZcJCU1ewLt8SOZCOmf0jhWYllSJSVpMCiZiSA6VYAl
         B5JpiGQZHR3OGyC+oQ/tOcIT0vBoK6ZX4r2GmX0/rlyZcXjVzvhOaDD9waRXss4ORN6N
         Ex73KLgIkWh/iSXdYG3zzeRWZUlXfe3pKS0qhDPU0+PoJ9tue4E6HjBgxLSZwod7BUM/
         +9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724088030; x=1724692830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Ddv6twXoWtXHXqa94jX8MItnSbPFQyPRlP6d3WoMc=;
        b=Mt5nU7JA9qjHrPzPelXDbjyHHnvt5G0fkG9nv4JFDQmEg81N1Q03M4kA6+D3Rlv6pN
         9iIhBy5n4V+G6GU1vkw4S5VvmQVNGcrpg2illQmig1eN9NYO7lrhZRCCeYiOu6KE6J4x
         N/wGJFc1jQNjLLd+R7U4T7rWIYTMkYtKQIwn60K6vj0O3V5/ZQmR5sG76O+BpRLMbxH9
         g29vZhg7wjb3Iwcmbephd6LGyGlyUxAH9cFcjhclmXFGdpFNV6fUNX4ZntN/iKI9HD2m
         fdeADvxzOnsGc/z1eyfc7ZdRWhoVRv8nc/Pjq2+uU15kNm+S7tQNdBY2vOlWd0SKLQeq
         CnYA==
X-Forwarded-Encrypted: i=1; AJvYcCVjmL2JoYCVXwrP476g7d0zTKkplnXAB3yYxkFYSORErepYaxbZglBatbO4tmMrxLJK3lswtUcqfeORCREb5XdNTkznM6av61iMJrfw
X-Gm-Message-State: AOJu0Yw30YHF0Nh4g1FAvTKZQ0aIEMtbYkP4+y8XpEuuaRziM1072a+a
	VQxABYSfCQmt/iIbqW7N5i6RMcFwunA3Wpc99MIRUZUVrToWmGc7J0PmxGU22A==
X-Google-Smtp-Source: AGHT+IFS46LqBKrm1MdFbLBCDRNytMMCr+3Tf953El5f+v9RCyTiFYwlhKpSQEfz+hDM+sJYIKpX8Q==
X-Received: by 2002:a05:6a21:3406:b0:1c4:d438:7dd2 with SMTP id adf61e73a8af0-1c904fb6496mr10239753637.32.1724088030116;
        Mon, 19 Aug 2024 10:20:30 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127addf5f5sm6801769b3a.6.2024.08.19.10.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:20:29 -0700 (PDT)
Date: Mon, 19 Aug 2024 10:20:23 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Split NX hugepage recovery flow into
 TDP and non-TDP flow
Message-ID: <20240819172023.GA2210585.vipinsh@google.com>
References: <20240812171341.1763297-1-vipinsh@google.com>
 <20240812171341.1763297-2-vipinsh@google.com>
 <Zr_gx1Xi1TAyYkqb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr_gx1Xi1TAyYkqb@google.com>

On 2024-08-16 16:29:11, Sean Christopherson wrote:
> On Mon, Aug 12, 2024, Vipin Sharma wrote:
> > +	list_for_each_entry(sp, &kvm->arch.possible_nx_huge_pages, possible_nx_huge_page_link) {
> > +		if (i++ >= max)
> > +			break;
> > +		if (is_tdp_mmu_page(sp) == tdp_mmu)
> > +			return sp;
> > +	}
> 
> This is silly and wasteful.  E.g. in the (unlikely) case there's one TDP MMU
> page amongst hundreds/thousands of shadow MMU pages, this will walk the list
> until @max, and then move on to the shadow MMU.
> 
> Why not just use separate lists?

Before this patch, NX huge page recovery calculates "to_zap" and then it
zaps first "to_zap" pages from the common list. This series is trying to
maintain that invarient.

If we use two separate lists then we have to decide how many pages
should be zapped from TDP MMU and shadow MMU list. Few options I can
think of:

1. Zap "to_zap" pages from both TDP MMU and shadow MMU list separately.
   Effectively, this might double the work for recovery thread.
2. Try zapping "to_zap" page from one list and if there are not enough
   pages to zap then zap from the other list. This can cause starvation.
3. Do half of "to_zap" from one list and another half from the other
   list. This can lead to situations where only half work is being done
   by the recovery worker thread.

Option (1) above seems more reasonable to me.

