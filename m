Return-Path: <linux-kernel+bounces-277955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B307C94A8A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1EDB24AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E11C9DDB;
	Wed,  7 Aug 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEi3+pbq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F361CCB3A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037418; cv=none; b=jLlwkBcdRMgjVPqt2+eO7jrk7x3cMBz/r/TBbuRQlQxUEuJ8+lEHvcIhpHPqpGScQZsdyQUMWYnQk3FDcsYmk4iGEupGk9q3gEpNjsIcr07YFn0DZXRo38B/Gu5RT0FWDaqmTesgLp/veRyTXc7RUqfJHbdjLynM81Ooh3zN5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037418; c=relaxed/simple;
	bh=2eRPKEFxxIXDo90EmVtlG5x4oYNEUjacrR24ctzOsA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvLhf7M7DsxtJ6O3dIpCiiu8pyG9YdIWwa+MY+kKOqU5UElFl8L1jdLyf/RBqgrXaNvRhEJZNspqjHwMhGI1I1Vr98/8Zsst+5/vMYXXO+iOWmegWfBCvtDveJwTci13JtspVNnG+GWHbG1BXWVdOruKCJUKeMnZ+q2Q9MrYfVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEi3+pbq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723037416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Pw5MOqd3z8LGuMF23Tz78DSwPMjyeTrVQ5jFAuAguQ=;
	b=eEi3+pbqqIRBCfQqO2lA3f6bAhCV1EU12vLV50qRzreWO7+3sjg1D0ZuAMs0IaFD9suToH
	ue2apz1KtSQKPazRTAMALiyrRJeZymoSo/LKMMQJMRk6QsEF7BEXSw0Jjh8s4bsA89HJ/7
	1ajVL3CKABIIA27ypMDatFM0o+mlbTE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-eAAaB6LjOfCnEp4UIRxBlQ-1; Wed,
 07 Aug 2024 09:30:10 -0400
X-MC-Unique: eAAaB6LjOfCnEp4UIRxBlQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C1721955F28;
	Wed,  7 Aug 2024 13:30:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.97])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D0FB01955BFC;
	Wed,  7 Aug 2024 13:30:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Aug 2024 15:30:07 +0200 (CEST)
Date: Wed, 7 Aug 2024 15:29:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240807132922.GC27715@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/31, Andrii Nakryiko wrote:
>
> Andrii Nakryiko (6):
>   uprobes: revamp uprobe refcounting and lifetime management
>   uprobes: protected uprobe lifetime with SRCU
>   uprobes: get rid of enum uprobe_filter_ctx in uprobe filter callbacks
>   uprobes: travers uprobe's consumer list locklessly under SRCU
>     protection
>   uprobes: perform lockless SRCU-protected uprobes_tree lookup
>   uprobes: switch to RCU Tasks Trace flavor for better performance
>
> Peter Zijlstra (2):
>   rbtree: provide rb_find_rcu() / rb_find_add_rcu()
>   perf/uprobe: split uprobe_unregister()

I see nothing wrong in 1-7. LGTM.

But since you are going to send the new version, I'd like to apply V2
and then try to re-check the resulting code.

As for 8/8 - I leave it to you and Peter. I'd prefer SRCU though ;)

Oleg.


