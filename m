Return-Path: <linux-kernel+bounces-406629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C789C6382
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05D8BE38B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BEB21A4C7;
	Tue, 12 Nov 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/JZF92Z"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81756219E5A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440024; cv=none; b=GK7GfKusVTZW0YuJUy4pbM1oDzRTMgWyPFMeWWIojxThZ6QyaTy2IogdVJxEMjPGGy1UxM7DupHuolgMNFvnN58eLMm0TrSN9GzEaIvhYmbxKm3ZCD5JcTkff0oDU6MKxCUtGLmxYWU32jxeM9nkOOedrihAaC+Odwyw/0Btlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440024; c=relaxed/simple;
	bh=6C41LX4i9cTx1gh70EBFDyV45Diih+RA+d+s5h63nro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zbet2ZHjzYRTG87ymdMB2msR9kVVPOWdROVUGIiJ6U8xpD/t7IoNAfHxMtaGSQ72aKkp3OUKXqQ35zmMR9WzOqLVSGbO5tkUPsWFvfs2kDN75CGGJif50WzRt8mTogt7jfm+CQ8rDIebmjeiJrO6t8UWxfVCK3Brwr8z4Y0DAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/JZF92Z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38fabff35so55330437b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440021; x=1732044821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DY8XtbI4B5jvo0O8PmvLtsCSOMCPMY0S/opKq4djRSg=;
        b=B/JZF92ZZ78fLYjLCjvQJA4kERsYT0lsXr5A3of2i3ShTLPBvV0/nYaEo7YeR4g2Hv
         rcnUiRjKvs/sPo4ao9ME5nV7P5npSEXr7STVzTX6VmHDfkG18KrmlbeFbA2L2PyYoGqy
         TxBDl4MLYLLu9jnL4OVUhmp1vyaJo/cAEp6AqbXgHpBqrs+/tqTYZK1jtE/obpu002Bk
         GiMGkrjA1FwWqx0kK640NcEgO2hN96SPkoYluC5VgZbfM5BuO3oV8KXYyN5cviSPrmrp
         7OSQuhgjONrUZd+1O3w1gWHPGDioLBwbOCpFy1woQ+T92aDzO0hOKYN/Ug6ebmxdYFVn
         uldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440021; x=1732044821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DY8XtbI4B5jvo0O8PmvLtsCSOMCPMY0S/opKq4djRSg=;
        b=tqrLJY3J2mpkbu3mHjerbA/cCpWCUY6Ht522A0QORlasoBM/OPqWJN9sKoBMi0mFUs
         TR/qd8HAJECFocrJDojeDq1QNQL8j/NK/mu4MmwfLRc6mzL3mnJenwprBm4741KlYTpI
         16WRwg/HxoOoRa6NA7kEJRBLNx8SvkFOzNKl7iTFZ2VIm+bVQdcHCoudBSbphjKx64ly
         /rkZ+5nfIZpcoYeyv7n1WCoJMFO1YNbe3ZtfeSM3kjapZJbyzoEzczkQdP50kk1YBILS
         OG19x/7iB9xdEtUyIc88o/7BIm6vhrop7HSrQ6ZOXldSpHgwSOe4NvhzSfCLqsEKlGVD
         E9bg==
X-Forwarded-Encrypted: i=1; AJvYcCUaoajh4/sFlEodooHEPnVLcSYpTEV/iZ+wcVcl6rCcpparSWNVUByIsjQ4mPiP3cVjloAWfy1OEKV9kBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9saG0jJVrtAgC2maXgwIFREm9PQv57+ex6sLxnytfKWUEu+Q
	YdS9KgDd+6CLg6lJgZnst0zZiOcKHVkbjVXvXybRD3NYJl/xHkczv9Q+7sTSxJUrSc/4yNmXsiu
	5cg==
X-Google-Smtp-Source: AGHT+IEfiBnG43gqjtPlri+V2asF4S1cpViCIopZffwXn6FSbMi2vaF5IgSBd31XWNhwa69IX48SXk7pAsA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:addc:0:b0:e30:cee4:1431 with SMTP id
 3f1490d57ef6-e337f8465a7mr51655276.1.1731440021500; Tue, 12 Nov 2024 11:33:41
 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Nov 2024 11:33:31 -0800
In-Reply-To: <20241112193335.597514-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112193335.597514-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112193335.597514-2-seanjc@google.com>
Subject: [GIT PULL] KVM: Generic changes for 6.13
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull two changes that coincidentally happen to be related to vcpu->pid.

The following changes since commit 5cb1659f412041e4780f2e8ee49b2e03728a2ba6:

  Merge branch 'kvm-no-struct-page' into HEAD (2024-10-25 13:38:16 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-6.13

for you to fetch changes up to 3e7f43188ee227bcf0f07f60a00f1fd1aca10e6a:

  KVM: Protect vCPU's "last run PID" with rwlock, not RCU (2024-10-30 14:41:22 -0700)

----------------------------------------------------------------
KVM generic changes for 6.13

 - Rework kvm_vcpu_on_spin() to use a single for-loop instead of making two
   partial poasses over "all" vCPUs.  Opportunistically expand the comment
   to better explain the motivation and logic.

 - Protect vcpu->pid accesses outside of vcpu->mutex with a rwlock instead
   of RCU, so that running a vCPU on a different task doesn't encounter
   long stalls due to having to wait for all CPUs become quiescent.

----------------------------------------------------------------
Sean Christopherson (3):
      KVM: Rework core loop of kvm_vcpu_on_spin() to use a single for-loop
      KVM: Return '0' directly when there's no task to yield to
      KVM: Protect vCPU's "last run PID" with rwlock, not RCU

 arch/arm64/include/asm/kvm_host.h |   2 +-
 include/linux/kvm_host.h          |   3 +-
 virt/kvm/kvm_main.c               | 143 ++++++++++++++++++++++----------------
 3 files changed, 86 insertions(+), 62 deletions(-)

