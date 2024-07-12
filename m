Return-Path: <linux-kernel+bounces-250554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291592F8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03843B2563D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804CC1581F5;
	Fri, 12 Jul 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A78Im2pJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D4149000
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780099; cv=none; b=lIDzvClFW66GVcSIVpXxI1HTShQHIrFm3gfahHE5FVC/08kMtC+vnEYQyPMFQIF6a7aTN//GbNX3ytyDJYSs6ZrVrKQj4oqLQWZgCU8CtrQ1LqVfCFXTCK2YNwtkGPl1vYlqrVTrNzCPKNAVbBo49TTyX8ZbZeSSlT6VH6X6D/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780099; c=relaxed/simple;
	bh=858t69WfL/tj9FR/9VOg/7LQIGZGuDl9bR4EsN6LxjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qreBQlFbjDmtClBRBsQY6ABE4Jq/5kXqnahpjTDDd7nRgDJ5XXkOJoLf3L/MIkq5wUu5na8pUkpBY20haOVxqxDb2J8YycN2/ZKYz7VD/2PqJtx3LmgZUKfkTG30iReL8WVFslwvdJ/xQKVFjESfqMIsF3HGzVzk+MX1RjYr5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A78Im2pJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720780097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epE1NcIup0vbrzaXG/uxhpSJU7vRRm4fO7gG8wrP94c=;
	b=A78Im2pJoqwTejHvnT0pW3+OhceSwc+74UG9zYZLi6nUmAq4toAbiRlji/f/dI2rz//J7h
	9pFvDpBLzhiHwR7+ky6Dkerkq30hmTB3pYQMMQxw/kV8rSJw/yCF8/ubbtpKKRDtovnJg7
	r3HRtqVTFMKb2nsQHBiqqhDDg5tAYcs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-FpBauZnNNbie9WNCv3t6PA-1; Fri,
 12 Jul 2024 06:28:12 -0400
X-MC-Unique: FpBauZnNNbie9WNCv3t6PA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 079AE1954B38;
	Fri, 12 Jul 2024 10:28:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.173])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6910119560AA;
	Fri, 12 Jul 2024 10:28:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 12 Jul 2024 12:26:32 +0200 (CEST)
Date: Fri, 12 Jul 2024 12:26:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 10/11] perf/uprobe: Convert single-step and uretprobe
 to SRCU
Message-ID: <20240712102627.GA31100@redhat.com>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.311168524@infradead.org>
 <20240711160652.GE16902@redhat.com>
 <20240711184251.GD27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711184251.GD27299@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07/11, Peter Zijlstra wrote:
>
>   uprobe_free_stage1
>     call_srcu(&uretprobe_srcu, &uprobe->rcu, uprobe_free_stage2);
>
>   put_uprobe()
>     if (refcount_dec_and_test)
>       call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_stage1);
>
>
> So my thinking was since we take uretprobe_srcu *inside* uprobe_srcu,

Ah, indeed! Somehow misread the change in put_uprobe() as if it
uses call_rcu(uretprobe_srcu).

Thanks,

Oleg.


