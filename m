Return-Path: <linux-kernel+bounces-327083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBD9770D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA19B1C24BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51E1BE85C;
	Thu, 12 Sep 2024 18:31:14 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D696126BED
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165874; cv=none; b=pPWN78V5izKhN6qDNZbBxlMcxcie0GR5cGg8q0DPMiOzFXN+4/8K0rqWmGd8QmvjNwcH1i132xdlu3Z47ECiKVb0x/g/BEmuOmSGra+bPcJ2x5dFy0yVdV6Za4eX5AFuAKH4X0wBPAvg6n6iR0VkwEqLFFbQ3KSbcQ78ke+xYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165874; c=relaxed/simple;
	bh=Ju4IAji/6ycpR7hHgmqZv5C320TVlAiK3w3N6YGrHRE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZHhg0HpwNX/kNs2tChtDMaUC2i5PC4J8v3bVinEvfUydFOn/9x1x0CGcCmsi1f6OS5P397oauroICaWmvkqVVQfsnrnySTjUEBSO9aP6/OSAuQPjlndLNdvzOOYbODz1AtYCj0p4KtY9GiubJPUojWKr8D5PITe7ZJeYy0IZm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B502463CF3CE;
	Thu, 12 Sep 2024 20:22:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wQSje5n0g5F7; Thu, 12 Sep 2024 20:22:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0420F63CF3E9;
	Thu, 12 Sep 2024 20:22:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3E5Un_6qz49c; Thu, 12 Sep 2024 20:22:48 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D118F63CF3CE;
	Thu, 12 Sep 2024 20:22:48 +0200 (CEST)
Date: Thu, 12 Sep 2024 20:22:48 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Li Zetao <lizetao1@huawei.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, willy@infradead.org
Message-ID: <731546887.37035.1726165368713.JavaMail.zimbra@nod.at>
In-Reply-To: <20240820025045.13339-1-lizetao1@huawei.com>
References: <20240820025045.13339-1-lizetao1@huawei.com>
Subject: Re: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: Convert hostfs_writepage to use folio
Thread-Index: Oc379SI6AfvPdJhPk8fAeiJLwgXW+w==

----- Urspr=C3=BCngliche Mail -----
> Von: "Li Zetao" <lizetao1@huawei.com>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>
> CC: lizetao1@huawei.com, "linux-um" <linux-um@lists.infradead.org>, "linu=
x-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Dienstag, 20. August 2024 04:50:45
> Betreff: [PATCH -next] hostfs: Convert hostfs_writepage to use folio

> convert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
>=20
> [1]: https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
>=20
> Cc: Matthew Wilcox <willy@infradead.org>

You patch submission didn't CC Matthew. Adding him now.

> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
> fs/hostfs/hostfs_kern.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 6d1cf2436ead..e17e70f20fa1 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -411,18 +411,19 @@ static const struct file_operations hostfs_dir_fops=
 =3D {
>=20
> static int hostfs_writepage(struct page *page, struct writeback_control *=
wbc)
> {
> -=09struct address_space *mapping =3D page->mapping;
> -=09struct inode *inode =3D mapping->host;
> +=09struct folio *folio =3D page_folio(page);
> +=09struct address_space *mapping =3D folio->mapping;
> +=09struct inode *inode =3D folio_inode(folio);
> =09char *buffer;
> -=09loff_t base =3D page_offset(page);
> +=09loff_t base =3D folio_pos(folio);
> =09int count =3D PAGE_SIZE;
> =09int end_index =3D inode->i_size >> PAGE_SHIFT;
> =09int err;
>=20
> -=09if (page->index >=3D end_index)
> +=09if (folio->index >=3D end_index)
> =09=09count =3D inode->i_size & (PAGE_SIZE-1);
>=20
> -=09buffer =3D kmap_local_page(page);
> +=09buffer =3D kmap_local_folio(folio, 0);
>=20
> =09err =3D write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
> =09if (err !=3D count) {
> @@ -439,7 +440,7 @@ static int hostfs_writepage(struct page *page, struct
> writeback_control *wbc)
>=20
>  out:
> =09kunmap_local(buffer);
> -=09unlock_page(page);
> +=09folio_unlock(folio);
>=20
> =09return err;
> }
> --
> 2.34.1

