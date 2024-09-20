Return-Path: <linux-kernel+bounces-334084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C501597D268
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6D11F238CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917713A3F7;
	Fri, 20 Sep 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0WuBoSGr"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E628139D13
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820293; cv=none; b=Zh5nOZj2mN+ZmWYf9J+N0/La0Su8JKUYKqOBT76ZXZDPydfUv5MFyQdIGMtGuqCJtYRYcmvD8xi9U45jBdApYmDYlxPoR5T2WhpqnKJ4xYMwVIT3WaXJeXjZ1FsgZVRd3oW1EDVJ0BQM43KsQ/O8te3aEErDdkOp8lHdhdglIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820293; c=relaxed/simple;
	bh=RAQrRvtbIqXdLwHQwT/AKIvCp5PD00AGUk+DKN/PzkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vGUdx23h/tMgltvRwc+A3e+Cdz5xeCETeWh1xDRqEOx/+Jk91LHj9CEftPksweuSaXlrzcIp8AO4NsGmBays0rNA01WTrUaXgo9ermPTjVZAx/5F4aKoclL59pIvR4y1k+fP50Rh+TrccVEjW+X0SiuO2NIb8vic0XuLstm6oSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0WuBoSGr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so2927032276.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726820289; x=1727425089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/uRJgyLOLddEMNrdHfSjNAL0ubIHrvPY02GX6Qup/s=;
        b=0WuBoSGrHo13D7kyKV/Q4R+1i/xAqRWYPGgc+0KI/q7ul+CqwCdXwyynoJQNnuWV5R
         nC2sI6Bz83gGI0yMd5OnZhJ1p2RogpxILGNP3ByrXZbrgQHXvg7xo0YL4onIzQ73QOPe
         zeDr1Pl9ffGYL0t4C9MGZqvZ18xSRSGPwVbKomUCwHaKaPDhYJ4D1p9hkBTJoGtxC0yc
         adPiF6iurJCuLYlix4YMOAhcf62gWExdql9mbnfUlShk5OicosaLmj3YfS47CIl/lLnY
         by8BYczVlgBNVP9aVLzLMsL6MhPN7+rsittJrL1Ux4jHq807gxK1PmV+knZ/RyyKp5Pl
         IL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820289; x=1727425089;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G/uRJgyLOLddEMNrdHfSjNAL0ubIHrvPY02GX6Qup/s=;
        b=D+4kxX2NzFK1XkUfs3OfKzISRuvZHUClvwJcPSRFurisrHCNEAMJYNLW41XXBkHRuW
         4SBv3PzuaQuhYBCYcWZ+yQwii34nDnVKJcUIwlbHxc+WmPF1pt1EBsoXRpSVXJh72SO+
         r8+dfssXfoAltT8hquV6YJgM+Cs/BGkRZHOSF8vxBgUIp3oTqa1Ie9ka6SU8Gqdt4/aW
         HAyW6LZCdNC4N9r4XBS18jFSs1nPzlx7w5uLOFWtgChFn35jwPOpeIi+msFouVbnOI3m
         yuGNlyWU1IGdVqkEKsMtjrNjp73Y1Iz5eSVOd61SxniWxYYbuRqANTHRHqgU93Wd48Wp
         uBug==
X-Forwarded-Encrypted: i=1; AJvYcCWWY8vqi7EPN3JoV9vPchsqH/i2rAE55FO+nOvNmmym7mFcn5X1J24+/sug03XQbxRvDljvZ0H3mILsj44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TxMQvN+KDwSpFyNBhriQ2vuwM3cpZos/l4BbZzHxeppLaJIC
	oi9+dq3johxmnYynufbOXw+Eyf9RgQ44CDzWmNB0bLM4G+1deA5910tyCaFsf++fwEvn0FIXFMk
	OFw==
X-Google-Smtp-Source: AGHT+IH2cetVHeWWdupsX/QGjDvXhnZwXWbzfvZX7m34wcYgwGDvwUA0kxLlrpZ7xGI3OlYmd0LLvAvK1TM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:b0d:0:b0:e16:67c4:5cd4 with SMTP id
 3f1490d57ef6-e2250c2d5demr1864276.4.1726820288549; Fri, 20 Sep 2024 01:18:08
 -0700 (PDT)
Date: Fri, 20 Sep 2024 01:18:05 -0700
In-Reply-To: <20240920080012.74405-2-mankku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240920080012.74405-1-mankku@gmail.com> <20240920080012.74405-2-mankku@gmail.com>
Message-ID: <Zu0vvRyCyUaQ2S2a@google.com>
Subject: Re: [PATCH 1/1] KVM: nVMX: update VPPR on vmlaunch/vmresume
From: Sean Christopherson <seanjc@google.com>
To: "Markku =?utf-8?Q?Ahvenj=C3=A4rvi?=" <mankku@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, janne.karhunen@gmail.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024, Markku Ahvenj=C3=A4rvi wrote:
> Running certain hypervisors under KVM on VMX suffered L1 hangs after
> launching a nested guest. The external interrupts were not processed on
> vmlaunch/vmresume due to stale VPPR, and L2 guest would resume without
> allowing L1 hypervisor to process the events.
>=20
> The patch ensures VPPR to be updated when checking for pending
> interrupts.

This is architecturally incorrect, PPR isn't refreshed at VM-Enter.

Aha!  I wonder if the missing PPR update is due to the nested VM-Enter path
directly clearing IRR when processing a posted interrupt.

On top of https://github.com/kvm-x86/linux/tree/next, does this fix things?

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a8e7bc04d9bf..a8255c6f0d51 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3731,7 +3731,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool=
 launch)
            kvm_apic_has_interrupt(vcpu) =3D=3D vmx->nested.posted_intr_nv)=
 {
                vmx->nested.pi_pending =3D true;
                kvm_make_request(KVM_REQ_EVENT, vcpu);
-               kvm_apic_clear_irr(vcpu, vmx->nested.posted_intr_nv);
+               kvm_apic_ack_interrupt(vcpu, vmx->nested.posted_intr_nv);
        }
=20
        /* Hide L1D cache contents from the nested guest.  */

