Return-Path: <linux-kernel+bounces-355864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9D995828
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810E928A60A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5D2213EFF;
	Tue,  8 Oct 2024 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmS23MkC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB68213EFB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418188; cv=none; b=LNcr1yy4m/o6WUeTjHQx8pwY2WlrQv++BA0dAJ7KUUpGB0v1OJZm+V8lkYnmz96xS/hGxmL7ibk/RX4aBJNEwjb5fh6TYrNgLvdhlcOjY+iDfxqMAgLf97BWL+kXYF25eCvKOloSRDdy2mg9QRqlYiTBGOuea/1yuQHJy/mkfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418188; c=relaxed/simple;
	bh=BKvRzmG8zYQq/3wAB1De8TfUM2+YdFa4tVx6nY/GTt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8NHmp8vtEwAl9VQVOUMdC0vt+BkIhag3cr6NTFg1bQUqpeRL1HMK30jcHb3d3faq4wdbpjjz+EHcUEzXUQbRdyFkqXJ+rVudY7vL27qN5DbCuENzscb9LPS3iHtHxWvOeb6NdJCHczUM9dTNV21WShuU2s2PVdcql202Q8pmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmS23MkC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728418186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4IyMs3DYz1iO2v17yE6rwIhRPU2F8xvoKO1L4wkbIE=;
	b=bmS23MkCkRkbqX9fNlvrvkHO+XWILaCdMtR0CfzENv5x06o+KiM8P4BXAySxOj7VjCduVY
	26m1+Yk21qDDPRpotX9nMN8e23GVpXlxdx50Um3xRmAhmZhlF+K3Ur/AoKxFQxme/mQ0yq
	Qx8/NLBdxSj9o0rET0mJQ2P6vgd1t4U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-7sjfBCQAPgS8zdbSsAonwA-1; Tue,
 08 Oct 2024 16:09:43 -0400
X-MC-Unique: 7sjfBCQAPgS8zdbSsAonwA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9722819560B1;
	Tue,  8 Oct 2024 20:09:41 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 895F719560A2;
	Tue,  8 Oct 2024 20:09:39 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, akpm@linux-foundation.org, linux-nfs@vger.kernel.org,
 gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] nfs: sysfs: use default get_ownership() callback
Date: Tue, 08 Oct 2024 16:09:37 -0400
Message-ID: <ECD4A28B-9987-42BC-91DC-8DED8CAEED21@redhat.com>
In-Reply-To: <20241003151435.3753959-5-aahringo@redhat.com>
References: <20241003151435.3753959-1-aahringo@redhat.com>
 <20241003151435.3753959-5-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 3 Oct 2024, at 11:14, Alexander Aring wrote:

> Since commit 5f81880d5204 ("sysfs, kobject: allow creating kobject
> belonging to arbitrary users") it seems that there could be cases for
> kobjects belonging to arbitrary users. This callback is set by default
> when using kset_create_and_add() to allow creating kobjects with
> different ownerships according to its parent.
>
> This patch will assign the default callback now for nfs kobjects for
> cases when the parent has different ownership than the default one.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/nfs/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index a6584203b7ff..b5737464b892 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -27,6 +27,7 @@ static const struct kobj_ns_type_operations *nfs_netn=
s_object_child_ns_type(
>  }
>
>  static struct kobj_type nfs_kset_type =3D {
> +	.get_ownership =3D kset_get_ownership,
>  	.release =3D kset_release,
>  	.sysfs_ops =3D &kobj_sysfs_ops,
>  	.child_ns_type =3D nfs_netns_object_child_ns_type,
> -- =

> 2.43.0

Hi Alex, if I understand this correctly, this patch just punts the owners=
hip
callback up to fs_kobj, which, because it has no .get_ownership is just
going to be the same result: root.

Does this patch add value?

Ben


