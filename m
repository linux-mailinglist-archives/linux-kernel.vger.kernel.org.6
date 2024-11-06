Return-Path: <linux-kernel+bounces-398591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC99BF335
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF111C221C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05037204942;
	Wed,  6 Nov 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mENS4AsN"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91E1DE2DE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910507; cv=none; b=pMNoeFsqZaQ9necL6RfrpR1HZZgbq9pAvb/66d6J63Rh92HSl2kLOjfi7IVJnf1qawyy+SR8THm7p+M00RXwdQP2KUTPRBEY7baZjpcoGdP5r+3Oln13arvY0Z0o5BXBi+qY+25zCQhZaRwkU8dIfTHEee7XNs7ETVWHzCCKfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910507; c=relaxed/simple;
	bh=4tsbpW+sXL68tP1yxEm0W3H56/gq/Dn8TFBfcJk/9aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvDYEci/iCLkqlIRkS+b33x7rBg2AHLkpyKuuBpUpBA+MQkuCimFvutIeKGopikbJi+uKqZ0V2w5ahHxgG/IAWTnDWLkJFYZ/yhVAO+UzBSCuwCch0yXB5fSfMq/ZIdB63shzKZQwtIHXS1tLyY6M3JpRXD9y5JPpW0ewQo7UZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mENS4AsN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cbca51687so66249845ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730910505; x=1731515305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjyDbWO2SgSlVVdlEVRu9YDIPFqK70sjzvuli6WSucQ=;
        b=mENS4AsNoZvKeMh9GzNvky8PvX4O0SMJhOi810O4ggjKEvgGeet1fIhEm6wIm1JHBP
         jXBacqi5dv/5VzgE/AOKEOOoaeaP/LAqJZSmTVQCabzSpfpS8kF/+QddLlRS4kWF9ugy
         1WPbDy+KVmHit43KsCZmRAsTFVkMKbGbD41SU/+zXvYNIcSiO/b7Vv15VE1AqmSLSAlI
         9dNZIlCzlE5vVb46PD/oY0Q3+uJUaCMVt5OpG2c6Pv88Luz012FuREWg0mpkRAvbxoRZ
         Nrg6vDL8HL5bV1X2BWf8T9GbyB0l6ykm0WkzVabfrXhOZwdLFd3QjjyWvPmj5KplUVda
         Lemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730910505; x=1731515305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjyDbWO2SgSlVVdlEVRu9YDIPFqK70sjzvuli6WSucQ=;
        b=UuAK+LlpYDx4N4yXG17/1vp3/4wQH6AxYKlKHPxxZIGqntn+yTigp42WBlvtLDo82p
         9j7CglwceEpaRqIZ7vUjBbSHK5hdFWF5wgyhgKaqDmuvFGAFiMsNcZAvc2AMoEgZQWhN
         gZtAKW9UApcwiiknJXAohWqFKdAWlYBWAsE8r9seTzhk/1TgUS1mPaovYrLVby37pNG6
         I8Ao7TMER+Bm2a6kOoU2fy3T7vv5ELCW0ww5MiKq6ejSQl3McivgjkpNo89qxoAMl1BG
         HZt72NXrOxLi8GGkC0EMI/pPbNm7sZZooiCVpCaKGBohm4g7WvPDVzPzEeadGmqRr1vT
         gXpA==
X-Gm-Message-State: AOJu0Yzclqgg+i/+VA9lnom7s3GgY4oo8+ykvAQTUUD0jTTJIum7xkdZ
	AbwhdzI/oTJuKQRhhEOSzDVQ3BIjnzsiCLguV54ZEuehmTa9nL/oU05/fwHJ
X-Google-Smtp-Source: AGHT+IH+VfMbKfQIeuHFwYqo48AtvLWhW4v6Voig9VhP6XG9iGE8ZUMVnATN/dt69gQMUldZaMlzOg==
X-Received: by 2002:a17:902:eccd:b0:20b:59be:77b with SMTP id d9443c01a7336-2111aec8329mr273596755ad.6.1730910505309;
        Wed, 06 Nov 2024 08:28:25 -0800 (PST)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2475sm97345495ad.129.2024.11.06.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 08:28:24 -0800 (PST)
Date: Wed, 6 Nov 2024 08:28:22 -0800
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Chen Yu <yu.c.chen@intel.com>, Leonardo Bras <leobras@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 0/3] sched/topology: optimize topology_span_sane()
Message-ID: <ZyuZJoD4hKa3hIvR@yury-ThinkPad>
References: <20240902183609.1683756-1-yury.norov@gmail.com>
 <ZuW_0fMfPSix4qqX@yury-ThinkPad>
 <Zvr4s9ErpD9F81YH@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvr4s9ErpD9F81YH@yury-ThinkPad>

Last reminder. If you guys don't care, I don't care either.

On Mon, Sep 30, 2024 at 12:15:02PM -0700, Yury Norov wrote:
> Ping again?
> 
> On Sat, Sep 14, 2024 at 09:54:43AM -0700, Yury Norov wrote:
> > Ping?
> > 
> > On Mon, Sep 02, 2024 at 11:36:04AM -0700, Yury Norov wrote:
> > > The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> > > even when cpu != i. In such case, cpumask_equal() would always return
> > > true, and we can proceed to the next iteration immediately.
> > > 
> > > Valentin Schneider shares on it:
> > > 
> > >   PKG can potentially hit that condition, and so can any
> > >   sched_domain_mask_f that relies on the node masks...
> > > 
> > >   I'm thinking ideally we should have checks in place to
> > >   ensure all node_to_cpumask_map[] masks are disjoint,
> > >   then we could entirely skip the levels that use these
> > >   masks in topology_span_sane(), but there's unfortunately
> > >   no nice way to flag them... Also there would be cases
> > >   where there's no real difference between PKG and NODE
> > >   other than NODE is still based on a per-cpu cpumask and
> > >   PKG isn't, so I don't see a nicer way to go about this.
> > > 
> > > v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
> > > v2: https://lkml.org/lkml/2024/8/7/1299
> > > v3:
> > >  - add topology_cpumask_equal() helper in #3;
> > >  - re-use 'cpu' as an iterator int the for_each_cpu() loop;
> > >  - add proper versioning for all patches.
> > > 
> > > Yury Norov (3):
> > >   sched/topology: pre-compute topology_span_sane() loop params
> > >   sched/topology: optimize topology_span_sane()
> > >   sched/topology: reorganize topology_span_sane() checking order
> > > 
> > >  kernel/sched/topology.c | 29 +++++++++++++++++++++++++----
> > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > 
> > > -- 
> > > 2.43.0

