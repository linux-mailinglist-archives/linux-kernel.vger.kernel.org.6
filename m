Return-Path: <linux-kernel+bounces-269620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0249434F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B304A1C239EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35BD1BD004;
	Wed, 31 Jul 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jpmgaa5E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D71BD501
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446705; cv=none; b=CZGLhxb7upQRssHz8iD7/AiMBZ9qKdPNbHTGtc7wwVNzrnRxHdkbIuhYJ/zIF2gT0yZz14guENWeP83iX2PPGfrUgdP5bSwhgTRkFWWJHzWkS/lB1bqoezCGIYpDQQnZ0DFdeBa1x8xQD8w2hry/mggd0tGQAuOi47Is0Aibl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446705; c=relaxed/simple;
	bh=iQu9CEXuLc6l42Svgzj+WtxBlKFzFHW7zLfsoyk92/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoeUKx041/ueESVYFwaWh6XwY0KiX4Fzj0owyZovF1+b446kYDUQcQl5DLqMBBGzzYIuJpfk6PiCB1/Scs1E1QSkSL+pp4xdSffFv3YRoQboWGvhL/Ylt7BbQvi8PFg3VjtEzCPWVrLt+gAjJ9Uptds1Fu+x/U+h5AeSAEVaGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jpmgaa5E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722446701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQu9CEXuLc6l42Svgzj+WtxBlKFzFHW7zLfsoyk92/s=;
	b=Jpmgaa5E64tfK5xOIR5ebDEhinprTcWjKOseFY683J4xXTdYyIQsL9SEQ9irlCe+CTAQi6
	fRT0nrMsgGy/HTPnuC9eK6fiTWtsFD+MqDnKAkd+miHvvbhViooPJaItvHtkYjci3y1zgf
	I0yyggaBSDDNFyC6M03KHcv15w7nelw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-7QYG4-FLMGiqndV50fVrmw-1; Wed,
 31 Jul 2024 13:24:56 -0400
X-MC-Unique: 7QYG4-FLMGiqndV50fVrmw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDA9A1944B2A;
	Wed, 31 Jul 2024 17:24:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DFFF1300018D;
	Wed, 31 Jul 2024 17:24:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 19:24:53 +0200 (CEST)
Date: Wed, 31 Jul 2024 19:24:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, andrii@kernel.org,
	mhiramat@kernel.org, jolsa@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240731172448.GB2752@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <20240731165614.GI33588@noisy.programming.kicks-ass.net>
 <CAEf4BzZXze8wRQwEJSy5nFzH=uk4wZPHY-gWw6j7iZfeBEiO0g@mail.gmail.com>
 <20240731170551.GK33588@noisy.programming.kicks-ass.net>
 <CAEf4BzYTMTNoGbL6keMhj4hRty-tw5XDeiLHOXMJxRyxZv6Efg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYTMTNoGbL6keMhj4hRty-tw5XDeiLHOXMJxRyxZv6Efg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/31, Andrii Nakryiko wrote:
>
> My expectation was that Oleg will
> just incorporate that by hand and will send the final v4 patch set.

Will do tomorrow, thanks.

Oleg.


