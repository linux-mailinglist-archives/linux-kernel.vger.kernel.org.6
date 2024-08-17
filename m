Return-Path: <linux-kernel+bounces-290471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0090795542A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C32B21F1B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD1E28FF;
	Sat, 17 Aug 2024 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SiAkUBc9"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF710F9
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723854154; cv=none; b=rmPzZitN6uIcs7JUW/Wd12HwuxOhzO8iykgOhqMHQ7CgSYU35hDUQW17lBLZRbj9f+zscg1T+LsYUuHJtnGU+fAlxFT4J1KldlpHSsdYudjgnV2GmJuqtefst7JvG8WeENZAvRlugoilQDoD44V/RGD9D5iI2MVytMb/L7OqPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723854154; c=relaxed/simple;
	bh=QQf1bIkol/q7MTydY3yyLcSFeGMt+1FUIHhUHoQsEAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KWpt6M7nZyfmOVgP08zmukU+D5m4Ao+9XPYCnl1XJy3SW3CxpfR52HyN0sqINdrseyTg7L+ar773X02q1S6k3+guV42F2Cw6ROKwJPHLFQAgmJCD5DWoWHy7EHf75iYC1+l931pGhWEeulDGZmKqUD3LVgWHq7VNRYuaYojfulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SiAkUBc9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc5acc1b96so23776565ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723854151; x=1724458951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wex9RE4Xv1E89xSyN/KGmWZh71FaVAljLAMHIavwNUU=;
        b=SiAkUBc9SuKRVs0rZYf06xDYam4DqxYA3AafD3sesWFy7HJJWAbuHMIQjfuXZzTw5H
         zPHQ56CO5JjTxDC0JIRyTSxSNEaWiHTnzMGP1BxGHdHmxZc8slXZwRAY/yIdMYBguzrn
         8BMZUVoLCLoVq/Z0r3au2sSH89r/4XJcCoEgfjOu+AS/Fb8l4MOrU3QqW1aTxRTgfvWc
         MMqGyfTeisRjSYCC5XNVGDqArBlKwWHLEQMcBgvYJs1gEBW2CvXAwHEwqNJy1jFwZ7sI
         3839CW0DrOoFjCrZj+Gj+ynOW3ayl7vtCWuxm05wLkqeIr9ot+5vYTOki4sDsDzcSSFK
         +yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723854151; x=1724458951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wex9RE4Xv1E89xSyN/KGmWZh71FaVAljLAMHIavwNUU=;
        b=WZMmPX6LPk2rynJ4CNKTGlK7Ku5wRtB11CRlAdRMVLccyzUefN8OOMUitf9IoPUTVH
         ZxQJgV8JpbVGLOXV5zoPWDuwfL3nTj4O9X8Fkoq6nV3ubD9szGsd6hzdLSTx3mhh+OP9
         7uIkdOs1duvELQvJlp1tGiY43NUBlPUBDn84olQoPsswuoZuokg3xQ8DzGcBYOTS25o+
         vfYvb19Q6thjWJVkWD/ECWF43kzxZW0crh2c8FCMJRgYKx6GLjZ6bNp6KiYqwqNZ83Za
         1aHIgfaCO/gHlI/LHKkh0w6yhQabnPaXcsUMrp4dOqOrZxxOrOiEsXDmXbUkBTM5TSir
         t+qw==
X-Forwarded-Encrypted: i=1; AJvYcCWR6emasdafeJFDInl3Q0K2ixnidU7xzwxeVFs7ZEL6sFU2ThJy4qB0uGNbcnFWqfQ1bWsjw+wP+T8oL6RVO6C6jYZcPrwk0i4pQuYJ
X-Gm-Message-State: AOJu0Yy+A2lgz+X4SAAJ/TxmlzP/CtyqQRS8zA9xTfukKCOVNQPy4zpa
	B5UO5GbedQsp68mJkrLIHZV5OOmxKZML4sWSLETP6af1lrld9vGu52KJwpsGD8KDsJ2H7MXy9TO
	1Qg==
X-Google-Smtp-Source: AGHT+IEke3GRU3gZRtwZUbx+4xSyQKjPnn2GeuUSY1oqt/amGpCpjgjhVGozOd5C0u3GywmaetTzHTxEQCs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c40e:b0:1fd:74a8:df4a with SMTP id
 d9443c01a7336-20203e97259mr4452825ad.5.1723854151378; Fri, 16 Aug 2024
 17:22:31 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:22:30 -0700
In-Reply-To: <b40f244f50ce3a14d637fd1769a9b3f709b0842e.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802114402.96669-1-stollmc@amazon.com> <b40f244f50ce3a14d637fd1769a9b3f709b0842e.camel@infradead.org>
Message-ID: <Zr_tRjKgPtk-uHjq@google.com>
Subject: Re: [PATCH] KVM: x86: Use gfn_to_pfn_cache for steal_time
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Carsten Stollmaier <stollmc@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, nh-open-source@amazon.com, Peter Xu <peterx@redhat.com>, 
	Sebastian Biemueller <sbiemue@amazon.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 02, 2024, David Woodhouse wrote:
> On Fri, 2024-08-02 at 11:44 +0000, Carsten Stollmaier wrote:
> > On vcpu_run, before entering the guest, the update of the steal time
> > information causes a page-fault if the page is not present. In our
> > scenario, this gets handled by do_user_addr_fault and successively
> > handle_userfault since we have the region registered to that.
> > 
> > handle_userfault uses TASK_INTERRUPTIBLE, so it is interruptible by
> > signals. do_user_addr_fault then busy-retries it if the pending signal
> > is non-fatal. This leads to contention of the mmap_lock.
> 
> The busy-loop causes so much contention on mmap_lock that post-copy
> live migration fails to make progress, and is leading to failures. Yes?
> 
> > This patch replaces the use of gfn_to_hva_cache with gfn_to_pfn_cache,
> > as gfn_to_pfn_cache ensures page presence for the memory access,
> > preventing the contention of the mmap_lock.
> > 
> > Signed-off-by: Carsten Stollmaier <stollmc@amazon.com>
> 
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> I think this makes sense on its own, as it addresses the specific case
> where KVM is *likely* to be touching a userfaulted (guest) page. And it
> allows us to ditch yet another explicit asm exception handler.

At the cost of using a gpc, which has its own complexities.

But I don't understand why steal_time is special.  If the issue is essentially
with handle_userfault(), can't this happen on any KVM uaccess?

