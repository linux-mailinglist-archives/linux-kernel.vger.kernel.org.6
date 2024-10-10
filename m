Return-Path: <linux-kernel+bounces-359137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EC9987EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A34B2710B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C601C9DFB;
	Thu, 10 Oct 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRVXh6co"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCA1C9DEA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567360; cv=none; b=tL3v+ZCNnPg7ZX/JSpy+xgZeR+66w5OM0oV8tWpk4zUmG6wU6ZXDm1KwOkFsJQJjXzpqvkD3TuoApDKJYX7zFwFTu2fDN72f1KyEvsmPwnpkq+TDKm0veB5kv1UzktR5A1JhTzb+mAensXNh94e2loLa+zVKNWKaScd4ThS9VNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567360; c=relaxed/simple;
	bh=cWoxMYwouaWii08puJZXUqyXaUlP+sbTkbJwaLhvTsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKfkhqi9afe4SNuod2R0uGRpUP+TSF5LlOLNOO9x4BEy12SzlouXRBnYHtLqZVWFdAGsEiveGu+QB2nJBLDs+++yzD3CozxiK/uS65Ccj4HBJfWsc6g60rNUxpIUZfx4ZyIpbvDsC7rU7v8WS3h2VLWyJqGsFidP8ZrfNkEKpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRVXh6co; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728567357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLWSdhm4cWTI/JECrdxeIVeuumDvtSKGj0GSu8fNSOg=;
	b=KRVXh6coDP7O+uvwj/ZDuBa/wzWRkR7dUJYki1TwjGJcusO8JxWpKXdBpuKIkv84542m8D
	XGTowTU+tPwEBodDLOkMXK6IE1x27c5KnHIHnX0SB3zyOl8528miLOtawQnqKSeeoOSY5L
	ZRYQCneVVsg2TOhLpZ6/03+/9RFsJrw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-PFTnS5JvPJaBuq8QEBPi4A-1; Thu,
 10 Oct 2024 09:35:54 -0400
X-MC-Unique: PFTnS5JvPJaBuq8QEBPi4A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9A5919560B6;
	Thu, 10 Oct 2024 13:35:51 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DABE19560A2;
	Thu, 10 Oct 2024 13:35:49 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Ye Bin <yebin@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/3] sysctl: add support for drop_caches for individual
 filesystem
Date: Thu, 10 Oct 2024 09:35:46 -0400
Message-ID: <5A1217C0-A778-4A9A-B9D8-5F0401DC1013@redhat.com>
In-Reply-To: <20241010121607.54ttcmdfmh7ywho7@quack3>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
 <20241010112543.1609648-3-yebin@huaweicloud.com>
 <20241010121607.54ttcmdfmh7ywho7@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10 Oct 2024, at 8:16, Jan Kara wrote:

> On Thu 10-10-24 19:25:42, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> In order to better analyze the issue of file system uninstallation cau=
sed
>> by kernel module opening files, it is necessary to perform dentry recy=
cling
>
> I don't quite understand the use case you mention here. Can you explain=
 it
> a bit more (that being said I've needed dropping caches for a particula=
r sb
> myself a few times for debugging purposes so I generally agree it is a
> useful feature).
>
>> on a single file system. But now, apart from global dentry recycling, =
it is
>> not supported to do dentry recycling on a single file system separatel=
y.
>> This feature has usage scenarios in problem localization scenarios.At =
the
>> same time, it also provides users with a slightly fine-grained
>> pagecache/entry recycling mechanism.
>> This patch supports the recycling of pagecache/entry for individual fi=
le
>> systems.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>  fs/drop_caches.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mm.h |  2 ++
>>  kernel/sysctl.c    |  9 +++++++++
>>  3 files changed, 54 insertions(+)
>>
>> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
>> index d45ef541d848..99d412cf3e52 100644
>> --- a/fs/drop_caches.c
>> +++ b/fs/drop_caches.c
>> @@ -77,3 +77,46 @@ int drop_caches_sysctl_handler(const struct ctl_tab=
le *table, int write,
>>  	}
>>  	return 0;
>>  }
>> +
>> +int drop_fs_caches_sysctl_handler(const struct ctl_table *table, int =
write,
>> +				  void *buffer, size_t *length, loff_t *ppos)
>> +{
>> +	unsigned int major, minor;
>> +	unsigned int ctl;
>> +	struct super_block *sb;
>> +	static int stfu;
>> +
>> +	if (!write)
>> +		return 0;
>> +
>> +	if (sscanf(buffer, "%u:%u:%u", &major, &minor, &ctl) !=3D 3)
>> +		return -EINVAL;
>
> I think specifying bdev major & minor number is not a great interface t=
hese
> days. In particular for filesystems which are not bdev based such as NF=
S. I
> think specifying path to some file/dir in the filesystem is nicer and y=
ou
> can easily resolve that to sb here as well.

Slight disagreement here since NFS uses set_anon_super() and major:minor
will work fine with it.  I'd prefer it actually since it avoids this
interface having to do a pathwalk and make decisions about what's mounted=

where and in what namespace.

Ben


