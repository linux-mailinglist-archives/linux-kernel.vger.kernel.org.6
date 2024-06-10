Return-Path: <linux-kernel+bounces-208543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 432B6902687
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6281F24E40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2954143746;
	Mon, 10 Jun 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWDVWxGl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5014373F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036397; cv=none; b=hZqhvERKpfC01sEkQnfKpzFWhq3eSxmNuJao2N6YcZZ9/TJNbPMpKGaVQq1nV4vClTHrRnbct9HGZqvo8NZvvH7+fW8dIrFRsuUWmi3Z8aOnCSwMS3NehB68h6oI61BDltju58fbFdp/ODRED7vvoLzxlwh4IblvaxBLOuJSHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036397; c=relaxed/simple;
	bh=UvPKv+li/SINxAK7aM9lX1lje5YFH7WAMPntdkSblq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvz9CtDrwm2vUYBrmdTSltKtacoPp9uXW7D87HTyDXsGRTRxfT0RwQvlJgOHdOCuB9Vy4X4pZdXy0heb/hPQaB2OmIcz1ShrfUk3g1A1RiJJnXlO9oLWpVvPRGihc6OU27+deTZlImADAR7EbGBFqjMWcKdHMcs7OK0fxmFf5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWDVWxGl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718036394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gf4fTgOHmlHgU0q+hImhFWNpPhswAm3czG7DXf3LyZU=;
	b=SWDVWxGlxLTcAYJFkjICJO5abWNh9X3CUKDprOiZCh35P5BdvmKQna56kK8+I/zoC03keR
	hIaw+RccqBGM2n9ZgYBnMatwBFY0K1lqBeP5HFzEIoqqS3Ee8EBWXzQdUBcaxlUDaR2+Ul
	7x1Fz+LX/wajj/4Q4mcvk//0B0/3yBs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-3Luzm_U-PoqUbBNU8riUcg-1; Mon,
 10 Jun 2024 12:19:51 -0400
X-MC-Unique: 3Luzm_U-PoqUbBNU8riUcg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D9B319560AD;
	Mon, 10 Jun 2024 16:19:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 59E5D19560AB;
	Mon, 10 Jun 2024 16:19:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Jun 2024 18:18:20 +0200 (CEST)
Date: Mon, 10 Jun 2024 18:18:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
Message-ID: <20240610161816.GE20640@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610152902.GC20640@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/10, Oleg Nesterov wrote:
>
> > At the moment I am staring at wait_task_zombie and trying to understand
> > how:
> >
> > 	status = (p->signal->flags & SIGNAL_GROUP_EXIT)
> > 		? p->signal->group_exit_code : p->exit_code;
> >
> > works without any locks or barriers.
>
> Agreed, at first glance this looks worrying without siglock... I'll try
> to take a look, perhaps we can simply kill the SIGNAL_GROUP_EXIT check,
> not sure.

Still not sure, will check tomorrow, but probably yes. We can rely on the
the exit_state == EXIT_ZOMBIE check in the caller and tasklist_lock.
OTOH, we should probably take ptrace into account...

In short, I am still not sure ;) but I agree this code needs some changes,
the comments at least.

> But this patch should not make any difference ?

Yes.

Oleg.


