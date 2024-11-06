Return-Path: <linux-kernel+bounces-398485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F79BF1D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E541C25735
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE47D203709;
	Wed,  6 Nov 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U53m2Gyk"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE716CD29
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907320; cv=none; b=iIBqi+x7iStk9j5wYrXAkg1E1OTV4EYfU0htFce8eMX0O/OkeWxZxQwtGzgLxUuDq2AJWjjnCJFtfQF4/rMMTZ3/EdEVQUkEdcL7LcQKMVKxehujAdtzNa0lByniWLF0Ju5I/MtPzhlDRua216S1jFbytXHLIbUMMI1/mJJzX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907320; c=relaxed/simple;
	bh=BzMh/SkjF/vZhwo25zJAi8RA4wwY7ojx5tSTsjGDWMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=beRfAYT8RtUBJdPIrAKZsdjf9xQs5WTzhlFQYsXoe41uiHIwou7nY3OYsvViOusv1rGGTJqlZDfNMhJ1tiJu198814dqAj+Ch2/LoWLamM3dshdikOrhzHtJI2/pzusSvGuxf10OPs75pvjDAuqhA/YtXlH+kPxDZY1C5F4HOhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U53m2Gyk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea863ecfe9so84402217b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730907317; x=1731512117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yuAQmTAdCCAAaxxu5QbRxg4oOjJGHpnFzwE4CldcWU=;
        b=U53m2GykqvDaj/gz/83Nz/TuZ/YIjGvaatD6B86Wbx30pdX6rIfF6S7iF8dsBaewYG
         IaYEAVzSsfMcb27xE4SuywzQAOQgXbMed4jurzRx7DNtib7uW5r3x8G1VGXXX43rNdDI
         zS3ACcLnm6saxV2RIg0SY2Yt5CAvrVhNodRYQMJklVwQSxEVIniGICbTumPoCzT7WGWo
         REK1sMN9wOy/9W2V42rpI7d5KbqVjTaZtpmFydOtjxl863KjcUOLFDNB691wXszOSuKZ
         dzh9r5YNhJWtxrLc1vM7ANHBDB8qyg2e9Q5QdHh0oodcbqlik6me4a4EbpQp7ZGhMCN9
         EXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907317; x=1731512117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yuAQmTAdCCAAaxxu5QbRxg4oOjJGHpnFzwE4CldcWU=;
        b=GuA8r9Glf7UgT0WrdjRCR62lCjpYSYbdAerqfFx7D+Yfn+EXu2+EimXjjJr4CtIfim
         oKaeJO4gbMFQq6gyj7ryOTCvS1Xztepc/Wcu7NgI2Ti7wB2Pqn5UaZpHdfOcs6p75ysf
         zBvI74MZWp3k+/eiQKbgSp/LZi7ooPgTqIvwJbRiwvLx8YqZWalM65VHNerOE6GJ+01N
         I9OccG8qbcSWP3i9NyiYtNweeIluWp+S4I/NHpNFPzjauyOXhxnvheRrEJ+Ey8aveI9+
         BZD9LrZWx4EOgmRWEzLEhw3X2iCpplzS0pRhQMvy0wbk704xZHmW2QYt1Rb5s1UyKgSS
         w4eA==
X-Forwarded-Encrypted: i=1; AJvYcCVOhZgl2Mc9V9AedfegRI3in83PodWjPUSKUDdK2aNU5k23MzDeisOYVhhqhavYtuvbvnq8dphVI8Fsucg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3884Hk8GZowDDUdB7AuDZ54F8/DITnSNmbmV77F3meMyGbwk
	GQxioGDbNvyQEHT+jlHEp7nVev5L5aFqcmgsaDlIK2ekMBymIDepfddhIepjs1ygWZkdyNRTAWE
	k2w==
X-Google-Smtp-Source: AGHT+IHmNxgiraaP+U1uT1ChKSKhhI4xy7BUPpqdGKKVhBllQrZbqSbHpux9zDxuCCy+elXJIEPKqQ6aqPM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:25c7:b0:6e2:6f2:efc with SMTP id
 00721157ae682-6e9d8ad570amr9938387b3.5.1730907316561; Wed, 06 Nov 2024
 07:35:16 -0800 (PST)
Date: Wed, 6 Nov 2024 07:35:15 -0800
In-Reply-To: <20241106152914.GFZyuLSvhKDCRWOeHa@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104101543.31885-1-bp@kernel.org> <ZyltcHfyCiIXTsHu@google.com>
 <20241105123416.GBZyoQyAoUmZi9eMkk@fat_crate.local> <ZypfjFjk5XVL-Grv@google.com>
 <20241105185622.GEZypqVul2vRh6yDys@fat_crate.local> <ZypvePo2M0ZvC4RF@google.com>
 <20241105192436.GFZypw9DqdNIObaWn5@fat_crate.local> <ZyuJQlZqLS6K8zN2@google.com>
 <20241106152914.GFZyuLSvhKDCRWOeHa@fat_crate.local>
Message-ID: <ZyuMsz5p26h_XbRR@google.com>
Subject: Re: [PATCH] x86/bugs: Adjust SRSO mitigation to new features
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, kvm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 06, 2024, Borislav Petkov wrote:
> On Wed, Nov 06, 2024 at 07:20:34AM -0800, Sean Christopherson wrote:
> > I prefer to be To:/Cc:'d on any patches that touch files that are covered by
> > relevant MAINTAINERS entries.  IMO, pulling names/emails from git is useless noise
> > the vast majority of the time.
> 
> Huh, that's what I did!

You didn't though.  The original mail Cc'd kvm@, but neither Paolo nor I.

> Please run this patch through get_maintainer.pl and tell me who else I should
> have CCed.

  $ ./scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nofixes -- <patch>
  Thomas Gleixner <tglx@linutronix.de>
  Ingo Molnar <mingo@redhat.com>
  Borislav Petkov <bp@alien8.de>
  Dave Hansen <dave.hansen@linux.intel.com>
  x86@kernel.org
  "H. Peter Anvin" <hpa@zytor.com>
  Peter Zijlstra <peterz@infradead.org>
  Josh Poimboeuf <jpoimboe@kernel.org>
  Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
  Sean Christopherson <seanjc@google.com>
  Paolo Bonzini <pbonzini@redhat.com>
  linux-kernel@vger.kernel.org
  kvm@vger.kernel.org

Versus the actual To + Cc:

  X86 ML <x86@kernel.org>
  Josh Poimboeuf <jpoimboe@redhat.com>,
  Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
  kvm@vger.kernel.org,
  LKML <linux-kernel@vger.kernel.org>,
  "Borislav Petkov (AMD)" <bp@alien8.de>

