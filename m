Return-Path: <linux-kernel+bounces-210794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB64A9048B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689271F23D35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430463BF;
	Wed, 12 Jun 2024 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1VN+IPK4"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00704696
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157851; cv=none; b=UrIhn0jKZagkvoz+d5nauUGu1qO44111fLU7ciWcAigkz40RXJ/5eAP65wU7RS25XQgbCW3FAf2ccYPcfioyUXB7+R9d3Qdm3MxcKQbRJf5aJ0glAeB1NgPVV4q+oJZFTHmJiBdQwG0lbcYWLKRHqc0uVliLRTGzYnkhanNUBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157851; c=relaxed/simple;
	bh=0DPlTkS07FZrwdnRXWDEH1hCjKNYS7C/USz49ifWufw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ufrCtFQtzcDJDsjv0EJp4YS2N9B8xcSenucMnmlJ0H5hqUoolARQmueQRcCPC/+qi9geGWXldRZhrOmDECIkeNJNpJNoLiQrOffp/05D48DvOwyev0BsTLRx1TVsGgaYJU7THFh8/BeCKu6eaDt39MGnGz5Ms/7nO9Gea7KU/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1VN+IPK4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7043008f4beso2965171b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 19:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718157849; x=1718762649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXnVrUTMJFYjzKddbINiNlPIUhxMFsXMcMylDIRfeC0=;
        b=1VN+IPK4SWyWCHxYzxVIMbHepOdXcD2qs1POOX8yM9F7sZ+BNvjn9IqFeAZyMNbRZS
         UN3bkqQ3uzBWrMfJ5+y2MeKAXGvcfPzWumKx4pjhP3d5bbv/ZzQIX98Z0C/ocAaL4ci4
         3ySa3GeUPqIB0YlsAfubpcltMz1Q3zogmTnI9TDc2/0voGn2h5EkkUh0lExbimOkQY2y
         NcgO9oxAWgQ9FoaOZFrLJhk9bsf8R4OtjGC9z8hiM6VYpMRf685mzdx2WFRQjUnovD+y
         BqsNIhg4sCjvCuziJAHnx20hbeIYSvSkbEffsswitq1SS2rtzxGYDBxNYd8SorZC/hkX
         nlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718157849; x=1718762649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXnVrUTMJFYjzKddbINiNlPIUhxMFsXMcMylDIRfeC0=;
        b=ZemFUo58lnlVCmeUFLSZV/L5YdNYb5HtlbPCLoJpIkOqZwcFhmraetFUIAVp4EWUk8
         OZjlWDxU/nHR2PqaOOAUAJ9ZWIPCHb+aL0p+5SazzgYZSFRt/umLLqgi6bENOCqE5a5d
         AWEBfR2BdzVL3/LBwslafcNM/bQ5aVXdqPHffs+jSd57Q0PKh+AQcHyi7mODm40tzcSK
         1ttnOZab0vf2BKTh3HOhgZy/U7TFmcZNISL4ze7nJ9vtFL9HTjWCpVjlCrB1pi3+unge
         dz4ZlWwNc1l+GgWB7nQKnToKbkPICz2gxU9QHLSF5SCV17uL4Nj9CBqot+dy6q6+6U8E
         ZOCA==
X-Forwarded-Encrypted: i=1; AJvYcCVlf0S78dPoE2Yz0vNM6mjsC6Js2AMtHjq6+vhIDntLqn5+VL9TgsVOID+kxmvmjiOBHf8AIY5mc7TeS346yFKtJUX+Pfu1icye8maC
X-Gm-Message-State: AOJu0YxDfltnrSQLpj4q7gCJV39tBwtJJK46CTwIwBdD+vSktiYfTr7I
	2pWtzs6enxyj8nAg02wXIHq3lUwk9QzhF+zHzk1b39XUIpuo2V6h6tggax6kfmsh3vwAZg7bSov
	+HQ==
X-Google-Smtp-Source: AGHT+IH5FPrTorAscjXfc3OIIcg+n+F0jZHwu145CjOfyG5FYTz/Hz/lXRHCxgY6Vs4mMXVQCOdjphJn6FU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:895:b0:6f6:7c6a:2c02 with SMTP id
 d2e1a72fcca58-705bcecea17mr67040b3a.3.1718157849088; Tue, 11 Jun 2024
 19:04:09 -0700 (PDT)
Date: Tue, 11 Jun 2024 19:04:07 -0700
In-Reply-To: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
Message-ID: <ZmkCFyOXDC5KfC-5@google.com>
Subject: Re:
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 11, 2024, Jacob Pan wrote:
> To tackle these challenges, Intel introduced NMI source reporting as a part
> of the FRED specification (detailed in Chapter 9). 

Chapter 9 of the linked spec is "VMX Interactions with FRED Transitions".  I
spent a minute or so poking around the spec and didn't find anything that describes
how "NMI source reporting" works.

> 1.	Performance monitoring.
> 2.	Inter-Processor Interrupts (IPIs) for functions like CPU backtrace,
> 	machine check, Kernel GNU Debugger (KGDB), reboot, panic stop, and
> 	self-test.
> 
> Other NMI sources will continue to be handled as previously when the NMI
> source is not utilized or remains unidentified.
> 
> Next steps:
> 1. KVM support

I can't tell for sure since I can't find the relevant spec info, but doesn't KVM
support need to land before this gets enabled?  Otherwise the source would get
lost if the NMI arrived while the CPU was in non-root mode, no?  E.g. I don't
see any changes to fred_entry_from_kvm() in this series.

