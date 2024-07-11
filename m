Return-Path: <linux-kernel+bounces-248448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6069092DD49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE811F22D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14A1C27;
	Thu, 11 Jul 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7ItivhK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803463D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656309; cv=none; b=tW2VIs3Tkp8SIzv/3p1fDg1TOvKbkYa2D42dFfARjaAguWO+UwIV6MmewS+X1HLfHAPv6pE5Lhin4tGtS8WoFhz95vQ/5R8I/hE7/GoalBhiNZCE22dZSoSLJTfuausLFs/WI0GAFtvEIuTw8ZBpMWF9eIbIlz6Ef/cZnr2sbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656309; c=relaxed/simple;
	bh=hHu/IyW6x+w5vAhpJ6MC+x6jI3h1T1ET7IgRgzFkP1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6YasFMknee1nzEK2Fblztm+coRmFUhrKbwAFCtT2VfU61jKBrYcsRDjcEEL67sakvoPFEYp/rbVUA7LlKThdyLWPsWIjiRWyzt6RBTnT9+sglL6ekRvpNfycxXO1lPv01rH8AXV4O+Zxg2YbGXjSgkgvGMH7ZFAINF+6ahtPZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7ItivhK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb4a332622so1511185ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720656307; x=1721261107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhcXl9iADlsGgb8HLvc0JcuAcLtv+mF5by2xI/1b61k=;
        b=J7ItivhKaWBVDPDNQKpogjSmtcfzpnoQlDAxFucu5zuAZpoJ7sgsZkolmWibZgVhyT
         pjiUymbeTcLNZ1ZtOC7YtSkw9aJwqPsnQG/3O3d1RZsJPvqD4zvWeWOw+LOG6uF+SQRH
         00qCbLkqisPm2Lnq29fl5CjapeYYBs0576DFooAANQ2h0Y7LdefcyswpHMjT3VLJ8A11
         Yi5lDmeKt1CweGaV9ZfrbujvjCKls/QFswVls8RMrBIL0fUzDSSbt85Txc+1Zt2OD6WJ
         a9PiTFel/bNYnh7P3QAtpgi71O/Q2cfJA8ghQZXCCNfv6ogsLnmJKFG3EA39u0YtoJIT
         txhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720656307; x=1721261107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhcXl9iADlsGgb8HLvc0JcuAcLtv+mF5by2xI/1b61k=;
        b=paf0z0y52++a5/QSYm+VAKFmRxPzth3cmyfITzMM6m3jF9aR5nmkaUUnZhdrvSGzWt
         JKMsuu1jI0tdaJEgf0f/rZwP0+7irv4M6FXBKfCvIBzp4r9sXieELyVv9+RSrWSXSNZQ
         AGhjzo+o7QrE2mSrb2ZykoxjbH+ma+Af/oRazJAxcbUsxU5i0zItWiEUmtyh30Hze/93
         L6Wb0ZG2REeIJXc/lVvRwI3zKNfAZm6D85LMbhTSfvvnPJG8TpYkJNHQ+FToCcwf8FbP
         K6uw8Yo8MPiQ4IDjowNTrJdyEkZXOpdGl7M8iabnryzXskrv/hyhE63dHpPc2PBeuX56
         V8sg==
X-Gm-Message-State: AOJu0YyR+b0cUYm/uHAaibfOQ8GNaeo2g+zbUOEdHYlt8AemYNbvv5Gl
	81z6Gz/IKCJP7tMIBksq40zUuOIGvXokQN3Ki3+5SIL4mDuThizL
X-Google-Smtp-Source: AGHT+IGcdq1ukj54eLusut1EYwIc3uLVIOvzbXWpk2uI5InHJr+QAtjdhXPyk3FuyJv93ncd7AaZZg==
X-Received: by 2002:a17:902:f546:b0:1fb:8620:c0c3 with SMTP id d9443c01a7336-1fbb6d251edmr62737135ad.2.1720656307164;
        Wed, 10 Jul 2024 17:05:07 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a10941sm39022245ad.30.2024.07.10.17.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 17:05:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jul 2024 14:05:00 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 6/6] sched_ext/scx_qmap: Pick idle CPU for direct
 dispatch on !wakeup enqueues
Message-ID: <Zo8hrMWVw4VEIkkN@slm.duckdns.org>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-7-tj@kernel.org>
 <20240710192523.GF317151@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710192523.GF317151@maniforge>

Hello,

On Wed, Jul 10, 2024 at 02:25:23PM -0500, David Vernet wrote:
...
> > +	/* if !WAKEUP, select_cpu() wasn't called, try direct dispatch */
> > +	if (!(enq_flags & SCX_ENQ_WAKEUP) &&
> > +	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >= 0) {
> > +		__sync_fetch_and_add(&nr_ddsp_from_enq, 1);
> > +		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
> > +		return;
> > +	}
> 
> Hmm, will this be a typical pattern for how this is used? I'd expect
> ops.select_cpu() and ops.enqueue() to quite often be nearly the same
> implementation. Meaning you would e.g. try to find an idle core in both, and do
> SCX_DSQ_LOCAL_ON, with the difference being that you'd just return the cpu and
> save the extra lock juggling if you did it on the ops.select_cpu() path. Not a
> huge deal given that it's just an example scheduler, but it might be a good
> idea to try and mirror typical use cases for that reason as well so readers get
> an idea of what a typical pattern would look like.

scx_qmap is a bit special in that it wants to be able to skip n'th tasks to
test the stall detection mechanism. We can't express that in select_cpu() as
not dispatching in select_cpu() just means that enqueue() will be invoked,
so it just funnels all tasks, even direct dispatch ones, to enqueue(), so it
looks a bit different from other schedulers. scx_qmap is mostly used to
exercise different code paths and is rather messy for anyone to use it as a
template. It'd probably be useful to note that in the comment.

Thanks.

-- 
tejun

