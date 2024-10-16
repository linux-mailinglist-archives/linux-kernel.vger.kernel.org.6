Return-Path: <linux-kernel+bounces-367729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF599A05E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC13284657
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700EE1B78F3;
	Wed, 16 Oct 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="oR1R/nO5"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C511B6D13
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072130; cv=none; b=Q3nIpYd3fONvcbPnAF2Umy4MyFpRbCwxQecZKrmm0YzVK6Re7dGg42wrXJXTuVLcqNtYN2Y8eoaw5scCSubsnoFm62u5apLXHKFJforZAjNRTMOsSaUSk8XGhQYEHiQvHnZMGXKKu1K8e5fJ5GyIFOt3hP7+BtoMNuvpS3XlIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072130; c=relaxed/simple;
	bh=D4ZIvpLXGjOGc57fdQgXtrHNIKToHnqKt5ztXwXmG2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoqvfQvBIS3BzRN1bvtjNtlX/QJkeBIEghlUjkADe1xtuHS2ka9erAo+JE8I5TG6BT2Ah0eK2PifxrWvKe86lUA5ZNcRTIuioPfvkcDAzy8BP21UboxSug0tyreZyTCcS0wlil0SVjjx81sxdMhdkSBDv1XIefFQphArWtHLR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=oR1R/nO5; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 69CE214C1E1;
	Wed, 16 Oct 2024 11:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729071588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKKCM8vsmuJw2e87CzOm6FJ2PosV5LE229Af8qrBvGs=;
	b=oR1R/nO5g1A3VVcMusNHveBTxJMzDmKsfMq84X8iH2qEBU8P0doZj5QGMYa4WQ+aJ8PeS5
	cSe911T5vLNSvg9baUet9qfW0M4IqNoH+WwYhFkIEPO13y3usYr/q0RgaBWQJ74SCu6b2s
	kguSW0KVQMIYcOmMyjF34bWnvRmEHeGS3hkQZq67Cph+PiojPU7TXVPWHAzRGFCKnA9LA6
	BGrZsLjTA9dm+8RrPPJ739OzVsz/vX9eIcEx6IYOudl8W3R+9EMzTNXJTkA93Oij4AcSn1
	FXshK2xiJ45eE4Incr6Q7yqt2xUBGYGyhY4iug5DCfFBUwoA6/FI/vGxuzR0cw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c1fa19b0;
	Wed, 16 Oct 2024 09:39:43 +0000 (UTC)
Date: Wed, 16 Oct 2024 18:39:28 +0900
From: asmadeus@codewreck.org
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Will Deacon <will@kernel.org>, ericvh@kernel.org, lucho@ionkov.net,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com,
	keirf@google.com, regressions@lists.linux.dev
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
Message-ID: <Zw-J0DdrCFLYpT5y@codewreck.org>
References: <20240923100508.GA32066@willie-the-truck>
 <20241009153448.GA12532@willie-the-truck>
 <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>

Thorsten Leemhuis wrote on Tue, Oct 15, 2024 at 08:07:10PM +0200:
> Thx for bringing this to my attention. I had hoped that Eric might reply
> and waited a bit, but that did not happen. I kind of expected that, as
> he seems to be  somewhat afk, as the last mail from him on lore is from
> mid-September; and in the weeks before that he did not post much either.
> Hmmm. :-/

Right, I had hoped he'd find time to look further into this and kept my
head in the ground, but it looks like we'll have to handle this somehow...

One note though he did sent a patch that seems related and wasn't sent
for merge:
https://lore.kernel.org/all/CAFkjPTn7JAbmKYASaeBNVpumOncPaReiPbc4Ph6ik3nNf8UTNg@mail.gmail.com/T/#u

Will, perhaps you can try it? I'm pretty sure the setup to reproduce
this is easy enough that I'll be able to reproduce in less than an hour
(export two tmpfs [sequential inode number fs] wthin the same 9p mount
in qemu without 'multidevs=remap'), but I don't even have that time
right now.

(I didn't even read the patch properly and it might not help at all,
sorry in this case)

> CCed Christian and Al, maybe they might be able to help directly or
> indirectly somehow. If not, we likely need to get Linus involved to
> decide if we want to at least temporarily revert the changes you mentioned.

I'm not sure this really needs to get Linus involved - it's breaking a
server that used to work even if qemu has been printing a warning about
these duplicate qid.path for a while, and the server really is the
better place to remap these inodes as we have no idea of the underlying
device id as far as I know...

So the question really just is do we have or can we build a workable, so
the question is can we resonable do any better, or do we just want to
live wth the old behaviour.
(Note that as far as I understand the old code isn't 100% "loop" proof
either anyway, a open(O_CREAT)/mkdir/mknod could happen to get identical
inode numbers as well, it's just less likely so folks haven't been
hitting it)


Thanks,
-- 
Dominique

