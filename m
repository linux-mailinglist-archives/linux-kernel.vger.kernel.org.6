Return-Path: <linux-kernel+bounces-234676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4091C95B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29431C22AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9084C12F392;
	Fri, 28 Jun 2024 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1i3w6crr"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2163824B2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615379; cv=none; b=cURfgG+YtPuw7Hrkf8qhVO5C7du6lCTKbyZqp+Vht6Bm2LFTQtI3DHY284F18gO4XGIwbIswkqvXFpOKpS37UvEsj9hgZHXHNq/W1QQM1RiwZNF2s5a1aE70OL81bnx14mqFG423trW7rUj9aDK1SUHmJMBiaUe2h5I84d6bO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615379; c=relaxed/simple;
	bh=tYHwGPzeAgpklCMmG17VwiaX8VetjCTGdecbXelbbUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kWxySbq3Yv4GZuCtf9wxflCJUl2JEtbEiKT55+os89jywzwB1U6hvBVIJSl3NpxRNRBjaF6c6mhswlvZpEu7EA48PKnXxsohb9P3g3/cPpyqrUQN3FE+VynJ0AhlbzNcSQdAZr88gjQ1YZ3w1OE2eZEqKNVgkBCvbh98cp53GXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1i3w6crr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-72c1d0fafb3so927198a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719615378; x=1720220178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDxiiVVnrl82x4ZZMEBuMnAQFf8fEn2Km8Ydtn4qydE=;
        b=1i3w6crrMOB3lD6fXWDCjvcdEBG/t9q/Ziwz48DilkxHBwZ8Ybljy28mD/meJPcElU
         EI1tAjboUQ9dUUpTjy/ZZtNFOpmVzFK6s2nJw0qjX7DQlfNt6wOoIS09fp4e2ynF5rQ6
         1xBMr6fiOaFBxN9uehfgYF3SoenJU385lb2ksZ55z8Kc9qmfgZq/Oi2U1wjNEjMfwOfL
         RhKbz/jnslXFgWwxluvVG3ReBJ2WHWev8zMzhtRr90WT1zD4si9MKUZNJgmbpEB7Y/0V
         HNDpnDYw3AKTfT5N3kWsjPNpiD5SaEUamTxVwZCUJbPgsyjpT9Jrp6CCrm0mRSNzzKPN
         evRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719615378; x=1720220178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDxiiVVnrl82x4ZZMEBuMnAQFf8fEn2Km8Ydtn4qydE=;
        b=HG5hxm0siCriI3ehg0TgfYtvZmbLqK5x/RDrGvCle8BMAddyNU9/TL8TRafRPpK13Z
         xIn75c1LgaqisApfMUIKYlxOjO+m2xsUqPuSizUCWY/QNw0vwHbWNcwHvmDT/kB0dTzA
         nhJsAtr/xnYfYTMoLcV46gzcCPGQErYPZFTyXHsu8e/0lSwe9kyKvKr45dzkin/WHLZS
         DRzx+PL4wpED5lePVDFiOXZDlst91eWaQk08Qs4j+PdNLneCYSeI//2xzok9GeamUsK2
         4oJwvpbOvKyk7R3dbqviCo6PNQ01ZIht85B/K7qmgYM5PKTIxXYnuusl2urg4ROBZGHv
         rJvA==
X-Forwarded-Encrypted: i=1; AJvYcCVG2E+eUKLqInSBLOX9XiccCy3jz9kml+9qMU9QrFcH8T5fu5425E1AyXro8Wxct/FD3J8crrLSL3x//jsprB1nIdgSU233Z4Yyr2FN
X-Gm-Message-State: AOJu0YwGAosghb7t1KZdf+ojfvV8mBZ82PEZIG/r9i7XdO913KAGdL3c
	C00vVyfSWvJSMgH8DxYq2yIQ4eiozBRN1a3EtydKo1rjrNgPzpCgETaAgequJ8HFLNPZEgF0xxC
	U1Q==
X-Google-Smtp-Source: AGHT+IFuclu+QRiL03Nr/e3Jt+cogkBXUNrfgJqbhX0E0zDCMxVddXN2gK9vtSiGxK0P1fMNG/gRlzq8QuI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:117:b0:659:23db:a4b2 with SMTP id
 41be03b00d2f7-71b5f3516f0mr48811a12.8.1719615377866; Fri, 28 Jun 2024
 15:56:17 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:55:26 -0700
In-Reply-To: <20240622-md-kvm-v2-1-29a60f7c48b1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240622-md-kvm-v2-1-29a60f7c48b1@quicinc.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <171961376508.228791.6632768103700293303.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: add missing MODULE_DESCRIPTION() macros
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 22 Jun 2024 22:44:55 -0700, Jeff Johnson wrote:
> Fix the following allmodconfig 'make W=1' warnings when building for x86:
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/kvm/kvm.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/kvm/kvm-intel.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/kvm/kvm-amd.o

I split this into two commits.  The x86 changes went to `kvm-x86 misc`, and the
generic KVM one went to `kvm-x86 generic`.  I split them partly so that I could
opportunistically delete the VT-x comment from kvm_main.c, which was comically
stale.

Holler if anything looks wrong.  Thanks!

[1/1] KVM: x86: add missing MODULE_DESCRIPTION() macros
      https://github.com/kvm-x86/linux/commit/8815d77cbc99

[1/1] KVM: Add missing MODULE_DESCRIPTION()
      https://github.com/kvm-x86/linux/commit/25bc6af60f61

--
https://github.com/kvm-x86/linux/tree/next

