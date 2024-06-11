Return-Path: <linux-kernel+bounces-209227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7C902F32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DDD31C219AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196D16F919;
	Tue, 11 Jun 2024 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnVtCIp4"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEA2AE8C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718077660; cv=none; b=Di7Nj/IWgNnmC+JM0MHDkRndcFLcJRTO7efIG3/D8fyEuggg6vWkKsyHB6QHBxWbsGDdUbS7C1JpE/S0BlmhEYZpe8YOnl9ACZ2BM5GXmzZ2JCW45HA+iIkD0sg/6zuPQ8lPHVeXefiLiZoUBVUlOlHndBDeGOS34M+iU5XoR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718077660; c=relaxed/simple;
	bh=ImC9OdLsLq5zNZ6vdjGWmQM6DDhoKVkf/yl46Ae7Og8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdgS0WnJ+bfhGioqXSa2SYp1PPdr36E1dCiII5nurjpNkwIWH9Jf0lVogzN/xrX+/VIej7uBRMdJqdN5iu/WH5OjdvMoWn5zU1QKRpaoUP/P6bH06X/x5YfWEMW3D2+sOMtnBxupioDUzo78hmac7LfIzqIZSfPDucX8Ud3QjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnVtCIp4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so5580a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718077657; x=1718682457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl/RVYtUWAmdJmYhx3bWwluPkKF6eTc3z6iPlXxf8LE=;
        b=PnVtCIp4on/k1VCDLATSzAf8Pi1yHfxD3sgK9nJ9Ttt9I+hGWN0u+OR5GhpcngKuBM
         mbVjoo182IPxj3/AFLt/C44x5XKeC+IjZlJQYfameC9AsKT2codr2GAfEgjfpCqPUgXp
         a1KnuUPXypcs8eVV9gQhEI/IRZjI2TAPMDlFs/lFFcBi1rgDdhUBmHPDMieV/S+z/oun
         G8gwUFvGK1F44WnplhT2I4yZ9O9/gb9oE4epK9amAW/KPCeo1H9m+DREZqxFBCWuFHIi
         lUQbMmnyLlJ8pZqOl95jKomVshiTRFbHzdDtdxoxkRH00CSlhhtHEL0Tpni1S/XWEcWq
         gAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718077657; x=1718682457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gl/RVYtUWAmdJmYhx3bWwluPkKF6eTc3z6iPlXxf8LE=;
        b=lq0zvqsFKJiqhMX+QPpYFqt5UCQb0Q/u6tSkuFtlbKrCu8T4CkQZfiePRl4+HKPcJ+
         bgjwCm2EyyF6E9VZOBAHHVwf8PdFgykOrlR0/UVwArOUpFAy3kLmW8G836HP16TEc6Ix
         Hh2xlOsVJeFlguY8qtrjEok5V1Fy0K49icT3Iz0RizTmeKFHKZ+lg52km7H8jX65PYGL
         sVxGWHghfLXGuEUDY2qTQy2iYPX+3AhxBcj6ZaHh0bDSGWXYC1S57oNHaUl+0Gh8GaSa
         8SgEjg4bGpLQGOVWCt+cLZ/kJnd9gY/VUjv9TsbjJfuNcpLdqxW6iVEXdM+T7h6n4X1L
         xdbA==
X-Forwarded-Encrypted: i=1; AJvYcCWq6/HNUY2hFYfkiA+22OW1ucvevosUlCw2a2guz9sveJmMXKI0qW2ZbC2SX776Y+d4VMV5Q92lxLapFs1iYujFT/GsLh0CLvAqCTgw
X-Gm-Message-State: AOJu0Yz3rrlUUUaFqSLMAgYIWRgqng45r8jxEZls1zY+yGfZN+WqdfZh
	ZcXBlx2cUFj6J4q4927E1ve6bxd1tmtlqcO2JXpBM7IzFCliWH8/tM8R0obfSTkawargb7QHRYS
	F5kPv3BkPswhQSkwwRP9LUbTIWmyD/omCyT6e
X-Google-Smtp-Source: AGHT+IHrnelPx4R7r3XsfzngPJ9pvyQM/0CUQ9e4Z0bbrPV0pjxrPvjnITInnIVugp2O/RUIuuEIazoy4vH18TduMQY=
X-Received: by 2002:a05:6402:b74:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57c92510457mr152515a12.6.1718077657109; Mon, 10 Jun 2024
 20:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611014845.82795-1-seanjc@google.com>
In-Reply-To: <20240611014845.82795-1-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 10 Jun 2024 20:47:21 -0700
Message-ID: <CALMp9eQBd1yFA+w8X4EK1M+Dmh_MaEG=7POd-pexgA-wHWJBSQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Always sync PIR to IRR prior to scanning I/O
 APIC routes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adamos Ttofari <attofari@amazon.de>, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:48=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Sync pending posted interrupts to the IRR prior to re-scanning I/O APIC
> routes, irrespective of whether the I/O APIC is emulated by userspace or
> by KVM.  If a level-triggered interrupt routed through the I/O APIC is
> pending or in-service for a vCPU, KVM needs to intercept EOIs on said
> vCPU even if the vCPU isn't the destination for the new routing, e.g. if
> servicing an interrupt using the old routing races with I/O APIC
> reconfiguration.
>
> Commit fceb3a36c29a ("KVM: x86: ioapic: Fix level-triggered EOI and
> userspace I/OAPIC reconfigure race") fixed the common cases, but
> kvm_apic_pending_eoi() only checks if an interrupt is in the local
> APIC's IRR or ISR, i.e. misses the uncommon case where an interrupt is
> pending in the PIR.
>
> Failure to intercept EOI can manifest as guest hangs with Windows 11 if
> the guest uses the RTC as its timekeeping source, e.g. if the VMM doesn't
> expose a more modern form of time to the guest.
>
> Cc: stable@vger.kernel.org
> Cc: Adamos Ttofari <attofari@amazon.de>
> Cc: Raghavendra Rao Ananta <rananta@google.com>
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>

