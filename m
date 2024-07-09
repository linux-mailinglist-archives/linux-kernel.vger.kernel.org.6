Return-Path: <linux-kernel+bounces-246175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82E92BE88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EF2B234D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AFD1891C4;
	Tue,  9 Jul 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjG/Xr0l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF57F487
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539394; cv=none; b=OQoR22q89gUTDXl7f3rCDm5txi4ePagb2ktBp9s6h0KKnTxw3i5877XkEsKTOD/oXoYG+rVRC/LMfMTMx6FBaIvwSvXn6g73KO9Go5sjWlE5yba47mHcod0ASTfon799WYPdysCGvIv8bY0Llgr5a0/RTmCEJZmkbCFgaADy2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539394; c=relaxed/simple;
	bh=QoXH9WXn9OqrNxC/5axg7uSehbufDXSMvxyVSPrSAu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAvBO0mwRECnB0dPwY4qm7YD298yrCfSbNjErTF+NsGzkr+lx/s5LGGTcao4fG8gtjZSo2/sJoihQNHv3fp9sAHwgBW82x2drYcmR8EuhDAtDhkhVV7qWtW3vFwA5f4wCaBXUvSuN6PDL+bGZ3YQy3fJLV7ZYG+vQJNaymAUNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjG/Xr0l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720539392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QoXH9WXn9OqrNxC/5axg7uSehbufDXSMvxyVSPrSAu4=;
	b=AjG/Xr0lUj9VjI6/+kAqUq8dLM1n8OuvPG90KvUcKREDqxwYfrMPoJhDuDtMOih+jQ+2Aw
	1ioUI3LF4nr00AOj7/FlvuUCs7HXF1ZiPaMuUjbkW3G3sy4qb3g0ACpxkaxkW60moaQsV6
	OGp3vUh1yKQCeuSZTkuw8yQsmo70iaI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-WV5DF-83NxGDU3uajjyf9w-1; Tue,
 09 Jul 2024 11:36:27 -0400
X-MC-Unique: WV5DF-83NxGDU3uajjyf9w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5791F1944D30;
	Tue,  9 Jul 2024 15:36:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DC5501955F3B;
	Tue,  9 Jul 2024 15:36:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 17:34:49 +0200 (CEST)
Date: Tue, 9 Jul 2024 17:34:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 05/10] perf/uprobe: SRCU-ify uprobe->consumer list
Message-ID: <20240709153444.GH28495@redhat.com>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.695619684@infradead.org>
 <20240709120551.GK27299@noisy.programming.kicks-ass.net>
 <20240709133349.GC28495@redhat.com>
 <20240709143218.GM27299@noisy.programming.kicks-ass.net>
 <20240709150504.GF28495@redhat.com>
 <20240709151930.GP27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709151930.GP27299@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/09, Peter Zijlstra wrote:
>
> Hmm, easiest would be to add a seqcount to register_mutex and simply
> skip the remove case when odd.

probably yes,

> Then the handler might get a few extra (unwanted) calls, but it should
> be able to handle them, they're fundamentally not different from the
> first one where it says REMOVE. Right?

plus the handler can never assume that UPROBE_HANDLER_REMOVE won't be
ignored, another consumer can want to trace this task.

Oleg.


