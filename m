Return-Path: <linux-kernel+bounces-359368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FB4998B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7E5B2C0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22461E1A10;
	Thu, 10 Oct 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVT1FURU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D111C6F45
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571952; cv=none; b=dv/NCuMHvJ/9LIcuz88iwzOLVQJOlhCrpLwEw+4niBY2mJcdtRzlOusF9oCZ7ArCO6C87WhOf9lMnX+Jfnip2e5fQ2iCsWsScYtfjFrNgf3z1+D03qcMLJiaiQ27NRXB+zuJrbhjhfguc02RwTwcrVnBUpMw3QqsF6plJVsl6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571952; c=relaxed/simple;
	bh=+WVT1NE80MQ2tJEJ6OJMW6GCdodvz/z2J4VPtuujUAY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=RFpOAX6rg66JEzTbhV4vC8Vjfm//1gl8qicCmH2scHsCtgPBaSDhXvg3ZDgVlaAGswBSxkGcq6bdtFpktB3C0/KkkwqKdeXofao4kMhGUzaY7AGHEs6nwZzI0FFS/MUaRutW0rtd3ki7nVLj9/h6Fv6lHjyesCYGKCaNLl41jz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVT1FURU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728571950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/rzIBijz35TvrQXNNS/JV1cr2x4Od/FDIZTbeen1ZA=;
	b=UVT1FURUS8lPPeVXLVM/5R2zd035Xri+jFedcZlVqXaeYp2sUNTLdIRhLWmws1x6MlCqok
	pVaygel0+89OeYZRPMZ5WA38TmexojKZHCr46e6sHyMkeJGeq/CYJuW5KiNbhkxxl5JD8K
	4JyW0doFk4jUtYO5uDRbAPApJ9TWgwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-cLA6nZKQNX2jBcl9sJatzw-1; Thu,
 10 Oct 2024 10:52:28 -0400
X-MC-Unique: cLA6nZKQNX2jBcl9sJatzw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 154261956046;
	Thu, 10 Oct 2024 14:52:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E14DE1956052;
	Thu, 10 Oct 2024 14:52:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8d05cae1-55d2-415b-810e-3fb14c8566fd@huawei.com>
References: <8d05cae1-55d2-415b-810e-3fb14c8566fd@huawei.com> <20240821024301.1058918-8-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com> <303977.1728559565@warthog.procyon.org.uk>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 7/8] cachefiles: Fix NULL pointer dereference in object->file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 15:52:20 +0100
Message-ID: <443969.1728571940@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Zizhi Wo <wozizhi@huawei.com> wrote:

> =E5=9C=A8 2024/10/10 19:26, David Howells =E5=86=99=E9=81=93:
> > Zizhi Wo <wozizhi@huawei.com> wrote:
> >=20
> >> +	spin_lock(&object->lock);
> >>   	if (object->file) {
> >>   		fput(object->file);
> >>   		object->file =3D NULL;
> >>   	}
> >> +	spin_unlock(&object->lock);
> > I would suggest stashing the file pointer in a local var and then doing=
 the
> > fput() outside of the locks.
> > David
> >=20
>=20
> If fput() is executed outside the lock, I am currently unsure how to
> guarantee that file in __cachefiles_write() does not trigger null
> pointer dereference...

I'm not sure why there's a problem here.  I was thinking along the lines of:

	struct file *tmp;
	spin_lock(&object->lock);
 	tmp =3D object->file)
	object->file =3D NULL;
	spin_unlock(&object->lock);
	if (tmp)
		fput(tmp);

Note that fput() may defer the actual work if the counter hits zero, so the
cleanup may not happen inside the lock; further, the cleanup done by __fput=
()
may sleep.

David


