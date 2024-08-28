Return-Path: <linux-kernel+bounces-305127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F999629D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81052286AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE9189B8B;
	Wed, 28 Aug 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XojhfzD7"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415F189513
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854175; cv=none; b=UJ5AzMu7ALy+EIzkDQx9Dt/+kK0hTtoTCddO4dnfRuu8hldULS6lrcBkfdCr2oocmC2+mJjEtYcIQuuQmt/OaBiArHMFcpQBHRj/FOjkfWcnTYaCY9rqWMhYh46w9vqbGUyQ5ERrZtS9geuW2bGv0LT8gbo86ihb+tw9QYn7ij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854175; c=relaxed/simple;
	bh=Ks5Bomh9T0NFTpgXt/gOr6En3ulnKIv6Hkpx5JLPDAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3h+aBDVehv0jAsrr4/XD++sf9KmTUKEJC4o3zV+IIRWSUle1lX9KuEk/h7JyJEeLw7aDBBHD9UhVUR+Zel5g62S0BMICyVt5hSkS6mcz0oIfMvoS3tQzEJUA9Ee6CBPKVO5WfxBwpTHTyUNGNG4bjBNhTi8wnA23xUqU6tvf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XojhfzD7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141d7b270dso5198737b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724854174; x=1725458974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pu5bwQiUwEdugFDcEXhTI1L6/mqdQCzI8zZqkqlm2tg=;
        b=XojhfzD7Ic1/7pEMXzv05/VggHdDZ963NUGiyZyvOuudtkH+3S65Yr6Nc+WCgw7PYP
         8YbdW/OsJJUOg7hVmnF9lLqOwsLmwYXeDJTSnD5yaJkWX3zOc6nV2HQDWgE4wbXT00rb
         1QRECYRy1SNAvPsfJ4s45zvuJ5lJHp89k/0TrV79BLuGM2nvJgXUauLXg9kQ5S/k9hei
         qHzkZHJZfjy7Gr/hiILEQ5p4GKZIE8zveAMi/2vYNO/Z8VRfqwtgPbDRC2BnWK9YE1ko
         pefh29AGLcrmnyRKQTEr2RkvWjdOVmPvxDroWsiSf8rsOGFVnafUnXiWMc/K3IHUWvgg
         zLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854174; x=1725458974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu5bwQiUwEdugFDcEXhTI1L6/mqdQCzI8zZqkqlm2tg=;
        b=bQLYZmauBCdeJmkJIZcgvmhHJc5JOvWn5FF7b1g6BaherzMqewW1wESvtHCLJA77Lp
         G+rZQmqShYcncFO7tTrs7xRmuf0n9iGl6+f+waXqkTL/ymKnmULecxKHJzXC6Vt3AA0d
         fr8w+Gv0HMLOlzoUdQnQgQCQMQAt9vX9vINyI1I19xs2+cIj8TuSGUDff6pthSdHKid0
         NxWY1AGGwaR27zYRrH1E9WqCQkeK9tD4vh57J3CpD03c9e/2HJjJ1Ys0SGX/AOkcCMtp
         irT+MRn/Hhb8qOPbo37DZkFqEUvaMDTyArTZ+vgueZbb+/xLXoUIBsms/6PPGYWpgr91
         ub6Q==
X-Gm-Message-State: AOJu0Ywn/HDdpo48Wnq4v1iorPVrpUUGpMHXIirS/eKt01QjZxstDnXa
	+GoBqz+25nnS4kqZieKpckrMYRPP356s/4VugK90ruT2Fc8f6v9JvE1R3aMa
X-Google-Smtp-Source: AGHT+IH1qGlldcsEniTWrrNUljVac/zC3t2lfcKQp5wHh4CIjRUWBehFRF9i4FPYXDFXv0PofLERIA==
X-Received: by 2002:a05:6a21:58d:b0:1c0:ee57:a9a3 with SMTP id adf61e73a8af0-1cc8b5ddfe6mr16696657637.35.1724854173765;
        Wed, 28 Aug 2024 07:09:33 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ed7esm10163250b3a.6.2024.08.28.07.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:09:33 -0700 (PDT)
Date: Wed, 28 Aug 2024 07:09:30 -0700
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Leonardo Bras <leobras@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2 0/2] sched/topology: optimize topology_span_sane()
Message-ID: <Zs8vmpwY2Dt9s0Ei@yury-ThinkPad>
References: <20240807190522.432388-1-yury.norov@gmail.com>
 <ZrzcozFadC5xQdUq@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrzcozFadC5xQdUq@yury-ThinkPad>

Ping again?

On Wed, Aug 14, 2024 at 09:35:04AM -0700, Yury Norov wrote:
> Ping?
> 
> On Wed, Aug 07, 2024 at 12:05:19PM -0700, Yury Norov wrote:
> > The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> > even when cpu != i. In such case, cpumask_equal() would always return
> > true, and we can proceed to the next iteration immediately.
> > 
> > Valentin Schneider shares on it:
> > 
> >   PKG can potentially hit that condition, and so can any
> >   sched_domain_mask_f that relies on the node masks...
> >   
> >   I'm thinking ideally we should have checks in place to
> >   ensure all node_to_cpumask_map[] masks are disjoint,
> >   then we could entirely skip the levels that use these
> >   masks in topology_span_sane(), but there's unfortunately
> >   no nice way to flag them... Also there would be cases
> >   where there's no real difference between PKG and NODE
> >   other than NODE is still based on a per-cpu cpumask and
> >   PKG isn't, so I don't see a nicer way to go about this.
> > 
> > v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
> > v2:
> >  - defer initialization of 'mc' in patch #1 @Chen Yu;
> >  - more comments from Valentin Schneider.
> > 
> > 
> > Yury Norov (2):
> >   sched/topology: pre-compute topology_span_sane() loop params
> >   sched/topology: optimize topology_span_sane()
> > 
> >  kernel/sched/topology.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.43.0

