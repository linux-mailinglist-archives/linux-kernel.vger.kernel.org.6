Return-Path: <linux-kernel+bounces-184294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAF68CA4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3F91C21324
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BD355C2E;
	Mon, 20 May 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8wbUXIt"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5345BE7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247380; cv=none; b=PAC1IjskeuZZRqADv62/+ZFTjzJ4jljQlENR+V+oL7B4XteCtl9bF2g7SQgENFY2Y2ChsB8gcDM2r+Z0XV+CwE6xijL3KWcllKjmr1h1pQrKAsn371Dx/wo83RhNbOdDKOyloGkTZfImZEPjTvA8tmEolRZJVlPcprMNm8UO/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247380; c=relaxed/simple;
	bh=qsssZSpIb8AOp3jd0s5cZWeOZuSXvtgyOhLTOXSW3hs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nqqlNUj54wzza040vS3bTSWFcmJ8cB304E+erAyjFpXFlJ3GKSVJ2Qy9acS+itTa2Fv/+gxUfNAfx3zh1xbaw4y2J90EMPayd0U2pxXR7Ae6ef39Pneaw8M/94o4O3a072cyjJBgzKSQVXgOhztqjGxn4Vha5gcNNm5potm9u5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8wbUXIt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f47c380709so8853953b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716247378; x=1716852178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6dan5f5r0roEc1leVmGEMVnNeZIHQ97VnRnbITPUR8=;
        b=F8wbUXItYlG+hWIFMmvUMaEagbb+pp3Fo6/1WCgXUcsUyo95SJ9mYD7KiPgyi/lvHM
         xy8G0OcZdKmNsWk0YPsonHmO+Ni+pdoWbCLLHNs8xyVYJTi+lulWaLCZctptr/pqB+JI
         MepZuh9hzbhCVNGg1jYKAF3juB3MEqoxfMOIL8vn1bx8bAuqXmtpVX68t7Fo9/VWHTvB
         vF1Mj5/ksDHe0uodOB6jBbnFszQOxfSSyRjTF198V0iGhfq5NzKKEfgTofGrjRfC8MxR
         OPwoM3B8ieMPXHkMUlZMXgeLCzit5GdvEakGBhlHtxn6PskibX9sSllkiSEFgkNtyVvC
         adkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716247378; x=1716852178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6dan5f5r0roEc1leVmGEMVnNeZIHQ97VnRnbITPUR8=;
        b=iVRgaVr7b71lHfTYgt9HYSu1VTn6ZvvnOr7XL5mNZ+Ae/BfgV4apnlQMsApYiAdYsj
         SfliRJukWcdy9fp8Oj+vebPMrI8ZITU4uff8zhK63Pi05iCXYA0PWZ2CMfmFgyZEQQ8C
         Vknz6g+qfd+9SEmkM5tb7nUKheIYASy340uLUB2cYl57mqxMJXNvBaYhcercurJjQ6BY
         b0WRUVotMmyjoR/O8iskhv3b8j5TIjNSmBHu6gAcDno6ifqWQd1yk4iNOhclMmnyBg8J
         3lQIsVxw71DqvqB7U56pTUuKM4Z++DhzYVSLoXcELzyAy6uQwfAKqZzJnIJ2M2+XwINq
         DD8g==
X-Forwarded-Encrypted: i=1; AJvYcCX+WVKPTBjgMaRQapQyQyGhJ1ZmzoQjoO2fINNvKvTDt7T1tdem93k56p4cPJqpiSc+yvX5lqfTrvpsRj8Ds8i2nmMh6hoFGVkQigvj
X-Gm-Message-State: AOJu0Yy0Qx6vgD7WkrJDqgc7x2wDPtrC5MBXwzne/KyMcAJWGNpVpHwr
	RzmNvd2LNfKiuRNE3LdaGhFBcXKT/ftoAFrZ3kgH9AGt8EaWtWtagdDhUFcAwBUmqfP1H3RTnzF
	AVg==
X-Google-Smtp-Source: AGHT+IFB6g9DAfS5aZiKnPeU/B2GRvB7ggPHs56ZBVjfNQNIror2U71zlq6ZNBzyj0am1DCx0PLUG/IybIE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2da8:b0:6f3:ea4b:d232 with SMTP id
 d2e1a72fcca58-6f4e01b953cmr1373095b3a.0.1716247378082; Mon, 20 May 2024
 16:22:58 -0700 (PDT)
Date: Mon, 20 May 2024 16:22:56 -0700
In-Reply-To: <78b3a0ef-54dc-4f49-863e-fe8288a980a7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com> <20240518000430.1118488-3-seanjc@google.com>
 <78b3a0ef-54dc-4f49-863e-fe8288a980a7@intel.com>
Message-ID: <ZkvbUNGEZwUHgHV9@google.com>
Subject: Re: [PATCH 2/9] KVM: nVMX: Initialize #VE info page for vmcs02 when
 proving #VE support
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 21, 2024, Kai Huang wrote:
> On 18/05/2024 12:04 pm, Sean Christopherson wrote:
> > Point vmcs02.VE_INFORMATION_ADDRESS at the vCPU's #VE info page when
> > initializing vmcs02, otherwise KVM will run L2 with EPT Violation #VE
> > enabled and a VE info address pointing at pfn 0.
> 
> How about we just clear EPT_VIOLATION_VE bit in 2nd_exec_control
> unconditionally for vmcs02?

Because then KVM wouldn't get any EPT Violation #VE coverage for L2, and as
evidence by the KVM-Unit-Test failure, running L2 with EPT Violation #VEs enabled
provides unique coverage.  Doing so definitely provides coverage beyond what is
strictly needed for TDX, but it's just as easy to set the VE info page in vmcs02
as it is so clear EPT_VIOLATION_VE, so why not.

> Your next patch says:
> 
> "
> Always handle #VEs, e.g. due to prove EPT Violation #VE failures, in L0,
> as KVM does not expose any #VE capabilities to L1, i.e. any and all #VEs
> are KVM's responsibility.
> "

I don't see how that's relevant to whether or not KVM enables EPT Violation #VEs
while L2 is running.  That patch simply routes all #VEs to L0, it doesn't affect
whether or not it's safe to enable EPT Violation #VEs for L2.

