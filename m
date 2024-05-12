Return-Path: <linux-kernel+bounces-176942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CC8C37A8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2131B1F21162
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917FA4CDE0;
	Sun, 12 May 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJkNXZOe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A404B5A6
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715533025; cv=none; b=kONetc6H5qkqaANw7hDRMvikoyPcnoUggPHQCF0zgqHJP8f5mvpVG2AYkza4QlliCjW0PRNerhwDCpzx5MvXKfi1ZQ7G4vyPtgm22bKmy8WfXtC0jxittbbMJytaUzKcu5Q8oCvtSmRnXnyiwxm5cBW7M660GEiZKgM+wLMgd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715533025; c=relaxed/simple;
	bh=kdXFdul21W1vhNDP10fjF3wHDYrB+OIdo2J4mUdXdPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz+D51TvzmMsU63HDAZagAEsR+7iYjoKkgKE67Ubo0vWyE9HaUJHBvcHvRQPIvAOTUrZq7THYI/1ChzjTh5IAPa/1EPQYVI2fGdDkMylRCud9lLTy5grk5ZeJN2ryx2mQQFOZXKLyosJ5O4AGKTUkW4IptyyqvQ1K4Y5l5n/dfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJkNXZOe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715533023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zkQu673XHiZsZ2LC3p7p7WgDWXyU8Quk0ZhICioaz88=;
	b=QJkNXZOeecHHwMNfvsyc2iFxfCISFj3kmtydKm4rBRQhzqHJtEqp8f+Bwxr24POwAuv1d8
	l69VMO65h4tBddcuiME2AZMosDfcSD7aKaJOEHaulbbzqxYHdpzr2RepRILKjjE8ELGy6H
	BX8Xtp3vs0ThC2y6HSIQSfwjfvWLSWw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-OwKcqLnDNBCkBGKdABtTZg-1; Sun, 12 May 2024 12:56:59 -0400
X-MC-Unique: OwKcqLnDNBCkBGKdABtTZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B324185A780;
	Sun, 12 May 2024 16:56:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by smtp.corp.redhat.com (Postfix) with SMTP id 766F72026D6E;
	Sun, 12 May 2024 16:56:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 12 May 2024 18:55:33 +0200 (CEST)
Date: Sun, 12 May 2024 18:55:29 +0200
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
Subject: Re: [PATCH] rcu/sync: don't read rcu_sync->gp_count lockless
Message-ID: <20240512165529.GD7541@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <20240512111948.GC7541@redhat.com>
 <550cf35c-4fb3-4f06-95b2-9206425d74cc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550cf35c-4fb3-4f06-95b2-9206425d74cc@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 05/12, Paul E. McKenney wrote:
>
> --- a/kernel/rcu/sync.c
> +++ b/kernel/rcu/sync.c
> @@ -151,15 +151,11 @@ void rcu_sync_enter(struct rcu_sync *rsp)
>   */
>  void rcu_sync_exit(struct rcu_sync *rsp)
>  {
> -	int gpc;
> -
>  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
> -	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
>
>  	spin_lock_irq(&rsp->rss_lock);
> -	gpc = rsp->gp_count - 1;
> -	WRITE_ONCE(rsp->gp_count, gpc);
> -	if (!gpc) {
> +	WARN_ON_ONCE(rsp->gp_count == 0);
> +	if (!--rsp->gp_count) {
>  		if (rsp->gp_state == GP_PASSED) {
>  			WRITE_ONCE(rsp->gp_state, GP_EXIT);
>  			rcu_sync_call(rsp);
> @@ -178,10 +174,10 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
>  {
>  	int gp_state;
>
> -	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));
>  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
>
>  	spin_lock_irq(&rsp->rss_lock);
> +	WARN_ON_ONCE(rsp->gp_count);
>  	if (rsp->gp_state == GP_REPLAY)
>  		WRITE_ONCE(rsp->gp_state, GP_EXIT);
>  	gp_state = rsp->gp_state;

Thanks Paul!

But then I think this change can also revert this chunk from the previous
patch:

	@@ -122,7 +122,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
			 * we are called at early boot time but this shouldn't happen.
			 */
		}
	-	rsp->gp_count++;
	+	WRITE_ONCE(rsp->gp_count, rsp->gp_count + 1);
		spin_unlock_irq(&rsp->rss_lock);
	 
		if (gp_state == GP_IDLE) {


Thanks again,

Oleg.


