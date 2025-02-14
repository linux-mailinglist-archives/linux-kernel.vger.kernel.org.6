Return-Path: <linux-kernel+bounces-514995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03A4A35E57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CBB3B2710
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC95264A63;
	Fri, 14 Feb 2025 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1lU0N0K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0B1EB5B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538239; cv=none; b=jzTmbFwU0Mng+j52vUQCUYOeWdQuvvMmp0U4ZIoWLoKjZDTYnIklmaKaOc7L3CM5N0hjbeAwOtj0399yjBO2xgn7Gg7vtuAedZC5kVeFbjjvX1y8sOiJ2zHX5lPY+i/ubbcrAuZeQkAAk1E/SOF5TI7SOhm7SR4AV4I8HrirmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538239; c=relaxed/simple;
	bh=+dRvZAEpzggpCGdlVHWJjVQQHmFiEjX9LCOV2fbhmjE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=IT5RW+QqyM423g4sWN1RdMK21amN+rkDpdZxG6Tb1xI/11IPy6TCZ8tVYogeAe7ClkMl3S9BmZy9S81Jwlxlh/hVNlew3UeAVAGF6tC8w0CMwx/E7n6KYFe/DvGQeX+Id/N715ZxVchzXnRMEg3SEEDjwnWQCfLZxca1gBskxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1lU0N0K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739538236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkmQoBgY6ibrO0SJlNLLatAXD9nZtLfLlyNK+9OBhaI=;
	b=i1lU0N0KwaSnRB7O6G5NmzZEgUcDUETr7P5lQtp84NBTO9YeeQgCSs4SN/qvonQosKH03z
	OTNQ/5mAgB9Nypu6bEtR9vIkJsyq8CUb+iawB3a00corbIfJnFehLbKNgBx49S5QI3Jp49
	X2+OTwfpw+N6kF3nFSUds/sQaAAIp3E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-Nol8qBg2MiuZsh45u0WI8Q-1; Fri,
 14 Feb 2025 08:03:52 -0500
X-MC-Unique: Nol8qBg2MiuZsh45u0WI8Q-1
X-Mimecast-MFC-AGG-ID: Nol8qBg2MiuZsh45u0WI8Q_1739538231
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FD5C18D95DE;
	Fri, 14 Feb 2025 13:03:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 847C51800352;
	Fri, 14 Feb 2025 13:03:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250211093432.3524035-1-max.kellermann@ionos.com>
References: <20250211093432.3524035-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Johannes Berg <johannes@sipsolutions.net>,
    netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH v6.13] fs/netfs/read_collect: fix crash due to uninitialized `prev` variable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3978534.1739538228.1@warthog.procyon.org.uk>
Date: Fri, 14 Feb 2025 13:03:48 +0000
Message-ID: <3978535.1739538228@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Max Kellermann <max.kellermann@ionos.com> wrote:

>  		prev = list_prev_entry(subreq, rreq_link);
> ...
> +		if (subreq->start == prev->start + prev->len) {
> +			prev = list_prev_entry(subreq, rreq_link);

Actually, that doubles the setting of prev redundantly.  It shouldn't hurt,
but we might want to remove the inner one.

David


