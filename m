Return-Path: <linux-kernel+bounces-439666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F989EB268
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652F7161CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C078F36;
	Tue, 10 Dec 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng2saVv7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6291AA1FF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838975; cv=none; b=WdNNOdgr/qY4Bhxtinl4W4wwhhmQYvoT8/K71odhbO3rR0ds10ANH+B0ZiB/rKqADqvspsSGUHbGQtRjZ385UKkaL5ncR+w/fzUEvkfJ+589H8V8E6jarRYXe2tylbuOIfwJC99ABgV8kvd2UroYqg+I7PKD8tHTXsM1GgA+vYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838975; c=relaxed/simple;
	bh=81SDwr+i7U7nSFtgaowgS3f+OVFldJCp5ag1L+YrymY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkhWqpUxxY3u2lbe57KB9uvfvPUV5H5VJoeEevOPOL7EDQt04MkQ8Wi6AJy1fcIA+Bz1ml+aMxIDjC+TgsqMV2hcKQa2NZo6AEcRhB6RMGZT+t7yMmiuVlL91tS5LT8ndkF8Z46DODJTYvfgsDoH7Hx6Z4JwL2pF5sckjqDb18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ng2saVv7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733838972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSFsmOdcddKIbSt6Sh45W8nB+T2Eq7+gB4QNkOWTcWE=;
	b=Ng2saVv70MEv9+/cb+PBZG4PR10FNdZ50RwT/K1vU27GkpHqQ8U0Juekkl33oVsIdlEMki
	XaPUx+2d3ivxqE99o/d68kdw2wZsMZtxlwFMYFqdEyN3qZQWp2FDhSmRHohHuR4ifzM4Zv
	68JOc8ZE4oo/w1vdW6B74uXdlOe8zck=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-ATZUGJlGPH287r4CgJ85Vw-1; Tue, 10 Dec 2024 08:56:11 -0500
X-MC-Unique: ATZUGJlGPH287r4CgJ85Vw-1
X-Mimecast-MFC-AGG-ID: ATZUGJlGPH287r4CgJ85Vw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43619b135bcso1705125e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838970; x=1734443770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSFsmOdcddKIbSt6Sh45W8nB+T2Eq7+gB4QNkOWTcWE=;
        b=q7CJX73JDzejCJmK6oqcSj1mZkTz5C//d10MYou9oivmAgcRMOTL/8vyNzAu5zlDMw
         y0yLX5qUmRpcviAqyzuTelcblwLyjS/FMDKr90Kewk92pax7Zfs1R6IbyWW4t9jvrbBI
         V8lazVQxehbkqvs/2XrahxVZNPeQFNgaDOL/eJbRNmTRkcp30wuCh9+MkeDQe0ZUbIKU
         kYUeYgn+p4dP7KP8vFom7YLAT3i5iqz7iuxwKondAhgI/V08g/i//kP7G7k+2gz/6zsF
         HZItYzvvADkt7P8jnDrNgSzuhjjhkpkOo2Uxx/7PKWzBTQEogJycJcXPispcUVjZskXy
         mrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQlDCYPTe7K9yp0QtpbaM78fA2iTstD1V7gwponvybpzU/RHw98jEKmAbeN6Sc+CVaH4F7J3MMee58dzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfpfr7PYCvm9vkrr0BT26HlmbwOrLddwOuL1/kBeC4m8A1X4Fg
	NX+jfTx9wwu2JDRtwT4lOOuI23u3bsocwVLYoO9Uf8Nq6BDmZcUp4nywLXpf+rjUPi5cB8mtLfm
	c2I2a/oqxJMOEbGt6f6HTgitBw5t+IUMPNb8A/GjsBirS3P4YBmJn/+ClzQVSn3DX+SchsRarmi
	hIg26/5l6WFLtSgoK5SdFDXHk3n4yX2betHuEb
X-Gm-Gg: ASbGncuJjkiDZ8icFeml/2Zrhz0TNdQlWnJb7AWLhhsT52BdRp5q0pbKbhCadHbmozW
	juBSlC/QgXYLg1QJm9bnpuip19lpXV71Bymk=
X-Received: by 2002:a05:600c:a46:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-434ddeb5573mr131813285e9.12.1733838970197;
        Tue, 10 Dec 2024 05:56:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGT6PKtby95Y/i0ysLL1kDTYIt+/yB6BbpbwY8jHyRrAnXXeBFggcg1I6c0FSATV4N/GlcZ6ogQmesGlCgDfo4=
X-Received: by 2002:a05:600c:a46:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-434ddeb5573mr131813105e9.12.1733838969816; Tue, 10 Dec 2024
 05:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0-n5WnAg8tBjLhG@linux.dev>
In-Reply-To: <Z0-n5WnAg8tBjLhG@linux.dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Dec 2024 14:55:56 +0100
Message-ID: <CABgObfZqKKAmJuL+awFFQ8Y1+GvTOWNuvPGav9Y0DVWRhC7EOw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 6.13, part #2
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Keisuke Nishimura <keisuke.nishimura@inria.fr>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Marc Zyngier <maz@kernel.org>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:53=E2=80=AFAM Oliver Upton <oliver.upton@linux.dev=
> wrote:
>
> Hi Paolo,
>
> Another week, another batch of fixes. The most notable here is the MDCR_E=
L2
> change from James, which addresses a rather stupid regression I introduce=
d
> in 6.13.
>
> Please pull.

Done, thanks!

Paolo

>
> --
> Thanks,
> Oliver
>
> The following changes since commit 13905f4547b050316262d54a5391d50e83ce61=
3a:
>
>   KVM: arm64: Use MDCR_EL2.HPME to evaluate overflow of hyp counters (202=
4-11-20 17:23:32 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/ tags=
/kvmarm-fixes-6.13-2
>
> for you to fetch changes up to be7e611274224b23776469d7f7ce50e25ac53142:
>
>   KVM: arm64: vgic-its: Add error handling in vgic_its_cache_translation =
(2024-12-03 16:22:10 -0800)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 6.13, part #2
>
>  - Fix confusion with implicitly-shifted MDCR_EL2 masks breaking
>    SPE/TRBE initialization
>
>  - Align nested page table walker with the intended memory attribute
>    combining rules of the architecture
>
>  - Prevent userspace from constraining the advertised ASID width,
>    avoiding horrors of guest TLBIs not matching the intended context in
>    hardware
>
>  - Don't leak references on LPIs when insertion into the translation
>    cache fails
>
> ----------------------------------------------------------------
> James Clark (1):
>       arm64: Fix usage of new shifted MDCR_EL2 values
>
> Keisuke Nishimura (1):
>       KVM: arm64: vgic-its: Add error handling in vgic_its_cache_translat=
ion
>
> Marc Zyngier (2):
>       KVM: arm64: Fix S1/S2 combination when FWB=3D=3D1 and S2 has Device=
 memory type
>       KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits to be overridden
>
>  arch/arm64/include/asm/el2_setup.h |  4 ++--
>  arch/arm64/kernel/hyp-stub.S       |  4 ++--
>  arch/arm64/kvm/at.c                | 11 +++++++++--
>  arch/arm64/kvm/hyp/nvhe/pkvm.c     |  4 ++--
>  arch/arm64/kvm/sys_regs.c          |  3 ++-
>  arch/arm64/kvm/vgic/vgic-its.c     | 12 +++++++++++-
>  6 files changed, 28 insertions(+), 10 deletions(-)
>


