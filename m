Return-Path: <linux-kernel+bounces-382827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D259B13C6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 02:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7954128784D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8645D8460;
	Sat, 26 Oct 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KJYbQJ/I"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE92CA8
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901518; cv=none; b=hdeMDUqAHXvvZqv58GQsX2ZrSFNv1lrZDHihVokgtCwCTTIC26g0krRHvKsGD6qhgIjWw6hh38kxuInl7cf3eJNIKEh+NAVDyogCP+wIPr0fmajRjBBbzhoRR6P67DlJYForujJnxZRWhZNJVo/sUUe5WVcIR7MNj4DKFVk8p6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901518; c=relaxed/simple;
	bh=R/lNSckK63LU/rF9leOxFNjB585FM5gQstkt+s3T9l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qssi5KKcPkXHpi2CZkT5g1ejwjJGbM3AtMHKzvQdc/pxyqfpqndUEKrJo5nXxBSFYAbvTravNWI2SUkPXd12OlZhcCRJsWulm7L4nxktdPC4LUqLE+5CNdtIwLe6O0FNEp80XEtuPDLnvq/+xwDjNGFna0rYU8u5WyCOq6bl/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KJYbQJ/I; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 20:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729901514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVgv2daW+pV0G7VAMaf+DE1h4/G7W1BYvdOcvVYWEzQ=;
	b=KJYbQJ/IM6bx53csNJm3+Wqk0TUUuRpvR4eIGyFqMx8wlUdngtOlc9vrFosDyQf9tq6Rxj
	AvVxzYznB64tQ5vGVBgR8+paT/5Cqo3UAvJNH1KdezjtREu0t/OvD+9/ELcS0edO9mw0f6
	rGo+8fylu9U89LsTvAdD6ryA+1mgJSs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Alan Huang <mmpgouride@gmail.com>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
	linux-bcachefs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org, 
	syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: Fix NULL ptr dereference in
 btree_node_iter_and_journal_peek
Message-ID: <udcnrneobxa2nmwg47jrks6j67bsulaw7s43oldd5l3ge5wunp@r5rzrwwgzls6>
References: <20241023072024.98915-3-pZ010001011111@proton.me>
 <09A7740A-3113-4ABF-8587-8E0A4231DD61@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09A7740A-3113-4ABF-8587-8E0A4231DD61@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 23, 2024 at 03:33:22PM +0800, Alan Huang wrote:
> On Oct 23, 2024, at 15:21, Piotr Zalewski <pZ010001011111@proton.me> wrote:
> > 
> > Add NULL check for key returned from bch2_btree_and_journal_iter_peek in
> > btree_node_iter_and_journal_peek to avoid NULL ptr dereference in
> > bch2_bkey_buf_reassemble.
> 
> It would be helpful if the commit message explained why k.k is null in this case

This code is only for iterating over interior btree nodes - k.k is only
null when we have a bad btree topology (gaps).

Piotr, could you add a comment to that effect?

