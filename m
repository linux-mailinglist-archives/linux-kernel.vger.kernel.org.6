Return-Path: <linux-kernel+bounces-396307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02F9BCB44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DFE283B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01501D3590;
	Tue,  5 Nov 2024 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kdSbBa+h"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E471D2F5C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804823; cv=none; b=ObmJ4oUVKlmbwpmZ001F9Y2UPIogHYUo27bzPn9sLIBZ6cTnRIRvm9v+V3uInBiR9M2lYPyziOU6lLzl7ZwTF5FkschfJEuDEvZ7sD/rY1xGa4HMaDdcpqVt55qZLmoJJQ7s7AyubTjRvLq1HFts+GA6JAf/3Oco1WJYJebFl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804823; c=relaxed/simple;
	bh=IjBLL8qaOxto8tsy6MxBrHfuLqnGwoiBExpfA+aYnkk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s6XsJeVbqiT5jJl/3F940YvdT1ndek7flJRBVZ+iG7lgGUaNWYWq5kqAFQjhrWPUphYvOFxIyYg7dk7TNg5ulXRtnee5YPHpIAVWxhHhPqza3KwkHD7dDkZgnvo59/acfu3vS+tfUGMXHEqNP+mKwSRxk+4Pwcfs2b9R1i4oIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kdSbBa+h; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730804817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjBLL8qaOxto8tsy6MxBrHfuLqnGwoiBExpfA+aYnkk=;
	b=kdSbBa+h2y3YdWpMVgTGmDKahIJ7thKxaM9hVyZLv+iN6ydmms3UxyFnFKZIFeb7V9kkl2
	iUimy0AjokxtqaMZGMQ9F389gzNasUNWukcMbd44ZcOpkxO3eDsywwX0neHneEE4sCsnxI
	qEhlBUjl/Zuwt7W49HZcfMfI2e/z+jY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] ext4: Use struct_size() to improve
 ext4_htree_store_dirent()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2024110539-frugality-glutton-58f0@gregkh>
Date: Tue, 5 Nov 2024 12:06:42 +0100
Cc: Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F6CE3AC-0C34-46E5-BF67-95845DFC8449@linux.dev>
References: <20241105103353.11590-2-thorsten.blum@linux.dev>
 <2024110539-frugality-glutton-58f0@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 5. Nov 2024, at 11:39, Greg KH wrote:
> On Tue, Nov 05, 2024 at 11:33:54AM +0100, Thorsten Blum wrote:
>> Inline and use struct_size() to calculate the number of bytes to
>> allocate for new_fn and remove the local variable len.
>>=20
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> This change was originally part of another patch that was split into =
two
>> separate patches after feedback from Greg KH
>> - Link: =
https://lore.kernel.org/r/20241104234214.8094-2-thorsten.blum@linux.dev/
>> ---
>> fs/ext4/dir.c | 5 ++---
>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
>> index 233479647f1b..02d47a64e8d1 100644
>> --- a/fs/ext4/dir.c
>> +++ b/fs/ext4/dir.c
>> @@ -471,14 +471,13 @@ int ext4_htree_store_dirent(struct file =
*dir_file, __u32 hash,
>> struct rb_node **p, *parent =3D NULL;
>> struct fname *fname, *new_fn;
>> struct dir_private_info *info;
>> - int len;
>>=20
>> info =3D dir_file->private_data;
>> p =3D &info->root.rb_node;
>>=20
>> /* Create and allocate the fname structure */
>> - len =3D sizeof(struct fname) + ent_name->len + 1;
>> - new_fn =3D kzalloc(len, GFP_KERNEL);
>> + new_fn =3D kzalloc(struct_size(new_fn, name, ent_name->len + 1),
>> + GFP_KERNEL);
>=20
> Does this actually matter and make the code any more robust or faster?
>=20
> The original code here is easier to read and understand, why add
> complexity if it is not required?

I find struct_size() to be more readable because it explicitly
communicates the relationship between the flexible array member name and
ent_name->len that the open-coded version doesn't. Plus, struct_size()
has some additional compile-time checks (e.g., __must_be_array()).

Thanks,
Thorsten


