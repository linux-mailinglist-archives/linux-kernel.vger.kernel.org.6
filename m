Return-Path: <linux-kernel+bounces-208823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0AD90299C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07702B24DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A129814E2EC;
	Mon, 10 Jun 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAJqhTGp"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DD1BF2A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049654; cv=none; b=KcXJ2BAz75/FrnNuXIFdHw6UoKaNlmgnOrFlAfJBq5uZ2h/q9/rsaVnpIvJUlBDh+KNGQU0oKJqDYAll5XTcLbwJNy6g3xYN9ihJLfLCo5TRjFBb64tvqJNlKnWW4e/UrHCSmGjusWoYEHSKiAILput/HFwJhBBFBbrsY2vdgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049654; c=relaxed/simple;
	bh=3L5WMAByMmGvCr/Yz15YD7kPi6ie/XSzaJL3Ha8vUZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDV3Q0/elxju8T7UIE0+HC2l4alcotQaSTX4YjZqjtgUGS5i0N/+FPJxp/MoW75/95x9X4lS21GdSIdFIfF22rFJkTcITznHThDNjf8cWLOol8UjIM+2PEd54EFsU8ARyVq7EC7ate857M1BnXL9mM23YRnM1difhodA++9fvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAJqhTGp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f480624d0fso2064725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718049652; x=1718654452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TQYoUe3TIjaF2QC+greyzhW4YnG4c7HmCarLa07jIU=;
        b=IAJqhTGpA1//W6Pns1MLCT7J4VidaVGUmdsofogDCcTn60U++HXBcwVHZ1pWxFDIwZ
         AoQJGCx2P7H2FQsBS3RRzDaqJP7Vsa+dEpgeAxcV7bjvcvMSZXAaFqFLKZYbWaVrUYrz
         eSePiCfqwbwb/BuXKZGQeGuoKE/Vn6G95WHM2Y3f0FOdI4QlvvdlOIOfKBbjZ47lDRd3
         yILBXAYHGtau7yoi0ZdlRN6e5OF8d2kW4++xANTot5LdkbggLRXOP20SqJiuMe2gWqo7
         Fcar28K/Z6Bj/+okx0DR9iXc0XHWRrIYUKQ6svaY3dDrs+XazUccwPAGHBoJ83MCgdYn
         NKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718049652; x=1718654452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TQYoUe3TIjaF2QC+greyzhW4YnG4c7HmCarLa07jIU=;
        b=KIA76D7PTBW6ttEbenDhi3iJdFDrmuhvCl6xWM2WqQ5YqCojrTk3rfeROgx6Fk63uN
         PjPJC9veNP+YWdYjZhwLPJbXMqQe6j1iJ3R/NkDG2nCf/532+Nt3rsAoPqnWztlXCjiM
         kRYU54i2jvkZdAOLxMFcn8XjR80b0D8kb47HPx0zopSBL213mhUd7Hq1AMxkQyNvaomB
         dK7hY+tXKoY6TqRenZLYWKzINMvdLpZY4zdMn27M3OjHM4dh2ACdIzZbi3K7/zhHIkgd
         2yKDoiMjt4IoulPt/RCfY5V5AkombFkUjBS8zrS/kT1rEXJB9IaOk/Mcj9qeWHPB0aKt
         6z9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHq1g8Fllw6TEilFjd0N8v8DRwKB14H7YP+Go9wzCAqiI15Wt9B0EyxRm3kHLp1W6WYUvLX5AbqFJ4yLQxRr9l20+UjXImVv6RLYU1
X-Gm-Message-State: AOJu0Yz9uwQuhkc76YsCqdWbapi1zaejVomrOZ1SEMWezEejlH3z+Kh3
	BN/NG2sY9j9eMBskCDg9evJ8eV3I+CypnjuDlUc9mfJ3YXSYkOHq
X-Google-Smtp-Source: AGHT+IHrmX01vlQEIUDcNtvME3OEojfuCutWL8rrHShb7Y/8Bb9eXKm62VCxxIxB9rJu1qFD/QG12A==
X-Received: by 2002:a17:902:ec8d:b0:1f6:138e:59e8 with SMTP id d9443c01a7336-1f6d02e08f8mr119898955ad.22.1718049651539;
        Mon, 10 Jun 2024 13:00:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6fac3b46fsm42426255ad.79.2024.06.10.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:00:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 10 Jun 2024 10:00:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Q: css_task_iter_advance() && dying_tasks
Message-ID: <ZmdbcSFmkmh-Cl7R@slm.duckdns.org>
References: <20240609142342.GA11165@redhat.com>
 <20240610105028.GA21586@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610105028.GA21586@redhat.com>

Hello, Oleg.

On Mon, Jun 10, 2024 at 12:50:28PM +0200, Oleg Nesterov wrote:
> I never understood the code in kernel/cgroup/ even remotely, most probably
> I missed something, but let me ask a couple of stupid questions anyway.
> 
> cgroup_exit() does
> 
> 	css_set_move_task(tsk, cset, NULL, false);
> 	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
> 
> but unless I am totally confused css_task_iter_advance() always ignores
> the "dying" sub-threads, so perhaps it should do, say,
> 
> 	css_set_move_task(tsk, cset, NULL, false);
> 	if (delay_group_leader(tsk))
> 		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
> 
> and then cgroup_release() can check list_empty(cg_list) before it takes
> css_set_lock.
> 
> No ?

Yeah, I think so. The current code hasn't broken for quite a while but it
also hasn't received much attention after the iterator updates which were
very much in the spirit of just getting it to work. I don't think you're
missing anything.

> Or, perhaps we can do even better? Can't cgroup_exit() do something like
> 
> 	// group_dead should be passed from do_exit()
> 
> 	css_set_move_task(tsk, cset, NULL, false);
> 
> 	if (thread_group_leader(tsk) && !group_dead)
> 		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
> 
> 	else if (!thread_group_leader(tsk) && group_dead) {
> 		leader = tsk->group_leader;
> 		if (!list_empty(leader->cg_list) {
> 			css_set_skip_task_iters(task_css_set(leader), leader);
> 			list_del_init(&leader->cg_list);
> 		}
> 	}
> 
> and then
> 
> 	- kill the atomic_read(&task->signal->live)) check in
> 	  css_task_iter_advance()
> 
> 	- kill the code under css_set_lock in cgroup_release()

That does sound a lot better than the current code. Care to send the patch?

Thanks.

-- 
tejun

