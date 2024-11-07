Return-Path: <linux-kernel+bounces-400744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F369C11AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A311F24E57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B66218D92;
	Thu,  7 Nov 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZyswXx54"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87121218D64
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018580; cv=none; b=OxSQQC/qF9tIuyTYnTJ4VHvcQ3puq5qYdk3m0P4plzGc5yrVM98d8C+ZwTavwClGZL0P9O3sL7Wd0FUwUua+jgKDEBO51Azq/lZXWwQjrUXU9/rpacZmIrqM0urTOxsJAYVdmG36p8JswQQOJh1y1jZY92yPynGpqHOM5TPMVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018580; c=relaxed/simple;
	bh=St/6DyT7z6EJRIdONXdukFEuSQSXlgKKfl6cWEurTUA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FybBvc+mPhhpRpVV9WDeUpf47nVJNuDKrckgsDfh2mEsqc0htyXL/vQJW1Uvvl5iRua3fHY0pgWVSqR3VAoz21yNYxuDEKVW8DSU2plNtL62ZnFQxGrA/3Luk4CHd6P662VeELh0sPpONmp10gR5SFOa4TuE9XOYTsVaQtO+PeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZyswXx54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB63AC4CECC;
	Thu,  7 Nov 2024 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731018580;
	bh=St/6DyT7z6EJRIdONXdukFEuSQSXlgKKfl6cWEurTUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZyswXx54idrLmADj6qzHP6GC8Y5KqAWcBDlDnbabLQ21CIZiFL3P6AGkupr9U+8qn
	 84k2GlB+AE/dxI6fMTzv78ACKU4rJgQVsx4ek68t5jckK39uFUWYfRRtoyXpNPKoQP
	 JKXA6+7X5XXU0YJJcHZb/8+36NZ5yQCQMGx1seWo=
Date: Thu, 7 Nov 2024 14:29:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marco Elver <elver@google.com>, Arnd Bergmann <arnd@kernel.org>,
 Sabyrzhan Tasbolatov <snovitoll@gmail.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: export copy_to_kernel_nofault
Message-Id: <20241107142938.c38ce0a63add88af49216b2f@linux-foundation.org>
In-Reply-To: <ZxigQIF59s3_h5PS@infradead.org>
References: <20241018151112.3533820-1-arnd@kernel.org>
	<ZxidW3lvA5Pqu71m@infradead.org>
	<CANpmjNNK_viqTuPxywfvZSZSdWGRsb5-u1-oR=RZYTh7YKk8cQ@mail.gmail.com>
	<Zxiev9UaoUlI1xs9@infradead.org>
	<CANpmjNPvBnov-EFk1PNO4GEOF7XLG7S1bYYjg9i4Ej=ZzaA6ag@mail.gmail.com>
	<ZxigQIF59s3_h5PS@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 00:05:36 -0700 Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Oct 23, 2024 at 09:02:23AM +0200, Marco Elver wrote:
> > Another alternative is to just #ifndef MODULE the offending test case,
> > so it's only available if built-in. No need to just make the whole
> > test built-in only. I know there are users of this particular test
> > that rely on it being a module.
> 
> That sounds good to me.

We still don't have patch which does this, so this series is stalled.

Sabyrzhan, could you please consider this?

