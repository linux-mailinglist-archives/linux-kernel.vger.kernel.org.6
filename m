Return-Path: <linux-kernel+bounces-256817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D47E9370D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4213B2239F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7807E146591;
	Thu, 18 Jul 2024 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6oXd3oX"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AF1E515
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342759; cv=none; b=QljztB6TYlhrxtN96/1qrFe6hKnDhlY5kGgbsTRqIhb2hrCS9PGhn+dcLmmTHzFOgBRCQkjNWbGS8Th5PH5aBdZ1y8UrFmDJRl36AP/lYRkPpJtSBVPTIPmNaUTwzJQ8v53yeUCgyy6Vxe+cl5jHAALHmP78nu2xYoKViNzehDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342759; c=relaxed/simple;
	bh=DtOBJMDbEYMDbgCAzA0likN/WfKk7VvWVxEbMKwp6EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsXNVpVaUKwEh+5ONIY9Hy8pd4TAJPVPlIN23YhYsk90buRFKd+JXXTTqksmF4g8SVVXiE8zTgrXA2mQv030UOvoO7cA2LnlQ7pLSNkUSDfjzoSu3Xf5ndAEb0MtW4IXZWCuP1fHVE5f2nQFpzKdhYpLpsXoNRnjWBj/z8CytxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K6oXd3oX; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: cam.alvarez.i@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721342756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ew/Bpx7JLrOZezDsJADu8JCmr0EXDkj/Td2twaORams=;
	b=K6oXd3oXnAY5zSXXz8i4WJECw17L47axGRiZLg4mrNfS227a38vjRnkH4c5vj0XjFX27qx
	EAy2c7tw8iUT69aJjvagw8JP7iRk7+33CKHNRhk6c+WVTOb8eSxtAEZ0kukPzanW5+sApo
	zTsqIN8SvDPcErv5hhbDLKTeoZ3MWQI=
X-Envelope-To: syzbot+4093905737cf289b6b38@syzkaller.appspotmail.com
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Thu, 18 Jul 2024 18:45:53 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Camila Alvarez Inostroza <cam.alvarez.i@gmail.com>
Cc: syzbot+4093905737cf289b6b38@syzkaller.appspotmail.com, 
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: WARNING in bch2_fs_journal_stop
Message-ID: <f6lmsdtntfs3ot4jc2waizihayhipszr3iuro3tzyjgbfvjwuw@ms4foq466yiz>
References: <20240717220237.1246673-1-cam.alvarez.i@gmail.com>
 <e2oi7a4jj4gjhzcp66rygr5d6wqlock6c5jvuwszxuej3hldmd@tnvbf45nbx2x>
 <6d42612b-1c20-0484-ce9f-eac509e6740d@macbook-pro-de-camila.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d42612b-1c20-0484-ce9f-eac509e6740d@macbook-pro-de-camila.local>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 18, 2024 at 06:42:55PM GMT, Camila Alvarez Inostroza wrote:
> 
> 
> On Thu, 18 Jul 2024, Kent Overstreet wrote:
> 
> > On Wed, Jul 17, 2024 at 06:02:39PM GMT, Camila Alvarez wrote:
> > > last_seq and last_empty_seq suffered from an off by one error when the
> > > journal has no entries.
> > > 
> > > The indexes were fixed and an assertion is added to check that the
> > > last_empty_seq is always kept under the next valid seq number.
> > 
> > oh nice. I'm going to need to stare at this some more, I still feel like
> > this code needs to be clearer and less fiddly.
> > 
> Sure! Please let me know if there's anything I can do to help.

I'm just applying it - the warning you added gave me warm fuzzies.

I'll let you know if anything pops up in the CI (and I should give you
an account so you can point it at your own branches; email me a username
and ssh key)

