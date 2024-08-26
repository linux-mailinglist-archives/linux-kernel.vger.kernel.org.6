Return-Path: <linux-kernel+bounces-301921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3896395F763
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E800C28415C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC319882F;
	Mon, 26 Aug 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN8K0ki5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2F143C7D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691941; cv=none; b=P76RelH7pstZz2FCt+fs7HhV9h/XxNGidzeoPV36xyOmXPa9pGuPd8zTNmm/g8oXgXblZ442GI1AuBLD3xHhL4KIihKCkIrpwN/Qd9WJkivLkIBBjkxigWd/CGY/v7XdQ6N3KSC+fBJQg57ek6KeDH308DKpjYA0oJcHfmErnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691941; c=relaxed/simple;
	bh=v1x8qM1JUpd+6H6lGzaQVnYOqnn9LhFyhGDyQJjWVpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dElFBN0SjVMxbnFkEObbjm/3NWXZpzdM5SBhlkrEmS1lGrLYLQQcb0m9/thigP/UpIiZyudR0m5S73Y+y10f6at2+N7CPtyqF7jxSM4ThAWwfkCXSa93mon0uNcpGQ9eb5FMJnvNDZZnzPEFbRVUQOJlfymbDEvMMDByuz/hw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN8K0ki5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724691938;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=iFLwdjGWsrz80giJodffzu8y0WaO5ReAP6Vq8OTY0bQ=;
	b=CN8K0ki5O0euZNew5unopbbfLQZzBiJIN8gBvnXCuiPuXZ1iXqXI3u+y8cfZfrLTOn7VoR
	QDXo2aJU+NPNx8HyGeQIlEpez6CwGflaYofhi/H1pvjBgm1721++Ga/YiqW/hfNWVHi2vT
	jU+xPghfpHAoE2z7BAnUlhpUmCrI1Hw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-5vz5HxPKNIq2vA7ptFg9mw-1; Mon,
 26 Aug 2024 13:05:36 -0400
X-MC-Unique: 5vz5HxPKNIq2vA7ptFg9mw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A9DC1955D47;
	Mon, 26 Aug 2024 17:05:34 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.65.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B435300019C;
	Mon, 26 Aug 2024 17:05:32 +0000 (UTC)
Date: Mon, 26 Aug 2024 13:05:29 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, pmaldek@suse.com, williams@redhat.com,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: test 1: was: Re: A Comparison of printk between upstream and
 linux-rt-devel
Message-ID: <Zsy12a7DQqu7h4zp@debarbos-thinkpadt14sgen2i.remote.csb>
Reply-To: debarbos@redhat.com
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZshiIdUFQs4CKW2t@pathway.suse.cz>
 <Zsjd0WUNIU8_kprt@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZsyK-s2D8eqqBrXU@pathway.suse.cz>
 <ZsyVXMqM2SK0aYyV@debarbos-thinkpadt14sgen2i.remote.csb>
 <Zsyafduo2UItzLAK@pathway.suse.cz>
 <871q2b8bou.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q2b8bou.fsf@jogness.linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Aug 26, 2024 at 07:02:49PM +0206, John Ogness wrote:
> For the 8250, I would expect the legacy driver (even during "hope and
> pray" mode) to be fairly reliable.
> 
> If this is running in QEMU, you could attach gdb and dump the backtrace
> for the panic CPU and investigate some state variables. If this is
> reproducible, it may be worth investigating where/why the legacy
> printing is choking.
> 
> John Ogness

Hi John.

This is not running in QEMU. I installed & booted this kernel directly.
Considering that this produced a vmcore, I could try my hand at doing a crash
analysis (with some pointers).

Do you think running this kernel in QEMU would behave any differently than it is
now?

Best,


