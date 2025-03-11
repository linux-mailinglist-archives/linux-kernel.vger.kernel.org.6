Return-Path: <linux-kernel+bounces-555266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F59A5ACE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A85C17338F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70A7221708;
	Mon, 10 Mar 2025 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Bz5nNjVZ"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33C1D5AA0;
	Mon, 10 Mar 2025 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649138; cv=none; b=fURoJiqUxqJFCqNXYW5yDIkq+rXnNJUgcaRUjDY5zLWoV9vKQ/GcuYhZ/1wIHduOMG9oMjTQaCD/Q2aqBpflwPZB1MjNlVm9GVcd6r88KRUI5kx0JfAlk8RlP8z78WmfN/KReOb3MiDSWHSZyOIG6D81kFOdfpLMtQ/TtwkDBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649138; c=relaxed/simple;
	bh=nIHGcSGPN84c/tiS/NAVq2Cguqv4thMhE5BRLAhRbTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEB4y0r1D4RmDLzu17czx7U/I7A2CppJTAOHdQjQnmuSCrKRdNnSRFgEspTLob/c1YsJo+6dmS+QIp5buNHtXnCN/Uxa9E/BOFB9STz3vEndYKb1+GfRw9SNdq5ewPUVVIzi40VWNerx48toA/tPDKFdssl/s4a0+DFirYIXfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Bz5nNjVZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6GHLZ5U+wRtHtT6lnv8lowfQ2tF7tmCMz43Byi27gzE=; b=Bz5nNjVZPYQDlAwZyaOtmQM2Wm
	4dO5rn0GOrU2oseYiEO8i3YQhTNQCzEpNqC12T5kgiXU4OTDR+uUrrJWvXnls8k35D9x56aX3Ube8
	YQYOKAmbzJxMzjYTXMNCrkO94M/b9dLCe5Rr1En60q5BpjvK2NHevJOidUeBYIffjyM/J1z/0KlqU
	6JvI5Qawn0lgWoZb4spUkI3N4PEYyaqvQC4RV5PvpwI6tsxyiE5ePqcIrWZ/NIFaIrzifMYAXqbHW
	/q0IS2Se2WnWZ4I1gWDKEkG8sDBRu6LKDuxW3wJCGBHApqenFOOhyaulbVLFYCag+H6IqvilP7oB3
	M8M2FHzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1trmV0-00000002lqx-0Yo1;
	Mon, 10 Mar 2025 23:25:30 +0000
Date: Mon, 10 Mar 2025 23:25:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	syzbot <syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com>,
	jk@ozlabs.org, linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [efi?] [fs?] possible deadlock in efivarfs_actor
Message-ID: <20250310232530.GK2023217@ZenIV>
References: <67cd0276.050a0220.14db68.006c.GAE@google.com>
 <8cf7d7efdc069772d69f913b02e5f67feadce18e.camel@HansenPartnership.com>
 <CAMj1kXH0Myy3bV-hFNWnoUk6ZAa6MAd1zFTM-X6dXiJPx==w0A@mail.gmail.com>
 <CAMj1kXEfG=Q3pk6PsVZxf5qCjEBTwTjUCJcNwBPO3PqNmSp=hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEfG=Q3pk6PsVZxf5qCjEBTwTjUCJcNwBPO3PqNmSp=hw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 10, 2025 at 07:24:43PM +0100, Ard Biesheuvel wrote:

> And one of the other logs has
> 
> [   47.650966][ T6617] syz.2.9/6617 is trying to acquire lock:
> [   47.652339][ T6617] ffff0000d69f6558
> (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at:
> efivarfs_actor+0x1b8/0x2b8
> [   47.654943][ T6617]
> [   47.654943][ T6617] but task is already holding lock:
> [   47.656931][ T6617] ffff0000f5b84558
> (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: iterate_dir+0x3b4/0x5f4
> 
> where the locks have the same name but the address is different.
> 
> So there is something dodgy going on here, and I'm inclined to just ignore it.

That one is a false positive - iterate_dir() locks parent, then
callback locks child, but without bothering to tell lockdep about
that.  IOW, in actor you should use inode_lock_nested(inode, INODE_CHILD);
instead of inode_lock(inode).

