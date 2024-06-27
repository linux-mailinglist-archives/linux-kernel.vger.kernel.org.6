Return-Path: <linux-kernel+bounces-231863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCB919F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966401F22386
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947C41760;
	Thu, 27 Jun 2024 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CtwiQNVm"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217620323
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471246; cv=none; b=njJFa0H9yNfy6MUIyD55Hajo+N05Uhv05I44EK1FmFk4EqItIGvka2+Ajgy8bv9bjeaUFiVDUKKoTlpkeWkjcFMQnb5jpG23ASdFJNzGGPf/6zqh7yDWgKTOHAGf/GAPvaPOsjdFUMPNTPN2vRInc+YYaGn5ZWn9nWCL1CmFxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471246; c=relaxed/simple;
	bh=wSDiMlGdvUeLj4IyYRu+CYeChH+JzxF6qqrXgXCCmIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adOQnfzifcDHO5B9PcLKZAYNVYBNVX4i8gIxxdBM5YbyCjMjFzxgHL7zyVat1BN07lF9BJQgOOky9cC6xC2YMhduh7aAo0Jnj0nhvVl63qnx0hMm+K6+gmNQTKnkclQscBYyDiZC0EnDey6ARpIJlGZuvfr9wGqBb6b8dadyDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CtwiQNVm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso857720266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719471243; x=1720076043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjuNH7+efJzV+dg6mfZmvOh7V/JIoCd0Ef6jayIJzPc=;
        b=CtwiQNVmhu6UB1AARfvtuBwOajePKkBUIXYLgoyExsMRAEr6xOF/06Q2d/1LbNqrqa
         qJlxyFdaurVaqNNyB7r/hPkyhcRDd/1WD7gnnt6f+Ff2ZK7PTPprL5Fh/4jzJj18WUgQ
         vhTrP7dnMyyDJa8lmitJC6/jSK94jIRNACjQSZrpLtaUR2C47V5gm3V3cTbUmjSIHuHw
         nOb/tT9L5VmgLuALI3pf3Uvq8dxXBpx6obxYjSkcBbJ9P7Muh26ezP7WlUKbMNFQaj/w
         I1cProxQYjRQQxeQz360HpQcWfLjngefZFDrdlW9DO2oom91QmCS+7mGb+74sA/wOH7g
         3TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471243; x=1720076043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjuNH7+efJzV+dg6mfZmvOh7V/JIoCd0Ef6jayIJzPc=;
        b=Xg0MiDllFC2AYw2NOrf7uxMbOi7vhuklnArWVXIKGcIUqO2QcooQHV73NDgyJL6GDu
         7p1o9Aymziwi3Yi5hWVYOGP0DTGUBmD6iAOUqKnQp44kcGrOAJxPOmko2DUF/uRkUQOe
         2hHyT/y/g9G7WqwhqZJ8KWxfeGtdrbM9vaPuWIWQlzhPsOA9sOml/WuFwZgW4Wr5nMrj
         TPssNP4cUq7XVlkR+NklZxN4PBosUcGwy5HD8uWc9oB/Z1PnFLqPFcSO8zwycZR2IPkg
         mzTpSOGuUqE6G7Rh7WayyVtc3DTsHTCwzizfnALfZ+GO1Tg0QVpoZ6CXJ8er4qfn0wi7
         RptA==
X-Forwarded-Encrypted: i=1; AJvYcCU1ZVmZSH7AufE72pqJJFs16y8x5Ew78rbTiBg15cGTV8mMl4uw14lUp7soSy/ZDZIECL09+H8xYVYzZzuL0romQyYI65EGkqtY9RQ5
X-Gm-Message-State: AOJu0Yzpmx0Co+G7ToG5LgwAEiwfFLJs0Q54cgohug30ggSgH0U4sGDf
	z+sxXbR1fNM//tQvRCscnbwOfa19J6gZBdKesLavqbKeTJ8RJBTG6x84rYAPeCw=
X-Google-Smtp-Source: AGHT+IH1leSP5D109mn21nFySvU6OY4kl5vHb4xGU7daK5xe89rAw93aQ2i/tRYV/9Xn4gXSzHs6cQ==
X-Received: by 2002:a17:907:d404:b0:a72:48dd:46a4 with SMTP id a640c23a62f3a-a727f3f2942mr450399766b.0.1719471242955;
        Wed, 26 Jun 2024 23:54:02 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d6fe07asm29976366b.28.2024.06.26.23.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 23:54:02 -0700 (PDT)
Date: Thu, 27 Jun 2024 08:54:02 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 6/6] mm: Drain LRUs upon resume to userspace on
 nohz_full CPUs
Message-ID: <Zn0MittvTWJm_bIN@tiehlicka>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-7-frederic@kernel.org>
 <ZnrSEf1xuFxKxj1D@tiehlicka>
 <c9c86312-09f6-4e03-8934-f5d7e8b36c81@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c86312-09f6-4e03-8934-f5d7e8b36c81@suse.cz>

On Wed 26-06-24 15:16:04, Vlastimil Babka wrote:
> On 6/25/24 4:20 PM, Michal Hocko wrote:
> > On Tue 25-06-24 15:52:44, Frederic Weisbecker wrote:
> >> LRUs can be drained through several ways. One of them may add disturbances
> >> to isolated workloads while queuing a work at any time to any target,
> >> whether running in nohz_full mode or not.
> >> 
> >> Prevent from that on isolated tasks with draining LRUs upon resuming to
> >> userspace using the isolated task work framework.
> >> 
> >> It's worth noting that this is inherently racy against
> >> lru_add_drain_all() remotely queueing the per CPU drain work and
> >> therefore it prevents from the undesired disturbance only
> >> *most of the time*.
> > 
> > Can we simply not schedule flushing on remote CPUs and leave that to the
> > "return to the userspace" path?
> > 
> > I do not think we rely on LRU cache flushing for correctness purposes anywhere.
> 
> I guess drain via lru_cache_disable() should be honored, but also rare.

I do not think we can call it rare because it can be triggered by the
userspace by NUMA syscalls for example. I think we should just either
make it fail and let caller decide what to do or just make it best
effort and eventually fail the operation if there is no other way. The
latter has an advantage that the failure is lazy as well. In an ideal
world, memory offlining will be a complete no-no in isolated workloads
and mbind calls will not try to migrate memory that has been just
added on the LRU cache. In any case this would require to document this
limitation at least.
-- 
Michal Hocko
SUSE Labs

