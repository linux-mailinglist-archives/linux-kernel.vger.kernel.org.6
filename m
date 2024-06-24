Return-Path: <linux-kernel+bounces-227974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D41A91592E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E1E1F24476
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF311A0B00;
	Mon, 24 Jun 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3mgtx5M9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SFta+En2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701CF1A0AE6;
	Mon, 24 Jun 2024 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265454; cv=none; b=buYNqsfrmV3BtNwev9dOmIuYaV2u77coq3En9DcbYUIpklbaBB0O3U3/qCXSAmXpSkOK+RMWuB7F8fsj3Y9P4tC3AiVJcA3PqTszZK3mIsmDpug4NTH18+Z/Dv72cLNvCxRxsJIisAWJ1LPtjzmbfFnzkREj5gACu6ZmvWfwEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265454; c=relaxed/simple;
	bh=AiHC9xnEMYGzcT5H5DWhz1dmOlvJKhP3SFGnJvzwTE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FnnBnzjFRVDumWoek0DnG3dVIyFvCtLJFNoNOI32wv+p2IaBQ9K8Bb0jsWDjhDrzWUub18+yOqFxHxBnj+MmBUWve6QNYcwdHi0cnIbzhOkudTKXyionvBMUCmLjXBmeNkxmRvl65Sgsc4BvHwcBI8H8xNq3V/LRcvTDzO/6FyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3mgtx5M9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SFta+En2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719265451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rASr6AApb78mUlBNDuPuk8RQlBZnWLpRlrhyt32M5QA=;
	b=3mgtx5M950PHaItAGxDU5pdxGWJ+rp6f0TyWMN7FfRzQmNso8u8W2ni5ulx1aNTlibmBjq
	7CYYyo/kANI5VuBqQiFBSk0S2afc5Y5LmpRJRgSPQf1VwXaPdpCWSlQpnhQSopnZGmwSIv
	QSSrjlX3fB0ZPd0VacDgoNQQImRwKQG67H1laNL1Y+Rly2/ptvFN+WaSrPJsDi3iih9jqe
	iDPmAfRWv9UsoHZfANjcEEmmKkouP8Xy/Biq/uGRdeG6thMfqQkUxKfp69imUgde/78tJL
	4zrdMPJLIxDwoXGC4+emnSt/NxBNdLBUxtTOP8nkcRhVG/ycCDc6/elB5UZQIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719265451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rASr6AApb78mUlBNDuPuk8RQlBZnWLpRlrhyt32M5QA=;
	b=SFta+En2ITCpFuP0FHtYbBHBDm+2rgkbGl+xIEAo9nX07wqh3gTZbJ9PIWPciQ1Z0bHC9R
	ORl5zQ9yEBgOLrBg==
To: Roman Kagan <rkagan@amazon.de>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, nh-open-source@amazon.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Marc
 Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gicv3-its: Workaround for GIC-700 erratum 2195890
In-Reply-To: <20240624165541.1286227-1-rkagan@amazon.de>
References: <20240624165541.1286227-1-rkagan@amazon.de>
Date: Mon, 24 Jun 2024 23:44:11 +0200
Message-ID: <87pls66mok.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 24 2024 at 18:55, Roman Kagan wrote:
> According to Arm CoreLink GIC-700 erratum 2195890, on GIC revisions
> r0p0, r0p1, r1p0 under certain conditions LPIs may remain in the Pending
> Table until one of a number of external events occurs.
>
> No LPIs are lost but they may not be delivered in a finite time.
>
> The workaround is to issue an INV using GICR_INVLPIR to an unused, in
> range LPI ID to retrigger the search.
>
> Add this workaround to the quirk table.  When the quirk is applicable,
> carve out one LPI ID from the available range and run periodic work to
> do INV to it, in order to prevent GIC from stalling.
>
> TT: https://t.corp.amazon.com/D82032616

Can you please refrain from providing internal links? 

> Signed-off-by: Elad Rosner <eladros@amazon.com>
> Signed-off-by: Mohamed Mediouni <mediou@amazon.com>
> Signed-off-by: Roman Kagan <rkagan@amazon.de>

That Signed-off-by chain is invalid. See Documentation/process/

Thanks,

        tglx

