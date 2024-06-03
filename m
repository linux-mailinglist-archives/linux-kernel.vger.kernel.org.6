Return-Path: <linux-kernel+bounces-199379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E228D8643
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844171C215E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7DA131182;
	Mon,  3 Jun 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMPpivgB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB87130A47
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429398; cv=none; b=o8NtzwHugUO4EN/7EqdbG+Vtg5WxQvxYPOGr5sL51QbK9LP0Jgss9NP5yNNXoJCK8bCEzOUpKfyB1tcvgY6+x9Z2kLqL/uwVF3XLuHi/cmUWuoS1ImgsZUvOMHAbT59U7a/oNo+sBiinbFcDG4A3+04zWvG6LZLbZoMiARvsTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429398; c=relaxed/simple;
	bh=nc1q9g6/yaNinjXpHmVTBpup+b4GNWrTy8UsznWyeVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5/WrtKa68KVrv3DlHIGX8adEVquYlYEQPDPaOq47wYdgh0XD7pLzGlcuHwP/s3b8zWnWASj9/9/MHbemRmVjCKAmHUNyvD0LzBOMj7Aq8rfE0lgYhcvdjn0G52RPWMKBOuTfsg+d5ohiCThlETQkKRzyzKviUypwmrAfLkRogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMPpivgB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717429395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nc1q9g6/yaNinjXpHmVTBpup+b4GNWrTy8UsznWyeVk=;
	b=IMPpivgBPKOLw0Qhycb1gM6CJG69SAuyjnSMF23OvrJQ3AHEDNVP2JQcEl6Fs753yMqlr1
	vO1ds8LJwmlWGSvMOYn32HqtWBG3HuYAZgi/LFasAhXiPds2GGOWLCvGiTj/jw/A/ivoD/
	QGVBstUxUFx8is7VGzlS9/WsXUXuqXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-1-oRNQjjNoK87_AoLLWbIQ-1; Mon, 03 Jun 2024 11:43:12 -0400
X-MC-Unique: 1-oRNQjjNoK87_AoLLWbIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 046DD18188A1;
	Mon,  3 Jun 2024 15:43:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.103])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0FA311C0D101;
	Mon,  3 Jun 2024 15:43:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  3 Jun 2024 17:41:41 +0200 (CEST)
Date: Mon, 3 Jun 2024 17:41:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz_full: don't abuse smp_call_function_single()
 in tick_setup_device()
Message-ID: <20240603154133.GC388@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
 <ZliSt-RDyxf1bZ_t@localhost.localdomain>
 <20240601140321.GA3758@redhat.com>
 <ZlzkJGPEIfWC3Ue1@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlzkJGPEIfWC3Ue1@pavilion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 06/02, Frederic Weisbecker wrote:
>
> I guess the static version above should work to remove the ifdef. And yes on top is fine.

OK, I've sent v2.

But again, I won't argue if you prefer to keep tick_do_timer_boot_cpu and add
WARN_ON_ONCE(tick_cpu != tick_do_timer_boot_cpu) before WRITE_ONCE(tick_do_timer_cpu).
In this case another patch makes no sense, I'll update this one.

Just tell me what you like more. Sorry for the chaotic emails.

Oleg.


