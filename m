Return-Path: <linux-kernel+bounces-289828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBBA954C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674562832D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2540D1BDAA7;
	Fri, 16 Aug 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmxBUOIY"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58B817
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817541; cv=none; b=c1GDXX9oKqAWW7ceNibO0bYO2rH6cmdBUEt7Cc374lWnibFmR880KONpHIV6yJGkWFCQET5Riom7oOMICtMWObRfoMQqDfG0t4Z8XORbK4MGzUiVXalyJ1/za8yAlv4UNilciU3NBy18FePFbYSbK+0TU09DLfS7xrUCY2si5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817541; c=relaxed/simple;
	bh=VYbyF+HrdvVkrnYQc6ZeYy2CpWFPLnio/X4LukFYzkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cFvnCKglu75gtD9/Ce/J0IlURYJWX3asNs5aeewxTfnlOvZSpuV8W9Y5XJPcASB8/3BU25okKCa2RxvHE8SC8XlP/DLIyYzvBxOI6PTJBtGDaHeMvCK4rJXdjvnTVekDqhY1jLZQ2/ILTJNqdr5XmSbkm5Wo34CZsBzBj1akjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmxBUOIY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-201f89c6b21so15460495ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723817539; x=1724422339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVUNWcnODzvW6XJwZ456FKRnFRY00JOKX48IktR25GI=;
        b=PmxBUOIY2NgA4dj64oNnzBUd8+AXVafPiF7fNwEM7u6aBEJkliYR6q0eupBusXHVba
         vZXPjiNYqq06Ss73/gPQMLES0kJkMx0oz4zwOOg63Tct/UFUtQQhCRAh8q+AfnQZZpuz
         HRk+GHZvxy3zxbINxH6gFFWBZQwz4Sm5qDkENiZIPAPN9HDrG+7Tu4uhALLHvYboLyMq
         AHWLzeQYl7Jg839xvWV+wFFPahhxuVGZf7ZtdyzTiqo4NRQmc1AEj5dVDEvGYmIcGP1G
         wX9+uTT/ixlLLKF2W6FLB+08D671GhnXrV1RtBhej2ptD5s+cTy4WIOqVGCrEArsNWTk
         4p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723817539; x=1724422339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVUNWcnODzvW6XJwZ456FKRnFRY00JOKX48IktR25GI=;
        b=LvwfA/0cebccmnv+Ue86Qw7j3muQrMEPVFxoFmHzUAqZuHPmVnOcnhwMBuMxfDaS/a
         bchjn2yZMm4Wp0vooJFjgY77gX7TKOuCUDe7owSQCnWdwmc7KOZGd9ajIxmZ8YaUTjx7
         O3JAwsS4m52aQWBTdCvsZP1kCE6d4+uIMSUzF9JMmwvrhtCDyWELwfstfIl3rEvu6OrK
         biHt065B4TWrrmptXbgwM5PmyV4LjhB8+UlYyv3sFvVHr7tCnRJ3rsgkx/gBdwhUb6cO
         KCgZlAB9wZf+TZofj5opvsZ5VNu2oaRPjjStqav+3e5VDdL+Em7zEAnnk+L1DLWA/G94
         R5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXKlCjnbHSSOQj2/vS1EkCZl3cHAoGRBnv1nEvLIw0dAC1wk7c2UuBURsP5rPvexAINsN0sEzJSckVuz5WUtcGCClaz/Ksxd3paJnjJ
X-Gm-Message-State: AOJu0Yy3anbGeZfilgZ5LVUo5uK1ZOQjd1HymQn5sB3wIaf8BvZ89Cy0
	qIIw3BCB0lao+C6agyPQsojGKTqKR8yqVjdlvL6bVk3uFEgJqylev2KQjlQbEynzuxfzawS1Y2V
	lCQ==
X-Google-Smtp-Source: AGHT+IEos5VlUKVOnDmduYMZV8tHrIqQZABYxJlweDXmJYF7fazHvJwYey2AyH4pkayOILvlUEx0MNTjeNI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e750:b0:200:ac2c:677f with SMTP id
 d9443c01a7336-20203f1cda4mr1405185ad.7.1723817539299; Fri, 16 Aug 2024
 07:12:19 -0700 (PDT)
Date: Fri, 16 Aug 2024 07:12:17 -0700
In-Reply-To: <20240709143906.1040477-7-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com> <20240709143906.1040477-7-jacob.jun.pan@linux.intel.com>
Message-ID: <Zr9eQdiIa-RiHGTk@google.com>
Subject: Re: [PATCH v4 06/11] KVM: VMX: Expand FRED kvm entry with event data
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org, 
	kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 09, 2024, Jacob Pan wrote:
> From: Zeng Guang <guang.zeng@intel.com>
> 
> According to FRED specification 10.6.2, VM exits triggered by events such as
> NMI, #DB, and #PF will have their event data stored in the exit-qualification
> field.
> 
> However, #DB and #PF are owned by the running guest, which is managed by KVM.

This is wrong.  #DB and #PF _may_ be guest #DBs/#PFs.  When host userspace is
debugging, #DBs may be the host's.  And when KVM is using shadow paging, or the
VM is running with a MAXPHYADDR smaller than the host's, #PF may be the host's
responsiblity.

> NMIs belong to the host, and the host NMI handler requires the event data
> stored in the VMCS for NMI-induced VM exits.
> 
> This patch enhances the FRED KVM entry interface to include the event data
  ^^^^^^^^^^
Documentation/process/maintainer-tip.rst

> derived from the exit qualification.

It's not "derived" from the exit qualification, it's stored there in the exact
format that's used by FRED.

