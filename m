Return-Path: <linux-kernel+bounces-351514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A38991266
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6214282E84
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B41B4F2F;
	Fri,  4 Oct 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UYpoEf3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81E1AE001
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081588; cv=none; b=sLLK2aSuyuv2JcECvIdqySIHXpF0bQ3xuwWHwYP5ekc53F5h07ALms5KVIJDE6ookUyaXMOY0YPfJPhhzr5Wz77Xkfo9J7MxpWUL9cakgg31LVSJiHGx3LX59u/28l0h5BGyAaluqUZ1LbYmNKQ/I0EtiSD3CX4DbFLtm1pXoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081588; c=relaxed/simple;
	bh=tEnRZ1CBS1ziqRHjQFppqFl4cK5/fPc3AdB8hdfr7X4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CYPhN5FZcK/mGBKQWjOWJlSj3S09m7gQyZa3zzPyKgmlpRkBPwBEUqrbpwljsVHKaG3edwafamXdb2FApwdK/LOZOP2BT3ewsbeNKI9VwHYMEsgwyX2PyzwxX5prELCjWondpRd/6Fh3gAJ5vX61Pt16ZtuSDNwWBXW3GNewQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UYpoEf3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262F5C4CECC;
	Fri,  4 Oct 2024 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728081588;
	bh=tEnRZ1CBS1ziqRHjQFppqFl4cK5/fPc3AdB8hdfr7X4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UYpoEf3OiIJX2B4yG4MqhZy+ZfcvOWrLLY3MM2JJuemYyp5Cy+FFXT6gHAbGROfbb
	 PCZVofPX7veozsAFvIu8xu5dGPRfwOwScY8KecTBaiQZF3dYoeLZB0fINfBYvvec1C
	 MLLg19IrUOxHjLsFJoIftSh6CYo5IqdfqqWFoQV4=
Date: Fri, 4 Oct 2024 15:39:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Frank van der Linden <fvdl@google.com>, David Hildenbrand
 <david@redhat.com>, Xiang Gao <gxxa03070307@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= [External Mail]Re: [PATCH v2] mm/cma:
 print total and used count in cma_alloc()
Message-Id: <20241004153947.43c5b16b7f75b0f60e918019@linux-foundation.org>
In-Reply-To: <2a7b7fc3a48d4bb9a6394e51af074017@xiaomi.com>
References: <20240929032757.404707-1-gxxa03070307@gmail.com>
	<f8dde346-8a81-4cca-8497-987f6e4b5e58@redhat.com>
	<CAPTztWY-CD9REdJq_-HeELJ+dX68+OZC76T0F+YMyZKMc-DHug@mail.gmail.com>
	<2a7b7fc3a48d4bb9a6394e51af074017@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 4 Oct 2024 12:23:30 +0000 高翔 <gaoxiang17@xiaomi.com> wrote:

> > > +static unsigned long cma_get_used_pages(struct cma *cma) {
> > > +     unsigned long used;
> > > +
> > > +     spin_lock_irq(&cma->lock);
> > > +     used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> > > +     spin_unlock_irq(&cma->lock);
> >
> > This adds overhead to each allocation, even if debug outputs are 
> > ignored I assume?
> >
> > I wonder if we'd want to print these details only when our allocation 
> > failed?
> >
> > Alternatively, we could actually track how many pages are allocated in 
> > the cma, so we don't have to traverse the complete bitmap on every 
> > allocation.
> >
> 
> Yep, that's what I did as part of
> https://lore.kernel.org/all/20240724124845.614c03ad39f8af3729cebee6@linux-foundation.org/T/
> 
> That patch didn't make it in (yet). I'm happy for it to be combined with this one if that's easier.

That patch has been forgotten about.  As I asked in July,
"I suggest a resend, and add some Cc:s for likely reviewers."

