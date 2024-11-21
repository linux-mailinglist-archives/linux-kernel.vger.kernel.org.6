Return-Path: <linux-kernel+bounces-416486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749A19D45C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3993C2837AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926917080B;
	Thu, 21 Nov 2024 02:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pYK/kxHJ"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E423099A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732156587; cv=none; b=IVhVeuocnGHLz+5hGE7iKRlF13oVgh2HQcizD+kGFdZQBleEGUHwf6zz0IRLw7WVYaCV9TqdRrEqc52Tx/iC4OlMO1GTyesp6SbztaeDYeqwjg07WGzeXiL/3ZZ3OtR/c7yi0y4RD7J+bSfgEqUQOKne4jdUeQSfYOqpM8HjFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732156587; c=relaxed/simple;
	bh=XD6H+mskuKwJ4feF5rMgPfYAfD+6/DuPPvmRtoo3+j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru5eaipGoEx/3Qp2/nxsKVGwItGv1uvhJ23QMMQQXC1+aGnO3C4TgOF+s89FkNnxx+mHmwxIvrxVnKupog1WORqv0NdiOUAX7S+k/kmmh6j7O2MqS3GkO4gQW9tU891w9z7B28wS/xmB55oI1H+3B62c7jUdDrT3YDbR4+NYSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pYK/kxHJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zVuQCNl9jHwkPp1tyJKBxII9GzdMwt4qUSAvpNPmYew=; b=pYK/kxHJfPA4aKGTJV8i4mAKoU
	IvFAcuzAbVwAipXmj4aYHqnxbMp6SYfDStGbXZaSRGHVRSnBpfgQXeKq7Rsb5Yj0ghgOTdkQzrYbv
	KKTCmYzfck0pdblFpLW/nvZ9J76bbRiK3zZAOyJod0p9+rv8axE6ckL2cz6geWDJXoMsH40qT+AMV
	eYeHobas0U9/5nBb8BwWoetrQQl/XJBa1FBpB4uezm7I4cQVoaPAEE28RedlhowYp4O9BsW5/bFGQ
	peg6dRPQAkifjg2AIOfBZcB8IXfTG3KCBVIQSVD/ukXlOjKuFLFsRDC56kkGS4m1yjyiQiZlrcPhT
	nPGdkgow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDx3L-0000000HaVR-1bvV;
	Thu, 21 Nov 2024 02:36:19 +0000
Date: Thu, 21 Nov 2024 02:36:19 +0000
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
Message-ID: <20241121023619.GM3387508@ZenIV>
References: <202411190900.FE40FA5@keescook>
 <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <CAHk-=wjPpuThc4Wbtk-aUz4buUSH9-gvsmjT5P3=2tU_Kz8oVA@mail.gmail.com>
 <CAHk-=wh4k8ks_oq4v=LXxidXZ+r-_er7cORjNzySjDaD8Xc9ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4k8ks_oq4v=LXxidXZ+r-_er7cORjNzySjDaD8Xc9ng@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 20, 2024 at 02:50:39PM -0800, Linus Torvalds wrote:
> So you probably want to do something like
> 
>         const char *name = smp_load_acquire(&dentry->d_name.name);
> 
> under the RCU read lock before then copying it with strscpy(). It
> should always be NULL-terminated.
> 
> If you want to be extra careful, you might surround it with a
> 
>         read_seqbegin_or_lock(&rename_lock, &seq);

What for?

	char name[something];

	sprintf(name, "%*pD", sizeof(name) - 1, file);

and be done with that...

