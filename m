Return-Path: <linux-kernel+bounces-344494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BAA98AA68
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97FE28217F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D7C194083;
	Mon, 30 Sep 2024 16:56:52 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423719342B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715412; cv=none; b=KuBmm7FtagIHTTOCdQMgHIwEjJ/zNYIQuFN3tINBZwLr9v8QakItBBthyxThXMMW0yqopbQGZZvRgUs1Y7ZSe2DS9JDwHf4g+gWU8emnzvB+cwgjfbTsZCD446JHgKjNs5+c13wxRr6bRr3bRiFW8c985EyuYQmthFRr9F1ki08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715412; c=relaxed/simple;
	bh=TSSCVuIXDgUDXIo5a1XRlsmzL/J1au6xiOSzYgwgknI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+BoaF4OFk1B3G9GtGH02G+YybumdDSp2e7IoKQpuxPyXVA3Q9Jsg7eyK08fupLp5hgAdkyJnW33PL57agMLTdZ/IolhypBUv2f8YHO3AzLzGGB4SshmtT/RiyhDvJM+Z+8bARE5QeMAZ6W0vdPbNNpdT9KgeOW6ZvDIxY2Pp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so6436186a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715399; x=1728320199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR7Ohc10cZr2a9t4ar4tQwRmc+z2Cx5HDkMXYIV5zug=;
        b=Z4xGK4EFzZPO8EwlATAcXDRJ2vwPq0QX3b2O3zdAmXPI8Wy5YPQymIvfOBBZ1it2Ue
         3Ln8Law2kdkzXF10Donvu5Vw+DrejO+2Fvj4baNUyL+Bs2rEamSGyLBD4qBmII2/e8av
         E6AohioeUC0BWjoXlhl8iIaALP7z6wp4l7hF198QQT7t4Ar2C3i6QHTQYMvriOuMKEqm
         Xy85AHK60yupCsdbAHxr2tWzi5p9S4IpgSpdH/HRJ3Yf6NqjvrM8Mg3qi9270QCQHKjR
         MCBPlW1fXDB3Q1+hTdWfauv3+4oRfj9vSWg+rJFLn5CaJKehu28TYe0FQBZ1dSMquJju
         FgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvCC3zq6wkwlNlC+RcryFsh5w1PoLeHtangT3X4n9tkNRrsegZ+e694BhY5hPPk+m96UXDOZc943ZT7hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9m/8rq208uVvfocIrXTR19ZVbhQm/F6ZUTD3IGJoagiomLR1
	Cv0reB4rsfGF9RGjLqoKJ2a8FQkVKqn1D6LBkYKeAgomQwoTe6rG
X-Google-Smtp-Source: AGHT+IFT5lSSyLl5l0J/y2iBnFVJMIUy4YuJd9RKXtlwDquxQ3os0zMhBMm5KXWoNiWp71QQSB6ekg==
X-Received: by 2002:a17:907:d20:b0:a86:82e2:8c6d with SMTP id a640c23a62f3a-a93c4aefc0cmr1513857166b.62.1727715398419;
        Mon, 30 Sep 2024 09:56:38 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bc6fsm551646666b.184.2024.09.30.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:56:38 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:56:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 6.12-rc1: general protection fault at pick_task_fair()
Message-ID: <20240930-furry-snail-of-promotion-1764e9@leitao>
References: <20240930-mysterious-meek-goldfish-2f851f@leitao>
 <20240930144809.GI5594@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930144809.GI5594@noisy.programming.kicks-ass.net>

Hello Peter,

On Mon, Sep 30, 2024 at 04:48:09PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 30, 2024 at 05:52:49AM -0700, Breno Leitao wrote:
> > Important to say that I am also seeing the following warning before the
> > crash:
> > 
> >  workqueue: drain_vmap_area_work hogged CPU for >20000us 4 times, consider switching to WQ_UNBOUND
> >  ------------[ cut here ]------------
> >            !se->on_rq
> >            WARNING: CPU: 24 PID: 17 at kernel/sched/fair.c:704 dequeue_entity+0xd21/0x17c0
> > 

> This looks to be the same issue as reported here:
> 
>   https://lkml.kernel.org/r/20240930144157.GH5594@noisy.programming.kicks-ass.net

Ok, I though they would be different given that it was crashing at
update_entity_lag() and not at pick_task_fair(). 

> Is there anything you can share about your setup / workload that manages
> to trigger this?

Nothing really. I have a test system where I install a debug kernel
(with some DEBUG+KASAN+LOCKDEP) and keep the host mostly idle, when I
hit it ~2x a day on average.

PS: I have the crashdump if you need me to investigate anything.

