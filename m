Return-Path: <linux-kernel+bounces-296413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEAB95AABB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E607B21079
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1685134C4;
	Thu, 22 Aug 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pYN/GCK1"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA30B641
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291683; cv=none; b=dIcFIsrdzz+fd1h9G/9250WBTRecYuZ+EQmn3dzDqYLfbqEMN+zQmsI85DOAV7RPnHQKeYjjisX/sYaN5u/0V/61bX72fuR2TqhM6nTUEHWEj3lCBjmcCjqj51BzixQmo0xADDfzMIUfxLVa1mzxp8LNJKpt28GrOfm28laxGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291683; c=relaxed/simple;
	bh=7HAKGxA2jJ9f2Dx7EQ1KsObKZTN2bS6VmhxbbUjwcDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwWz8cMFx4QSIybmwJkH434dgVp+so7Qv7jtCHVRf35eUMrWOJCL5U48aegI8Ga5vmEOmWsUdMTGYHQk7voBhkWrz8BuWem7IMSPsVmP3Fhoj6y80lE3oxqPoWGtXsdUywkRgL5WLIc+RpHhukvST6ftGHgypm6Lxhj1x5WJ1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pYN/GCK1; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Aug 2024 21:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724291678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7HAKGxA2jJ9f2Dx7EQ1KsObKZTN2bS6VmhxbbUjwcDQ=;
	b=pYN/GCK1hTGmBTlykqoEDN8fOVstR95DzcNEs09sfMZdph1tW/YT9+kqnvWYtO4Uci2rJO
	uSWi8h6xrRxa9EGXICRxbVNV2Hb0SlErQkL/N8ygWPE2nwpWydjfwEDFUCYebe/nApMHBV
	oBCdwh7GE3l0+XRSl/6d2qWk+kBDbTc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	tangyouling@kylinos.cn
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 list_lru_add
Message-ID: <jfoxamnb675yq2ezkrirwzvvl3ojcuswkpu6rsiiizuegd4yhz@fdu4iordaf6o>
References: <0000000000006d415806048a9aee@google.com>
 <000000000000294a7f06203be41c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000294a7f06203be41c@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: Revert "bcachefs: Mark bch_inode_info as SLAB_ACCOUNT"

