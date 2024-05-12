Return-Path: <linux-kernel+bounces-176853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4251E8C35FF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 12:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C484C1F212B2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F391CD24;
	Sun, 12 May 2024 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTmTlvW2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A721CAAF
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715510608; cv=none; b=hL10Bk8A5WXsTAhWoEnr5XYqjvFZdbqnU2xAXONtJQe8KmgYqM4emh/bcuGsVGqeBzFT+Tgo8y2apmtdM4zzPv9U6hklvfnQAJwr9Q3gpuFH8oehrqf5P4uo/9k7qqhiHuurpfeEUkDnirDObPr2TiEBBXcBrcyOmaUzI6uUkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715510608; c=relaxed/simple;
	bh=0rdr5+9oRPkVDvU6kbrzwQtN/Z+LPqctRKzqAJ8FT6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khBrVenHodJnlEI1R9/ICKCteQR66KldH54yF1Y5tcpWkDv3NXtdANnmG9NZ2uwFcfiGZ9N+TDQ95JuQPWGQj5MQ/QpL/t86Al+ZzkFbc8iqZzn4QE1+zh56hFMHyh5ztWVdPOwCbybiefTcsaSOpMSjs+5T8OPrb4SzKTIa/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTmTlvW2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715510606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oxrgodSSTuZswJnNY6k+AyI3wOxNGvPqyHgv829oWBs=;
	b=MTmTlvW2txlpc8nQCGdMXtpYUsEiRTbAXx3m1ZLDX+Nbowdjd6+JhsmMLvzgFRiJ3Wl48u
	MwGehcJ6CZzs0p77p1OtIZQUoCjdeS64/WKhS9Tf5mBn+ZMSKyLaXCulNMTxmqk0vswsZC
	+gFgQV5WjWy4ygIZpMJc2+WHOVC3b4M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-ckBUExiOMliF3DcwR5UIXw-1; Sun, 12 May 2024 06:43:22 -0400
X-MC-Unique: ckBUExiOMliF3DcwR5UIXw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE33F8030A4;
	Sun, 12 May 2024 10:43:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0DEA7492BC6;
	Sun, 12 May 2024 10:43:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 12 May 2024 12:41:55 +0200 (CEST)
Date: Sun, 12 May 2024 12:41:52 +0200
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
Message-ID: <20240512104151.GA7541@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240510131849.GB24764@redhat.com>
 <20240510135057.GC24764@redhat.com>
 <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Sorry for another delay...

On 05/10, Paul E. McKenney wrote:
>
> On Fri, May 10, 2024 at 03:50:57PM +0200, Oleg Nesterov wrote:
> >
> > I can only find the strnstr(buf, "rcu") checks in skip_report(),
> > but they only cover the KCSAN_REPORT_VALUE_CHANGE_ONLY case...
>
> Huh, new one on me!  When I run KCSAN, I set CONFIG_KCSAN_STRICT=y,
> which implies CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n, which should
> prevent skip_report() from even being invoked.
>
> Which suggests that in the rest of the kernel, including "rcu_"
> in your function name gets you stricter KCSAN checking.  ;-)

Yes.

And that is why I was very confused. I misinterpreted the "stricter
data-race rules used in RCU code" as if there must be more "rcu-only"
hacks in the kernel/kcsan/ code which I can't find ;)

Oleg.


