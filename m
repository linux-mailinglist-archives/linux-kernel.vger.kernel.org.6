Return-Path: <linux-kernel+bounces-398823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C29BF680
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A11C1F21A23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED399199247;
	Wed,  6 Nov 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAcsGUGh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983418C903
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921422; cv=none; b=AQpWHLT6zu/WCClhVzE6JTRlkXUecZcNUx++nYWQY9r9RLxZ3REsmBhju0tY66y6tpeCkl4E249L+MVcX2yvA7JIpRDsUgdMUuQuZbYMxeao9BBDu6y0yg1Gvf6jSBVfBj76lIAEixOTF30sOuutwoyICDQeTdL0Nn0ZCgOKL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921422; c=relaxed/simple;
	bh=LYPx2RY7qWthrzmKtNx04Q/EDCTv0h2uWzWbldndaB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2+Bp6LCszKmwnasI0/l44xgvDp+j3YyQxtIN15OQxll4remaHQKLsXmQtvxgAXCUBIzXjYXoxoPBqREVoXPsgWcZvk5v/Z4e8X9KZGSHP2jy6VbuMRiCViE+Y+cFQsNsgpzfkxiZg7a7IKflRq8RM4ZY/b/AkqcI8bX9vzmbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAcsGUGh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730921419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYPx2RY7qWthrzmKtNx04Q/EDCTv0h2uWzWbldndaB8=;
	b=gAcsGUGhVrvoaUdS4b3ic3Zzz3BaW3xM2VPsMtxYp1KIshKWFPaq29yx47wP9c49+xUFt8
	3qj8tZSEU4Et+vVE7Hzru9F/FCbVdOUvokbYPmCsUmoB4XvI71KHsOj8Lfqx6yNHTTS4t9
	Z9aCHZEO1ZM8da7F16BZ1kb0Ecdh0Hg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-Wl2NuUOLOLOFwl2VZQJD2A-1; Wed,
 06 Nov 2024 14:30:13 -0500
X-MC-Unique: Wl2NuUOLOLOFwl2VZQJD2A-1
X-Mimecast-MFC-AGG-ID: Wl2NuUOLOLOFwl2VZQJD2A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A926C19560A3;
	Wed,  6 Nov 2024 19:30:11 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 939991955F41;
	Wed,  6 Nov 2024 19:30:10 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "open list:NFS" <linux-nfs@vger.kernel.org>,
 "SUNRPC, AND LOCKD CLIENTS)," <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_sysfs_link_rpc_client(): Replace strcpy with strscpy
Date: Wed, 06 Nov 2024 14:30:08 -0500
Message-ID: <8A472C39-0EC9-469F-B568-012BC794C3D5@redhat.com>
In-Reply-To: <20241106024952.494718-1-danielyangkang@gmail.com>
References: <20241106024952.494718-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 5 Nov 2024, at 21:49, Daniel Yang wrote:

> The function strcpy is deprecated due to lack of bounds checking. The
> recommended replacement is strscpy.
>
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


