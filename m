Return-Path: <linux-kernel+bounces-325568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E29975B80
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812581C20D22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83CF1BB68C;
	Wed, 11 Sep 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmZaH6Ep"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B37E583
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085669; cv=none; b=Ksda0EGRCsAKc9uv4JTrwJApa/QJXkUMKpfdthBabGu7GEvF1hleFk3Vjh1WHCYshpDAsLbvj4DD6HoTdjue1A/t9u/k3wQusTCOz85Y5GdQCKq8i6E5DaMs7+I5vPkjYSkQM+hFPT7/fZ/gJgjB3oMeH+GjoqrGmmwhjTJ0Xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085669; c=relaxed/simple;
	bh=h2kKG31g+Hmx6tmmvHaeqz9ofEgVn9kMKUL7/hoWBa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAEZANj5vyGUiiur7+H/hsnHeMgYQv4GYjUUQtg85x1Wrnc80Oas5md4Iox8TxdxlWiPHeuA5OtXIYtfOmIUb23w+sGM2Z4JXUhxreiACHJKmqmVuu1Br6tzczik31xWXVkXzbXf83fw6b73Izo/N+6X8fn/GcGNp/Dd76k3ItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmZaH6Ep; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726085665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KXXJVpHBqZ8jkbmiTKtUQVPTfqELx0UeolsgQNEGcI=;
	b=EmZaH6EpJLlM0M5vFiQlHFDr/pIfevrADJxNaXyZUtlh3QQmBGnjDirEpPkJveMLxFvcsB
	/cQuLOFwAlpqd5r6xOVYakwvmhokZRnHBZNR41z/nVWxba3iVvIeYbi1kiqmik+kE/+whq
	5zhk2Qj+nC+B5AvDICpVGHNptbT+gHw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-X6QncCq1PHOuVSxOccM3SA-1; Wed,
 11 Sep 2024 16:14:22 -0400
X-MC-Unique: X6QncCq1PHOuVSxOccM3SA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 532F21945109;
	Wed, 11 Sep 2024 20:14:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.43])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E5A5D1956086;
	Wed, 11 Sep 2024 20:14:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 11 Sep 2024 22:14:08 +0200 (CEST)
Date: Wed, 11 Sep 2024 22:14:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Kisel <romank@linux.microsoft.com>, akpm@linux-foundation.org,
	apais@microsoft.com, benhill@microsoft.com, ebiederm@xmission.com,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev, workingjubilee@gmail.com
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <20240911201402.GB16757@redhat.com>
References: <20240911144412.GA16954@redhat.com>
 <20240911174107.1217693-1-romank@linux.microsoft.com>
 <20240911195311.GA16757@redhat.com>
 <CAHk-=wjhqn+B85OA8pfLhckUXSwLtJzFq5JPO2cNNzhPN__HJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhqn+B85OA8pfLhckUXSwLtJzFq5JPO2cNNzhPN__HJQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/11, Linus Torvalds wrote:
>
> On Wed, 11 Sept 2024 at 12:54, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> >         - please try to make your changelog more convincing. And in particular,
> >           please explain why !!current->ptrace is not enough and this feature
> >           needs the tracer's pid.
>
> Oleg, I realize you like the simpler patch that only has that
                  ^^^^^^^^
No, no, I don't!!! ;)

> "!!current->ptrace", but my point is that even that simpler patch is
> simply WRONG, WRONG, WRONG.

and I agree, agree, agree.

> There is simply no valid situation where a "I have a tracer" is a good
> thing to test for.

Yes, yes, and that is why I added you/Eric to this discussion.

I just tried to play fair. I just thought that I can't simply "nack" this
change, because I can't explain why I didn't like the whole idea.

Oleg.


