Return-Path: <linux-kernel+bounces-252303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AE931143
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A567283873
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F18F186E4A;
	Mon, 15 Jul 2024 09:35:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2218628E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036118; cv=none; b=Q/kTHe12nTzbQ6bDNVSbnwpQjEf+UA+FVbieLDrH1Qdnewj9Xlkq4U/9nERly0/aNu++ENPVtzx+M6k5HSX1Ou9SsaZq71t0P36HRJsajxEnEegtxJyrdmhRpz/VZoUKWOQbdUO7T7r/acsri6DldMnuG+ZpjLRXNuBYfvqwlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036118; c=relaxed/simple;
	bh=d1IpJnFsGxD67vL8DzTqGrx0OM5HaJZP/Sd8M6qzcDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOWE1cf17w5BcIFM16stAtN9VGya7gAo+J2PxEmzhorLy4/eg7S/61kOtwr9hlgbssKQam/ld93aUMuVY8d3NkRMtUJVL+b4zYCtV6MMoSYK+mZRYaWy+NHGbcdx09N8/bCZu2Tf2AIgADjkhzKGrf+iF8Vd/7P/qtjWVr+T2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0747CDA7;
	Mon, 15 Jul 2024 02:35:42 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C08CB3F73F;
	Mon, 15 Jul 2024 02:35:14 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:35:09 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Sebastian Ott <sebott@redhat.com>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 1/3] KVM: arm64: fix override-init warnings in W=1 builds
Message-ID: <ZpTtTQ-ysRGw2tZG@J2N7QTR9R3>
References: <20240712110332.10970-1-sebott@redhat.com>
 <20240712110332.10970-2-sebott@redhat.com>
 <8734oep96j.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734oep96j.wl-maz@kernel.org>

On Fri, Jul 12, 2024 at 10:55:16PM +0100, Marc Zyngier wrote:
> On Fri, 12 Jul 2024 12:03:30 +0100,
> Sebastian Ott <sebott@redhat.com> wrote:
> > 
> > Remove double initializations in cases where that's easily possible
> > - like extra NULL initialization in static global structures. In the
> > other cases just silence -Woverride-init.
> > 
> > To fix warnings like the following:
> > arch/arm64/kvm/hyp/vhe/switch.c:271:43: warning: initialized field overwritten [-Woverride-init]
> >   271 |         [ESR_ELx_EC_CP15_32]            = kvm_hyp_handle_cp15_32,
> >       |                                           ^~~~~~~~~~~~~~~~~~~~~~
> > 
> > Signed-off-by: Sebastian Ott <sebott@redhat.com>
> > ---
> >  arch/arm64/kvm/handle_exit.c     | 5 +++++
> >  arch/arm64/kvm/hyp/nvhe/switch.c | 6 ++----
> >  arch/arm64/kvm/hyp/vhe/switch.c  | 3 +--
> >  arch/arm64/kvm/sys_regs.c        | 5 +++++
> >  4 files changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> > index d7c2990e7c9e..2c049746657c 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
> > @@ -291,6 +291,9 @@ static int handle_svc(struct kvm_vcpu *vcpu)
> >  	return 1;
> >  }
> >  
> > +__diag_push();
> > +__diag_ignore_all("-Woverride-init", "Allow field overrides in exit_handlers");
> 
> The wording you are looking for is "Silence stupid warning". I really
> mean it. There is really nothing wrong with this code, and if the
> compiler doesn't understand the purpose of a default initialiser, then
> *maybe* it should be fixed rather than polluting the kernel with this
> stuff.

IMO this would be a lot more palatable if this were an attribute on the
struct or assignment, like we asked for in the past:

  https://lore.kernel.org/lkml/20190809083251.GA48423@lakrids.cambridge.arm.com/

Having something that we could put specifically on the default assignment would
make this a lot more legible and better capture the intent.

Mark.

