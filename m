Return-Path: <linux-kernel+bounces-360086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C86999446
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641271F23ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C976F1E3769;
	Thu, 10 Oct 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="u+N6SE9K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F561E2317
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595048; cv=none; b=Yq032K8J908F76UioW7IjkrwxOjUaJspPUW5+yUWrRLWpgWPITpb8OQQzmDB67a1EhmxPxz1EC2GUqomvWzhE0EicpQcAmTxsLQoQqKNr+2NirIGmNO1qbs2pHVJbmY4yvm5W/BXiQ3z3z6e4vFTtPWCfC+NHqfTE7rFOV1P0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595048; c=relaxed/simple;
	bh=h/ydTxkvMIlJ33x8vbPMvRfe6S+g8mbXshs+rjB07HA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sf75A4EXz9x9bkPrzGpz3Hyye9Y9wPio6Zgk3VRAJj7H97thnwLkNEQw6E+quvhbN2MVKgmhx8OvAeAfU1xMwdT9+Amqg4ykDCQcYKDd/o3YAL4CbJuMWtv4arUNTWg09cpPFezaYdSZ6anHfVQGMuzWtaQeZn452GMtFlMZteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=u+N6SE9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5E3C4CEC5;
	Thu, 10 Oct 2024 21:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728595047;
	bh=h/ydTxkvMIlJ33x8vbPMvRfe6S+g8mbXshs+rjB07HA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u+N6SE9KV1DUPMTlYZr52oPJT95+GVQ+9eMki630RwTp8kd6oyeSyx7OYwJdTo+/J
	 efQmV5A3cfJNTaGTPx28R5XhtznQN8gDcMin5sT135VEZovhQ35XSprj5QAHr29wLu
	 C2B6DgmtdPUKMvcKW2kCTxZojIrUW6shfV3sSR4k=
Date: Thu, 10 Oct 2024 14:17:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Frank van der Linden <fvdl@google.com>, David Hildenbrand
 <david@redhat.com>, Xiang Gao <gxxa03070307@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?B?562U5aSNOiDlm57lpI06?= [External Mail]Re: [PATCH v2]
 mm/cma: print total and used count in cma_alloc()
Message-Id: <20241010141726.0bc7b9d0758756249efadc3a@linux-foundation.org>
In-Reply-To: <5de41e1999414426ba88447a4d95db18@xiaomi.com>
References: <20240929032757.404707-1-gxxa03070307@gmail.com>
	<f8dde346-8a81-4cca-8497-987f6e4b5e58@redhat.com>
	<CAPTztWY-CD9REdJq_-HeELJ+dX68+OZC76T0F+YMyZKMc-DHug@mail.gmail.com>
	<2a7b7fc3a48d4bb9a6394e51af074017@xiaomi.com>
	<20241004153947.43c5b16b7f75b0f60e918019@linux-foundation.org>
	<CAPTztWbTieT1St6QRR6dJAPyVrZHU4GVW8F2j43whMdf3+Vu1g@mail.gmail.com>
	<5de41e1999414426ba88447a4d95db18@xiaomi.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Oct 2024 08:48:55 +0000 高翔 <gaoxiang17@xiaomi.com> wrote:

> 
> ________________________________
> 发件人: Frank van der Linden <fvdl@google.com>
> 发送时间: 2024年10月5日 6:55
> 收件人: Andrew Morton
> 抄送: 高翔; David Hildenbrand; Xiang Gao; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> 主题: Re: 回复: [External Mail]Re: [PATCH v2] mm/cma: print total and used count in cma_alloc()
> 
> [外部邮件] 此邮件来源于小米公司外部，请谨慎处理。若对邮件安全性存疑，请将邮件转发给misec@xiaomi.com进行反馈
> 
> On Fri, Oct 4, 2024 at 3:39 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 4 Oct 2024 12:23:30 +0000 高翔 <gaoxiang17@xiaomi.com> wrote:
> >
> > > > > +static unsigned long cma_get_used_pages(struct cma *cma) {
> > > > > +     unsigned long used;
> > > > > +
> > > > > +     spin_lock_irq(&cma->lock);
> > > > > +     used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> > > > > +     spin_unlock_irq(&cma->lock);
> > > >
> > > > This adds overhead to each allocation, even if debug outputs are
> > > > ignored I assume?
> > > >
> > > > I wonder if we'd want to print these details only when our allocation
> > > > failed?
> > > >
> > > > Alternatively, we could actually track how many pages are allocated in
> > > > the cma, so we don't have to traverse the complete bitmap on every
> > > > allocation.
> > > >
> > >
> > > Yep, that's what I did as part of
> > > https://lore.kernel.org/all/20240724124845.614c03ad39f8af3729cebee6@linux-foundation.org/T/
> > >
> > > That patch didn't make it in (yet). I'm happy for it to be combined with this one if that's easier.
> >
> > That patch has been forgotten about.  As I asked in July,
> > "I suggest a resend, and add some Cc:s for likely reviewers."
> 
> > Indeed - I certainly wasn't suggesting that anyone else forgot about
> > it, it's up to me to follow up here, and I haven't yet.
> 
> 
> Do I need to resend it after adding "used_count" member to the "struct cma" as V3?

I don't know what is being asked here.  What is this used_count?  Some
other patch, presumably?  Which?

The preferable thing to do is to send a patch against latest
mm-unstable or linux-next.

