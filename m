Return-Path: <linux-kernel+bounces-330770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F3397A403
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B343C1F223A0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0DE156C52;
	Mon, 16 Sep 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xfxb/MgW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7E14F12F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726496365; cv=none; b=O1n+sjve5yf0vAmhDA2rnl3avg/PwX7tIL0CDLH9ZDcdiJMRJUdR8OssGQ//UX6EvvJg8+07FXz8g1Rrev6ta691vrRFw+3aTTO02KLNjLUkNaavJk7xJPqAQOoDnRpXHnmbNUfTmOOJViHDMUtmQevwTuCTAc4KSZeKT8OkEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726496365; c=relaxed/simple;
	bh=knm+SgfwZ9UaN8njARDSqAzh//upppGOTDB0X/DOlB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsfdltmfBjxYagemakRE91qVuxL3BFxg9kUfjYD+mc30igvSmIJC8+LPF2OTdVViql5kXviKLXFWt2WYArpfRRpfltGFwEna6izeMoC6KT3e8b9AT47jjn9txFW9efDDrBnC3UUoclMwDUsvq56KeRBMZl1BebJgPuKt7L3GbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xfxb/MgW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726496362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=knm+SgfwZ9UaN8njARDSqAzh//upppGOTDB0X/DOlB0=;
	b=Xfxb/MgWEqZPA9xCltn9fpLH9ygdMQ2Ppc/q/Etb5FAa3eQGLgD4VRK77TbCBq2HlGgBvC
	ZVMF/Qg3ibQBHJxsN/AsHfrOOGEFFdLPHhyaMnOSp/evEVFjGWvr0ZN79SkZJZSsBDkch+
	qpVFgsB80kv1w6QsKQQTJYNZfhn76wQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-1J4J-k56PqKibycX6NXmdQ-1; Mon,
 16 Sep 2024 10:19:17 -0400
X-MC-Unique: 1J4J-k56PqKibycX6NXmdQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A23FB19560AE;
	Mon, 16 Sep 2024 14:19:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.82])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 008DE195605A;
	Mon, 16 Sep 2024 14:19:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 16 Sep 2024 16:19:02 +0200 (CEST)
Date: Mon, 16 Sep 2024 16:18:56 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	chenqiwu <qiwuchen55@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: arm64: stacktrace: WARN_ON(state->common.pc == orig_pc) in
 kunwind_recover_return_address()
Message-ID: <20240916141856.GA10560@redhat.com>
References: <20240916102741.GA13899@redhat.com>
 <mb61pmsk7natw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61pmsk7natw.fsf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/16, Puranjay Mohan wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > given that kunwind_recover_return_address() passes idx == NULL to
> > ftrace_graph_ret_addr(), it should always return ret == state->common.pc ?
> >
> >
> > Perhaps this connects to 29c1c24a27 ("function_graph: Fix up ftrace_graph_ret_addr()")
> > and I have no idea if something like the patch below makes any sense.
> >
>
> Your finding is accurate.
>
> It has been fixed in upstream by c060f93253ca ("arm64: stacktrace: fix
> the usage of ftrace_graph_ret_addr()")

Yes, I have already found that commit, see my next email ;)

Nevertheless, thanks a lot Puranjay for the confirmation!

Oleg.


