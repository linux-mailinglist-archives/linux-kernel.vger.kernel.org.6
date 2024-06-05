Return-Path: <linux-kernel+bounces-202855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E758FD1F6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40A61F24108
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1585061FE7;
	Wed,  5 Jun 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPWEHlhR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FF19D88E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602294; cv=none; b=pKzLGQHFFb86g4jbxfgFs1et5gvB0l5bLVpxL6O3zlXzbyRGbe9zO8NSblHLQndcIPxlxyYp105ufdCIDCC0+QsrEbXbVCs1Pk2KVZE5QMuIzl5jnOzLU/+Hh2oJRq6Tgj7l007TjxQdQ2eOZwTTU4yDRf4kbZ79KaClBddV6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602294; c=relaxed/simple;
	bh=BVhfDmp7EMCJeUlCwY6gVCLaaetzqiVbZV7+bFTYkZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3Y1LJWWhIbpR2CNiqmufSCWCB5EPQ5CstwN/JRGVnnMA2nCJ3b49R3OYncYV2erbdrOpwvzmyTjrMhQbhlFjVqIsrTCU/NVlbwLJImE91wvraQ8qg+nMuj2KmEKdIoZfdZlqH7bN5V1FaMf52raiNkOeJ6hJ9ic10zPIJF8omQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPWEHlhR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627f43bec13so117413147b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717602292; x=1718207092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BC+wHIAAkSMG5ikZu33sScLTYzucBodRNg3gYHDfmYw=;
        b=CPWEHlhRI8V/sxjjwPIaEkOQE27LvBwn9waUbtgR7pzLSmLg5cDRVsf/jZx0E62zRC
         tRJWHKPT7UNo7Et5BXj95Q0UMCbutQDWfzVsHft2bw8JnO6rXQADKFXjW1pGZPMpNelA
         440ULFGF9gjJsGpkIg5kP6QG3CH2p4wEzHgchU9t75Yy3xsyNKL6KGhtPDH2pmWutBCw
         wgLhOIACZEO7EqrqMMshnDUVxBnO1ESotLUt6PgsPJ1j7icWDDaxOtdwPzoux8X/vJYG
         Y0x/biAg/rM5B8JUjjpvB908L3MlqE6C2JU832zzGfq+wCiVMudk4kl081WlozbPK6Bv
         V9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717602292; x=1718207092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC+wHIAAkSMG5ikZu33sScLTYzucBodRNg3gYHDfmYw=;
        b=njF3IaZ1/cdGDAm3VHV9M3xt0EcLSgOoIOBzMfR/Ax0LsqevzCyIm4yt479Zs8C2I8
         LVuFv85oZq92qCURuIs8zIaWJZHh8Mumwr41+4wPyzLpleBpav2N0yV7PiMzTXEPubkU
         8EcYvnkspQ1tusBNinsBzZlLSCFDMzbncMDQeS0Py2L9zcPCjiVxSC95zxmgivYrg/7d
         Q3bhGy7YA1SP5eu+gOpXxsd4MWIrYQqkDj+AHuMdt6VRir6U79pf1NhoNVPGQLPO/UD8
         oxaMvp5jfZEYsktltSjCM8+hDW7e5u5Y63vu7rLoTdRe221+n0KNvSOhwbw1E6pWyOy/
         QmzQ==
X-Gm-Message-State: AOJu0YwtXmc0tQMiprx56SCKbRE4TPqrHqDCNY2WU1w/fivDeUg/A1zH
	WidCo+RIIaw7kH7aoaGLZXipy5hYSD35HsLEP0eD4pxX/+yGGVsxKo0JGgo7MX0MmK2g5jMbosJ
	K/w==
X-Google-Smtp-Source: AGHT+IE2iOIzHVLwm+SJXUsDFZt6fF5GM2SMfLp5CkJVhKWqscYywtwdaJbJfiTEdC8yAdRWJJoeax6Ugeo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:85:b0:627:925c:cf31 with SMTP id
 00721157ae682-62cbb58de20mr7360197b3.5.1717602292014; Wed, 05 Jun 2024
 08:44:52 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:44:50 -0700
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Message-ID: <ZmCH8vH6VRdYHZWs@google.com>
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
From: Sean Christopherson <seanjc@google.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org, 
	torvalds@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org, 
	mark.rutland@arm.com, juri.lelli@redhat.com, joel@joelfernandes.org, 
	raghavendra.kt@amd.com, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com, 
	konrad.wilk@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 27, 2024, Ankur Arora wrote:
> Patches 1,2 
>  "sched/core: Move preempt_model_*() helpers from sched.h to preempt.h"
>  "sched/core: Drop spinlocks on contention iff kernel is preemptible"
> condition spin_needbreak() on the dynamic preempt_model_*().

...

> Not really required but a useful bugfix for PREEMPT_DYNAMIC and PREEMPT_AUTO.
> Sean Christopherson (2):
>   sched/core: Move preempt_model_*() helpers from sched.h to preempt.h
>   sched/core: Drop spinlocks on contention iff kernel is preemptible

Peter and/or Thomas, would it be possible to get these applied to tip-tree sooner
than later?  They fix a real bug that affects KVM to varying degrees.

