Return-Path: <linux-kernel+bounces-186422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995138CC3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E6D2817BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E355C3E;
	Wed, 22 May 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDL0+Mng"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3B1864C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391161; cv=none; b=iytQ4g+jloNga5A1XYNZnrFBB3GdkIc0dHI+shFTHNeSTUY6TZzF40VZnLdpLaWE89EUCfoWvY7AOmNEMdwe20QTb89cP6vZU+lUGIN1MSSGQAlohd6AqfCEf01bdKZ9OqbXMQHMA5uZ+R9sagYafo8CqRtvEn7STrRVRghGkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391161; c=relaxed/simple;
	bh=KE+pBnv5zt5vI85uRoqvndQzOv24txGQzt4kJaLXgxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j24wlAldR3iuUNlBqMgyLLVo8m0ZLATOU73SpcDT+gNgEXNrY7vbQ4LWGPz7S3PdyMwOm7I49fh+IuU60Dk6N+f69eLW0wfKReTnhYmKbDsq2DgGrqdCej9BdmnEL5QoAVQo0J69lzmSYmYXQsOPe+kqVaQkFz8aFdMgB/D8Sag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDL0+Mng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716391156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KgxuixhVGqDyCfxB1A2ol2Z4DoFFfMEDKYX2HE53EHo=;
	b=VDL0+MngEmvbxzA/j3pbmsfWpPTVHiMxGKHg0hmLyHpXV1pl++ZKbsnx10qtlscoz+6vwk
	GVwUNu+ySX4O2rGvqS/ZoegmUX/gmcDxvM8cPU80kXucwOOG0XqqnHWyuebUcVy+/ej9/U
	xcBh/Wo1wDG94M2iOzTGaI9aYY996as=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-HxHP_9ETOiGOPAEBCaa9zA-1; Wed, 22 May 2024 11:19:12 -0400
X-MC-Unique: HxHP_9ETOiGOPAEBCaa9zA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15B25185A78E;
	Wed, 22 May 2024 15:19:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.153])
	by smtp.corp.redhat.com (Postfix) with SMTP id 117C2492BC6;
	Wed, 22 May 2024 15:19:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 22 May 2024 17:17:45 +0200 (CEST)
Date: Wed, 22 May 2024 17:17:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240522151742.GA10400@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

After the recent comment 5097cbcb38e6 ("sched/isolation: Prevent boot crash
when the boot CPU is nohz_full") the kernel no longer crashes, but there is
another problem.

In this case tick_setup_device() does tick_take_do_timer_from_boot() to
update tick_do_timer_cpu and this triggers WARN_ON_ONCE(irqs_disabled())
in smp_call_function_single().

I don't understand this code even remotely, I failed to find the fix.

Perhaps we can use smp_call_function_single_async() as a workaround ?

But I don't even understand why exactly we need smp_call_function()...
Lets suppose we change

	--- a/kernel/time/tick-common.c
	+++ b/kernel/time/tick-common.c
	@@ -231,9 +231,9 @@ static void tick_setup_device(struct tick_device *td,
	 
			} else if (tick_do_timer_boot_cpu != -1 &&
							!tick_nohz_full_cpu(cpu)) {
	-			tick_take_do_timer_from_boot();
	+//			tick_take_do_timer_from_boot();
				tick_do_timer_boot_cpu = -1;
	-			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
	+			WRITE_ONCE(tick_do_timer_cpu), cpu);
	 #endif
			}

Can anyone explain what exactly can go wrong?

Race with tick_nohz_stop_tick() on boot CPU which can set
tick_do_timer_cpu = TICK_DO_TIMER_NONE? Is it really bad?

Something else?

Please help, I don't think I can find a sane solution :/

Oleg.


