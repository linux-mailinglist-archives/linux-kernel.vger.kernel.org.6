Return-Path: <linux-kernel+bounces-381214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3BE9AFC05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56D31F24553
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92D1D0DDE;
	Fri, 25 Oct 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSo+1HFE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C91CEAD3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843566; cv=none; b=NvkDiKVhFyvoR9tcetk4qAn0cjvu3tGdEwcb/k/Sg+5ykFkfxtE/6jFcPJtnsaeSp6BK/b9lWb2p0wJh4oNdrvcU1f+X08bvzwwPJU9COE47fgCzwmbJXlA90ELzZK732DcWd+Vv0YMXgWpTFo6Ogr8M7L6UW3p2Zb5h1kVphas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843566; c=relaxed/simple;
	bh=ATaXUh+6mRM8+DzD6T9X0xAxW2Dm2ynHKp1/NJ1ZYS4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mBJ8btpjPV2cAWRO2dP0Qjh2ImmvhnR8aBrI15iEAakc4Fk3Pmckh4ey2ahvQGBOuKAJeQi1HgqRlmUDHx1Bnq2DoHpEytt8bjrW9IviO62nVZTTH0lDavZcXf69BKr0iViSDmLc7ExRCqzI0mTYmNStA8VJraV6+25kTP6u6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSo+1HFE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729843561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RJJHsXrgapppl7p0/PyNGlnzqEqHhWtD8NkXnb6nj9g=;
	b=bSo+1HFE4fm6VqZz9kKoZ0XqxujRJn2ej0/c7OwMiX7Mdv+gLS2nGndbRyN768PaxQ7flN
	Tyy8eu0Se7jWK2Ytz90X2KYtnrFXS25g5uwCCNvFaBiFS4jOQ69yL/7dY34PYuisqSU0Oc
	QdSNB8ln9XKllBnXcLBzkiihEvkTsPU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-FPE0XAzzPNeTRp9zwS178w-1; Fri,
 25 Oct 2024 04:05:58 -0400
X-MC-Unique: FPE0XAzzPNeTRp9zwS178w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1383A1955F43;
	Fri, 25 Oct 2024 08:05:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B461C1956056;
	Fri, 25 Oct 2024 08:05:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZxshMEW4U7MTgQYa@gmail.com>
References: <ZxshMEW4U7MTgQYa@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com,
    skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Add a check for NULL folioq in netfs_writeback_unlock_folios
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3951591.1729843553.1@warthog.procyon.org.uk>
Date: Fri, 25 Oct 2024 09:05:53 +0100
Message-ID: <3951592.1729843553@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Chang Yu <marcus.yu.56@gmail.com> wrote:

> syzkaller reported a null-pointer dereference bug
> (https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16) in
> netfs_writeback_unlock_folios caused by passing a NULL folioq to
> folioq_folio. Fix by adding a check before entering the loop.

And, of course, the preceding:

	if (slot >= folioq_nr_slots(folioq)) {

doesn't oops because it doesn't actually dereference folioq.

However... if we get into this function, there absolutely *should* be at least
one folioq in the rolling buffer.  Part of the rolling buffer's method of
operation involves keeping at least one folioq around at all times so that we
don't need to use locks to add/remove from the queue.

Either the rolling buffer wasn't initialised yet (and it should be initialised
for all write requests by netfs_create_write_req()) or it has been destroyed
already.

Either way, your patch is, unfortunately, just covering up the symptoms rather
than fixing the root cause.  I suggest instead that we patch the function to
detect the empty rolling buffer up front, dump some information about the bad
request and return.

David


