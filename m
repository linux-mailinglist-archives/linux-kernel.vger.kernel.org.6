Return-Path: <linux-kernel+bounces-321383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FD79719D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBD41F212B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F01B81B8;
	Mon,  9 Sep 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="G8bOdjKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S13T8gmN"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F061AD9EA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886156; cv=none; b=JDRv8rlQjZ4F11zg+oD98AxakqjVRDaZYhWDOcWwJ+NyRutI3+UggSagQpj7ukiQlTBym9P5ZSu8xGIQRyIBrLK4JSMDs7h8xemjJp6kZ9Fzu9alvcDVnFzgo4n/DR5XCR7vBHEyZNMmlICcbWVEWd+E8BWD3lqG2Ruimxar6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886156; c=relaxed/simple;
	bh=67as3g0g+o3AzANYDo2aFGyQpq4AvlUYLxMLyuV9NB0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i/SaYpKSgyKPYG14qu0RBoh6o706KRruezpk54x9D/i/Jljb6IcjIZBKzUluApCdvow1HVVCjY7v0JZTRKdJMWaeuTb9tB0thXpHxyiaKeLIGeZFpnT9ddojCoNl4fa9oymIxKbPbL/OYVargISAdVjHxoS38BtZNfPzT8bSy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=G8bOdjKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S13T8gmN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 740261380226;
	Mon,  9 Sep 2024 08:49:13 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Mon, 09 Sep 2024 08:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725886153;
	 x=1725972553; bh=zzJBBMf+zohuvcLUo41tDA+vsEhpgbS/Jc7eQESKcS8=; b=
	G8bOdjKaDXZAbmEbd/pAHr26PgnbXfZUFCYgX8hWhXC/AqkmRMyCVSd5PckEyjFu
	lthK9zTHSFiiHsWoQwE/6e7ifKZlWHQO4b/Dt2eZ+amSbhTNQCUveX32J1Dq4UG9
	SWZGSpOvClahJ6O8Mu0+A4+6la6JTl2xsn5ql2IfTtqRYoFyc9jRTP1Y3GuHvdRp
	gLZ9R2TrnHkq8b7K3qvkiXJMUFAQgeXIv0fBg/A5HO1JZ09F6QQjCvur6GgQpdZY
	JH1uUXPiKPwLSp3juaDLromTpVPSAXx1qNf/sZUoFHV6w8mnb8AJ8mOYW3NXSDoN
	7t3OyOZSnGnaonGj0pJimw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725886153; x=
	1725972553; bh=zzJBBMf+zohuvcLUo41tDA+vsEhpgbS/Jc7eQESKcS8=; b=S
	13T8gmNnalWX57csimCaxNTwJCX7WXFsO8GPubmApkuJeTdgAju//lwEFEpEii9j
	uPZXciQgipjtUK7vctuOTkil+V59ESUjI5rHW/Doato4Rs+4Ikq5WIyw0j5FmaKr
	OTb0McJZowuqBWbBxEWQ/jIkeJsZTDyc2QuL8x18J2UuOrw7VD5oZA0zoEZOoOmn
	4YNHks++TrS14mJmqiEsOVbZEPA5X2jpri/oWlF0P0JAua8b+hhgg0p+oNXznUk+
	MmjB+zvWpaOeQ31yEOfGZcuhoMcXNiNvKni9aU6Uk14VzN2dJKHQSgz+3NjuqpfJ
	ELimHOH/ULP9s7jR0CxXA==
X-ME-Sender: <xms:yO7eZhDi19Ulq55cErvPi18PxbfCGkpGTJnHvSZFsIZzwptvCHEw9A>
    <xme:yO7eZvi8u5DoyZ2-HplfActyo5uC2cYcqEKKvdHQ4DCYnXddpSiACqEpvZQJiB4vr
    LcUZIbn-LthcP4p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevohhlihhnucghrghlthgv
    rhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgfehtdettedtkeeftdfgtdejtedvhffgtefftdetkedtjeeggeeuheejkeekheffnecu
    ffhomhgrihhnpehhohhnghhgfhhuiiiirdguvghvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhsh
    hirghnghhkrghosehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqvghrohhfsheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yO7eZsmdtodOE6kzj_F3EAmwH8yEX-J4qufiOYz6BYsfafvyEnwxkA>
    <xmx:yO7eZrwws-LtBshFfEz-MYAdd94C5VAlICvzXDrcu3fLf4mP8aUkjA>
    <xmx:yO7eZmRsqLX7J3kXCdxk0Ti1fM83WnN9HxNKxGAVktYYa2Px1CAGoQ>
    <xmx:yO7eZuaaLs8GgDPtln14sx2FipDH_cEVcOxzEUq1QEOOlHCeo1yHcw>
    <xmx:ye7eZhciR4momiIk6uIjCiohvZlgXBb1Hx6lOY498zd5ijNtAWtenaYu>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7EAF529C006F; Mon,  9 Sep 2024 08:49:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 08:48:52 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
In-Reply-To: <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sun, Sep 8, 2024, at 11:19 PM, Gao Xiang wrote:
> Fast symlink can be used if the on-disk symlink data is stored
> in the same block as the on-disk inode, so we don=E2=80=99t need to tr=
igger
> another I/O for symlink data.  However, correctly fs correction could =
be
> reported _incorrectly_ if inode xattrs are too large.
>
> In fact, these should be valid images although they cannot be handled =
as
> fast symlinks.
>
> Many thanks to Colin for reporting this!

Yes, though feel free to also add
Reported-by: https://honggfuzz.dev/=20
or so...not totally sure how to credit it "kernel style" bit honggfuzz v=
ery much helped me find this bug (indirectly).



>
> Reported-by: Colin Walters <walters@verbum.org>
> Fixes: 431339ba9042 ("staging: erofs: add inode operations")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>  - sent out a wrong version (`m_pofs +=3D vi->xattr_isize` was missed).
>
>  fs/erofs/inode.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 5f6439a63af7..f2cab9e4f3bc 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -178,12 +178,14 @@ static int erofs_fill_symlink(struct inode=20
> *inode, void *kaddr,
>  			      unsigned int m_pofs)
>  {
>  	struct erofs_inode *vi =3D EROFS_I(inode);
> -	unsigned int bsz =3D i_blocksize(inode);
> +	loff_t off;
>  	char *lnk;
>=20
> -	/* if it cannot be handled with fast symlink scheme */
> -	if (vi->datalayout !=3D EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >=3D bsz || inode->i_size < 0) {
> +	m_pofs +=3D vi->xattr_isize;
> +	/* check if it cannot be handled with fast symlink scheme */
> +	if (vi->datalayout !=3D EROFS_INODE_FLAT_INLINE || inode->i_size < 0=
 ||
> +	    check_add_overflow(m_pofs, inode->i_size, &off) ||
> +	    off > i_blocksize(inode)) {
>  		inode->i_op =3D &erofs_symlink_iops;
>  		return 0;
>  	}

This change LGTM.

> @@ -192,16 +194,6 @@ static int erofs_fill_symlink(struct inode *inode=
,=20
> void *kaddr,
>  	if (!lnk)
>  		return -ENOMEM;
>=20
> -	m_pofs +=3D vi->xattr_isize;
> -	/* inline symlink data shouldn't cross block boundary */
> -	if (m_pofs + inode->i_size > bsz) {

It can cross a boundary but it still can't be *bigger* right? IOW do we =
still need to check here for inode->i_size > bsz or is that handled by s=
omething else generic?

