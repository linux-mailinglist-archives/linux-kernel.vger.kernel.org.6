Return-Path: <linux-kernel+bounces-209946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32946903D40
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE13C1F24ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD9317D88C;
	Tue, 11 Jun 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dtPM3bza"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DA17D372
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112325; cv=none; b=dHCgVIFKSf2g+66i56RTZpxSEsQnwvPA2YKuzPTGYKDB2whiAtEqcBRQQEpr/xi+vXzli71vDsGQHDYLEfADI6EvwDPD+ktu/OcS9utLIYihASyNFhQr5E174xY8oyJgfWDwhfQ7S+mpKsvt96lnPtKzFkIjzqZm/Iyc2pMx3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112325; c=relaxed/simple;
	bh=mKkhzXW/ASFN57eSiiHglp/2fuVN5NEP5Kv15ktDi2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhKI/hmYRHpZCTsmn0iayIJ58EjBTw8xU181xvFQbk7pEv0eB2YHrjkhiCaP+HZzKa+6xTnVsyUb4+yY2azFfLDqK0ov6+nrF+UAbIeo6HDO5R1KrqEWztC7BizL0mEtHM/bkx0fmUTWVeNzxy5BGKjU7ZA2AFB5pLhMQz/WceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dtPM3bza; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RelhGyxlTxFvdioe1ErNIrfed8XzIly9QmvYbzKEvzA=; b=dtPM3bzacnvWlLZJ4x+GJmqeit
	U+GYcJPIunRpVZxY97umWo3/5Y4HtoZTdVXuAqHZAHGV2BGpL+fABVMMcauo7wlPx8ATSsiJB62ND
	s7HhSwHKfHb6uw4HB0WthP9Wa3mPmFzcqW53nxEc3EwA6nFhWG7LFyiIN92OS2qMF0vmnjPfdO/xn
	4cy5WGGfbll/UWZNtdls4qvHJLpj+LNlCKv4D8eRA4oe3GYmKA5Y833EmHW/sbpN1KTukhGyqxQgy
	1UBWFFWfdd7V1zsRqjlhb/WBfo1Nrp0VNpSgZtfUur5v9gPgg4jDBhNE+K4a/ZWSp7apNY2hckM1x
	IlyJ4a2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH1Uv-00000002BPn-0sMk;
	Tue, 11 Jun 2024 13:25:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C54A8302792; Tue, 11 Jun 2024 15:25:15 +0200 (CEST)
Date: Tue, 11 Jun 2024 15:25:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [PATCH v1 14/14] x86/alternative: Replace the old macros
Message-ID: <20240611132515.GG8774@noisy.programming.kicks-ass.net>
References: <20240607111701.8366-1-bp@kernel.org>
 <20240607111701.8366-15-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607111701.8366-15-bp@kernel.org>

On Fri, Jun 07, 2024 at 01:17:01PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Now that the new macros have been gradually put in place, replace the
> old ones. Leave the new label numbers starting at 7xx as a hint that the
> new nested alternatives are being used now.

You forgot to kill alt_max_[23]().

