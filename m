Return-Path: <linux-kernel+bounces-279538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C3494BEA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC6E28152F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7AD18E022;
	Thu,  8 Aug 2024 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC2TVhay"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84542143726
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124420; cv=none; b=j4IQSQoNPdqtVLZDvW/JKmlygjhmMQaWGkh+Oshs2r1lPdBdmGGgfgmtR6MIEcRmuVMl1saX65fSP1a+Sh7BgoB/llCCRID2nCWjV95/slzbqivBPRWZIxsVjRr2ev98UAHx6moOqRO8Y40CAOBd2A7ADXin+55PVALugP1rjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124420; c=relaxed/simple;
	bh=E7qPM6Za/OUweacjnMkcLSYOGg27RehJJPlMm6etOas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMmzKNdoLe+ECSZnSWvtzlXWloiLf6w0AQQCDXnTIO5iYR6Bf1arnOdLnUtJOJGaMxhmfW8qOiIbqnv0UF04C63Aq5yCL8QDQqAdmZxkvBv5D3R854mRJNWGqbmNjFZx5eb8xlBl5xi9Y2XvJyapTZmkqD77Cs8daz3qM9dFclw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AC2TVhay; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723124417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BzXJpaP0eGm9JAF0HD6UstKeBReW0UlULvpo8rzaNMQ=;
	b=AC2TVhayr+4xkzsoOKXiRRh7lq+F/4Wq+Z4LWgOD8SaeWkQ/7ORG0koKF45LeKKnKJvDbe
	nC/Ovu0UBtdXheizf/T4HCL++vwXxAaiqOp9PflxpsuKMk7PvnAj6W0y3FIKpRCzdEKR2S
	UlhviStYt3mluj+n2g+lXs3glSrmlBc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-qdhrjKtiPpmbMdJcVjijYQ-1; Thu,
 08 Aug 2024 09:40:15 -0400
X-MC-Unique: qdhrjKtiPpmbMdJcVjijYQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAE361955BCF;
	Thu,  8 Aug 2024 13:40:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 27C9919560A3;
	Thu,  8 Aug 2024 13:40:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 15:40:12 +0200 (CEST)
Date: Thu, 8 Aug 2024 15:40:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 7/8] uprobes: perform lockless SRCU-protected
 uprobes_tree lookup
Message-ID: <20240808134007.GE8020@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-8-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-8-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/31, Andrii Nakryiko wrote:
>
>  static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
> +static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);

Just noticed... Why seqcount_rwlock_t?

find_uprobe_rcu() doesn't use read_seqbegin_or_lock(),
seqcount_t should work just fine.

Oleg.


