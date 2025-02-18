Return-Path: <linux-kernel+bounces-519693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB6A3A0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560733A33F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A76F26B0B5;
	Tue, 18 Feb 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWJYmu4t"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D726AA9B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891077; cv=none; b=Gfzzbpax13EWOsl5ZYdgbRUB2xWxQnZQw/4JEc6PujjIEfak73XQ39us1+bHFzXWvkpfdbP0h8LklTWv5HRQaeHubj9wKcBEgNr2nQp0Wg3NYWky1A4cZ00m21wMKujw2N6JzV1X45C/bMzixa1koQK8d39FnLVjS30q1DLczB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891077; c=relaxed/simple;
	bh=I899cDCtzrLN27Unv61LFQINIpMMYCQTO3vzchKPTV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jlSsmS2dk4sKPNnQKwkDYUpSsEr+H4k+W0jvXpNb/ZNsK6DlqPe7C4MOfuGU9naZstNioRMyRjHmeJF/Sb1GFprYgxJ37CUkZuqryr/v/v4ba1dEf8URiBECT2aJeQr8OXFv3b9k6eCHOLE++9KM6zlSKx25McipIxfA/TZGLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWJYmu4t; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220e62c4f27so124971415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739891074; x=1740495874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2knpZyBZj3T0QsRG2HDCFcc/2ipgVgDbXPlB+2nkirM=;
        b=JWJYmu4tAG+Iy607hcvs46XQbbfpO7Psf6uhLE38VWCbS3+Luw5QwCzvUTCvFPqf3w
         P3oT2umOgdXQHJsphV0e4uPcjlvlkZcyU1DWLKODpdwX12TfIKOz8RADuqjQglKlkgn6
         B67l86ptccjHkeA8MFxW6GvT2dCcC45yOaO5ZS98DSPyT6TtHpaTewjonErgbUrhQkPO
         XWVK/FZCbXAQ60syyXd74tghEgPNtYPd9+6gb0c7ea3NfoJffJpj47eiHS6wIlKZpbLn
         ORR8hzqkxKCpSwnbiM/5wHv06LuFs6+7su7J5nte6OysHkaNlOJ6h0rFGw8hGd+4D0y7
         7dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739891074; x=1740495874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2knpZyBZj3T0QsRG2HDCFcc/2ipgVgDbXPlB+2nkirM=;
        b=Ca+eyz+1164cAYGJRhMM7XuBKcvqVdf77xpozpW7nWOps9Qw0+BP5el0+1x9GgWdNs
         n9SuTbW2efMNrcjZMua6uFWCvEcTm6bRY7hI8w5HgQ505OcSei8U1n3XH37y3MsSLATQ
         wXwO4bIyBd8c0qOCWRPR4YKBgmIPDlmZgdkEOWupzTwwD4w3uJTURjiIECk3djNiY2/M
         yxyJomLY5f/T8fBVfbSY8X+4O/ZqMvekSbZJCNJnzFxIYRGjwNiQDdnsuvMNbAMOGy+I
         Ri308wx1io+9Y1QHGlP8i8SnDB6hKJw8a1SJnksv79meVI18HptxJQx2rsLLaUvrUOuX
         p9UA==
X-Forwarded-Encrypted: i=1; AJvYcCVp7RB/V56YK7WgR1WpsKkfXATdC8M5tx/ZhQy3AciMr5orKoQF5bYtXBwVsj5s07w33VXj1APDsghzbe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjr9K17xjx9uXvoEL/cO10AsmbUuXMqK0SrAiZkYYBWLdjYvYO
	C4LNXryOCwu41DJNiHh/EPxA/ZaiV4fLS0wXwdnPnMQGTIx+UFSYNfWW/ks6pqb4QCaaTfV//rk
	zuA==
X-Google-Smtp-Source: AGHT+IEQM/K6moISqV33XPWsPZzBljK/WoSuhYmU5iaE5Q5tbSVOXX7pggels/AhXSwuZfgpgUZ1nTGnfS0=
X-Received: from pfbga8.prod.google.com ([2002:a05:6a00:6208:b0:725:e4b6:901f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a21:b0:1e1:9f57:eaaf
 with SMTP id adf61e73a8af0-1ee8caab754mr24825593637.6.1739891074053; Tue, 18
 Feb 2025 07:04:34 -0800 (PST)
Date: Tue, 18 Feb 2025 07:04:32 -0800
In-Reply-To: <28dcae5c-4fb7-46a8-9f37-a4f9f59b45a2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240914101728.33148-1-dapeng1.mi@linux.intel.com>
 <20240914101728.33148-8-dapeng1.mi@linux.intel.com> <Z6-wmhr5JDNuDC7D@google.com>
 <28dcae5c-4fb7-46a8-9f37-a4f9f59b45a2@linux.intel.com>
Message-ID: <Z7ShgKYeSqpGUXGl@google.com>
Subject: Re: [kvm-unit-tests patch v6 07/18] x86: pmu: Fix potential out of
 bound access for fixed events
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 18, 2025, Dapeng Mi wrote:
> 
> On 2/15/2025 5:07 AM, Sean Christopherson wrote:
> > On Sat, Sep 14, 2024, Dapeng Mi wrote:
> >> @@ -744,6 +753,12 @@ int main(int ac, char **av)
> >>  	printf("Fixed counters:      %d\n", pmu.nr_fixed_counters);
> >>  	printf("Fixed counter width: %d\n", pmu.fixed_counter_width);
> >>  
> >> +	fixed_counters_num = MIN(pmu.nr_fixed_counters, ARRAY_SIZE(fixed_events));
> >> +	if (pmu.nr_fixed_counters > ARRAY_SIZE(fixed_events))
> >> +		report_info("Fixed counters number %d > defined fixed events %ld. "
> > Doesn't compile on 32-bit builds.  Easiest thing is to cast ARRAY_SIZE, because
> > size_t is different between 32-bit and 64-bit.
> 
> But ARRAY_SIZE() should return same value regardless of 32-bit or 64-bit,
> right?

Yep.  The value is the same, but the type "returned" by sizeof() is different.
On 32-bit, it's an "unsigned int"; on 64-bit, it's an unsigned long.  I.e. the
size of sizeof() is different (sorry, couldn't resist).

