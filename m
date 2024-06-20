Return-Path: <linux-kernel+bounces-223331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80137911146
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FCFB27ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20F1BBBDA;
	Thu, 20 Jun 2024 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLwx3Tgb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10FC1BC095
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908459; cv=none; b=uPx5AhGzhONbWfu/CciZ0TQwAh05MOnXhAa1ZV47QHmzQtpbkngpMRmNqWu+J+WN489wE++kA0koUtgjNSQ84CcPCEflIljN+f1AiGDPcUfNboxjFBF62EBzAYBwlwiilk5hU74IMUPER4h8LuZQY+hosFeB+/Obx9mexww+enU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908459; c=relaxed/simple;
	bh=SLTcb+k51rqswflzWg3ZbykIc839nIpu4j+u+uc48KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Daa+uUftvc53NVFN231BRuHPZHi8EQ1it6HkGBsOj0LtRZ9X66QzXRet2AzmsnYauYEOjblY4ExgCwgXmPjUaSiZYY07BLFShKViPICvbPXvhE8tg4xYMldS0nqrayOl3+7yifJD80FBIxFjKenIogpEfXt8cTSuKt6FT5NS+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLwx3Tgb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718908456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWGOZ5x9U68yB64FGPI0opjFJHzrTVmGdyjMtfdZyeU=;
	b=eLwx3TgbbEES5AeVsJRiQy99WRmpMqxN6Jvgo3gKSYAysHtGGeTNtjccv2OlKmNQ55FUFb
	maIslynnCTVms5iuPj+aoyqGDUHUUV5izrN0PSXqh0X9a+kVq2A0JXGHyUwJ2gFM8N+Pzp
	MWeOyM4jtn7umdffsIchQwFO8Fn3Hac=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-CMeDcwWLP_GcYKQq1Ny3eA-1; Thu,
 20 Jun 2024 14:34:15 -0400
X-MC-Unique: CMeDcwWLP_GcYKQq1Ny3eA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B30081955D5B;
	Thu, 20 Jun 2024 18:34:13 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.10.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87F7B1956048;
	Thu, 20 Jun 2024 18:34:10 +0000 (UTC)
Date: Thu, 20 Jun 2024 14:34:07 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	john.ogness@linutronix.de, pmladek@suse.com, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, williams@redhat.com,
	jlelli@redhat.com, lgoncalv@redhat.com, jwyatt@redhat.com,
	aubaker@redhat.com
Subject: Re: [PATCH] prinkt/nbcon: Add a scheduling point to
 nbcon_kthread_func().
Message-ID: <ZnR2H5l7hyQflA4E@debarbos-thinkpadt14sgen2i.remote.csb>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <20240620071545.Es9LoyJY@linutronix.de>
 <20240620093246.HE9XDWSZ@linutronix.de>
 <20240620094300.YJlW043f@linutronix.de>
 <skr5kyam73ldikhn7uc6b3ikq4cxrtd4ohd4dekkhlmtyxmnbg@mw6xlvaop6hz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <skr5kyam73ldikhn7uc6b3ikq4cxrtd4ohd4dekkhlmtyxmnbg@mw6xlvaop6hz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jun 20, 2024 at 12:18:37PM -0500, Andrew Halaney wrote:
> Acked-by: Andrew Halaney <ahalaney@redhat.com>
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> 
> This survived a bunch of tests that normally would cause some lockups
> etc in PREEMPT_VOLUNTARY systems. I can see that the nbcon thread successfully
> migrated NUMA nodes etc during periods of overwhelming the console backlog
> successfully, which without this would not work prior.
> 
> Thanks!

I'm going to second Andrew's observed results here. With the original
reproducer of calling LTP pty03 && pty06 in a while loop, plus invoking
stress-ng with --timeout 60000s && --numa 64, there were no problems with the
nbcon thread migrating NUMA nodes and no panic(s) with 
kernel.softlockup_panic = 1

This was observed on an nproc == 128 machine.

Thanks! :-) 

Acked-by: Derek Barbosa <debarbos@redhat.com>
Tested-by: Derek Barbosa <debarbos@redhat.com>


