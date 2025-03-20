Return-Path: <linux-kernel+bounces-570076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE47A6ABC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3A7485567
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEA422370C;
	Thu, 20 Mar 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCZDSoOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA5222596;
	Thu, 20 Mar 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490891; cv=none; b=NsOmz67Qy7P0cU3/cKQHfUJXPf0llrfn+V6S1xQDSfJ98XZlmPSZiMK3kTAqPX05K6MVmCTB2dYpTmX/fosk9p1joCUUOsVcmNNdfJFWjHIstQi9J2RHzeGi4PdqF3vfLwl5E4pK+E7Fcu3Q90BWztsdzLRRcC0Wo+G9fvsElYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490891; c=relaxed/simple;
	bh=ew/lN1IMKa0aN4Z0/QC36U+fh07ns9tUoom4T4BzL1w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Msat+CIxNmo4PmnIbOKKJePb3Xsr/0mq39KIsWaqqid+U2EhL6j2Q5uGmhbkfgnIqTbxLHubxq/zCAEIo3Ccjcp653WaWL2BgFtl0oCCbkUyhj4sbzwUdf+CIdQemjfd8s6M4ZYGvoVennO7dwMFEz4iScJ/iD0T2W2M1AQDnuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCZDSoOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEA8C4CEDD;
	Thu, 20 Mar 2025 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742490891;
	bh=ew/lN1IMKa0aN4Z0/QC36U+fh07ns9tUoom4T4BzL1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCZDSoOi7psL8Pcu5B/ZafcXvbi20EkUJ0p0RiZSbQktauCNAVk3odFQWGV5/ULbo
	 TiulST5zMSgTkAPgyNHjmFOCXPEXeP2VY5zc/Kt4o91MkETAK36+hNUtWYc7mGWkN/
	 PakuJe183abPtH17Sk42zYZt52eGxZkHULV9q0WNEHRwF4HKqaEviZqTgbADgI9swP
	 4K5BkHbcBxznyKU6kvt7M3xGe6s2sNkZz/DH3pjSxoZbMvCWbNyTjt6Rn6Yst2tvsY
	 uciBIRALwIL6PUiw1ZouhYpjtpvusJJo/hz/TBFJ9GXVynmxqtw6DC9rsAK5zwvPqb
	 QCuI8F0wko3bQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tvJTk-00FWMt-M2;
	Thu, 20 Mar 2025 17:14:48 +0000
Date: Thu, 20 Mar 2025 17:14:48 +0000
Message-ID: <86cyebmxo7.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu
 <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	devel@daynix.com
Subject: Re: [PATCH RFC] KVM: arm64: PMU: Use multiple host PMUs
In-Reply-To: <ba9cd6d2-1ee5-478a-8102-42b4dac411ce@daynix.com>
References: <20250319-hybrid-v1-1-4d1ada10e705@daynix.com>
	<Z9pze3J2_zrTk_yC@linux.dev>
	<e8324d9d-3756-41cf-a102-28572e302368@daynix.com>
	<86plidmjwh.wl-maz@kernel.org>
	<bd681ec6-0b4c-47d9-8a4a-b7324c0883a6@daynix.com>
	<86o6xxmg87.wl-maz@kernel.org>
	<aabd71eb-286b-475c-a30e-d5cf5c4f2769@daynix.com>
	<86msdhmemw.wl-maz@kernel.org>
	<cd7b4528-34a3-4d87-9711-acc2c2e6f6e1@daynix.com>
	<86ldt0n9w1.wl-maz@kernel.org>
	<Z9sSMJAlf7cQ5viu@linux.dev>
	<0d84bc94-1c65-4737-a2eb-aa7f96a7d1e0@daynix.com>
	<86iko4m5i4.wl-maz@kernel.org>
	<ba9cd6d2-1ee5-478a-8102-42b4dac411ce@daynix.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: akihiko.odaki@daynix.com, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, kees@kernel.org, gustavoars@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devel@daynix.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 20 Mar 2025 09:52:59 +0000,
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
> On 2025/03/20 18:10, Marc Zyngier wrote:
> > On Thu, 20 Mar 2025 06:03:35 +0000,
> > Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >> 
> >> On 2025/03/20 3:51, Oliver Upton wrote:
> >>> On Wed, Mar 19, 2025 at 06:38:38PM +0000, Marc Zyngier wrote:
> >>>> On Wed, 19 Mar 2025 11:51:21 +0000, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>>>> What about setting the flag automatically when a user fails to pin
> >>>>> vCPUs to CPUs that are covered by one PMU? There would be no change if
> >>>>> a user correctly pins vCPUs as it is. Otherwise, they will see a
> >>>>> correct feature set advertised to the guest and the cycle counter
> >>>>> working.
> >>>> 
> >>>> How do you know that the affinity is "correct"? VCPU affinity can be
> >>>> changed at any time. I, for one, do not want my VMs to change
> >>>> behaviour because I let the vcpus bounce around as the scheduler sees
> >>>> fit.
> >> 
> >> Checking the affinity when picking the default PMU; the vCPU affinity
> >> is the only thing that rules the choice of the default PMU even now.
> >> 
> >> Perhaps we may model the API as follows: introduce another "composite"
> >> PMU that works on any core but only exposes the cycle counter. Robust
> >> VMMs will choose it or one of hardware PMUs with
> >> KVM_ARM_VCPU_PMU_V3_SET_PMU. KVM will choose the default PMU according
> >> to the vCPU affinity at the point of KVM_ARM_VCPU_INIT otherwise. If
> >> the affinity is covered by one hardware PMU, that PMU will be chosen
> >> as the default. The "composite" PMU will be the default otherwise.
> > 
> > This makes no sense to me. A VCPU is always affine to a PMU, because
> > we do not support configurations where only some CPUs have a PMU. This
> > is an all-or-nothing situation.
> 
> At least isn't it fine to have the composite PMU with a new value for
> KVM_ARM_VCPU_PMU_V3_SET_PMU?

Not sure KVM_ARM_VCPU_PMU_V3_SET_PMU is the right hook (it takes a PMU
'type', which is under control of the perf subsystem). But if we can
find a value that is guaranteed to be unique, why not.

> > More importantly, you keep suggesting the same "new default", and I
> > keep saying NO.
> > 
> > My position is clear: if you want a *new* behaviour, you *must* add a
> > new flag that the VMM explicitly provides to enable this CC-only PMU.
> > No change in default behaviour at all.
> > 
> > I'm not going to move from that.
> 
> Why not? It will not break anything guaranteed to work in the past.

It doesn't have to be guaranteed. It just has to *exist*. That's the
Linux ABI for you.

> Currently KVM only guarantees that the emulated PMU correctly counts
> only when
> 1) the vCPU affinity is contained by one PMU and
> 2) it will not expand
> 
> Breaking these conditions will make the behavior of the emulated PMU
> undefined. Now I'm proposing to remove 1).

And I'm saying no to that. I'm also getting tired of arguing the same
point on and on.

We currently have two different behaviours:

- either you explicitly set a PMU, and the affinity of this PMU
  constraints the affinity of the vcpus. The vcpus are not allowed to
  run outside of this affinity. Everything counts all the time.

- or you don't explicitly set a PMU, and a default PMU will be picked
  from the current affinity of the first vcpu. Your vcpus will be able
  to run anywhere, but the virtual PMU will *only* count when the
  vcpus are affine to the default PMU. When the vcpus are not affine
  to default PMU, *nothing* counts.

These two behaviours are ABI. They are not changing. They don't get
relaxed, they don't get tightened, they stay just as they are,
forever.

You want a *third* behaviour, go ahead. Define it the way you want.
But the behaviours described above will stay unchanged.

I'm looking forward to your patches implementing it, but I am also
done arguing on it.

	M.

-- 
Without deviation from the norm, progress is not possible.

