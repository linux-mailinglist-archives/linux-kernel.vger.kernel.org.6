Return-Path: <linux-kernel+bounces-368611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BCB9A1240
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58B2B24297
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DB8213ECA;
	Wed, 16 Oct 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0GWx5zV"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BF1885BB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105545; cv=none; b=NB4UYRvX8BySl7f9zamz1YixsU7qIxlqo5YkWkeySc4B/i9ghgdGQS12NHzI6Bl9+NTvjS81wcRjpiOLFrZhVBWmnSyqQzkobgSZesplmX5A+NtSn85nfFcxe/JCIp1btk5VVkyazjN9me1Vpmg6/eqFbYOM1iArgLCJ3FI0U5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105545; c=relaxed/simple;
	bh=8AJc7nnOVnEcgZoFHh8+qQ064B2g1njgKpyNk4S+kxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo4yPszRmKxx0mWQWHEfgUAqmGOJSveQ9WhDGIoqMAJQZVXcoZQsCE43tk9xdc2XEYw8ANDHAinxynjWu7qMmiutmz9fr5MOuuuiKdA+P2ouO8KHAOFNWcjMj/XdAvUFR+KpGElUasTssFvt5etCvqLrROHaQE2mGvHjVeeQ2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0GWx5zV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4608dddaa35so51451cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729105542; x=1729710342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4fS3U7sZSvRVdJyoUhS3TF3Nb+W11QQ+SMyGO80/sw=;
        b=D0GWx5zVsXJGXrLVN3Z1PKbfrK559qbciGomzq51fZ5A11ObhY3KPZqPmeVSV+9zIs
         PdHjAf/+lSNAfegGle1b/wTRvCc1oNsFSbqim4SpsOFoyl900/8s/AtNw3dQ9RJUQXTo
         OQBYCGxDib+WQhcdE9RAvLXvuWfnirC00vcmkaaOTPj8n9K4sbSY8tMf+kQhwOGm+fet
         SnEyk3Z9Xc7CWUWgugt/AHXRV3HgD+vkaLdZbv12eCQ11IOUL0rmowMwkhLPLsdyOukT
         E5sLyS24p2mkioOfMrpFKoYKmDLr8HpLQRTdfmQ/nT/nWZaxKF4+5mdDYQe75jRvhWOM
         059Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105542; x=1729710342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4fS3U7sZSvRVdJyoUhS3TF3Nb+W11QQ+SMyGO80/sw=;
        b=UsRrtjjfz3k1IWlHuo62RIlflCFNhqIREbMM9oS70OD6UhVFN4MGnJnV9CyAa8fOCO
         VLo4jumZr8xJozpnQLCYpPsjsGnxcCLQWnSkAl/yYufoFgpdiW4icmePVI0aOkdaga2b
         I8vz31a96S4fG/74y6povlZDigsoBJHrM7rUhSbHcqQ/dL0rmuC9Q/7R4pAfhIqTfUCz
         HVeqhXuL2Z3EIIW/YZ+pkw3dEUevCX+tmH7/MU5Xnoy37KMl3JBsyG90IC7rLEMQyed4
         Lk0TKgNGFI350CWS7VtqVtyAdXbZT0E7VvqHoSvzHZJDKubvvXydja2IkZv4V1Aj7V8a
         YT2w==
X-Forwarded-Encrypted: i=1; AJvYcCUyY5gsT4LX+o3v0kbogWiPdQj1c1MnY8Cl6whcZz9Sv0yHMND3cB0mCfep6sT+BShNX2wJAM9em4hbYP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYr1n2toQkvt4ZfTnNkv0rlUIxwGUB9T1k8oNCoxKVXBgBu1S
	iZA4OnOuTQWO/REH9DkVAA8uIp78XpWhuqE29s9V6vUe+qbe1xtIc5e9qaA9VQ==
X-Google-Smtp-Source: AGHT+IE5vMu8b7tn/Vo4Stb0Ua1CGr54lW9KQb9aB0aHmUEk+fl1QrOBTLpAkMbB5h460JEQLGsq5A==
X-Received: by 2002:a05:622a:a313:b0:453:5b5a:e77c with SMTP id d75a77b69052e-4609c7856e5mr528301cf.10.1729105542146;
        Wed, 16 Oct 2024 12:05:42 -0700 (PDT)
Received: from google.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc229245fcsm20946876d6.58.2024.10.16.12.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:05:41 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:05:38 -0400
From: Brian Geffon <bgeffon@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, jack@suse.cz,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	cmllamas@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
	jing.xia@unisoc.com, xuewen.yan94@gmail.com,
	viro@zeniv.linux.org.uk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org,
	lizeb@google.com
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for
 ep_poll_callback
Message-ID: <ZxAOgj9RWm4NTl9d@google.com>
References: <20240426080548.8203-1-xuewen.yan@unisoc.com>
 <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-kurieren-intellektuell-50bd02f377e4@brauner>

On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > Now, the epoll only use wake_up() interface to wake up task.
> > However, sometimes, there are epoll users which want to use
> > the synchronous wakeup flag to hint the scheduler, such as
> > Android binder driver.
> > So add a wake_up_sync() define, and use the wake_up_sync()
> > when the sync is true in ep_poll_callback().
> > 
> > [...]
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc

This is a bug that's been present for all of time, so I think we should:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") 
Cc: stable@vger.kernel.org

I sent a patch which adds a benchmark for nonblocking pipes using epoll:
https://lore.kernel.org/lkml/20241016190009.866615-1-bgeffon@google.com/

Using this new benchmark I get the following results without this fix
and with this fix:

$ tools/perf/perf bench sched pipe -n
# Running 'sched/pipe' benchmark:
# Executed 1000000 pipe operations between two processes

     Total time: 12.194 [sec]

      12.194376 usecs/op
          82005 ops/sec


$ tools/perf/perf bench sched pipe -n
# Running 'sched/pipe' benchmark:
# Executed 1000000 pipe operations between two processes

     Total time: 9.229 [sec]

       9.229738 usecs/op
         108345 ops/sec

> 
> [1/1] epoll: Add synchronous wakeup support for ep_poll_callback
>       https://git.kernel.org/vfs/vfs/c/2ce0e17660a7

