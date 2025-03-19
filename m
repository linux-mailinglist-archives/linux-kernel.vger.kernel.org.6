Return-Path: <linux-kernel+bounces-568559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61D5A69774
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0268A17FBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4331E5B60;
	Wed, 19 Mar 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sHu2dfGW"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C7204F65
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407611; cv=none; b=V9Wi9Kifw6EKVOmXrf/eAYhwPLbh/idxdBQqutUh83/pLlOUBD7iPkgDInuEZXKGtLdVq0dvRMTZAqv+GU3KZ2e+fOxijHh7Q1j7dGeURtAIsmK1POFcILujhsgWB7HGBGS6MxZkBpYZ1CnGImOymaXpYEb3QHvFLLmB1BV7Z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407611; c=relaxed/simple;
	bh=PSoiUXOsPCOJzGfaX6x9D+rZ847fmNdDd34M+1viIaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuQO0vMdnCVp/cZHkGc5q8Hq5wnyxu3Azh7Hwy37YYhNbuqolYT7oBw4rwA2abp747CY/5EXDxX7B1NFOOmIkhAOvIG835cTL8Nh8deX3S7OP1S206xSrGNqRN+i5vU7FoZTI/5T0tiDb399yfeiebxRrStGMrQmITDFZX6qTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sHu2dfGW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3bf231660so83335585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742407608; x=1743012408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NubMu+PJrXrK7FSH6frb72hGV0SUS0LkaEj4SuXE4k=;
        b=sHu2dfGWlOP6m6/nT4M5C/KNBJIryr7QX48KN/dOZWuOhuBSbKix+A462/LukjrhUN
         wZMpL4xfZo2r3T+qXD+OCX+SpsN//7Z0glmZxfOokqF4S8cAHdUDrb+8OUVpq5Q7eJrp
         5l8PsA3c/ore+3KUzO5oL4xBDWuSkOfnMl6/BvPQ2LSSuFnTLvZ7idkEC4kCoyybjFAq
         UjuHK6oU2Y12mPjgbOEgb0dOT0ajn5iePzaYhuXIrya+aTgMWRpiD3IMpHKa/mgp4Ob1
         sT98UO1iz19iU6cBPoTiGnwKD9WbQanar6YtQYqcQppcx99d/BtNFBfoW8+0ozxXmsIc
         QJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407608; x=1743012408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NubMu+PJrXrK7FSH6frb72hGV0SUS0LkaEj4SuXE4k=;
        b=iTAzSVdxTMumRXlw7vEYN9oXUDk1nloVzwlHQHh1fbgrrf9ZORGWEIJNzhtc5ieolK
         65Zkoiz1SC/A3X/6YvbEMGTdVHrpipaOHJO4tQmXieu1r5yKdCITsLep48QNvdl4YXyR
         0zoZyrxUk+5bKVzz07RB+tQ6j1iCymFJhrH5d91ghd2FtMA0SXcR2KNh94JpaUzs9Tgp
         Q5Dp6Hu8Rfg1libgR0uyiViCxGIp/Y3+q8XYoxPsleRstdtCYXd90aLBNTrYd4zANhBu
         AMKopfl209FpdralATDZvh9UhOi7CE1Js1RXFaxdXK81RPPbHl/FBvq5cNoJIU7aiQQx
         ZHgg==
X-Forwarded-Encrypted: i=1; AJvYcCVWChwYqGByvwEZgYArWI/ZubNaZzohYA39rkKtlAufmuaIjtMogP3OcxlEKtVped8LLjzCBlPwEd1Rm/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5ceQNYVunp0j+nVrUU1YYp0fVdPUvBODDDyZAEOsCC2PKQ3T
	jMstoF01K85JOB8WOm5EqZc5a63FQIvF1Rx2cBwL62VWFC8lAf79zuenoYO0H48=
X-Gm-Gg: ASbGnct370XVkFHRD2nyfY5HEMLn54TTHrYFGItfPQZI69tXfA8KdveCzIilZiJtcDe
	iTpKTN/E26XiZ91iJMiP5HHKftgebk5qIOlCg5ZwLryGKqrpNxXQnRYIOmgECdvzCn5r+Ixk1SL
	ceYFX0C189h7KO6AUh4xSN0KuJa7KbvPm+VIuzYkkVIFFeYuEnKhddwNW2hv516ZGoh8V2aX2eT
	DqVCjZruFbmnDQgWNtU409OrXUCZkEcU7oFF6QGgUoIHW9W7ypXGbpQOQ0EPoGJrs7mGAy155AL
	C3PGmVU80DGA/jb+24ooGve5vNCFm0HSiiECkLL2wKk=
X-Google-Smtp-Source: AGHT+IHiSAMT4qpEHY5hxrStqDgNaN2Q83H85X1DL7R0E0NeRn5pbKUwIbbATANiD9rmFjdJm9FC3A==
X-Received: by 2002:a05:620a:408a:b0:7c5:5909:18ca with SMTP id af79cd13be357-7c5a83ca625mr516096485a.26.1742407608056;
        Wed, 19 Mar 2025 11:06:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9c669sm884839585a.64.2025.03.19.11.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:06:47 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:06:43 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <20250319180643.GC1876369@cmpxchg.org>
References: <20250319071330.898763-1-gthelen@google.com>
 <Z9r70jKJLPdHyihM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9r70jKJLPdHyihM@google.com>

On Wed, Mar 19, 2025 at 05:16:02PM +0000, Yosry Ahmed wrote:
> @@ -365,9 +352,8 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>  void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>  	__acquires(&cgroup_rstat_lock)
>  {
> -	might_sleep();
> +	cgroup_rstat_flush(cgrp);
>  	__cgroup_rstat_lock(cgrp, -1);
> -	cgroup_rstat_flush_locked(cgrp);
>  }

Might as well remove cgroup_rstat_flush_hold/release entirely? There
are no external users, and the concept seems moot when the lock is
dropped per default. cgroup_base_stat_cputime_show() can open-code the
lock/unlock to stabilize the counts while reading.

(btw, why do we not have any locking around the root stats in
cgroup_base_stat_cputime_show()? There isn't anything preventing a
reader from seeing all zeroes if another reader runs the memset() on
cgrp->bstat, is there? Or double times...)

