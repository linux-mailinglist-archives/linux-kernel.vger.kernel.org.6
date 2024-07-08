Return-Path: <linux-kernel+bounces-243975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2E929D44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F3DB2138E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9FE2374E;
	Mon,  8 Jul 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZFjgk/7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB20A2E62D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424410; cv=none; b=f1PQEX+IUts1jOeKP/hewNOfkmkKpUGE99M2zZqbt/A/NZCNsJArTUAphTUvn9dKcb4UB+0NZp4q6LOtUcB1P2el14W6FEEJvLPjuXrAsP0gkYMtAo0GBGOVzujgHjBFQDl4u8h19PBTj0nN1Eq/eCnJb6hVKRIlulWqQyn09Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424410; c=relaxed/simple;
	bh=SpDSboa7oGmRDhx/k6wE6KF7kP4inD3V2rVBJJ2oJZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6+sYEcCy+vLhX206lxb77MnsQu/Btyu/Qucr3StVFmlX3IJ8+2Y8eGLYEJyzIU5tjOXJSfIlP/6QZeLNvPEpiKMziOFz32pmo8NLlUaJ0qzpYwzBYmI8N4fKwC2q7AVt8Le7MlS1R86FyV77BbbcVXDunUZ6ntN8Mgfne3kLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZFjgk/7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720424407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsM1zzo2EHPt9L+YcT4nXiccWCmRJsSwtfUO1i17zD4=;
	b=BZFjgk/7xk4civPB3aD7UjQMJlP0TAExmXB5AApqh5PsESxhlke0l+m2jcjrJUtme25B4N
	Q6etmxTJxAYzPJ7FZtds26K/mpFdbaUbpxCL9PEfzhBAq+Gyfq+y3W/2Cy8iY5iO0JaxcV
	g4RNzGuTombkvfA6QCF3s8iICNEjdVc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-yk7Y3MpwPnyI78oMz-7ULQ-1; Mon,
 08 Jul 2024 03:40:05 -0400
X-MC-Unique: yk7Y3MpwPnyI78oMz-7ULQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A61F6195609F;
	Mon,  8 Jul 2024 07:40:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.131])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91C721955E85;
	Mon,  8 Jul 2024 07:40:00 +0000 (UTC)
Date: Mon, 8 Jul 2024 09:39:57 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pbonzini@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 1/5] virtio_blk: Fix default logical block size fallback
Message-ID: <20240708073957.GA38033@dynamic-pd01.res.v6.highway.a1.net>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
 <20240705115127.3417539-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FKw8Zu0f8Pq44lmG"
Content-Disposition: inline
In-Reply-To: <20240705115127.3417539-2-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


--FKw8Zu0f8Pq44lmG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 11:51:23AM +0000, John Garry wrote:
> If we fail to read a logical block size in virtblk_read_limits() ->
> virtio_cread_feature(), then we default to what is in
> lim->logical_block_size, but that would be 0.
>=20
> We can deal with lim->logical_block_size =3D 0 later in the
> blk_mq_alloc_disk(), but the code in virtblk_read_limits() needs a proper
> default, so give a default of SECTOR_SIZE.
>=20
> Fixes: 27e32cd23fed ("block: pass a queue_limits argument to blk_mq_alloc=
_disk")
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/block/virtio_blk.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FKw8Zu0f8Pq44lmG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaLl8sACgkQnKSrs4Gr
c8hcrgf/c+60lHGsplPnwddNePPY0ZKeSrLPVKP5bg+1ocK4K9OkqxheH0k7OVb7
N1J6w2jCV9BaQ+mqdvVF8tbuWasRkCR2t8obb8n8jFngPugUMQ5gGtNIbPWhOCIL
XHVFbQ4RrWln6E1iw3kJ5CZUSLBrCvb37oj6hMi0bEkxJI6uhTIqSaREfkpnYIZw
AN9bV1A+Nr8mPyYx91FKoVfPQqOmkUKC/kJnLlyH9kzYdM9meiiCVTIMVfLezuCW
xQZ8V0Tt93lxg71uGZsS7YtvRj9H6hT1PH+4G//cVMHobL2krs2TrbUeWD+T1fYq
wnT8E/Rq/KGl1ZCnZ2EZkrfhx+8WVw==
=DSki
-----END PGP SIGNATURE-----

--FKw8Zu0f8Pq44lmG--


