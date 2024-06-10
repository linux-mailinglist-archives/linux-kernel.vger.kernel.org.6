Return-Path: <linux-kernel+bounces-208499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1109025E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476CA1F22527
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292F13DDBF;
	Mon, 10 Jun 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKvM3120"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C0A953
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034250; cv=none; b=MiTPMAgwS/ZsqGzOIOzdmeybXni5kA7JlzKzCTfvEtvL2eXCaKxfd8qwzONI7+JEYpmAtePVSBB1SSzdWUcxFXp04Vepeoo/KqtkSz8H7Y7nWJTYmCvpOHWibCUN1PNOBo99OeNuVnuOErlRej0+ktrLHqR4i8YZknjjrBWeJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034250; c=relaxed/simple;
	bh=HLc+fvDIRaaMlBOSzyUtzanU6pOiNOst/nVuD8ZtJzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvyFYheRyYEI70gOLhZ1M5eH6RAXPn7chKIrNpQ7rBRdI8BB+KHs6IQKuA/4JFzSJexpYDckR0H+TqyZcPTSR6r/O9JuU/TfPO3SwR8PNJ37gGRwfLqPLKXPWDVgG84nifE18CAKT2i2LoooqpSra4Snk7ZEXugKJ4qCtzvRaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKvM3120; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718034247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T2EqbctTT1xHHn0V6/YoWQcjmYAW5mNOc777pbvK9Ik=;
	b=fKvM3120J6xUwmFpMfLGPzloGlPfsPdwODd+f9ZWXBK1WEeje15N6hIs7MkrRPQAZY/N+Z
	w438HGqtbWF9IiyFXxWibqZ0byJycZgorX/meFkjgWIKKGFnJQ37yTQ3XHuVHc5JsxYVnu
	InvOz4uiA22aZyeQtfcjq1+L3702qqg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-nhYQIaqWNPyujwhJpVPi3w-1; Mon,
 10 Jun 2024 11:44:04 -0400
X-MC-Unique: nhYQIaqWNPyujwhJpVPi3w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD34F1956064;
	Mon, 10 Jun 2024 15:44:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C4F8619560AA;
	Mon, 10 Jun 2024 15:44:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Jun 2024 17:42:32 +0200 (CEST)
Date: Mon, 10 Jun 2024 17:42:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
Message-ID: <20240610154229.GD20640@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610152902.GC20640@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Forgot to mention ...

On 06/10, Oleg Nesterov wrote:
>
> I guess I was not clear. Of course, SIGNAL_GROUP_EXIT must be always
> set under ->siglock. But I think synchronize_group_exit() can just
> return if SIGNAL_GROUP_EXIT is already set? If nothing else, this is
> what do_group_exit() does.

Just in case... I guess do_group_exit() needs some cleanups too. For
example,

	if (sig->flags & SIGNAL_GROUP_EXIT)
		exit_code = sig->group_exit_code;

without siglock is racy, exit_code can be wrong (not a big problem).
LOAD(sig->flags) can make KCSAN unhappy. Etc.

But this all has nothing to do with 1/1 ?

Oleg.


