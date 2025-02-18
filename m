Return-Path: <linux-kernel+bounces-519865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9BA3A2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB063B1283
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3C426E64F;
	Tue, 18 Feb 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEMyVO09"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266CE243387;
	Tue, 18 Feb 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896412; cv=none; b=A3gsI83BNpaKDy/j5YAvAeKavNWKZldiZKq+ZMIjYosGmQ5P/WlPDcFldF4LHckYtUfzJQc1y2tqkKPKm9Ei6kB/QBhV37vcwd9jxSbfN7Z6wCIuvVUKlpGQPgdAsUtl3Rm89QEdfzjPgPegn5wPuSpBHOmLAWOIlTITAMR7eU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896412; c=relaxed/simple;
	bh=HG8MXPAywW+QktCxIEk+iQgG7o3B8smG8DbYQu12UIA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/cG+/47bOmJgDx+m4BSqazehk5DWxKrhK148x+19wanDRr/Mwcz0tzRr0ZEYZ0Ywk1mtqJpr0RRmHw5tJsPd3fErpXvRiZaUP+DDDCsEAvRRvKcPArzVLkCjZBImjJC2SfCyR3LraCyhR5D81ZEkIh0pmGSU4gs4kPId3ZlVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEMyVO09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBCEC4CEE2;
	Tue, 18 Feb 2025 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739896411;
	bh=HG8MXPAywW+QktCxIEk+iQgG7o3B8smG8DbYQu12UIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZEMyVO09N9YD0BFOLZYtvQSrLTutXchQdS75COw3/+XOnX4w3Ez1OtNa2BPXHUrMv
	 PtstLTkTq27FSGZVk4YRBc8JWKAkRvNL6LJzh2fLfzq+geHydXQRHQXDkgXrA0y3B5
	 YWQVUMrDMnG2MVjCEP08rY4pQc/BP10lY4TvqGHqADYiR5l+Y5sAUX8aFyFiyJFlbF
	 iAJ/I+MsgR5Mq9GU6HzyL2iyPFLfHgTGdagzAS0exemNxZW7A6TxPMkXQGH4jN1rqH
	 HUXkJkZ61G6fb2itwxi9zGKLGx6GfhhRy/ifJ2+DrcmCNC5WROcMyXxp2x08ztwYlJ
	 eaaEe5Gxfj2rQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tkQXH-005Vjg-F7;
	Tue, 18 Feb 2025 16:33:29 +0000
Date: Tue, 18 Feb 2025 16:33:26 +0000
Message-ID: <86eczvrz55.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: Eric Auger <eauger@redhat.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	kvmarm <kvmarm@lists.linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	christoffer.dall@arm.com,
	suzuki.poulose@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	coltonlewis@google.com,
	joey.gouly@arm.com,
	yuzenghui@huawei.com,
	darren@os.amperecomputing.com,
	vishnu@os.amperecomputing.com
Subject: Re: [PATCH] KVM: arm64: nv: Set ISTATUS for emulated timers, If timer expired
In-Reply-To: <1a19dacc-72ca-4631-bce8-7426b3de0b47@os.amperecomputing.com>
References: <bcb4289b-507c-4ea1-afc7-6febd34d88db@redhat.com>
	<86y10osr19.wl-maz@kernel.org>
	<4d443db1-85b1-4071-acd5-3187deb9cb17@redhat.com>
	<2f6b2cb1-3d32-480a-9801-9b993ae74e2d@os.amperecomputing.com>
	<152d262e-641d-4bb1-9656-a13e049d62c4@redhat.com>
	<86h661wje4.wl-maz@kernel.org>
	<4a9fbdd9-ad23-44bc-8ba5-399f08068db4@redhat.com>
	<86cygpwfy0.wl-maz@kernel.org>
	<b22d5916-8b55-43bc-a256-2136d66ad25f@redhat.com>
	<86frkptzr6.wl-maz@kernel.org>
	<Z6ZMdv8jJUvYwQzT@linux.dev>
	<86bjvdtxb5.wl-maz@kernel.org>
	<8da22249-eedb-477b-98d8-f50dee56f1f7@redhat.com>
	<87tt8v14j2.wl-maz@kernel.org>
	<1a19dacc-72ca-4631-bce8-7426b3de0b47@os.amperecomputing.com>
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
X-SA-Exim-Rcpt-To: gankulkarni@os.amperecomputing.com, eauger@redhat.com, oliver.upton@linux.dev, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, christoffer.dall@arm.com, suzuki.poulose@arm.com, will@kernel.org, catalin.marinas@arm.com, coltonlewis@google.com, joey.gouly@arm.com, yuzenghui@huawei.com, darren@os.amperecomputing.com, vishnu@os.amperecomputing.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 18 Feb 2025 07:33:11 +0000,
Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
> 
> 
> Hi Marc,
> 
> On 15-02-2025 11:20 pm, Marc Zyngier wrote:
> > On Mon, 10 Feb 2025 18:26:48 +0000,
> > Eric Auger <eauger@redhat.com> wrote:
> >> 
> >> Hi Marc,
> >> 
> >> On 2/7/25 7:38 PM, Marc Zyngier wrote:
> >>> On Fri, 07 Feb 2025 18:09:58 +0000,
> >>> Oliver Upton <oliver.upton@linux.dev> wrote:
> >>>> 
> >>>> Hey,
> >>>> 
> >>>> On Fri, Feb 07, 2025 at 05:45:33PM +0000, Marc Zyngier wrote:
> >>>>> I found at least one issue that could fail the migration. Before the
> >>>>> VM starts running, we limit the feature set to the subset we actually
> >>>>> support with NV.
> >>>>> 
> >>>>> By doing this, we also change the value of IDreg fields that are not
> >>>>> writable, because they describe features that we don't support.
> >>>>> Obviously, that fails on restore.
> >>>>> 
> >>>>> I need to have a think...
> >>>> 
> >>>> We spoke about this a while ago (and I forgot til now), but I was
> >>>> wondering if we could use vCPU feature flags to describe NV, including
> >>>> the selection between FEAT_E2H0 and FEAT_VHE.
> >>>> 
> >>>> I think this might match userspace expectations a bit more closely where
> >>>> the state of the ID registers after init gives the actual feature set
> >>>> supported by the VM.
> >>> 
> >>> I'm not sure that's enough. Let me give you an example:
> >>> 
> >>> My host has FEAT_XNX, described in ID_AA64MMFR1_EL1.XNX. For whatever
> >>> reason, we don't allow this field to be written to, even out of NV
> >>> context. This is odd, because for an EL1 VM, this field means nothing
> >>> at all.
> >> So the curprit fields for me look like
> >> 
> >> - ID_AA64MMFR1_EL1.XNX
> >> - ID_AA64DFR0_EL1.DoubleLock
> >> - ID_AA64PFR0_EL1.RAS
> >> 
> >> This is still based on your nv-next branch from Jan 9
> >> https://github.com/eauger/linux/tree/nv_next_jan9_2025
> > 
> > I have now pushed out a new nv-next branch with the new and improved
> > UAPI. I expect migration to work a bit better, or at least not to
> > explode on ID register restore. You will notice that things have
> > changed a bit (extra flag and cap for FEAT_E2H0), but nothing really
> > major.
> > 
> 
> Tried nv-next branch and it is breaking(kernel Oops) for normal VM
> boot itself with qemu. Looks like this is happening since qemu is
> trying to write to ID_UNALLOCATED mapped registers as part of
> save-restore of registers.

Yeah, ID_UNALLOCATED is in pretty bad shape overall. For start, it
doesn't even have a name associated to it, and then everything else
falls apart.

I'll rework it shortly, thanks for the heads up.

	M.

-- 
Without deviation from the norm, progress is not possible.

