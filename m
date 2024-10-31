Return-Path: <linux-kernel+bounces-391199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818B59B83BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF57EB21E97
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7463E1CBE96;
	Thu, 31 Oct 2024 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYB2S1km"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4951CBE88
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404479; cv=none; b=WMBtM/LWJuc3KufpjdzIHiSrFAmYbTPIpzcHZTYezbDgs59ogTsCKv7k4Ll+Ag0pij/p4Z5WD5BC6Kbm8a5WjFQtMh84DIKNgXnCL1BF5NaunoP/r5AaO4ZOH7xTNYaRL10V+wCCpvHz0pVT9Cmgq1VSlegTXcsfHwO8vpPvW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404479; c=relaxed/simple;
	bh=FZJmO/0nWtMIc1C67uozS/AO4KOMqF4YsxND6/5wyzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dX2D9u7BUVf73+L4gzdsugYplKz+VIfxgxC2ErSJG97lfmTBAdbQwXJisxFGgcm9TvwjSnB9iODuRq2As1IN7OU6z2I3dT0J7H5qrnsbCETWV6QzKHz/OxYB15Nu61XEP+dFlGOIijb0PptSCIy09h0RirOuiQWHQVHlXm/OspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYB2S1km; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2b9f2c6559so2061303276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404477; x=1731009277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Li5w4117oEfxJIQ/plzg7K0jEWXBrMaZ/ZZJ90PA74c=;
        b=PYB2S1kmgmrh/tML2fZFU1fNIJX97gJwLi7aa0ACpRHMbwdWwIUXlM+ZwbZnqUsOax
         ka4f3Y01WikV6Qhg6r8dx0zNllgokrL2S1Fiw08uTxwd2iAdUcT5rMrcpWh3dUrWXQYf
         7/Dl8coTcZ8x9aXufVU5xPRTz+CddFfAl6t4t6Bw5IPB5vPmeH4V9hbwyN8g48Nqqaud
         K3D0zAqUWLFyLqUip2EFI4POJVu7ChY733azwXY04oqZFRlUoNeDI1zeaEAhqfsxtp1M
         V03suU0SGzBCLVAf1lzsdfOD9qgeuIHLjJch5x9XVcBOoCM0REF3R4ka2dRX2dz+FkHa
         UVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404477; x=1731009277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Li5w4117oEfxJIQ/plzg7K0jEWXBrMaZ/ZZJ90PA74c=;
        b=vRdlldyJaGEzYLJGXem5B2TrseZpWpgt3wfvyT3eZZAQFnebN1wtBbcGi2gIxReMIY
         9vi724NMrz8/mL2c4vBsV9mzA/pRhg1mgzgESwaLVwFiQDtrkYI52D9hrO3voJCDJO4b
         /QSAM5Ff7eZvs2FlAny5D+UbeDac24vOGhYuUWUAKuwSjmzLrCVmexnnQ1MPslP1Ru+J
         EgCD7YSaa5GcjuY6aCUm1nSb1zeOOpTXSt2LskQfyAlZ1ZRAaDT+Uxu5lnPUmIA4NNTY
         lslNPFFOioJC7VelriM72+i7kYH9Rpxv4q0ZyzHm5lsH4z7HoeZN4fiBKHLEcl6CM1F8
         cDCw==
X-Forwarded-Encrypted: i=1; AJvYcCXz45Cvt9TUrVrT8BugASRN3QgoXqjG1+z+yKeITwMPZCKbr6+5mPuetFZAXNqWzLJRpunKsSOXKJVAQdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOr1EZqcHTFEtIBLjg9MwUjlddh0c3kuhvVNoXtr1ixXiq6Spf
	Zrbz4DMCoBOtKUTAfz19KmSCQobK6xcv3JZaL5GO4zeAh7hADnQKR8DXAMO42G/urFTiiZjUvXA
	x4g==
X-Google-Smtp-Source: AGHT+IEjSKx38AkziKnvpwa1pyyJb4RIVHhdqq42lYLH5ZkJRj7QjsXDK3d8azul8LNNnP6ZucJo5Fk96nQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:8541:0:b0:e28:e97f:5394 with SMTP id
 3f1490d57ef6-e30e5a3e278mr2560276.4.1730404476895; Thu, 31 Oct 2024 12:54:36
 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:37 -0700
In-Reply-To: <20240906221824.491834-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906221824.491834-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039506428.1508883.15289868954923615228.b4-ty@google.com>
Subject: Re: [PATCH v4 0/4] Relax canonical checks on some arch msrs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 06 Sep 2024 18:18:20 -0400, Maxim Levitsky wrote:
> Recently we came up upon a failure where likely the guest writes
> 0xff4547ceb1600000 to MSR_KERNEL_GS_BASE and later on, qemu
> sets this value via KVM_PUT_MSRS, and is rejected by the
> kernel, likely due to not being canonical in 4 level paging.
> 
> One of the way to trigger this is to make the guest enter SMM,
> which causes paging to be disabled, which SMM bios re-enables
> but not the whole 5 level. MSR_KERNEL_GS_BASE on the other
> hand continues to contain old value.
> 
> [...]

Applied to kvm-x86 misc, with some massaging (see responsed to individual
patches).  Thanks!

[1/4] KVM: x86: drop x86.h include from cpuid.h
      https://github.com/kvm-x86/linux/commit/391bd0c520c1
[2/4] KVM: x86: implement emul_is_noncanonical_address using is_noncanonical_address
      https://github.com/kvm-x86/linux/commit/6c45d62536d0
[3/4] KVM: x86: model canonical checks more precisely
      https://github.com/kvm-x86/linux/commit/1b1336d1d858
[4/4] KVM: nVMX: fix canonical check of vmcs12 HOST_RIP
      https://github.com/kvm-x86/linux/commit/14a95598b6e7

--
https://github.com/kvm-x86/linux/tree/next

