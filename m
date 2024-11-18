Return-Path: <linux-kernel+bounces-413153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED70B9D149E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97DDB284CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94A1A9B51;
	Mon, 18 Nov 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7Eosy31"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF51863F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943110; cv=none; b=R+VikRgMltdMHyyE5CqQ4vbjwuSX5++0sWbstqiIeQTyp1lqluLaEQg+/DiBzeWMNthb5uTw+UkfCQ4/knhDfefmwEnOG0FAQoOADeSC6P5tA0q7O/CKnC46QlBRvrAH3PK47edwJDisU5Z7ZMMygZmVzwQCkPJH5x7H0XGg1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943110; c=relaxed/simple;
	bh=hBphlb8sxiGnAngt4/xmrXbCxgW71SdO1EWhEvWkMrk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Dzp8iE81X62xvCMLjLIlBqfu55uIwWk8JAfeAIofuZfBdB8L2miyjnjJkWId5CL7e7hY3KeR9whI5hHvwtNfs4/1iJ6+ZXDAyo+BIUlqlOo7kpwPEw/brSqwEoOZwTdGiKkCbmmzukfJ0Q/FC3KK5CRRAS96kVvuNtSgiGdf/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7Eosy31; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731943107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u37gK7b2dkgA+xW8mJkA1jAuS5QF6WI76HNyDRLrVeU=;
	b=R7Eosy31pG3c9fi0AEOTWyTWYLTmrrdqamElNIDPWxlMvkW4CKBwiIzqS6JIouJtS2qZCf
	bKGIFyc6LMju5JENsbZnbiILEN4Y0coy1fCJjq4d8Q0KZApEfdKHY9H0iuseUvHAY2FVIM
	qSOJK3zQl0wy9++j9R1vsp0Hy4Nk9Ng=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-zN7FcrEaMHKOaKU6vlQbgQ-1; Mon,
 18 Nov 2024 10:18:24 -0500
X-MC-Unique: zN7FcrEaMHKOaKU6vlQbgQ-1
X-Mimecast-MFC-AGG-ID: zN7FcrEaMHKOaKU6vlQbgQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6AA21903456;
	Mon, 18 Nov 2024 15:18:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 508561956086;
	Mon, 18 Nov 2024 15:18:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241116063613.15120-1-advaitdhamorikar@gmail.com>
References: <20241116063613.15120-1-advaitdhamorikar@gmail.com>
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next] afs: Remove logically dead code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <883922.1731943099.1@warthog.procyon.org.uk>
Date: Mon, 18 Nov 2024 15:18:19 +0000
Message-ID: <883923.1731943099@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Advait Dhamorikar <advaitdhamorikar@gmail.com> wrote:

>  	iterate_folioq(&iter, iov_iter_count(&iter), dvnode, ctx,
>  		       afs_dir_iterate_step);
>  
> -	if (ret == -ESTALE)
> -		afs_invalidate_dir(dvnode, afs_dir_invalid_iter_stale);
>  	return ret;

Removing this is the wrong thing to do.  However, you're correct that ret is
never set to -ESTALE.

A better solution, I think, is to check the result of iterate_folioq(),
invalidating the dir and returning -ESTALE if 0 and if the iterator count is
not 0.

David


