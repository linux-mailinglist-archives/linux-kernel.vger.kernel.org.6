Return-Path: <linux-kernel+bounces-245926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B692BB77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FF51F28462
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09113168C33;
	Tue,  9 Jul 2024 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+t7nWrJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D615749F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532137; cv=none; b=R36eFmnDLn8uY/7T4iHLTQqZZMChT7RNIPkYVCW6DS5XqO1ATOJxPaAGHNcKykiBmC+cE/XZNGCiUeocj7kBhZqnCIfTNUDuxSel1Neit28yxM3vCcLBAQT33ND7ffIkN9pOtDhSkL+QvcGpfjgJOVIczLbJYeqa8TiMNqTlTpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532137; c=relaxed/simple;
	bh=cuzCeXTqYo0QyMrSSzYvnTgJyAf40E7V2eq3QJrrnXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gijs4L6WG2q7Bemtx1lsZl17ZUW8A5/z7ldwVvtvoJJI5hQMvT4VJ/bv8OBSAKjl4BCvCAQuLxxf9uCOzuOEprxuoV2YTvzAzJcxhLFZ4BUTMOYIEHteg0szNbxWWMoF0udgJyApO654/+dkS85BCMdkMIV8YPIgHfi3Qm0vVAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+t7nWrJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720532134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijEQ5OJUpTOCUi9BswoP/Fe9Lk/QYNAmNRytj2PeYAM=;
	b=W+t7nWrJ0TTo79RuoVsfoQrmP9qyVhgV3lK+gGGKQkxvTkZbo78Ic3lXm+t/VCkGARWmlV
	1pbpYGqsN/PQCtiKldsH4o4JlbPqTWMN6gormJqW8/GRjuLMzBy5j27C2n9vjBiBiwvf3q
	vS3J6aAqSP1IoYynKsJWcwhTDe6IQeA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-SJycBqmhPPOA49SJpkQ27w-1; Tue,
 09 Jul 2024 09:35:32 -0400
X-MC-Unique: SJycBqmhPPOA49SJpkQ27w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29BD5196E0A1;
	Tue,  9 Jul 2024 13:35:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DA67319560AE;
	Tue,  9 Jul 2024 13:35:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 15:33:54 +0200 (CEST)
Date: Tue, 9 Jul 2024 15:33:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 05/10] perf/uprobe: SRCU-ify uprobe->consumer list
Message-ID: <20240709133349.GC28495@redhat.com>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.695619684@infradead.org>
 <20240709120551.GK27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709120551.GK27299@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/09, Peter Zijlstra wrote:
>
> > +	guard(srcu)(&uprobes_srcu);
> > +
> > +	for_each_consumer_rcu(uc, uprobe->consumers) {
> >  		int rc = 0;
> >
> >  		if (uc->handler) {
> > @@ -2116,7 +2126,6 @@ static void handler_chain(struct uprobe
> >  		WARN_ON(!uprobe_is_active(uprobe));
> >  		unapply_uprobe(uprobe, current->mm);
>
>    ^^^ this remove case needs more thought.

Yeah... that is why the current code doesn't use ->consumer_rwsem, iirc.

And consumer_add/del need some changes. Say, consumer_add() does

	uc->next = uprobe->consumers;
	uprobe->consumers = uc;

I guess it should do

	WRITE_ONCE(uc->next, uprobe->consumers);
	rcu_assign_pointer(uprobe->consumers, uc);

Oleg.


