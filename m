Return-Path: <linux-kernel+bounces-248152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C592D8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A9E1F2107A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0A1974FA;
	Wed, 10 Jul 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+1kcPgd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCA195FE0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639219; cv=none; b=n1aSLOipPDBp061cuO5nAKMyGtAF2HuMEoF/66jV7gDFiMCBuVuE3BwsUv911CKUsldsfsjTQqckmkJHijo8TSlIqoQiIaiP0+1yIUwwd9iewaksq8XJDNsmrIjYMbC+QVIdVUi4h2lufwt6I3gMBmyZuquxp0IDauJ8nplFb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639219; c=relaxed/simple;
	bh=0fsclPJO+0S/lvzn0RI6aYyeLzEsX1Mg7kOsvhED/bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slVbYG16Fb5nUjl917JwcbR/IQPk2sqiKmlR8EgR4tL3/hJFAE0QAwJdml6HRDRBYQEb1KdkLMZW2Gcl74VMB7SEZ7DO8EbFwd3pXe4Mqj+mMIfawEO0X4zbjQcf0iPG7LG5/J6mNJCDgk6r+MKk2sp51gD1XamqETc9PxfjKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+1kcPgd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720639217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0fsclPJO+0S/lvzn0RI6aYyeLzEsX1Mg7kOsvhED/bc=;
	b=N+1kcPgdpBWiG4TxvskWrmKp+TOhLeF8xAAV/YzBxSQg0YN37GWMCd/3CCr5GYzV6mpomD
	79pLihsOUlZl/SfEPEqVMhO0inMXXIc3SuXtvU3n87QLmy0V3/8p4KJqsRJw+rRxsjiPOs
	/oISBmTFh6/sOkAS9VTdHh093wI++yo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-rqcydCwYOAGWRZkmxDNCLQ-1; Wed,
 10 Jul 2024 15:20:10 -0400
X-MC-Unique: rqcydCwYOAGWRZkmxDNCLQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B9F81955F42;
	Wed, 10 Jul 2024 19:20:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E2AD81955F40;
	Wed, 10 Jul 2024 19:20:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 21:18:29 +0200 (CEST)
Date: Wed, 10 Jul 2024 21:18:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Julian Orth <ju.orth@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/2] kernel: rerun task_work while freezing in
 get_signal()
Message-ID: <20240710191824.GD9228@redhat.com>
References: <cover.1720634146.git.asml.silence@gmail.com>
 <89ed3a52933370deaaf61a0a620a6ac91f1e754d.1720634146.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ed3a52933370deaaf61a0a620a6ac91f1e754d.1720634146.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

I have already acked this patch, so I am sorry for the noise, but

On 07/10, Pavel Begunkov wrote:
>
> Run task_works in the freezer path. Keep the patch small and simple
> so it can be easily back ported,

Agreed.

I tried to argue with v1 which added the additional task_work_run()
into get_signal(), but I failed to suggest a "better" change which
doesn't uglify/complicate get_signal/backporting.

Oleg.


