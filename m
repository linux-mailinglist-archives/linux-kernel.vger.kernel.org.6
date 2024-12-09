Return-Path: <linux-kernel+bounces-437974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE209E9B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16C31628A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7923312A;
	Mon,  9 Dec 2024 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPTfDn/B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F8481D1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760244; cv=none; b=PA6NUc+TqznTz9joosNooCsZmI6cb3Jk66nC0/HAJiZGXI6FASbgqCffFU7mpYpjKGS+psPjYqRAMJugOFBSEBuskyuwrCkFwP6xBha5lapEjbsVvKtU4AP3SnkXvp1j2j+1/IZk48vOwTf2wEHwBWbE90F1RimygzAEVBlyTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760244; c=relaxed/simple;
	bh=HcHrZ+agvz4D3sGtHxCE7PE6Arti4HiRiqeu5M1F8EI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ig5NgptJxzU9cTbHgoPEh4cXX4gc3oai57iKTgtTs7v1mmcbQf7v0UASfBUbUggCefVuswx5w/SmYusx8rnmO6NtEcCpXQx4Jt08pBaY3vUz7nmowoDW/nau16nRqJfypOidGfXPnSUYJiHknDvJlsdBDxwAJ8xi0q9FEDY4dQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPTfDn/B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733760242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcHrZ+agvz4D3sGtHxCE7PE6Arti4HiRiqeu5M1F8EI=;
	b=jPTfDn/BGEJPJyCbwlyKxv9hf3cddC67vd/aYfvYrM31wPHIXuODSPC7k9o2+86OELu6ZL
	+cfiPVRuk8hQVfm9ghvQykDtuBZAEEobcjKh4iVxXFub+VPjssf607FurJLIkI+GIAXy8Z
	g7Rpo8bTwDseHyxeiMlOD5uW1ru5MXw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-eVdzHhjhMAC2XveG54Er6w-1; Mon,
 09 Dec 2024 11:03:58 -0500
X-MC-Unique: eVdzHhjhMAC2XveG54Er6w-1
X-Mimecast-MFC-AGG-ID: eVdzHhjhMAC2XveG54Er6w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 465B919541BC;
	Mon,  9 Dec 2024 16:03:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C8A2300018D;
	Mon,  9 Dec 2024 16:03:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241209141554.638708-1-max.kellermann@ionos.com>
References: <20241209141554.638708-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/cachefiles/daemon: parse the "secctx" immediately
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2133496.1733760235.1@warthog.procyon.org.uk>
Date: Mon, 09 Dec 2024 16:03:55 +0000
Message-ID: <2133497.1733760235@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Max Kellermann <max.kellermann@ionos.com> wrote:

> +#include <linux/security.h> // for security_secctx_to_secid()

You don't need a comment there.

David


