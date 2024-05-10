Return-Path: <linux-kernel+bounces-175698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CCC8C23CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428511F258C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B175116D9A1;
	Fri, 10 May 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnPJbqan"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD116F296
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341582; cv=none; b=YfrgMr5IQhQ8cqGsJ+Pf/NMy01Kk1NcmEtEC+qaadOnXxF5pFbkXFDk9GE29CPxadVhszLaGTO95BeMGCcGSZVG8jEHAJXeiMDM+bDguUmYCHJX8wbmsOgTvx90+0z3xv8RkuAvD5EIpgKvatC2XJZgHXkDu8t4KFjx/PK5OZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341582; c=relaxed/simple;
	bh=8fZVZZLwrYj7eBOG3h8Y9eFzWHWyYMn9hTu3xemaVHQ=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=LBZQNzD5rxJzURxV3QdJeXVdA56KXhwJaTmFxcb7MSd3RtdFxER1xk19FuAQIB/sPEo+hL2KxB6KjRkFQI+s+D6D7T+7kYhvgYhLxvS1UjjhVlUiDtFCJhPpzzJJYD7qHkFgqfnCUXcagqZAu7X6iZSWb2E7vYwLsCOtwc/VgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnPJbqan; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715341579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwU5Oore3SuCw8wZi4A6hCUo7BctEtdssnTwHpRObJs=;
	b=SnPJbqan4n2fqG6bhOv38VAYe3sK72muMOA5Cn7CVB6iRopF8pe5CtPbIBzraSFbrUxiPr
	IT9lJJDhybQZkoIu0v2SrHWMb/lgXdSElw3xYcDQvZ5GTtxNIF/NFir8lhj5C40t2gJ2dX
	SVpAUFjpzLZDK7BkcxVzVTtom2N5XOE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-wA18SPOdMBeTCD36AVxuKw-1; Fri, 10 May 2024 07:46:14 -0400
X-MC-Unique: wA18SPOdMBeTCD36AVxuKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FABB8030A6;
	Fri, 10 May 2024 11:46:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC7F2055894;
	Fri, 10 May 2024 11:46:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1586576.1715341405@warthog.procyon.org.uk>
References: <1586576.1715341405@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Jan Kara <jack@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
    Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: Don't reduce symlink i_mode by umask if no ACL support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1586840.1715341572.1@warthog.procyon.org.uk>
Date: Fri, 10 May 2024 12:46:12 +0100
Message-ID: <1586841.1715341572@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

David Howells <dhowells@redhat.com> wrote:

> -	inode->i_mode &= ~current_umask();
> +	if (!S_ISLNK(inode->i_mode))
> +		inode->i_mode &= ~current_umask();

Meh.  I forgot to commit the change.  Will resend.

David


