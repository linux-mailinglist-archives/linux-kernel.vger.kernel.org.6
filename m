Return-Path: <linux-kernel+bounces-228875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DA91680D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3733C1C24D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EE714D294;
	Tue, 25 Jun 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOLKDiNd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AF14BFBF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318957; cv=none; b=tpENqk3t/OCnlWk2Tp1f+S95hyIMamRTWLrtXbfrSN5v5ZSN5NsZ6EO6iaKPwrlY3WgPSlMBQrKMItRxqdgPqC2QB1U5zNiT2biT2/U3nSnKPpnOhAoF9zeI+LRPOS5NQ+vIOMNaycUaMOjUCXmtVZN4U/EIwAT1pjrS60mVXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318957; c=relaxed/simple;
	bh=BP08sTdTTNHRTt+6KipTmcAxEw1ocEmLhTr+kBQbVtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhuVwQHDvFULSKRRWYLOucsVioBrRiE8HSNAj3+aSAGcNDhf1FkjNWCf2S/KiYqHDz81Nm1Lgye5DTO1mxJoEK4XrD9+i3hNUSGt1Ha/tPNc97xFUBWxRF7Fjm6Ryr29qNjSR369VZkE22ZTXaRMs7i1b/ZXeMMn/F9HX+8GxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOLKDiNd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719318954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Rx4ljDasquwUrnCO7d0BB6VQoqF3qIWWRtfu74Fd0Q=;
	b=EOLKDiNddPxMrogCe02BmxHB82Cj/F7dwFg4JQ8SMoNiCNsbJiilGBQGzKhVAO4/VP4uck
	gvC3UVwl65fdcxcCgxmjw5blPJmxhn5w0Ecg9YKwbvTcj6OLKqVjiflcwkhVTZ4J+QFOoi
	v5i1LokdbA1QAFIWk4SJfyUJP8NkUgE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-_mufoMiEOEufhfhljYYGJw-1; Tue,
 25 Jun 2024 08:35:53 -0400
X-MC-Unique: _mufoMiEOEufhfhljYYGJw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D618D19560AA;
	Tue, 25 Jun 2024 12:35:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EC82B19560AB;
	Tue, 25 Jun 2024 12:35:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 14:34:18 +0200 (CEST)
Date: Tue, 25 Jun 2024 14:34:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] signal: Compute the process exit_code in get_signal
Message-ID: <20240625123415.GA16836@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
 <20240613154541.GD18218@redhat.com>
 <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
 <20240617183758.GB10753@redhat.com>
 <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
 <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
 <87cyodinl5.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyodinl5.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/18, Eric W. Biederman wrote:
>
> In prepartion for moving the work of sys_exit and sys_group_exit into
> get_signal compute exit_code in get_signal,

So far I don't understand the purpose of this preparation, but

> make PF_SIGNALED depend on the exit_code

> -		current->flags |= PF_SIGNALED;
> +		if (exit_code & 0x7f)
> +			current->flags |= PF_SIGNALED;

This is another user-visible change...

PF_SIGNALED means that the task didn't exit on its own but have gone
through get_signal().

This should not affect coredump_task_exit(), but what about
acct_collect/bacct_add_tsk ?

Confused...

Oleg.


