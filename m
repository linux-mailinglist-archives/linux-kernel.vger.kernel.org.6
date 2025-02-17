Return-Path: <linux-kernel+bounces-516353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA39A37001
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D33170794
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7F1E5B77;
	Sat, 15 Feb 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR0sWtiQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0452E14A088;
	Sat, 15 Feb 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641812; cv=none; b=iBM9+F7DXxHEmnckB8f8i2IWrS1dOM1/N0TPgruj9Ghhd9zkqAvv5hMNObY8vNrgs1r/zs8JrSCziVjsLvoRJeqpfz3l/TCKNiyBvBMN1D6VJaf3KPlO0EQTfc0E9ps3s6Dm8rO8EUtU0ZG7ELfi2bNUDmiYT2VDn+1io/Znb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641812; c=relaxed/simple;
	bh=A51e6JcDqBBxxRkVKA0V/7fSn5jRxsBs2bLls+VWRiM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pv++ELIXQQy7g2dwNA3qaRgGZ+e2uM0FhHsRWlnJhwmFb5laH14ukZ+CIcEsh4WvOIGp1Pds/E+WxvOH6nFJyZjm3up2ugOfnWcTm2CsRzoayRuWVGan+TNrgzJDl5SIUo63tveLAwUe5xm4cDy7aV0O/lBg6L7CNjsNMZX72hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR0sWtiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2459C4CEDF;
	Sat, 15 Feb 2025 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739641811;
	bh=A51e6JcDqBBxxRkVKA0V/7fSn5jRxsBs2bLls+VWRiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KR0sWtiQJ8yi1gvD8QbU/Ul+R+dVqgW9Lgrlrmn10gIwmG4Z9n9fDJcEx6W1vqO9k
	 Qhte3SQxCB2TJzESKDHloaaaqGJKoNTS0S0l90UoUxBLu9eFEFhOG+OQNkAFtmQufp
	 NVkw+h3zackvyxC/nx+4VNk9qsNkXgohPIKNgpUBvoKulT4womsv38bqgwJ7by9cyB
	 IaKYA/ApU+40w7d0XOM6qCoP1rUVSqNkiaxXV1gQtqyaiEEtlqgKXruc7EhBNtjNt8
	 3nYI0rRdjFz3O0bsfYM6vfgtjmMkM7y9FVQWEpfM9MQL67Qt07eLXDwGw3KZ08eLJI
	 SeJ9v0TdmHGJw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tjMIr-004Q9y-PA;
	Sat, 15 Feb 2025 17:50:09 +0000
Date: Sat, 15 Feb 2025 17:50:09 +0000
Message-ID: <87tt8v14j2.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Eric Auger <eauger@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
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
In-Reply-To: <8da22249-eedb-477b-98d8-f50dee56f1f7@redhat.com>
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
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: eauger@redhat.com, oliver.upton@linux.dev, gankulkarni@os.amperecomputing.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, christoffer.dall@arm.com, suzuki.poulose@arm.com, will@kernel.org, catalin.marinas@arm.com, coltonlewis@google.com, joey.gouly@arm.com, yuzenghui@huawei.com, darren@os.amperecomputing.com, vishnu@os.amperecomputing.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 10 Feb 2025 18:26:48 +0000,
Eric Auger <eauger@redhat.com> wrote:
> 
> Hi Marc,
> 
> On 2/7/25 7:38 PM, Marc Zyngier wrote:
> > On Fri, 07 Feb 2025 18:09:58 +0000,
> > Oliver Upton <oliver.upton@linux.dev> wrote:
> >>
> >> Hey,
> >>
> >> On Fri, Feb 07, 2025 at 05:45:33PM +0000, Marc Zyngier wrote:
> >>> I found at least one issue that could fail the migration. Before the
> >>> VM starts running, we limit the feature set to the subset we actually
> >>> support with NV.
> >>>
> >>> By doing this, we also change the value of IDreg fields that are not
> >>> writable, because they describe features that we don't support.
> >>> Obviously, that fails on restore.
> >>>
> >>> I need to have a think...
> >>
> >> We spoke about this a while ago (and I forgot til now), but I was
> >> wondering if we could use vCPU feature flags to describe NV, including
> >> the selection between FEAT_E2H0 and FEAT_VHE.
> >>
> >> I think this might match userspace expectations a bit more closely where
> >> the state of the ID registers after init gives the actual feature set
> >> supported by the VM.
> > 
> > I'm not sure that's enough. Let me give you an example:
> > 
> > My host has FEAT_XNX, described in ID_AA64MMFR1_EL1.XNX. For whatever
> > reason, we don't allow this field to be written to, even out of NV
> > context. This is odd, because for an EL1 VM, this field means nothing
> > at all.
> So the curprit fields for me look like
> 
> - ID_AA64MMFR1_EL1.XNX
> - ID_AA64DFR0_EL1.DoubleLock
> - ID_AA64PFR0_EL1.RAS
> 
> This is still based on your nv-next branch from Jan 9
> https://github.com/eauger/linux/tree/nv_next_jan9_2025

I have now pushed out a new nv-next branch with the new and improved
UAPI. I expect migration to work a bit better, or at least not to
explode on ID register restore. You will notice that things have
changed a bit (extra flag and cap for FEAT_E2H0), but nothing really
major.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

