Return-Path: <linux-kernel+bounces-175817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2BF8C2592
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF3C1C2197E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002612C465;
	Fri, 10 May 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHC9ZEbP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63043F8D1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347232; cv=none; b=GgK0r6Tnbaq47WyH1z8LTC37sEZak/lwZC5XwF/+5vHwiX4qA9BePKkvMN+prYdxjOPTm1pfgYqvpEWMbC+McTpC4mM+3wUBY3zceM7XwSQmXwJq0vMWkZ7jVzw+0FHRE6eJRvja22ldVrODFv3bh3aOGZS8kt+iXvkU7km3hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347232; c=relaxed/simple;
	bh=3Tl2B5EkwGEZNx5cMVsNSYK6mjudFoYF8s7Ug0qESew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJhO7G9yiOzH4eYxtS3JrO6Tg4IQRQM++QzeMfAh+6f1YSSuBRhRDR0vMjqm0o1oIf/Imxp+BttC3j96bnj6mh1jkMU1oYggx4cnCL4JtF1DPh/Zg7xUnumCGUzq8BiTvYeYgEtYqeOop825B2lINhDhhRKYMXpIAGr5RGNfK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHC9ZEbP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715347229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Tl2B5EkwGEZNx5cMVsNSYK6mjudFoYF8s7Ug0qESew=;
	b=EHC9ZEbPmV0HU6F81vXBB1TdL7PIjM9qhmSD+acW00+ykCirToNOujKr3EE9lmgoOycaIL
	436qHwsOUFBpj927F2626tP6jl8R1eZbRj8frqf+2c4LgZeGqLLcmoaBIALpFCTe5cEbrs
	YdkgHZrsDymERWEZmVaadSTvIgChvCA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-1IN8NqBBOEqJ0JjcE-RsZg-1; Fri,
 10 May 2024 09:20:19 -0400
X-MC-Unique: 1IN8NqBBOEqJ0JjcE-RsZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C795929AC039;
	Fri, 10 May 2024 13:20:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.196])
	by smtp.corp.redhat.com (Postfix) with SMTP id E61E6DDC97A;
	Fri, 10 May 2024 13:20:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 May 2024 15:18:53 +0200 (CEST)
Date: Fri, 10 May 2024 15:18:50 +0200
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
Message-ID: <20240510131849.GB24764@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 05/07, Paul E. McKenney wrote:
>
> By the stricter data-race rules used in RCU code [1],
..
> [1] https://docs.google.com/document/d/1FwZaXSg3A55ivVoWffA9iMuhJ3_Gmj_E494dLYjjyLQ/edit?usp=sharing

I am getting more and more confused...

Does this mean that KCSAN/etc treats the files in kernel/rcu/
differently than the "Rest of Kernel"? Or what?

And how is it enforced?

Oleg.


