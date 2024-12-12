Return-Path: <linux-kernel+bounces-443552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD779EF6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885A1188E8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351B222D78;
	Thu, 12 Dec 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2VAQ1OAw"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21D222D59
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023694; cv=none; b=QzhfbF3/bXAbpHLoj8KrdAWfWqaxZBFxtl1hSddYStbcT6yGC0GKqO6sFj2O1oO02JGijr/KLO214aykwlw+UEjAkLm6T50gSSfTT+nnEVipXYkJNMR36+gHBhPco3m520dPDpWCjtWZdAa86CL85IwQwVIMumGZ+20S1SvQj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023694; c=relaxed/simple;
	bh=3VhHoxhtsIYlY9delcNaANiN7hnym9vuOfGY5s9r26Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2HYhnK27ILaGU8cSwvjhbM6E0oRS7pwwbHjRIJyUZXXYCRhHPUjzLl/8mXnfKaBpg9BCIll4Sd3VLWOiZat9q5BkyB2VWKk/K0/4RuWhB2X+hhLuET9EENW4lmuD0Zbfbm+XauKpVQ5BJ10cv84IKVMmdsQP72h8Zjyv6YSqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2VAQ1OAw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467896541e1so273251cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734023692; x=1734628492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUN1FGW9s6aYaX1rahb83q8l6+aJSntI9ZnzO5TRvUw=;
        b=2VAQ1OAw1bc3MBS17U0f/2tZvXsavPeWgpMiube6+fGHeX1/hPeuttKMvmZ2Tmk5tC
         KBCVUWzIPEQFZzZVBjOtrx51baDoAUHwzLf1dSVWMQKhFftQFdLYcHm5COIz9obkdQbB
         xaaUweIYtTtO+BgVJqxu8T9JuYmEP9mAdfmlN87IQP6FI8Wtjba/MUjGJ1ddMLRcQX3J
         nNOKHbdv5AS5RQfy6nKJoyidtJQ4KvKv3n7S747jMUFgXYykpPN77B8Ky7sIsium2ZFe
         XhqO1Al/PlnOoVCnTUx2s0d5dyNGxWyCTjERDFbSxeRQvjeDXLbV+ywNbzkiylwI5lLg
         SFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023692; x=1734628492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUN1FGW9s6aYaX1rahb83q8l6+aJSntI9ZnzO5TRvUw=;
        b=t0OzPBEcQQzbzLekhKDDW1aVfVF5OkNxDk6aCPwWSO0GNFVU/3QsUfabjwTfvYqy87
         xxZCWtw1lQAc4yD4pVYq4SwLsKGkvyeQbwzWXETK2iT5uLe0BHMrJ9eQJk7zUvjfz1mC
         DhjXeagnQxcl6jkbuKMGT/WozzsRFAXrT7VEt8J2Jo3uwT8GBb1ryyJ72V/+PlqEZTl/
         A49N8WB9czdXQcSketCnr9w3CHQRZKpbmNSwBNxm0bTc513MbMjReSbXfAwMSBKGMIbZ
         hAjuGPHUxYnWf3HbsrlCN/3FGbb4MnyjCClvIFPNm05nsD7xKGI/3QABT4f8T0sz9HGR
         FZhg==
X-Forwarded-Encrypted: i=1; AJvYcCUlOJifTZleehGHI8zl2augK9eInQ8Bu6bTyXK3AqiacU52lOq4aoLNXwLAJ7Pv2v3o/VF+o138bm/clRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVqroxEg+WNUrxc3vlwi0EVfeKPYtV9yv9wEuNi+V5FTan49mF
	j6EM/PLartegIzhh68SOdrT/tNbx3JXBBQkbGRNpOuXYE5f+mBUw8kco/izzwQ==
X-Gm-Gg: ASbGncsLeAtLPuAhedup3MIXyfJ4s3So7oRfPfdiiBtRq+RfALYL6m0tDcrZ6+rkYsM
	aCnBCxDb8DaZcLtmdegiiGCGQdTBN0mbiOw36a3CFOv0Q2IcA/sx1VrWNYW8r31Yn9Eb1l+DWgv
	TZLMyamVFs3pdCJNdwT1J4OyL18XiHG8UFpdWY3cBgOmcorI20mNiuimnuhkeyvllqqoB3f6Ppk
	J8DL8Rh8hcSgNVEbroDN8SnGsl5uBgvO505r2th/eWtaFwrtZguT8IJ+XlsJQgu7EhDXlt2dJHL
	HbHW1XbXtX2e15ST3A==
X-Google-Smtp-Source: AGHT+IGgjH6GqV4jXXmphoAA+pxi/+QUQrcufFJsbeUtuxETjKPMe94758G2fCviij2ZNFYfuwddKA==
X-Received: by 2002:a05:622a:5197:b0:466:8356:8b71 with SMTP id d75a77b69052e-467a10186aemr1322081cf.19.1734023691781;
        Thu, 12 Dec 2024 09:14:51 -0800 (PST)
Received: from google.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d90299bccesm55849206d6.60.2024.12.12.09.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:14:51 -0800 (PST)
Date: Thu, 12 Dec 2024 12:14:44 -0500
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
	stable@vger.kernel.org, lizeb@google.com
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for
 ep_poll_callback
Message-ID: <Z1saBPCh_oVzbPQy@google.com>
References: <20240426080548.8203-1-xuewen.yan@unisoc.com>
 <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
 <ZxAOgj9RWm4NTl9d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxAOgj9RWm4NTl9d@google.com>

On Wed, Oct 16, 2024 at 03:05:38PM -0400, Brian Geffon wrote:
> On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> > On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > > Now, the epoll only use wake_up() interface to wake up task.
> > > However, sometimes, there are epoll users which want to use
> > > the synchronous wakeup flag to hint the scheduler, such as
> > > Android binder driver.
> > > So add a wake_up_sync() define, and use the wake_up_sync()
> > > when the sync is true in ep_poll_callback().
> > > 
> > > [...]
> > 
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.misc
> 
> This is a bug that's been present for all of time, so I think we should:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") 
> Cc: stable@vger.kernel.org

This is in as 900bbaae ("epoll: Add synchronous wakeup support for
ep_poll_callback"). How do maintainers feel about:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org

> 
> I sent a patch which adds a benchmark for nonblocking pipes using epoll:
> https://lore.kernel.org/lkml/20241016190009.866615-1-bgeffon@google.com/
> 
> Using this new benchmark I get the following results without this fix
> and with this fix:
> 
> $ tools/perf/perf bench sched pipe -n
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
> 
>      Total time: 12.194 [sec]
> 
>       12.194376 usecs/op
>           82005 ops/sec
> 
> 
> $ tools/perf/perf bench sched pipe -n
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
> 
>      Total time: 9.229 [sec]
> 
>        9.229738 usecs/op
>          108345 ops/sec
> 
> > 
> > [1/1] epoll: Add synchronous wakeup support for ep_poll_callback
> >       https://git.kernel.org/vfs/vfs/c/2ce0e17660a7

Thanks,
Brian


