Return-Path: <linux-kernel+bounces-232007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F402691A17A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BC51F24322
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5F27D401;
	Thu, 27 Jun 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jrg3Fazd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB30811E0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477099; cv=none; b=GoSHCIDW/TK3JIJqILf06YtlzAUGrQTrsvbk5Yq/7mW4f5s8BC6CO0bhcD0wcLQWSzX50Y8MDdRNkBHdzmjZfElxEivgDG9+2HzxmB6mfDnu8yH/5Qs6O5sDSh2FEEBMv2GhWFruRAREeEs8uxND7ykOS2wiUKo2Zt9GcUExBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477099; c=relaxed/simple;
	bh=69dNhsMtHWUZwGq4tRdy+zYPCaxQs0hBmwjzWtLSx/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFMfCmbmgeNx/UUTE0P2AVB+Rfr4rZ8zhFYqEfhl7x3cPPNsukyo1EpOtTLjtZ78v6iZ8s/GFwzJ/9zP+tkSCLswZTn2+v6L9lYiEUObi+bcn5MZwhBpVjw2tmLjwEmmfE+ux4ExrIP+mv534OrLBs3PgiS0V02nmEnwCdINFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jrg3Fazd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719477096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H7fg323TlM/G5nlOhZV+l1V8FOvg18d3mVisBJ/KjeM=;
	b=Jrg3FazdGCv8FsRiIX6zn65AC/ee0cL1brftYtKGid8sb6WEUh+Wh+zUdZnSZl92ULHHdS
	OLVA58umawlyJRHit44/odeifHYZ/xkw8DnwS2ZPS8VScl6bJiZI7wVbiTurcRSNrfxsw4
	CvyOZg04dmcxAjpyLb6awwTJCusicn8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-9LDVHzboOWeU0kNEEk7nyQ-1; Thu,
 27 Jun 2024 04:31:24 -0400
X-MC-Unique: 9LDVHzboOWeU0kNEEk7nyQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6163C19560B0;
	Thu, 27 Jun 2024 08:31:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0519A300021A;
	Thu, 27 Jun 2024 08:31:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 27 Jun 2024 10:29:47 +0200 (CEST)
Date: Thu, 27 Jun 2024 10:29:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tycho Andersen <tandersen@netflix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] memcg: mm_update_next_owner: kill the "retry" logic
Message-ID: <20240627082941.GA21813@redhat.com>
References: <20240626152835.GA17910@redhat.com>
 <20240626152924.GA17933@redhat.com>
 <Zn0bPrHrBGwdrGwU@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn0bPrHrBGwdrGwU@tiehlicka>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Michal, thanks for looking at this,

On 06/27, Michal Hocko wrote:
>
> On Wed 26-06-24 17:29:24, Oleg Nesterov wrote:
> > @@ -446,7 +463,6 @@ void mm_update_next_owner(struct mm_struct *mm)
> >  {
> >  	struct task_struct *c, *g, *p = current;
> >
> > -retry:
> >  	/*
> >  	 * If the exiting or execing task is not the owner, it's
> >  	 * someone else's problem.
> > @@ -468,16 +484,16 @@ void mm_update_next_owner(struct mm_struct *mm)
> >  	 * Search in the children
> >  	 */
> >  	list_for_each_entry(c, &p->children, sibling) {
> > -		if (c->mm == mm)
> > -			goto assign_new_owner;
> > +		if (c->mm == mm && try_to_set_owner(c, mm))
> > +			goto ret;
>
> You need to unlock tasklist_lock, right? Same for other goto ret.

No. From the patch

	+/* drops tasklist_lock if succeeds */
	+static bool try_to_set_owner(struct task_struct *tsk, struct mm_struct *mm)
	+{
	+       bool ret = false;
	+
	+       task_lock(tsk);
	+       if (likely(tsk->mm == mm)) {
	+               /* tsk can't pass exit_mm/exec_mmap and exit */
	+               read_unlock(&tasklist_lock);
	                ^^^^^^^^^^^^^^^^^^^^^^^^^^^

try_to_set_owner() drops tasklist right after it verifies that
tsk->mm == mm under task_lock().

> It should still die but it can do so in a better shape.

Agreed!

Oleg.


