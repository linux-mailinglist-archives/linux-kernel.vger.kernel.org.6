Return-Path: <linux-kernel+bounces-511037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4053A324EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534B43A4004
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B820ADF0;
	Wed, 12 Feb 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IN+fPS0/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A520ADE6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359703; cv=none; b=AkEVK4BeaS+qWBSeiNQckW472YKU3ksv4wR74/qB+/JNTjT4qF0rxRGBHhnhnfTPH+aUkKgn9Jwc+4F7Owse5kMYa5/5qSRbtDVVuaNSZLiWaME5njSwGebAnZ2GYtHEPh4mDTIRtCFWvpfr1EQmCscf3XreR6LmwBuQPUwsUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359703; c=relaxed/simple;
	bh=crBH/z2IHA/+ZXt/+MdRv6oNnh+5SECu9UFZCDeV2sQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=pLVIGuXvn+W9rmnmf0ShbKG7raVM3LOk7R3c/a/sEz/TSmTc98IDYqGMu+4IhzD0e2zqcHNXtFp7iqu6x2J6C4IxtDNaqpdnKJQh+PvbLFETomqwPJ6OrqZhOiEtIug7diUSUPuc97CWJK8lNuInzfo2yAHWXOWGtHss59UYWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IN+fPS0/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739359700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+53ctVXxszASoqutnviIyhNloVmP44++pToMJO4ztk=;
	b=IN+fPS0/Dn2gBKTImSzrAqmjDu6DwjAzqXx/M1xHCWj2cfJFRj9vujmHNOFCXROrsAavIC
	M/9MOn1V4F59uk1fXVh8L4Bp7zwdoUEzzsZePe0/quvuOzLGLIhAFn59FEdmwm6WLZYUkF
	wIT69OHzXXU3RjxRWsgP5mcDaxi5oP4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-TNiaGmmYMzi9fHfL-vUmZg-1; Wed,
 12 Feb 2025 06:28:19 -0500
X-MC-Unique: TNiaGmmYMzi9fHfL-vUmZg-1
X-Mimecast-MFC-AGG-ID: TNiaGmmYMzi9fHfL-vUmZg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFA4419560AF;
	Wed, 12 Feb 2025 11:28:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B59CF19560A3;
	Wed, 12 Feb 2025 11:28:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250212025843.80283-2-liuye@kylinos.cn>
References: <20250212025843.80283-2-liuye@kylinos.cn> <20250212025843.80283-1-liuye@kylinos.cn>
To: Liu Ye <liuye@kylinos.cn>
Cc: dhowells@redhat.com, brauner@kernel.org, akpm@linux-foundation.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/folio_queue: Delete __folio_order and use folio_order directly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3517720.1739359694.1@warthog.procyon.org.uk>
Date: Wed, 12 Feb 2025 11:28:14 +0000
Message-ID: <3517721.1739359694@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Liu Ye <liuye@kylinos.cn> wrote:

> __folio_order is the same as folio_order, remove __folio_order and then
> just include mm.h and use folio_order directly.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>

Acked-by: David Howells <dhowells@redhat.com>


