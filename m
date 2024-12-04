Return-Path: <linux-kernel+bounces-432030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A6F9E43FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D5B16441A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045BF1C3BE2;
	Wed,  4 Dec 2024 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeHlR6RG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181624B26
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339012; cv=none; b=QJ6npRfKzTGFN/ZvkyiKU5trmF9KUoSFxv8Pp2qzW7aPGVYgQKYQL5uOX89D2U1GT4UIalBSLycSmIVJCJURzycnU4/sLDG53Ljf8g39lebo9jj1yi73wzTZa69nyao90R1L02GCKSUNYuw3Ph8LravKE7zwpan/vrgZlW9TSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339012; c=relaxed/simple;
	bh=3Z4dOJDsq2U+x9KILDCrBH0XCKmJzb5fADQbCJKued0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=q2dfIuHlWPknvh8ZS1/QTiEpw4t2qvAAjtglXEK2I8uUyIOXeaWx6n5Bm5PX/RV9jfEeDksmA2dcq0s7b0XauwpAMNTvUEf6UgmPjneu51XrncwwQrqV9LvWBfG87KU0Q6MsqoKw8wbQQvEe2DvK1WoTZCZAlwBzGgtBFak3cyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeHlR6RG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733339009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=atHTY7IWU/YS4OJ1wCzFH6IlRbbStHEqvPU49S0UYoA=;
	b=OeHlR6RGkMMrJJz1aO0yYxY4wEh7uMk/KjjTgp5XtxqKZ0M58flFWtZ+exCdi85HXNokNO
	ziqvUMlRRRgHRd/bLFauEbq9aN4XAJq+oLtPolhiLxFkrGA8rxKqh9i375Tyr1QcqecFov
	IUezHBcYUco0+Wn/Fe/jeq0gRWsoFG4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-kNeIQh6zOW2gVTasjQz6QA-1; Wed,
 04 Dec 2024 14:03:26 -0500
X-MC-Unique: kNeIQh6zOW2gVTasjQz6QA-1
X-Mimecast-MFC-AGG-ID: kNeIQh6zOW2gVTasjQz6QA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A96E61954AFF;
	Wed,  4 Dec 2024 19:03:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7A031954200;
	Wed,  4 Dec 2024 19:03:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241204151200.399599-1-colin.i.king@gmail.com>
References: <20241204151200.399599-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, kernel-janitors@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] afs: remove redudant use of variable ret in afs_dir_iterate_contents
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1399908.1733339000.1@warthog.procyon.org.uk>
Date: Wed, 04 Dec 2024 19:03:20 +0000
Message-ID: <1399909.1733339000@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Colin Ian King <colin.i.king@gmail.com> wrote:

> The variable ret is being initialized with 0 and is never re-assigned.
> At the end of the function the check for ret being set to -ESTALE
> is always false, so the check and the call to afs_invalidate_dir is
> redundant. Remove ret and this check and just return 0 at the end
> of the function.

This is the wrong thing to do.  We need to get the error out.  I'm fixing my
patch to do that.

Thanks,
David


