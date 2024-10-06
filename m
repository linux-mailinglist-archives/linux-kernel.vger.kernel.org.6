Return-Path: <linux-kernel+bounces-352481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CDF991FD8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE71C20B1A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0A189F25;
	Sun,  6 Oct 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KeKLmlMA"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA34156677
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728235092; cv=none; b=BFFdirD4TBOODNG6ljQkg1YuhDvJBi5Ve/J1OXSQuZ453TMCLCjS4lP6blEQtzx4Uzhgt4pFbl6esD+5wbX84BnulX1+fzjeUyc3kP2NKmhmdkgRmmmo2b4AjbGAqCCx48MRKKVkmPs6fFCQg92NQIVj2shFNDGuiC4BIWbuPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728235092; c=relaxed/simple;
	bh=Bin7YDXJqMmKBCp7+ofvc9JlUl2S3ibvz2aG8nFJgRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfPT/5+bmrPEBk0oEsF7C6nGHCQtigUG2XcAtGT2jfVi3Rw4yBsg/VmIfuVhacne/XyYMkZMEQH3BIT/wRdadpD6AIUz2SeZaYZTlnaRxnoq5x8U97qyiJIOfQWBDTyj1RHFdV6NTmKFRTardeOyE5NUFarUhniZuAgru1kBEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KeKLmlMA; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 6 Oct 2024 13:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728235087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyJREKlwieF6Ph0K2iiGmYhDA7GHXV0d5WPVEJ0thT8=;
	b=KeKLmlMATUQZlJ/4YL7dZav4fb7DVW3vFte/EQd0qBCEJ3AQ9CrGKtu9QuIbf9tp6g3bYw
	mrtiMHdEP3d74Sy2Q7LPU45LQVIGk0AtpUhAXyj2gz4NE92SHg3jAEHk6MBhUAcdyvCcVe
	B/xCwWYNmDTTTQk5OVxFSWDOY+1kfO0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <v2k6atl7hlaxw4ktu4e2j7mj67sbz63vzrqk6pnxmntrkuzwut@3k4knhrlnqeb>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <5987583.MhkbZ0Pkbq@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5987583.MhkbZ0Pkbq@lichtvoll.de>
X-Migadu-Flow: FLOW_OUT

On Sun, Oct 06, 2024 at 01:49:23PM GMT, Martin Steigerwald wrote:
> Hi Kent, hi Linus.
> 
> Kent Overstreet - 06.10.24, 02:54:32 CEST:
> > On Sat, Oct 05, 2024 at 05:14:31PM GMT, Linus Torvalds wrote:
> > > On Sat, 5 Oct 2024 at 16:41, Kent Overstreet 
> <kent.overstreet@linux.dev> wrote:
> > > > If what you want is patches appearing on the list, I'm not unwilling
> > > > to
> > > > make that change.
> > > 
> > > I want you to WORK WITH OTHERS. Including me - which means working
> > > with the rules and processes we have in place.
> > 
> > That has to work both ways.
> 
> Exactly, Kent.
> 
> And it is my impression from reading the whole thread up to now and from 
> reading previous threads it is actually about: Having your way and your 
> way only.
> 
> That is not exactly "work both ways".
> 
> Quite similarly regarding your stand towards distributions like Debian.

My issue wasn't with Debian as a whole; it was with one particular
packaging rule which was causing issues, and a maintainer who - despite
warnings that it would cause issues - broke the build and sat on it,
leaving a broken version up, which resulted in users unable to access
their filesystems when they couldn't mount in degraded mode.

> I still do have a BCacheFS on my laptop for testing, but meanwhile I 
> wonder whether some of the crazy kernel regressions I have seen with the 
> last few kernels where exactly related to having mounted that BCacheFS 
> test filesystem. I am tempted to replace the BCacheFS with a BTRFS just to 
> find out.

I think you should be looking elsewhere - there have been zero reports
of random crashes or anything like what you're describing. Even in
syzbot testing we've been pretty free from the kind of memory safety
issues that would cause random crashes

The closest bugs to what you're describing would be the
__wait_on_freeing_inode() deadlock in 6.12-rc1, and the LZ4HC crash that
I've yet to triage - but you specifically have to be using lz4:15
compression to hit that path.

The worst syzbot has come up with is something strange at the boundary
with the crypto code, and I haven't seen any user reports that line up
with that one.

