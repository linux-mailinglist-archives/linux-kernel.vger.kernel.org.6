Return-Path: <linux-kernel+bounces-192189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C042F8D19C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1B428A921
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3316C858;
	Tue, 28 May 2024 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzHHvYxp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525A16C854
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896280; cv=none; b=pdacealmDCfsHI/xqCJFdDxcRVxFYdjsbq3cBVokf3ljhzMQLuN2DPIG13PaxNfeP9faRfsW+uv7iMR8KltLWYWnL6vZe1F+D7JiNM1zfslXB/ZoUB94TI/JKEbZpdNpVPJ7sak9wJ9gsgUffCzxO7yiuEb9L0eg4VvQ8Y5TQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896280; c=relaxed/simple;
	bh=qsUEMsJeSS+IBw2BPZZTlJN3EV1oMrAZQyqKVRUbvtE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bzU11THBcs7lKoxdA+N6FOBWCwCtkJ4N8hRwHriqQst84TBzrbibvjgwVx+MnY3p3Lv4FDaleprzfvdmz4Q1sH3kSYt3SSWblnvlRbwSwtneaxvZWjjzP2XAlenm3WJkdCzAtujroGru4ugcdFarwhqvP6GLjsLjlOdRBL7j3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzHHvYxp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716896278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cR2bt1k7HyvsTYH0cB1zhL4rvahDLosFkY2Z9XJBKj4=;
	b=hzHHvYxpq+FsTLqXvk3EO71TXhDzb/11TYP/7H1pbeIf1JguOJj3t2OWxrjQOSW8AFMyZm
	spfYLgnOoN1/U+03z99VxT0EaXKu16Xn82NN8q5zi6ZJ/8jXnRTZG8vow+b/Fg0CJnr6fh
	ufaUx7n9EFhEHvIiqq6XF0aw4f0CEsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-t2Ce_dVVNM-Zrr8EG9E22Q-1; Tue, 28 May 2024 07:37:54 -0400
X-MC-Unique: t2Ce_dVVNM-Zrr8EG9E22Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B007881227E;
	Tue, 28 May 2024 11:37:53 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E44710004FF;
	Tue, 28 May 2024 11:37:53 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 872D230C1C33; Tue, 28 May 2024 11:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 8623A43520;
	Tue, 28 May 2024 13:37:53 +0200 (CEST)
Date: Tue, 28 May 2024 13:37:53 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
cc: Benjamin Marzinski <bmarzins@redhat.com>, Yang Yang <yang.yang@vivo.com>, 
    Alasdair Kergon <agk@redhat.com>, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dm: optimize flushes
In-Reply-To: <Zk-EtZE4C7bndEYn@kernel.org>
Message-ID: <96148bb3-42e3-a5e2-63fb-ad7f67ba4fea@redhat.com>
References: <20240514090445.2847-1-yang.yang@vivo.com> <20240514090445.2847-4-yang.yang@vivo.com> <ZkTXzG1yrPmW64Z6@redhat.com> <60bd4b9-8edd-7e22-ce8b-e5d0e43da195@redhat.com> <90f4beb-2e15-3f9-4bc2-0d13872e8ea@redhat.com> <Zk4Y6DMgK71UuoKd@kernel.org>
 <44afd6c8-d36a-4b9d-e77f-fca269a9897b@redhat.com> <Zk-EtZE4C7bndEYn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3



On Thu, 23 May 2024, Mike Snitzer wrote:

> On Thu, May 23, 2024 at 07:46:25PM +0200, Mikulas Patocka wrote:
> > Hi
> > 
> > Here I'm resending the patch, with more comments and explanations added.
> > 
> > Mikulas
> > 
> > 
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > Device mapper sends flush bios to all the targets and the targets send it
> > to the underlying device. That may be inefficient, for example if a table
> > contains 10 linear targets pointing to the same physical device, then
> > device mapper would send 10 flush bios to that device - despite the fact
> > that only one bio would be sufficient.
> > 
> > This commit optimizes the flush behavior. It introduces a per-target
> > variable flush_bypasses_map - it is set when the target supports flush
> > optimization - currently, the dm-linear and dm-stripe targets support it.
> > When all the targets in a table have flush_bypasses_map,
> > flush_bypasses_map on the table is set. __send_empty_flush tests if the
> > table has flush_bypasses_map - and if it has, no flush bios are sent to
> > the targets via the "map" method and the list dm_table->devices is
> > iterated and the flush bios are sent to each member of the list.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Suggested-by: Yang Yang <yang.yang@vivo.com>
> 
> Nicely done, please feel free to stage for 6.11 (create a new
> 'dm-6.11' branch starting from 'dm-6.10' -- we'll need to rebase
> dm-6.11 to 6.10-rc2 or so but at least we'll get this commit in the
> pipeline, push to 'for-next').
> 
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>

OK, done.

Mikulas


