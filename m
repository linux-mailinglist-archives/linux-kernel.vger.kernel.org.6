Return-Path: <linux-kernel+bounces-203052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C5A8FD5A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236E01C231E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE9381B1;
	Wed,  5 Jun 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqzxFpPI"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27A624
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611763; cv=none; b=MCuC7ks+M2gt3dLzogIiA5Rtt5AEFmkkwP3biB03kQumnMLHDS1YOPSxs9bQd/4Eapl7HyHACog9qQt3hAZBlEr9kS3Fekvr16v8dR/fE/XAkkFK/aM6UhZh4XjaeypvLizZPznG/z74yv25ovn8lrVTwaZ98guQ9RH0hY3RLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611763; c=relaxed/simple;
	bh=8Yl2+w81FXnntMILRI1QYhAqwCRXphAGHKrQXeUqBIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCh7luCvxRYhVjl5QkDmaLr39kF9RdIiYPoSCU8SETurdEFODt8TazeRnijpMtepamsh4cOC9STN6U7GR+MkQFRj1siwWZfPHAOE/F85o8iVyril7EEUX/49F7DsIlB5nGePmzpwO03OACUoFtHcEkVGzLhKP223sh8hH8TbjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqzxFpPI; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d1fea41751so24797b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717611761; x=1718216561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOqedOYWtOVtPbtjeswNPTnq3pBDEi8nQj3J33r0HFU=;
        b=pqzxFpPI/wmfaTGjEpi+xJmPYRqO3qsJlr64ZezgIoQJc6rP85BiOWYfNJsEuHLWrt
         cQdwfA7XiXWwy9kC01ni3hMl7om/naNCLnkmI7cXm9V+29F5S0ZDmY+aikfjluPNuFXD
         OsAj7OH4HFYqVCNFFUsWvOEFG/nHIyZv1flz85a0R1uSSsdZoTFra86nP4mf4y4EASAg
         eBYVqJrWvwts3nAmQTZXDkyqgrfQuT8+3T9r2VYYHJmk0FZJbtW6nzKx3uNMEUJlK7hd
         hy8IP6Bs/jhu/YsWpOsVzVkvMU0y+8HNcBw2LO2Yx3BbPH8zGF9srEMRfQU4kq7gnbxw
         DYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717611761; x=1718216561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOqedOYWtOVtPbtjeswNPTnq3pBDEi8nQj3J33r0HFU=;
        b=hE1FQ6qt2Dv5zApw3qjb9CwEoccbZsopDx//6nLbWPLOmF/4nlDUX2+RUiq7WTe5CH
         nBv+wVBR5QD79M2QH8Qhz1q30vAvXAaA27QoXYk7yVs13dnVdSOfgoR4jlcJG7lxK8Z9
         b8g8oCdWHc4S72MRG2WqtP49v2DuomG6aqJu4bmb36AIebwckNUjY4/pj96J9F57XWNT
         /qO8ACH6Yyjpdeo2UtVzVViWq4W0Z8qRf7pqhelc6mloUtJEGAzKL1Y9qvGKyRlLL+Jm
         2ew/IDS0RWksF1Z2W+OzpZY1252MQNr3yLqyZcJmg91qS4b9HT8D8d2djldRtrriOe8j
         UoDg==
X-Forwarded-Encrypted: i=1; AJvYcCXGsjHOCf4Dqvt37IYusrdcbLQCUxMehwPWrN5tCpzy+AjglgurYyBgcAY5ldttwDPJQU6DxbbLuykCDhTw7KZtOmXBEPtamnaCDOcJ
X-Gm-Message-State: AOJu0YwpZZ539NIsIHPApwVWyaVQD8gZ5L4dfvxgifl+9Wrw5e6MhqVd
	NL7orBHDXulWGWZHGVpnQog0OnzesJH/UDHgPY0ogVPVnyF39KFZYYT/1hZj+9pHgjXg5PFTmJu
	yw8RinYPg3HKqhkcDh8wPvm/ns2hJKeHat8eH
X-Google-Smtp-Source: AGHT+IHsCbdc5SIxEdO83ZSuXLPQqM2CirxmFQGrXAysPbgK5BZQogLBsFsI95s/n1VGjNN6WgnF/fjK22vCs//hZXc=
X-Received: by 2002:a05:6808:8ca:b0:3d1:e7db:83a5 with SMTP id
 5614622812f47-3d20439d490mr3086311b6e.32.1717611760997; Wed, 05 Jun 2024
 11:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-kvm-arm64-sme-assert-v2-1-54391b0032f4@kernel.org>
In-Reply-To: <20240605-kvm-arm64-sme-assert-v2-1-54391b0032f4@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 5 Jun 2024 19:22:04 +0100
Message-ID: <CA+EHjTywH4BQNMpJokWgEiaD2zyc4rNisxSRDszogaxRBDnCdg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: Fix confusion in documentation for pKVM
 SME assert
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Jun 5, 2024 at 7:11=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> As raised in the review comments for the original patch the assert and
> comment added in afb91f5f8ad7 ("KVM: arm64: Ensure that SME controls are
> disabled in protected mode") are bogus. The comments says that we check
> that we do not have SME enabled for a pKVM guest but the assert actually
> checks to see if the host has anything set in SVCR which is unrelated to
> the guest features or state, regardless of if those guests are protected
> or not. This check is also made in the hypervisor, it will refuse to run
> a guest if the check fails, so it appears that the assert here is
> intended to improve diagnostics.
>
> Update the comment to reflect the check in the code, and to clarify that
> we do actually enforce this in the hypervisor. While we're here also
> update to use a WARN_ON_ONCE() to avoid log spam if this triggers.

Reviewed-by: Fuad Tabba <tabba@google.com

Cheers,
/fuad
>
> Fixes: afb91f5f8ad7 ("KVM: arm64: Ensure that SME controls are disabled i=
n protected mode")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Commit message tweaks.
> - Change the assert to WARN_ON_ONCE().
> - Link to v1: https://lore.kernel.org/r/20240604-kvm-arm64-sme-assert-v1-=
1-5d98348d00f8@kernel.org
> ---
>  arch/arm64/kvm/fpsimd.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 521b32868d0d..820769567080 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -92,11 +92,14 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
>         }
>
>         /*
> -        * If normal guests gain SME support, maintain this behavior for =
pKVM
> -        * guests, which don't support SME.
> +        * The pKVM hypervisor does not yet understand how to save or
> +        * restore SME state for the host so double check that if we
> +        * are running with pKVM we have disabled SME.  The hypervisor
> +        * enforces this when the guest is run, this check is for
> +        * clearer diagnostics.
>          */
> -       WARN_ON(is_protected_kvm_enabled() && system_supports_sme() &&
> -               read_sysreg_s(SYS_SVCR));
> +       WARN_ON_ONCE(is_protected_kvm_enabled() && system_supports_sme() =
&&
> +                    read_sysreg_s(SYS_SVCR));
>  }
>
>  /*
>
> ---
> base-commit: afb91f5f8ad7af172d993a34fde1947892408f53
> change-id: 20240604-kvm-arm64-sme-assert-5ad755d4e8a6
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

