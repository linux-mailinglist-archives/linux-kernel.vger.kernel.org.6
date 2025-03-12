Return-Path: <linux-kernel+bounces-557530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19053A5DA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9D6189B905
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDC523C8D7;
	Wed, 12 Mar 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVvPjFPZ"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6A238D34
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775316; cv=none; b=Abs3Trp5pN7p+oihTRWAzwOZAT7mUBpzBh5mFGLSfI8Qx52lgsB8+9HuXs8V+BYQxhJuMXffE1uq4O3T4Fj/PHjH2jnI/R7XHACufqXnMM6lvMFIWWY/oFt6IfxxP8B0/WHSSpr1EaVspYzBJbpUPFYw/VxI8uKDxrBZ1QHAnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775316; c=relaxed/simple;
	bh=ZLUuClHnNCcAV6Y/eGwPmyS92uLo8ipaIfvbI02nVr4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=j2ubnMlPlG7gYCNrBCEHKhNzz+oABty60JV/BFGw1YdpuNORekguBH/D8N9RG08zIE/WSQT50bnQPRMyFOX6tmMMAuD/jeqkTdxb3b0v0ybuEHUJUkQWqIfy2aE0AKchEkGdkUbiPncc3AyHM+wjK4kS0dyQdOecCZJ50q8Anss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVvPjFPZ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741775311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeieGkvgQ2K1L/OL0XW5ciRepWh+wDso58YIF25ZbpU=;
	b=ZVvPjFPZQFob2pVWOZkD/Ysod3nBaSVWLd2sHj/rxn6HKdZiBxM+Dbi+8Kr+I1xYmr7NqH
	PDLKHMjEPqaH9veVi3iaUdNOiu0WOCFuBnRL1TPAsC1uhPcawcgGIXKTD9ENUPJXWBaLbZ
	b8SsVuEFZsH/o7AMl37s8X+/hnDgIX0=
Date: Wed, 12 Mar 2025 10:28:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <5f6f0c575aa00e61ec2a6a3b90df8e20a71b5900@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] genirq: Keep affinity_hint unchanged if it has a value
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87h63yzkb7.ffs@tglx>
References: <20250311013352.2727490-1-yajun.deng@linux.dev>
 <871pv31wpf.ffs@tglx>
 <171eb20e618f8c05ef8169e892a1ed08cf580ee9@linux.dev>
 <87h63yzkb7.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

March 12, 2025 at 5:10 PM, "Thomas Gleixner" <tglx@linutronix.de mailto:t=
glx@linutronix.de?to=3D%22Thomas%20Gleixner%22%20%3Ctglx%40linutronix.de%=
3E > wrote:


>=20
>=20On Wed, Mar 12 2025 at 03:20, Yajun Deng wrote:
>=20
>=20>=20
>=20> March 11, 2025 at 10:14 PM, "Thomas Gleixner" <tglx@linutronix.de> =
wrote:
> >=20
>=20> >=20
>=20> > > For example, if affinity_hint points to smp_affinity, smp_affin=
ity
> > >  > is changed by the user, and affinity_hint would chang. affinity_=
hint
> > >  > couldn't as a hint to the user, it should keep the value if it h=
as.
> > >=20=20
>=20> >  What is 'smp_affinity'?
> > >=20
>=20>  It's 'desc->irq_common_data.affinity'.
> >=20
>=20Which has no business to end up in the affinity hint.
>=20=20
>=20
> >=20
>=20> >=20
>=20> > I really fail to understand the problem you are trying to solve.
> > >=20
>=20>  irq_update_affinity_hint(irq, desc->irq_common_data.affinity);
> >=20
>=20>  As in this code, this means affinity_hint points to smp_affinity.
> >=20
>=20This code does not exist and no driver should ever invoke
> irq_update_affinity_hint() that way. The hint is a cpu mask managed by
> the driver and not something the driver pulls out of a data structure
> which it has no business to fiddle with.
>

Okay, I got it. Thank you!
=20
>=20Thanks
>=20
>=20 tglx
>

