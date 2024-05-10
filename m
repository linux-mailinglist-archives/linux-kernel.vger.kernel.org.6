Return-Path: <linux-kernel+bounces-175687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8CB8C23A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12E31C23BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6F16EC06;
	Fri, 10 May 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCfZpGBY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDA165FDB
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340804; cv=none; b=L6yp75YBRIdO4UcmIHN9P5qY3CMvZQI5S17P4dK592MHmPoAg/UUSVjn6fnJ+PzIkbi5c+jjSMtNJvphDjupzZ7Nu2Q5xhZtu51s7u+qYnR4Na1goT60LYED9au4EuML04kU9PHsTk7NSZbj2Yhdpiqkg5RSTATPdGlr6S1+KzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340804; c=relaxed/simple;
	bh=HrkrZp+/n0k/6V53rE3JbD0UBV428A770HYxzG7Hupk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTDCM/cOI/5nCHhluBXzMkoW8j7bLtt4V8aNjs79ps7zGqGvnR0OgmVg3MmxotOsVC8pgnPvy/XDriBKschF0aqvCaiWIBdscgg6cFehxSgkenFYYedBXHkKlMWMsMEQboMC4Y4fgLVblQ7UsbVbWyS5qGBZbD2TBe9vfhzPaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCfZpGBY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715340802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g2/qqYRhFWlKB3W1SwI+1uiNp1F5LJ9jGM/cRZ481m0=;
	b=HCfZpGBY3Zl+E87BDf3w4poc/0ngKc8pp7esvTQa1LSnOqN95OIThkgoQX7vEOtJZDTS1z
	HePsi3/Nni+J2ui6K/A4lRJ1RYzI1Fk48UoGsxnIllKgeg1rCvZRf4+bYpIVjPgrS8VNzw
	b3BrVTwj1OsYb/FZHiSIcBfJbpMVvo4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-CpMeO0AuNmSaiywsnJtJ6A-1; Fri, 10 May 2024 07:33:18 -0400
X-MC-Unique: CpMeO0AuNmSaiywsnJtJ6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ADBD81227E;
	Fri, 10 May 2024 11:33:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.196])
	by smtp.corp.redhat.com (Postfix) with SMTP id 509ED44E3AF9;
	Fri, 10 May 2024 11:33:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 May 2024 13:31:52 +0200 (CEST)
Date: Fri, 10 May 2024 13:31:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <20240510113149.GA24764@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240509151312.GA22612@redhat.com>
 <f0a02cfe-7fc2-494c-8734-e5583f42a8f7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a02cfe-7fc2-494c-8734-e5583f42a8f7@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 05/09, Paul E. McKenney wrote:
>
> On Thu, May 09, 2024 at 05:13:12PM +0200, Oleg Nesterov wrote:
> >
> > We can move these WARN_ON()'s into the ->rss_lock protected section.
> >
> > Or perhaps we can use data_race(rsp->gp_count) ? To be honest I thought
> > that READ_ONCE() should be enough...
> >
> > Or we can simply kill these WARN_ON_ONCE()'s.
>
> Or we could move those WARN_ON_ONCE() under the lock.

Sure, see above.

But could you help me to understand this magic? I naively thought
that READ_ONCE() is always "safe"...

So, unless I am totally confused it turns out that, say,

	CPU 0			CPU 1
	-----			-----

	spin_lock(LOCK);
	++X;			READ_ONCE(X); // data race
	spin_unlock(LOCK);

is data-racy accoring to KCSAN, while

	CPU 0			CPU 1
	-----			-----

	spin_lock(LOCK);
	WRITE_ONCE(X, X+1);	READ_ONCE(X); // no data race
	spin_unlock(LOCK);

is not.

Why is that?

Trying to read Documentation/dev-tools/kcsan.rst... it says

	KCSAN is aware of *marked atomic operations* (``READ_ONCE``, WRITE_ONCE``,

	...

	if all accesses to a variable that is accessed concurrently are properly
	marked, KCSAN will never trigger a watchpoint

but how can KCSAN detect that all accesses to X are properly marked? I see nothing
KCSAN-related in the definition of WRITE_ONCE() or READ_ONCE().

And what does the "all accesses" above actually mean? The 2nd version does

	WRITE_ONCE(X, X+1);

but "X + 1" is the plain/unmarked access?

Thanks,

Oleg.


