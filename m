Return-Path: <linux-kernel+bounces-307143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C095096490D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4006EB27FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602171B1417;
	Thu, 29 Aug 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQy7Re+Z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344518DF87
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943020; cv=none; b=aPWh+VW4TWfkboQTunJXywQ+J/kY+cPqnj6aFwCCaotBSQERjmdZr8KjwnARX+HSb8cqAGctALlpLIQiQVXrlPUxDyqj1DjqT+kThqrX9mNr+OLw5kkEl7JBrbaCHBNT0BJtKeood3FCnuEatXaozxRSUQ4jwPxCU/t3VXmvmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943020; c=relaxed/simple;
	bh=7owvFBq7H/zZo+uLT3Wf+SvWErVFCaIRpkT2UIT2MZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xolo8MnYpweOaon2x1/tPrw3jWks8S5cQYxAFVKPjU4EIs+/FUEPWhr+N5hg0OuaPRwI63QOS3tVaOvGL4LxORGByakRhrAmd7pk4KlH7q/VEhFAbFStYHtaI2o7vdGavzuN7DWjBOUyOe6qNVFSc1aiFjnETDAF1ETOFfg0Iy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQy7Re+Z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b2249bf2d0so16401207b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943018; x=1725547818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K40x/XxYGu996xFAIHnF019vu74x3oRUZW/VL978XPs=;
        b=mQy7Re+ZrfITiMdVQU6svtb/OfcE8Gcm6Y3/ua4uYA7vcvsDo+O5SmpttULsN+yxyj
         uSruxnwNjn3SPzGJ3fEBWOXf7k2daUiFsGYSYOE9PuBu4nZfz+YEDtsbqLRiKyOfrWK9
         3X7QV/cSEuVI6UBbMh8JXErqgz3m5paVkXHnWB5ONOMy2LmQyagG+y2Zyq09DRXPm1WW
         zW0N9SriY4DTbkihN/3wddehscaHoy7dxVbddhdw7ptK0sK5ohZLdGR+R9XjdZmdZZOz
         vP+dpUbbsKNF4DB4bE1QUEBc5XZKj4kVdSNpa9PNOO0ctH9DjjnMBnBAIx5Zqy1VvVNB
         vCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943018; x=1725547818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K40x/XxYGu996xFAIHnF019vu74x3oRUZW/VL978XPs=;
        b=OgXQilWLnCJNsk0L5iB2gQJarzePDdbbDgVp2kugYfUujz0O1nK/rEhEmsUIQwFdis
         ZUxxHHLmHXA4fZsVgoU2COVWVrdJefyKEo4l7/mIv/74C3v56iRear7gBARaR1bPEt1w
         Xep7sTRxyHuTKO0DxzEht3YG+W5Efg0furOxK4JVLddqVrdzqimKVDWmwaSz2O+o6a97
         sx0GQ8KVDFyH4R5UApsLZNEOxpzvumBRgv9OgSrY2Pod2N/QTrYh8dVrTL1fWX+wRJaf
         faIvMxnjuvY+a6+vnC/QYFALqt5hiNrkfrlxWdVG3f5n8BGemb2Y77/LXtfSwcvXigaJ
         fFSA==
X-Forwarded-Encrypted: i=1; AJvYcCVhQfsY79Nk5tA8WT4MwsbhgHMp3iKN7O/I8Woh1+W6yLuKtHLlH/b3dWHnSXsQevb0PZs/DivQC6V24Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13KJlMuFHST+Sf+912n2uXQ/aAqURQxAeUT5W8kazxW0Tm5Fa
	uzHnxxocRPHQhzce7dZ9gk4wFz8Vt5whYLtMOwwFV1yfoFGvChwC1HOnRNfmUQw/UNqaM9NAlHj
	DbQ==
X-Google-Smtp-Source: AGHT+IGmzsl+rb2EC+zOzjzhADg2nn9Mafe2WTKumDpKYR0ktqk4W9+2ZAHTw7zGoStxNYtfttKBQBxzE5Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:680d:b0:64a:e220:bfb5 with SMTP id
 00721157ae682-6d2e6f71327mr398347b3.1.1724943018336; Thu, 29 Aug 2024
 07:50:18 -0700 (PDT)
Date: Thu, 29 Aug 2024 07:50:16 -0700
In-Reply-To: <87475131-856C-44DC-A27A-84648294F094@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827203804.4989-1-Ashish.Kalra@amd.com> <87475131-856C-44DC-A27A-84648294F094@alien8.de>
Message-ID: <ZtCKqD_gc6wnqu-P@google.com>
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	thomas.lendacky@amd.com, michael.roth@amd.com, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 29, 2024, Borislav Petkov wrote:
> On August 27, 2024 10:38:04 PM GMT+02:00, Ashish Kalra <Ashish.Kalra@amd.com> wrote:
> >From: Ashish Kalra <ashish.kalra@amd.com>
> >
> >With active SNP VMs, SNP_SHUTDOWN_EX invoked during panic notifiers causes
> >crashkernel boot failure with the following signature:
> 
> Why would SNP_SHUTDOWN be allowed *at all* if there are active SNP guests and
> there's potential to lose guest data in the process?!

Because if the host is panicking, guests are hosed regardless.  Unless I'm
misreading things, the goal here is to ensure the crashkernel can actually capture
a kdump.

