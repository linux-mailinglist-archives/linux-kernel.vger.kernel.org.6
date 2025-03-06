Return-Path: <linux-kernel+bounces-548908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA9AA54AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA92E16A586
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC6B20B7F4;
	Thu,  6 Mar 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwUdjJpL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175B20B7E2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264417; cv=none; b=AkqPCvdE7tSzoCGk0J95rqNelSiWcqvz+2mc0NHtWh3FatYV5qNnysVBR/RAo0MmcU29SsfkE1Vt2o4Ah4txaeOWkTtIJ7R/5ToDir/LOB+Pxg7L5hQyEcm4rVNHg0E35vIZZs+vdR3wLaOQVFK8+92HYv74EbqHKSfpMtSTWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264417; c=relaxed/simple;
	bh=kFnpwOqp85UqVvm4pdv7W15a85XO7BqfmlYiqyDaHpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT3w0mjxjfCil/ivp7Wqv7xojZ2+bCXreXQadLCnkeErcQ7y03ugtEMotmN4sHFqhNq6e3wTeGGBooe+mx2JmFbWPooJoNbJr1OUHH94x6JihHWjj60/+kZNVEwV4LKMXX31aiDQpBlUbhcDqtrwOC+aEWZ4hzznSjrUXYykFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwUdjJpL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741264414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSaun7lz0bYxj+TpuiSszwxCug8hPax6TNKoHPYNE3k=;
	b=GwUdjJpL430wMKRtz8jYrsZhrVZfW0zuuMukS9UKd5voyAx4JdP0lOYhd3aDZrXpRIzDE4
	sV3mwqGTfYtbaa/72abioYUi2hvtzauAUEvl5mdJ3KJK9sx89XKIK4zsNMcB51ORVVqK0S
	UuvMD6OCpCfz6/Tv8usyjgGQ3t3jkik=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-7dVMJNGsO7ylcJzUCNfUbg-1; Thu,
 06 Mar 2025 07:33:28 -0500
X-MC-Unique: 7dVMJNGsO7ylcJzUCNfUbg-1
X-Mimecast-MFC-AGG-ID: 7dVMJNGsO7ylcJzUCNfUbg_1741264406
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27E1719560AB;
	Thu,  6 Mar 2025 12:33:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.240])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 110551955DDE;
	Thu,  6 Mar 2025 12:33:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Mar 2025 13:32:54 +0100 (CET)
Date: Thu, 6 Mar 2025 13:32:46 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Neeraj.Upadhyay@amd.com,
	Ananth.narayan@amd.com, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 3/3] treewide: pipe: Convert all references to
 pipe->{head,tail,max_usage,ring_size} to unsigned short
Message-ID: <20250306123245.GE19868@redhat.com>
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
 <20250306113924.20004-1-kprateek.nayak@amd.com>
 <20250306113924.20004-4-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306113924.20004-4-kprateek.nayak@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 03/06, K Prateek Nayak wrote:
>
> @@ -272,9 +272,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  	 */
>  	for (;;) {
>  		/* Read ->head with a barrier vs post_one_notification() */
> -		unsigned int head = smp_load_acquire(&pipe->head);
> -		unsigned int tail = pipe->tail;
> -		unsigned int mask = pipe->ring_size - 1;
> +		unsigned short head = smp_load_acquire(&pipe->head);
> +		unsigned short tail = pipe->tail;
> +		unsigned short mask = pipe->ring_size - 1;

I dunno... but if we do this, perhaps we should
s/unsigned int/pipe_index_t instead?

At least this would be more grep friendly.

Oleg.


