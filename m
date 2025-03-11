Return-Path: <linux-kernel+bounces-555295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4ABA5B406
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD32A172F80
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7A200B0;
	Tue, 11 Mar 2025 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NkzqL8m/"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6D5234
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653358; cv=none; b=VSp/KpDnSOWHcrJTsCEvDletc7k3dNbN493PJFT9kAo1CSuP7Bi40KGwl7Yg44kRPh/phChOwDt0SWsrtTHZ96Nmg+yfBll8NQrMPtIu8JDnDBo4CdhzPjdLoleqhx09o33PCgquFlHkTLHJMvBeXifofUoXpFXA8oruPfAewTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653358; c=relaxed/simple;
	bh=ok9fQkjTAJT8maHeXtQN58QU2aGw86+f2bDLzty8qRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSisTD5GuTGBuZ0ikTuVv0MRqquN1b/MfzpLGExJIdsYCShi3k16T2/O9yWWkhjRA9ZjXVsWXn0F2DZh9o59H65ybU5y3FskpvXchTjcs7sLa0oVsIbig1hvcvj4Twe08V96C3UOJDDXdxleDi4DPF9vqZmpvO2nm1ouv0N4jNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NkzqL8m/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i+tciCSY+qLhnWHcqp4RtdeinAR7d+E6IEhacthVhOg=; b=NkzqL8m/fNT1SrziU4OYXXSiVw
	OM/WY+f/+pAm/rMsaZAGr5ddqzg7KI0Xjy2RBBtj8Q0u0n88N3L4TiYxnZh4fmQ8oVgLIPnF7v6qD
	XOSfllDC2TACwUB0VK3LDqSQWut52VxvQjaTBS7vD2jHINgs25u7Bl56Q1uPeT6UrnqYbdfgBfSow
	rTTYUP39SVJPQw5m9wbODYpOIMkMSjRO1l8pFubOHshYi6oIVYS73dArwuxumwM9QGkUyTGMp4dlC
	vwl5Zr1W8ajlqv/JCOYH+ztOcRUQr33iEMyNwRDntDJEWW+ZiPX/0lUGCkz79YrQ+6EX2xp+2yyKh
	fYDblx+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1trnb8-00000002xHy-0erI;
	Tue, 11 Mar 2025 00:35:54 +0000
Date: Tue, 11 Mar 2025 00:35:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amit <amitchoudhary0523@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching use-after-free easily in linux kernel.
Message-ID: <20250311003554.GN2023217@ZenIV>
References: <CAFf+5zj=KmBG0Avqy6cq9qtpGKR3HnYNc6rK6y8B_78Ajt4RhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFf+5zj=KmBG0Avqy6cq9qtpGKR3HnYNc6rK6y8B_78Ajt4RhQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 10, 2025 at 01:24:54PM +0530, Amit wrote:
> Hi,
> 
> We can catch use-after-free easily if we do the following:
> 
> kfree(x);
> (x) = NULL;
> 
> Now, if someone uses 'x' again then the kernel will crash and we will know where
> the use-after-free is happening and then we can fix it.

That assumes that no pointer is ever stored in more than one place.
Which is very clearly false.

