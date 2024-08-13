Return-Path: <linux-kernel+bounces-285274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66944950B83
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291A228720F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4891A2C24;
	Tue, 13 Aug 2024 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQo0XQ32"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956B18C3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570577; cv=none; b=q8/yONkF23xRGncaQuGqNzXwWBXyJ5A6bnzTNYCMQjiaFBpktQHwBR3/SpXZkM0pBfoRyl5JRTWLe1/nOgKQOx5k6EO44i9/pMU+s2syAU+dkIr0NRhiOkv023Hh0AyDeVOLMltO9tiA4qMRvxJla3vfdTmitxmfpiR/FAzFgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570577; c=relaxed/simple;
	bh=Snsxhi3LIQZcXAKg3rDQSNDIeb30hQkyvxggbi0dWFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sCicgaR8L1k+U0uUc6e3sIMdaDvy1okjhwtXbafqE2fqJnYaDJvOXDQaFXTavuvxCh9LHzKPmFnYUfaKG/lG0suBH8l35XGjmIFm72yhg7VwyceSoTbm5ICiUSsPNquOu9O7dUsUOeFo3o6+MJYhym9j6jwCvfC+yteuewFMv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQo0XQ32; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc6f3ac7beso46141675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723570576; x=1724175376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qaxx+RIlGX+ihV0yke86zTWP07hgBW9xJr8rC5KpwXM=;
        b=OQo0XQ32bjh0iBL5axa6SqPpuz/ew1BXtJu1dzlV6iVZ61Ojh5edef7Lnhtkndv6V7
         xqK8V+/2pHd9RL3u8gfMoDCQacUNStIog2s7MgkKma04UDSuQ2yrUHtDsLGcJu6etvex
         W+zdmOOf7ycJ6dYEj9NA24+BSpadURfId87UQXUf7FoWgJdlKKZe6VqM1SFTbj0hqIu8
         SRxnGAGgKik2dMx9/UQPQyGeNKIUW+/xaOLyPi8yZoCwCShz4YdOEbbpaNGO3tmbz77W
         dLBFKh+fan5KJlcum9jMg5KQQ3PBpUt2QF3SQZmoIaBTaHFpnMKG0H9MGUs3fdMORP09
         tRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570576; x=1724175376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qaxx+RIlGX+ihV0yke86zTWP07hgBW9xJr8rC5KpwXM=;
        b=EAUdnvmZDnhC4MahZIVaUYD0xiui3KKZXJ/if/HV/cGf9sB6wNtUFPkqE3UDfJcPCe
         2IkF0a7YNu0hAI4qpOsjDqg91/cET92IU6O4jPJPCIuqCyVVATkCTRxl9ptH9RV8R9p+
         RWGE9nLq3T4Hr9No4mWbSwDB6UB+GjoA4ROezAPCyv8x35fMSDVJOw4lrOh12+vMEkdB
         BJ04LupOwOCfXcJZ2JZfcDgos0fskLiQIZppv/d9lZQuirgLyFVbtQ2ub3NfRi+mI+Vo
         D/AHGC92XqeUpNdB9fm5w+PDdgnfVLTg/XzXbE1Aj2obCJn17aRV41FLAoERf0o7wO9Q
         Y3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlclQibIqoDrweZKjrVpyJSOjDcpqNLZthz4x7YEwdHM3bjkDSIIOkuhTA2kCl3fi3fI5x0KCM2Ic4oTRQvbKR2qQaQUcGCjyxGNmM
X-Gm-Message-State: AOJu0YyqAp4vNe5LO4oefzJqGbHhEqOEH2+cPyIImSSd2jg9RwxiN1xx
	dyPbyz87enf58HuDA/BS1f/irZvSIq4nrm1kRkZmFrHazuXLpAkeXdYMiyeO6h2xMW1KWhzJHMh
	nbg==
X-Google-Smtp-Source: AGHT+IEAaxGWcx079WWkKDEjS2dVuIZWuu8HYSM3PufJYi/0hU7fPNMjSiLPVYS4fPuoi7FYVv5lbw02/Yo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2d1:b0:1fb:6151:f630 with SMTP id
 d9443c01a7336-201d64a5e6bmr80045ad.10.1723570575607; Tue, 13 Aug 2024
 10:36:15 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:36:14 -0700
In-Reply-To: <20240813164244.751597-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813164244.751597-1-coltonlewis@google.com>
Message-ID: <ZruZjhSRqo7Zx_1r@google.com>
Subject: Re: [PATCH 0/6] Extend pmu_counters_test to AMD CPUs
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Jinrong Liang <ljr.kernel@gmail.com>, Jim Mattson <jmattson@google.com>, 
	Aaron Lewis <aaronlewis@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 13, 2024, Colton Lewis wrote:
> (I was positive I had sent this already, but I couldn't find it on the
> mailing list to reply to and ask for reviews.)

You did[*], it's sitting in my todo folder.  Two things.

1. Err on the side of caution when potentially resending, and tag everything
RESEND.  Someone seeing a RESEND version without having seen the original version
is no big deal.  But someone seeing two copies of the same patches/emails can get
quite confusing.

2. Something is funky in your send flow.  The original posing says 0/7 in the
cover letter, but there are only 6 patches.

[*] https://lore.kernel.org/all/20240802182240.1916675-1-coltonlewis@google.com

