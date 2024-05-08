Return-Path: <linux-kernel+bounces-173722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6438C0493
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C92288B67
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913E7C6CE;
	Wed,  8 May 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDlqL98l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0MhzSA9x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63987B3E1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194021; cv=none; b=drOpBCCQP6kvKpIgAVXZ1PCp+5tapClhrGAsX4Hvuh58Se0bY2j/vXbMXkPRgIzpmPmxgkvdBIo2fu6TW5Le1gbgqN/LcGwkCwNr11nQ2g7bDzZY42lZVL5HmEEMrgW4cBL+2cDkT0mGYvR/prqc0PQcmLPtBA4ry/iSwni1VoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194021; c=relaxed/simple;
	bh=O4+iWlVjdsDfKqKroZj2t8jy1NGR/zwFpOp/8NsjFlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzzfK+MH5yZ5/P2jU94khGF3WzImjdBF0Os4kjQAjCRx51ezwQds8ytes8fdPtHfbcYgKTPrJl/j/O6VaWvr9vuwq2oxcxJrfjbHMYDAoi2DPBWQneKGGFlgQ2DlTkBtnHwOgF0SUvE06mPcIwY8GLyQ4n5403cyfFPYARCb8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDlqL98l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0MhzSA9x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 8 May 2024 20:46:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715194017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6o7L7QXNQvx0xNXZVcYSLNmrfCQqLomfxFWX4xHH3k=;
	b=QDlqL98lFh60txNqqltm1jSCSe1xNNpupP3cvpljw2mRkb6R7qLm2HNoeT+B6uoiujRA6m
	ulcw4/SrYRftc0zqWJqThQHT1CYdJKymPSpPawo9QWxVSFLoCyUJX/TIP4/9rNPYKSw+yj
	G7vlhK5heF5/RFsVvDsTo1mA1Sbkd4ZiZbs5fWwPuF1uap0gQbB1ZDHu0RZXzYxQ2mtUen
	gkc/M8RlXLGtQkUFT+5HoZYmiQiHnXcsfv18/FMNdLQC1g6BSKYeRLI7VOapYHfYye4zzY
	JAHVRuvSvvflLm7ZSGprEy90tef2bV/8d4pG7Y8+31vu/0qMYyTxTniM7JHuWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715194017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6o7L7QXNQvx0xNXZVcYSLNmrfCQqLomfxFWX4xHH3k=;
	b=0MhzSA9x0EOPrnFl/KOGroBOQUAMqQV0jrCVc0bIBA+Vx8Jul/sryS53O7hGT8AbFSWnh5
	gDEIhEFQt+G9IMCw==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Don't use hugepage mappings for vmemmap if it's
 not supported
Message-ID: <20240508184641.WP8ok_Hg@linutronix.de>
References: <20240508173116.2866192-1-namcao@linutronix.de>
 <43829e94-98ae-46a4-a3e6-dbabbe94d7c1@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43829e94-98ae-46a4-a3e6-dbabbe94d7c1@ghiti.fr>

On Wed, May 08, 2024 at 08:22:43PM +0200, Alexandre Ghiti wrote:
> Hi Nam,
Hi Alex,

> > Commit ff172d4818ad ("riscv: Use hugepage mappings for vmemmap") broke XIP
> > kernel, because huge pages are not supported on XIP kernel.
> 
> I don't understand why XIP kernels can't support huge vmalloc mappings,

Me neither.

> so I
> think the right fix would be to enable such mappings on XIP. WDYT?

I agree that is the ideal solution. But I don't want to send any new
feature to the stable trees (stable folks may even reject such patch).
So I intend that to be in another patch.

Best regards,
Nam

