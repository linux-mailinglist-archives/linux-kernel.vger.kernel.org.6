Return-Path: <linux-kernel+bounces-303452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930D960C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5F41C22E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03C1C1725;
	Tue, 27 Aug 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w+JX/Hgq"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CD1BFDF3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765801; cv=none; b=H/ZmRdsciTKZuqy7ltDTuC3gc0r9OMAxmZzAjkiUmE2AUumfUKhcL/tqjwloZUiBeAD0CmqrzfM2LnLbHvHAXkW9bczzX32TzfmKJHqtIpW7Hm+O5olqtGM3v5wjTvoJh5CYZ6QU0j30flXcY79n9BNh4UdnLip9gsAdehoq/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765801; c=relaxed/simple;
	bh=2BfLlfZNpjATIv4G7J2SgXFYlzQxHH4irggz/urF4y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=giUoslMU8NWjhOgcYUO76uM5/4gTTAgkyhQzDjQqdDs9CsZhhgQT7vS2TnZmNrIg0GeHs9x5ueGAgluddhCopoN8x6htqB1k2PC1mDr/ghL1Fs4CIYJxRySvJ7uCLasgolDQ/rpCN2X00dKncIS9y+Lt0VvhdpbNcc3o+K9TJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w+JX/Hgq; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724765796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRIGZ0wgkj3ZUOkwKf4jqmKYT6MZrP5kCetvM2EiQSI=;
	b=w+JX/HgqXJY99M2E1FzwM/vwsbRRKPRUp+jjaol77ATBJkajayTrTlwJ07tJxC+jLraHyf
	588bIZuK+HRR6oiFJydwVqpkevg+inmV1CIng0/MuriQQ6xo0XB57Qk95LF9lom7PeZyc3
	N2CUdtz7o94Bvuwh07IwHw+V/86bqPo=
From: Luis Henriques <luis.henriques@linux.dev>
To: Xiubo Li <xiubli@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,  ceph-devel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ceph: fix out-of-bound array access when doing a
 file read
In-Reply-To: <20240822150113.14274-1-luis.henriques@linux.dev> (Luis
	Henriques's message of "Thu, 22 Aug 2024 16:01:13 +0100")
References: <20240822150113.14274-1-luis.henriques@linux.dev>
Date: Tue, 27 Aug 2024 14:36:14 +0100
Message-ID: <87mskyxf3l.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 22 2024, Luis Henriques (SUSE) wrote:

> If, while doing a read, the inode is updated and the size is set to zero,
> __ceph_sync_read() may not be able to handle it.  It is thus easy to hit a
> NULL pointer dereferrence by continuously reading a file while, on another
> client, we keep truncating and writing new data into it.
>
> This patch fixes the issue by adding extra checks to avoid integer overfl=
ows
> for the case of a zero size inode.  This will prevent the loop doing page
> copies from running and thus accessing the pages[] array beyond num_pages.
>
> Link: https://tracker.ceph.com/issues/67524
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
> Hi!
>
> Please note that this patch is only lightly tested and, to be honest, I'm
> not sure if this is the correct way to fix this bug.  For example, if the
> inode size is 0, then maybe ceph_osdc_wait_request() should have returned
> 0 and the problem would be solved.  However, it seems to be returning the
> size of the reply message and that's not something easy to change.  Or ma=
ybe
> I'm just reading it wrong.  Anyway, this is just an RFC to see if there's
> other ideas.
>
> Also, the tracker contains a simple testcase for crashing the client.

Just for the record, I've done a quick bisect as this bug is easily
reproducible.  The issue was introduced in v6.9-rc1, with commit
1065da21e5df ("ceph: stop copying to iter at EOF on sync reads").
Reverting it makes the crash go away.

Cheers,
--=20
Lu=C3=ADs


>  fs/ceph/file.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 4b8d59ebda00..dc23d5e5b11e 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1200,9 +1200,9 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>  		}
>=20=20
>  		idx =3D 0;
> -		if (ret <=3D 0)
> +		if ((ret <=3D 0) || (i_size =3D=3D 0))
>  			left =3D 0;
> -		else if (off + ret > i_size)
> +		else if ((i_size >=3D off) && (off + ret > i_size))
>  			left =3D i_size - off;
>  		else
>  			left =3D ret;
> @@ -1210,6 +1210,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>  			size_t plen, copied;
>=20=20
>  			plen =3D min_t(size_t, left, PAGE_SIZE - page_off);
> +			WARN_ON_ONCE(idx >=3D num_pages);
>  			SetPageUptodate(pages[idx]);
>  			copied =3D copy_page_to_iter(pages[idx++],
>  						   page_off, plen, to);
> @@ -1234,7 +1235,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>  	}
>=20=20
>  	if (ret > 0) {
> -		if (off >=3D i_size) {
> +		if ((i_size >=3D *ki_pos) && (off >=3D i_size)) {
>  			*retry_op =3D CHECK_EOF;
>  			ret =3D i_size - *ki_pos;
>  			*ki_pos =3D i_size;
>


