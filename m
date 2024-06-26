Return-Path: <linux-kernel+bounces-231061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A41249185AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595241F27076
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B218C338;
	Wed, 26 Jun 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpUITXxU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD8177998
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415532; cv=none; b=VQetg9FL7Jtk2VawmAW4A5ancURCSS2Ovk+Tgl9r955xdBeJfwEY5dsDgy1wY5J5Zq9gomNXThzo+Szm6UFYMQIW8/JqYMiKu8/2iwHT9KtO4oAYak5hWiVvgZ17tG4LuPd3l6nRBqiKAnjDJWrFp4p+OZfM/atlVz2jm/E1afk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415532; c=relaxed/simple;
	bh=n2eyTmEVbUI0DY39yr7MWMW2MvOH5CtjCxH/a90cE6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0jR01uDCzhduPXKU+mJZOezl2Z+QTpPaPsV/uQ7kID/Br3rCkAISnPSbbVvE1/KNBxqx81JTOZEP2yZQ/Q+FxI4NpRNja8JJZS/lzz3ZUb7gGOeoiwErxjeLH98A6bsXFaMpA0jLBUbNYf0Kc3xOEcj4vSqJr+VEKN9CtcNDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpUITXxU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719415529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2eyTmEVbUI0DY39yr7MWMW2MvOH5CtjCxH/a90cE6k=;
	b=hpUITXxUbnxDfa9Wc1pX+vthZ4d6EqOlUSVC1YPNPGE4ou1Fmr0htQNC+dG0FOBh+KQY94
	sPFH85xl31C5c8+Fnr2FT7TpoKRyZIssorK/BObIlb1mKFcqdbsJRa6oGmosn0FT1+Palx
	czH1+TUC5/zHO7fk28AzloRoNa2yTDY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-mCYyMfNuNlmYKRw9ZOZTDQ-1; Wed,
 26 Jun 2024 11:25:21 -0400
X-MC-Unique: mCYyMfNuNlmYKRw9ZOZTDQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 996BE1955F54;
	Wed, 26 Jun 2024 15:25:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 98B121956057;
	Wed, 26 Jun 2024 15:25:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Jun 2024 17:23:46 +0200 (CEST)
Date: Wed, 26 Jun 2024 17:23:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: alexjlzheng@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
	akpm@linux-foundation.org, brauner@kernel.org, axboe@kernel.dk,
	tandersen@netflix.com, willy@infradead.org, mjguzik@gmail.com,
	alexjlzheng@tencent.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: optimize the redundant loop of
 mm_update_next_owner()
Message-ID: <20240626152340.GA17644@redhat.com>
References: <20240620152744.4038983-1-alexjlzheng@tencent.com>
 <20240620172958.GA2058@redhat.com>
 <ZnU-wlFE5usvo9ah@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnU-wlFE5usvo9ah@tiehlicka>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 06/21, Michal Hocko wrote:
>
> On Thu 20-06-24 19:30:19, Oleg Nesterov wrote:
> >
> > Or even better. Can't we finally kill mm_update_next_owner() and turn the
> > ugly mm->owner into mm->mem_cgroup ?
>
> Yes, dropping the mm->owner should be a way to go. Replacing that by
> mem_cgroup sounds like an improvemnt. I have a vague recollection that
> this has some traps on the way. E.g. tasks sharing the mm but living in
> different cgroups. Things have changes since the last time I've checked
> and for example memcg charge migration on task move will be deprecated
> soon so chances are that there are less roadblocks on the way.

OK, thanks...

So if we can't do this right now, can we at least cleanup it? To me it looks
just ugly.

We don't need get/put_task_struct. The "retry" logic is obviously suboptimal.
The search in the children/siblings doesn't handle zombie leaders.

I'll send 2 (hopefully simple) patches in a minute, could you review? I have
no idea how to test them...

Oleg.


