Return-Path: <linux-kernel+bounces-530168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C41BA42FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE77169EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFBA2045A4;
	Mon, 24 Feb 2025 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="maOIQzSv"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F22571D0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435808; cv=none; b=b7am/Ei0ikC2b5M7t/gWHle+jZrSX8RdRhUS9EdbQIblF2BO8mRdlsITYt1kMfChbVtcN8/tBzpkAeJlcF3bL0frx6T2IPwVbQkauGvUF+7ns2ocUoPqRH6jHwnFR/bwxNdkwKvKxMzh1jF3EFECuJke1vKghwi5KLQc+nuC850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435808; c=relaxed/simple;
	bh=qmooO3AxZOs0ohQpJ4yo5y4Yi0jidhmcv0CFom4ARm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpRtqy3O8V0ztxmAqZ6gG8yKFsMRtUcpamWWdvRzypYh2sIPg/nzED7NILNzaOVpm0uedUFr/Y4pe+TDQo925Go5klpRXDpHjpNPALCCTWYQJKmNpPwtGenDKHk+b7Fuvf4+Qc6lqNKJHR+W7OZKxv2Xzj57PEy4jMTb8ho1q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=maOIQzSv; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 14:23:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740435794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MytlJ2KGkzQ+RhdKVpvDJ1qR08yPF+KOv8QGFyqerQs=;
	b=maOIQzSvuUUmYk2SXkgSfup4ufEe8vHbBJ1FJO81wU3bAJfRUFrahN1yRRh9znIPT/o5TV
	WoB9p4K7A8zLUuGiNJ6GriZ8DtNyq3pPrqY+zl2aOneRbzq2EQxRQ9awhbiIE8t+IhjSRU
	HIruwKqVpJtTTT00ZjwDqRmDWWixvoY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ott <sebott@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] KVM: arm64: writable MIDR/REVIDR
Message-ID: <Z7zxSdW5b6rqe2bt@linux.dev>
References: <20250218163443.32836-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218163443.32836-1-sebott@redhat.com>
X-Migadu-Flow: FLOW_OUT

Hi Sebastian,

On Tue, Feb 18, 2025 at 05:34:39PM +0100, Sebastian Ott wrote:
> Based on prior discussion [1] this series allows VMMs to change
> MIDR/REVIDR to enable migration between machines that differ in
> these registers. Since these are used for errata handling the
> errata management series [2] is a prerequisite for this one.
> 
> changes for V3:
> * handle VPIDR_EL2 as part of vcpu ctxt - thanks Oliver!

Thanks for respinning. While your changes are looking good, as I got
ready to apply this series I wound up peeling the onion a bit further
and have a few more concerns:

 - Current KVM allows guests to read SMIDR_EL1 despite the fact that we
   do not support SME (this is part of TID1 traps)

 - The "invariant" values that KVM presents to userspace originate from
   the boot CPU, not the CPU that resets the ID registers for a VM

 - A VMM that wants to present big-little can do so on current KVM by
   affining vCPUs, but cannot with this series

All of this is to say, I think your series is going to collide with
the pre-existing pile of crap we have. I'm going to pick up these
changes and rework them so we can send a fix for #1 to stable trees and
(hopefully) avoid breaking the old "invariant" behavior.

I'll post what I have as soon as I test it, hopefully we can get this
shaped up for 6.15.

Thanks,
Oliver

