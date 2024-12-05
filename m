Return-Path: <linux-kernel+bounces-432555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5BB9E4CEA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60171881A2E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272BA191F60;
	Thu,  5 Dec 2024 03:56:59 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78572391A6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371018; cv=none; b=t1tACTzxH4WFHiNmPMafgwN7gheHG1N6ytGGA2aZrtX0hvVHAULGcMiqgbMHzE7X1cVU3VadrXA8kOknWWo8/FoBXPQyqbh7qEpWSRT2BnX0MhWxZg26rinxbVjdDaaYA8zlPKbjx4UnwsDiokCkBBAiMDNwYee0xaKpsTLxAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371018; c=relaxed/simple;
	bh=znsleuUfC2G1hJwjU/6jWn9E76LkD/Dlnmz0o42y8Zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfivDP3AuWax7AUTzKgo0zaFxG54P1wBebNVWZ0b6TFodilFgPqcwGNJljRGcy9sMHHYBP1xavspLOlILMp+8NQFhdHqZLYRcyb5ZMp8uV07aVxEctK++Cdv2XY43FwqM/fETmLhJUbwlcMox6jLr7LoKPm3nBqnNhwBzlwDips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Y3gBv1WyKzYlGnT;
	Thu,  5 Dec 2024 11:40:23 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Dec
 2024 11:40:35 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Dec
 2024 11:40:35 +0800
From: wangzijie <wangzijie1@honor.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
CC: <chao@kernel.org>, <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
	<shengyong@oppo.com>, <wangzijie1@honor.com>
Subject: Re: [f2fs-dev] f2fs-tools: Check and fix inline xattr inplace
Date: Thu, 5 Dec 2024 11:40:34 +0800
Message-ID: <20241205034035.3119810-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <502ae396-ae82-44d6-b08d-617e9e9c4092@oppo.com>
References: <502ae396-ae82-44d6-b08d-617e9e9c4092@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)

>On 2024/12/4 20:23, wangzijie wrote:=0D
>> When we check inode which just has inline xattr data, we copy=0D
>> inline xattr data from inode, check it(maybe fix it) and copy=0D
>> it again to inode. We can check and fix xattr inplace for this=0D
>> kind of inode to reduce memcpy times.=0D
>> =0D
>> Signed-off-by: wangzijie <wangzijie1@honor.com>=0D
>> ---=0D
>>   fsck/fsck.c | 18 ++++++++++++++----=0D
>>   1 file changed, 14 insertions(+), 4 deletions(-)=0D
>> =0D
>> diff --git a/fsck/fsck.c b/fsck/fsck.c=0D
>> index aa3fb97..fd8b082 100644=0D
>> --- a/fsck/fsck.c=0D
>> +++ b/fsck/fsck.c=0D
>> @@ -840,11 +840,18 @@ int chk_extended_attributes(struct f2fs_sb_info *s=
bi, u32 nid,=0D
>>   	struct f2fs_xattr_entry *ent;=0D
>>   	__u32 xattr_size =3D XATTR_SIZE(&inode->i);=0D
>>   	bool need_fix =3D false;=0D
>> +	bool has_xattr_node =3D false;=0D
>> +	nid_t xnid =3D le32_to_cpu(inode->i.i_xattr_nid);=0D
>>   =0D
>>   	if (xattr_size =3D=3D 0)=0D
>>   		return 0;=0D
>>   =0D
>> -	xattr =3D read_all_xattrs(sbi, inode, false);=0D
>> +	if (xattr_size <=3D inline_xattr_size(&inode->i) && !xnid)=0D
>Hi, zijie,=0D
>=0D
>I propose to change the behavors of read_all_xattrs and write_all_xattrs, =
and to add a=0D
>new free_xattrs.=0D
>=0D
>* read_all_xattrs checks whether xnid exist. If it's not, return inline_xa=
ttr directly=0D
>   without alloc and memcpy.=0D
>* write_all_xattrs checks whether inline_xattr and new txattr_addr have th=
e same address=0D
>   to avoid copying back.=0D
>* free_xattrs checks whether inline_xattr and new txattr_addr have the sam=
e address to=0D
>   free xattr buffer properly.=0D
>=0D
>In this way, all instances where {read|write}_all_xattrs are called can av=
oid unnecessary=0D
>memory alloc and copy. free_xattrs(xattrs) should be used instead of free(=
xattrs).=0D
>=0D
>thanks,=0D
>shengyong=0D
=0D
Hi, yong=0D
Thanks for sharing what you proposed to do. By the way, I noticed that =0D
when setattr, read_all_xattr will set xattr header's magic and refcount,=0D
but it seems we don't check these values in header(kernel/fsck). Should we =
=0D
add check logic for it?=0D
=0D
>> +		xattr =3D inline_xattr_addr(&inode->i);=0D
>> +	else {=0D
>> +		xattr =3D read_all_xattrs(sbi, inode, false);=0D
>> +		has_xattr_node =3D true;=0D
>> +	}=0D
>>   	ASSERT(xattr);=0D
>>   =0D
>>   	last_base_addr =3D (void *)xattr + xattr_size;=0D
>> @@ -867,12 +874,15 @@ int chk_extended_attributes(struct f2fs_sb_info *s=
bi, u32 nid,=0D
>>   	}=0D
>>   	if (need_fix && c.fix_on) {=0D
>>   		memset(ent, 0, (u8 *)last_base_addr - (u8 *)ent);=0D
>> -		write_all_xattrs(sbi, inode, xattr_size, xattr);=0D
>> +		if (has_xattr_node) {=0D
>> +			write_all_xattrs(sbi, inode, xattr_size, xattr);=0D
>> +			free(xattr);=0D
>> +		}=0D
>>   		FIX_MSG("[0x%x] nullify wrong xattr entries", nid);=0D
>> -		free(xattr);=0D
>>   		return 1;=0D
>>   	}=0D
>> -	free(xattr);=0D
>> +	if (has_xattr_node)=0D
>> +		free(xattr);=0D
>>   	return 0;=0D
>>   }=0D
>>   =0D
>=0D
>=0D
>=0D
>_______________________________________________=0D
>Linux-f2fs-devel mailing list=0D
>Linux-f2fs-devel@lists.sourceforge.net=0D
>https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel=0D
=0D

