Return-Path: <linux-kernel+bounces-572466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960AFA6CA9F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32443B4F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593D420A5C2;
	Sat, 22 Mar 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JoCPy1wt"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE1F3398A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654154; cv=none; b=cdLqUtnAU3ETrrJVvKowt33jCMtppY4xJLh4vYdjkhyg6IzfdzkMBZlZlhvI4Xcmk/UovcutVxJpN4JoBGvyN+0/Fernv/W6Ov7u+2fyBVPISkX9/lzSu3vFbSiOnpmVoattsCAYKYCJofyOoW0fXASdfbINikWumYsYHB2CLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654154; c=relaxed/simple;
	bh=yTeqaizKOE/RILsjcL+sO1F5sgZ0UVDAx9x1ymdZyV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peL0s3sxhABmLyOnhEgItB8EYFUJa28ZyYMj+SDe9wo/Mdwx2tCDTrolATwbH70CdrjHvo3OjrKtlyIqmbIM3WgBNQcX+OSjzZEhMzL2nB/tRIP5TLvv7DPEEjY6yM7TKCNBuHu7EKAmjfHKUc/CV7UhvBaN3CzlvXzsi1fdBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JoCPy1wt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X0GxGmiZBiEAGm66BhJ5lPv94pMwvTP6CV2+E77cK/8=; b=JoCPy1wtTtjF+ETgtHmd+8sIm5
	cPErzWp3/AZ48L6upgbsUkYIqchUAe/Ej2AztHoxRKGMXqToFaG45hVvgh9mKurxCFHmnCAMKi5dB
	m/3nHRY9r7EfNZ1PyzkV6OzipYHShigY+35eTsBQZBnQNJA5j+OSjgU2CsxI3a+d01zkgpfXySXf5
	1OAPJH/ZJROXrQ9rLBnD65D9Ftp3tj3yrLBY/zaTCkI4BxgcTQmaQJpna24k/4tiig+Mam65v8K4v
	1+EOU17BYSvy+tIsCBfgoyrMddseNpiVu0vkAKaF/r42GunBSfsqRc4NbzJVs+Nuxl0vvi6LQz/Ux
	cWD8U3IQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tvzwz-0000000DSqx-1OeI;
	Sat, 22 Mar 2025 14:35:49 +0000
Date: Sat, 22 Mar 2025 14:35:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+219127d0a3bce650e1b6@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: jfs: Avoid sleeping function call in softirq
Message-ID: <20250322143549.GH2023217@ZenIV>
References: <20250322142134.35325-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322142134.35325-1-purvayeshi550@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Mar 22, 2025 at 07:51:34PM +0530, Purva Yeshi wrote:
> Bug detected by Syzbot:
> BUG: sleeping function called from invalid context in jfs_fsync
> 
> Fix jfs_fsync() to avoid sleeping in softirq/atomic, preventing crash.
> Skip execution in softirq/atomic and return -EWOULDBLOCK to prevent issues.
> Correct generic_file_fsync() call to pass the required arguments properly.

_ANY_ ->fsync() instance may sleep; adding that bandaid in jfs one does
not fix anything - the realy bug is whatever leads to having that
*called* in such conditions (e.g. having an unbalanced spin_lock()
somewhere, etc.)

NAK.

