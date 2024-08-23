Return-Path: <linux-kernel+bounces-299622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D377F95D7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A8B21E57
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA4192D6B;
	Fri, 23 Aug 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjAbOOgP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26334192D76
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444094; cv=none; b=IQN1N74zTpQqi0QWIpZ0a/gaqveT4glBINV7TLbKD+iCaPHjIgHTfdfj+YKRw9xuOgc6othniq9RpWm0zH++BD3Q5oHP6YptJ52rA8KMF370F1lpiB26uKIp2FhZdL4suGULf6mnKNgn+RRBMls/xGQ5P/7oBTTdHSXDUz989m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444094; c=relaxed/simple;
	bh=+Vm3qvk0NHvRMc87oPOrkYfGOmGZxU4opat5zBcurtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvfL4LLLuIWH7jNbczvyFA0b9UC3dVSdwxpotnZUs66YvFrntQWWOQyiLi7HhO8baOm4jo4FrrRwcO27dV7KFxbSOvTn7Wn1vcTJS/17Mf4y/7uUsiYyFqGJrkDYnnqsoWID3ZChx2Am5byKBx1jpFAeifTSPIM44Ft/SOHFKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjAbOOgP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202508cb8ebso17255135ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724444092; x=1725048892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYQzSMz6zS5VJiOY1cNxgEf0zBFVgF3RmEdhGw7bsks=;
        b=hjAbOOgPXodXRFQybGGxu74i7+oi+GIppYHvy7jzsoRkLIWdC4H+PkeNESmE6UU5Qv
         X6LukHB0m2gSpse1SxgUZma9hZIresuUVKOyvRqG3b7L+xfwMzZrDsiFLukYsPhfzEz4
         rsPa5MKfjSHcnzas/tbFMW/WWwcnZ92YFKgObkFW3iRhI+CbnSwFbl/ISBk4KtDpzXNz
         /8vtiZVqKK1kgvNB9rHktlxwNRAKsu1vc6q+mXZXoVI9ang0MeOsrhJvdinYhHUDIVoW
         KL/kJmakVxRgi42sYcgiOphjfCiuKYJtfgWFpdDvZo8hH4lRHrcdugJlD8klrfcam8nx
         OcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444092; x=1725048892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYQzSMz6zS5VJiOY1cNxgEf0zBFVgF3RmEdhGw7bsks=;
        b=seNBDmKhDtScSW69z46dYcjK0e8hDTT4u1ntEP1rrZx1epOhTF70mcBotgEHAPEWmr
         lbrWe07IN7+4g686cyfrRv5mMcGWFVTEKnG27qe7Eit5CcO/UmfqCHycX4fAxtV6H2IX
         f+59GHWbJCEnn3mpJmuvgUqSBJ26kJf1F/AzN+gBNg74JBd1slKYMWQ10CFYK99wQP45
         hWEriKOWStBEjt3ywnXKigvsOfK8I4k42E7YhEd6C826+q+vJcikqoBNTNI0G8GNiTQE
         8XpjJigBEHZQvtXchyPpQOhJ8GvxndByUCAVGoUpgwDre7/4TMNnl9wdCQD20nlbt5Mm
         hY7w==
X-Forwarded-Encrypted: i=1; AJvYcCU9hODDEbJGYcDz8rZ+NUnTBw62jCian9mMll3Z70VH7DlBOnfJudA0tbSRR2C1eFrlCBC/oBWuGfNxwH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FE+GvBjSvMBldj7i/w9bzEozpYozddoTLz1kQVhXv1apJi0Q
	kzUM2SUvqpR0OVPaq1doJ+MIbEth5C6sthZK8G26FxXaqRBIRTRJ
X-Google-Smtp-Source: AGHT+IHGHpInpaZxYNi+LuoNgksFQT5m/rKhEYd5Q7NZdSEJaCPo+OY5E4yW8rroDGwG7jsuuxL+Bw==
X-Received: by 2002:a17:902:ec84:b0:1fd:9a23:90c4 with SMTP id d9443c01a7336-2039e6be9b2mr37448325ad.65.1724444092309;
        Fri, 23 Aug 2024 13:14:52 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20393f37480sm20867725ad.187.2024.08.23.13.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:14:51 -0700 (PDT)
Date: Fri, 23 Aug 2024 13:14:49 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 4/6] sched: NUMA-aware per-memory-map concurrency
 IDs
Message-ID: <ZsjtuTsKuS1k1RK_@yury-ThinkPad>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
 <20240823185946.418340-5-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823185946.418340-5-mathieu.desnoyers@efficios.com>

On Fri, Aug 23, 2024 at 02:59:44PM -0400, Mathieu Desnoyers wrote:
> The issue addressed by this change is the non-locality of NUMA accesses
> to data structures indexed by concurrency IDs: for example, in a
> scenario where a process has two threads, and they periodically run one
> after the other on different NUMA nodes, each will be assigned mm_cid=0.
> As a consequence, they will end up accessing the same pages, and thus at
> least one of the threads will need to perform remote NUMA accesses,
> which is inefficient.
> 
> That being said, the same issue theoretically exists due to false
> sharing of cache lines by threads running on after another on different

running one after another you mean?

> cores/CPUs within a single NUMA node, but the extent of the performance
> impact is lesser than remote NUMA accesses.
> 
> Solve this by making the rseq concurrency ID (mm_cid) NUMA-aware. On
> NUMA systems, when a NUMA-aware concurrency ID is observed by user-space
> to be associated with a NUMA node, guarantee that it never changes NUMA
> node unless either a kernel-level NUMA configuration change happens, or
> scheduler migrations end up migrating tasks across NUMA nodes.
> 
> There is a tradeoff between NUMA locality and compactness of the
> concurrency ID allocation. Favor compactness over NUMA locality when
> the scheduler migrates tasks across NUMA nodes, as this does not cause
> the frequent remote NUMA accesses behavior. This is done by limiting the
> concurrency ID range to minimum between the number of threads belonging
> to the process and the number of allowed CPUs.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> ---
> Changes since v0:
> - Rename "notandnot" to "nor".

