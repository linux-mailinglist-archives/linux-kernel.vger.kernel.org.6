Return-Path: <linux-kernel+bounces-399723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502689C0372
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3301F215A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498181F4299;
	Thu,  7 Nov 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E8Yoffr3"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CD1DFE2F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977793; cv=none; b=UQkINjmKsUof5RSeIoeyGl4bbVtp1l8m1dwdh96ZTmLvFEKJB0x52cxZFQLUhYde1v8DJafUGv+FyuCBBl/+QbEpyHTh61E0UKzfUySGBOkBSEF3EbYL4cyDIlTygmIlnO/+RAMamWaymZZGuqKCDG86dtOYdIuYKfcnkCbtW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977793; c=relaxed/simple;
	bh=8aHD7W6Ht8fDQwB3vAXgXnkNqgUDKXUBZpBsZgLrdl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J646YHeqmoAG3LwRDiJ/lkjusjfytfFPsKC0La1+aGfHsItll5nUtGv1MDlTw8/2CXsh4V4I3hXW+pKDwOtE+04xtaUe2IK8JnbfbFJAbKLmXkQYtGUPLf2oAu0KsXFb/2/GeTr4ahV0NU6xIuQZFy6iphnfbAQEkR63rZ42HdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E8Yoffr3; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730977788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIlgsYE+XXSE/ly7Hc6W6Z99lO+NKZkrAF66GCW0yX0=;
	b=E8Yoffr30msIKibeYjRjIs/Wej2+J04iMd6+/PcdlBV2/+PE7rkRqcIQ0QFDFmccAnJHJk
	l57qvngsJs9ckoSYMgxPAqiQkrM93rJjH1gi4OkKW9mPSXiUvoYtj4PxcakGmgNtD3Yh/I
	s3yRDXxZrtU3nBsncpI8b0Mqob6e7+M=
From: Luis Henriques <luis.henriques@linux.dev>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubli@redhat.com>,  Ilya
 Dryomov <idryomov@gmail.com>,  ceph-devel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] ceph: ceph: fix out-of-bound array access when
 doing a file read
In-Reply-To: <yvmwdvnfzqz3efyoypejvkd4ihn5viagy4co7f4pquwrlvjli6@t7k6uihd2pp3>
	(Goldwyn Rodrigues's message of "Wed, 6 Nov 2024 15:40:44 -0500")
References: <yvmwdvnfzqz3efyoypejvkd4ihn5viagy4co7f4pquwrlvjli6@t7k6uihd2pp3>
Date: Thu, 07 Nov 2024 11:09:38 +0000
Message-ID: <87ldxvuwp9.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

(CC'ing Alex)

On Wed, Nov 06 2024, Goldwyn Rodrigues wrote:

> Hi Xiubo,
>
>> BTW, so in the following code:
>>=20
>> 1202                 idx =3D 0;
>> 1203                 if (ret <=3D 0)
>> 1204                         left =3D 0;
>> 1205                 else if (off + ret > i_size)
>> 1206                         left =3D i_size - off;
>> 1207                 else
>> 1208                         left =3D ret;
>>=20
>> The 'ret' should be larger than '0', right ?
>>=20
>> If so we do not check anf fix it in the 'else if' branch instead?
>>=20
>> Because currently the read path code won't exit directly and keep=20
>> retrying to read if it found that the real content length is longer than=
=20
>> the local 'i_size'.
>>=20
>> Again I am afraid your current fix will break the MIX filelock semantic ?
>
> Do you think changing left to ssize_t instead of size_t will
> fix the problem?
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 4b8d59ebda00..f8955773bdd7 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>  	if (ceph_inode_is_shutdown(inode))
>  		return -EIO;
>=20=20
> -	if (!len)
> +	if (!len || !i_size)
>  		return 0;
>  	/*
>  	 * flush any page cache pages in this range.  this
> @@ -1087,7 +1087,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>  		size_t page_off;
>  		bool more;
>  		int idx;
> -		size_t left;
> +		ssize_t left;
>  		struct ceph_osd_req_op *op;
>  		u64 read_off =3D off;
>  		u64 read_len =3D len;
>

I *think* (although I haven't tested it) that you're patch should work as
well.  But I also think it's a bit more hacky: the overflow will still be
there:

		if (ret <=3D 0)
			left =3D 0;
		else if (off + ret > i_size)
			left =3D i_size - off;
		else
			left =3D ret;
		while (left > 0) {
			// ...
		}

If 'i_size' is '0', 'left' (which is now signed) will now have a negative
value in the 'else if' branch and the loop that follows will not be
executed.  My version will simply set 'ret' to '0' before this 'if'
construct.

So, in my opinion, what needs to be figured out is whether this will cause
problems on the MDS side or not.  Because on the kernel client, it should
be safe to ignore reads to an inode that has size set to '0', even if
there's already data available to be read.  Eventually, the inode metadata
will get updated and by then we can retry the read.

Unfortunately, the MDS continues to be a huge black box for me and the
locking code in particular is very tricky.  I'd rather defer this for
anyone that is familiar with the code.

Cheers,
--=20
Lu=C3=ADs

