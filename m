Return-Path: <linux-kernel+bounces-416492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B73779D45D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FFF1F21C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B4139D1E;
	Thu, 21 Nov 2024 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mwl8afNb"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16744C6F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732156876; cv=none; b=U3N5wFAY9g8J1vwKZ58lBpHya4suTIqNVHrWHAlgNl7CBpbN4E0KKvce9skAOMf/ly5lgG+ltpX9du2ktKpHLoGd0xE9gCtFo6Ki6jpr6wO7flq6LwKDAjI+Ei/Ti0+9GPun1b2xx5SZ9HaWKqe2so6QGc+h9qBBRJtTsKKfPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732156876; c=relaxed/simple;
	bh=wFGYXymuPFk0R/H2u5Va7oFFuC2inmfwW5aKa0v8yqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4Q3vRANm/j050NdEgEksoYWOx9K+FLEowkByfuVjnYiuOKuCewiJyNuIh5YsNvBy+iviwmX8LXHhG/kaNy22MoshISk4FaGVW2PXZRXvGB9Dg/HtvcT6njwR9v4yMu36/59dKx1IhdFmeSDFbMbFlecT1sMP64LvSRuC44FIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mwl8afNb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nil5pmMCIjBmoWlY9VpaqHlfeoWp+CWEtRnLE5MtG/A=; b=mwl8afNbMHcBYSqRh2YlwBaUT+
	WynZT5xWj1uShq4fvoUkDGv/2S5IYIO5aaVnVhhSVCqqaATqtqpNhmyuSvECwa92unEL8LJ7XLwfd
	C6Pt8wR8yc4QqJlf8VyOHe/9qcCaonhSoPDpEKjg6mWpt99nsgQ+tU1vVy1j974Duw826f52Fb9qG
	1ishBMPNlk9WYp8eJIp5LXoFFazA7Y1g/aBkZ4ebCRMFBoKaauIAj6zOSnPY8AoeSUMYUYSXH1CE+
	1MoBgYV6EK5j/KLFhMXCU4LHFCcXklZyB94mPcRYfEuCUgAEGT58qvmQJ/Rx+QJIdLiOoLMwONXSN
	jkS86mFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDx84-0000000HaZ0-2UQe;
	Thu, 21 Nov 2024 02:41:12 +0000
Date: Thu, 21 Nov 2024 02:41:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Nir Lichtman <nir@lichtman.org>,
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
Message-ID: <20241121024112.GN3387508@ZenIV>
References: <202411190900.FE40FA5@keescook>
 <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <CAHk-=wjPpuThc4Wbtk-aUz4buUSH9-gvsmjT5P3=2tU_Kz8oVA@mail.gmail.com>
 <CAHk-=wh4k8ks_oq4v=LXxidXZ+r-_er7cORjNzySjDaD8Xc9ng@mail.gmail.com>
 <20241121023619.GM3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121023619.GM3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 21, 2024 at 02:36:19AM +0000, Al Viro wrote:
> On Wed, Nov 20, 2024 at 02:50:39PM -0800, Linus Torvalds wrote:
> > So you probably want to do something like
> > 
> >         const char *name = smp_load_acquire(&dentry->d_name.name);
> > 
> > under the RCU read lock before then copying it with strscpy(). It
> > should always be NULL-terminated.
> > 
> > If you want to be extra careful, you might surround it with a
> > 
> >         read_seqbegin_or_lock(&rename_lock, &seq);
> 
> What for?
> 
> 	char name[something];
> 
> 	sprintf(name, "%*pD", sizeof(name) - 1, file);
> 
> and be done with that...

... or

	struct name_snapshot n;

	take_dentry_name_snapshot(&n, file->f_path.dentry);

	do_something(n.name.name);

	release_dentry_name_snapshot(&n);

