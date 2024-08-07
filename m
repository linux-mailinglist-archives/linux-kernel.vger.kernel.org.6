Return-Path: <linux-kernel+bounces-278616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415494B277
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6C0284AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD115350B;
	Wed,  7 Aug 2024 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPeKCPe0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE580143726
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067709; cv=none; b=Tl25z9WNLMstJumZkUdKjzO7C2/ej/kHvRff3+7Si2GCqoOHifECNA61qCRPKKRV1IZ+FUpUgp4CrlJuopBjQvGlyUqVX0ya2k/12Rz35dR21IH8Z/4qmqBu/K091wReininAHkciTduBndxV+eiXQZn4/XnY0F6ZarePeyEEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067709; c=relaxed/simple;
	bh=0RaV4CpVwa6q8JVt6a22lURVLu6pUkXISymVMTlfyCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mc9C+CNZd7pLJUzPTqSh3LtamsxR8gneTCgO72M0YiuWVThphvfMsB7rg3aDEJUXMhNJ1cSLvNCtJ3VCsgvbFsbHLMdBDesIBt1TCPnetO4GU1tdw4Kyuv8ifUzN5YzGIriRSqf5pIZ6hCsH9Ps7mcwz/rVYAXGtqtvv+TeUcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPeKCPe0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd34eso7380807b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723067707; x=1723672507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jANMjcKGEYQuIUsfuAhF8IG3wgp7bwuXo1MQfr3YT4w=;
        b=jPeKCPe0OFGdPPDzbDzTyjmt3eXw77r+VLdTTJlfr0diG/rHc8eY37hXOOCfNqYyn+
         eLjNJ2ljNXT+jyN1dQG2HAs5gsAklv9fvMB0Bd+ykvDYeAjcHmMl0yWZcULYDqmpuHV/
         a5NePODijvxDsZX95ISAHF4hpPdENsqNSg6sqy2KTZbs1uxkzev+38jQuhjxay66MpDC
         t6anVgG79jwgNLdKAqfQvO8yI3I73qmqT4Dw8C9/vdzKE3hWYlZZNgrzIMX8qQb1+DqZ
         J85kBbqXFAkTfbIfgHFSXXjl6VhOGfH94EUqGfVLg8R5IbiHK00XYMW5eSx+pWUUJG+x
         6Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723067707; x=1723672507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jANMjcKGEYQuIUsfuAhF8IG3wgp7bwuXo1MQfr3YT4w=;
        b=VWchI96rqzOD05jekdkKXfHXTMpcPGSL7HNApKwQuyHR+noDn/yNpQyNnTfy6IWomB
         5on3tQG3NoRXTsZWM8vfmIgdokUNU7/73Crzqo0Dzla88oqW2IqpjVlsGQrYSOPNS4fQ
         412kfxMXUnVKDBeOybtIWFDwWsOir0pWJWq7mvE6/36yiKQdL4VJHeBg/vQomhGaXIrr
         2/n1mXWbouQJP5u91s0pxRUk/LGP5cKy3BM+bCaiK9HIlRy6aKL3JqEn6YGPRoNrht5z
         zFNLGk1TGDzyc73DDtM0wo2VNX9rfKPmisKGQva5JYYG8ltbGevV+Edo1KxY0pLYCF/5
         hZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCW42sOugJCYO06i7YelnpCJKS2kFf3gpf6KHJH0Besmc/8IR+JgIoDoleK3xVDZ8dr5aXZnsmnORRLijoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+F/BYADzDdRngv1Ba5V4aJR7M4Pmy7ZU6943owgKu8O4qNKh
	3uVn+8uhR72a7CxMKpnlDSgpQBLyVraAQsHVdKpnfujNRhQu2y4fPjuevjZvBkIv2yg03dVN7Dh
	umw==
X-Google-Smtp-Source: AGHT+IHawM3vfj94ONnPgf7psPrnNPP7pjVi7qIXcjgJ6jY6ZsLJdawu91zUieFX3TNnShZQeUmn5QhR86c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b90:b0:e08:6e2c:69da with SMTP id
 3f1490d57ef6-e0bde229235mr129661276.1.1723067706742; Wed, 07 Aug 2024
 14:55:06 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:55:05 -0700
In-Reply-To: <87ttfw18jy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240807054722.682375-1-xin@zytor.com> <20240807054722.682375-4-xin@zytor.com>
 <87ttfw18jy.ffs@tglx>
Message-ID: <ZrPtOTHBfZ2e6RfV@google.com>
Subject: Re: [PATCH v1 3/3] x86/entry: Set FRED RSP0 on return to userspace
 instead of context switch
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 07, 2024, Thomas Gleixner wrote:
> Though I wonder if this should not have a per CPU cache for that.
> 
>         if (cpu_feature_enabled(X86_FEATURE_FRED) {
>         	unsigned long rsp0 = (unsigned long) task_stack_page(current) + THREAD_SIZE;
> 
> 		if (__this_cpu_read(cpu_fred_rsp0) != rsp0) {
> 			wrmsrns(MSR_IA32_FRED_RSP0, fred_rsp0);
>                         this_cpu_write(cpu_fred_rsp0, rsp0);
>                 }
>         }	
> 
> Hmm?

A per-CPU cache would work for KVM too, KVM would just need to stuff the cache
with the guest's value instead of setting _TIF_LOAD_USER_STATES.

