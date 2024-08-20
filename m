Return-Path: <linux-kernel+bounces-294060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC612958860
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E371F22656
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24E191461;
	Tue, 20 Aug 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="W2qVSnpz"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09243AB2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162451; cv=none; b=fHs/tRiLheZybGFOT7PC74gFsHI6qQRBWrXJeUS4Up9Mlr/jaSy2iwTVh/ESSvb6Pdjvr7Ti8Nn/CHscGAPOazsrmiGyGDAO69TBskt0KcVoHm481BQFHUAbuEwobp+v9ouf6cV+WHz3HW+lSK7Z3ig/olD7JgUq8Sud1TXgckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162451; c=relaxed/simple;
	bh=55jJYgOUczFj86iKSrhJP2mQI8SrM2z+EKFOQSKC2Ug=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pzo2PJW6QEqBjGCVTl68TGjsyJ9mJA86nSLOAhIB337wlKzsuTx9px2CZJ73WoZ6IPafaO850++OC6WTFo5hZnAsa4oh+O4hXM03kVBckqqQDSdO7ypLZ7iikPYnzjno/hkoEk12XGb8Iy1izEh9WbqxLwtTWxTrXIyZgRielhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=W2qVSnpz; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724162142; bh=7w2ZeBRO8dWCQ5Ju3weMtW2rPYoozSsTikvsgwQXQ60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W2qVSnpzXrKTL+IEhj26Ox/L4eq6qgg8i0+2kESnKtgSrK+Lq9n+8xZDVYpv98NMX
	 9sfvqkOAfBIp+RDl/epDoW0UbK+44gLQAjcFYZkJQJxZZ6i6bo3BeRbx1uPsmijrSa
	 dXl6o3gJIxnh8ECkFoCi4szyB2yyHu9gQvtULgP8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id DE680CCA; Tue, 20 Aug 2024 21:55:38 +0800
X-QQ-mid: xmsmtpt1724162138tw1xzbvi4
Message-ID: <tencent_16A450176CD77A86C8536B8366297C03A105@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTPOzuldNXnGcmcxVJyiZqBUaZ/eqKMv37A08Aq287QLK1GsQIGQ
	 s5vLdnv1VefJJ+MUbLyCxWXUkgczqmfyrzjmMsYec6i976yV4Iz+cD8kVhij4gx2W1HwZLsj+sY8
	 IFVisBloGxenpUM0Xkmn1TUr7obA6InYSKyO8gzuKl25QedHAc7LaAhQL14JZosnfWOQgOK0HgQC
	 aBsrQMaygwKTPcZMUWZxG5gWN2XKTV7XzmYuAKkMua95uBNlBMk493eBIKEhh0WGNdjC2kxbqB0g
	 eEv3g70j0wIA55Dwk3V3/cVzzFlmQk4MS2pgls5TSiMEL0I0IcnYHjV6nYBnX4aYibnmvNpyS6lU
	 QumZC/DJCTbMHfl3RIKgkDIY0GW+PVUQQM4yaM7nTztq8Xb4uvN3wg3M1FvHYj0+GY4hUgAOfqTp
	 xtnu+Pd/xXwU8W9E40Hbh0WzDmp+YwiAaVwOa2b0LBgzISQcYhqMoKnuSprnUC1fZN2htoTXBfXv
	 xM7sSlH5PSFwWNyHQxVK0xuVlooau9wF8KJRYBl682OfzeN/NT/h+BW6t1vb/nNYaGBPJ1skbBoV
	 dqh8h5rzRI8ZdXacw8WhfhAuPHWhmEkJnYlCG1fN6eB68HdUu7ctMYiqeXezgygiB8Gixf26CBbD
	 5YKb+6RVJoL0nbbW/b7kqoIhe6YUdtZ/0hx4wNUUk+oC/Jw39SWMR3J+syp/z21XhYh806/QO8gY
	 hp9v1H4xO4G4BFf4k++B9gC0j0isP5AVxQ/gPDtGXo2vS43SI50okpqgaDov8EUk8meLeP4F6nOH
	 K6SopTH49Mikpv41L3K1cs4XvLvsoZdHOkYhIS913xhKy4iswkt4H6RewAcyAiEKNiS975k96jd6
	 5HHKSHceUMH4fogKc7lQ64LGoH1DYcQNGN0kFDk/wBWW13QEhU8c5HI+FnjazkGYIFHEV3MsamuZ
	 XZdZm0fINM4UmcVWY/T0cNpwU8rkTb
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: joseph.qi@linux.alibaba.com
Cc: eadavis@qq.com,
	jlbec@evilplan.org,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ocfs2: Add i_size check for dir
Date: Tue, 20 Aug 2024 21:55:39 +0800
X-OQ-MSGID: <20240820135538.4048106-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <205e0d29-2567-4d82-a024-a8e7826d9f18@linux.alibaba.com>
References: <205e0d29-2567-4d82-a024-a8e7826d9f18@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Aug 2024 20:44:37 +0800, Joseph Qi wrote:
> > When the i_size of dir is too large, it will cause limit to overflow and
> > be less than de_buf, ultimately resulting in last_de not being initialized
> > and causing uaf issue.
> >
> > Reported-and-tested-by: syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/ocfs2/dir.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> > index d620d4c53c6f..c308dba6d213 100644
> > --- a/fs/ocfs2/dir.c
> > +++ b/fs/ocfs2/dir.c
> > @@ -3343,6 +3343,8 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
> >  	unsigned long offset = 0;
> >  	unsigned int rec_len, new_rec_len, free_space;
> >
> > +	if (i_size_read(dir) > OCFS2_MAX_BLOCKSIZE)
> > +		return -EINVAL;
> 
> Why OCFS2_MAX_BLOCKSIZE?
I think it is largest block size in ocfs2, therefore, if it is larger
than it, it must be incorrect, even though the value of i_size in dir
in the current issue is much larger than it (i_size_read(dir) is 0x900000000000100).
> It seems that this is caused by a corrupted dir inode, since this is an
> inline case, we may try best to make sure it won't exceeds block size?
> i.e. dir->i_sb->s_blocksize.
You mean dir->i_sb->s_blocksize bigger than OCFS2_MAX_BLOCKSIZE?

BR,
Edward


