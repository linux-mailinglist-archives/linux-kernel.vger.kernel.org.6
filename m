Return-Path: <linux-kernel+bounces-229869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4060E91755A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC88282DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DE8C05;
	Wed, 26 Jun 2024 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZurM+FS"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74604C6F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363173; cv=none; b=hV8QzZ1N+qaFix9gLnmM6b2UqDBQbs739szwSxbYsl5R4ppJMjQ9kDAqY9m3z6Y/Ljzv93uxrpHwAQGEv3OjJoN6ftbbs6CfShPsPazSs5JbUE5VWgH91+L0klCBcTCaJFaymFij8TRHHykw4dHSbpvTGnJgx24r8HsH8xSAqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363173; c=relaxed/simple;
	bh=rYDk2vxssouHVnqxPOJdg9O2bH/DuWjARU9ybOrETzY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JqxNB6TRWLXSGcbjcw8AAd7plNLYjuI4X2Z4rsqc2gtNwKQAydz8Mblnh8Et4eWYCfMcy0NdT//UisMRMuAMbTUPkgSvSZSAXq8qFsjNKmf2k0xXwX7p0VgwNSufXbPCYPedFAH7snlSIWePnfTCDxVjCQ7d6ik0tfWZrOcLRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZurM+FS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-71884eda768so2859821a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719363171; x=1719967971; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UvXLBMqi2t4pTUZ6x+fhYXYNjgVj0iVDglj03OeJQU=;
        b=gZurM+FSPnFclimhk/VCnlee19g7KETcyNyu0wDkyOLSRaAXtd4zcb/o+R2VJt7mLl
         +l9BX1rbockAaH91VPuYrWlhLhDJZKdT1X6Veppf3LCH0X8vTAqVgNRuMygnrL9QGN6i
         dz9gnCWAfQb+EGuZZZ9YPVbiMYOcnMNsKxJRL+1mzqTVhxUcfDFUo2OiO35wo7dit5jb
         NPVzec837oTrd5yYZo164ot5GUltAzjXftcHJAGfd6PP1dmgndVjoui4SewKlTluDjEa
         qvix/av8M9/lovv0ZaKINkm0m+OQWY0a0wlQzo2Us4a2Yy4rxtNioGGMXnsHJpo76orL
         sJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719363171; x=1719967971;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+UvXLBMqi2t4pTUZ6x+fhYXYNjgVj0iVDglj03OeJQU=;
        b=OaMmbTXQh14qHwQGaDzIUlZ8xprqgQc5koMytdLBZtWUxP4HtaO+euFvTs3UzgQrjf
         AsX+gQiZ0aIcJpUIgMmX3UomUDcbCVgjgcYNToWS8qWJcfCzcar0T+UKimtUCxF+Furi
         vA0/X6RHe0jahdJVt46rV+4K3HT7WDT7h1Fuzi3ehgXRwMzIQcFDVfic8eP51hCEp39P
         Rum6avtFEE/obioymBYX8XNSMbKcGNs/S+rR5x+LDOqsu/diM4Ox9i6EVxxy64WTwQwV
         0BNn83HWhyYSLKtAo4tw4u724D1khwk6cZL3XKdhSLGL4C61dtcAjS7725azy7SCBXAS
         1v2A==
X-Forwarded-Encrypted: i=1; AJvYcCWLy21senMNegh+FiLF62BPDWJESzPbhbZt/iVsuVZ67EmAEYGxDVhsp3gwuJPQJyptSTNz8qVxcsrYK5te7Ebzsa4DhwaGFncjbYQt
X-Gm-Message-State: AOJu0Yx7quOE//QT254ijcgnyeGVVlxPAkiNWHIoCY/06CgO2bFCvfiQ
	GODDfif+A31PbaT20xV7rH8g68FLbljNKB/rAmCUEqyIA45egCMs
X-Google-Smtp-Source: AGHT+IGI6pSOLAue3Bo6/qvw9F5Vby4Oe2ealYdgKzq2ORApGm8WCuGCOswyfyh7vZmnBI6Y1Od4QQ==
X-Received: by 2002:a17:90a:fa96:b0:2c7:bade:25be with SMTP id 98e67ed59e1d1-2c8612a2294mr7606525a91.14.1719363170749;
        Tue, 25 Jun 2024 17:52:50 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d806140csm259550a91.33.2024.06.25.17.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 17:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jun 2024 10:52:45 +1000
Message-Id: <D29JDHZSVCII.YCP01SIB9FYA@gmail.com>
Subject: Re: [PATCH 2/4] workqueue: Improve scalability of workqueue
 watchdog touch
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Tejun Heo" <tj@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Lai Jiangshan" <jiangshanlai@gmail.com>, "Srikar
 Dronamraju" <srikar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240625114249.289014-1-npiggin@gmail.com>
 <20240625114249.289014-3-npiggin@gmail.com>
 <Znr2_fjb1UY-Rakp@slm.duckdns.org>
In-Reply-To: <Znr2_fjb1UY-Rakp@slm.duckdns.org>

On Wed Jun 26, 2024 at 2:57 AM AEST, Tejun Heo wrote:
> On Tue, Jun 25, 2024 at 09:42:45PM +1000, Nicholas Piggin wrote:
> > On a ~2000 CPU powerpc system, hard lockups have been observed in the
> > workqueue code when stop_machine runs (in this case due to CPU hotplug)=
.
> > This is due to lots of CPUs spinning in multi_cpu_stop, calling
> > touch_nmi_watchdog() which ends up calling wq_watchdog_touch().
> > wq_watchdog_touch() writes to the global variable wq_watchdog_touched,
> > and that can find itself in the same cacheline as other important
> > workqueue data, which slows down operations to the point of lockups.
> >=20
> > In the case of the following abridged trace, worker_pool_idr was in
> > the hot line, causing the lockups to always appear at idr_find.
> >=20
> >   watchdog: CPU 1125 self-detected hard LOCKUP @ idr_find
> >   Call Trace:
> >   get_work_pool
> >   __queue_work
> >   call_timer_fn
> >   run_timer_softirq
> >   __do_softirq
> >   do_softirq_own_stack
> >   irq_exit
> >   timer_interrupt
> >   decrementer_common_virt
> >   * interrupt: 900 (timer) at multi_cpu_stop
> >   multi_cpu_stop
> >   cpu_stopper_thread
> >   smpboot_thread_fn
> >   kthread
> >=20
> > Fix this by having wq_watchdog_touch() only write to the line if the
> > last time a touch was recorded exceeds 1/4 of the watchdog threshold.
> >=20
> > Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Applied 1-2 to wq/for-6.11.

Thanks Tejun.

> I think 3 and 4 should probably be routed
> through either tip or Andrew?

Yeah, let's see if it gets any comments.

Thanks,
Nick

