Return-Path: <linux-kernel+bounces-171630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB158BE6A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AFE1F21B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEF516079C;
	Tue,  7 May 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E11HEBKP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7253615FCFC
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093690; cv=none; b=t7yiZV3YoB9mGs+uQINMl/98kuOBafrEehsihyVravej4PoPnCgQ7L4okK5qTq0aDtorB39jdBxfC1NwP82MOd/1swxf8LPjP0TIM8Qj/G9zWeECaKxKBs50ogQBEYkCpsFOAXq3MjZE32LhtJpM9JWtRa8wu3OCtnwPaqzMaxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093690; c=relaxed/simple;
	bh=x1ynqQFHOK413TFZ0OfYJH7ssjMEsPRE5/yFxBbEta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqpPw5Ay1nxgYfhNU5v/2qj0KBCZH+mWftBAMOu6eoce9KfF3cem9cK+hSAqaEvrPPezXeW0FClYAMCJaDx1KdSg0WUNZrrgrh4kdxBk0H3As5jsLKCbaHeFHXCUdyIo3yZ+ky961TezasDlP4pJGTMpHXlQqN1WRN07Na/44ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E11HEBKP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715093688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L5Q00hDqz0kX8rmCO430SmGXckCysDjESYgq4a/xGRA=;
	b=E11HEBKPQUbfHt5UTDBPMzW8CrOsCCRTABigKPfPxPY9ofhPWmcjfVPZiYa50IKSllkArA
	j11BnybtRlPC1DtqxN83U7QiswnY96HYmOKPlwuwyG0XisX9337YYyiFPO4MF/Fr7el8jl
	O7tLWSEAUKE1LM+IImBvEfzaL4Lm1vo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-vZjh9jiYNri97qvEKcuSaQ-1; Tue, 07 May 2024 10:54:45 -0400
X-MC-Unique: vZjh9jiYNri97qvEKcuSaQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B821185A783;
	Tue,  7 May 2024 14:54:44 +0000 (UTC)
Received: from fedora (unknown [10.39.192.225])
	by smtp.corp.redhat.com (Postfix) with SMTP id 1CA37492CAA;
	Tue,  7 May 2024 14:54:41 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 May 2024 10:54:44 -0400 (EDT)
Date: Tue, 7 May 2024 10:54:41 -0400
From: Oleg Nesterov <oleg@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <ZjpAsYJIfzYSKgdA@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507093530.3043-26-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hello,

I feel I don't really like this patch but I am travelling without my working
laptop, can't read the source code ;) Quite possibly I am wrong, I'll return
to this when I get back on May 10.

Oleg.

On 05/07, Uladzislau Rezki (Sony) wrote:
>
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> The rcu_sync structure's ->gp_count field is updated under the protection
> of ->rss_lock, but read locklessly, and KCSAN noted the data race.
> This commit therefore uses WRITE_ONCE() to do this update to clearly
> document its racy nature.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/sync.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> index 86df878a2fee..6c2bd9001adc 100644
> --- a/kernel/rcu/sync.c
> +++ b/kernel/rcu/sync.c
> @@ -122,7 +122,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
>  		 * we are called at early boot time but this shouldn't happen.
>  		 */
>  	}
> -	rsp->gp_count++;
> +	WRITE_ONCE(rsp->gp_count, rsp->gp_count + 1);
>  	spin_unlock_irq(&rsp->rss_lock);
>
>  	if (gp_state == GP_IDLE) {
> @@ -151,11 +151,15 @@ void rcu_sync_enter(struct rcu_sync *rsp)
>   */
>  void rcu_sync_exit(struct rcu_sync *rsp)
>  {
> +	int gpc;
> +
>  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
>  	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
>
>  	spin_lock_irq(&rsp->rss_lock);
> -	if (!--rsp->gp_count) {
> +	gpc = rsp->gp_count - 1;
> +	WRITE_ONCE(rsp->gp_count, gpc);
> +	if (!gpc) {
>  		if (rsp->gp_state == GP_PASSED) {
>  			WRITE_ONCE(rsp->gp_state, GP_EXIT);
>  			rcu_sync_call(rsp);
> --
> 2.39.2
>


