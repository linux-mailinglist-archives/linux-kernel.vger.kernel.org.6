Return-Path: <linux-kernel+bounces-333166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFA97C4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47D71C228EC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBFF22098;
	Thu, 19 Sep 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mJ2tavrE"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4718BC04
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730551; cv=none; b=FIU99vMwzfi2RoRYuyHmTBY+e35pC7sTO6ysLfh6K/sKSHplFD2U0NyD/ZyUhwBKsUVYaFQoUWLxc6IzwhKn5R8Xm9scyMaHiL5Y73xCdzxu/8G3pCd5CvGStkMLRxfVyjoZSl+Nz4mov3C0VlsTmSIhWR963a+Su9zpQ9s1jk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730551; c=relaxed/simple;
	bh=kXe44D4oPW7CPCoxcbg896TShv4XLJMnwM4n0Dy3AXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FoAZuUKKmYZZ/+Kg6w52I6iPKAhYnMIRf6CrsnjiC3pJcOHIxWCo+10ER5zu1gJLieHhXiuqNd7JJ7EJMeB0RdNt/vALsJrk6A+a1Hp9Fj7KhfLAoVmUO2c5gB3x9jb/yL9O2UPioeR17MWh1OYAAUh0XmfPjMKZ4rAJ0BuOKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mJ2tavrE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kXe44D4oPW7CPCoxcbg896TShv4XLJMnwM4n0Dy3AXw=;
	t=1726730550; x=1727940150; b=mJ2tavrEcZz0+UD7V+QBMbmVwHKT9DjnMNTKMwFme7jS6Pg
	bnMpSdorrGufhiDzBotkjcXqo5G0gf3XLHvlbHewo3x/jup/5ZJaNmm5aRbf28249+DOUnFuce+1c
	DetFPYjmAprAw7ow/QbEDeDTuYCuSDxw29STK59gOBRkfLVmedsdiF7OinxoV4GBDUV64/v/iXpXO
	L+TetLse9nuMaOShvytucJ3Wwkwz7thF6TIkKWfOFz57KD31Pfwqtj7Juryk7PG6sOK6/huhiSszD
	dNc4QIKqt5EJPg/gyn2qEK9T6Cq2qXLt+8GxR1p4I3bUX6tGcen04fgPf8IBlvVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srBUd-00000003SkL-0W6a;
	Thu, 19 Sep 2024 09:22:24 +0200
Message-ID: <627bd11a7fe69fed02719c2ecf5370b59328e80d.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Remove 3-level page table support on i386
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, Tiwei Bie
	 <tiwei.btw@antgroup.com>, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Sep 2024 09:22:19 +0200
In-Reply-To: <0a73298f1c0ed189046360ea867e6da32276381c.camel@sipsolutions.net>
References: <20240918061702.614837-1-tiwei.btw@antgroup.com>
	 <0a73298f1c0ed189046360ea867e6da32276381c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-09-19 at 08:54 +0200, Johannes Berg wrote:
> On Wed, 2024-09-18 at 14:17 +0800, Tiwei Bie wrote:
> > The highmem support has been removed by commit a98a6d864d3b ("um:
> > Remove broken highmem support"). The 2-level page table is
> > sufficient
> > on UML/i386 now. Remove the 3-level page table support on UML/i386
> > which is still marked as experimental.
> >=20
>=20
> No real objection, but with the 4-level page table work on 64-bit
> pending as well (which likely conflicts), I wonder if we should just
> remove 3-level *entirely*?

Fine with me. There is only the tiny advantage of saving a few pages of
memory for each process. I just erred on the side of keeping it in case
anyone is cares to the option =E2=80=A6

I'll resubmit the patchset without 3-level support then, possibly on
top of this patch. On the assumption that no one actually cares about
3-level page tables on x86_64.

Benjamin

