Return-Path: <linux-kernel+bounces-299783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9495DA0C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9320AB22A22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607E11CCB2B;
	Fri, 23 Aug 2024 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWstTs4b"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509101CC889
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457517; cv=none; b=ESbMk5tvGPiBAgVdk8qZ8JEfX7rkqJW0wJDqI1uKhkcrm0kAhBfzCfBSYjMfmnJMI9uP2v4h7oYq7RYLsLPmB1EtpF3X1N70fFiAZ6ico2/A2HgcBRgBOmkpqeB4yk4jVtjLrD3H7ujgcDYPJ18KmgFumkGxA2NwCGiBEXBnXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457517; c=relaxed/simple;
	bh=j9n9mihYRZQWqjE2BiPF54wUkj6Ln3alQNJ+sPErDyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AAg40iN/ARioOSZqBO+jjr4vcwtZb0jtIKC21o3Sq5FffpdF8YK5CXc/DeSKu+kvBrtWidffGxbkTjhjmmFr3fVrBT1OglaqbjNYjFj40yA0MRHJPD9xrl6/snu0xdeOjkuP4sJqOpVFofjX9bIsJnGZQask1UfmEPs0ZxLziFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWstTs4b; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-72c1d0fafb3so2093798a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724457516; x=1725062316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfCUjrQDJHRwDLv2K8QP2itmDGlYky0q8hGNP2iYfJE=;
        b=sWstTs4bJ1CRg9DAEuAioof+AUOrkLM8VzJlS0hIGSPphFq8vOY2cbRnyuiPMXegjD
         KE62f/gs9YyuAR61id8d57+DGGerOFR8AY4QzC6rgOElajWb1Y8lHBfp2+Te0+JneAvf
         AuRz9y6WnwvlFtwpZ2TMn8aCKjfFCtdtypYZP2Es+ObCV7Grcu9YQ+msyO6hHQCS3bBs
         pgKgwBCgK3DhY7E0fdtAdrL9zFfZsvKR2wae3DKVndceFJ6wGsVXqMYqxuSXJVTWin+1
         a/D2mUZjJcRxYKFZmkIVezuMoj05Hg3D+t8rlEDeL5YgSpAunrplI0Exxz1Pz5yt8BPU
         gpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457516; x=1725062316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfCUjrQDJHRwDLv2K8QP2itmDGlYky0q8hGNP2iYfJE=;
        b=EePoT2HSWIgzE+rzuSPgwOn5O7MMfZVCJkw9RZpl2X4HZ6B/n2baZSfT8lAQc2Es8M
         k1PVIAw0sjtbbgJeTcw4yRED4qlpOCzzo8yX2qX0ShzAuL3VNChwnQXmsCLoHC3B3d3d
         GaWuGUtV1jD5xTQGCeHjIMIj/VBAQ5gB5q5irg7AdfeouBukgJxYI3yk6mQfdLFpA/vv
         TAvt4fxVNjufGsqiwp4k/TXRL2jBiUZbq29pGOhb8d61xCzvxU1xF08pNm/sNVCEsWfa
         EVk8okEjhWk1e20S6+XGd5PhaNukSvHu1abNjRA/5oi5PhtkDSXkB74pWG2ZEzUY3gJc
         ykmA==
X-Forwarded-Encrypted: i=1; AJvYcCUWVk4FJkh50BRUrt8qBQt3BBwvFUTqgc6ZASVuTcmFgllMC7ItyikGjvZ3SaFV29ePp9rXujK9slIUOXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuc5NpH9pvNdB2/a9r3dzph9oYi41BfN8fVhCHynjnspaiW1nu
	9plUvu8K1wT60XpmEaRmnTmKd5eHq7a5NwyhXiMQQq5eF1BFa2KJ/3Zh4cRslVVuiebcD1dsm3m
	+Rg==
X-Google-Smtp-Source: AGHT+IEMneYevLNK6j5An26pw/VuJMCAprEGtxP4I1Ef3Vx6HAx2pi+/oo4hOIwzOzxg8N/cd2ztxgQkDOU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:b24f:0:b0:6e7:95d3:b35c with SMTP id
 41be03b00d2f7-7cf54e73722mr6516a12.5.1724457515455; Fri, 23 Aug 2024 16:58:35
 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:48:07 -0700
In-Reply-To: <20240722235922.3351122-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240722235922.3351122-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172443876585.4128342.15040275219129929508.b4-ty@google.com>
Subject: Re: [PATCH] KVM: nVMX: Honor userspace MSR filter lists for nested VM-Enter/VM-Exit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 22 Jul 2024 16:59:22 -0700, Sean Christopherson wrote:
> Synthesize a consistency check VM-Exit (VM-Enter) or VM-Abort (VM-Exit) if
> L1 attempts to load/store an MSR via the VMCS MSR lists that userspace has
> disallowed access to via an MSR filter.  Intel already disallows including
> a handful of "special" MSRs in the VMCS lists, so denying access isn't
> completely without precedent.
> 
> More importantly, the behavior is well-defined _and_ can be communicated
> the end user, e.g. to the customer that owns a VM running as L1 on top of
> KVM.  On the other hand, ignoring userspace MSR filters is all but
> guaranteed to result in unexpected behavior as the access will hit KVM's
> internal state, which is likely not up-to-date.
> 
> [...]

Applied to kvm-x86 vmx, with a slight massaging of the docs as suggested by Hou.

[1/1] KVM: nVMX: Honor userspace MSR filter lists for nested VM-Enter/VM-Exit
      https://github.com/kvm-x86/linux/commit/653ea4489e69

--
https://github.com/kvm-x86/linux/tree/next

