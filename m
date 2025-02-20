Return-Path: <linux-kernel+bounces-524699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E6A3E5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABD2189C261
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4471B213E72;
	Thu, 20 Feb 2025 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uf+7sJ9L"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA62B9AA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083969; cv=none; b=jp1uyhZ2IgUaoGjtZRJvSgHwvt130FPhZJcbPdsdEjJPmTqOmRV4+pwXjICn3yh3qpS4xR24VE/7kk6cEeXP1wa4OmJJCcT/sDWD30pkTkb5HVZ/9elHtRnE+7KvfKMYaUyutyvofVHJ5GbMtnlvgo3KPmwwZMMKw42rJznDQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083969; c=relaxed/simple;
	bh=GXmby5r7jmhWHpKMuDVtnZrpYoSfgQYzXmWWqJTIRj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccs0XM3GJNGwbspATEEzKpnYMRLiCc19mCEpH+RN91piIwzueGby3q5y6nDKXUX+ycpA1qY7ajQ+7W7xvCsrXMZbP1Jp1NSpMxjaY/juqwUe+6DENzo26cGzWmg78LgU6Oz23g7eV9gcbT6negmW8qG2Ya+y8VQkSsoSV7RITnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uf+7sJ9L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F4MQba6vka5aBfrAWeL4MHPRxEgttf2PmNBq0voUdu8=; b=uf+7sJ9LuyJoTh/5acAs/DXLHz
	i/mNivKqEHT0vSAoGYnlRfy3UTyQVOOOXWMRn/pjSggCGV6o21aW/C5xWcBNzAXCDWVltk+lY405C
	P4UkLxAri+TBehx2uTa8QQ2oSTN9o2Ui7Mub4Z708KYIrK9HxqN3vCoa39OSYiVdrAo+Q73G0GMto
	QFvEyWQXNtJL/BmDnM72rMlX0Ojm1nGzE3+8/Nw8Rl7iHAdMoPxo1Q++USiAXBVGy/So3UyugVeKY
	auqJtD8wKKDUWJbFzWG/jAnL4wCHOGBr8hKkZn+HlqQUmHglAf3UzXG9NUBEt6styVNHGrVDjm8JC
	FfVko1MQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlDKO-0000000376C-0keQ;
	Thu, 20 Feb 2025 20:39:24 +0000
Date: Thu, 20 Feb 2025 20:39:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tj@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernfs: Drop kernfs_rwsem while invoking
 lookup_positive_unlocked().
Message-ID: <20250220203924.GL1977892@ZenIV>
References: <67b45276.050a0220.173698.004f.GAE@google.com>
 <20250218163938.xmvjlJ0K@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218163938.xmvjlJ0K@linutronix.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 18, 2025 at 05:39:38PM +0100, Sebastian Andrzej Siewior wrote:

> +	scoped_guard(rcu) {
> +		knparent = find_next_ancestor(kn, NULL);
> +		if (WARN_ON(!knparent)) {
> +			dput(dentry);
> +			return ERR_PTR(-EINVAL);
> +		}

NAK.  dput() is blocking; you *can't* do that under rcu_read_lock().

