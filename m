Return-Path: <linux-kernel+bounces-424470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7919DB4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139482823DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B8198E74;
	Thu, 28 Nov 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TSA0kfjl"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885A195FEC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786089; cv=none; b=mFFQ6xs++zlyIIgqSDnXTKTx24dMp8vDeveP/L5jXeoTp7mjGIVs3HpbxD/ZbJX65mK5ZzFv2nI8HMamd40dsRj/ut1c49KACV7nBE38OHiOkPDkSblC0Y5GOmcG9RZ1o1MF58tA0Oo0bDIgiEqrPWdtOb7VKfXfp/LWzfO2f2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786089; c=relaxed/simple;
	bh=aMpYn4R0EIeydkdloBQcGhRW0AGtuXc3BSIgeKf6BEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpMRYv9JVb4ZipKCnXKsssQgzy6zV4mCSh5GVk/A3Y1lPhGPnuluoik1fxDaSPaWaZQ4AvXaF4cXol6l7oh+vOXFBwBnf/LwjVUM3cB+tTbm1+BY+iW8+fbmIbQ4chuRKJrItj0kj8R2dcfiRzZ6VdFCxi8cfxyScXC18OAlUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TSA0kfjl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aMpYn4R0EIeydkdloBQcGhRW0AGtuXc3BSIgeKf6BEk=; b=TSA0kfjl8tAoIqBfD8kIJ31b9d
	OiOFePhfMUFEdq99p4NDkKC4KTFtpA1YArnlpW9Ho8XdxoUjExHZGccU/P6HHkFVgSLGg3Gk2qgA5
	YjayKybnAl0ZHv5H56eMWxlQ0qvPTDuXlGJOLswAWfFzH+oUfEFdHNTa8l+HlxR80+x5CacRQx05n
	5BLCmDBVZtAMySlkbprEEiF3g2NRSvoDlKsIdrrXLjgZqvvvWbZvYK8LcuPZy8P+DKwgB1m+TeufI
	o26/j5uUXgyjl6RlgoMxi8lp5JJNMa8vKWF5X7dnOWmLPGaGmqqPSbEtABORgodsmh/XjN7382Nid
	c5E5BLng==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGaob-00000001ZxL-2NTs;
	Thu, 28 Nov 2024 09:28:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 93F5330026A; Thu, 28 Nov 2024 10:28:00 +0100 (CET)
Date: Thu, 28 Nov 2024 10:28:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/nmi: Use trylock in __register_nmi_handler() when
 in_nmi()
Message-ID: <20241128092800.GB35539@noisy.programming.kicks-ass.net>
References: <20241127233455.76904-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127233455.76904-1-longman@redhat.com>

On Wed, Nov 27, 2024 at 06:34:55PM -0500, Waiman Long wrote:
> The __register_nmi_handler() function can be called in NMI context from
> nmi_shootdown_cpus() leading to a lockdep splat like the following.

This seems fundamentally insane. Why are we okay with this?

