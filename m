Return-Path: <linux-kernel+bounces-547131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B127FA50349
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDC43A7ADE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38724E4A0;
	Wed,  5 Mar 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8BQ5Y7o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6998460
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187786; cv=none; b=JB13A9JbqpCFk70UE/Ld++ifGLKAteJnjxa3pMqO3DegI0r3KHUwPLzcU22dxHpS/6IK1+zuE37fJjSF/GGqqvedvtVR6HcdD6eI8ZZ5h8ssWEx3mNy60PVLni/dIraGe91TtpROh2twvTP7HAQcSBOvNeaCp2mu5nUhtDyEwzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187786; c=relaxed/simple;
	bh=/ShZhVPtJr4+4o6krCssL/Gbe44AN9lbhxnovSZUweU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=aKQpl50HrmWBdCxndsQ8jN8oLc2cTURMvNat90uU7FYWrW3TfSzvhEicaA8AbxtDrQht8RB/9VJ1d5IbAE7mY4zn+HYAYVWw6c1x5fGeT1wTBQTJ1RfqlNWhMkAVru7b5nWyooSJK2DYsmIpn4TKheHt/NS+utDV42T2n/WgyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8BQ5Y7o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741187784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeISuS/evk/TM3j9QzoSRQzIAJ0c3rz9FhJHNooEGGU=;
	b=L8BQ5Y7oTk6OwndulU2MZEFfx91sZgq14gxBS3IEAM03MHeKM+ZoWiBJoTa5nbywv1Z2WW
	1akW42i3idqvf09eYJA6yV2olb5ishRRxBVIHNHlPn5o69sN0PkTgopEsMa70wxYUxZhdw
	P7AyCvsnDxva6aDlBBGByWDOOvGKXNE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-GOra96h5PjOwAo_MEnkZnA-1; Wed,
 05 Mar 2025 10:16:10 -0500
X-MC-Unique: GOra96h5PjOwAo_MEnkZnA-1
X-Mimecast-MFC-AGG-ID: GOra96h5PjOwAo_MEnkZnA_1741187769
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F4451954B39;
	Wed,  5 Mar 2025 15:16:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB38B1956095;
	Wed,  5 Mar 2025 15:16:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <26a4651e-b56c-4350-8f9a-e0e2a2a3b452@stanley.mountain>
References: <26a4651e-b56c-4350-8f9a-e0e2a2a3b452@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] afs: Fix error code in afs_alloc_cell()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4167139.1741187764.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Mar 2025 15:16:04 +0000
Message-ID: <4167140.1741187764@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Return the error code if idr_alloc_cyclic() fails.  Currently it
> potentially could return either -ENOMEM or an uninitialized variable.

Thanks, but Christian has already pulled an updated version into his tree.=
  It
may not have made it into linux-next yet:

--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -203,7 +203,13 @@ static struct afs_cell *afs_alloc_cell(struct afs_net=
 *net,
 	cell->dns_status =3D vllist->status;
 	smp_store_release(&cell->dns_lookup_count, 1); /* vs source/status */
 	atomic_inc(&net->cells_outstanding);
+	ret =3D idr_alloc_cyclic(&net->cells_dyn_ino, cell,
+			       2, INT_MAX / 2, GFP_KERNEL);
+	if (ret < 0)
+		goto error;
+	cell->dynroot_ino =3D ret;
 	cell->debug_id =3D atomic_inc_return(&cell_debug_id);
+
 	trace_afs_cell(cell->debug_id, 1, 0, afs_cell_trace_alloc);
 =

 	_leave(" =3D %p", cell);

David


