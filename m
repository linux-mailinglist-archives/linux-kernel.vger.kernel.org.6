Return-Path: <linux-kernel+bounces-558612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50234A5E8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BF2174E11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D091F1500;
	Wed, 12 Mar 2025 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="KC0FL6QV"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1064B4D599
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823233; cv=none; b=rwVB/bpMWBonVJZyIxa3F5+1F2qcNado4Os9f36kAD0C5jNBGdjIKjIlRLpaZpsmOrit/LGdctjmtNRb1iAgPbuW2k5T6xf+xQSDYiAyOHwopwR472JbDvvn38HG1+otJIY4FrmxQ3Ne4FlwiAphQD2kDj4cvzNrLU89xrK42p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823233; c=relaxed/simple;
	bh=LNMHhqYtWImiUGY1//tK1tOH7RHIXuSinwJ0qTm7iKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULqOR74uztrnQBiTIiMyHaSbG1xoOX/yZn8AM2M/ODdGRA1mcrG7D71iaZRdXvMuaN+xZdOk5lZmrHCkeqbaQrhp9H4EYuzOYLzE+ae7psGk/cOKxvqMEWDltf414mLQiR8z3dCoycdpyIiuLzhDO/1YEt8Vh6wlKWyZGloVJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=KC0FL6QV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3EEDE14C2D3;
	Thu, 13 Mar 2025 00:47:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1741823229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YY7I/zxMal1gQ7T/2aGJI6VxUmcPXytmaUNdVhQtGJo=;
	b=KC0FL6QVr08mnC1u8pfNbEn+MtTVjGjXTAqy2wzecAMfFMmSFxblwUBFPBlKWIvymoa58F
	FkumZpFZNlUMH4oPleNcuqZ3t43ORp8KPYAoOe+QXvJB2pkZMqmYRjMPQOBeYLCMKZkW+c
	kzOZzQ61BiaOaXtCik0k+hVPdubKHldRIQTdibo3VwifWjzy6egXmm+pqXrdn/HxDOSuJz
	NcrG99vnDfvnX/3QUc/wI3iIgHMJGG3kOJ0Q+HVbf+685Nk4+0oVPEvLgTpVxn+QaGCnfw
	aYOdA26VlfM/9OXSlgg51U/EL0aTbdL+Dhtij/i24+b+/od6gS3PBzsxGPdFUw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d7795da1;
	Wed, 12 Mar 2025 23:47:05 +0000 (UTC)
Date: Thu, 13 Mar 2025 08:46:50 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	syzbot <syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [v9fs?] general protection fault in p9_client_walk
Message-ID: <Z9Ic6iarKKROVf2K@codewreck.org>
References: <67d12512.050a0220.14e108.0024.GAE@google.com>
 <34836920.9mNPFRc1x4@silver>
 <Z9F6cakkpF26_KJu@codewreck.org>
 <2115265.hiCNZqmPJN@silver>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2115265.hiCNZqmPJN@silver>

Christian Schoenebeck wrote on Wed, Mar 12, 2025 at 03:25:27PM +0100:
> > OTOH I don't get why all mkdirs don't hit that.. ah, it's only a problem
> > if the parent directory has some ACL and none of our tests hit that :/
> 
> There are test cases now?

What, you want a proper CI ?!
I'm still running semi-manually but I'm testing the bare minimum works
before sending Linus pull requets.. Which doesn't include ACLs...

But now I'm looking Eric published https://github.com/v9fs/test which
has some github actions, perhaps I can add my handful of test cases
there and try to run that instead, at which point we can consider
running more complete test suites like xfstests which do have some acl
checks.
I'm sure plenty of what we do isn't quite valid and would fail tests,
but at least it could check we're not hitting any null deref or similar
bug...

> > Well, it shouldn't be too hard to trigger & fix anyway, since you've
> > done this much want to send the patch?
> 
> If it is not super urgent then I'll schedule some cycles. Not worried if
> anyone is faster of course.

Given it's been broken since 6.0 (2.5 years ago) I guess we don't have
anyone using ACLs (or at least not creating directories), so it's
probably not super urgent..

-- 
Dominique Martinet | Asmadeus

